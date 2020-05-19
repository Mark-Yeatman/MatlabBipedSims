function [value, isterminal, direction] = guardSSupp(t, x)
global flowdata     
    if flowdata.Flags.ignore
        CV = [];
    else
        CV = constraintValidation(t,x);
    end
    L = Spring_Length_func(x,flowdata.State.pf1);
    %value, isterminal, direction
    LeadStrike   = [x(2) - flowdata.Parameters.SLIP.L0*sin(flowdata.State.alpha), x(1) > flowdata.State.pf1(1), -1]; %only strike when mass in front of first 'foot' and moving down
    TrailRelease = [1, 0, 0];
    FullRelease  = [L - flowdata.Parameters.SLIP.L0, x(4)>0, 1]; %only release when mass moving up
    %FullRelease  = [1, 0, 0];
    Landing = [1, 0, 0];
    guard = [LeadStrike',  TrailRelease', FullRelease', Landing', CV'];
    
    value =      guard(1,:)';
    isterminal = guard(2,:)';
    direction =  guard(3,:)';
end
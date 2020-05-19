function [value, isterminal, direction] = guardDSupp(t, x)
global flowdataglobal flowdata     
    if flowdata.Flags.ignore
        CV = [];
    else
        CV = constraintValidation(t,x);
    end
    L = Spring_Length_func(x,flowdata.State.pf2);
    %value, isterminal, direction
    LeadStrike   = [1, 0, 0];
    TrailRelease = [L-flowdata.Parameters.SLIP.L0, x(4)>0, 1];
    FullRelease  = [1, 0, 0];
    Landing = [1, 0, 0];
    guard =[LeadStrike',  TrailRelease', FullRelease', Landing', CV'];
    
    value =      guard(1,:)';
    isterminal = guard(2,:)';
    direction =  guard(3,:)';
end
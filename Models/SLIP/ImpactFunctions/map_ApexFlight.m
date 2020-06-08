function xout = map_ApexFlight(xprev,xnext)
%MAP_LANDING Summary of this function goes here
%   Detailed explanation goes here
    global flowdata
    if isfield(flowdata.State,'s')
        s = PE_func(xnext)/(KE_func(xnext)+PE_func(xnext));
        flowdata.State.delta_s = s - flowdata.State.s;
        flowdata.State.s = s;
        delta_a = deg2rad(flowdata.Parameters.attack_angle.k*(flowdata.State.delta_s));
        flowdata.State.alpha = flowdata.State.alpha + delta_a;
    end
    xout = xnext;   
end


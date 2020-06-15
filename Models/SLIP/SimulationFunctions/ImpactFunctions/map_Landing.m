function xout = map_Landing(xprev,xnext)
%MAP_LANDING Summary of this function goes here
%   Detailed explanation goes here
    global flowdata
    L0 = flowdata.Parameters.SLIP.L0;
    alpha = flowdata.State.alpha;
    flowdata.State.pf2 = nan(2,1);
    flowdata.State.pf1(1) = xnext(1) + L0*cos(alpha); %keep y height at 0 because ground
    %flowdata.Parameters.State.Erefx = KEx_func(xnext);
    %flowdata.Parameters.State.Key_Landing = KEy_func(xnext);
    xout = xnext;   
end


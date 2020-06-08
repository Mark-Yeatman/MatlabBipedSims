function xout = map_FullRelease(xprev,xnext)
%MAP_LANDING Summary of this function goes here
%   Detailed explanation goes here
    global flowdata
    if ~isfield(flowdata.Parameters,'StepLength')
    %Update contact angle based on release angle
        theta = XYtoLTheta(xprev',flowdata.State.pf1);
        r = 1; %0<r<1 , 0 =  mirror release angle, 1 = constant contact angle
        flowdata.State.alpha = theta(2) + r*(flowdata.State.alpha - theta(2));
    end
    flowdata.State.pf1(1) = nan;
    flowdata.State.pf2 = nan;  
    xout = xnext;   
end


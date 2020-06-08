function xout = map_FullRelease(xprev,xnext)
%MAP_LANDING Summary of this function goes here
%   Detailed explanation goes here
    global flowdata
    if isfield(flowdata.Parameters,'alpha')
    %Update contact angle based on release angle
        Ltheta = XYtoLTheta(xprev',flowdata.State.pf1);
%         r = 1; %0<r<1 , 0 =  mirror release angle, 1 = constant contact angle
%         flowdata.State.alpha = -Ltheta(2) + r*(flowdata.State.alpha - Ltheta(2));
        k = flowdata.Parameters.alpha.k; %0<r<1 , -1 =  mirror release angle, 0 = constant contact angle
        d = flowdata.Parameters.alpha.d;
        Ltheta(2) = pi - Ltheta(2);
        if rad2deg(Ltheta(2))<55 ||  rad2deg(Ltheta(2))>70
            flowdata.State.alpha_1 = Ltheta(2);
            flowdata.State.alpha = Ltheta(2);
        else
            alpha_next = flowdata.State.alpha_0...
            + k*(flowdata.State.alpha - Ltheta(2))...
            + d*(flowdata.State.alpha - flowdata.State.alpha_1);

            flowdata.State.alpha_1 = flowdata.State.alpha;
            flowdata.State.alpha = alpha_next;
        end
    end
    flowdata.State.pf1(1) = nan;
    flowdata.State.pf2 = nan;  
    flowdata.Parameters.State.Key_Landing = KEy_func(xnext);
    xout = xnext;   
end


function z = XYtoLTheta1(x)
    %XYTOLTHETA Summary of this function goes here
    %   Detailed explanation goes here
    global flowdata
    dim = flowdata.Parameters.dim;
    x0 = flowdata.State.pf1(1);
    y0 = flowdata.State.pf1(2);
    
    q = x(1:dim/2);         %position
    qdot = x(dim/2+1:dim);  %velocity
    
    L = sqrt((q(1)-x0)^2 + (q(2)-y0)^2);
    theta = atan2(q(2)-y0,q(1)-x0);
    
    T = [cos(theta), -sin(theta)*L;...
         sin(theta),  cos(theta)*L];
    phi_dot = T \ qdot;
    z = [L;theta;phi_dot];
end


function u = BallKPBC(x)
    %BALLKPBC Kinetic Passivity-Based Control
    global flowdata

    dim = flowdata.Parameters.dim;
    
    k = flowdata.Parameters.KPBC.k;
    omega = flowdata.Parameters.KPBC.omega;  
    
    qdot = x( dim/2+1 : dim );
    E = flowdata.E_func(x);
    [Eref,Eref_part] = Eref_func(x);
    
    u = -k*omega*(E - Eref)*qdot;
    u = u + Eref_part*0;
    u = u(:);
end


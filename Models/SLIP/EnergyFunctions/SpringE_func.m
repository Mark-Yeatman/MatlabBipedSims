function E = SpringE_func(x)
    %SPRING Computes spring energy in the SLIP model
    %   Takes state vector as input and checks the phase in flowdata.State.c_phase
    global flowdata
    
    k = flowdata.Parameters.SLIP.k;
    L0 = flowdata.Parameters.SLIP.L0;
    if strcmp(flowdata.State.c_phase,"SSupp")
        pf = flowdata.State.pf1;
        L = Spring_Length_func(x,pf);
        E = 1/2*k*(L-L0)^2;
    elseif strcmp(flowdata.State.c_phase,"DSupp")
        pf1 = flowdata.State.pf1;
        L1 = Spring_Length_func(x,pf1);
        E1 = 1/2*k*(L1-L0)^2;
        
        pf2 = flowdata.State.pf2;
        L2 = Spring_Length_func(x,pf2);
        E2 = 1/2*k*(L2-L0)^2;
        
        E = E1+ E2;
        
    else
        E = 0;
    end
end

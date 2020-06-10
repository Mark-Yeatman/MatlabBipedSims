function E = SpringAxisEnergy_func(x,pf)
    %SPRINGAXISENERGY_FUNC Kinetic Energy, Gravitional, and Spring
    %Potential of SLIP model with gravity shaped to be constant along
    %spring axis.
    %    
    global flowdata
    
    m = flowdata.Parameters.Biped('m');
    k = flowdata.Parameters.SLIP.k;
    g = flowdata.Parameters.Environment.g;
    L0 = flowdata.Parameters.SLIP.L0;
    E = 0;
    
    if ~isnan(pf)
        L1 = Spring_Length_func(x,flowdata.State.pf1)
        E = 
    end
    if
        E = 1/2*m*
end


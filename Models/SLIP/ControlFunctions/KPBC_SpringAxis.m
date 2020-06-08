function [u,Farray,uArray] = KPBC_SpringAxis(x)
%KPBC_SpringAxis Energy tracking controller for the SLIP model actuated
%along the sping axis.
    %   1 dimensional, so no weighting matrix
global flowdata
    dim = flowdata.Parameters.dim;
    %omega = flowdata.Parameters.KPBC.omega;
    k = flowdata.Parameters.KPBC.k;  
    sat = flowdata.Parameters.KPBC.sat;
    
    GenE = flowdata.E_func(x');
    phase = flowdata.State.c_phase;

    if strcmp(phase,'SSupp')
        Eref = flowdata.State.Eref;
        pf = flowdata.State.pf1;       
        Ldot = Spring_Velocity_func(x,pf);
        L = Spring_Length_func(x,pf);
        
        F = -k*(GenE - Eref)*Ldot;
        F(abs(F)>sat) = sign(F(abs(F)>sat)) * sat;        
        
        u(1) = F*( x(1) - pf(1))/L;
        u(2) = F*( x(2) - pf(2))/L;
        u = u(:); %makes sure its a column vector
        uArray = [u,nan(2,1)];
        Farray = [F,nan];
    elseif strcmp(phase,'DSupp')
        Eref = flowdata.State.Eref;
        pf1 = flowdata.State.pf1;       
        Ldot1 = Spring_Velocity_func(x,pf1);
        
        L1 = Spring_Length_func(x,pf1);

        F1 = -k*(GenE - Eref)*Ldot1; %turn off front leg KPBC during DSupp
        F1(abs(F1)>sat) = sign(F1(abs(F1)>sat)) * sat;        
        
        u1(1) = F1*( x(1) - flowdata.State.pf1(1))/L1;
        u1(2) = F1*( x(2) - flowdata.State.pf1(2))/L1;
        u1 = u1(:); %makes sure its a column vector
        
        pf2 = flowdata.State.pf2;       
        Ldot2 = Spring_Velocity_func(x,pf2);
        
        L2 = Spring_Length_func(x,pf2);
    
        F2 = -k*(GenE - Eref)*Ldot2;
        F2(abs(F2)>sat) = sign(F2(abs(F2)>sat)) * sat;        
        
        u2(1) = F2*( x(1) - flowdata.State.pf2(1))/L2;
        u2(2) = F2*( x(2) - flowdata.State.pf2(2))/L2;
        u2 = u2(:); %makes sure its a column vector
        
        u = (u1+u2); %turn off during DSupp, for now
        uArray = [u1,u2];
        Farray = [F1,F2];
    else
        u = [0;0];
        Farray = [nan,nan]; 
        uArray = nan(2,2);
    end
    %u(abs(u)<1e-1) = 0;

end
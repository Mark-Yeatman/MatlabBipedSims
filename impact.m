function xnext = impact(xprev,ie)
%Handle discrete dynamics
global flowdata

    imp_name = flowdata.setNextPhaseAndConfig(ie(end));  
  
    if ~isempty(imp_name)
        %Display impact name
        myprint(strcat(imp_name,'-->'))
       
        if flowdata.Parameters.dim >4
            %for 'real' bipeds
            [xnext,F] = ImpactMap(xprev);    
            [xnext,valid_impact] = ImpactValidation(xprev,xnext,F,imp_name);
        else
            %for the SLIP and bouncing ball 
            xnext = xprev;
            [xnext,valid_impact] = ImpactValidation(xprev,xnext,imp_name);
        end            
          
    end           
end
function [xnext,F] = ImpactMap(xprev)
    %relabeling matrix
    global flowdata 
    dim = flowdata.Parameters.dim;
    params = cell2mat(flowdata.Parameters.Biped.values);
    if flowdata.Flags.step_done %if you want to swap the coordinates AND THEN apply the map, you need to change this matrix so that the x,y coordinates aren't in the nullspace
        R = [zeros(1,dim/2);
             zeros(1,dim/2);
             0,0,ones(1,dim/2-2);[zeros(dim/2-3,3),flip(-1*eye(dim/2-3),1)]];
    else
        R=eye(dim/2);
    end
    qprev = xprev(1:dim/2)';
    qdotprev = xprev(dim/2+1:dim)';

    qnextmapped =  R*qprev;  
    
    M = M_func(xprev',params);
    [A,~] = flowdata.getConstraintMtxs(xprev',params);
    a = min(size(A)); %number of constraints
    temp = [M,-A';A,zeros(a)]\[M*qdotprev;zeros(a,1)];
    
    qdotnext = temp(1:dim/2);
    F = temp(dim/2+1:end);
    
    qdotnextmapped = R*qdotnext;
    
    xnext = [qnextmapped;qdotnextmapped];
    xnext = reshape(xnext,size(xprev));
end
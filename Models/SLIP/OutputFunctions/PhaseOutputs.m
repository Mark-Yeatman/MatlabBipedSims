function outputs = PhaseOutputs(t,y,xin)
global flowdata
%global outdata

    dim = flowdata.Parameters.dim;
    outputs.phase_name = flowdata.State.c_phase;
    outputs.foot_pos_1 = flowdata.State.pf1;
    outputs.foot_pos_2 = flowdata.State.pf2;
    
    num_cntrs = length(flowdata.Controls.Internal) + length(flowdata.Controls.External);
    outputs.Force = zeros(num_cntrs , dim/2, length(t));
    outputs.GRF = zeros(2, 2, length(t)); %x/y, Leg , time

    for i = 1:length(t)
       outputs.COM_Force(i,:) = flowdata.eqnhandle(t(i),y(i,:)','u');
       outputs.KineticEnergy(i,:) = KE_func(y(i,:)');
       outputs.PotentialEnergy(i,:) = PE_func(y(i,:)');
       outputs.SpringEnergy(i,:) = SpringE_func(y(i,:)');
       
       %Control Forces
       for j = 1:length(flowdata.Controls.Internal)
            [~,outputs.Force(j,:,i), LegGRF] = flowdata.Controls.Internal{j}(y(i,:)');
            outputs.GRF(:,:,i) = outputs.GRF(:,:,i) + LegGRF;
       end 
       
       for j = length(flowdata.Controls.Internal)+1:length(flowdata.Controls.External)
            [~,outputs.Force(j,:,i), LegGRF] = flowdata.Controls.Internal{j}(y(i,:)');
            outputs.GRF(:,:,i) = outputs.GRF(:,:,i) + LegGRF;
       end 
       
       %Spring Lengths
       if contains(flowdata.State.c_phase,'Supp') 
            pf1 = flowdata.State.pf1;
            outputs.L1(i,1) = Spring_Length_func(y(i,:)',pf1);
       else
            outputs.L1(i,1) = nan;
       end
       if strcmp(flowdata.State.c_phase,'DSupp') 
            pf2 = flowdata.State.pf2;
            outputs.L2(i,1) = Spring_Length_func(y(i,:)',pf2);
       else
            outputs.L2(i,1) = nan;
       end
       
       %ODE Event Data
        [outputs.eventdata.value(:,i),...
         outputs.eventdata.isterminal(:,i),...
         outputs.eventdata.direction(:,i)] = flowdata.odeoptions.Events(t(i),y(i,:)');
    end
end
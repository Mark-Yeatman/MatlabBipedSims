function outputs = StepOutputs(t,y,phase_outputs,xin)
%global outdata
global flowdata
    outputs = [];
%     outputs.phases={};
%     
    outputs.u = [];
    outputs.KineticEnergy = [];
    outputs.PotentialEnergy = [];
    outputs.SpringEnergy = [];    
    outputs.Eref = [];
%     outputs.L1 = [];
%     outputs.L2 = [];
     outputs.Force = [];
%     outputs.GRF = [];
%     
%     outputs.steplength = norm( y(end,1)' - xin(1)' );             
%     outputs.speed = outputs.steplength /(max(t)-min(t));
     for i=1:length(phase_outputs)
%         
         data = phase_outputs{i};
%         
%         %over step data
        outputs.u= [outputs.u; data{1}.u];   
        outputs.KineticEnergy = [outputs.KineticEnergy; data{1}.KineticEnergy];   
        outputs.PotentialEnergy = [outputs.PotentialEnergy; data{1}.PotentialEnergy];   
        outputs.SpringEnergy = [outputs.SpringEnergy; data{1}.SpringEnergy]; 
        outputs.Eref = [outputs.Eref; data{1}.Eref]; 
%         outputs.L1 = [outputs.L1; data{1}.L1];  
%         outputs.L2 = [outputs.L2; data{1}.L2];  
         outputs.Force = cat(3,outputs.Force,data{1}.Force);
%         outputs.GRF = cat(3,outputs.GRF,data{1}.GRF);
%         
%         %over phase data
% %         outputs.phases{i} = struct('phase_name',data{1}.name,...
% %                                    'tstart',data{2},...
% %                                    'tend',data{3},...
% %                                    'impact_name',data{4},...
% %                                    'foot_pos_1',data{1}.foot_pos_1,...
% %                                    'foot_pos_2',data{1}.foot_pos_2);
%         outputs.phases{i} = data{1};
%         outputs.phases{i}.tstart = data{2};
%         outputs.phases{i}.tend = data{3};
%         outputs.phases{i}.impact_name = data{4};
% 
     end

end
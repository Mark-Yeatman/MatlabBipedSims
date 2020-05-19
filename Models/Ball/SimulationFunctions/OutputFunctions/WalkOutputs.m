function outputs = WalkOutputs(t,x,stepOutputs)
    global flowdata
    outputs = [];
%     %global outdata
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
     for i=1:length(stepOutputs)
         data = stepOutputs{i};
%         
%         %over walk data
         outputs.u = [outputs.u; data{1}.u];   
         outputs.KineticEnergy = [outputs.KineticEnergy; data{1}.KineticEnergy];   
         outputs.PotentialEnergy = [outputs.PotentialEnergy; data{1}.PotentialEnergy];   
         outputs.SpringEnergy = [outputs.SpringEnergy; data{1}.SpringEnergy];   
         outputs.Eref = [outputs.Eref; data{1}.Eref]; 
%         outputs.L1 = [outputs.L1; data{1}.L1];  
%         outputs.L2 = [outputs.L2; data{1}.L2];
         outputs.Force = cat(3,outputs.Force,data{1}.Force);
%         outputs.GRF = cat(3,outputs.GRF,data{1}.GRF);
%         %over step data
%         outputs.steps{i}.phases = data{1}.phases;
%         outputs.steps{i}.speed = data{1}.speed;
%         outputs.steps{i}.steplength = data{1}.steplength;
%         tlast = data{2};
%         for j = 1:length(outputs.steps{i}.phases)    %Iterate over phases
%             outputs.steps{i}.phases{j}.tstart = outputs.steps{i}.phases{j}.tstart + tlast;
%             outputs.steps{i}.phases{j}.tend = outputs.steps{i}.phases{j}.tend + tlast;
%         end
     end
   outputs.E = outputs.KineticEnergy + outputs.PotentialEnergy + outputs.SpringEnergy;
end


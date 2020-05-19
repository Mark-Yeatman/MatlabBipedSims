function outputs = StepOutputs(t,y,phase_outputs,xin)
global flowdata
    outputs = [];
    outputs.u = []; 
    outputs.W = [];
    for i=1:length(phase_outputs)
        data = phase_outputs{i};        
        %over walk data
        outputs.u = [outputs.u; data{1}.u]; 
        outputs.W = [outputs.W; data{1}.W]; 
    end
end
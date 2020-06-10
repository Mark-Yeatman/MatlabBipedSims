[I,J,L] = size(out_extra.Force);
cords = {'x','y'};
legendstrs = {};
figure('Name','Torques and Forces','NumberTitle','off')
for i = 1:I
    for j = 1:J
        F = squeeze(out_extra.Force(i,j,:));
        plot(tout,F)
        hold on
        fname  = replace(func2str(flowdata.Controls.Internal{i}),"_func"," ");
        legendstrs{end+1} = strcat(fname,cords{j});
    end
end
legend(legendstrs)
xlabel('time')
ylabel('Torque/Force')
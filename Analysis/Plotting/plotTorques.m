[I,J,L] = size(out_extra.Force);
cords = {'x','y'};
legendstrs = {};
figure('Name','Torques and Forces','NumberTitle','off')
for i = 1:I
    for j = 1:J
        F = squeeze(out_extra.Force(i,j,:));
        plot(tout,F)
        hold on
        legendstrs{end+1} = strcat(func2str(flowdata.Controls.Internal{i}),cords{j});
    end
end
legend(legendstrs)
xlabel('time')
ylabel('Torque/Force')
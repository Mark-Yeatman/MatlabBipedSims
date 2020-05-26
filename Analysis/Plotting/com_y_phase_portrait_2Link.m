params = cell2mat(flowdata.Parameters.Biped.values);
com_pos_y = zeros(size(tout));
com_vel_y = zeros(size(tout));
for i=1:length(tout)
    temp_pos = COM_pos_func(xout(i,:)', params);
    com_pos_y = temp_pos(2);
    
    temp_vel = COM_vel_func(xout(i,:)', params);
    com_vel_y = temp_vel(2);
end

figure('Name','Positions','NumberTitle','off')
plot(com_pos_y,com_vel_y)
title('CoM y phase portrait')
xlabel('\dot{y}')
ylabel('y')
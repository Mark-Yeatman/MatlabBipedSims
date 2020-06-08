% Colors
% blue = [0, 0.4470, 0.7410];
% orange = 	[0.8500, 0.3250, 0.0980];
% yellow = [0.9290, 0.6940, 0.1250];
% purple = [0.4940, 0.1840, 0.5560];
% green = [0.4660, 0.6740, 0.1880];
% red = [0.6350, 0.0780, 0.1840];
newcolors =[0, 0.4470, 0.7410;
      0.8500, 0.3250, 0.0980;
      0, 0.0, 0;
      0.4940, 0.1840, 0.5560;
      0.4660, 0.6740, 0.1880;
      0.6350, 0.0780, 0.1840];
%Trajectories

set(0,'DefaultFigureWindowStyle','docked')
dim =4;

%%Trajectories
%State positions
figure('Name','Positions','NumberTitle','off')
plot(tout,xout(:,1),tout,xout(:,2))
title('Positions')
legend("x","y",'Location', 'eastoutside')

figure('Name','Hip Trajectory','NumberTitle','off')
plot(xout(:,1),xout(:,2))
title('Hip Trajectory')
xlabel('x')
ylabel('y')

F = reshape(out_extra.Force(1,1,:),[1,length(tout)]);
L = reshape(out_extra.L1,[1,length(tout)]);
GRF = reshape(out_extra.GRF(1,1,:),[1,length(tout)]);
xrel = GRF.*L./F;

%State velocities
figure('Name','Velocities','NumberTitle','off')
plot(tout,xout(:,dim/2+1:dim))
title('velocities')
legend("x","y",'Location', 'eastoutside')


%% Phase Portraits
figure('Name','Phase Portraits','NumberTitle','off')

subplot(2,2,1)
plot(xout(:,2),xout(:,3),'o')
title('Y-Xdot Phase Portrait')
xlabel('y')
ylabel('x_dot')
axis vis3d
grid on

subplot(2,2,3)
plot(xout(:,3),xout(:,4),'o')
title('Xdot-Ydot Phase Portrait')
xlabel('x_{dot}')
ylabel('y_{dot}')
axis vis3d
grid on

subplot(2,2,4)
plot(xout(:,2),xout(:,4),'o')
title('Y-Ydot Phase Portrait')
xlabel('y')
ylabel('y_{dot}')
axis vis3d
grid on

subplot(2,2,2)
plot3(xout(:,2),xout(:,4),xout(:,3),'o')
title('Y-Ydot-Xdot Phase Portrait')
xlabel('y')
ylabel('y_{dot}')
zlabel('x_{dot}')
axis vis3d
grid on

%% Energy Plots
figure('Name',strcat('Energy'),'NumberTitle','off')
subplot(2,2,1)
plot(tout,out_extra.PotentialEnergy, tout,out_extra.KineticEnergy, tout,out_extra.SpringEnergy)
title('Energy by Component')
ylabel('Joules')
xlabel('Time')
legend('Potential','Kinetic','Spring')

subplot(2,2,2)
Etotal = out_extra.PotentialEnergy + out_extra.KineticEnergy + out_extra.SpringEnergy;
plot(tout, Etotal)
title('Total Energy')
ylabel('Joules')
xlabel('Time')

subplot(2,2,3)
scatter(tout, out_extra.L1,12,'filled') 
hold on
scatter(tout, out_extra.L2,12,'filled')
title('Spring Lengths')
ylabel('Length')
xlabel('Time')
legend('Spring 1', 'Spring 2')

subplot(2,2,4)
Eratio = (out_extra.PotentialEnergy+out_extra.SpringEnergy)/( out_extra.KineticEnergy+ out_extra.PotentialEnergy+ out_extra.SpringEnergy);
plot(tout, Eratio)
hold on 
[sharedvals,idx] = intersect(tout,out_extra.t_impacts,"stable");
plot(tout(idx),Eratio(idx),'*g')
title('Normalized Kinetic-Potential Ratio')
ylabel('Joules')
xlabel('Time')


% subplot(2,2,4)
% plot(tout, 1/2*(Etotal - flowdata.Parameters.KPBC.Eref.SSupp).^2)
% title('Storage')
% ylabel('Storage (J^2)')
% xlabel('Time')


 %% Discrete, per step data
% figure('Name',strcat('Discrete Info'),'NumberTitle','off')
% subplot(2,2,1)
% %scatter(1:step_num,NormApexH,'filled')
% title('Normalized Apex Height')
% ylabel('Normalized Apex Height')
% xlabel('Stepnum')
% 
% subplot(2,2,2)
% 
% title('Contact Angle')
% ylabel('Contact Angle')
% xlabel('Stepnum')
% 
% subplot(2,2,3)
% 
% title('LaunchFailMetric')
% ylabel('Energy Distance')
% xlabel('Stepnum')
% 
% subplot(2,2,4)
% 
% title('SpeedFailMetric')
% ylabel('Minimum forward speed')
% xlabel('Stepnum')
% 
% dark = [0, 0, 10]/255;
% light = [255, 0, 255]/255;
% step_num = length(out_extra.steps);
% NormApexH = zeros(step_num,1);
% ImpactKEx = zeros(step_num,1);
% ImpactKEy = zeros(step_num,1);
% LaunchFailMetric  = zeros(step_num,1);
% SpeedFailMetric = zeros(step_num,1);
% C_map = zeros(step_num,3);
% for i = 1:step_num
%     NormApexH(i) = out_extra.steps{i}.NormApexH;    
%     ImpactKEx(i) = 1/2*m*out_extra.istate_plus(i,3)^2;
%     ImpactKEy(i) = 1/2*m*out_extra.istate_plus(i,4)^2;
%     LaunchFailMetric(i) = out_extra.steps{i}.LaunchFailMetric;
%     SpeedFailMetric(i) = out_extra.steps{i}.ForwardSpeedFailMetric;
%     
%     C_map(i,:) = light.*( (i)/(step_num) ) + dark*( (step_num-i)/(step_num) );
%     
%     subplot(2,2,1)
%     hold on
%     scatter(i,NormApexH(i),'filled', 'MarkerFaceColor', C_map(i,:))
%     
%     subplot(2,2,2)
%     hold on
%     if isfield('alpha',out_extra.steps{i})
%         scatter(i,rad2deg(out_extra.steps{i}.alpha),'filled', 'MarkerFaceColor', C_map(i,:))
%     end
%     
%     subplot(2,2,3)
%     hold on
%     scatter(i,LaunchFailMetric(i),'filled', 'MarkerFaceColor', C_map(i,:))
%     
%     subplot(2,2,4)
%     hold on
%     scatter(i,SpeedFailMetric(i),'filled', 'MarkerFaceColor', C_map(i,:))
% end
% 
% % subplot(2,2,4)
% % plot(xout(:,1),xout(:,2),'o')
% % title('X-Y Phase Portrait')
% % xlabel('x')
% % ylabel('y')
% 
% % %Energies
% % figure('Name','Energies','NumberTitle','off')
% % plot(tout, out_extra.mech_e, tout, out_extra.e_sys)
% % title('energies')
% % legend("Mech", "Gen",'Location', 'eastoutside')
% % xlabel("time")
% % ylabel("Energy")

%% Torques and Forces
si = size(out_extra.Force);
if si(1)>1
    figure('Name','Forces','NumberTitle','off')
    subplot(2,1,1)
    F_s = squeeze(out_extra.Force(1,:,:));
    F_kpbc = squeeze(out_extra.Force(2,:,:));
    F_T = F_kpbc + F_s;
    plot(0,0)
    plot(tout,F_s,'.', tout, F_kpbc, '.', tout, F_T,'.')
    title('Forces along Spring Axis')
    xlabel("time")
    ylabel("N")
    legend("Spring_1","Spring_2", "KPBC_1", "KPBC_2", "FT_1", "FT_2");   
    grid on
else
    figure('Name','Forces','NumberTitle','off')
    subplot(2,1,1)
    F_s = squeeze(out_extra.Force(1,:,:));
    plot(tout,F_s,'.')
    title('Spring Forces')
    xlabel("time")
    ylabel("N")
    legend("Spring_1","Spring_2");
    grid on
end
subplot(2,1,2)
GRF_1 = squeeze(out_extra.GRF(:,1,:));
GRF_2 = squeeze(out_extra.GRF(:,2,:));
plot(tout, GRF_1,'.', tout, GRF_2,'.')
title('Ground Reaction Forces by Leg')
xlabel("time")
ylabel("N")
legend("F_x1","F_y1","F_x2","F_y2");
grid on

%% Spring Lengths
figure('Name','Spring Lengths','NumberTitle','off')
plot(tout,out_extra.L1,'.',tout,out_extra.L2,'.')
title('Spring Lengths')
xlabel("time (s)")
ylabel("L (m)")
legend("L_1","L_2");
grid on

set(0,'DefaultFigureWindowStyle','normal')
clear all
path(pathdef)
addpath('Experiments\Ball_Exps\')
addpath('Analysis\')
addpath('UtilityFunctions\')
addpath(genpath('Models\Ball\'))

global flowdata

flowdata = flowData();
flowdata.E_func = @TotalE_func;
%ode equation handle and tolerenaces
flowdata.eqnhandle = @dynamics;
flowdata.odeoptions = odeset('RelTol', 1e-6, 'AbsTol', 1e-6, 'MaxStep',1e-3);

%Flags
flowdata.Flags.silent = false;
flowdata.Flags.warnings = false;

%simulation parameters
flowdata.Parameters.dim = 4; %state variable dimension

%Environment Parameters
e = 1;
h = 0.75;
flowdata.Parameters.Environment.e = e;
flowdata.Parameters.Environment.h = h;

%Biped Parameters
m = 1.5;
g = 9.81;
flowdata.Parameters.Biped = containers.Map({'m','g'},{m,g});

%Control Parameters
flowdata.Controls.Internal = {@MassSpringControl};

k = 2;
L0 = 8;
flowdata.Parameters.Spring.k = k;
flowdata.Parameters.Spring.L0 = L0;

%Discrete Mappings 
flowdata.setPhases({'Oscillate'})
flowdata.setConfigs({})
e1 = struct('name','Impact','nextphase','Oscillate','nextconfig','');
flowdata.Phases.Oscillate.events = {e1};
flowdata.End_Step.event_name = 'Impact';

%Set initial phase and contact conditions
flowdata.State.c_phase = 'Oscillate';
flowdata.State.c_configs = {};
flowdata.setImpacts();

%ODE event initialization
flowdata.tspan = 10; %seconds
v = 0:0.5:5;
results = {1,length(v)};
E_labels = {1,length(v)};
cmap = color_interpolate([1,0,0],[0,0,1],length(v));
f = figure;
for i = 1:length(v)
    
    %Simulate
    xi = [0,h,0,-v(i)];
    E = flowdata.E_func(xi');
    [fstate, xout, tout, out_extra] = walk(xi,1);
    results{i} = {E,fstate,xout,tout,out_extra};
    E_labels{i} = num2str(E);
    
    %Plot
    plot3(xout(:,2),xout(:,4),E*ones(size(xout(:,2))),'Color',cmap(i,:),'LineWidth',1);
    %points = [xout(:,2)';xout(:,4)';E*ones(size(xout(:,2)))'];
    %fnplt(cscvn(points),'b',3)
    hold on
    title("Phase Portraits")
    xlabel('y')
    ylabel('ydot')
    zlabel('E')
    %axis equal
end
limits = axis;
axis(limits);
LEG = legend(E_labels);
% [X,Y,Z] = meshgrid(h,limits(3):0.5:limits(4),limits(5):0.5:limits(6));
% surf(X,Y,Z,'C
x0 = h;
x1 = h;
y0 = limits(3);
y1 = limits(4);
z0 = limits(5);
z1 = limits(6);
p = patch([h,h,h,h], [y0,y0,y1,y1], [z0, z1, z1, z0], 'black');
alpha(p,0.2);
title(LEG,'Energy (Joules)')
grid on
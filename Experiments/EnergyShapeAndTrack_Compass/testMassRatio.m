% path(pathdef)
% addpath('Experiments')
% addpath('Experiments\EnergyShapeAndTrack_Compass\')
% addpath('Analysis\')
% addpath('UtilityFunctions\')
% addpath(genpath('Models\2LinkCompassGait\'))
% 
% initializeCompassGaitLimitCycle
% 
% %Add Control Function
% flowdata.Controls.Internal = {@Shaping};
% 
% %Shaping Control Parameters
% flowdata.Parameters.Shape.Mh = 9;
% flowdata.Parameters.Shape.Ms = 5;
% flowdata.Parameters.Shape.a = 0.5;
% flowdata.Parameters.Shape.b = 0.5;
% flowdata.Parameters.Shape.g = 9.81;
% flowdata.Parameters.Shape.asvector = [9,5,0.5,0.5];
% 
% %flowdata.State = mass_ratio_sweep_results{i}.State;
% flowdata.Flags.do_validation = false;
% [fstate, xout, tout, out_extra] = walk(xi,3);

%Demonstrates changing walking speeds in the 2 Link compass gait biped through shaping the
%MASS RATIO between the shank and hip masses. Uses an adaptive energy
%tracking control to increase the basin of attraction of the gaits.
clear all
path(pathdef)
addpath('Experiments\EnergyShapeAndTrack_Compass\')
addpath('Analysis\')
addpath('UtilityFunctions\')
addpath(genpath('Models\2LinkCompassGait\'))
global flowdata

flowdata = flowData;
flowdata.E_func = @TotalE_func;
%ode equation handle and tolerenaces
flowdata.eqnhandle = @dynamics;
flowdata.odeoptions = odeset('RelTol', 1e-10, 'AbsTol', 1e-10);

%Flags
flowdata.Flags.silent = false;
flowdata.Flags.ignore = true;
flowdata.Flags.do_validation = false;

%Simulation parameters
flowdata.Parameters.Environment.slope = -deg2rad(3.7);   %ground slope
g = 9.81;
flowdata.Parameters.Environment.g = g;
flowdata.Parameters.dim = 8;        %state variable dimension

%Discrete Mappings and Constraints
flowdata.setPhases({'SSupp'})
flowdata.setConfigs({})
impactlist =  {'FootStrike'};
e1 = struct('name','FootStrike','nextphase','SSupp','nextconfig','');
e2 = struct('name','FallForward','nextphase','Failure','nextconfig','');
e3 = struct('name','FallBackward','nextphase','Failure','nextconfig','');
flowdata.Phases.SSupp.events = {e1,e2,e3};
flowdata.End_Step.event_name = 'FootStrike';

%Set initial phase, contact conditions, and state
flowdata.State.c_phase = 'SSupp';
flowdata.State.c_configs = {};
flowdata.setImpacts();

load('C:\Users\Mark\Box Sync\Research\StandardizedSimCode\Experiments\EnergyShapeAndTrack_Compass\Data\grid_results.mat')

%Physical Parameter Change
ratio = grid_results.physical_mass_ratio.ratio{end-1};
StateStart = grid_results.physical_mass_ratio.State{end-1}.extra;
xi = grid_results.physical_mass_ratio.State{end-1}.xi;

Ms = 5;
Mh = Ms * ratio;
Isz = 0;
a = 0.5;
b = 0.5;
params_keys = {'Mh', 'Ms', 'Isz', 'a', 'b', 'g'};
params_values = {Mh, Ms, Isz, a, b, g};
flowdata.Parameters.Biped = containers.Map(params_keys,params_values);

flowdata.State = StateStart;
disp("Physical parameter test")
[fstate_a, xout_a, tout_a, out_extra_a] = walk(xi,25);
disp(strcat("Expected stable speed: ", num2str(grid_results.physical_mass_ratio.speed{end-1})))
disp(strcat("Sim stable speed: ", num2str(out_extra_a.steps{end}.speed)))

%Shaping Parameter Change
flowdata.Controls.Internal = {@Shaping,@KPBC};

%KPBC Parameters
flowdata.Parameters.KPBC.k = 1;
flowdata.Parameters.KPBC.omega = diag([0,0,1,1]);
flowdata.Parameters.KPBC.sat = inf;

%Eref update law Parameters
flowdata.Parameters.Eref_Update.k = 0.5;

%Shaping Parameters
ratio = grid_results.shape_mass_ratio.ratio{end-1};
StateStart = grid_results.shape_mass_ratio.State{end-1}.extra;
xi = grid_results.shape_mass_ratio.State{end-1}.xi;

Ms = 5;
Mh = Ms * ratio;
Isz = 0;
a = 0.5;
b = 0.5;
params_keys = {'Mh', 'Ms', 'Isz', 'a', 'b', 'g'};
params_values = {Mh, Ms, Isz, a, b, g};
flowdata.Parameters.Shaping = containers.Map(params_keys,params_values);

%Biped Parameters
Mh = 10;
Ms = 5;
Isz = 0;
a = 0.5;
b = 0.5;
params_keys = {'Mh', 'Ms', 'Isz', 'a', 'b', 'g'};
params_values = {Mh, Ms, Isz, a, b, g};
flowdata.Parameters.Biped = containers.Map(params_keys,params_values);

flowdata.State = StateStart;
shape_params = cell2mat(flowdata.Parameters.Shaping.values);
flowdata.State.Eref = flowdata.E_func(xi',shape_params);
disp("Shape parameter test")
[fstate, xout, tout, out_extra] = walk(xi,25);
disp(strcat("Expected stable speed: ", num2str(grid_results.shape_mass_ratio.speed{end-1})))
disp(strcat("Sim stable speed: ", num2str(out_extra.steps{end}.speed)))
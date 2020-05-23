clear all
path(pathdef)
addpath('Experiments\ModelTests\')
addpath('Analysis\')
addpath('UtilityFunctions\')
addpath(genpath('Models\Ball\'))

global flowdata

flowdata = flowData();
flowdata.E_func = @TotalE_func;
%ode equation handle and tolerenaces
flowdata.eqnhandle = @dynamics;
flowdata.odeoptions = odeset('RelTol', 1e-6, 'AbsTol', 1e-6, 'MaxStep',1e-1);

%Flags
flowdata.Flags.silent = false;
flowdata.Flags.warnings = false;

%simulation parameters
flowdata.Parameters.dim = 4; %state variable dimension

%Environment Parameters
flowdata.Parameters.Environment.e = 1;
flowdata.Parameters.Environment.h = 0.75;

%Biped Parameters
m = 1.5;
g = 9.81;
flowdata.Parameters.Biped = containers.Map({'m','g'},{m,g});

%Control and Parameters
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
xi = [0,0.25,0,2];
[fstate, xout, tout, out_extra] = walk(xi,2);

basicplotsBall
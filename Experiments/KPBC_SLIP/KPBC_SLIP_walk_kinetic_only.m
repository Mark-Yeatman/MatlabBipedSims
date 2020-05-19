%Uses the kinetic passivity based control, only tracking the kinetic energy
%of the mass
path(pathdef)
addpath('Experiments')
addpath('Analysis\')
addpath('UtilityFunctions\')
addpath(genpath('Models\SLIP\'))

load limit_cycle_data.mat xi

global flowdata

flowdata = flowData;
flowdata.E_func = @KE_func;
%ode equation handle and tolerenaces
flowdata.eqnhandle = @dynamics;
flowdata.odeoptions = odeset('RelTol', 1e-6, 'AbsTol', 1e-6, 'MaxStep',1e-3);

%Flags
flowdata.Flags.silent = false;
flowdata.Flags.ignore = true;

%simulation parameters
flowdata.Parameters.Environment.slope = deg2rad(0);    %ground slope in rads
flowdata.Parameters.dim = 4;                           %state variable dimension
 
%Biped Parameters
flowdata.Parameters.Biped.m = 70; %in kg

%Control and Parameters
flowdata.Controls.Internal = {@SpringF_func, @KPBC_SpringAxis};

flowdata.Parameters.SLIP.k = 12250;
flowdata.Parameters.SLIP.L0 = 0.94;

flowdata.Parameters.KPBC.k = 1; 
flowdata.Parameters.KPBC.sat = inf;

%flowdata.Parameters.KPBC.omega = diag([0,0,0,1,1,0.001,1,1]);

%Discrete Mappings 
flowdata.setPhases({'SSupp','DSupp','Flight'})
flowdata.setConfigs({})
impactlist =  {'LeadStrike','TrailRelease','FullRelease','Landing'};
n_phaselist = {'DSupp','SSupp','Flight','SSupp'};
n_configlist = {'keep','keep','keep','keep'};
flowdata.setImpacts(impactlist,n_phaselist,n_configlist); %note that all the constraint matrices are zero
flowdata.End_Step.event_name = 'LeadStrike';

%Set initial phase and contact conditions
flowdata.State.c_phase = 'SSupp';
flowdata.State.c_configs = {};
flowdata.State.alpha = deg2rad(70); %spring impact angle 
flowdata.State.pf1 = [0.1251;0];
flowdata.State.pf2 = [nan;nan];
flowdata.Parameters.KPBC.Eref.SSupp = 50.9482+1; %mean kinetic energy of the passive limit cycle
flowdata.Parameters.KPBC.Eref.DSupp = 50.9482+1;

%ODE event initialization
flowdata.odeoptions.Events = flowdata.Phases.(flowdata.State.c_phase).eventf;

[fstate, xout, tout, out_extra] = walk(xi,100);
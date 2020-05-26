%Uses the kinetic passivity based control, only tracking the kinetic energy
%of the mass
path(pathdef)
addpath('Experiments')
addpath('Analysis\')
addpath('UtilityFunctions\')
addpath(genpath('Models\SLIP\'))

load run_kinetic_only_limit_cycle_data.mat xi fdState

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

flowdata.Parameters.SLIP.k = 8200;
flowdata.Parameters.SLIP.L0 = 1;

flowdata.Parameters.KPBC.k = 2; 
flowdata.Parameters.KPBC.sat = inf;

%flowdata.Parameters.KPBC.omega = diag([0,0,0,1,1,0.001,1,1]);

%Discrete Mappings 
flowdata.setPhases({'SSupp','DSupp','Flight'})
flowdata.setConfigs({})
impactlist =  {'LeadStrike','TrailRelease','FullRelease','Landing'};
n_phaselist = {'DSupp','SSupp','Flight','SSupp'};
n_configlist = {'keep','keep','keep','keep'};
flowdata.setImpacts(impactlist,n_phaselist,n_configlist); %note that all the constraint matrices are zero
flowdata.End_Step.event_name = 'Landing';

%Set initial phase and contact conditions
flowdata.State = fdState;
flowdata.Parameters.KPBC.Eref.SSupp = 1.239662854511278e+03 - 200; %mean kinetic energy of the passive limit cycle

%ODE event initialization
flowdata.odeoptions.Events = flowdata.Phases.(flowdata.State.c_phase).eventf;

[fstate, xout, tout, out_extra] = walk(xi,3);
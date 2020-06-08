clear all
path(pathdef)
addpath('Experiments\KPBC_SLIP\')
addpath(genpath('Analysis\'))
addpath('UtilityFunctions\')
addpath(genpath('Models\SLIP\'))

load flight_limit_cycle_data.mat xi_flight
global flowdata

flowdata = flowData;
flowdata.E_func = @TotalE_func;
%ode equation handle and tolerenaces
flowdata.eqnhandle = @dynamics;
flowdata.odeoptions = odeset('RelTol', 1e-8, 'AbsTol', 1e-8);

%Flags
flowdata.Flags.silent = false;
flowdata.Flags.ignore = true;
flowdata.Flags.warnings = false;
flowdata.Flags.rigid = false;

%simulation parameters
flowdata.Parameters.Environment.slope = deg2rad(0);    %ground slope in rads
flowdata.Parameters.dim = 4;                           %state variable dimension
 
%Biped Parameters
flowdata.Parameters.Biped = containers.Map({'m'},{70});%in kg

%Control and Parameters
flowdata.Controls.Internal = {@SpringF_func};
flowdata.Parameters.SLIP.k = 10000;
flowdata.Parameters.SLIP.L0 = 0.94;

%Discrete Mappings 
flowdata.setPhases({'SSupp','DSupp','Flight'})
flowdata.setConfigs({})
impactlist =  {'LeadStrike','TrailRelease','FullRelease','Landing'};
e1 = struct('name','LeadStrike','nextphase','DSupp','nextconfig','');
e2 = struct('name','TrailRelease','nextphase','SSupp','nextconfig','');
e3 = struct('name','FullRelease','nextphase','Flight','nextconfig','');
e4 = struct('name','Landing','nextphase','SSupp','nextconfig','');
e5 = struct('name','ApexSSupp','nextphase','SSupp','nextconfig','');
e6 = struct('name','Floor','nextphase','Failure','nextconfig','');
flowdata.Phases.SSupp.events = {e1,e3,e5,e6};
flowdata.Phases.DSupp.events = {e2,e6};
flowdata.Phases.Flight.events = {e4,e6};

flowdata.End_Step.event_name = 'ApexSSupp';
flowdata.End_Step.map = @flowdata.identityImpact;

%Set initial phase and contact conditions
flowdata.State.c_phase = 'Flight';
flowdata.State.c_configs = {};
flowdata.setImpacts()

flowdata.State.alpha = deg2rad(55); %spring impact angle 

x_apex = [0,flowdata.Parameters.SLIP.L0*1.05,3,0];
flowdata.State.pf1 = [nan;0];
flowdata.State.pf2 = [nan;nan];

[fstate, xout, tout, out_extra] = walk(xi_flight,10);
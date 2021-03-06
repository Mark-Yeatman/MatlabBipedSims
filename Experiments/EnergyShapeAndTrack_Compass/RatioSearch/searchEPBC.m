%Add Control Function
flowdata.Controls.Internal = {@Shaping, @KPBC};
%flowdata.Controls.Internal = {};
%Set parameters
flowdata.Parameters.Shape.Mh = 10;
flowdata.Parameters.Shape.Ms = 5;
flowdata.Parameters.Shape.a = 0.5;
flowdata.Parameters.Shape.b = 0.5 ;
flowdata.Parameters.Shape.g = 9.81;
flowdata.Parameters.Shape.asvector = [10, 5, 0.5, 0.5]; 

flowdata.Parameters.KPBC.k = 100;
flowdata.Parameters.KPBC.omega = diag([0,0,1,0.001]);
flowdata.Parameters.KPBC.sat = inf;
flowdata.Parameters.KPBC.Eref.SSupp = flowdata.E_func(fstate',[flowdata.Parameters.Shape.asvector, flowdata.Parameters.Environment.g]);

temp = find((abs([grid_results.physical_length_ratio.ratio{:}]-ratio)<1e-6),1);
flowdata.Parameters.Eref_Update.vref = grid_results.physical_length_ratio.speed{temp};
flowdata.Parameters.Eref_Update.vref = ratio;
flowdata.Parameters.Eref_Update.weight = 2.5;
%flowdata.Parameters.Eref_Update.flag = "ball";


flowdata.State.Eref = flowdata.Parameters.KPBC.Eref.SSupp;
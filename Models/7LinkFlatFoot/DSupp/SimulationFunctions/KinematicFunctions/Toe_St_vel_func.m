function velToest = Toe_St_vel_func(in1)
%TOE_ST_VEL_FUNC
%    VELTOEST = TOE_ST_VEL_FUNC(IN1)

%    This function was generated by the Symbolic Math Toolbox version 8.3.
%    23-Sep-2019 18:19:28

%7 Link Flat Foot with Double Support file. Only needs state as inputs, parameters are already substituted in
x3 = in1(3,:);
x9 = in1(9,:);
x10 = in1(10,:);
x11 = in1(11,:);
t2 = cos(x3);
t3 = sin(x3);
t4 = t2.*x11;
t5 = t3.*x11;
t6 = -t5;
velToest = reshape([t6,t4,0.0,0.0,-t4,t6,0.0,0.0,0.0,0.0,0.0,0.0,t5./5.0+x9,t4.*(-1.0./5.0)+x10,0.0,0.0],[4,4]);

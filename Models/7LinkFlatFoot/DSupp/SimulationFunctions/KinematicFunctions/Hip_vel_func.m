function velH = Hip_vel_func(in1)
%HIP_VEL_FUNC
%    VELH = HIP_VEL_FUNC(IN1)

%    This function was generated by the Symbolic Math Toolbox version 8.3.
%    23-Sep-2019 18:19:28

%7 Link Flat Foot with Double Support file. Only needs state as inputs, parameters are already substituted in
x3 = in1(3,:);
x4 = in1(4,:);
x5 = in1(5,:);
x9 = in1(9,:);
x10 = in1(10,:);
x11 = in1(11,:);
x12 = in1(12,:);
x13 = in1(13,:);
t2 = x3+x4;
t3 = x11+x12;
t4 = t2+x5;
t5 = t3+x13;
t6 = cos(t4);
t7 = sin(t4);
t8 = t5.*t6;
t9 = t5.*t7;
t10 = -t9;
velH = reshape([t10,t8,0.0,0.0,-t8,t10,0.0,0.0,0.0,0.0,0.0,0.0,t8.*(-1.07e+2./2.5e+2)+x9-t3.*cos(t2).*(1.07e+2./2.5e+2)-x11.*cos(x3).*(7.0./1.0e+2),t9.*(-1.07e+2./2.5e+2)+x10-t3.*sin(t2).*(1.07e+2./2.5e+2)-x11.*sin(x3).*(7.0./1.0e+2),0.0,0.0],[4,4]);
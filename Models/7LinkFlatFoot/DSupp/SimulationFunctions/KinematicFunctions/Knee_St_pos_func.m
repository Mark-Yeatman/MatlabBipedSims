function posKst = Knee_St_pos_func(in1)
%KNEE_ST_POS_FUNC
%    POSKST = KNEE_ST_POS_FUNC(IN1)

%    This function was generated by the Symbolic Math Toolbox version 8.3.
%    23-Sep-2019 18:19:26

%7 Link Flat Foot with Double Support file. Only needs state as inputs, parameters are already substituted in
x1 = in1(1,:);
x2 = in1(2,:);
x3 = in1(3,:);
x4 = in1(4,:);
x5 = in1(5,:);
t2 = x3+x4;
t3 = t2+x5;
t4 = cos(t3);
t5 = sin(t3);
posKst = reshape([t4,t5,0.0,0.0,-t5,t4,0.0,0.0,0.0,0.0,1.0,0.0,x1-sin(t2).*(1.07e+2./2.5e+2)-sin(x3).*(7.0./1.0e+2),x2+cos(t2).*(1.07e+2./2.5e+2)+cos(x3).*(7.0./1.0e+2),0.0,1.0],[4,4]);

function posFsw = Foot_Sw_pos_func(in1,in2)
%FOOT_SW_POS_FUNC
%    POSFSW = FOOT_SW_POS_FUNC(IN1,IN2)

%    This function was generated by the Symbolic Math Toolbox version 8.5.
%    18-Apr-2020 15:46:16

%
ls = in2(:,7);
lt = in2(:,8);
x1 = in1(1,:);
x2 = in1(2,:);
x3 = in1(3,:);
x4 = in1(4,:);
x5 = in1(5,:);
x6 = in1(6,:);
t2 = x3+x4;
t3 = t2+x5;
t4 = t3+x6;
t5 = cos(t4);
t6 = sin(t4);
posFsw = reshape([t5,t6,0.0,0.0,-t6,t5,0.0,0.0,0.0,0.0,1.0,0.0,x1+ls.*t6-lt.*sin(t2)+lt.*sin(t3)-ls.*sin(x3),x2-ls.*t5+lt.*cos(t2)-lt.*cos(t3)+ls.*cos(x3),0.0,1.0],[4,4]);

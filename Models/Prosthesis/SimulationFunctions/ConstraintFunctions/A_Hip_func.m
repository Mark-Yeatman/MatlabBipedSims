function Ahip = A_Hip_func(in1)
%A_HIP_FUNC
%    AHIP = A_HIP_FUNC(IN1,IN2)

%    This function was generated by the Symbolic Math Toolbox version 8.3.
%    14-Oct-2019 12:19:59

%Prosthesis file. Needs state and parameters as inputs
global flowdata
in2 =  flowdata.Parameters.Biped.asvector;
la = in2(:,10);
ls = in2(:,9);
lt = in2(:,8);
x3 = in1(3,:);
x4 = in1(4,:);
x5 = in1(5,:);
t2 = x3+x4;
t3 = cos(t2);
t4 = sin(t2);
t5 = t2+x5;
t6 = cos(t5);
t7 = sin(t5);
t8 = ls.*t3;
t9 = ls.*t4;
t10 = lt.*t7;
t11 = lt.*t6;
t12 = -t8;
t13 = -t9;
t14 = -t10;
t15 = -t11;
Ahip = reshape([1.0,0.0,0.0,1.0,t12+t15-la.*cos(x3),t13+t14-la.*sin(x3),t12+t15,t13+t14,t15,t14],[2,5]);

function out1 = Adot_VHC_func(in1,in2)
%ADOT_VHC_FUNC
%    OUT1 = ADOT_VHC_FUNC(IN1,IN2)

%    This function was generated by the Symbolic Math Toolbox version 8.5.
%    29-May-2020 10:16:53

a = in2(:,4);
b = in2(:,5);
x3 = in1(3,:);
x4 = in1(4,:);
x7 = in1(7,:);
x8 = in1(8,:);
t2 = a+b;
t3 = x3.*2.0;
t4 = x4.*2.0;
t7 = x4./2.0;
t5 = t2.^2;
t6 = t3+x4;
t9 = sin(t7);
t10 = t3+t4;
t8 = cos(t6);
t11 = cos(t10);
t12 = t11.*6.0;
out1 = [0.0,0.0,t5.*t9.*(x8.*sin(t3+x4.*(3.0./2.0))+t8.*t9.*x7.*2.0).*-3.0,(t5.*(x8.*(t8.*-3.0+t12+cos(x4).*5.0)-x7.*(t8.*6.0-t12)))./4.0];

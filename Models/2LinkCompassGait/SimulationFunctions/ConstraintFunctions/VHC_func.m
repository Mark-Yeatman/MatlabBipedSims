function out1 = VHC_func(in1,in2)
%VHC_FUNC
%    OUT1 = VHC_FUNC(IN1,IN2)

%    This function was generated by the Symbolic Math Toolbox version 8.5.
%    29-May-2020 10:16:53

a = in2(:,4);
b = in2(:,5);
x3 = in1(3,:);
x4 = in1(4,:);
t2 = a+b;
t3 = x3+x4;
t4 = t2.^2;
out1 = -sqrt(2.0).*sqrt(t2)+t4.*(cos(t3)-cos(x3)).^2.*4.0+t4.*(sin(t3)-sin(x3)).^2;

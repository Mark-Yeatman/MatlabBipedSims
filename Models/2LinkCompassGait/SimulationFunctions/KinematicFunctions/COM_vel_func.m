function dCoM = COM_vel_func(in1,in2)
%COM_VEL_FUNC
%    DCOM = COM_VEL_FUNC(IN1,IN2)

%    This function was generated by the Symbolic Math Toolbox version 8.5.
%    29-May-2020 10:16:55

Mh = in2(:,2);
Ms = in2(:,3);
a = in2(:,4);
b = in2(:,5);
x3 = in1(3,:);
x4 = in1(4,:);
x5 = in1(5,:);
x6 = in1(6,:);
x7 = in1(7,:);
x8 = in1(8,:);
t2 = a+b;
t3 = x3+x4;
t4 = x7+x8;
t5 = Ms.*2.0;
t6 = b.*2.0;
t7 = Mh+t5;
t8 = b+t2;
t9 = Mh.*t2;
t10 = Ms.*t8;
t11 = 1.0./t7;
t12 = t9+t10;
dCoM = [t11.*(t7.*x5-t12.*x7.*cos(x3)+Ms.*a.*t4.*cos(t3)),t11.*(t7.*x6-t12.*x7.*sin(x3)+Ms.*a.*t4.*sin(t3)),0.0];

function Adsupp = A_DSupp_func(in1,in2)
%A_DSUPP_FUNC
%    ADSUPP = A_DSUPP_FUNC(IN1,IN2)

%    This function was generated by the Symbolic Math Toolbox version 8.5.
%    18-Apr-2020 15:46:08

%
ls = in2(:,7);
lt = in2(:,8);
x3 = in1(3,:);
x4 = in1(4,:);
x5 = in1(5,:);
x6 = in1(6,:);
t2 = x3+x4;
t3 = cos(t2);
t4 = sin(t2);
t5 = t2+x5;
t6 = cos(t5);
t7 = sin(t5);
t8 = t5+x6;
t9 = lt.*t3;
t10 = lt.*t4;
t11 = cos(t8);
t12 = sin(t8);
t13 = lt.*t7;
t14 = lt.*t6;
t17 = -t9;
t18 = -t10;
t15 = ls.*t11;
t16 = ls.*t12;
Adsupp = reshape([1.0,0.0,1.0,0.0,0.0,1.0,0.0,1.0,0.0,0.0,t14+t15+t17-ls.*cos(x3),t13+t16+t18-ls.*sin(x3),0.0,0.0,t14+t15+t17,t13+t16+t18,0.0,0.0,t14+t15,t13+t16,0.0,0.0,t15,t16],[4,6]);

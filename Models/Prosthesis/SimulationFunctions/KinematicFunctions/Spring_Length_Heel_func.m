function LFlatHeel = Spring_Length_Heel_func(in1)
%SPRING_LENGTH_HEEL_FUNC
%    LFLATHEEL = SPRING_LENGTH_HEEL_FUNC(IN1,IN2)

%    This function was generated by the Symbolic Math Toolbox version 8.3.
%    14-Oct-2019 12:19:55

%Prosthesis file. Needs state and parameters as inputs
global flowdata
in2 =  flowdata.Parameters.Biped.asvector;
la = in2(:,10);
lf = in2(:,11);
ls = in2(:,9);
lt = in2(:,8);
x4 = in1(4,:);
x5 = in1(5,:);
t2 = x4+x5;
LFlatHeel = sqrt(la.^2+lf.^2+ls.^2+lt.^2+la.*lt.*cos(t2).*2.0+la.*ls.*cos(x4).*2.0+ls.*lt.*cos(x5).*2.0+lf.*lt.*sin(t2).*2.0+lf.*ls.*sin(x4).*2.0);

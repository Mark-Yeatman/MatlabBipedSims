function [value, isterminal, direction] =  guard_ApexSSupp(t, x)
%GUARD_FULLRELEASE Summary of this function goes here
%   Detailed explanation goes here
    global flowdata
    L = Spring_Length_func(x,flowdata.State.pf1);
    value = L - flowdata.Parameters.SLIP.L0;
    isterminal =  x(4)>0; %only release when mass moving up
    direction = 1;
end


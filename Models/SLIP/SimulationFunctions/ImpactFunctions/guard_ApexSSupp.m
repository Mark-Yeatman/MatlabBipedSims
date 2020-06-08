function [value, isterminal, direction] = guard_ApexSupp(t, x)
%GUARD_TRAILRELEASE Summary of this function goes here
%   Detailed explanation goes here
    global flowdata
    value = x(1)-flowdata.State.pf1(1);
    isterminal =  strcmp('SSupp',flowdata.State.c_phase); %only release when mass moving up
    direction = 1;
end


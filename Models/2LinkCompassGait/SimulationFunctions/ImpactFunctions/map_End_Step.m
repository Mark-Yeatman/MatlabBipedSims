function xout = map_FootStrike(xprev,xnext)
    %MAP_FOOTSTRIKE Summary of this function goes here
    %   Detailed explanation goes here
    if flowdata.Flags.step_done
        nextpose = Foot_Sw_pos_func(xprev',params);            
        xnext(1:2) = nextpose(1:2,4)';
    end
    xout = xnext;
end


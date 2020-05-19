function M = M_func(x);
    global flowdata
    m = flowdata.Parameters.Biped.m;
    M=[m,0;0,m];
end

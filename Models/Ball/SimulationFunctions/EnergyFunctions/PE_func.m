function pe = PE_func(x)
    global flowdata
    m = flowdata.Parameters.Biped.m;  
    g = flowdata.Parameters.Environment.g;  
    pe=g.*m.*x(2);
end

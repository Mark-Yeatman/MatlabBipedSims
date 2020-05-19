function G = G_func(x,params)
    global flowdata
    g = flowdata.Parameters.Environment.g;
    m = flowdata.Parameters.Biped('m');
    G=[0;g.*m];
end
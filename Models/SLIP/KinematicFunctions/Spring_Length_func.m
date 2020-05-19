function l = Spring_Length_func(x,pF)
    xf = pF(1);
    yf = pF(2);
    l=(abs((-1).*xf+x(1)).^2+abs((-1).*yf+x(2)).^2).^(1/2);
end

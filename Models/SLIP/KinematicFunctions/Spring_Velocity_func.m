function ldot = Spring_Velocity_func(x,pF)
    xf = pF(1);
    yf = pF(2);
    ldot=((xf+(-1).*x(1)).^2+(yf+(-1).*x(2)).^2).^(-1/2).*(((-1).*xf+x(1)).*x(3)+((-1).*yf+x(2)).*x(4));
end


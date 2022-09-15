function I = integ1(N)
a = (2*pi)/N;
t = 0:a:2*pi;
y = (sin(5*t)).^2;
I = sum(y.*a);
return
end
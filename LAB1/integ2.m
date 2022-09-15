function J = integ2(N)
a = 1/N;
t = 0:a:1;
y = exp(t);
J = sum(y.*a);
return
end
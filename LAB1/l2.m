a = zeros(1,100);
b = zeros(1,100);
for N = 1:100
   
a(N) = integ1(N);
b(N) = integ2(N);

end
subplot(2,1,1)
plot(a)
ylabel('I(N)')
xlabel('N')
title('Simulate Integral of sin^2(5t)')
subplot(2,1,2)
plot(b)
ylabel('J(N)')
xlabel('N')
title('Simulate Integral of e^t')
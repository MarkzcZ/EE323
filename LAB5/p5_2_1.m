x1 = hamming(20);

figure(1)
stem(0:19,abs(DFTsum(x1))),xlabel('n'),ylabel('abs(DFTsum(x1))'),title('magnitude plot for DFT(x1)')

x1 = hamming(20);
[X,w] = DTFTsamples(x1);
figure(2)
stem(w,abs(X)),xlabel('w'),ylabel('DTFT(x1)'),title('magnitude plot for DTFT(x1)')
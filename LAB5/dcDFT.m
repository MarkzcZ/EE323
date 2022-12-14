function X = dcDFT(x)
N = length(x);  
x0 = x(1:2:N);  % Even part of x[n]
x1 = x(2:2:N);  % Odd part of x[n]
X0 = DFTsum(x0); X0 =[X0 X0];
X1 = DFTsum(x1); X1 = [X1 X1];
X = X0+ exp(-1j*2*pi/N*[0:1:N-1]).*X1;% equation5.13, using twiddle factior.
end
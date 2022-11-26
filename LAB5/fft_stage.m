function X = fft_stage(x)
N = length(x);  % Determine the length of the input signal.
if N == 2 % If N=2, then the function should just compute the 2-pt DFT as in (5.14), and then return.
    X(1) = x(1)+x(2);
    X(2) = x(1)-x(2);
else %  If N>2, then the function should perform the FFT steps described previously (i.e. decimate, compute (N/2)-point DFTs, re-combine), calling fft_stage to compute the (N/2)-point DFTs
    r = 0:1:N/2-1;
    xeven = x(1:2:N);
    xodd = x(2:2:N);
    X0 = fft_stage(xeven);
    X1 = fft_stage(xodd);
    temp = X1.*exp(-j*2*pi/N*r);
    X = [X0+temp X0-temp]; 
end
end
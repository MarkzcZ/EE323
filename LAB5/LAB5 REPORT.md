# LAB5 REPORT

SID:12012505

Name: 占陈郅

###  Part 1: Introduction.

------

- The last laboratory covers the Discrete Fourier Transform (DFT). This laboratory will continue the  discussion of the DFT and will introduce the FFT.
- The main content contains in this lab:
  - Build DTFT Function
  - Learn  *fftshift*
  - Zero Padding
  - Divide-and-Conquer DFT

### Part 2: Result & Analysis.

------

#### 5.2 Continuation of DFT Analysis

**5.2.1 Shifting the Frequency Range**

- Part 1 - Illustrate a representation for the DFT of a Hamming window x of length N = 20.
  
  Code:
  
  ```matlab
  x1 = hamming(20);
  
  figure(1)
  stem(0:19,abs(DFTsum(x1))),xlabel('n'),ylabel('abs(DFTsum(x1))'),title('magnitude plot for DFT(x1)')
  ```
  
  ![111](C:\Users\M__zzZ\Documents\MATLAB\DSP LAB\EE323\LAB5\111.png)
  
  <center> fig.1 Magnitude plot for DFT(x1) with circling the low frequency components</center>
  
  Analysis:
  
  The circle above shows the low frequency components.
  
  
  
- Part 2 - Write a function to compute samples of the DTFT and their corresponding frequencies in the range -π to π.

  Code:

  ```matlab
  x1 = hamming(20);
  [X,w] = DTFTsamples(x1);
  figure(2)
  stem(w,abs(X)),xlabel('w'),ylabel('DTFT(x1)'),title('magnitude plot for DTFT(x1)')
  ```
  
  ```matlab
  function [X,w] = DTFTsamples(x)
  N = length(x);
  k = 0:N-1;
  w = 2*pi*k/N;
  w(w>=pi)=w(w>=pi)-2*pi;% shift the range from [0,2*pi] to [-pi,pi]
  w = fftshift(w);
  X = fftshift(DFTsum(x));
  display(w);display(X);
  end
  ```
  
  ![12](C:\Users\M__zzZ\Documents\MATLAB\DSP LAB\EE323\LAB5\12.png)
  
  <center> fig.2 Magnitude plot for DTFT(x1)</center>
  
  Analysis:
  
  In the DTFTsample function, w = 2*pi*k/N is used to transform x in time domain to frequency domain, then shift the w to -π ~ π, and use *fftshift* to get the magnitude of DTFT of x.



**5.2.2 Zero Padding**

- In the following, you will compute the DTFT samples of 𝑥(𝑛) using both 𝑁 = 50 and 𝑁 = 200 point FT's. Notice that when 𝑁 = 200, most of the samples of 𝑥[𝑛] will be zeros because 𝑥[𝑛] = 0 for 𝑛 ≥ 50.This technique is known as “zero padding”, and may be used to produce a finer  sampling of the DTFT. For 𝑁 = 50 and 𝑁 = 200, do the following: 

  1. Compute the vector x containing the values 𝑥[0], … , 𝑥[𝑁 − 1]. 
  2. Compute the samples of 𝑋 [𝑘] using your function DTFTsamples. 
  3. Plot the magnitude of the DTFT samples versus frequency in rad/sample.

  Code:

  ```matlab
  x1 = sin(0.1*pi*[0:49]);
  n = zeros(1,0);%change value of N
  x = horzcat(x1,n);%zero padding
  [X,w] = DTFTsamples(x);
  stem(w,abs(X)),xlabel('w'),ylabel('DTFT(x)'),title('magnitude plot for DTFT(x)')
  ```

  ![21](C:\Users\M__zzZ\Documents\MATLAB\DSP LAB\EE323\LAB5\21.png)

  <center> fig.3 DTFT(x1) without zero padding</center>

  ![22](C:\Users\M__zzZ\Documents\MATLAB\DSP LAB\EE323\LAB5\22.png)

  <center> fig.4 DTFT(x) with zero padding</center>

  Analysis:

  The second plot(N=200) looks more like true DTFT of x.

  Why would that happen? To answer in short:

  1. Zero padding do not change the frequency component of DTFT.
  2. DFT sampling DTFT in one period.

  Whatever N=50 or N=200, the results of DTFT are still periodic, but in the N=200 case, there are more 150 times sampling in one period of DTFT than N=50 case.

  In conclusion, zero padding is the same as frequency-domain interpolation.

  

#### 5.3 The Fast Fourier Transform Algorithm

**5.3.1 Implementation of Divide-and-Conquer DFT**

- Write a Matlab function dcDFT

  Code:

  ```matlab
  function X = dcDFT(x)
  N = length(x);  
  x0 = x(1:2:N);  % Even part of x[n]
  x1 = x(2:2:N);  % Odd part of x[n]
  X0 = DFTsum(x0); 
  X0 =[X0 X0];%odd and even part are both used twice.
  X1 = DFTsum(x1); 
  X1 = [X1 X1];
  %if k = [0:N-1], with the equation 5.12, the result can be expressed in one equation.
  k = [0:1:N-1];
  X = X0+ exp(-1j*2*pi/N*k).*X1;% X[k] = X0[k] + W*X1[k] equation5.13&5.12, using twiddle factior.
  end
  ```

- Test

  Code:

  ```matlab
  clear;
  n = 0:9; 
  x1 = (n==0);% case 1
  x2 = ones(1,10);% case 2
  x3 = exp(1j*2*pi*n/10);% case 3
  N = 0:9;
  sgtitle('dcDFT and DFTsum')
  subplot(321),stem(n,abs(dcDFT(x1))),xlabel('N'),ylabel('dcDFT(x1)'),title('dcDFT(x1)');
  subplot(322),stem(n,abs(DFTsum(x1))),xlabel('N'),ylabel('DFTsum(x1)'),title('DFTsum(x1)');
  subplot(323),stem(n,abs(dcDFT(x2))),xlabel('N'),ylabel('dcDFT(x2)'),title('dcDFT(x2)');
  subplot(324),stem(n,abs(DFTsum(x2))),xlabel('N'),ylabel('DFTsum(x2)'),title('DFTsum(x2)');
  subplot(325),stem(n,abs(dcDFT(x3))),xlabel('N'),ylabel('dcDFT(x3)'),title('dcDFT(x3)');
  subplot(326),stem(n,abs(DFTsum(x3))),xlabel('N'),ylabel('DFTsum(x3)'),title('DFTsum(x3)');
  ```

  ![31](C:\Users\M__zzZ\Documents\MATLAB\DSP LAB\EE323\LAB5\31.png)

  <center> fig.5 dcDFT and DFTSum</center>

  Analysis:

  In the dcDFT.m, if k = [0:N/2-1], as shown in equation 5.13, the results need two equations to express, but if k = [0:N-1], with the equation 5.12 we know -W can change to +W by k = k+N/2 in phase, 0 to N/2-1 and N/2 to N-1 can be **both** expressed by X[k] = X~0~[k] + W~N~^k^X1[k]. The result can be expressed in one equation as shown in the code.

  The figure above shows dcDFT is as good as DFTsum.
  
  The number of multiplies that are required in this approach to computing an N point DFT is 
  $$
  N + 2 × (\frac{N}2)^2=N+\frac{N^2}2
  $$



###### **5.3.2 Recursive Divide and Conquer**

- Write three Matlab functions to compute the 2-, 4-, and 8-point FFT's using the syntax

  1. X=FFT2(x)

     ```matlab
     function X = FFT2(x)
     X(1) = x(1)+x(2);
     X(2) = x(1)-x(2);
     end
     ```

  2. X=FFT4(x)

     ```matlab
     function X = FFT4(x)
      r = 0:1;
      X0 = FFT2([x(1) x(3)]);  
      X1 = FFT2([x(2) x(4)]); 
      temp = X1.*exp(-j*2*pi/4*r);
      X = [X0+temp X0-temp];
     end
     ```

  3. X=FFT8(x)

     ```matlab
     function X = FFT8(x)
      r = 0:3;
      X0 = FFT4([x(1) x(3) x(5) x(7)]);
      X1 = FFT4([x(2) x(4) x(6) x(8)]); 
      temp = X1.*exp(-j*2*pi/8*r);
      X = [X0+temp X0-temp];
     end
     ```

     

- Test your function FFT8 by using it to compute the DFT's of the following signals. Compare  these results to the previous ones.

  ![image-20221126162529654](C:\Users\M__zzZ\AppData\Roaming\Typora\typora-user-images\image-20221126162529654.png)

  <center> fig.6 FFT8 compare to fft</center>

  ![32](C:\Users\M__zzZ\Documents\MATLAB\DSP LAB\EE323\LAB5\32.png)

  <center> fig.7 FFT8 compare to DFTsum</center>

  Code:

  ```matlab
  clear;
  x = ones(1,8);
  X = FFT8(x);
  display(X)
  Xn = fft(x)
  
  clear
  n=0:1:7;
  x1 = (n==0);
  x2 = ones(1,8);
  x3 = exp(j*2*pi*n/8);
  N = 0:7;
  sgtitle('FFT8 and DFTsum 占陈郅12012505')
  subplot(321),stem(n,abs(FFT8(x1))),xlabel('N'),ylabel('FFT8(x1)'),title('FFT8(x1)');
  subplot(322),stem(n,abs(DFTsum(x1))),xlabel('N'),ylabel('DFTsum(x1)'),title('DFTsum(x1)');
  subplot(323),stem(n,abs(FFT8(x2))),xlabel('N'),ylabel('FFT8(x2)'),title('FFT8(x2)');
  subplot(324),stem(n,abs(DFTsum(x2))),xlabel('N'),ylabel('DFTsum(x2)'),title('DFTsum(x2)');
  subplot(325),stem(n,abs(FFT8(x3))),xlabel('N'),ylabel('FFT8(x3)'),title('FFT8(x3)');
  subplot(326),stem(n,abs(DFTsum(x3))),xlabel('N'),ylabel('DFTsum(x3)'),title('DFTsum(x3)');
  ```

- Calculate the total number of multiplies **by twiddle factors**.

  When N is the power of 2, N = 2^v^, it requires  v = log~2~N stages of computation. The number of  complex multiplications and additions required is  therefore Nv = Nlog~2~N.

  For 8-point FFT.
  $$
  \frac{8}2×log_28=12
  $$
  For N = 2^p^ point FFT.
  $$
  \frac{N}2×log_2N = p2^{p-1}
  $$
  

- Write a recursive function X=fft_stage(x) that performs one stage of the FFT algorithm for a  power-of-2 length signal.

  Code:

  ```matlab
  function X = fft_stage(x)
  N = length(x);  % Determine the length of the input signal.
  if N == 2
      X(1) = x(1)+x(2);
      X(2) = x(1)-x(2);
  else
      r = 0:1:N/2-1;
      xeven = x(1:2:N);
      xodd = x(2:2:N);
      X0 = fft_stage(xeven);
      X1 = fft_stage(xodd);% the same method as dcDFT
      temp = X1.*exp(-j*2*pi/N*r);
      X = [X0+temp X0-temp]; 
  end
  end
  ```

  

- Test fft_stage on the three 8-pt signals given above, and verify that it returns the same results as  FFT8.

  Code:

  ```matlab
  clear
  n=0:1:7;
  x1 = (n==0);
  x2 = ones(1,8);
  x3 = exp(j*2*pi*n/8);
  N = 0:7;
  sgtitle('FFT8 and fft\_stage 占陈郅12012505')
  subplot(321),stem(n,abs(FFT8(x1))),xlabel('N'),ylabel('FFT8(x1)'),title('FFT8(x1)');
  subplot(322),stem(n,abs(fft_stage(x1))),xlabel('N'),ylabel('fft\_stage(x1)'),title('fft\_stage(x1)');
  subplot(323),stem(n,abs(FFT8(x2))),xlabel('N'),ylabel('FFT8(x2)'),title('FFT8(x2)');
  subplot(324),stem(n,abs(fft_stage(x2))),xlabel('N'),ylabel('fft\_stage(x2)'),title('fft\_stage(x2)');
  subplot(325),stem(n,abs(FFT8(x3))),xlabel('N'),ylabel('FFT8(x3)'),title('FFT8(x3)');
  subplot(326),stem(n,abs(fft_stage(x3))),xlabel('N'),ylabel('fft\_stage(x3)'),title('fft\_stage(x3)');
  ```

  ![33](C:\Users\M__zzZ\Documents\MATLAB\DSP LAB\EE323\LAB5\33.png)

  <center> fig.8 FFT8 compare to fft_stage</center>

  fft_stage returns the same results as FFT8.

### **Part 3: Summary & Experience.**

------

- This lab mainly talks about Fast Fourier Transform, with its nature, its qualities and variants.
- The Fast Fourier Transform FFT is a more efficient algorithm for computing the discrete Fourier transform with O (N log_2 N) computational complexity, which is more scalable than the original DFT with O (N^2) computational complexity.
- A common FFT implementation requires limiting the number of input data points to the form N=2^m (multiplication of 2). If the number of data you have is not several powers of 2, you can make up the next multiplication of 2 by adding zeros (zero padding) to the end. The added zeros do not affect the frequency domain spectrum, but only increase the apparent data density, i.e., the extra frequency domain points are actually linear interpolations of the valid data.

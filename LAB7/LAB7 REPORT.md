# LAB7 REPORT

占陈郅 #12012505



#### Contents

------

[TOC]

### Introduction & Background

This laboratory covers some basic examples of FIR and IIR filters, and then introduces the concepts  of FIR filter design. Systematic methods of designing both FIR and IIR filters are followed.

In digital signal processing applications, it is often necessary to change the relative amplitudes of  frequency components or remove undesired frequencies of a signal. This process is called filtering.  Digital filters are used in a variety of applications. Digital filters are used in audio systems in the  previous laboratories that allow the listener to adjust the bass (low-frequency energy) and the treble  (high frequency energy) of audio signals. Digital filter design requires the use of both frequency domain and time domain techniques.  This is because filter design specifications are often given in the frequency domain, but filters are  usually implemented in the time domain with a difference equation. Typically, frequency domain  analysis is done using the z-transform and the discrete-time Fourier Transform (DTFT).

- LTI causal digital filter(𝑁 − 1 zeros and 𝑀 − 1 poles)

​	$y[n]=\sum_{i=0}^{N-1} b_{i} x[n-i]-\sum_{k=1}^{M-1} a_{k} y[n-k]$

- Impulse response, and when a~k~=0

  $h[n]=\sum_{i=0}^{N-1} b_{i} \delta[n-i]-\sum_{k=1}^{M-1} a_{k} h[n-k]$

  $h[n]=\sum_{i=0}^{N-1} b_{i} \delta[n-i]$

- Z-transform and DTFT and delay in z-transform

  $X[z]=\sum_{n=-\infin}^{\infin} x[n] z^{-n}$

  $X[e^{jw}]=\sum_{n=-\infin}^{\infin} x[n] e^{-jwn}$

  $
  x[n-K] \stackrel{z}{\longleftrightarrow}\sum_{n=-\infty}^{\infty} x[n-K] z^{-n} =\sum_{m=-\infty}^{\infty} x[m] z^{-(m+K)} \\
  =z^{-K} \sum_{m=-\infty}^{\infty} x[m] z^{-m}=z^{-K} X(z)
  $

- Rewrite the first equation by z-transform

  $Y(z)=\sum_{i=0}^{N-1} b_{i} z^{-i} X(z)-\sum_{k=1}^{M-1} a_{k} z^{-k} Y(z) \\
  Y(z)\left(1+\sum_{k=1}^{M-1} a_{k} z^{-k}\right)=X(z) \sum_{i=0}^{N-1} b_{i} z^{-i} 
  H(z) \triangleq \frac{Y(z)}{X(z)}=\frac{\sum_{i=0}^{N-1} b_{i} z^{-i}}{1+\sum_{k=1}^{M-1} a_{k} z^{-k}}
  $
  
- Evaluating 𝐻(𝑧) on the unit circle

  $H\left(e^{j \omega}\right)=\frac{\sum_{i=0}^{N-1} b_{i} e^{-j \omega i}}{1+\sum_{k=1}^{M-1} a_{k} e^{-j \omega k}}$





### Design of a Simple FIR Filter

- The transfer function for this filter is given by

$H_{f}(z)=\left(1-z_{1} z^{-1}\right)\left(1-z_{2} z^{-1}\right)=\left(1-e^{j \theta} z^{-1}\right)\left(1-e^{-j \theta} z^{-1}\right)=1-2 \cos \theta z^{-1}+z^{-2}$

- Then the difference equation can be infer

$y[n]=x[n]-2cos\theta x[n-1]+x[n-2]$

- The system diagram:

<img src="C:\Users\M__zzZ\AppData\Roaming\Typora\typora-user-images\image-20221224145202724.png" alt="image-20221224145202724" style="zoom:80%;" />

<center> Fig.1 System diagram of the FIR filter</center>

- The plot of the magnitude response for the three values of $\theta$

<img src="C:\Users\M__zzZ\Documents\MATLAB\DSP LAB\EE323\LAB7\p7_3a.png" alt="p7_3a" style="zoom:80%;" />

<center> Fig.2 The plot of the magnitude response for the three values of θ</center>

```matlab
w = -pi:0.01:pi;
z = exp(j*w);
H1 = 1-2*cos(pi/6)*z.^(-1)+z.^(-2)
H2 = 1-2*cos(pi/3)*z.^(-1)+z.^(-2)
H3 = 1-2*cos(pi/2)*z.^(-1)+z.^(-2)
subplot(131)
plot(w,abs(H1))
title('\theta = \pi /6')
subplot(132)
plot(w,abs(H2))
title('\theta = \pi /3')
subplot(133)
plot(w,abs(H3))
title('\theta = \pi /2')
```

From the figures above, it can be concluded that when $\omega$ = 0 , the abs of Hf(e^jw^) tends to equal 0.

- The time domain plot of 101 samples

<img src="C:\Users\M__zzZ\Documents\MATLAB\DSP LAB\EE323\LAB7\p731.png" alt="p731" style="zoom:80%;" />

<center> Fig.3 The time domain plot of 101 sampless</center>

- The plot of the magnitude of the DTFT for 1001 samples

  <img src="C:\Users\M__zzZ\Documents\MATLAB\DSP LAB\EE323\LAB7\p732.png" alt="p732" style="zoom:80%;" />

  <center> Fig.4 The plot of the magnitude of the DTFT for 1001 samples</center>

- FIRfilter.m

  ```matlab
  function y = FIRfilter(x)
  [X,w]=DTFT(x,0);
  [Xmax,Imax]=max(abs(X));%by hint
  h = [1 -2*cos(w(Imax)) 1];
  y = conv(x,h);
  end
  ```

- Filtered output

  <img src="C:\Users\M__zzZ\Documents\MATLAB\DSP LAB\EE323\LAB7\1.png" alt="1" style="zoom:80%;" />
  
  <center> Fig.5 Filtered output</center>

From the filtered output, it allows waves in specific frequency bands to pass through while blocking other frequency bands, the waveform in time domain changes a lot, so which is a **bandpass filter**.



### Design of a Simple IIR Filter

- Transfer function for a second order IIR filter with complex-conjugate poles

  $H_{i}(z)=\frac{1-r}{\left(1-r e^{j \theta} z^{-1}\right)\left(1-r e^{-j \theta} z^{-1}\right)}=\frac{1-r}{1-2 r \cos (\theta) z^{-1}+r^{2} z^{-2}}$

- Then the difference equation can be infer

  $y[n]-2rcos\theta y[n-1]+r^2y[n-2]=(1-r)x[n]$

- The system diagram:

  <img src="C:\Users\M__zzZ\AppData\Roaming\Typora\typora-user-images\image-20221224154346044.png" alt="image-20221224154346044" style="zoom:80%;" />

  <center> Fig.6 System diagram of the IIR filter</center>

- The plot of the magnitude of the frequency response for each value of r

  <img src="C:\Users\M__zzZ\Documents\MATLAB\DSP LAB\EE323\LAB7\p7_4a.png" alt="p7_4a" style="zoom:80%;" />

  <center> Fig.7 The plot of the magnitude of the frequency response for each value of r</center>

  ```matlab
  w = -pi:0.01:pi;
  z = exp(j*w);
  r1 = 0.99;r2 = 0.9; r3 = 0.7;
  H1 = (1-r1)./(1-2*r1*cos(pi/3).*z.^(-1)+(r1^2)*z.^(-2))
  H2 = (1-r2)./(1-2*r2*cos(pi/3).*z.^(-1)+(r2^2)*z.^(-2))
  H3 = (1-r3)./(1-2*r3*cos(pi/3).*z.^(-1)+(r3^2)*z.^(-2))
  subplot(131)
  plot(w,abs(H1))
  title('r1 = 0.99')
  subplot(132)
  plot(w,abs(H2))
  title('r2 = 0.9')
  subplot(133)
  plot(w,abs(H3))
  title('r3 = 0.7')
  ```

  As r decreases, the two spikes in the amplitude response image become flatter, the trough in the middle increases, and the maximum value increases. As r approaches 1 ideally , two impulses are considered ideal.

- The original pcm signal output of 

  The time domain plot of the signal for 101 points

  The plot of the magnitude of the DTFT computed from 1001 samples of the signal

  The plot of the magnitude of the DTFT for 𝜔 in the range [𝜃 − 0.02, 𝜃 + 0.02]

  <img src="C:\Users\M__zzZ\Documents\MATLAB\DSP LAB\EE323\LAB7\p741.png" alt="p741" style="zoom:80%;" />

  <center> Fig.8 The original pcm signal output</center>

- The filtered pcm signal output

  <img src="C:\Users\M__zzZ\Documents\MATLAB\DSP LAB\EE323\LAB7\p742.png" alt="p742" style="zoom:80%;" />

  <center> Fig.9 The filtered pcm signal output</center>

- IIRfilter.m

  ```matlab
  function y = IIRfilter(x)
  theta = (3146/8000)*2*pi;
  r = 0.995;
  N = length(x);
  y = zeros(1,N);
  y(1) = x(1);
  y(2) = x(2)+2*r*cos(theta);
  for i = 3:N
  y(i) = x(i)+2*r*cos(theta).*y(i-1)-(r^2).*y(i-2);
  end
  end
  ```

  After passing through the filter, the noise in the frequency domain of this sound is much reduced. In addition, the filtered sound is much clearer.

  I think that in this case, the value of r cannot be small, but r takes 0.9999999 and 0.995 to compare it with almost no difference, nor is it effective.
  
  In addition, if r infinitely close to 1, the magnitude response of DTFT filtered output will be more than 15000 at peek, which is too large for the filter, and in ideal situation, the desired signal around $\omega$=$\theta$ will be 0 if r = 1. So such a value for r might be ill-advised.



### Filter Design Using Truncation

- The plots of the magnitude response for the two filters (not in decibels). On each of the  plots, mark the passband, the transition band and the stopband

  <img src="C:\Users\M__zzZ\Documents\MATLAB\DSP LAB\EE323\LAB7\p6761.png" alt="p6761" style="zoom:80%;" />

  <center> Fig.10 The plots of the magnitude response for the two filters</center>

- The plots of the magnitude response in decibels for the two filters

  <img src="C:\Users\M__zzZ\Documents\MATLAB\DSP LAB\EE323\LAB7\p762.png" alt="p762" style="zoom:80%;" />

  <center> Fig.11 The plots of the magnitude response in decibels for the two filters</center>

  In this case, when N gets larger, the performance of the filter becomes better because more sample points appear.
  
  The sound result passing this filter sounds smoother and better.



### Summary

Through various small experiments in this experiment, I gained a certain level of understanding of the design of IIR and FIR filters, and also gained valuable programming experience and the ability to analyze problems. When drawing the system flowchart, I was still not familiar with Simulink, the layout was not beautiful enough, unreasonable, and not practical enough.
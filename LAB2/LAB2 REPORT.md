# LAB2 REPORT

SID:12012505

Name: 占陈郅

###  Part 1: Introduction.

------

- In this lab, we mainly discuss the Discrete-Time Systems. And a definition to a discrete-time system is that anything that takes a discrete-time signal as input and generates a discrete- time signal as output.
- In order to understand discrete-time systems, it is important to first understand their classification into categories of linear/nonlinear, time-invariant/ time-varying, causal/noncausal, memoryless/with-memory, and stable/unstable.
- The main content contains in this lab:
  - Background Exercises
  - Example Discrete-Time Systems
  - Difference Equations
  - Audio Filtering
  - Inverse Systems
  - System Tests
  - Stock Market Example



### Part 2: Result & Analysis.

#### 2.2 Background Exercises

**2.2.1 Example Discrete-time Systems**

- For the DT approximation of differentiator: 
  $$
  y(t)=\frac {d}{dt}x(t)
  $$
  We have difference equation： 
  $$
  y[n]=x[n]−x[n−1]
  $$

- For the DT approximation of integrator: 
  $$
  y(t)=∫_∞^tx(τ)dτ
  $$
  We have difference equation:
  $$
  y[n]−y[n−1]=x[n]
  $$
  which could be also wirtten as  
  $$
  y[n]=x[n]+y[n−1]
  $$

- Block diagram for these two discrete-time system (Figure 2.1): 

  ![Fig2.1](C:\Users\M__zzZ\Documents\MATLAB\DSP LAB\LAB2\Fig2.1.png)

  

**2.2.2 Stock Market Example**

- Let n be the nth day, $y[n]$ be avgvalue, and $x[n]$ be value.

  Then we have below three difference equations: $$ \begin{aligned} System 1: y[n]&=\frac{1}{3}(x[n]+x[n-1]+x[n-2])\ \\System 2: y[n]&=0.8y[n-1]+0.2x[n]\ \\System 3: y[n]&=y[n-1]+\frac{1}{3}(x[n]-x[n-3]) \end{aligned} $$

- System diagrams for these three equations (Figure 2.2):

![Fig2.2](C:\Users\M__zzZ\Documents\MATLAB\DSP LAB\LAB2\Fig2.2.png)



- Impulse response for these four systems:

$$ \begin{aligned} System 1: h[n]&=\frac{1}{3}(δ[n]+δ[n-1]+δ[n-2])\ \\System 2: h[n]&=0.8h[n-1]+0.2δ[n]\ \\System 3: h[n]&=h[n-1]+\frac{1}{3}(δ[n]-δ[n-3]) \end{aligned} $$

- Methods (2.3) and methods (2.5) are known as moving average becasue the absolute value of weights applied on the time sequence is equal, which will make the average value line become smoother and much more flat.

#### 2.3 Example Discrete-Time Systems

- Codes for two functions:

  ```matlab
  function y=differentiator(x)
  % y[n]=x[n]-x[n-1]
  x=[0 x];
  y=zeros(1,length(x)-1);
  for n=1:length(x)-1
      y(n)=x(n+1)-x(n);
  end
  end
  ```

  ```matlab
  function y=integrator(x)
  % y[n]=x[n]+y[n-1]
  y=zeros(1,length(x)+1);
  for n=1:length(x)
  y(n+1)=x(n)+y(n);
  end
  y=y(2:length(x)+1);
  end
  ```

- Result

![Fig2.3](C:\Users\M__zzZ\Documents\MATLAB\DSP LAB\LAB2\Fig2.3.png)

- Analysis:

  For these four cases, they all satisfy the BIBO stability.

#### 2.4 Differential Systems

- Codes for two functions:

```matlab
function y=S1(x)
% y[n]=x[n]-x[n-1]
N=length(x);
x=[0 x];
y=zeros(1,N);
for n=1:N
    y(n)=x(n+1)-x(n);
end
end
```

```matlab
function y=S2(x)
% y[n]=(1/2)y[n-1]+x[n]
N=length(x);
y=zeros(1,N+1);
for n=1:length(x)
y(n+1)=x(n)+(1/2)*y(n);
end
y=y(2:N+1);
end
```

- Block diagram for each case

  Block diagrams for S1 and S2:

  ![Fig2.4](C:\Users\M__zzZ\Documents\MATLAB\DSP LAB\LAB2\Fig2.4.png)

   Block diagrams for S1(S2) and S2(S1): ![Fig2.5](C:\Users\M__zzZ\Documents\MATLAB\DSP LAB\LAB2\Fig2.5.png)

   Block diagram for S1+S2: ![Fig2.6](C:\Users\M__zzZ\Documents\MATLAB\DSP LAB\LAB2\Fig2.6.png)

- Impulse responses for these five cases: 

  ![Fig2.7](C:\Users\M__zzZ\Documents\MATLAB\DSP LAB\LAB2\Fig2.7.png)

  Figure 2.7 Impulse responses of five systems

  - Oberservations:
    - Impulse response of S1+S2 equals the sum of impulse responses of S1 and S2;(Parrallel connection results in addition.)
    - Impulse response of S1(S2) is same with impulse response of S2(S1), and the impulse response of this two system is S1⊗S2 ;(Series connection results in convolution.)



#### 2.5 Aduio Filtering

- Code for this section:

  ```matlab
  clear;
  [s,fs]=audioread('music.au');
  s=s';
  s1=S1(s);
  s2=S2(s);
  sound(s1,fs);
  next=input('press any key to the next song');
  sound(s2,fs);
  ```

- Analysis:

  - Compared with the original song, the song filtered by System S1 is much more smoother.
  - Compared with the original song, the song filtered by System S2 is louder and much more tighter.

![1](C:\Users\Mark Z\Documents\MATLAB\1.jpg)

FUNCTION CODE:

```matlab
function I = integ1(N)
a = (2*pi)/N;
t = 0:a:2*pi;
y = (sin(5*t)).^2;
I = sum(y.*a);
return
end

function J = integ2(N)
a = 1/N;
t = 0:a:1;
y = exp(t);
J = sum(y.*a);
return
end
```

Analysis:

As can be seen from the images, both functions make the output more accurate as the independent variable N increases, approximating the actual value. The reason why I(5) and I(10) are almost zero is because the amplitudes sampled at both input 5 and 10 are close to zero and the errors are large due to the small number of samples.

### 1.4

![](C:\Users\Mark Z\Documents\MATLAB\2.jpg)

Analysis:

- According to Matlab code `[signal,fs]=audioread('speech.au');`, we could load the speech signal and read its sampling frequency *fs*.
- Use below Matlab command to sound the loaded signal:`sound(signal,fs);`

### 1.5

![3](C:\Users\Mark Z\Documents\MATLAB\3.jpg)

Fig.1 plots of sinc(t) and rect(t)

![4](C:\Users\Mark Z\Documents\MATLAB\4.jpg)Fig.2  plot of a^n*u

![5](C:\Users\Mark Z\Documents\MATLAB\5.jpg)Fig.3 plot of cos(wn)a^n*u

### 1.6

![](C:\Users\Mark Z\Documents\MATLAB\6.jpg)

Analysis: 

Stem function every 1 for drawing, Figure 1 in the sin function of the period is 10, stem sampling frequency relative to this period is more appropriate, restore better, Figure 2 in the period is 3, every 1 pick a sample can only draw the highest and lowest point and 0, Figure 3 in the period is 2, every drawing happens to be in the point of 0, has almost can not restore the function, Figure 4 in the period is 9/10, due to the sampling frequency is too low, the final image like a period of 9 sin function, but in fact, has been over 10 cycles.

### 1.7

![7](C:\Users\Mark Z\Documents\MATLAB\7.jpg)

Fig.1 plots of sig1 and sig2

![8](C:\Users\Mark Z\Documents\MATLAB\8.jpg)

Fig.2 plots of ave1

![9](C:\Users\Mark Z\Documents\MATLAB\9.jpg)

Fig.3 plots of ave2

Analysis:

- Since sig1∼N(0,1), and sig2∼N(0.2,1), we could use Matlab code below to obtain this two signals:

```matlab
sig1=random('norm',0,1,1,1000);
sig2=random('norm',0.2,1,1,1000);
```

- As n→1000, we have the average values gradually tend to means of the signal, which is: 

   *ave1(n) → mean(sig1) = 0, as n → 1000*

   *ave2(n) → mean(sig2) = 0.2, as n → 1000*

- Therefore, we could use average values to estimate means when n is enough large to distinguish random noises.


### 1.8



### **Part 3: Summary & Experience.**

------

- Matlab is a very useful and powerful tool in digital signal processing.
- We could use many Matlab functions in signal processing toolbox to solve the problems.
# LAB1 REPORT

SID:12012505

Name: 占陈郅

### **Part 1: Introduction.**

------

- The purpose of this lab is to illustrate the properties of continuous and discrete-time signals using digital computers and the Matlab software environment.
- The main content discussed in this lab:

  - Start with Matlab and learn some basic commands;
  - Numerical computation of continuous signals;
  - Special functions such as sinc(t),rect(t),u[n] and etc;
  - Illustrate the process of sampling;
  - Processing of speech signal and 2-D signal;



**Part 2: Result & Analysis.**

### 1.3.1

1、![image-20220908113920755](C:\Users\Mark Z\AppData\Roaming\Typora\typora-user-images\image-20220908113920755.png)

2、![image-20220908114006388](C:\Users\Mark Z\AppData\Roaming\Typora\typora-user-images\image-20220908114006388.png)

### 1.3.2

![image-20220908114728085](C:\Users\Mark Z\AppData\Roaming\Typora\typora-user-images\image-20220908114728085.png)

Analysis:

From the comparison of the two figures, it is easy to find that n1 takes more points between 0 and 60 and the first image simulation is more accurate, while the second figure loses more information because fewer points are taken.

```matlab
stem(n,y)
title('discrete-time signal 占陈郅12012505')
```

```matlab
plot(n1,z)
title('continuous-time plots of the signal 占陈郅12012505')
```



### 1.3.3

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

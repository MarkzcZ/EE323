function [mag,phase] = FreRes(num,den)
nP = 0:-1:1-length(num);% The index of z for numerator: z^0, z^(-1),z^(-2),...
nD = 0:-1:1-length(den);% The index of z for denominator: z^0, z^(-1),z^(-2),...
syms w;
P = sum(num.*exp(j*w).^nP)% numerator
D = sum(den.*exp(j*w).^nD)% denonminator
H = P/D % Obtain the function expression of the transfer function.
mag = abs(H); phase = angle(H); 
% sgtitle({'Transfer function: ',char(H)},'FontSize',10)
subplot(311),fplot(w,(abs(H)),[-pi,pi]);
xlabel('w(rad)'),ylabel('magnitude response');
title('magnitude response');
subplot(312),fplot(w,20*log10(abs(H)),[-pi,pi]);% magnitude in dB
xlabel('w(rad)'),ylabel('magnitude response(dB)');
title('magnitude response(dB)');hold on;
subplot(313),fplot(w,angle(H),[-pi,pi]);% phase
xlabel('w(rad)'),ylabel('phase response');
title('phase response');hold on;

end
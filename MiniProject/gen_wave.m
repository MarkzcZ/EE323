function waves = gen_wave(tone, scale, noctave, rising, rhythm)
% tone为数字音符，scale为调号, noctave为高低八度数量，rising为升降调，rhythm为节拍，即每个音符持续时长，fs为采样频率，
fs = 44100; %采样频率默认为8192Hz 

freq = tone2freq(tone, scale, noctave, rising);%计算音的频率


x=linspace(0,2*pi*rhythm,rhythm*fs);%增加时值

y=0.7*sin(freq.*x)+0.2*sin(2.*freq.*x)+0.1*sin(3.*freq.*x);%输出包络sin波
waves = y.*exp(-x/rhythm);%音的自然延长

end
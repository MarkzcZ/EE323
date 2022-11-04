function waves = gen_wave(tone, scale, noctave, rising, rhythm)
% tone为数字音符，scale为调号, noctave为高低八度数量，rising为升降调，rhythm为节拍，即每个音符持续时长，fs为采样频率，
fs = 8192; %采样频率默认为8192Hz 

freq = tone2freq(tone, scale, noctave, rising);%计算音的频率

x=linspace(0,2*pi*rhythm,rhythm*fs);%增加时值
waves=sin(freq.*x);%输出sin波
end
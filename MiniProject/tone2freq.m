function freq = tone2freq(tone, scale, noctave, rising) 
% tone: 输入数字音符，数值范围1到7
% noctave: 高或低八度的数量，数值范围整数。0表示中音，正数表示高noctave个八度，负数为低noctave个八度
% rising: 升或降调。1为升，−1为降，0无升降调
% freq为输出的频率
switch(scale)
    case'A'
        f0=440;
    case'B'
        f0=494;
    case'C'
        f0=261.5;
    case'D'
        f0=293.5;
    case'E'
        f0=329.5;
    case'F'
        f0=349;
    case'G'
        f0=391.5;
end
f0 = f0*(2.^noctave);%高低八度

dur = [0,2,3,5,7,8,10];
if tone == 0
    freq = 0;
else 
    freq = f0*(2.^((dur(tone)+rising)/12));
end
end
       
%Encode Radio 1 for DSB and Radio 2 for SSB 
%200Hz band gap

duration=8;
f_sample=44100;
t=(((0-4)*f_sample+0.5):((duration-4)*f_sample-0.5))/f_sample;

%Band 1: 200 Hz to 2.2kHz
%Band 2: 2.4 kHz to 4.4 kHz
%Band 3: 4.6 kHz to 6.6 kHz
[x2, f_sample]=audioread('x2.wav');
x2= x2';

[x3, f_sample]=audioread('x3.wav');
x3= x3';

[x4, f_sample]=audioread('x4.wav');
x4= x4';

[x5, f_sample]=audioread('x5.wav');
x5= x5';

[x6, f_sample]=audioread('x6.wav');
x6= x6';

[x1, f_sample]=audioread('x1.wav');
x1= x1';
%lowpass prefilter

h_prefilter = sin(2 * pi * 1000 * t) ./ (pi * t);

x1_lpf = ece301conv(h_prefilter, x1);
x2_lpf = ece301conv(h_prefilter, x2);
x3_lpf = ece301conv(h_prefilter, x3);
x4_lpf = ece301conv(h_prefilter, x4);
x5_lpf = ece301conv(h_prefilter, x5);
x6_lpf = ece301conv(h_prefilter, x6);

%%Radio 1
x1carrier = cos(2 * pi * 1200 * t);
x2carrier = cos(2 * pi * 3400 * t);
x3carrier = cos(2 * pi * 5600 * t);

radio1 = x1_lpf .* x1carrier + x2_lpf .* x2carrier + x3_lpf .* x3carrier;
radio1 = 2 .* radio1;
audiowrite('radio1.wav', radio1,44100);

%%Radio 2
%Band 1: 0.2 to 1.2 kHz
%Band 2: 1.4 to 2.4 kHz
%Band 3: 2.6 to 3.6 kHz
%Band 4: 3.8 to 4.8 kHz
%Band 5: 5 to 6 kHz
%Band 6: 6.2 to 7.2 kHz

x1carrier = cos(2 * pi * 500 * t);
x2carrier = cos(2 * pi * 1900 * t);
x3carrier = cos(2 * pi * 3100 * t);
x4carrier = cos(2 * pi * 4300 * t);
x5carrier = cos(2 * pi * 5500 * t);
x6carrier = cos(2 * pi * 6700 * t);

x1_lp_ssb = sin(2 * pi * 500 * t) ./ (pi * t);
x2_lp_ssb = sin(2 * pi * 1900 * t) ./ (pi * t);
x3_lp_ssb = sin(2 * pi * 3100 * t) ./ (pi * t);
x4_lp_ssb = sin(2 * pi * 4300 * t) ./ (pi * t);
x5_lp_ssb = sin(2 * pi * 5500 * t) ./ (pi * t);
x6_lp_ssb = sin(2 * pi * 6700 * t) ./ (pi * t);

radio2 = ece301conv(x1 .* x1carrier, x1_lp_ssb) ;
radio2 = radio2 + ece301conv(x2 .* x2carrier, x2_lp_ssb); 
radio2 = radio2 + ece301conv(x3 .* x3carrier, x3_lp_ssb);
radio2 = radio2 + ece301conv(x4 .* x4carrier, x4_lp_ssb);
radio2 = radio2 + ece301conv(x5 .* x5carrier, x5_lp_ssb) ;
radio2 = radio2 + ece301conv(x6 .* x6carrier, x6_lp_ssb);
radio2 = radio2 .* 2;
audiowrite('radio2.wav', radio2,44100);

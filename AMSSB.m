function [y] = AMSSB(ch)
%This function decodes the selected single side band channel from the encoded radio wave

%initializations
duration=8;
f_sample=44100;
t=(((0-4)*f_sample+0.5):((duration-4)*f_sample-0.5))/f_sample;
[radio2, f_sample]=audioread('radio2.wav');
radio2=radio2';

f_c = 700 + 1200 * (ch - 1); % calculating the correct frequency for the channel

lpf1 = sin(2*pi*(f_c-1000)*t) ./ (pi*t); % lower bound of the band pass
lpf2 = sin(2*pi*(f_c)*t) ./ (pi*t); % upper bound of the band pass

bpf = lpf2 - lpf1; % subtracting the smaller lpf from the bigger one should only leave the band in between the two left

y_tmp1 = ece301conv(bpf, radio2); % convoling signal with bpf

y_tmp2 = y_tmp1 .* cos(2 * pi * f_c * t); % Centering the signal

lpf = sin(2*pi*1000*t) ./ (pi*t); % use 1000 as it is the given bandwidth of each signal

y_tmp3 = ece301conv(lpf, y_tmp2); % getting rid of extraneous parts from the bandpass

y = 4 * y_tmp3; % re-scaling the signal back to its original height

audiowrite('test.wav', y, 44100); % saving the decoded signal x to the test.wav file
sound(y, f_sample)
end
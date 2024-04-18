function [y] = AMDSB(ch)
%This function decodes the selected double side band channel from the encoded radio wave
duration=8;
f_sample=44100;
t=(((0-4)*f_sample+0.5):((duration-4)*f_sample-0.5))/f_sample;
[radio1, f_sample]=audioread('radio1.wav');
radio1=radio1';



audiowrite('test.wav', x, 44100); %saving the decoded signal x to the test.wav file
end
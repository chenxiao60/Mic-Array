%IIR实现人工混响的主程序调用
clc
clear all
[x,fs,bits]=wavread('S_01_01.wav');  %这个WAV文件需要自已准备，要求是单声道
delays = [2191 2971 3253  3307]; %这是梳状滤波器的参数，可以调整
rt60=1; %设置想要得到的混响时间
[y] = schroeder(x,delays,rt60,fs);%调用人工混响函数
sound(y,fs);
 wavwrite(y,fs,bits,'C:\Users\Administrator\Desktop\hunxiang\混响\S_01_01revb2.wav');


%IIRʵ���˹���������������
clc
clear all
[x,fs,bits]=wavread('S_01_01.wav');  %���WAV�ļ���Ҫ����׼����Ҫ���ǵ�����
delays = [2191 2971 3253  3307]; %������״�˲����Ĳ��������Ե���
rt60=1; %������Ҫ�õ��Ļ���ʱ��
[y] = schroeder(x,delays,rt60,fs);%�����˹����캯��
sound(y,fs);
 wavwrite(y,fs,bits,'C:\Users\Administrator\Desktop\hunxiang\����\S_01_01revb2.wav');


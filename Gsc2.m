clear all;close all;
% [s1,fs,bits]=wavread( 'F:\cocktail and tc and pesq\Audio\chen10��24��֤����clean\��Ƶ 02_16_01.wav'); %���������ź�Դ 
[s2,fs,bits]=wavread( 'F:\cocktail and tc and pesq\Audio\chen10��24��֤����clean\��Ƶ 02_16_01.wav'); %���������ź�Դ 
[s3,fs,bits]=wavread( 'F:\cocktail and tc and pesq\Audio\chen10��24��֤����clean\��Ƶ 02_16_01.wav'); %���������ź�Դ 
[s4,fs,bits]=wavread( 'F:\cocktail and tc and pesq\Audio\chen10��24��֤����clean\��Ƶ 02_16_01.wav'); %���������ź�Դ 
[s5,fs,bits]=wavread( 'F:\cocktail and tc and pesq\Audio\chen10��24��֤����clean\��Ƶ 02_16_01.wav'); %���������ź�Դ 
[s6,fs,bits]=wavread( 'F:\cocktail and tc and pesq\Audio\chen10��24��֤����clean\��Ƶ 02_16_01.wav'); %���������ź�Դ 
[s7,fs,bits]=wavread( 'F:\cocktail and tc and pesq\Audio\chen10��24��֤����clean\��Ƶ 02_16_01.wav'); %���������ź�Դ 
   s2=s2(1.35*8000:3.35*8000,1);
   s3=s3(1.35*8000:3.35*8000,1);
   s4=s4(1.35*8000:3.35*8000,1);
   s5=s5(1.35*8000:3.35*8000,1);
   s6=s6(1.35*8000:3.35*8000,1);
   s7=s7(1.35*8000:3.35*8000,1);

s1=[s2,s3,s4,s5,s6,s7];
m= 6 ;% array��Ԫ
p=1; %  signal number�ź���
N=3000;% recursive number �������� �������
A=zeros(m,p); % array pattern��������
theta=[60]*pi/180;% the signal from the direction of 30 degree is expected. DOA 30Ϊ�����źŷ���
phi=[90]*pi/180;
j=sqrt(-1);
%
% s=to_get_s(w,N,p);
% s_rec=get_s_rec(s,m,p,theta);
% S=s_rec; %  output date matrix  .m*N ����Ԫ������ݾ���
%%%%����������������������������%% ����Ӧ����Ȩ
y=s1';% input data of GSC;
ad=exp(-j*pi*[0:m-1]'*sin(theta(1))); %steering vector in the direction of expected. �����źŷ�����ʸ��
% ad=exp(-j*pi*cos(2*pi*[0:m-1]'/m-theta(2))); 
% a_theta=exp(j*2*pi*R*cos(2*pi*K'/M-theta(iii)*pi/180)*cos(phi(ii)*pi/180)); 
% ed = [sin(90*pi/180)*cos(45*pi/180); sin(90*pi/180)*sin(45*pi/180); cos(90*pi/180)];
% rn=[0:m-1]';
% rn = [rn zeros(m,2)];
% d0 = exp(-j * 2*pi*1000/340 *rn* ed);
c=10;%  condition �����γ�����
C=ad';
Wc=C'*inv(C*C')*c; %main path weight ��ͨ���̶�Ȩ
wa(1:m-1,1)=0;  % auxiliary path  ����ͨ������ӦȨ
B=get_B(m,theta); % get Block Matrix �õ���������
u=0.000001;
for k=1:N
    yb=conj(B)*y(:,k);  % m-1*1 ��������
    Zc(k)=Wc.'*y(:,k);
    Za(k)=wa(:,k).'*yb;
    Z(k)=Zc(k)-Za(k);
    wa(:,k+1)=wa(:,k)-u*Z(k)*conj(yb);
end
%%%%------------
%%%main path ��ͨ��
% wop=Wc;
% drawpp(m,wop);
% %%%%auxiliary path ����ͨ��
% wop=B'*wa(:,N)
% drawpp(m,wop);
%%array response �ܵ�������Ӧ
wop=Wc-B'*wa(:,N);
% drawpp(m,wop);
y=s1*wop;outlen=length(s1(:,1));
t = (0:outlen-1)/fs;
figure
plot(t,s1(:,1));
xlabel('Time (sec)'); ylabel ('Amplitude (V)');
% axis([0 7 -0.2 0.2]);
%  sound(sigArray(:,1));
% y=y/max(abs(y));
figure
plot(t,y);
xlabel('Time (sec)'); ylabel ('Amplitude (V)');
title('Signal y');
% wavwrite(y,fs,'C:\Users\Administrator\Desktop\4��Ԫ\yout91')
wavwrite(y,fs,'F:\cocktail and tc and pesq\Audio\youtgsc.wav');
% plot(yout');
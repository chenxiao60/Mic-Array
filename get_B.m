function Bm=get_B(m,theta)  %���ڲ�����������
u0=0.5*sin(theta(1)); % ������Ԫ���Ϊ�������
a0=exp(-j*2*pi*[0:m-1]'*u0);
u=u0+[1:m-1];
B=exp(-j*2*pi*[0:m-1]'*u);
Bm=conj(B');%% M-1*M �ľ���
% function Bm=get_B(m,theta)  %���ڲ�����������
% % u0=0.5*sin(theta(1)); % ������Ԫ���Ϊ�������
% % a0=exp(-j*2*pi*[0:m-1]'*u0);
% % u=u0+[1:m-1];
% % B=exp(-j*2*pi*[0:m-1]'*u);
% % Bm=conj(B');%% M-1*M �ľ���
% 
% ed = [sin(90*pi/180)*cos(90*pi/180); sin(90*pi/180)*sin(90*pi/180); cos(90*pi/180)];
% rn=[0:m-1]';
% rn = [rn zeros(m,2)];
% a0 = exp(-j * 2*pi*1000/340 *rn* ed);
% mm=[1:m-1]';
% mm=[mm zeros(m-1,2)];
% rn
% mm
% ed=[ed zeros(m-1,2)];
% u=ed+mm;
% B=exp(-j*2*pi*1000/340 *rn*u);
% Bm=conj(B');%% M-1*M �ľ���
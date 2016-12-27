function Bm=get_B(m,theta)  %用于产生阻塞矩阵
u0=0.5*sin(theta(1)); % 假设阵元间距为半个波长
a0=exp(-j*2*pi*[0:m-1]'*u0);
u=u0+[1:m-1];
B=exp(-j*2*pi*[0:m-1]'*u);
Bm=conj(B');%% M-1*M 的矩阵
% function Bm=get_B(m,theta)  %用于产生阻塞矩阵
% % u0=0.5*sin(theta(1)); % 假设阵元间距为半个波长
% % a0=exp(-j*2*pi*[0:m-1]'*u0);
% % u=u0+[1:m-1];
% % B=exp(-j*2*pi*[0:m-1]'*u);
% % Bm=conj(B');%% M-1*M 的矩阵
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
% Bm=conj(B');%% M-1*M 的矩阵
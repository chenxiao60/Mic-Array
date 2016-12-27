clear all;close all;

m=8 ;% array阵元
p=4; %  signal number信号数
N=3000;% recursive number 迭代次数 或快拍数
A=zeros(m,p); % array pattern阵列流型
theta=[30 0 -45 60]*pi/180;% the signal from the direction of 30 degree is expected. DOA 30为期望信号方向
j=sqrt(-1);
w=[0.01 0.2 0.3 0.4]*pi; % frequency for each signal.各个信号的数字频率

%%
s=to_get_s(w,N,p);
s_rec=get_s_rec(s,m,p,theta);
S=s_rec; %  output date matrix  .m*N 的阵元输出数据矩阵
%%%%——————————————%% 自适应调节权
y=S;% input data of GSC;
ad=exp(-j*pi*[0:m-1]'*sin(theta(1))) %steering vector in the direction of expected. 期望信号方向导向矢量
c=10;%  condition 波束形成条件
C=ad';
Wc=C'*inv(C*C')*c; %main path weight 主通道固定权
wa(1:m-1,1)=0;  % auxiliary path  辅助通道自适应权
B=get_B(m,theta); % get Block Matrix 得到阻塞矩阵
u=0.000001;
for k=1:N
    yb=conj(B)*y(:,k);  % m-1*1 的列向量
    Zc(k)=Wc.'*y(:,k);
    Za(k)=wa(:,k).'*yb;
    Z(k)=Zc(k)-Za(k);
    wa(:,k+1)=wa(:,k)-u*Z(k)*conj(yb);
end
%%%%------------
%%%main path 主通道
wop=Wc;
drawpp(m,wop);
%%%%auxiliary path 辅助通道
wop=B'*wa(:,N)
drawpp(m,wop);
%%array response 总的阵列响应
wop=Wc-B'*wa(:,N);
drawpp(m,wop);
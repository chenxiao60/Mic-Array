clear all;close all;

m=8 ;% array��Ԫ
p=4; %  signal number�ź���
N=3000;% recursive number �������� �������
A=zeros(m,p); % array pattern��������
theta=[30 0 -45 60]*pi/180;% the signal from the direction of 30 degree is expected. DOA 30Ϊ�����źŷ���
j=sqrt(-1);
w=[0.01 0.2 0.3 0.4]*pi; % frequency for each signal.�����źŵ�����Ƶ��

%%
s=to_get_s(w,N,p);
s_rec=get_s_rec(s,m,p,theta);
S=s_rec; %  output date matrix  .m*N ����Ԫ������ݾ���
%%%%����������������������������%% ����Ӧ����Ȩ
y=S;% input data of GSC;
ad=exp(-j*pi*[0:m-1]'*sin(theta(1))) %steering vector in the direction of expected. �����źŷ�����ʸ��
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
wop=Wc;
drawpp(m,wop);
%%%%auxiliary path ����ͨ��
wop=B'*wa(:,N)
drawpp(m,wop);
%%array response �ܵ�������Ӧ
wop=Wc-B'*wa(:,N);
drawpp(m,wop);
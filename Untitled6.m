clear all;close all;

m=8 ;% ��Ԫ
p=4; %  �ź���
N=2000;% �������� �������
A=zeros(m,p); % ��������
theta=[30 -20 -40 60]*pi/180;% DOA 30Ϊ�����źŷ���
j=sqrt(-1);
w=[0.1 0.02 0.3 0.4]; % �����źŵ�����Ƶ��

s=to_get_s(w,N,p);
s_rec=get_s_rec(s,m,p,theta);
S=s_rec; % m*N ����Ԫ������ݾ���

%%%%����������������������������%% ����Ӧ����Ȩ
y=S;% input data of GSC;
ad=exp(-j*pi*[0:m-1]'*sin(theta(1))) % �����źŷ�����ʸ��
c=5;% �����γ�����
C=ad';
Wc=C'*inv(C*C')*c; % ��ͨ���̶�Ȩ
u=0.01;
wa(1:m-1,1)=0;  % ����ͨ������ӦȨ
Bm=get_B(m,theta); % get Block Matrix �õ���������
B=Bm;
Rxx=get_Rxx(s_rec,N,p,m);
R=Rxx;
wa=inv(B*R*B')*B*R*Wc;
%%%%-----------------------------
wop=Wc-B'*wa;

%%-------------------------��ͼ
drawpp(m,0,wop);

function s_rec=get_s_rec(s,m,p,theta)  %���ڲ���������Ԫ����ź�����
A=zeros(m,p);
j=sqrt(-1);
%%% ��Ԫ���Ϊ�������
wi=pi*sin(theta);
A=exp(-j*wi'*[0:(m-1)]);  % ��������
s_rec=A'*s;
s_rec=awgn(s_rec,10);  % SNR=10 db
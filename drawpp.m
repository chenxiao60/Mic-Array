function y=drawpp(m,wop)
%figure,plot(e)
thetas=[-90:90];
tm=thetas*pi/180;
am=exp(-j*pi*[0:m-1]'*sin(tm));
A=abs(wop'*am);  %������Ӧ
A=A/max(A);
figure,polar(tm,A)
A=10*log10(A);  %����ͼ
hold on,title('��һ��������Ӧ��ֵ������ͼ������Ԫ�������20db')
figure,plot(thetas,A);
hold on,title('����Ԫ�������20db')
hold on,xlabel('�����/��')
hold on,ylabel('��һ�� A=10*log10(A);')
grid on 
axis([-90 90 -35 0]);
hold on,plot(-45,-35:0.1:0,'r');
hold on,plot(30,-35:0.1:0,'r');
hold on,plot(0,-35:0.1:0,'r');
hold on,plot(60,-35:0.1:0,'r');
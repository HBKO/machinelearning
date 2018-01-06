%costfunction�൱��Ŀ�꺯��
%ʹ��һ�׵��ݶ��½�
%���룺X��ʾ��������ݼ�:m*n(m��ʾ��������n��ʾά��),y��ʾ�����ı�ǩ(m*1:m��ʾ������),beta��ʾ�߼��ع�Ĳ���[w;b]
%��������������ֵ
function [jVal,gradient]=costfunction(X,y,beta)
    jVal=0;
    %�����ݶ�
    grad=zeros(size(beta));
    h=1.0./(1.0+exp(-1*X*beta));
    m=size(y,1);
    %Ŀ�꺯��
    jVal=((-1*y)'*log(h)-(1-y)'*log(1-h))/m;
    for i=1:size(beta,1)
        gradient(i)=((h-y)'*X(:,i))/m; %ʹ���ݶ��½�����
    end
end
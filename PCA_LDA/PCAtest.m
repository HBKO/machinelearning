%����PCA��ά����ͨ��KNN�����б�
clear;
clc;
load('ORL_32_32.mat');
X=alls';
[m,n]=size(X);
Labels=gnd;
%���Ļ�
Xhat=X-ones(m,1)*mean(X)/m;
%��Э�������
Cov=cov(Xhat);
%����ֵ���
[PC,variances,explained]=pcacov(Cov);

[lambda,index]=sort(variances,'descend');%�����������н�������
presdim=50;%�뱣����ά��
PC=PC(:,index);%������������С��������������
W=PC(:,1:presdim);%ѡ��ǰm�����������Ӧ�������������ͶӰ����
Y=W'*X';
Y=Y';

%���ڲ���Ҫѵ������ȫ�����ϵ��ɲ��Լ�,��
res=zeros(1,400);
distance=zeros(1,400);
for i=1:400
    for j=1:400
        distance(1,j)=norm(Y(i,:)-Y(j,:));
    end
    distance(1,i)=+inf;
    %��k=1
    [~,minindex]=min(distance(1,:));
    res(1,i)=Labels(minindex);
end


%����׼ȷ��
count=0;
for i=1:400
    if res(1,i)==Labels(i)
        count=count+1;
    end
end
disp(count/400);

        
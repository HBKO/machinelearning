%����LDA��KNN��������ʶ��
clear;
clc;
load('ORL.mat');
X=alls';
Labels=gnd;
%��������һ��40��
%�����ܵ���������
x_bar=mean(X);
n=10;
%����40����
Data=cell(40);
for i=1:40
    Data{1,i}=X((i-1)*10+1:i*10,:);
end
bar=zeros(40,1024);
%����ÿһ�������������
for i=1:40
    tmpMatrix=Data{1,i};
    bar(i,:)=mean(tmpMatrix);
end
%����ÿһ�����ɢ�Ⱦ���
%���ɢ�Ⱦ���
SW=zeros(1024,1024);
for i=1:40
    tmpMatrix=Data{1,i};
    Data{2,i}=n*(bar(i,:)-x_bar)'*(bar(i,:)-x_bar);%����ɢ�Ⱦ���
    SW=SW+Data{2,i};
end

%������������������
%��������ɢ�Ⱦ���
Sb=zeros(1024,1024);
for i=1:40
    Data{3,i}=Data{1,i}-repmat(bar(i,:),n,1);
    Sb=Sb+Data{3,i}'*Data{3,i};
end

%��������ֵ
[vs,lam]=eig(Sb,SW);%fisher criterion,minimize Sb/SW,����ֵ�ֽ�
lam=diag(lam);%ȥ��С�ڵ����������ֵ��Ӧ�����������������˻���
ind=find(lam<=0);
lam(ind)=[];
vs(:,ind)=[];
[lambda,index]=sort(lam,'ascend');%������ֵ��������
presdim=30;
vs=vs(:,index);
w=vs(:,1:presdim);%LDAͶӰ����LDA������
Y=w'*X';
Y=Y';


%���ڲ���Ҫѵ������ȫ�����ϵ��ɲ��Լ�
res=zeros(1,200);
distance=zeros(1,200);
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



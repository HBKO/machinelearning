%利用LDA和KNN进行人脸识别
clear;
clc;
load('ORL.mat');
X=alls';
Labels=gnd;
%所有样本一共40类
%计算总的样本中心
x_bar=mean(X);
n=10;
%构建40个类
Data=cell(40);
for i=1:40
    Data{1,i}=X((i-1)*10+1:i*10,:);
end
bar=zeros(40,1024);
%计算每一个类的样本中心
for i=1:40
    tmpMatrix=Data{1,i};
    bar(i,:)=mean(tmpMatrix);
end
%计算每一个类的散度矩阵
%类间散度矩阵
SW=zeros(1024,1024);
for i=1:40
    tmpMatrix=Data{1,i};
    Data{2,i}=n*(bar(i,:)-x_bar)'*(bar(i,:)-x_bar);%构建散度矩阵
    SW=SW+Data{2,i};
end

%对所有样本进行正则化
%计算类内散度矩阵
Sb=zeros(1024,1024);
for i=1:40
    Data{3,i}=Data{1,i}-repmat(bar(i,:),n,1);
    Sb=Sb+Data{3,i}'*Data{3,i};
end

%计算特征值
[vs,lam]=eig(Sb,SW);%fisher criterion,minimize Sb/SW,特征值分解
lam=diag(lam);%去除小于等于零的特征值对应的特征向量，属于退化解
ind=find(lam<=0);
lam(ind)=[];
vs(:,ind)=[];
[lambda,index]=sort(lam,'ascend');%对特征值降序排序
presdim=30;
vs=vs(:,index);
w=vs(:,1:presdim);%LDA投影矩阵，LDA基矩阵
Y=w'*X';
Y=Y';


%由于不需要训练，则将全部集合当成测试集
res=zeros(1,200);
distance=zeros(1,200);
for i=1:400
    for j=1:400
        distance(1,j)=norm(Y(i,:)-Y(j,:));
    end
    distance(1,i)=+inf;
    %令k=1
    [~,minindex]=min(distance(1,:));
    res(1,i)=Labels(minindex);
end


%计算准确率
count=0;
for i=1:400
    if res(1,i)==Labels(i)
        count=count+1;
    end
end
disp(count/400);



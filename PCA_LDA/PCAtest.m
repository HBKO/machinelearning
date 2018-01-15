%利用PCA降维，再通过KNN进行判别
clear;
clc;
load('ORL_32_32.mat');
X=alls';
[m,n]=size(X);
Labels=gnd;
%中心化
Xhat=X-ones(m,1)*mean(X)/m;
%求协方差矩阵
Cov=cov(Xhat);
%特征值求解
[PC,variances,explained]=pcacov(Cov);

[lambda,index]=sort(variances,'descend');%对特征根进行降序排序
presdim=50;%想保留的维度
PC=PC(:,index);%根据特征根大小对特征向量排序
W=PC(:,1:presdim);%选择前m个最大特征对应的特征向量组成投影向量
Y=W'*X';
Y=Y';

%由于不需要训练，则将全部集合当成测试集,将
res=zeros(1,400);
distance=zeros(1,400);
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

        
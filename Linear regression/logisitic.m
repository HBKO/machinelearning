%实现对率回归，实现机器学习课本上的下降方法
clear;
clc;

load('watermelondata.mat');
Data=data;
[r,c]=size(Data);
%设置训练集以及测试集，先用留出法
%6个正，7个负
traindata=Data(1:6,2:3);
trainLabel=Data(1:6,4);
traindata=[traindata;Data(9:15,2:3)];
trainLabel=[trainLabel;Data(9:15,4)];
tmp=ones(13,1);
traindata=[traindata tmp];

testdata=Data(7:8,2:3);
testLabel=Data(7:8,4);
testdata=[testdata;Data(16:17,2:3)];
testLabel=[testLabel;Data(16:17,4)];
tmp=ones(4,1);
testdata=[testdata tmp];
%获取数据的维度
[r,c]=size(traindata);

max_iter=400;
beta=zeros(max_iter+1,c);
%观测差值
cha=zeros(max_iter+1,3);
%选定初值

for i=1:c
    beta(1,i)=1;
end

der1=0;
der2=0;

%进行牛顿迭代法进行迭代
for k=1:max_iter
    der1=0;
    der2=0;
    for i=1:r
        X=traindata(i,:);
        y=trainLabel(i);
        der1=der1+X*(y-p1(X,beta(k,:)));
        der2=der2+X*X'*p1(X,beta(k,:))*(1-p1(X,beta(k,:)));
    end
    der1=der1/r;
    der2=der2/r;
    cha(k,:)=der2^(-1)*(-der1);
    beta(k+1,:)=beta(k,:)-cha(k,:);
end

%disp(cha);
%绘制迭代差值
plot(cha);

%x(:,1)=linspace(0,1);
%x(:,2)=linspace(0,1);
%x(:,3)=linspace(1,1);
%y=x*(beta(501,:)');
%allpoint=[traindata(:,1:2) trainLabel(:,1)];
%hold on
%scatter3(allpoint(:,1),allpoint(:,2),allpoint(:,3));
%plot3(x(:,1),x(:,2),y(:));
%hold off
[r,~]=size(testdata);
res=traindata*(beta(max_iter+1,:)');
disp(res);
count=0;
for i=1:r
    if trainLabel(i,:)==round(res(i))
        count=count+1;
    end
end
disp(['the accurate is :',num2str(count/4)]);




    
    
    
        


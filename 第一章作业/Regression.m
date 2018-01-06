clear;
clc;
load('ORL_32_32.mat');
%暂时使用留出法2，8划分训练集


%将像素数据进行归一化
mapalls=mapminmax(alls,0,1);
traindata=zeros(1024,320);
testdata=zeros(1024,80);
count1=1;
count2=1;
count=1;
for i=1:10:400
    for j=1:8
        traindata(:,count1)=mapalls(:,(i+j-1));
        count1=count1+1;
    end
    for j=9:10
        testdata(:,count2)=mapalls(:,(i+j-1));
        count2=count2+1;
    end
end

%对第一个图片进行识别，查看相似度
testdata1=testdata(:,1);

%设置权值
w=zeros(40,8);
%计算权值
for i=1:40
%    for j=1:8
%        picture=traindata(:,((i-1)*8+j));
%        w(i,j)=(picture'*picture)^(-1)*picture'*testdata1;
%    end
    picture=traindata(:,((i-1)*8+1):(8*i));
    w(i,:)=(picture'*picture)^(-1)*picture'*testdata1;
end

w=w';
%获取每一个类别图片的预测值
Preddata=zeros(1024,40);
finalres=zeros(1,40);
for i=1:40
    Preddata(:,i)=traindata(:,((i-1)*8+1):(8*i))*w(:,i);
    finalres(i)=norm(Preddata(:,i)-testdata1);
end
%disp(finalres);
[mindata,Index]=min(finalres);
disp(Index);
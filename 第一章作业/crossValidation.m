%进行二折交叉验证
%即将数据二等分之后，一份为训练集，一份为测试集
%之后再进行交换一次，查看准确率
%二次求平均
clear;
clc;
load('ORL_32_32.mat');

%归一化
mapalls=mapminmax(alls,0,1);
mapalls=[mapalls;gnd];
traindata=zeros(1025,200);
testdata=zeros(1025,200);

count1=1;
count2=1;
%使得采样的类别比例等分
for i=1:10:400
    for j=1:5
        traindata(:,count1)=mapalls(:,(i+j-1));
        count1=count1+1;
    end
    for j=6:10
        testdata(:,count2)=mapalls(:,(i+j-1));
        count2=count2+1;
    end
end

%统计成功分类的数量
finallabel=zeros(1,200);
count=0;

for i=1:200
    finallabel(i)=Linear(traindata(1:(end-1),:),testdata(1:(end-1),i),5);
    if finallabel(i)==testdata(1025,i)
        count=count+1;
    end
end

%替换分类再进行一次检测
accurate1=count/200;
count=0;

for i=1:200
    finallabel(i)=Linear(testdata(1:(end-1),:),traindata(1:(end-1),i),5);
    if finallabel(i)==traindata(1025,i)
        count=count+1;
    end
end

accurate2=count/200;

disp(['the accuracy is : ',num2str((accurate1+accurate2)/2)]);
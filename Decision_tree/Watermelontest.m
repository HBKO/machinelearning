%利用西瓜数据集进行验证
clear;
clc;
load('watermelon.mat');
Data=ans;
[m,n]=size(Data);
%用留出法划分数据集
PosData=Data(1:8,:);
NegData=Data(9:17,:);
[Pr,~]=size(PosData);
[Nr,~]=size(NegData);
TrainData=[PosData(1:Pr-2,1:end-1);NegData(1:Nr-2,1:end-1)];
TrainLabels=[PosData(1:Pr-2,end);NegData(1:Nr-2,end)];
TestData=[PosData(Pr-2:Pr,1:end-1);NegData(Nr-2:Nr,1:end-1)];
TestLabels=[PosData(Pr-2:Pr,end);NegData(Nr-2:Nr,end)];

%进行训练
Attribute=[1:n-1];
classnumber=zeros(1,n-1);
for i=1:n-1
    classnumber(1,i)=max(Data(:,i));
end
%获取得到的训练树为
Tree=DecTree(TrainData,Attribute,TrainLabels,classnumber);


%进行测试
[Tsr,~]=size(TestData);
count=0;
for i=1:Tsr
    res=DecEstimation(Tree,TestData(i,:));
    count=count+(res==TestLabels(i,1));
end
disp(count/Tsr);

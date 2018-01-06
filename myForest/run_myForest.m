clear;
clc;
%测试我们的第一个孤立森林

%拆分数据集
data=importdata('shuttle_49097.csv');
[r,c]=size(data);

ADLabels=data(:,end);
Data=data(:,1:end-1);


rounds=10;
%设置默认参数
%树数目
NumTree=100;
%每棵树使用的数据集
NumSub=256;
CurNumDim=size(Data,2);
auc=zeros(rounds,1);
mtime=zeros(rounds,1);
memory=zeros(rounds,1);
score=zeros(r,100);
rseed=zeros(rounds,1);
%进行十次循环来查看对该数据集的一个效果


for i=1:rounds
    disp(['建立孤立森林',num2str(i)]);

    rseed(i)=sum(100*clock);
    myForest=BuildForest(Data,NumTree,NumSub,rseed(i));
    [Mass,ElapseTime]=myEstimation(Data,myForest);
    Score=-mean(Mass,2);
    auc(i)=Measure_AUC(Score,ADLabels);
    mtime(i,1)=ElapseTime;
    disp(['auc = ', num2str(auc(i)),'.']);
end

avgauc=mean(auc');
avgtime=mean(mtime');
disp(['average auc= ',num2str(avgauc),'.']);








%disp(score);
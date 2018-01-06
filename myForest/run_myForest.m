clear;
clc;
%�������ǵĵ�һ������ɭ��

%������ݼ�
data=importdata('shuttle_49097.csv');
[r,c]=size(data);

ADLabels=data(:,end);
Data=data(:,1:end-1);


rounds=10;
%����Ĭ�ϲ���
%����Ŀ
NumTree=100;
%ÿ����ʹ�õ����ݼ�
NumSub=256;
CurNumDim=size(Data,2);
auc=zeros(rounds,1);
mtime=zeros(rounds,1);
memory=zeros(rounds,1);
score=zeros(r,100);
rseed=zeros(rounds,1);
%����ʮ��ѭ�����鿴�Ը����ݼ���һ��Ч��


for i=1:rounds
    disp(['��������ɭ��',num2str(i)]);

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
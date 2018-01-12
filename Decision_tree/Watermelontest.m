%�����������ݼ�������֤
clear;
clc;
load('watermelon.mat');
Data=ans;
[m,n]=size(Data);
%���������������ݼ�
PosData=Data(1:8,:);
NegData=Data(9:17,:);
[Pr,~]=size(PosData);
[Nr,~]=size(NegData);
TrainData=[PosData(1:Pr-2,1:end-1);NegData(1:Nr-2,1:end-1)];
TrainLabels=[PosData(1:Pr-2,end);NegData(1:Nr-2,end)];
TestData=[PosData(Pr-2:Pr,1:end-1);NegData(Nr-2:Nr,1:end-1)];
TestLabels=[PosData(Pr-2:Pr,end);NegData(Nr-2:Nr,end)];

%����ѵ��
Attribute=[1:n-1];
classnumber=zeros(1,n-1);
for i=1:n-1
    classnumber(1,i)=max(Data(:,i));
end
%��ȡ�õ���ѵ����Ϊ
Tree=DecTree(TrainData,Attribute,TrainLabels,classnumber);


%���в���
[Tsr,~]=size(TestData);
count=0;
for i=1:Tsr
    res=DecEstimation(Tree,TestData(i,:));
    count=count+(res==TestLabels(i,1));
end
disp(count/Tsr);

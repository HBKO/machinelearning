%���ж��۽�����֤
%�������ݶ��ȷ�֮��һ��Ϊѵ������һ��Ϊ���Լ�
%֮���ٽ��н���һ�Σ��鿴׼ȷ��
%������ƽ��
clear;
clc;
load('ORL_32_32.mat');

%��һ��
mapalls=mapminmax(alls,0,1);
mapalls=[mapalls;gnd];
traindata=zeros(1025,200);
testdata=zeros(1025,200);

count1=1;
count2=1;
%ʹ�ò������������ȷ�
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

%ͳ�Ƴɹ����������
finallabel=zeros(1,200);
count=0;

for i=1:200
    finallabel(i)=Linear(traindata(1:(end-1),:),testdata(1:(end-1),i),5);
    if finallabel(i)==testdata(1025,i)
        count=count+1;
    end
end

%�滻�����ٽ���һ�μ��
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
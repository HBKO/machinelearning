clear;
clc;
load('ORL_32_32.mat');

mapalls=mapminmax(alls,0,1);
%mapalls=alls;
mapalls=[mapalls;gnd];
traindata=zeros(1025,320);
testdata=zeros(1025,80);


count1=1;
count2=1;
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

finallabel=zeros(1,80);
count=0;

for i=1:80
    finallabel(i)=Linear(traindata(1:(end-1),:),testdata(1:(end-1),i),8);
    if finallabel(i)==testdata(1025,i)
        count=count+1;
    end
end

disp(['the accuracy is : ',num2str(count/80)]);



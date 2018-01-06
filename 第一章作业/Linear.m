%traindata:全部的训练数据，mxn:m表示数据维度，n表示样本，假设样本数据类别都连续
%testdata:代表测试数据
%number:训练集中的数据的每一类有多少数据
function index = Linear( traindata, testdata,number)
    [r,c]=size(traindata);
    classnumber=c/number;
    w=zeros(classnumber,number);
    %计算权值
    for i=1:classnumber
        picture=traindata(:,((i-1)*number+1):(number*i));
        w(i,:)=(picture'*picture)^(-1)*picture'*testdata;
    end

    w=w';
    %获取每一个照片的预测值
    Preddata=zeros(r,classnumber);
    finalres=zeros(1,classnumber);
    for i=1:classnumber
        Preddata(:,i)=traindata(:,((i-1)*number+1):(number*i))*w(:,i);
        finalres(i)=norm(Preddata(:,i)-testdata);
    end
    [~,index]=min(finalres);
end


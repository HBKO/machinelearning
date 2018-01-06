%traindata:ȫ����ѵ�����ݣ�mxn:m��ʾ����ά�ȣ�n��ʾ�������������������������
%testdata:�����������
%number:ѵ�����е����ݵ�ÿһ���ж�������
function index = Linear( traindata, testdata,number)
    [r,c]=size(traindata);
    classnumber=c/number;
    w=zeros(classnumber,number);
    %����Ȩֵ
    for i=1:classnumber
        picture=traindata(:,((i-1)*number+1):(number*i));
        w(i,:)=(picture'*picture)^(-1)*picture'*testdata;
    end

    w=w';
    %��ȡÿһ����Ƭ��Ԥ��ֵ
    Preddata=zeros(r,classnumber);
    finalres=zeros(1,classnumber);
    for i=1:classnumber
        Preddata(:,i)=traindata(:,((i-1)*number+1):(number*i))*w(:,i);
        finalres(i)=norm(Preddata(:,i)-testdata);
    end
    [~,index]=min(finalres);
end


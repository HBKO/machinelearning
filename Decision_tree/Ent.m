%Data:m x n����m��ʾ���ݵ�������n��ʾ���ݵ�ά�ȣ�������ά�����һά��ʾ��ǩ��
%Labels:��ʾ���ݱ�ǩ��
%Attribute:��ʾ��ѡ�������
%c1:��ʾ������ά���µ���������
%res:��ʾӦ�ð���һά�ı�ǩ���з���
%���ݶ�����1,2����ʽ��ʾ����(����matlab�±겻��Ϊ0)
%Ent:��ʾ����ÿһά����Ϣ���棬�������ѡ���ά��
%
function res=Ent(Data,Labels,Attribute)
    [~,c1]=size(Attribute);
    if c1==1
        res=Attribute;
        return;
    end
    Data=Data(:,Attribute);
    
    Data=Data';
    [m,c1]=size(Data);
    pos=0;neg=0;
    %����D
    for i=1:c1
        if Labels(i)==1
            pos=pos+1;
        else
            neg=neg+1;
        end
    end
    pos=pos/c1;
    neg=neg/c1;
    D=-(pos*log2(pos)+neg*log2(neg));
    %����ÿһ�����ı�ǩ
    Num=zeros(c1,2);
    Count=cell(m);
    for i=1:m
        for j=1:c1
            Num(Data(i,j),Labels(j))=Num(Data(i,j),Labels(j))+1;
        end
            Count{1,i}=Num;
            Num=zeros(c1,2);
    end
    Gain=zeros(m);
    for i=1:m
        Gain(i)=D;
    end
    Entnum=zeros(c1);
    
    for i=1:m
        Num=Count{1,i};
        [k,c]=size(Num);
        for j=1:k
            sumnum=Num(j,1)+Num(j,2);
            for p=1:2
                if Num(j,p)==0
                    continue;
                end
                tmp=Num(j,p)/sumnum;
                Entnum(j)=Entnum(j)-tmp*log2(tmp);
            end
            Entnum(j)=sumnum/c1*Entnum(j);
            Gain(i)=Gain(i)-Entnum(j);
        end
        Entnum=zeros(c1);
    end
    [~,res]=max(Gain(:,1));
    res=Attribute(res);
end
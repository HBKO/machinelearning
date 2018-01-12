%Data:m x n矩阵：m表示数据的行数，n表示数据的维度，至少两维，最后一维表示标签。
%Labels:表示数据标签。
%Attribute:表示所选择的属性
%c1:表示在所有维数下的最大类别数
%res:表示应该按那一维的标签进行分类
%数据都是以1,2的形式表示出来(由于matlab下标不能为0)
%Ent:表示计算每一维的信息增益，并算出所选择的维度
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
    %计算D
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
    %计算每一个类别的标签
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
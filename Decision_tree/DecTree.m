%DecForest：构建决策树
%Data:表示用于构建决策树的数据
%Labels:表示标签
%Attribute:表示属性集
%classnumber:n x 1矩阵：表示属性中有多少类别
%Tree:生成出来的树
%Tree.Attribute:针对于该结点划分的属性,0表示叶结点
%Tree.NodeStatus:表示该结点所具有的状态
%Tree.Child：表示该结点的孩子结点
%1和2：表示该结点的标签
%0:表示还需要继续向下分
function Tree = DecTree( Data,Attribute,Labels,classnumber )

    [m,n]=size(Data);
    flag=0;
    %对标签进行计数
    Count=zeros(1,2);
    Count(1,Labels(1,1))=Count(1,Labels(1,1))+1;
    for i=2:m
        if Labels(i)~=Labels(1)
            flag=1;
        end
        Count(1,Labels(i))=Count(1,Labels(i))+1;
    end
    
    %判读D中样本全属于同一类别C
    if flag==0
        Tree.Attribute=0;
        Tree.NodeStatus=Labels(1);
        Tree.Child=[];
        return;
    end
    flag=0;
    [~,ca]=size(Attribute);
    for i=2:m
        
        for j=1:ca
            if Data(i,Attribute(j))~=Data(1,Attribute(j))
                    flag=1;
                    break;
            end
        end
    end
    %属性集A为空或者D的所有属性值均一样,表示为最多的标签
    if isempty(Attribute) || flag==0
        Tree.Attribute=0;
        [~,Tree.NodeStatus]=max(Count);
        Tree.NodeStatus=Tree.NodeStatus;
        Tree.Child=[];
        return;
    end
    
    

    %计算最优属性
    Index=Ent(Data,Labels,Attribute);
    %将A中的出现Index属性剔除
    
    
    tmp=sortrows([Data Labels],Index);
    start=1;finish=1;
    Number=zeros(2,classnumber(1,Index));
    %计算矩阵中有多少个不同的数字
    for i=1:m
        Number(1,tmp(i,Index))=Number(1,tmp(i,Index))+1;
        Number(2,tmp(i,Index))=Number(2,tmp(i,Index))+((tmp(i,end))-1);
    end
    finData=cell(classnumber(1,Index));
    
    %对数据的该数据进行划分分支
    for finish=1:m
        if tmp(start,Index)~=tmp(finish,Index)
            finData{1,tmp(start,Index)}=tmp(start:(finish-1),:);
            start=finish;
        end
    end
    %针对最后一组进行分组
    finData{1,tmp(finish,Index)}=tmp(start:finish,:);
    
    [~,k]=size(finData);
    
    
    %将已经判断属性进行剔除
    [~,cow]=size(Attribute);
    for i=1:cow
        if Attribute(i)==Index
            Attribute(i)=[];
            break;
        end
    end
    
    %进行划分树结点
    for i=1:k
        TmpMatrix=finData{1,i};
        [m,n]=size(TmpMatrix);
        
        %遇到空集合直接随机取一个标签
        %选择样本最后的一类最后标签
        if isempty(TmpMatrix)
            Tree.Attribute=Index;
            Tree1.Attribute=0;
            [~,maxindex]=max(Number(1,:));
            NodeStatus=round(Number(2,maxindex)/Number(1,maxindex))+1;
            Tree1.NodeStatus=NodeStatus;
            Tree1.Child=[];
            Tree.Child{i}=Tree1;
        else
            Tree.Attribute=Index;
            Tree.NodeStatus=0;
            Tree.Child{i}=DecTree(TmpMatrix(:,1:end-1),Attribute,TmpMatrix(:,end),classnumber);
        end
    end
end


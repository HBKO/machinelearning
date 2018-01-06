
%根据论文伪代码建立孤立树
%输入的参数如下：
%伪代码中只有一个data子样本参数，这里后面的参数是利用给递归用的
%data:输入的数据，行表示样本树，列表示数据的维度
%CurIndex:当前所要利用的数据在原数据的索引
%Curheight:现在的树高
%Parasm表示一些限制的参数
%Parasm.IndexDim: sub-dimension index;
%Parasm.NumDim: #子样本的维度
%Param.LimitHeight:最大的树高

%输出的Tree实际上是一个树结点
%Tree.NodeStatus: 1:inNode, 0:叶子结点
%Tree.SplitAttribute:用来划分的维度
%Tree.SplitPoint:划分点
%Tree.LeftChild:左子树
%Tree.RightChild:右子树
%Tree.Size: 该结点的数据size
%Tree.Height:该结点的高度



function  Tree=BuildTree(Data,CurIndex,Curheight,Parasm)
    Tree.Height=Curheight;
    NumInts=length(CurIndex);
    %终止条件
    if Tree.Height >= Parasm.HeightLimit ||  NumInts<=1
        Tree.NodeStatus=0;
        Tree.SplitAttribute=[];
        Tree.SplitPoint=[];
        Tree.LeftChild=[];
        Tree.RightChild=[];
        Tree.Size=NumInts;
        %每一层增加一个分割属性，看分割效果如何
        Tree.SplitAttribute2=[];
        Tree.SplitPoint2=[];
        %再增加一个维度的分割属性
        Tree.SplitAttribute3=[];
        Tree.SplitPoint3=[];
        
        %第四维数据
        Tree.SplitAttribute4=[];
        Tree.SplitPoint4=[];
        
        %第五维数据
        Tree.SplitAttribute5=[];
        Tree.SplitPoint5=[];
        
        Tree.FinalPoint=[];
        return;
    else    %说明要继续向下划分结点
        tmp=[1:Parasm.NumDim];
        Tree.NodeStatus=1;
        %随机选取维度
        Tree.SplitAttribute=1+round((Parasm.NumDim-1)*rand(1));
        tmp(Tree.SplitAttribute)=[];
        [~,c]=size(tmp);
        
        %选取与先前寻找的属性不同的属性的属性
        index=round((c-1)*rand(1))+1;
        SplitAttribute=tmp(index);
        

        Tree.SplitAttribute2=SplitAttribute;
        tmp(index)=[];
        [~,c]=size(tmp);
        index=round((c-1)*rand(1))+1;
        Tree.SplitAttribute3=tmp(index);
        
        tmp(index)=[];
        [~,c]=size(tmp);
        index=round((c-1)*rand(1))+1;
        Tree.SplitAttribute4=tmp(index);
        
        tmp(index)=[];
        [~,c]=size(tmp);
        index=round((c-1)*rand(1))+1;
        Tree.SplitAttribute5=tmp(index);
        
        CurData=Data(CurIndex,Tree.SplitAttribute);
        CurData2=Data(CurIndex,Tree.SplitAttribute2);
        CurData3=Data(CurIndex,Tree.SplitAttribute3);
        CurData4=Data(CurIndex,Tree.SplitAttribute4);
        CurData5=Data(CurIndex,Tree.SplitAttribute5);
        
        %随机选取该维度的数据分割点
        mindata=min(CurData);
        maxdata=max(CurData);
        Tree.SplitPoint=mindata+(maxdata-mindata)*rand(1);
        
        
        %随机选取第二个维度的数据
        mindata=min(CurData2);
        maxdata=max(CurData2);
        Tree.SplitPoint2=mindata+(maxdata-mindata)*rand(1);
        
        
        %随机选取第三维的数据
        mindata=min(CurData3);
        maxdata=max(CurData3);
        Tree.SplitPoint3=mindata+(maxdata-mindata)*rand(1);
        
        %随机选取第四维的数据
        mindata=min(CurData4);
        maxdata=max(CurData4);
        Tree.SplitPoint4=mindata+(maxdata-mindata)*rand(1);
        
        
        %随机选取第五维的数据
        mindata=min(CurData5);
        maxdata=max(CurData5);
        Tree.SplitPoint5=mindata+(maxdata-mindata)*rand(1);
        
        tmpnumber=[Tree.SplitPoint Tree.SplitPoint2 Tree.SplitPoint3 Tree.SplitPoint4 Tree.SplitPoint5];
        
        Tree.FinalPoint=norm(tmpnumber);
        
        FinalData=[CurData CurData2 CurData3 CurData4 CurData5];
        
        %利用向量的二范数来进行比较大小
        [r,c]=size(FinalData);
        FinalNum=zeros(r,1);
        for i=1:r
            FinalNum(i)=norm(FinalData(i,:));
        end
        
        mindata=min(FinalNum);
        maxdata=max(FinalNum);
        
%        Tree.UpperLimit=Tree.SplitPoint+(maxdata-mindata);
%        Tree.LowerLimit=Tree.SplitPoint-(maxdata-mindata);
        Tree.UpperLimit=Tree.FinalPoint+(maxdata-mindata);
        Tree.LowerLimit=Tree.FinalPoint-(maxdata-mindata);

        
        %建立右子树和左子树数据
%        Lindex=CurIndex(CurData<Tree.SplitPoint);
%        Rindex=CurIndex(CurData>=Tree.SplitPoint);
        Lindex=CurIndex(FinalNum<Tree.FinalPoint);
        Rindex=CurIndex(FinalNum>=Tree.FinalPoint);
        Tree.LeftChild=BuildTree(Data,Lindex,Curheight+1,Parasm);
        Tree.RightChild=BuildTree(Data,Rindex,Curheight+1,Parasm);
        Tree.size=NumInts;
    end
end


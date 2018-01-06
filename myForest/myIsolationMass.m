%输入：
%Data:表示输入的数据
%CurtIndex:表示每次循环中所需要使用的数据索引
%Tree:进行检验的树
%result:得到的检测评分
%Harmonic：调和级数
%输出：
%result.mass:得到的评价分数
%result.depth;得到的深度

%这种进行测试的方法有别于论文中的方法，主要是每次都处理所有的数据进行递归查深度。
%因为我们建树的过程中有记录树结点的深度，所以只要数据落到结点上，我们就可以得到的数据的异常评分。
%利用减少递归的次数来提高性能


function myIsolationMass(Data,CurtIndex,Tree,result,Harmonic)

%达到叶结点
if Tree.NodeStatus==0
    if Tree.Size<=1
        result.mass(CurtIndex)=Tree.Height;
    else
        c=2*(Harmonic(Tree.Size)-1);
        result.mass(CurtIndex)=Tree.Height+c;
    end
    return;
else
%不在叶结点，需要继续递归分隔数据
%跟训练数据分割一样，进行分割
%    CurtData=Data(CurtIndex,Tree.SplitAttribute);
    CurtData1=Data(CurtIndex,Tree.SplitAttribute);
    CurtData2=Data(CurtIndex,Tree.SplitAttribute2);
    CurtData3=Data(CurtIndex,Tree.SplitAttribute3);
    CurtData4=Data(CurtIndex,Tree.SplitAttribute4);
    CurtData5=Data(CurtIndex,Tree.SplitAttribute5);
    FinalData=[CurtData1 CurtData2 CurtData3 CurtData4 CurtData5];
    [r,c]=size(FinalData);
    CurtData=zeros(r,1);
    for i=1:r
        CurtData(i)=norm(FinalData(i,:));
    end
    
    %左子树数据小于分割点
    LeftCurtIndex=CurtIndex(((CurtData>=Tree.LowerLimit) & (CurtData<Tree.FinalPoint)));
    %右子树的数据大于分割点
    RightCurtIndex=CurtIndex(((CurtData<=Tree.UpperLimit) & (CurtData>=Tree.FinalPoint)));
    
    %进行递归查找
    if ~isempty(LeftCurtIndex)
        myIsolationMass(Data,LeftCurtIndex,Tree.LeftChild,result,Harmonic);
    end
    if ~isempty(RightCurtIndex)
        myIsolationMass(Data,RightCurtIndex,Tree.RightChild,result,Harmonic);
    end
end
    
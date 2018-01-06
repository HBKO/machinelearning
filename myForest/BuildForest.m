%建立孤立森林，利用得到的孤立树的到孤立森林
%输入的参数：m*n的Data数据，行表示样本，n表示维度
%NumTree:需要建立的树木数目
%NumSub:子样本的数目
%rseed:随机种子
%输出的结构体是一个森林，Forest数据结构如下：
%Forest.Trees:孤立树
%Forest.NumTree:树的数目
%Forest.NumSub:训练一棵树所需要的数据量
%Forest.NumDim:数据的维度
%Forest.HeightLimit:高度限制
%Forest.c:a normalization term for possible usage;(用来修正树高的常数)
%Forest.ElapseTime:运行时间。
%Forest.rseed:时间种子

function Forest=BuildForest(Data,NumTree,NumSub,rseed)
    %进行初始化
    [NumInst,NumDim]=size(Data);
    Forest.Trees=cell(NumTree,1);
    
    Forest.NumTree=NumTree;
    Forest.NumSub=NumSub;
    Forest.NumDim=NumDim;
    %假设树是一个尽量平衡的树，不让其退化，这里得到的高度是完全平衡树的理想情况
    Forest.HeightLimit=ceil(log2(NumSub));
    %c控制高度公式：c=2H(NumSub-1)-2(NumSub-1)/NumSub(H为调和级数可以表示为下面的样子)
    Forest.c=2*(log(NumSub-1)+0.5772156649)-2*(NumSub-1)/NumSub;
    et=cputime;
    %设置计算参数
    Paras.HeightLimit=Forest.HeightLimit;
    Paras.NumDim=NumDim;
    
    disp(['Creating IFOREST with t = ',num2str(NumTree),' and \psi = ',num2str(NumSub)]);
    
    %设置时间种子
    rand('state',rseed);
%    AllIndex=[1:NumInst];
%    sample=NumTree*NumSub;
    %循环筛选数据建树
    for i=1:NumTree
        %采用有放回随机
        %原代码是有放回随机
%        if sample>NumInst
            if NumSub < NumInst  %randomly selected sub-samples
                [tmp,SubRand]=sort(rand(1,NumInst));
                IndexSub=SubRand(1:NumSub);
            else
                IndexSub=1:NumInst;
            end
        
        %这里使用无放回随机
%        else
%            [r,c]=size(AllIndex);
%            if NumSub<NumInst % randomly selected sub-samples
%                [tmp,SubRand]=sort(rand(1,c));
%                IndexSub=AllIndex(SubRand(1:NumSub));
%                AllIndex(SubRand(1:NumSub))=[];
%            else
%                IndexSub=1:NumInst;
%            end
  %          disp (c);
 %       end
        
        Paras.IndexDim=1:NumDim;
%        Forest.Trees{i}=TreeNode_iForest(Data,IndexSub,0,Paras);    %build an isolation tree
        Forest.Trees{i}=BuildTree(Data,IndexSub,0,Paras);        %建立孤立树
    end

    Forest.ElapseTime=cputime-et;
end
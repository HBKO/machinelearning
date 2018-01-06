%��������ɭ�֣����õõ��Ĺ������ĵ�����ɭ��
%����Ĳ�����m*n��Data���ݣ��б�ʾ������n��ʾά��
%NumTree:��Ҫ��������ľ��Ŀ
%NumSub:����������Ŀ
%rseed:�������
%����Ľṹ����һ��ɭ�֣�Forest���ݽṹ���£�
%Forest.Trees:������
%Forest.NumTree:������Ŀ
%Forest.NumSub:ѵ��һ��������Ҫ��������
%Forest.NumDim:���ݵ�ά��
%Forest.HeightLimit:�߶�����
%Forest.c:a normalization term for possible usage;(�����������ߵĳ���)
%Forest.ElapseTime:����ʱ�䡣
%Forest.rseed:ʱ������

function Forest=BuildForest(Data,NumTree,NumSub,rseed)
    %���г�ʼ��
    [NumInst,NumDim]=size(Data);
    Forest.Trees=cell(NumTree,1);
    
    Forest.NumTree=NumTree;
    Forest.NumSub=NumSub;
    Forest.NumDim=NumDim;
    %��������һ������ƽ��������������˻�������õ��ĸ߶�����ȫƽ�������������
    Forest.HeightLimit=ceil(log2(NumSub));
    %c���Ƹ߶ȹ�ʽ��c=2H(NumSub-1)-2(NumSub-1)/NumSub(HΪ���ͼ������Ա�ʾΪ���������)
    Forest.c=2*(log(NumSub-1)+0.5772156649)-2*(NumSub-1)/NumSub;
    et=cputime;
    %���ü������
    Paras.HeightLimit=Forest.HeightLimit;
    Paras.NumDim=NumDim;
    
    disp(['Creating IFOREST with t = ',num2str(NumTree),' and \psi = ',num2str(NumSub)]);
    
    %����ʱ������
    rand('state',rseed);
%    AllIndex=[1:NumInst];
%    sample=NumTree*NumSub;
    %ѭ��ɸѡ���ݽ���
    for i=1:NumTree
        %�����зŻ����
        %ԭ�������зŻ����
%        if sample>NumInst
            if NumSub < NumInst  %randomly selected sub-samples
                [tmp,SubRand]=sort(rand(1,NumInst));
                IndexSub=SubRand(1:NumSub);
            else
                IndexSub=1:NumInst;
            end
        
        %����ʹ���޷Ż����
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
        Forest.Trees{i}=BuildTree(Data,IndexSub,0,Paras);        %����������
    end

    Forest.ElapseTime=cputime-et;
end
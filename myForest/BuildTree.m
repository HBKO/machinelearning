
%��������α���뽨��������
%����Ĳ������£�
%α������ֻ��һ��data�������������������Ĳ��������ø��ݹ��õ�
%data:��������ݣ��б�ʾ���������б�ʾ���ݵ�ά��
%CurIndex:��ǰ��Ҫ���õ�������ԭ���ݵ�����
%Curheight:���ڵ�����
%Parasm��ʾһЩ���ƵĲ���
%Parasm.IndexDim: sub-dimension index;
%Parasm.NumDim: #��������ά��
%Param.LimitHeight:��������

%�����Treeʵ������һ�������
%Tree.NodeStatus: 1:inNode, 0:Ҷ�ӽ��
%Tree.SplitAttribute:�������ֵ�ά��
%Tree.SplitPoint:���ֵ�
%Tree.LeftChild:������
%Tree.RightChild:������
%Tree.Size: �ý�������size
%Tree.Height:�ý��ĸ߶�



function  Tree=BuildTree(Data,CurIndex,Curheight,Parasm)
    Tree.Height=Curheight;
    NumInts=length(CurIndex);
    %��ֹ����
    if Tree.Height >= Parasm.HeightLimit ||  NumInts<=1
        Tree.NodeStatus=0;
        Tree.SplitAttribute=[];
        Tree.SplitPoint=[];
        Tree.LeftChild=[];
        Tree.RightChild=[];
        Tree.Size=NumInts;
        %ÿһ������һ���ָ����ԣ����ָ�Ч�����
        Tree.SplitAttribute2=[];
        Tree.SplitPoint2=[];
        %������һ��ά�ȵķָ�����
        Tree.SplitAttribute3=[];
        Tree.SplitPoint3=[];
        
        %����ά����
        Tree.SplitAttribute4=[];
        Tree.SplitPoint4=[];
        
        %����ά����
        Tree.SplitAttribute5=[];
        Tree.SplitPoint5=[];
        
        Tree.FinalPoint=[];
        return;
    else    %˵��Ҫ�������»��ֽ��
        tmp=[1:Parasm.NumDim];
        Tree.NodeStatus=1;
        %���ѡȡά��
        Tree.SplitAttribute=1+round((Parasm.NumDim-1)*rand(1));
        tmp(Tree.SplitAttribute)=[];
        [~,c]=size(tmp);
        
        %ѡȡ����ǰѰ�ҵ����Բ�ͬ�����Ե�����
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
        
        %���ѡȡ��ά�ȵ����ݷָ��
        mindata=min(CurData);
        maxdata=max(CurData);
        Tree.SplitPoint=mindata+(maxdata-mindata)*rand(1);
        
        
        %���ѡȡ�ڶ���ά�ȵ�����
        mindata=min(CurData2);
        maxdata=max(CurData2);
        Tree.SplitPoint2=mindata+(maxdata-mindata)*rand(1);
        
        
        %���ѡȡ����ά������
        mindata=min(CurData3);
        maxdata=max(CurData3);
        Tree.SplitPoint3=mindata+(maxdata-mindata)*rand(1);
        
        %���ѡȡ����ά������
        mindata=min(CurData4);
        maxdata=max(CurData4);
        Tree.SplitPoint4=mindata+(maxdata-mindata)*rand(1);
        
        
        %���ѡȡ����ά������
        mindata=min(CurData5);
        maxdata=max(CurData5);
        Tree.SplitPoint5=mindata+(maxdata-mindata)*rand(1);
        
        tmpnumber=[Tree.SplitPoint Tree.SplitPoint2 Tree.SplitPoint3 Tree.SplitPoint4 Tree.SplitPoint5];
        
        Tree.FinalPoint=norm(tmpnumber);
        
        FinalData=[CurData CurData2 CurData3 CurData4 CurData5];
        
        %���������Ķ����������бȽϴ�С
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

        
        %����������������������
%        Lindex=CurIndex(CurData<Tree.SplitPoint);
%        Rindex=CurIndex(CurData>=Tree.SplitPoint);
        Lindex=CurIndex(FinalNum<Tree.FinalPoint);
        Rindex=CurIndex(FinalNum>=Tree.FinalPoint);
        Tree.LeftChild=BuildTree(Data,Lindex,Curheight+1,Parasm);
        Tree.RightChild=BuildTree(Data,Rindex,Curheight+1,Parasm);
        Tree.size=NumInts;
    end
end


%DecForest������������
%Data:��ʾ���ڹ���������������
%Labels:��ʾ��ǩ
%Attribute:��ʾ���Լ�
%classnumber:n x 1���󣺱�ʾ�������ж������
%Tree:���ɳ�������
%Tree.Attribute:����ڸý�㻮�ֵ�����,0��ʾҶ���
%Tree.NodeStatus:��ʾ�ý�������е�״̬
%Tree.Child����ʾ�ý��ĺ��ӽ��
%1��2����ʾ�ý��ı�ǩ
%0:��ʾ����Ҫ�������·�
function Tree = DecTree( Data,Attribute,Labels,classnumber )

    [m,n]=size(Data);
    flag=0;
    %�Ա�ǩ���м���
    Count=zeros(1,2);
    Count(1,Labels(1,1))=Count(1,Labels(1,1))+1;
    for i=2:m
        if Labels(i)~=Labels(1)
            flag=1;
        end
        Count(1,Labels(i))=Count(1,Labels(i))+1;
    end
    
    %�ж�D������ȫ����ͬһ���C
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
    %���Լ�AΪ�ջ���D����������ֵ��һ��,��ʾΪ���ı�ǩ
    if isempty(Attribute) || flag==0
        Tree.Attribute=0;
        [~,Tree.NodeStatus]=max(Count);
        Tree.NodeStatus=Tree.NodeStatus;
        Tree.Child=[];
        return;
    end
    
    

    %������������
    Index=Ent(Data,Labels,Attribute);
    %��A�еĳ���Index�����޳�
    
    
    tmp=sortrows([Data Labels],Index);
    start=1;finish=1;
    Number=zeros(2,classnumber(1,Index));
    %����������ж��ٸ���ͬ������
    for i=1:m
        Number(1,tmp(i,Index))=Number(1,tmp(i,Index))+1;
        Number(2,tmp(i,Index))=Number(2,tmp(i,Index))+((tmp(i,end))-1);
    end
    finData=cell(classnumber(1,Index));
    
    %�����ݵĸ����ݽ��л��ַ�֧
    for finish=1:m
        if tmp(start,Index)~=tmp(finish,Index)
            finData{1,tmp(start,Index)}=tmp(start:(finish-1),:);
            start=finish;
        end
    end
    %������һ����з���
    finData{1,tmp(finish,Index)}=tmp(start:finish,:);
    
    [~,k]=size(finData);
    
    
    %���Ѿ��ж����Խ����޳�
    [~,cow]=size(Attribute);
    for i=1:cow
        if Attribute(i)==Index
            Attribute(i)=[];
            break;
        end
    end
    
    %���л��������
    for i=1:k
        TmpMatrix=finData{1,i};
        [m,n]=size(TmpMatrix);
        
        %�����ռ���ֱ�����ȡһ����ǩ
        %ѡ����������һ������ǩ
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


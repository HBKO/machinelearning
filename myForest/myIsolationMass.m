%���룺
%Data:��ʾ���������
%CurtIndex:��ʾÿ��ѭ��������Ҫʹ�õ���������
%Tree:���м������
%result:�õ��ļ������
%Harmonic�����ͼ���
%�����
%result.mass:�õ������۷���
%result.depth;�õ������

%���ֽ��в��Եķ����б��������еķ�������Ҫ��ÿ�ζ��������е����ݽ��еݹ����ȡ�
%��Ϊ���ǽ����Ĺ������м�¼��������ȣ�����ֻҪ�����䵽����ϣ����ǾͿ��Եõ������ݵ��쳣���֡�
%���ü��ٵݹ�Ĵ������������


function myIsolationMass(Data,CurtIndex,Tree,result,Harmonic)

%�ﵽҶ���
if Tree.NodeStatus==0
    if Tree.Size<=1
        result.mass(CurtIndex)=Tree.Height;
    else
        c=2*(Harmonic(Tree.Size)-1);
        result.mass(CurtIndex)=Tree.Height+c;
    end
    return;
else
%����Ҷ��㣬��Ҫ�����ݹ�ָ�����
%��ѵ�����ݷָ�һ�������зָ�
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
    
    %����������С�ڷָ��
    LeftCurtIndex=CurtIndex(((CurtData>=Tree.LowerLimit) & (CurtData<Tree.FinalPoint)));
    %�����������ݴ��ڷָ��
    RightCurtIndex=CurtIndex(((CurtData<=Tree.UpperLimit) & (CurtData>=Tree.FinalPoint)));
    
    %���еݹ����
    if ~isempty(LeftCurtIndex)
        myIsolationMass(Data,LeftCurtIndex,Tree.LeftChild,result,Harmonic);
    end
    if ~isempty(RightCurtIndex)
        myIsolationMass(Data,RightCurtIndex,Tree.RightChild,result,Harmonic);
    end
end
    
%���þ�����������֤��֤���Ľ��
%���ݣ�Tree�����ľ�����
%data:��ʾ��������
function res=DecEstimation(Tree,data)
    if Tree.NodeStatus~=0
        res=Tree.NodeStatus;
        return;
    else
        Attribute=Tree.Attribute;
        res=DecEstimation(Tree.Child{data(1,Attribute)},data);
    end
end

        
%����������isolation���е����
%���������
%instance:���в��Ե�һ�����ӣ�Treeѵ��������hlim�߶�����
%������ݣ�
%mass��ʾ���ݵ�һ���쳣�÷�

function pathlength(instance,Tree,hlim)
global mass;
    if Tree.NodeStatus==0 || Tree.Height>=hlim
        if Tree.Size<=1
            mass=Tree.Height;
        else
            c=2*(harmonic(Tree.Size)-1);
            mass=c+Tree.Height;
        end
        return;
    else
        SplitAtt=Tree.SplitAttribute;
        if instance(SplitAtt)<Tree.SplitPoint
            pathlength(instance,Tree.LeftChild,hlim);
        else
            pathlength(instance,Tree.RightChild,hlim);
        end
    end
end


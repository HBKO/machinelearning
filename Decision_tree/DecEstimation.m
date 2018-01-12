%利用决策树进行验证验证集的结果
%数据：Tree构建的决策树
%data:表示测试数据
function res=DecEstimation(Tree,data)
    if Tree.NodeStatus~=0
        res=Tree.NodeStatus;
        return;
    else
        Attribute=Tree.Attribute;
        res=DecEstimation(Tree.Child{data(1,Attribute)},data);
    end
end

        
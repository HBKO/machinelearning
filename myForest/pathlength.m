%测试数据在isolation树中的深度
%输入参数：
%instance:进行测试的一个例子，Tree训练的树，hlim高度限制
%输出数据：
%mass表示数据的一个异常得分

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


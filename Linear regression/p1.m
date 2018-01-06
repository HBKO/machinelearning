%计算p1的值，用到后面的牛顿迭代公式
%输入：x表示数据:m*n m表示数据量，n表示维度。
%beta表示对数回归的参数：[w1 w2 w3 b]


function res = p1( X,beta )
    res=(exp(beta*X'))/(1+exp(beta*X'));
end


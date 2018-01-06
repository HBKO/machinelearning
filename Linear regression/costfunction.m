%costfunction相当于目标函数
%使用一阶的梯度下降
%输入：X表示输入的数据集:m*n(m表示数据量，n表示维数),y表示所带的标签(m*1:m表示数据量),beta表示逻辑回归的参数[w;b]
%输出：函数的输出值
function [jVal,gradient]=costfunction(X,y,beta)
    jVal=0;
    %设置梯度
    grad=zeros(size(beta));
    h=1.0./(1.0+exp(-1*X*beta));
    m=size(y,1);
    %目标函数
    jVal=((-1*y)'*log(h)-(1-y)'*log(1-h))/m;
    for i=1:size(beta,1)
        gradient(i)=((h-y)'*X(:,i))/m; %使用梯度下降方法
    end
end
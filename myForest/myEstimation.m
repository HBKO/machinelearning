%将测试集放入估计函数中进行估计
function [Mass,ElapseTime]=myEstimation(TestData,Forest)

NumInst=size(TestData,1);
Mass=zeros(NumInst,Forest.NumTree);
Harmonic=GetHarmonicSeries(Forest.NumSub);


et=cputime;
for k=1:Forest.NumTree
    result=Result_iForest(NumInst);
    myIsolationMass(TestData,1:NumInst,Forest.Trees{k,1},result,Harmonic);
    Mass(:,k)=result.mass;
end
ElapseTime=cputime-et;
end


function Harmonic=GetHarmonicSeries(NumSub)
    Harmonic=zeros(NumSub,1);
    Harmonic(1)=1;
    
    for i=2:NumSub
        Harmonic(i)=Harmonic(i-1)+1/i;
    end
end
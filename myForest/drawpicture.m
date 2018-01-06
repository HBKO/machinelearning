%»æÖÆAUCÇúÏßÍ¼
x=[2,3,4,5];
breastw=[0.97665 0.97318 0.97389 0.96457];
http=[2;0.98809];
shuttle=[0.9921 0.98623 0.98025 0.97415];


hold on 
xlabel('the number of dimensions');
ylabel('AUC performance');
plot(x,breastw);
plot(x,shuttle);
scatter(2,0.98809);
legend('breastw','shuttle','http');
hold off

plotly();

clear all; clc;

Ntrain = 20;

fun = @(x) sin(x.^2);

xtrain = 100;%dummy value %useless
ytrain = 0;

xtest = linspace(0,pi,200)';
ytest = fun(xtest);

hyps.l = 0.2;
hyps.sf = 1;
hyps.sn = 0.1;

yGP = zeros(200,1);
ystd = 2*ones(200,1);
ystd_neg = -2*ones(200,1);


opt.fname = 'GP_0';
data2txt(opt, xtrain,ytrain,xtest,ytest,yGP, ystd,ystd_neg);

for i=1:Ntrain
    xtrain = [xtrain;pi*rand(1,1)];
    ytrain = [ytrain;fun(xtrain(end))+0.1*randn(1,1)];
    
    gp = fitrgp(xtrain,ytrain','FitMethod','none','Sigma',hyps.sn,'KernelParameters',[hyps.l;hyps.sf]);
    [yGP,std]=gp.predict(xtest);
    ystd=yGP+2*std;
    ystd_neg=yGP-2*std;
    
    opt.fname = ['GP_',num2str(i)];
    data2txt(opt,xtrain,ytrain,xtest,ytest,yGP, ystd,ystd_neg);
    
end

plot(xtest,ytest);
hold on;
plot(xtrain,ytrain,'*')
plot(xtest,yGP);
plot(xtest,ystd);
plot(xtest,ystd_neg);

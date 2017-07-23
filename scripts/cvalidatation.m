samples_per_digit=50;
block_sze=samples_per_digit/K;
for fold =1:K
    test_ind = 1+(fold-1)*block_sze:fold*block_sze;
    train_ind = [1:(fold-1)*block_sze, (fold*block_sze+1):samples_per_digit];

    for i=0:9
        train=x(train_ind+i*samples_per_digit,:,:);
        test=x(test_ind+i*samples_per_digit,:,:);
        % Perform training and validation in here for this fold of the digit i

        
    end
    
end    




X_train =
X_test = 
Y_train = 
Y_test = 
%cross validation with plot
c = cvpartition(sp,'k',3);
classifier = @(X_train, Y_train,X_test)(SMGI(X_test,X_train,Y_train));
MCR = crossval('mcr',LC,sp,'predfun',classifier,'partition',c);


indices = crossvalind('Kfold',sp,3);
cp = classperf(sp);
for i = 1:3
    test = (indices == i); train = ~test;
    
    class = SMGI(LC(test,:), LC{1,1}(train,:), sp(train,:));
    %class = classify(meas(test,:),meas(train,:),species(train,:));
    classperf(cp,class,test)
end
cp.ErrorRate







cve = fitensemble(connectedlaplacian,sp,'Bag',100,'Tree',...
    'type','classification','kfold',5)

figure;
plot(loss(cve,X_test,Y_test,'mode','cumulative'));
hold on;
figure;
plot(kfoldLoss(cve,'mode','cumulative'),'r.');
hold off;
xlabel('Network classes');
ylabel('Model Classification error');
legend('Test','Cross-validation','Label','Network');



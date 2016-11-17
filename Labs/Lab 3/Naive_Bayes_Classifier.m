%% Pergunta 1

gscatter(xtrain(1,:), xtrain(2,:), dtrain,'rgb','osd');
figure;
gscatter(xtest(1,:), xtest(2,:), dtest,'rgb','osd');

%% Pergunta 2

Classifier = fitNaiveBayes(xtrain',dtrain');

P1 = Classifier.predict(xtrain');
cMat1 = confusionmat(dtrain',P1)

P2 = Classifier.predict(xtest');
cMat2 = confusionmat(dtrain',P2)

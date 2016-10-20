function print_confusion_matrix(nndata, input, desired)
%
% Print the confusion matrix for the 5x5 digits


npatterns = size(desired,2);
nclasses = size(desired,1);

if(nclasses  < 2)
  disp('CONFUSION MATRIX: the network needs to have at least two outputs.');
  return;
end

[desiredclass,~] = find(desired > 0);     % 'desiredclass' contains the desired class

nndata = forward(nndata, input);
[~,netclass] = max(nndata.layer{end}.outputactivation);    % 'netclass' contains the class found by the network

netclass = netclass';

confusion = zeros(nclasses, nclasses+1);
for i=1:npatterns
  confusion(desiredclass(i), netclass(i)) = confusion(desiredclass(i), netclass(i)) + 1;
end

for i=1:nclasses
  confusion(i, nclasses+1) = round(confusion(i,i) / sum(confusion(i,1:nclasses)) * 100);
end

disp('---------------------------------------------------------------------------------------------------------------------------');
disp('Confusion matrix. The last column indicates the percentage of correct classifications for the corresponding desired pattern');
disp('---------------------------------------------------------------------------------------------------------------------------');
disp(confusion);

fprintf('Percentage of correct classifications: %5.2f%%\n\n', 100 * sum(diag(confusion)) / sum(sum(confusion(:,1:nclasses))));

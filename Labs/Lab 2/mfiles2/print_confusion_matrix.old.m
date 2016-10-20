function print_confusion_matrix(nndata, input, desired)
  if(size(input,1)~=25)
    disp('CONFUSION MATRIX: incorrect input data size');
    return;
  end
  
  if(size(desired,1)~=10)
    disp('CONFUSION MATRIX: incorrect ouput data size');
    return;
  end
  
  [desired,j]=find(desired>0);
  
  
  nndata=forward(nndata, input);
  [i,output]=max(nndata.layer{end}.outputactivation);
  
  output=output';
  
  confusion=zeros(10,11);
  for i=1:length(output)
    confusion(desired(i),output(i))=confusion(desired(i),output(i))+1;
  end
  
  for i=1:10
    confusion(i,11)=round(confusion(i,i)/sum(confusion(i,1:10))*100);
  end
  
  disp('---------------------------------------------------------------------------------------------------------------------------');
  disp('Confusion matrix. The last column indicates the percentage of correct classifications for the corresponding desired pattern');
  disp('---------------------------------------------------------------------------------------------------------------------------');
  disp(confusion);
  
  disp(sprintf('Percentage of correct classifications: %5.2f%%\n', 100*sum(diag(confusion))/sum(sum(confusion(:,1:10)))));
  
  
  
  

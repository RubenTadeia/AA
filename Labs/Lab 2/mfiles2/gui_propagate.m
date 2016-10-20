function [input, desired_output]=gui_propagate(n, typ)
  % n indicates how far we need to go. n=0 get only the input and desired output; n=1 propagate input
  %
  % typ indicates the type of input: 'training', 'validation' or 'test'. The default (i.e., if typ not supplied) is 'training'.
  global NNDATA

  if(nargin<2)
    typ='training';
  end
  

  input=[];
  desired_output=[];
  switch typ
    case 'training'
      input_data = gui_interpret_input(NNDATA.gui.input.training);
    case 'validation'
      input_data = gui_interpret_input(NNDATA.gui.input.validation);
    case 'test'
      input_data = gui_interpret_input(NNDATA.gui.input.test);
    otherwise
      input_data = [];
  end
  
  if(isempty(input_data))            %check if interpret_input succeeded 
    errordlg([ typ ' data unknown'],'Error','modal');
    return;
  end
  
  %now need to check if dimensions are correct
  if(size(input_data,1)~=NNDATA.ninputs+NNDATA.layer{end}.nunits)
    errordlg([typ ' data size is not correct'],'Error','modal');
    return;
  end

  
  input=input_data(1:NNDATA.ninputs,:);
  desired_output=input_data(1+NNDATA.ninputs:end,:);

  input=normalize(input,NNDATA.gui.input.normalize); %if normalize's range is not given nothing is done
  desired_output=normalize(desired_output,NNDATA.gui.input.normalize); 
  
  
  if n<1
    return 
  end
  
  NNDATA=forward(NNDATA, input);
  
  return

function [value, typ]=gui_interpret_input(input)
  %given an input string interpret it's meaning.
  %currently it can be direct input (i.e. a matrix), a matlab variable, any matlab expression, or a file.
  %typ returns what type of data it is
  
  value=[];
  typ='unknown';

  if(isstruct(input)) %used to allow input of a saved neural net to neural_gui
    typ='struct';
    value=input;
    return
  end

  try
    value=evalin('base', input)'; %matlab expressions will be dealt with in the base workspace
    %    disp('Input is a matlab expression');
    typ='matlab';
  catch %anything goes wrong need to check if it's other types of input
  end  
  
  try
    value=load(input)';
    typ=input;
  catch
  end
    
  

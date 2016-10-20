function output=normalize(input, range)
  
  if(isempty(range))
    output=input;
    return
  end
  
  n_min=min(range);
  n_max=max(range);
  
  input_max=max(max(input));
  input_min=min(min(input));
  output=(input-input_min)/(input_max-input_min); %between 0 and 1
  output=output*(n_max-n_min)+n_min; %between n_min e n_max
  
  




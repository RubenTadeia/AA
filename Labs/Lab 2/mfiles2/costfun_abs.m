function result=costfun_abs(output, desired, typ)

switch typ
  case 'direct',
    error = output - desired;
    result = sum(sum(abs(error))) / (size(error,1) * size(error,2));
  case 'feedback',
    error = output - desired;
    result = sign(error) / (size(error,1) * size(error,2));
  case 'configure',
    % This cost function does not have options. This part is to be used by configurable error criteria.
    % For example, using the dual slope cost function needs to select slopes.
    result = [];
  case 'description',
    result = 'absolute error';
  case 'graph',
    x = -1:.1:1;
    y = abs(x);
    result = [x;y];
end


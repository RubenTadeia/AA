function result = costfun_sigmoid(output, desired, typ)
%
% Cost function appropriate for binary classification. For one of the classes, 'desired' should be positive, and for the other one it should be
% negative.

persistent factor

stabf = 0; %1e-5;        % Stabilization factor

switch typ
 case 'direct',
  result = sum(sum(comp_sigmoid(output, desired, factor, stabf))) / (size(output,1) * size(output,2));
 case 'feedback',
  result = comp_sigmoid_deriv(output, desired, factor, stabf) / (size(output,1) * size(output,2));
 case 'configure',
  factor = gui_configure_costfun_sigmoid(factor);
  result = factor;                  
 case 'description',
  result= 'sigmoid';
 case 'graph',
  x = -1:.01:1;
  desired = ones(size(x));
  y = comp_sigmoid(x, desired, 3*factor, stabf);
  
  y = y / max(max(y));
  
  result = [x;y];
end

function y = comp_sigmoid(output, desired, factor, stabf)
sgnd = sign(desired);
y = 1 ./ (1 + exp(factor * sgnd .* output)) + stabf * factor * (output + 1.275 * sgnd).^2;    % The quadratic term is for stabilization

function y = comp_sigmoid_deriv(output, desired, factor, stabf)
sgnd = sign(desired);
exponential = exp(factor * sgnd .* output);
if isfinite(exponential)
  y = -factor * sgnd .* exponential ./ (1 + exponential).^2 + stabf * factor * (output + 1.275 * sgnd);
else
  y = 0;
end



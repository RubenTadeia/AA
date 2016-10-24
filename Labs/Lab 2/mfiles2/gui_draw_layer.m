function gui_draw_layer(pos, params)
  %draws a neuron layer on screen
  %if typ is given with a known activation function name, a representation will be shown

  x=pos(1);
  y=pos(2);
  width=pos(3);
  height=pos(4);

  color='y';
  if(isempty(call_afun(params.typ,0, 'deriv')))
    color=[1 .8 0];
  end
  patch([x x x+width x+width],[y y+height y+height y], color);
  
  text(x+width/4, y+height/9, 'layer');
  
  
  if(nargin>1)
    
    text(x+width/2, y+17/20*height, num2str(params.nunits)); %show number of elements
    
    result=call_afun(params.typ,[], 'graph');
    description=call_afun(params.typ,[], 'description');
    
    s=result(1,:);
    t=result(2,:);
    
    s=width/4*s;
    t=-height/8*t; %scale
    
    hold on
    plot(s+x+width/2,t+y+height/2,'r');
    text(x+width/4, y+height/2, description); %show description of activation function
    hold off
    
  end
  
  

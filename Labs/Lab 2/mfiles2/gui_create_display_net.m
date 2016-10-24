function display_net=gui_create_display_net(nndata)
  %given a neural network structure, creates a structure holding it's display information
  %display information holds an array with (an entry per line):
  %      x,y,width,height, type, num 
  %
  %      x,y,width,height hold where the element will be drawn on screen
  %      type can be: 0 - layer, 1 - synapse, 2 - input layer, ...
  %      num: the number of the layer/synapse/input/... element

  num.layer=length(nndata.layer); 
  
  display_net=zeros(3+num.layer+num.layer,6); %pre-allocate memory (input.layer+synapses)
  
  layer_spacing=50;
  layer_width=50;
  layer_height=100;
  
  %create the.layer
  display_net(1:num.layer,:)=[[1:num.layer]'*(layer_spacing+layer_width) ...
                              repmat([0 layer_width layer_height 0 ], num.layer,1) ...
                              [1:num.layer]'];
                              
  %create the synapses
  display_net(num.layer+1:2*num.layer,:)=[[1:num.layer]'*(layer_spacing+layer_width)-layer_spacing ...
                                           repmat([0 layer_spacing layer_height 1], num.layer,1) ...
                                           [1:num.layer]'];
  %add the input layer
  display_net(end-2,:)=[0, 0, layer_width, layer_height, 2, 1];
  
  %add the error indicator
  display_net(end-1,:)=[num.layer*(layer_spacing+layer_width)+layer_width+layer_spacing/2 0, layer_width, layer_height, 3, 1];

  %add the training 
  display_net(end,:)=[num.layer*(layer_spacing+layer_width)+2*layer_width+layer_spacing/2 0, layer_width, layer_height, 4, 1];
  
  
  %add a small offset to all x,y values
  display_net(:,1)=display_net(:,1)+20;
  display_net(:,2)=display_net(:,2)+20;
  
  

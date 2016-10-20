function gui_draw_display_net(nndata)
  %draws the display net on the currently visible axis
  
  cla
  
  display_net=nndata.gui.display_net;
  
  num_objs=size(display_net,1); %number of objects to draw
  
  for i=1:num_objs %for each object, draw appropriate symbol
    switch display_net(i,5)
      case 0 %layer
        params.typ=nndata.layer{display_net(i,6)}.afun;
        params.nunits=nndata.layer{display_net(i,6)}.nunits;
        gui_draw_layer(display_net(i,1:4),params)
      case 1 %synapse
        gui_draw_synapse(display_net(i,1:4))
      case 2 %input
        [data, params.typ]=gui_interpret_input(nndata.gui.input.training);
        
        params.ninputs=nndata.ninputs;
        params.noutputs=nndata.layer{end}.nunits;
        
        gui_draw_input_layer(display_net(i,1:4),params);
      case 3 %error
        gui_draw_error_criterion(display_net(i,1:4))
      case 4 %training
        params.typ=nndata.train.costfun;
        gui_draw_training(display_net(i,1:4),params);
      otherwise
        disp('can not draw unknown display net element');
    end      
  end
  
  %disable line hit test so button presses can be caught in the axes
  objects=allchild(gca);
  set(objects,'HitTest','off');

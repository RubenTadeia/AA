function obj=gui_find_clicked_object(nndata, pos)
  %given a position on screen return the object(s) there. 

  display_net=nndata.gui.display_net;

  if(isempty(display_net))
    obj=[];
    return
  end
    
  indexes=find((display_net(:,1)<pos(1)) & ...
               (display_net(:,2)<pos(2)) & ...
               (display_net(:,1)+display_net(:,3)>pos(1))& ...
               (display_net(:,2)+display_net(:,4)>pos(2)));
               
  %return only object type and number for each object found
  obj=display_net(indexes,5:6);

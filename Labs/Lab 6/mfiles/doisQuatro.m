%Visualização dos dois primeiros
% componentes no espaço 2D com base
% definida pelos dois primeiros vectores
% próprios e centrada na média
pc12=pc(1:2,:);
figure;
scatter(pc12(1,:),pc12(2,:));
% Rescontrução com os dois primeiros
% componentes
xr12=v(:,1:2)*pc(1:2,:)
mean(x,2)*ones(1,size(x,2));
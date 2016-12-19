pc=zeros(size(x));
for i=1:20
pc(i,:)=v(:,i)'*cx
end
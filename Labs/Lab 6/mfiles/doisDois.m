pc=zeros(size(x));
for i=1:n
pc(i,:)=v(:,i)'*cx;
end
function [input,desired]=build_picture(data)

image_size=14; %images will be 14x14

input=reshape(data(5,:),image_size,image_size);
desired=reshape(data(10,:),image_size,image_size);






% cmap.m  ver 1.0  by Tom Irvine

function[cmap]=cmap_colors_alt(n)

cmap(1,:)=[0 0.1 0.4];  % dark blue
cmap(2,:)=[0.8 0 0];% red
cmap(3,:)=[0 0 0];  % black
cmap(4,:)=[0.6 0.3 0];  % brown
cmap(5,:)=[0 0.5 0.5];  % teal
cmap(6,:)=[1 0.5 0];% orange
cmap(7,:)=[0.5 0.5 0];  % olive
cmap(8,:)=[0.13 0.55 0.13]; % forest green  
cmap(9,:)=[0.5 0 0];% maroon
cmap(10,:)=[0.5 0.5 0.5 ];  % grey
cmap(11,:)=[1. 0.4 0.4];% pink-orange
cmap(12,:)=[0.5 0.5 1]; % lavender
cmap(13,:)=[0.05 0.7 1.];   % light blue
cmap(14,:)=[0  0.8 0.4 ];   % green
cmap(15,:)=[1 0.84 0];  % gold
cmap(16,:)=[0 0.8 0.8]; % turquoise 

rng(1);

for i=17:n
    cmap(i,:)=[rand() rand() rand()];
end    
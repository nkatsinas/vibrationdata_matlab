cmap(1,:)=[0 0.1 0.4];        % dark blue
cmap(2,:)=[0.8 0 0];        % red
cmap(3,:)=[0 0 0];          % black
cmap(4,:)=[0.6 0.3 0];      % brown
cmap(5,:)=[0 0.5 0.5];      % teal
cmap(6,:)=[1 0.5 0];        % orange
cmap(7,:)=[0.5 0.5 0];      % olive
cmap(8,:)=[0.13 0.55 0.13]; % forest green  
cmap(9,:)=[0.5 0 0];        % maroon
cmap(10,:)=[0.5 0.5 0.5 ];  % grey
cmap(11,:)=[1. 0.4 0.4];    % pink-orange
cmap(12,:)=[0.5 0.5 1];     % lavender
cmap(13,:)=[0.05 0.7 1.];   % light blue
cmap(14,:)=[0  0.8 0.4 ];   % green
cmap(15,:)=[1 0.84 0];      % gold
cmap(16,:)=[0 0.8 0.8];     % turquoise   

clc; 
axes(handles.axes1);
x=[-4 -4 4 4 -4];
y=[4 7 7 4 4]+1;

plot(x,y,'Color',cmap(1,:),'linewidth',0.75);
hold on;
x=[-5 5];
y=[ 1 1];
plot(x,y,'Color','k','linewidth',0.75);
y=[0.5 1];
x=[-0.7 0];
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]-1.4;
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]-2.8;
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]-4.2;
plot(x,y,'Color','k','linewidth',0.75);
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]+1.4;
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]+2.8;
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]+4.2;
plot(x,y,'Color','k','linewidth',0.75);

text(-0.9,6.5,'m','fontsize',11);
text(-3.5,3,'k','fontsize',11);

nn=2000;

dt=4/(nn-1);

t=zeros(nn,1);
for i=1:nn
    t(i)=(i-1)*dt;
end
t=t-0.75;
y=sawtooth(2*pi*t,0.5);
y1=y;

t=3*t/(max(t)-min(t));

plot(y,t+2,'Color',cmap(5,:),'linewidth',0.75);
x=[0 0];
y=[1 1.5];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);


x=[0 0];
y=[max(t)+2 5];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);

hold off;
grid on;
set(gca,'XTick',[], 'YTick', [])
xlim([-10 10]);
ylim([0 10]);

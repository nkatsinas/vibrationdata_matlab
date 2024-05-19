        
n=500;


for i=1:501
   hw(i,1)=i; 
   hw(i,2)=sin( ((i-1)*pi/n) )^2 ;
end        

hw(:,1)=hw(:,1)/hw(end,1);

figure(10);
plot(hw(:,1),hw(:,2),'linewidth',0.8);
xlabel('Time');
ylabel('w(t)');

ylim([0 1.1]);

xtt=[0 0.5 1 ];
xTT={'0';'T/2';'T'};

    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    
    grid on;
    
%   title('Hanning Window  w(t) = 1 - [ cos (\pi t / T) ]^2');
   
   title('Hanning Window  w(t)');
   
try
   
    FS='sine9p5';
    THM=evalin('base',FS);
    disp(' FS read');
catch
     disp(' FS not read');
end
   
try
    sz=size(THM);
    n=sz(1);
    
    for i=1:n
       THM(i,2)=THM(i,2)*sin( ((i-1)*pi/n) )^2;  
    end
    
    THM(:,2)=THM(:,2)*sqrt(8/3);
    
    figure(11);
    plot(THM(:,1),THM(:,2),'linewidth',0.8);
    xlabel('Time (sec)');
    ylabel('Accel (G)');
    title('y(t) = 1.0 sin (2\pi t)   with Compensated Hanning Window');
    grid on;
    xlim([0 9.5]);
    
catch
end



M1_Q=[BET.pm4.time BET.pm4.aero.est.Qinf];
M1_Mach=[BET.pm4.time BET.pm4.aero.est.Minf];


figure(17);
plot(M1_Mach(:,1),M1_Mach(:,2));
grid on;


sz=size(M1_Mach);

n=sz(1);

ratio1=zeros(n,1);
ratio2=zeros(n,1);


for i=1:n
    ratio1(i)=M1_Q(i,2)/(1+0.13*M1_Mach(i,2)^2);
    ratio2(i)=M1_Q(i,2)/(1+M1_Mach(i,2)^2);
end


M1_ratio1=[BET.pm4.time  ratio1 ];
M1_ratio2=[BET.pm4.time  ratio2 ];


[~,kk]=min(abs(BET.pm4.time-385));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


figure(101);

   yyaxis left
    plot(M1_Q(1:kk,1),M1_Q(1:kk,2),M1_ratio1(1:kk,1),M1_ratio1(1:kk,2),M1_ratio2(1:kk,1),M1_ratio2(1:kk,2));
    ttt='NS M1 AC-6318 Fwd Ring Frame Descent';
    title(ttt);
    ylabel('Q Parameter (psf)');
    
    grid on;

    yyaxis right
    plot(M1_AC_6318_RMS(:,1),M1_AC_6318_RMS(:,2));
    ylabel('Accel (GRMS)');
    grid on;
    xlabel('Time (sec)');
    legend('Q','Q/(1+0.13*M^2)','Q/(1+M^2)','GRMS');
    xlim([340 400]);
    
    ttt=strrep(ttt,'-','_');
    ttt=strrep(ttt,' ','_');
    ttt=sprintf('%s.fig',ttt);
    savefig(ttt)
    

 
    p1=M1_Q;
    p2=M1_ratio1;
    p3=M1_ratio2;
    p4= M1_AC_6318_RMS;
    ttt='NS M1 AC-6318 Fwd Ring Frame Descent Supersonic';
    t1=340;
    t2=400;

     fig_num=102;
[fig_num]=plot_core(fig_num,p1,p2,p3,p4,ttt,t1,t2);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    function[p]=adjust(p,t1,t2)
    
       [~,i]=min(abs(p(:,1)-t1));
       [~,j]=min(abs(p(:,1)-t2));
       p=p(i:j,:);
       p(:,2)=p(:,2)/max(abs(p(:,2)));
        
    end    
    
function[fig_num]=plot_core(fig_num,p1,p2,p3,p4,ttt,t1,t2)
    
cmap(1,:)=[0 0 0.8];        % dark blue
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
    
        [p1]=adjust(p1,t1,t2); 
        [p2]=adjust(p2,t1,t2);        
        [p3]=adjust(p3,t1,t2); 
        [p4]=adjust(p4,t1,t2);         
         
  
        
        h2=figure(fig_num);
        fig_num=fig_num+1;
       
        hold on;
        plot(p1(:,1),p1(:,2),'Color',cmap(1,:),'DisplayName','Q');
        plot(p2(:,1),p2(:,2),'Color',cmap(2,:),'DisplayName','Q/(1+0.13*M^2)');
        plot(p3(:,1),p3(:,2),'Color',cmap(3,:),'DisplayName','Q/(1+M^2)');
        plot(p4(:,1),p4(:,2),'Color',cmap(4,:),'DisplayName','GRMS');
        legend('Q','Q/(1+0.13*M^2)','Q/(1+M^2)','GRMS')
  
        legend('location','eastoutside')
        set(h2, 'Position', [0 0 1400 900]);
        set(gca,'Fontsize',20);
        
        title(ttt);
        ylabel('Value');
        grid on;
        xlabel('Time (sec)');
        
        try
            xlim([350 410]);
        catch
        end
        
        ylim([0 1.2]);
    
    
        ttt=strrep(ttt,'-','_');
        ttt=strrep(ttt,' ','_');
        ttt=sprintf('%s.fig',ttt);
        savefig(ttt)
        
        pname=sprintf('f%d.bmp',fig_num-1);
        print(h2,pname,'-dbmp','-r300');
        
        pname=sprintf('f%d.emf',fig_num-1);
        print(h2,pname,'-dmeta','-r300');
        
        hold off;
    
    end
    
    
    
    
        
    



try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end    


    fig_num=1;

    
M4=[358	403];
M5=[351	396];	
M6=[362	407];	
M7=[348	393];	
M8=[359	404];	
M9=[358	403];	
P7=[360	405];	
P8=[359	404];

    
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 	
 
    t1=M7(1);
    t2=M7(2);
    
    
    p1=M7_pm4_Q;
    p2=M7_ds_ratio1;
    p3=M7_ds_ratio2;
    p4=M7_AC_6319_th_bessel_20Hz_RMS;
    ttt='NS M7 AC-6319 Fwd Fin Box Descent Supersonic, Normalized';
    
    [fig_num]=plot_core(fig_num,p1,p2,p3,p4,ttt,t1,t2);
    
   
    
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
    t1=M8(1);
    t2=M8(2);
 
    p1=M8_pm4_Q;
    p2=M8_ds_ratio1;
    p3=M8_ds_ratio2;
    p4=M8_AC_6319_th_bessel_20Hz_RMS;
    ttt='NS M8 AC-6319 Fwd Fin Box Descent Supersonic, Normalized';
        [fig_num]=plot_core(fig_num,p1,p2,p3,p4,ttt,t1,t2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    t1=M9(1);
    t2=M9(2);

    p1=M9_pm4_Q;
    p2=M9_ds_ratio1;
    p3=M9_ds_ratio2;
    p4=M9_AC_6319_th_bessel_20Hz_RMS;
    ttt='NS M9 AC-6319 Fwd Fin Box Descent Supersonic, Normalized';
        [fig_num]=plot_core(fig_num,p1,p2,p3,p4,ttt,t1,t2);
  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
    t1=P7(1);
    t2=P7(2);

    p1=P7_pm4_Q;
    p2=P7_ds_ratio1;
    p3=P7_ds_ratio2;
    p4=P7_AC_6319_th_bessel_20Hz_RMS;
    ttt='NS P7 AC-6319 Fwd Fin Box Descent Supersonic, Normalized';
        [fig_num]=plot_core(fig_num,p1,p2,p3,p4,ttt,t1,t2);
   
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    t1=P8(1);
    t2=P8(2);

    p1=P8_pm4_Q;
    p2=P8_ds_ratio1;
    p3=P8_ds_ratio2;
    p4=P8_AC_6319_th_bessel_20Hz_RMS;
  ttt='NS P8 AC-6319 Fwd Fin Box Descent Supersonic, Normalized';
      [fig_num]=plot_core(fig_num,p1,p2,p3,p4,ttt,t1,t2);
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     
    t1=M4(1);
    t2=M4(2);

    p1=M4_pm4_Q;
    p2=M4_ds_ratio1;
    p3=M4_ds_ratio2;
    p4=M4_AC_6310_th_bessel_20Hz_RMS;
    ttt='NS M4 AC-6310 Fwd Fin Box Descent Supersonic, Normalized';
     [fig_num]=plot_core(fig_num,p1,p2,p3,p4,ttt,t1,t2);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    t1=M5(1);
    t2=M5(2);

    p1=M5_pm4_Q;
    p2=M5_ds_ratio1;
    p3=M5_ds_ratio2;
    p4=M5_AC_6310_th_bessel_20Hz_RMS;
    ttt='NS M5 AC-6310 Fwd Fin Box Descent Supersonic, Normalized';
        [fig_num]=plot_core(fig_num,p1,p2,p3,p4,ttt,t1,t2);
    
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    t1=M5(1);
    t2=M5(2);
 
    p1=M5_pm4_Q;
    p2=M5_ds_ratio1;
    p3=M5_ds_ratio2;
    p4=M5_AC_6322_th_bessel_20Hz_RMS;
    ttt='NS M5 AC-6322 Fwd Fin Ring Frame Valve Base Descent Supersonic, Normalized';
       [fig_num]=plot_core(fig_num,p1,p2,p3,p4,ttt,t1,t2);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 
    t1=M6(1);
    t2=M6(2);

    p1=M6_pm4_Q;
    p2=M6_ds_ratio1;
    p3=M6_ds_ratio2;
    p4=M6_AC_6322_th_bessel_20Hz_RMS;
    ttt='NS M6 AC-6322 Fwd Fin Ring Frame Valve Base Descent Supersonic, Normalized';
       [fig_num]=plot_core(fig_num,p1,p2,p3,p4,ttt,t1,t2);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  
    t1=M4(1);
    t2=M4(2);

    p1=M4_pm4_Q;
    p2=M4_ds_ratio1;
    p3=M4_ds_ratio2;
    p4=M4_AC_6320_th_bessel_20Hz_RMS;
    ttt='NS M4 AC-6320 Fwd Ring Frame OML Descent Supersonic, Normalized';
        [fig_num]=plot_core(fig_num,p1,p2,p3,p4,ttt,t1,t2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   
    t1=M5(1);
    t2=M5(2);

    p1=M5_pm4_Q;
    p2=M5_ds_ratio1;
    p3=M5_ds_ratio2;
    p4=M5_AC_6320_th_bessel_20Hz_RMS;
    ttt='NS M5 AC-6320 Fwd Ring Frame OML Descent Supersonic, Normalized';
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
        ttt=strrep(ttt,',','_');
        ttt=sprintf('%s.fig',ttt);
        savefig(ttt)
        
        pname=sprintf('f%d.bmp',fig_num-1);
        print(h2,pname,'-dbmp','-r300');
        
        pname=sprintf('f%d.emf',fig_num-1);
        print(h2,pname,'-dmeta','-r300');
        
        hold off;
    
    end
    
    
    
    
    
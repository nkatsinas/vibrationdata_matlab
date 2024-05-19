

try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end    

t1=20;
t2=120;

fig_num=1;

ttt='NS M7 AC-6319 Fwd Fin Box Ascent';
THM=M7_AC_6319_th_bessel_20Hz_RMS;
Q=M7_ns4_Q;
ratio1=M7_ratio1;
ratio2=M7_ratio2;
[fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
ttt='NS M8 AC-6319 Fwd Fin Box Ascent';
THM=M8_AC_6319_th_bessel_20Hz_RMS;
Q=M8_ns4_Q;
ratio1=M8_ratio1;
ratio2=M8_ratio2;
[fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM);
       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ttt='NS M9 AC-6319 Fwd Fin Box Ascent';
THM=M9_AC_6319_th_bessel_20Hz_RMS;
Q=M9_ns4_Q;
ratio1=M9_ratio1;
ratio2=M9_ratio2;
[fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM);
       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ttt='NS P7 AC-6319 Fwd Fin Box Ascent';
THM=P7_AC_6319_th_bessel_20Hz_RMS;
Q=P7_ns4_Q;
ratio1=P7_ratio1;
ratio2=P7_ratio2;
[fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
ttt='NS P8 AC-6319 Fwd Fin Box Ascent';
THM=P8_AC_6319_th_bessel_20Hz_RMS;
Q=P8_ns4_Q;
ratio1=P8_ratio1;
ratio2=P8_ratio2;
[fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
ttt='NS M4 AC-6310 Fwd Fin Box Ascent';
THM=M4_AC_6310_th_bessel_20Hz_RMS;
Q=M4_ns4_Q;
ratio1=M4_ratio1;
ratio2=M4_ratio2;
[fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     
ttt='NS M5 AC-6310 Fwd Fin Box Ascent';
THM=M5_AC_6310_th_bessel_20Hz_RMS;
Q=M5_ns4_Q;
ratio1=M5_ratio1;
ratio2=M5_ratio2;
[fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

     
ttt='NS M5 AC-6322 Fwd Fin Ring Frame Valve Base Ascent';
THM=M5_AC_6322_th_bessel_20Hz_RMS;
Q=M5_ns4_Q;
ratio1=M5_ratio1;
ratio2=M5_ratio2;
[fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ttt='NS M6 AC-6322 Fwd Fin Ring Frame Valve Base Ascent';
THM=M6_AC_6322_th_bessel_20Hz_RMS;
Q=M6_ns4_Q;
ratio1=M6_ratio1;
ratio2=M6_ratio2;
[fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM);

    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ttt='NS M4 AC-6320 Fwd Ring Frame OML Ascent';
THM=M4_AC_6320_th_bessel_20Hz_RMS;
Q=M4_ns4_Q;
ratio1=M4_ratio1;
ratio2=M4_ratio2;
[fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ttt='NS M5 AC-6320 Fwd Ring Frame OML Ascent';
THM=M5_AC_6320_th_bessel_20Hz_RMS;
Q=M5_ns4_Q;
ratio1=M5_ratio1;
ratio2=M5_ratio2;
[fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


ttt='NS M5 AC-6320 Fwd Ring Frame OML Ascent';
THM=M5_AC_6320_th_bessel_20Hz_RMS;
Q=M5_ns4_Q;
ratio1=M5_ratio1;
ratio2=M5_ratio2;
[fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    Q=M4_ns4_Q;
    ratio1=M4_ratio1;
    ratio2=M4_ratio2;
    THM=M4_AC_6305_th_bessel_20Hz_RMS;
    ttt='NS M4 AC-6305 Aft Equipment Bay Ascent';
    [fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    Q=M5_ns4_Q;
    ratio1=M5_ratio1;
    ratio2=M5_ratio2;
    THM=M5_AC_6305_th_bessel_20Hz_RMS;
    ttt='NS M5 AC-6305 Aft Equipment Bay Ascent';
    [fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    Q=M6_ns4_Q;
    ratio1=M6_ratio1;
    ratio2=M6_ratio2;
    THM=M6_AC_6305_th_bessel_20Hz_RMS;
    ttt='NS M6 AC-6305 Aft Equipment Bay Ascent';
    [fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    Q=M7_ns4_Q;
    ratio1=M7_ratio1;
    ratio2=M7_ratio2;
    THM=M7_AC_6305_th_bessel_20Hz_RMS;
    ttt='NS M7 AC-6305 Aft Equipment Bay Ascent';
    [fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    Q=M8_ns4_Q;
    ratio1=M8_ratio1;
    ratio2=M8_ratio2;
    THM=M8_AC_6305_th_bessel_20Hz_RMS;
    ttt='NS M8 AC-6305 Aft Equipment Bay Ascent';
    [fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM)
    
    h2=figure(fig_num);
    fig_num=fig_num+1;

    yyaxis left
    plot(Q(:,1),Q(:,2),ratio1(:,1),ratio1(:,2),ratio2(:,1),ratio2(:,2));
    title(ttt);
    ylabel('Q Parameter (psf)');
    
    grid on;

    yyaxis right
    plot(THM(:,1),THM(:,2));
    ylabel('Accel (GRMS)');
    grid on;
    xlabel('Time (sec)');
    legend('Q','Q/(1+0.13*M^2)','Q/(1+M^2)','GRMS');
    xlim([t1 t2]);

    ttt=strrep(ttt,'-','_');
    ttt=strrep(ttt,' ','_');
    ttt=sprintf('%s.fig',ttt);
    savefig(ttt)
    
            pname=sprintf('g%d.emf',fig_num-1);
        print(h2,pname,'-dmeta','-r300');
    
end   
    
    
    
    
    
    
    
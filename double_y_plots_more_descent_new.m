

try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end    

M4=[358	403];
M5=[351	396];	
M6=[362	407];	
M7=[348	393];	
M8=[359	404];	
M9=[358	403];	
P7=[360	405];	
P8=[359	404];
    

fig_num=1;

t1=M7(1);
t2=M7(2);

ttt='NS M7 AC-6319 Fwd Fin Box Descent';
THM=M7_AC_6319_th_bessel_20Hz_RMS;
Q=M7_pm4_Q;
ratio1=M7_ds_ratio1;
ratio2=M7_ds_ratio2;
[fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t1=M8(1);
t2=M8(2);
 
ttt='NS M8 AC-6319 Fwd Fin Box Descent';
THM=M8_AC_6319_th_bessel_20Hz_RMS;
Q=M8_pm4_Q;
ratio1=M8_ds_ratio1;
ratio2=M8_ds_ratio2;
[fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM);
       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t1=M9(1);
t2=M9(2);

ttt='NS M9 AC-6319 Fwd Fin Box Descent';
THM=M9_AC_6319_th_bessel_20Hz_RMS;
Q=M9_pm4_Q;
ratio1=M9_ds_ratio1;
ratio2=M9_ds_ratio2;
[fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM);
       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t1=P7(1);
t2=P7(2);

ttt='NS P7 AC-6319 Fwd Fin Box Descent';
THM=P7_AC_6319_th_bessel_20Hz_RMS;
Q=P7_pm4_Q;
ratio1=P7_ds_ratio1;
ratio2=P7_ds_ratio2;
[fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
t1=P8(1);
t2=P8(2);

ttt='NS P8 AC-6319 Fwd Fin Box Descent';
THM=P8_AC_6319_th_bessel_20Hz_RMS;
Q=P8_pm4_Q;
ratio1=P8_ds_ratio1;
ratio2=P8_ds_ratio2;
[fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
t1=M4(1);
t2=M4(2);

ttt='NS M4 AC-6310 Fwd Fin Box Descent';
THM=M4_AC_6310_th_bessel_20Hz_RMS;
Q=M4_pm4_Q;
ratio1=M4_ds_ratio1;
ratio2=M4_ds_ratio2;
[fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t1=M5(1);
t2=M5(2);

ttt='NS M5 AC-6310 Fwd Fin Box Descent';
THM=M5_AC_6310_th_bessel_20Hz_RMS;
Q=M5_pm4_Q;
ratio1=M5_ds_ratio1;
ratio2=M5_ds_ratio2;
[fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t1=M5(1);
t2=M5(2);
     
ttt='NS M5 AC-6322 Fwd Fin Ring Frame Valve Base Descent';
THM=M5_AC_6322_th_bessel_20Hz_RMS;
Q=M5_pm4_Q;
ratio1=M5_ds_ratio1;
ratio2=M5_ds_ratio2;
[fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t1=M6(1);
t2=M6(2);

ttt='NS M6 AC-6322 Fwd Fin Ring Frame Valve Base Descent';
THM=M6_AC_6322_th_bessel_20Hz_RMS;
Q=M6_pm4_Q;
ratio1=M6_ds_ratio1;
ratio2=M6_ds_ratio2;
[fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM);

    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t1=M4(1);
t2=M4(2);

ttt='NS M4 AC-6320 Fwd Ring Frame OML Descent';
THM=M4_AC_6320_th_bessel_20Hz_RMS;
Q=M4_pm4_Q;
ratio1=M4_ds_ratio1;
ratio2=M4_ds_ratio2;
[fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t1=M5(1);
t2=M5(2);

ttt='NS M5 AC-6320 Fwd Ring Frame OML Descent';
THM=M5_AC_6320_th_bessel_20Hz_RMS;
Q=M5_pm4_Q;
ratio1=M5_ds_ratio1;
ratio2=M5_ds_ratio2;
[fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t1=M5(1);
t2=M5(2);

ttt='NS M5 AC-6320 Fwd Ring Frame OML Descent';
THM=M5_AC_6320_th_bessel_20Hz_RMS;
Q=M5_pm4_Q;
ratio1=M5_ds_ratio1;
ratio2=M5_ds_ratio2;
[fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t1=M4(1);
t2=M4(2);

    Q=M4_pm4_Q;
    ratio1=M4_ds_ratio1;
    ratio2=M4_ds_ratio2;
    THM=M4_AC_6305_th_bessel_20Hz_RMS;
    ttt='NS M4 AC-6305 Aft Equipment Bay Descent';
    [fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t1=M5(1);
t2=M5(2);

    Q=M5_pm4_Q;
    ratio1=M5_ds_ratio1;
    ratio2=M5_ds_ratio2;
    THM=M5_AC_6305_th_bessel_20Hz_RMS;
    ttt='NS M5 AC-6305 Aft Equipment Bay Descent';
    [fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t1=M6(1);
t2=M6(2);

    Q=M6_pm4_Q;
    ratio1=M6_ds_ratio1;
    ratio2=M6_ds_ratio2;
    THM=M6_AC_6305_th_bessel_20Hz_RMS;
    ttt='NS M6 AC-6305 Aft Equipment Bay Descent';
    [fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t1=M7(1);
t2=M7(2);

    Q=M7_pm4_Q;
    ratio1=M7_ds_ratio1;
    ratio2=M7_ds_ratio2;
    THM=M7_AC_6305_th_bessel_20Hz_RMS;
    ttt='NS M7 AC-6305 Aft Equipment Bay Descent';
    [fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t1=M8(1);
t2=M8(2);

    Q=M8_pm4_Q;
    ratio1=M8_ds_ratio1;
    ratio2=M8_ds_ratio2;
    THM=M8_AC_6305_th_bessel_20Hz_RMS;
    ttt='NS M8 AC-6305 Aft Equipment Bay Descent';
    [fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[fig_num]=core(fig_num,t1,t2,ttt,Q,ratio1,ratio2,THM)
    
    h2=figure(fig_num);
    fig_num=fig_num+1;

    
    t2=t2+5;
     
    [~,q1]=min(abs(Q(:,1)-t1));
    [~,q2]=min(abs(Q(:,1)-t2));    
    
    [~,tt1]=min(abs(THM(:,1)-t1));
    [~,tt2]=min(abs(THM(:,1)-t2));
    
    [~,r1]=min(abs(ratio1(:,1)-t1));
    [~,r2]=min(abs(ratio1(:,1)-t2));   
    
    
    yyaxis left
    plot(Q(q1:q2,1),Q(q1:q2,2),ratio1(r1:r2,1),ratio1(r1:r2,2),ratio2(r1:r2,1),ratio2(r1:r2,2));
    title(ttt);
    ylabel('Q Parameter (psf)');
    
    grid on;

    yyaxis right
    plot(THM(tt1:tt2,1),THM(tt1:tt2,2));
    ylabel('Accel (GRMS)');
    grid on;
    xlabel('Time (sec)');
    legend('Q','Q/(1+0.13*M^2)','Q/(1+M^2)','GRMS');
    legend('location','eastoutside');

    xlim([350 415]);
    set(h2, 'Position', [0 0 1400 900]);
    set(gca,'Fontsize',20);
        
    ttt=strrep(ttt,'-','_');
    ttt=strrep(ttt,' ','_');
    ttt=sprintf('%s.fig',ttt);
    savefig(ttt)
    
            pname=sprintf('g%d.emf',fig_num-1);
        print(h2,pname,'-dmeta','-r300');
    
end   
    
    
    
    
    
    
    
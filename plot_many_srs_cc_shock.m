%
% function[fig_num]=plot_loglog_multiple_function(fig_num,x_label,y_label,t_string,ppp,leg,fmin,fmax)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%

fig_num=1;
fmin=10;
fmax=10000;
x_label='Natural Frequency (Hz)';
y_label='Peak Accel (G)';
t_string='SRS Q=10  NS CC Separation Shock X-axis';

%
figure(fig_num);
fig_num=fig_num+1;
%

hold on;

%
cc_srs_mpe_x=[ 10 16; 100 400; 320 5000; 2000 14000; 10000 14000];
a=cc_srs_mpe_x;
plot(a(:,1),a(:,2),'k','DisplayName','Envelope');  % black

%
a=E1_sep3x_bessel_srs;
plot(a(:,1),a(:,2),'DisplayName','E1 3x');  
%
a=E3_sep2x_bessel_srs;
plot(a(:,1),a(:,2),'DisplayName','E3 2x'); 
%
a=E3_sep3x_bessel_srs;
plot(a(:,1),a(:,2),'DisplayName','E3 3x'); 

%
a=N1_sep2x_bessel_srs;
plot(a(:,1),a(:,2),'DisplayName','N1 2x'); 
%
a=N1_sep3x_bessel_srs;
plot(a(:,1),a(:,2),'DisplayName','N1 3x');  
%
a=N2_sep2x_bessel_srs;
plot(a(:,1),a(:,2),'DisplayName','N2 2x'); 
%
a=N2_sep3x_bessel_srs;
plot(a(:,1),a(:,2),'DisplayName','N2 3x'); 
%
a=N3_sep2x_bessel_srs;
plot(a(:,1),a(:,2),'DisplayName','N3 3x'); 


hold off;
%

legend show;

ylabel(y_label);   
xlabel(x_label);
out=sprintf(t_string);
title(out);
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
disp(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%


%
[xtt,xTT,iflag]=xtick_label(fmin,fmax);


if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    xlim([min(xtt),max(xtt)]);
end

ylim([1, 1e+05]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t_string='SRS Q=10  NS CC Separation Shock Y-axis';

%
figure(fig_num);
fig_num=fig_num+1;
%

hold on;

%
cc_srs_mpe_y=[ 10 12; 200 300; 2000 14200; 10000 14200];
a=cc_srs_mpe_y;
plot(a(:,1),a(:,2),'k','DisplayName','Envelope');  % black

%
a=E1_sep2y_bessel_srs;
plot(a(:,1),a(:,2),'r','DisplayName','E1 2y');  
%
a=E1_sep3y_bessel_srs;
plot(a(:,1),a(:,2),'b','DisplayName','E1 3y');  
%
a=E2_sep2y_bessel_srs;
plot(a(:,1),a(:,2),'DisplayName','E2 2y'); 

%
a=E2_sep3y_bessel_srs;
plot(a(:,1),a(:,2),'DisplayName','E2 3y'); 
a=E3_sep2y_bessel_srs;
plot(a(:,1),a(:,2),'DisplayName','E3 2y');  
%
a=E3_sep3y_bessel_srs;
plot(a(:,1),a(:,2),'DisplayName','E3 3y'); 
%
a=N1_sep2y_bessel_srs;
plot(a(:,1),a(:,2),'DisplayName','N1 2y'); 
%
a=N1_sep3y_bessel_srs;
plot(a(:,1),a(:,2),'DisplayName','N1 3y'); 
%
a=N2_sep3y_bessel_srs;
plot(a(:,1),a(:,2),'DisplayName','N2 3y');

hold off;
%

legend show;

ylabel(y_label);   
xlabel(x_label);
out=sprintf(t_string);
title(out);
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
disp(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%


%
[xtt,xTT,iflag]=xtick_label(fmin,fmax);


if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    xlim([min(xtt),max(xtt)]);
end

ylim([1, 1e+05]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t_string='SRS Q=10  NS CC Separation Ball Latch Only';

%
figure(fig_num);
fig_num=fig_num+1;
%

hold on;

%
cc_srs_mpe_ball_latch=[ 10 16; 250 560; 1000 2000; 2200 14000; 10000 14000];
a=cc_srs_mpe_ball_latch;
plot(a(:,1),a(:,2),'k','DisplayName','Envelope');  % black

%
a=N1_sep2x_bessel_srs;
plot(a(:,1),a(:,2),'DisplayName','N1 2x'); 
%
a=N1_sep3x_bessel_srs;
plot(a(:,1),a(:,2),'DisplayName','N1 3x');  
%

a=N1_sep2y_bessel_srs;
plot(a(:,1),a(:,2),'DisplayName','N1 2y'); 
%
a=N1_sep3y_bessel_srs;
plot(a(:,1),a(:,2),'DisplayName','N1 3y'); 


hold off;
%

legend show;

ylabel(y_label);   
xlabel(x_label);
out=sprintf(t_string);
title(out);
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
disp(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%


%
[xtt,xTT,iflag]=xtick_label(fmin,fmax);


if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    xlim([min(xtt),max(xtt)]);
end

ylim([1, 1e+05]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t_string='SRS Q=10  NS CC Separation Explosive Bolt Only';

%
figure(fig_num);
fig_num=fig_num+1;
%

hold on;

%
cc_srs_mpe_exp_bolts=[ 10 3; 1900 14000; 10000 14000];
a=cc_srs_mpe_exp_bolts;
plot(a(:,1),a(:,2),'k','DisplayName','Envelope');  % black

%
a=E1_sep3x_bessel_srs;
plot(a(:,1),a(:,2),'DisplayName','E1 3x');  
%
a=E1_sep2y_bessel_srs;
plot(a(:,1),a(:,2),'r','DisplayName','E1 2y');  
%
a=E1_sep3y_bessel_srs;
plot(a(:,1),a(:,2),'b','DisplayName','E1 3y');  
%

hold off;
%

legend show;

ylabel(y_label);   
xlabel(x_label);
out=sprintf(t_string);
title(out);
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
disp(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%


%
[xtt,xTT,iflag]=xtick_label(fmin,fmax);


if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    xlim([min(xtt),max(xtt)]);
end

ylim([1, 1e+05]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t_string='SRS Q=10  NS CC Separation LSC Only';

%
figure(fig_num);
fig_num=fig_num+1;
%

hold on;

%
cc_srs_mpe_LSC=[ 10 6; 100 130 ; 320 5000; 4000 14000; 10000 14000];
a=cc_srs_mpe_LSC;
plot(a(:,1),a(:,2),'k','DisplayName','Envelope');  % black

%
a=E3_sep2x_bessel_srs;
plot(a(:,1),a(:,2),'DisplayName','E3 2x'); 
%
a=E3_sep3x_bessel_srs;
plot(a(:,1),a(:,2),'DisplayName','E3 3x');  
%
a=E3_sep2y_bessel_srs;
plot(a(:,1),a(:,2),'DisplayName','E3 2y');  
%
a=E3_sep3y_bessel_srs;
plot(a(:,1),a(:,2),'DisplayName','E3 3y'); 
%
hold off;
%

legend show;

ylabel(y_label);   
xlabel(x_label);
out=sprintf(t_string);
title(out);
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
disp(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
[xtt,xTT,iflag]=xtick_label(fmin,fmax);


if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    xlim([min(xtt),max(xtt)]);
end

ylim([1, 1e+05]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t_string='SRS Q=10  NS CC Separation Shock Comparison';

%
figure(fig_num);
fig_num=fig_num+1;
%

hold on;

envelope=[ 10 16; 130 300; 320 5000; 2000 14000; 10000 14000];
%
a=envelope;
plot(a(:,1),a(:,2),'k','DisplayName','Envelope');  % black

%
a=cc_srs_mpe_ball_latch;
plot(a(:,1),a(:,2),'r','DisplayName','Ball Latch Only'); 
%
a=cc_srs_mpe_exp_bolts;
plot(a(:,1),a(:,2),'b','DisplayName','Explosive Bolts Only');  
%
a=cc_srs_mpe_LSC;
plot(a(:,1),a(:,2),'DisplayName','LSC Only');  
%
hold off;
%

legend show;

ylabel(y_label);   
xlabel(x_label);
out=sprintf(t_string);
title(out);
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
disp(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
[xtt,xTT,iflag]=xtick_label(fmin,fmax);


if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    xlim([min(xtt),max(xtt)]);
end

ylim([1, 1e+05]);
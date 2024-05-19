

%  psd_fds_plot_2x2_alt_h2.m  ver 1.0  by Tom Irvine

function[fig_num,h2]=psd_fds_plot_2x2_alt_h2(fig_num,Q,bex,fn,xfds,...
          fds_ref,nmetric,iu,t_string,power_spectral_density,fmin,fmax)

disp('a1')
      

x_label_psd=sprintf(' Frequency (Hz)');      

fsize=10.5;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h2=figure(fig_num);
fig_num=fig_num+1;

subplot(2,4,[1,2,5,6]);

f=power_spectral_density(:,1);
a=power_spectral_density(:,2);
%
%
plot(f,a)
%
disp('a2')

ylab_psd='Accel (G^2/Hz)';

ylabel(ylab_psd);   
xlabel(x_label_psd);
out=sprintf(t_string);
title(out);
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
disp('a3')

set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
set(gca,'Fontsize',fsize);  

disp('a4')
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
ymax=1.0e-90; 
%
ymin=1.0e+90;
%
%% out1=sprintf('ymin=%8.4g  fmin=%8.4g  fmax=%8.4g',ymin,fmin,fmax);
%% disp(out1);
%
for i=1:length(a)
    
    if( f(i)>=fmin && f(i) <=fmax  )
    
        if(ymin>a(i))
            ymin=a(i);
        end
        if(ymax<a(i))
            ymax=a(i);
        end
    
    end
    
end
%
[ymin,ymax]=ytick_log(ymin,ymax);
%
%
L=10^5;
%
if(ymin<ymax/L)
    ymin=ymax/L;
end

[xtt,xTT,iflag]=xtick_label_alt(fmin,fmax);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);          
end

%
%clear ytickn;
%
ya=ymin;
k=1;
for i=1:20
    for j=1:9
        ytickn(k)=j*ya; 
        k=k+1;
    end
    ya=ya*10.;
    ytickn(k)=ya; 
%    
    if(ya>ymax)
        break;
    end
end
%
nd=round(log10(ymax/ymin));
%
set(gca,'ytick',ytickn);
%
string1=num2str(ymin);
string2=num2str(10*ymin);
string3=num2str(100*ymin);
string4=num2str(1000*ymin);
string5=num2str(10000*ymin);
string6=num2str(100000*ymin);
string7=num2str(1000000*ymin);
%
if(nd==1)
    set(gca,'YTickLabel',{string1;'';'';'';'';'';'';'';'';string2})
end
if(nd==2)
    set(gca,'YTickLabel',{string1;'';'';'';'';'';'';'';'';string2;'';'';'';'';'';'';'';'';string3})
end
if(nd==3)
    set(gca,'YTickLabel',{string1;'';'';'';'';'';'';'';'';string2;'';'';'';'';'';'';'';'';string3;'';'';'';'';'';'';'';'';string4})
end
if(nd==4)
    set(gca,'YTickLabel',{string1;'';'';'';'';'';'';'';'';string2;'';'';'';'';'';'';'';'';string3;'';'';'';'';'';'';'';'';string4;'';'';'';'';'';'';'';'';string5})
end
if(nd==5)
    set(gca,'YTickLabel',{string1;'';'';'';'';'';'';'';'';string2;'';'';'';'';'';'';'';'';string3;'';'';'';'';'';'';'';'';string4;'';'';'';'';'';'';'';'';string5;'';'';'';'';'';'';'';'';string6})
end
if(nd==6)
    set(gca,'YTickLabel',{string1;'';'';'';'';'';'';'';'';string2;'';'';'';'';'';'';'';'';string3;'';'';'';'';'';'';'';'';string4;'';'';'';'';'';'';'';'';string5;'';'';'';'';'';'';'';'';string6;'';'';'';'';'';'';'';'';string7})
end
%
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
axis([fmin,fmax,ymin,ymax]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
leg_a=sprintf('PSD Envelope');
leg_b=sprintf('Measured Data');

fmin=min(fn);
fmax=max(fn);

[xtt,xTT,iflag]=xtick_label_alt(fmin,fmax);

disp('ref 1')

subplot(2,4,3);
%        
i=1;
xx=xfds(:,i);
ff=fds_ref(:,i);
plot(fn,log10(xx),fn,log10(ff))
[y_label,t_string]=fds_ylabel_apvtp(Q(i),bex(i),nmetric,iu);
y_label=strrep(y_label,'(','log10(')

[t_string]=ttstring(nmetric,t_string)

    
out=sprintf(t_string)
title(out);
grid on;
xlabel(' Natural Frequency (Hz)');
ylabel(y_label);
%% legend(leg_a,leg_b,1);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin','XminorTick','off','YminorTick','off');
%

set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
set(gca,'Fontsize',fsize);  
%
if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);    
end  
xlim([fmin,fmax])

ymax=max([ max(log10(xx)) max(log10(ff))  ]);
ymin=min([ min(log10(xx)) min(log10(ff))  ]);
[ytt,yTT]=ytick_linear_min_max_alt(ymax,ymin);
set(gca,'ytick',ytt);
set(gca,'YTickLabel',yTT);
ylim([min(ytt),max(ytt)]);
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
subplot(2,4,4);
%        
i=2;
xx=xfds(:,i);
ff=fds_ref(:,i);
plot(fn,log10(xx),fn,log10(ff))
[y_label,t_string]=fds_ylabel_apvtp(Q(i),bex(i),nmetric,iu);
y_label=strrep(y_label,'(','log10(');
%
[t_string]=ttstring(nmetric,t_string);

    
out=sprintf(t_string);
title(out);

grid on;
xlabel(' Natural Frequency (Hz)');
ylabel(y_label);
%% legend(leg_a,leg_b,1);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin','XminorTick','off','YminorTick','off');
%

set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
set(gca,'Fontsize',fsize);  
%
if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);    
end  
xlim([fmin,fmax]);    

ymax=max([ max(log10(xx)) max(log10(ff))  ]);
ymin=min([ min(log10(xx)) min(log10(ff))  ]);
[ytt,yTT]=ytick_linear_min_max_alt(ymax,ymin);
set(gca,'ytick',ytt);
set(gca,'YTickLabel',yTT);
ylim([min(ytt),max(ytt)]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
subplot(2,4,7);
%        
i=3;
xx=xfds(:,i);
ff=fds_ref(:,i);
plot(fn,log10(xx),fn,log10(ff))
[y_label,t_string]=fds_ylabel_apvtp(Q(i),bex(i),nmetric,iu);
y_label=strrep(y_label,'(','log10(');

[t_string]=ttstring(nmetric,t_string);

out=sprintf(t_string);
title(out);
grid on;
xlabel(' Natural Frequency (Hz)');
ylabel(y_label);
%% legend(leg_a,leg_b,1);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin','XminorTick','off','YminorTick','off');
%
%


set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
set(gca,'Fontsize',fsize);  
%
if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);    
end  
xlim([fmin,fmax]); 

ymax=max([ max(log10(xx)) max(log10(ff))  ]);
ymin=min([ min(log10(xx)) min(log10(ff))  ]);
[ytt,yTT]=ytick_linear_min_max_alt(ymax,ymin);
set(gca,'ytick',ytt);
set(gca,'YTickLabel',yTT);
ylim([min(ytt),max(ytt)]);
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
subplot(2,4,8);
%        
i=4;
xx=xfds(:,i);
ff=fds_ref(:,i);
plot(fn,log10(xx),fn,log10(ff))
[y_label,t_string]=fds_ylabel_apvtp(Q(i),bex(i),nmetric,iu);
y_label=strrep(y_label,'(','log10(');
%
[t_string]=ttstring(nmetric,t_string);

out=sprintf(t_string);
title(out);
grid on;
xlabel(' Natural Frequency (Hz)');
ylabel(y_label);
%% legend(leg_a,leg_b,1);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin','XminorTick','off','YminorTick','off');
%

set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
set(gca,'Fontsize',fsize);  
%
if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);    
end  
xlim([fmin,fmax]); 

ymax=max([ max(log10(xx)) max(log10(ff))  ]);
ymin=min([ min(log10(xx)) min(log10(ff))  ]);
[ytt,yTT]=ytick_linear_min_max_alt(ymax,ymin);
set(gca,'ytick',ytt);
set(gca,'YTickLabel',yTT);
ylim([min(ytt),max(ytt)]);
%
set(h2, 'Position', [0 0 1200 650]);
%    
  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[t_string]=ttstring(nmetric,t_string)

t_string=strrep(t_string,'Acceleration FDS','FDS');
t_string=strrep(t_string,'Pseudo Velocity','PV');


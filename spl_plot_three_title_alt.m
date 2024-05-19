%
%   spl_plot_three_title_alt.m  ver 1.9  by Tom Irvine
%
function[fig_num,hp]=spl_plot_three_title_alt(fig_num,n_type,f1,dB1,f2,dB2,f3,dB3,leg1,leg2,leg3,tstring,stype)
%



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




%
[oaspl_1]=oaspl_function(dB1);
[oaspl_2]=oaspl_function(dB2);
[oaspl_3]=oaspl_function(dB3);

%


disp(' ');


if(stype<=2)
    leg1=sprintf('%s  oaspl %6.4g dB',leg1,oaspl_1);
    leg2=sprintf('%s  oaspl %6.4g dB',leg2,oaspl_2);
    leg3=sprintf('%s  oaspl %6.4g dB',leg3,oaspl_3);
    disp(' Overall SPLs (ref = 20 micro Pascal) ');
else
    leg1=sprintf('%s  oafpl %6.4g dB',leg1,oaspl_1);
    leg2=sprintf('%s  oafpl %6.4g dB',leg2,oaspl_2);
    leg3=sprintf('%s  oafpl %6.4g dB',leg3,oaspl_3);
    disp(' Overall FPLs (ref = 20 micro Pascal) ');
end



out1=sprintf('\n %s = %8.4g dB',leg1,oaspl_1);
disp(out1)
out1=sprintf('  %s = %8.4g dB \n',leg2,oaspl_2);
disp(out1)
out1=sprintf('  %s = %8.4g dB \n',leg3,oaspl_3);
disp(out1)


hp=figure(fig_num);
hold on;

%


plot(f1,dB1,'Color',cmap(1,:),'DisplayName',leg1);
plot(f2,dB2,'Color',cmap(2,:),'DisplayName',leg2);
plot(f3,dB3,'Color',cmap(3,:),'DisplayName',leg3);


grid on;

if(stype==1)
    if(n_type==1)
        disp(' One-Third Octave SPL  Ref: 20 micro Pa ');
        out1=sprintf('One-Third Octave SPL,  %s \n Ref: 20 micro Pa ',tstring);
    else
        disp(' Full Octave SPL  Ref: 20 micro Pa ');
        out1=sprintf('Full Octave SPL,  %s \n Ref: 20 micro Pa ',tstring);
    end    
    ylabel('SPL (dB)');
end
if(stype==2)
    if(n_type==1)
        disp(' One-Third Octave SPL  Ref: 20 micro Pa ');
        out1=sprintf('One-Third Octave Sound Pressure Level,  %s \n Ref: 20 micro Pa ',tstring);
    else
        disp(' Full Octave SPL  Ref: 20 micro Pa ');
        out1=sprintf('Full Octave Sound Pressure Level,  %s \n Ref: 20 micro Pa ',tstring);
    end
    ylabel('SPL (dB)');
end
if(stype==3)
    if(n_type==1)
        disp(' One-Third Octave FPL  Ref: 20 micro Pa ');
        out1=sprintf('One-Third Octave FPL,  %s \n Ref: 20 micro Pa ',tstring);
    else
        disp(' Full Octave FPL  Ref: 20 micro Pa ');
        out1=sprintf('Full Octave FPL,  %s \n Ref: 20 micro Pa ',tstring);
    end    
    ylabel('FPL (dB)');
end


title(out1);

xlabel(' Center Frequency (Hz) ');

%

fmin=max([ min(f1) min(f2) min(f3) ]);
fmax=min([ max(f1) max(f2) max(f3) ]);

ymin=min([ min(dB1) min(dB2) min(dB3)  ]);
ymax=max([ max(dB1) max(dB2) max(dB3) ]);

ymax=ymax+10;

if(ymin<ymax-75)
    ymin=ymax-75;
end    

if(fmin>20)
    fmin=20;
end


[ytt,yTT,iflag]=ytick_label_spl(ymin,ymax);

if(iflag==1)
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ymin=min(ytt);
    ymax=max(ytt);    
end

%%  iflag
%%  ymin
%%  ymax

%
[xtt,xTT,iflag]=xtick_label(fmin,fmax);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);    
end

%
grid on;
set(gca, 'xminorgrid', 'on', 'yminorgrid', 'on')
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log','YScale','lin');
%
%

axis([fmin,fmax,ymin,ymax]);
legend show;
hold off;

fig_num=fig_num+1;

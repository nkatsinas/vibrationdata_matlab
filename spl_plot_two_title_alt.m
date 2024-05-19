%
%   spl_plot_two_title_alt.m  ver 2.0  by Tom Irvine
%
function[fig_num,hp]=spl_plot_two_title_alt(fig_num,n_type,f1,dB1,f2,dB2,leg1,leg2,tstring,stype)
%
[oaspl_1]=oaspl_function(dB1);
[oaspl_2]=oaspl_function(dB2);
%


disp(' ');


if(stype<=2)
    leg1=sprintf('%s  oaspl %6.4g dB',leg1,oaspl_1);
    leg2=sprintf('%s  oaspl %6.4g dB',leg2,oaspl_2);
    disp(' Overall SPLs (ref = 20 micro Pascal) ');
end
if(stype==3)
    leg1=sprintf('%s  oafpl %6.4g dB',leg1,oaspl_1);
    leg2=sprintf('%s  oafpl %6.4g dB',leg2,oaspl_2);
    disp(' Overall FPLs (ref = 20 micro Pascal) ');
end
if(stype==4)
    leg1=sprintf('%s  oa power %6.4g dB',leg1,oaspl_1);
    leg2=sprintf('%s  oa power %6.4g dB',leg2,oaspl_2);
    disp(' Overall Sound Power Levels (ref = 1 pico Watt) ');
end


out1=sprintf('\n %s = %8.4g dB',leg1,oaspl_1);
disp(out1)
out1=sprintf('  %s = %8.4g dB \n',leg2,oaspl_2);
disp(out1)



hp=figure(fig_num);
%
plot(f1,dB1,f2,dB2);

legend(leg1,leg2);  

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
if(stype==4)
    if(n_type==1)
        disp(' One-Third Octave Sound Power Level  Ref: 1 pico Watt ');
        out1=sprintf('One-Third Octave Sound Power Level,  %s \n Ref: 1 pico Watt ',tstring);
    else
        disp(' Full Octave Sound Power Level  Ref: 1 pico Watt ');
        out1=sprintf('Full Octave Sound Power Level,  %s \n Ref: 1 pico Watt',tstring);
    end    
    ylabel('Power (dB)');
end

title(out1);

xlabel(' Center Frequency (Hz) ');

%

fmin=max([ min(f1) min(f2)]);
fmax=min([ max(f1) max(f2)]);

[~,j1]=min(abs(f1-fmin));
[~,j2]=min(abs(f2-fmin));

ymin=min([ min(dB1(j1:end)) min(dB2(j2:end))  ]);
ymax=max([ max(dB1(j1:end)) max(dB2(j2:end))  ]);

ymax=ymax+5;

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

fig_num=fig_num+1;

%
%   spl_plot_four.m  ver 1.6  by Tom Irvine
%
function[fig_num]=spl_plot_four(fig_num,n_type,f1,dB1,f2,dB2,f3,dB3,f4,dB4,leg1,leg2,leg3,leg4)
%
[oaspl_1]=oaspl_function(dB1);
[oaspl_2]=oaspl_function(dB2);
[oaspl_3]=oaspl_function(dB3);
[oaspl_4]=oaspl_function(dB4);
%


disp(' ');
disp(' Overall Sound Pressure Levels (ref = 20 micro Pascal) ');
disp(' ');
out1=sprintf('  %s = %8.4g dB',leg1,oaspl_1);
out2=sprintf('  %s = %8.4g dB',leg2,oaspl_2);
out3=sprintf('  %s = %8.4g dB',leg3,oaspl_3);
out4=sprintf('  %s = %8.4g dB',leg4,oaspl_4);

disp(out1);
disp(out2);
disp(out3);
disp(out4);

leg1=sprintf('%s  oaspl %6.4g dB',leg1,oaspl_1);
leg2=sprintf('%s  oaspl %6.4g dB',leg2,oaspl_2);
leg3=sprintf('%s  oaspl %6.4g dB',leg3,oaspl_3);
leg4=sprintf('%s  oaspl %6.4g dB',leg4,oaspl_4);

figure(fig_num);
%
hold all;      

plot(f1,dB1,'color','blue','DisplayName',leg1);
plot(f2,dB2,'color','red','DisplayName',leg2);
plot(f3,dB3,'color','black','DisplayName',leg3);
plot(f4,dB4,'color',[0 .5 0] ,'DisplayName',leg4);

legend show;

grid on;
if(n_type==1)
    disp(' One-Third Octave Sound Pressure Level  Ref: 20 micro Pa ');
else
    disp(' Full Octave Sound Pressure Level  Ref: 20 micro Pa ');    
end    

title('Sound Pressure Level  Ref: 20 micro Pa');
xlabel(' Center Frequency (Hz) ');
ylabel(' SPL (dB) ');

%

fmin=min([ min(f1) min(f2)  min(f3)  min(f4)]);
fmax=max([ max(f1) max(f2)  max(f3)  max(f4)]);

if(fmin>20)
    fmin=20;
end


ymin=min([ min(dB1) min(dB2)  min(dB3)  min(dB4)]);
ymax=max([ max(dB1) max(dB2)  max(dB3)  max(dB4)]);

for i=0:5:250
    if(ymax<i)
        ymax=i;
        break;
    end
end
for i=0:5:200
    if(ymin<i)
        ymin=i-5;
        break;
    end
end

ymax=ymax+5;


%
[xtt,xTT,iflag]=xtick_label(fmin,fmax);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);    
end


grid on;
set(gca, 'xminorgrid', 'on', 'yminorgrid', 'on')
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log','YScale','log');
%
axis([fmin,fmax,ymin,ymax]);

hold off;

fig_num=fig_num+1;

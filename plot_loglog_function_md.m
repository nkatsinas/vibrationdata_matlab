%
%  plot_loglog_function_md.m  ver 1.3  by Tom Irvine
%
function[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md)
%


f=ppp(:,1);
a=ppp(:,2);
%
figure(fig_num);
fig_num=fig_num+1;
%
plot(f,a);
%
ylabel(y_label);   
xlabel(x_label);
out=sprintf(t_string);
title(out);

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
 
%

grid on;
set(gca, 'xminorgrid', 'on', 'yminorgrid', 'on')
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log','YScale','log');  

[xtt,xTT,iflag]=xtick_label(fmin,fmax);


if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);
    xlim([fmin,fmax]);    
end   


ff=f;
aa=a;

for i=length(aa):-1:1
    if(aa(i)==0)
        ff(i)=[];
        aa(i)=[];
    end
end


[~,index1] = min(abs(ff-fmin));
[~,index2] = min(abs(ff-fmax));



max(aa(index1:index2));
min(aa(index1:index2));

ymax= 10^ceil(0.01+log10(max(aa(index1:index2))));
%
ymin= 10^floor(log10(min(aa(index1:index2))));

% fprintf('\n ymax=%8.4g  ymin=%8.4g \n',ymax,ymin);



if(ymin<ymax/10^md)
    ymin=ymax/10^md;
end

if(ymin==ymax)
    ymin=ymin/10;
    ymax=ymax*10;
end    

ylim([ymin,ymax]);

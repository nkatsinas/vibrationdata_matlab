%
%  subplots_three_linlin_three_titles_ss.m  ver 1.2  by Tom Irvine
%

function[fig_num]=subplots_three_linlin_three_titles_ss(fig_num,xlabel3,ylabel1,ylabel2,ylabel3,data1,data2,data3,t_string1,t_string2,t_string3)

qmax1=max(abs(data1(:,2))); 
qmax2=max(abs(data2(:,2)));  
qmax3=max(abs(data3(:,2)));  

qmax=max( [ qmax1 qmax2 qmax3   ]);

[ymax,yTT,ytt,iflag]=ytick_linear_double_sided(qmax);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hp=figure(fig_num);

subplot(3,1,1);
plot(data1(:,1),data1(:,2));
grid on;
ylabel(ylabel1);
title(t_string1);

if(iflag==1)
    ylim([-ymax,ymax]);    
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);  
    set(gca,'MinorGridLineStyle',':','GridLineStyle',':',...
                                    'XminorTick','off','YminorTick','on'); 
else
    ylim([-qmax,qmax]);        
end

%
subplot(3,1,2);
plot(data2(:,1),data2(:,2));
grid on;
ylabel(ylabel2);
title(t_string2);

if(iflag==1)
    ylim([-ymax,ymax]);    
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);  
    set(gca,'MinorGridLineStyle',':','GridLineStyle',':',...
                                    'XminorTick','off','YminorTick','on'); 
else
    ylim([-qmax,qmax]);        
end

%
subplot(3,1,3);
plot(data3(:,1),data3(:,2));
grid on;
xlabel(xlabel3);
ylabel(ylabel3);
title(t_string3);
if(iflag==1)
    ylim([-ymax,ymax]);    
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);  
    set(gca,'MinorGridLineStyle',':','GridLineStyle',':',...
                                    'XminorTick','off','YminorTick','on'); 
else
    ylim([-qmax,qmax]);        
end

fig_num=fig_num+1;
set(hp, 'Position', [50 50 650 650]);
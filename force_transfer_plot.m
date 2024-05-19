
fig_num=999;

tpi=2*pi;

Q=[5 10 20];


%
fstart=0.1;
fend=10;

i=1;

oct=1/48;

while(1)

    f(i)=fstart*2^(oct*(i-1));

    if(f(i)>fend)
        break;
    end

    i=i+1;
    
end

f=fix_size(f);

omega=tpi*f;

omegan=tpi;

num=length(f);

H=zeros(num,3);


for ijk=1:3
%
    QQ=Q(ijk);
    
    damp=1/(2*QQ);
    
    for i=1:num
        
        omega=tpi*f;
        
        H(i,ijk)= omegan^2 /((omegan^2-omega(i)^2)+(1i)*(2*damp*omega(i)*omegan));
    end
%
end

HM=abs(H);

q5_p=zeros(num,1);
q10_p=zeros(num,1);
q20_p=zeros(num,1);


scale=180/pi;


for i=1:num
    
    q5_p(i)=scale*atan2(imag(H(i,1)),real(H(i,1)));
    
    q10_p(i)=scale*atan2(imag(H(i,2)),real(H(i,2))); 
    
    q20_p(i)=scale*atan2(imag(H(i,3)),real(H(i,3)));  
    
end 


q5_m=HM(:,1);
q10_m=HM(:,2);
q20_m=HM(:,3);


f1=fstart;
f2=fend;


[xtt,xTT,iflag]=xtick_label(f1,f2);

ff=f;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(fig_num);
fig_num=fig_num+1;
%
subplot(3,1,1);
plot(ff,q20_p,'b',ff,q10_p,'r',ff,q5_p,'k');
    

ylabel('Phase (deg)');
title('SDOF Transfer Function for Applied Force');

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    f1=min(xtt);
    f2=max(xtt);    
end

ylim([-180,0]);
xlim([f1 f2]);
    
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
                    'YScale','lin','ytick',[-180,-135,-90,-45,0]); 


    grid on;
    set(gca, 'xminorgrid', 'on', 'yminorgrid', 'off')    
    set(gca,'fontsize',9.5)
                
%%%%%%%%

subplot(3,1,[2 3]);
plot(ff,q20_m,'b',ff,q10_m,'r',ff,q5_m,'k');

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    f1=min(xtt);
    f2=max(xtt);    
end


xlim([f1 f2]);

legend('Q=20','Q=10','Q=5');


xlabel('Frequency Ratio  ( f / fn )');
ylabel('Magnitude [ kx / F ]');

set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
         'YScale','log'); 

         grid on;
    set(gca, 'xminorgrid', 'on', 'yminorgrid', 'on')
    
     set(gca,'fontsize',9.5)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




clear n;
clear b;
clear h;


%%%  log_Nf = A - B*log10(Seq - C );
%%%  Nf=10^(log_Nf);




A=20.68;
B=9.84;
C=0;
P=0.63;


j=1;

for i=30:80
   
    n(j)=10^(i/10);
    b(j)=(9.772e+17/n(j))^(1/9.25);
    
    seq=10^((-log10(n(j))+A)/B);
    
    h(j)=seq/(2^P);
    
    j=j+1;
    
end

figure(999);
plot(n,b,n,h);
title('Wohler S-N Curve, Aluminum 6061-T6, Kt=1, R=-1')
ylabel('Stress (ksi)');
xlabel('Nf Cycles');
legend('Basquin','MIL-HDBK-5J');
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','lin','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
%
%  

em=1.0e+07;
h=0.25;
mu=0.3;

md=0.1/386;

tpi=2*pi;
num=20000;

cair=13500;

lambda_bending=zeros(num,1);
lambda_air=zeros(num,1);
f=zeros(num,1);



for i=1:num
    
    f(i)=i;
    
    omega=tpi*f(i);

    B=em*h^3/(12*(1-mu^2));
    mp=md*h; 
    cb=( (B/mp)^(1/4))*sqrt(omega); 

    lambda_bending(i)=cb/f(i);
    lambda_air(i)=cair/f(i);    
    
end




figure(777)
plot(f,lambda_bending,f,lambda_air);
legend('Plate Bending','Acoustic Air');
xlabel('Frequency (Hz)');
ylabel('Wavelength (in)');

fmin=10;
fmax=20000;

[xtt,xTT,iflag]=xtick_label(fmin,fmax);


if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    
    fmin=min(xtt);
    fmax=max(xtt);
    xlim([fmin fmax]);
end


title('Wavelength vs. Frequency')

    set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
    set(gca,'XGrid','on','GridLineStyle',':');
    set(gca,'YGrid','on','GridLineStyle',':');



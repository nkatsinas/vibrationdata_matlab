
clear NS_spl_smoothed;

clear a;
clear f;
clear spl;
clear pressure;
clear intensity;
clear power;
clear Lwb;
clear NN;
clear normalized_power;

clear NS_LW;
clear NG_LW;

clear NS_Lwb;
clear NG_Lwb;

clear NS_power;
clear NG_power;

clear NS_pressure;
clear NG_pressure;

clear NS_str;

clear NG_intensity;
clear NG_spl;

clear NR;


clear X;
clear Y;

m_per_inch=0.0254;
N_per_lbf = 4.448;

NS_F=25000;


NS_Ue=12000*12;
NS_de=25.6;

NS_F=NS_F*N_per_lbf;
NS_Ue=NS_Ue*m_per_inch;
NS_de=NS_de*m_per_inch;

error_max=1e+99;

for ijk=1:10000

aeff=rand()+1.e-06;

if(ijk>100 && rand()>0.5)
    aeff=ra*(0.99+0.02*rand());
end

NS_MP=NS_F*NS_Ue;

NS_WOA=0.5*aeff*NS_MP;

NS_LW=10*log10(NS_WOA)+120;

% disp(' ');
% disp(' ********** NS ********** ');

outp5=sprintf('\n overall acoustic power level LW = %8.4g dB ',NS_LW);
outp6=sprintf(' Ref = 1.0e-12 Watts \n');  

% disp(outp5);
% disp(outp6);

%%


nu=length(MIC_6321_6322_opt_psd_ev1_spl(:,1));

size(NS_liftoff_single_plate_10deg_0p15eff_BHS_spl_1);

NR=NS_liftoff_single_plate_10deg_0p15eff_BHS_spl_1(1:nu,2)-MIC_6321_6322_opt_psd_res_ev4_spl(:,2);

NR_function=[NS_liftoff_single_plate_10deg_0p15eff_BHS_spl_1(1:nu,1) NR];


NS_PM_external_landing_SPL=[ MIC_6321_6322_opt_psd_ev4_spl(:,1)  MIC_6321_6322_opt_psd_ev4_spl(:,2)+NR ];

%%

a=NS_PM_external_landing_SPL;



fa=a(:,1);
aspl=a(:,2)-3;

n=length(freq);
m=length(fa);

n=length(freq);

NS_pressure=zeros(n,1);
NS_intensity=zeros(n,1);
NS_power=zeros(n,1);
NS_Lwb=zeros(n,1);
NS_str=zeros(n,1);

NS_spl_smoothed=zeros(n,1);

refa=20e-06;
refb=1.0e-12;

rhoc=415;       % Pa sec/m


%%


NS_spl_landing_smoothed=[fa aspl];


NS_r=41+24;

NS_r=NS_r*m_per_inch;


NS_spl=zeros(n,1);


for i=1:n
    NS_pressure(i)=refa*10^(aspl(i)/20);
    NS_intensity(i)=(NS_pressure(i))^2/rhoc;
    NS_power(i)=2*pi*r^2*NS_intensity(i);
    NS_Lwb(i)=10*log10(NS_power(i)/refb);
end


% [oadb]=oaspl_function(NS_Lwb);

% diff=NS_LW-oadb;
% NS_Lwb=NS_Lwb+diff;


for i=1:n    
    NS_power(i)=refb*10^(NS_Lwb(i)/10);
    NS_intensity(i)=NS_power(i)/(2*pi*NS_r^2);
    NS_pressure(i)=sqrt( NS_intensity(i)*rhoc);
    NS_spl(i)=20*log10(NS_pressure(i)/refa)+3;       
end

 NS_spl_check=[freq NS_spl];


 for i=1:n
    NS_str(i) = freq(i)* NS_de/NS_Ue;
 end
 
 
[NS_oadb]=oaspl_function(NS_Lwb);

out1=sprintf('\n NS overall power = %8.4g dB \n',NS_oadb);
% disp(out1);


error=abs(NS_LW-NS_oadb);

if(error<error_max)
    error_max=error;
    out1=sprintf(' %8.4g  %8.5g  %8.5g  %8.5g',aeff,NS_LW,NS_oadb,error_max);
    disp(out1);
    ra=aeff;
end

end

return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


disp(' ');
disp(' ********** NG ********** ');

NG_F=3e+05;


NG_Ue=10934*12;
NG_de=76;

NG_F=NG_F*N_per_lbf;
NG_Ue=NG_Ue*m_per_inch;
NG_de=NG_de*m_per_inch;



NG_MP=NG_F*NG_Ue;

NG_WOA=0.5*aeff*NG_MP;

NG_LW=10*log10(NG_WOA)+120;

NG_r=76+49;
NG_r=NG_r*m_per_inch;

outp5=sprintf('\n overall acoustic power level LW = %8.4g dB ',NG_LW);
outp6=sprintf(' Ref = 1.0e-12 Watts \n');  

disp(outp5);
disp(outp6);

n=length(freq);

NG_power=zeros(n,1);
NG_Lwb=zeros(n,1);

NG_intensity=zeros(n,1);
NG_pressure=zeros(n,1);
NG_spl=zeros(n,1);

sn=NS_str;

for i=1:n
    NG_str = freq(i)* NG_de/NG_Ue; 
    
    strouhal=NG_str;
    
    for j=1:n-1
    
        if(strouhal<sn(1))
            NG_power(i)=NS_power(1);
            break;
        end
        if(strouhal==sn(j))
            NG_power(i)=NS_power(i);
            break;
        end
        if( strouhal>sn(j) && strouhal<sn(j+1) )    
 
            slope=log10(NS_power(j+1)/NS_power(j))/log10(sn(j+1)/sn(j));
 
            az=log10(NS_power(j));
            az=az+slope*(log10(strouhal)-log10(sn(j)));
 
            NG_power(i)=10^az;
            break;
        end
        if(strouhal>=sn(end))
            noct=log(strouhal/sn(end))/log(2);
            ndB=-12*noct;
            rr=10^(ndB/10);
            NG_power(i)=NS_power(end)*rr;
            break;
        end  
    
    end
        
    NG_Lwb(i)=10*log10(NG_power(i)/refb);
   
end

%    NG_pressure(i)=refa*10^(spl(i)/20);
%    NG_intensity(i)=(NG_pressure(i))^2/rhoc;
%    NG_power(i)=2*pi*r^2*NG_intensity(i);

[NG_oadb]=oaspl_function(NG_Lwb);

diff=NG_LW-NG_oadb;
NG_Lwb=NG_Lwb+diff;

[NG_oadb]=oaspl_function(NG_Lwb);


for i=1:n
    
    NG_power(i)=refb*10^(NG_Lwb(i)/10);
    
    NG_intensity(i)=NG_power(i)/(2*pi*NG_r^2);
    NG_pressure(i)=sqrt( NG_intensity(i)*rhoc);
    
    NG_spl(i)=20*log10(NG_pressure(i)/refa)+3;       
end



out1=sprintf('\n NG overall power = %8.4g dB \n',NG_oadb);
disp(out1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=1;

ppp1=[freq NG_Lwb];
ppp2=[freq NS_Lwb];

NG_landing_sound_power=ppp1;

leg1=sprintf('NG GS1 %6.4g dB',NG_oadb);
leg2=sprintf('NS PM  %6.4g dB',NS_oadb);



fmin=20;
fmax=2000;

x_label='Center Frequency (Hz)';
y_label='Power (dB)';
t_string='Sound Power at Landing    ref: 1 pico Watt';


md=6;

[fig_num,h2]=plot_loglin_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);

ylim([130 200]);

%%

    freq=fix_size(freq);
    
    f=freq;
    dB=NG_spl;
    
    NG_landing_spl=[f dB];
    NG_landing_external_spl=[f dB];
    
    n_type=1;

    tstring=sprintf('NG Landing BHS');
    
    [fig_num]=spl_plot_title(fig_num,n_type,f,dB,tstring);

    
    
refc=1.0e-12;

NS_intensity_dB=zeros(n,1);
NG_intensity_dB=zeros(n,1);

for i=1:n
    NS_intensity_dB(i)=10*log10(NS_intensity(i)/refc);
    NG_intensity_dB(i)=10*log10(NG_intensity(i)/refc);    
end    


ppp1=[freq NG_intensity_dB];
ppp2=[freq NS_intensity_dB];



[NG_oadb]=oaspl_function(NG_intensity_dB);
[NS_oadb]=oaspl_function(NS_intensity_dB);

leg1=sprintf('NG GS1 %6.4g dB',NG_oadb);
leg2=sprintf('NS PM  %6.4g dB',NS_oadb);



fmin=20;
fmax=2000;

x_label='Center Frequency (Hz)';
y_label='Intensity (dB)';
t_string='Sound Intensity at BHS Landing    ref: 1 pico W/m^2';


md=6;

[fig_num,h2]=plot_loglin_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);

ylim([110 180]);
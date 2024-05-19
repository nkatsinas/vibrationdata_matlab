
clear new_nrspl;
clear cc;
clear new_power;

cc=NS_landing_10deg_45peff_max_BHS_spl_1


 dB_diff=cc(1:21,2)-NS_PM_external_landing_SPL(1:21,2);

new_power=[cc(1:21,1) NS_landing_10deg_45peff_max_Lwb(1:21,2)-dB_diff];

m_per_inch=0.0254;

m_per_inch=0.0254;
N_per_lbf = 4.448;

F=15000;


Ue=12000*12;
de=25.6;

F=F*N_per_lbf;
Ue=Ue*m_per_inch;
de=de*m_per_inch;


aeff=0.45;

MP=F*Ue;

WOA=0.5*aeff*MP;

LW=10*log10(WOA)+120;

WOA;

ref=1.0e-12;

n=length(new_power(:,1));

new_nrspl=zeros(n,2);

freq=new_power(:,1);

for i=1:n
    
    df = ((2^(1/6))-1/(2^(1/6)))*freq(i);

%    Lwb(i)= 10*log10(amp(i)/ref) +LW -10*log10(U/de) +10*log10(df);
    
    aa=new_power(i,2)-LW+10*log10(Ue/de) -10*log10(df);
    new_nrspl(i,:)=[new_power(i,1)*de/Ue aa]; 
end

% [oadb]=oaspl_function(aa);

new_nrspl
disp(' ')
disp('cylinder_shell_honeycomb_TL.m, ver 1.1,  February 5, 2009 ');
disp('By Tom Irvine    Email: tomirvine@aol.com');
disp(' ')
disp(' Reference: ');
disp(' T. Irvine, Transmission Loss through a honeycomb-sandwich Cylindrical Shell, ')
disp(' Vibrationdata, 2008 ');
disp(' ');
%
TPI=2.*pi;
%
ref  = 1.0e-12;
Aref = 20.e-06;
%
m_per_ft = 0.3048;
%
clear f;
clear fr;
clear psd;
clear fc;
clear spl;
clear fr;
clear ar;
clear s;
clear sfr;
clear spl;
clear psd;
clear E;
%
fc(1)=2.5;
	fc(2)=3.15;
	fc(3)=4.;;
	fc(4)=5.;
	fc(5)=6.3;
	fc(6)=8.;
	fc(7)=10.;
	fc(8)=12.5;
	fc(9)=16.;
	fc(10)=20.;
	fc(11)=25.;
	fc(12)=31.5;
	fc(13)=40.;
	fc(14)=50.;
	fc(15)=63.;
	fc(16)=80.;
	fc(17)=100.;
	fc(18)=125.;
	fc(19)=160.;
	fc(20)=200.;
	fc(21)=250.;
	fc(22)=315.;
	fc(23)=400.;
	fc(24)=500.;
	fc(25)=630.;
	fc(26)=800.;
	fc(27)=1000.;
	fc(28)=1250.;
	fc(29)=1600.;
	fc(30)=2000.;
	fc(31)=2500.;
	fc(32)=3150.;
	fc(33)=4000.;
	fc(34)=5000.;
	fc(35)=6300.;
	fc(36)=8000.;
	fc(37)=10000.;
	fc(38)=12500.;
	fc(39)=16000.;
	fc(40)=20000.;
    f=fc;
%
for(i=1:40)
    spl(i)=1.;
end
ilast=length(spl);
%
%**************************************************************************
%
    cref=200000./12.;
%
    disp(' ')
	disp(' Enter face sheet material:  1=aluminum  2=steel  3=graphite epoxy  4=other ')
    imat=input(' ');
%
    if(imat ~=1 & imat ~=2 & imat ~= 3 & imat ~= 4)
		disp(' Input Error ');
    end
%
	if(imat==1)
		W=0.1;
		cmat=cref;
    end
	if(imat==2)
		W=0.29;
		cmat=cref;
    end
 	if(imat==3)
        E=10.0e+06;      % elastic modulus (psi)
        rho=0.00015024;  % mass/volume (lbf sec^2/in^4)
        W=rho*386;
		cmat=sqrt(E/rho)/12.;
    end   
    if(imat==4)
%
		disp(' Enter face sheet weight density (lbm/in^3) ');
   		W=input(' ');
%
		disp(' Enter face sheet elastic modulus (lbf/in^2) ');
   		E=input(' ');
%
		cmat = sqrt( (E/W)*(32.2/12.) );
%
    end
%
	out1=sprintf('\n Face Sheet Weight Density = %10.3g lbm/in^3 ',W);
    disp(out1)
%
	out1=sprintf('\n Speed of Sound in Material = %10.3g ft/sec ',cmat);	
    disp(out1)
%
	scale = cmat/cref;
%
%**************************************************************************
%
    disp(' ')
	disp(' Enter diameter (in) ');
	stationdiam=input(' ');
%
	stationdiam=stationdiam/12.;
%	
	disp(' Enter total face thickness (in) ');
   	fc_thickness=input(' ');
%
	disp(' Enter core thickness (in) ');
   	core_thickness=input(' ');
%    
	disp(' Enter core mass density (lbm/in^3) ');
   	Wc=input(' ');
%
%**************************************************************************
%
     Wf=W;
   	out1=sprintf('\n Face Sheet Density per area = %10.3g lbm/in^2 ',Wf*fc_thickness);
    disp(out1) 
%
   	  out1=sprintf('       Core Density per area = %10.3g lbm/in^2 ',Wc*core_thickness);
    disp(out1) 
%
    W=W*fc_thickness + Wc*core_thickness;
%
	  out1=sprintf('      Total Density per area = %12.3g lbm/in^2  \n',W);
    disp(out1)
%
	  out1=sprintf('      Total Density per area = %12.3g lbm/ft^2  \n',W*144.);
    disp(out1)
%
%   1 lbm/in^2 = 0.0025904 lbf sec^2/in^3 
%
    W=W*0.0025904; 
	out1=sprintf('        Total Density per area = %12.3g lbf sec^2/in^3  ',W);
    disp(out1)
%
    rho_bar=W;
%
	fr(1)=1.0;
	fr(2)=2.0;
	fr(3)=2.7;
	fr(4)=3.0;
	fr(5)=3.3;
	fr(6)=3.6;
	fr(7)=3.7;
	fr(8)=3.78;
	fr(9)=3.9;
	fr(10)=4.0;
	fr(11)=4.1;
	fr(12)=4.3;
	fr(13)=4.7;
%
	ar(1)=-158;	
	ar(2)=-146;
	ar(3)=-140.5;
	ar(4)=-136.;
	ar(5)=-130.;
	ar(6)=-121.;
	ar(7)=-119.;
	ar(8)=-118.8;
	ar(9)=-119.;
	ar(10)=-120.;
	ar(11)=-121.7;
	ar(12)=-123.;
	ar(13)=-124.5;
%
	for(i=1:13)
		fr(i)= log10( ((10.^fr(i))*scale) );
    end
%
	jlast = 13;
%
for(i=1:max(size(f)))
%
		sfr = log10( f(i)*stationdiam );
%
        if( sfr <= fr(1))
			va= ar(1);
        end
		if(sfr >= fr(jlast) )
			va= ar(jlast);
        end
		if( sfr > fr(1) && sfr < fr(jlast) )
%
			for(j=1:11)
%
				if(sfr >= fr(j) && sfr <= fr(j+1) )
%
					len = fr(j+1) -fr(j);
					k2  = (sfr    -fr(j))/len;
%
					k1=1.-k2;
					va = k1*ar(j) + k2*ar(j+1);
%
					break;
                end
            end
        end
%
		vdb = va - 20.*log10(W) + spl(i);
%
		al = 1.*(10.^(vdb/20.));
%
		df = ((2.^(1./6.))-1./(2.^(1./6.)))*f(i);
%
% assume vdb is in terms of RMS
%
		psd(i) = (al^2.)/df;
%
end
%
ra=0.;
rb=0.;
%
for(i=1:(max(size(fr))-1))
%
    s(i)=log( psd(i+1)/psd(i) )/log( f(i+1)/f(i) );
%
    if(s(i) < -1.0001 ||  s(i) > -0.9999 )
%  
    rb=rb+ ( psd(i+1) * f(i+1)- psd(i)*f(i))/( s(i)+1.);
%
else
%
    rb=rb+ psd(i)*f(i)*log( f(i+1)/f(i));
end
%		 
    if(f(i) < 2050.)
        ra=rb;
    end
end
%
RF=cmat/(pi*stationdiam);
out1=sprintf('\n Ring Frequency = %12.4g Hz ',RF);
disp(out1)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' Enter loss factor ');
n=input(' ');
%%%%%% rho_bar=tft*rho;
%
%%%%%% out1=sprintf('\n Surface mass density = %8.4g (lbf sec^2/in^3)  ',rho_bar);
%%%%%%   out2=sprintf('                      = %8.4g (lbm/in^2)      \n',rho_bar*386.);
%%%%%% disp(out1);
%%%%%% disp(out2);
%
ring_f = RF;
fn=ring_f;
%
air_rho=1.2103e-007;   % lbf sec^2/in^4  
air_c=13500;           % in/sec
rho_c_air=air_rho*air_c;  % lbf sec/in^3
%
disp(' Enter the altitude (nautical miles) ');
alt=input(' ');
alt=alt*1.852;  % convert to km
%
density_ratio=(-0.00787*alt^3 +0.505*alt^2 -11.7*alt +101)/101;
%
out1=sprintf('\n Air Density Ratio = %7.3g ',density_ratio);
disp(out1);
%
rho_c_air=rho_c_air*density_ratio;
%
out1=sprintf('\n  acoustic impedance of air = %8.4g lbf sec/in^3',rho_c_air);   % lbf sec/in^3
disp(out1);
%
fff=fn;
f_ratio=fn/fff;
fr2=f_ratio^2;
A=1+(n*pi*rho_bar*fff/rho_c_air)*fr2;
B=(pi*rho_bar*fff/rho_c_air)*(1-fr2);
TLR=10*log10(A^2+B^2);
% 
out1=sprintf('\n Estimated Transmission Loss at Ring Frequency = %7.3g dB',TLR);
disp(out1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' Enter transmission loss at ring frequency (dB)');
TLR=input(' ');
TLR=-abs(TLR);
%
disp(' ');
%
maxpsd=max(psd);
psd=psd/max(psd);
for(i=1:max(size(psd)))
    psd(i)=10*log10(psd(i));
end
%   
clear TL;
clear ft;
j=1;
for(i=1:max(size(psd)))
    if(f(i)>= 20 & f(i)<=10000)
        TL(j)=psd(i)+TLR;
        ft(j)=f(i);
        j=j+1;
    end
end    
%
disp(' ');
disp(' Apply limits due to flanking noise, vents, etc. ');
disp(' ');
%
disp(' Enter upper frequency TL limit (dB)')
UL=input(' ');
disp(' Enter lower frequency TL limit (dB)')
LL=input(' ');
%
UL=-abs(UL);
LL=-abs(LL);
%
clear TL_old;
%
TL_old=TL;
for(i=1:max(size(TL)))
    if(ft(i)<RF)
        if(TL(i)<LL)
            TL(i)=LL;
        end
    else
        if(TL(i)<UL)
            TL(i)=UL;
        end        
    end
    if(i>1 & ft(i)<RF*0.9 & TL(i)<TL(i-1))
        TL(i)=TL(i-1);
    end
end
figure(1);  
plot(ft,TL);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin'); 
grid;
xlabel(' Frequency (Hz)');
ylabel(' Transmission Loss (dB)');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
figure(2);  
plot(ft,TL,ft,TL_old);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin'); 
legend ('with limits','without limits');  
grid;
xlabel(' Frequency (Hz)');
ylabel(' Transmission Loss (dB)');
ffmin=10.;
ffmax=max(ft);
%
ymin=min(TL_old)-1;
if(min(TL)<ymin)
    ymin=min(TL)-1;
end
%
ymax=max(TL)+3;
if(max(TL_old)>ymax)
    ymax=max(TL_old)+3;
end
%
axis([ffmin,ffmax,ymin,ymax]);
%
disp(' Write the TL data to a file? ')
choice = input(' 1=yes 2=no ');
%
if(choice == 1)
   disp(' ');   
   disp(' Enter the output filename ');
   filename1 = input(' ','s');
   fid1 = fopen(filename1,'w');  
   for(k=1:length(ft))
      fprintf(fid1,'%11.4e %11.4e \n',ft(k), TL(k));    
   end
   fclose(fid1);
end    
%
clear transmission_loss;
transmission_loss=[ft;TL]'; 
out5 = sprintf('\n\n The TL matrix is renamed as "transmission_loss" ');
disp(out5);      
disp(' ')
disp(' Franken.m, ver 1.1,  July 9, 2018 ');
disp(' By Tom Irvine    Email: tom@irvinemail.org');
disp(' ')
disp(' Cylindrical Skin Vibration due to Acoustic Pressure Field ')
disp(' Franken upper limit curve is used per NASA CR-1302 ')
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
clear ar;
clear s;
clear spl;
clear psd;
clear E;
%
disp(' ')
disp('The input file must have two columns:  freq(Hz) & SPL(dB) ');
disp('The frequency resolution must be one-third octave band ');
%
disp(' ')
disp(' Select file input method ');
disp('   1=external ASCII file ');
disp('   2=file preloaded into Matlab ');
file_choice = input('');
%
if(file_choice==1)
    disp(' Enter the input filename ');
    filename = input(' ','s');
    fid = fopen(filename,'r');
    THM = fscanf(fid,'%g %g',[2 inf]);
    THM=THM';
else
    THM = input(' Enter the matrix name:  ');
end
f=THM(:,1);
spl=THM(:,2);
ilast=length(spl);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
db=spl;
%
[oadb]=oaspl_function(db);

out1=sprintf('\n  Overall SPL = %8.4g dB \n',oadb);
disp(out1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    cref=200000./12.;
%
    disp(' ')
	disp(' Enter material:  1=aluminum  2=steel  3=other ')
    imat=input(' ');
%
    if(imat ~=1 && imat ~=2 && imat ~= 3)
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
%
		disp(' Enter cylindrical skin weight density (lbm/in^3) ');
   		W=input(' ');
%
		disp(' Enter elastic modulus (lbf/in^2) ');
   		E=input(' ');
%
		cmat = sqrt( (E/W)*(32.2/12.) );
%
    end
%
	out1=sprintf('\n Weight Density = %10.3g lbm/in^3 ',W);
    disp(out1)
%
	out1=sprintf('\n\n Speed of Sound in Material = %10.3g ft/sec ',cmat);	
    disp(out1)
%
	W=W*(12.^3);
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
	disp(' Enter skin thickness (in) ');
   	thickness=input(' ');
% 
    thickness=thickness/12.;
%
    W=W*thickness;
%
	out1=sprintf(' Weight Density (per area) = %12.3f lbm/ft^2 ',W);
    disp(out1)
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
BWT=(2.^(1./6.))-1./(2.^(1./6.));
%
for(i=1:ilast)
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
		df = BWT*f(i);
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
r_disp=0.;
%
for(i=1:(ilast-1))
%
    s(i)=log( psd(i+1)/psd(i) )/log( f(i+1)/f(i) );
%
    if(s(i) < -1.0001 ||  s(i) > -0.9999 )
%  
        racc= ( psd(i+1) * f(i+1)- psd(i)*f(i))/( s(i)+1.);
%
    else
%
        racc= psd(i)*f(i)*log( f(i+1)/f(i));
    end
    rb=rb+racc;
% 
    if(f(i) < 2050.)
        ra=rb;
    end
end
%
grms=sqrt(ra);
grmsb=sqrt(rb);
disp_rms=sqrt(r_disp);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
clear a;
a=psd;
%
n=length(f);
%
for i=1:n
    a(i)=a(i)*(386.^2)/((2.*pi*f(i))^4);
end
%
rd=0.;
%
nn=length(f)-1;
%
for  i=1:nn
%    
    s(i)=log10( a(i+1)/ a(i) )/log10( f(i+1)/f(i) );   
%
end
%disp(' RMS calculation ');
%
for i=1:nn
    if(s(i) < -1.0001 |  s(i) > -0.9999 )
        rd = rd + ( a(i+1) * f(i+1)- a(i)*f(i))/( s(i)+1.);
    else
        rd = rd + a(i)*f(i)*log( f(i+1)/f(i));
    end
end    
drms=sqrt(rd);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
out1=sprintf('\n Ring Frequency = %12.4g Hz ',cmat/(pi*stationdiam));
disp(out1)
%
disp(' ');
disp(' Overall Skin Levels ');
%
out1=sprintf('\n\n Acceleration (up to 2000 Hz) = %12.4g GRMS ',grms );
disp(out1)
%
out1=sprintf('\n Acceleration (up to 10,000 Hz) = %12.4g GRMS\n',grmsb );
disp(out1)
%
out1=sprintf('\n Displacement (up to 2000 Hz) = %12.4g inch RMS ',drms );
disp(out1)
%
disp(' ');
disp(' Plot the PSD? ')
choice = input(' 1=yes 2=no ');
%
sz=size(f);
if(sz(2)>sz(1))
    f=f';
end
sz=size(psd);
if(sz(2)>sz(1))
    psd=psd';
end
%
disp(' ');
disp(' output file: va_psd ');
va_psd=[f psd];
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(choice == 1)
    figure(1);     
    plot(f,psd)
    xlabel(' Frequency (Hz)');
    ylabel(' Accel (G^2/Hz)'); 
    at = sprintf(' Power Spectral Density  Overall Level = %6.3g GRMS ',grmsb);   
    title(at);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log'); 
    grid;
    psd_max=max(psd);
    psd_min=min(psd); 
%    
    for(i=1:12)
        bn=10^(5-i);
        if(psd_max < bn)
            ymax=bn;
        end
    end
%
    ymin=ymax/100;    
    if(psd_min < psd_max/1000)
       ymin=ymax/1000;    
    end 
    if(psd_min < psd_max/1000)
       ymin=ymax/1000;    
    end    
    fmax=max(f);
    set(gca, 'XTickMode', 'manual');
    pfmax=fmax;
    if(fmax<20000)
        pfmax=20000;
        set(gca,'xtick',[10 100 1000 10000 20000]); 
    end    
    if(fmax<10000)
        pfmax=10000;
        set(gca,'xtick',[10 100 1000 10000]); 
    end
    if(fmax<5000)
        pfmax=5000;
        set(gca,'xtick',[10 100 1000 5000]);   
    end
    if(fmax<2000)
        pfmax=2000;
        set(gca,'xtick',[10 100 1000 2000]);      
    end
    if(fmax<1000)
        pfmax=1000;
        set(gca,'xtick',[10 100 1000]);      
    end
    fmin=10;
    axis([fmin,pfmax,ymin,ymax]);  
%
end
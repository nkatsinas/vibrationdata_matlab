%
%  octaves_alt.m  ver 1.1  by Tom Irvine
%

function[fl,fc,fu,imax]=octaves_alt(ioct)
%
%
if(ioct==1)  % full octave
    oex=1/2;
	fc(1)=2.;
	fc(2)=4.;
	fc(3)=8.;
	fc(4)=16.;
	fc(5)=31.5;
	fc(6)=63.;
	fc(7)=125.;
	fc(8)=250.;
	fc(9)=500.;
	fc(10)=1000.;
	fc(11)=2000.;
	fc(12)=4000.;
	fc(13)=8000.;
	fc(14)=16000.;
end
if(ioct==2)  % 1/3 octave
    oex=1/6;
	fc(1)=2.5;
	fc(2)=3.15;
	fc(3)=4.;
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
end
if(ioct==3)  % 1/6 octave
    oex=1/12;
	fc(1)=2.5;
	fc(3)=3.15;
	fc(5)=4.;
	fc(7)=5.;
	fc(9)=6.3;
	fc(11)=8.;
	fc(13)=10.;
	fc(15)=12.5;
	fc(17)=16.;
	fc(19)=20.;
	fc(21)=25.;
	fc(23)=31.5;
	fc(25)=40.;
	fc(27)=50.;
	fc(29)=63.;
	fc(31)=80.;
	fc(33)=100.;
	fc(35)=125.;
	fc(37)=160.;
	fc(39)=200.;
	fc(41)=250.;
	fc(43)=315.;
	fc(45)=400.;
	fc(47)=500.;
	fc(49)=630.;
	fc(51)=800.;
	fc(53)=1000.;
	fc(55)=1250.;
	fc(57)=1600.;
	fc(59)=2000.;
	fc(61)=2500.;
	fc(63)=3150.;
	fc(65)=4000.;
	fc(67)=5000.;
	fc(69)=6300.;
	fc(71)=8000.;
	fc(73)=10000.;
	fc(75)=12500.;
	fc(77)=16000.;
	fc(79)=20000.;
	for i=2:2:78
		fc(i)=sqrt(fc(i-1)*fc(i+1) );
	end
end
if(ioct==4)  % 1/12 octave
    
    oex=1/24;
            
    [fc]=one_twelfth_octave();
                
end     
if(ioct==5)  % 1/24 octave
          	
    
    oex=1/48;    
    
    fa=one_twelfth_octave();
    n=length(fa);
            
    fa(end+1)=fa(end)*2^(1/12);
            
    fc=zeros(2*n,1);
            
    for i=1:n
        fc(2*i-1)=fa(i);
        fc(2*i)=sqrt(fa(i)*fa(i+1));
    end    
            
end 

imax=length(fc);

fl=zeros(imax,1);
fu=zeros(imax,1);
fc=fix_size(fc);

	for i=1:imax
			fl(i)=fc(i)/(2.^oex);
	end
	for i=1:(imax-1)
			fu(i)=fl(i+1);	
	end
	fu(imax)=fc(i)*(2.^oex);
    
    
    
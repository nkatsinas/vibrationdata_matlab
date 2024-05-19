disp(' ')
disp('  oct_to_onethird.m  version 1.1, July 9, 2018 ')
disp('  by Tom Irvine ')
disp('  Email:  tom@irvinemail.org ')
%
disp(' ')
disp(' This program converts a full-octave SPL to one-third format.')
disp(' ')
disp(' The input file must have two columns: freq(Hz) and level(dB) ')
%
clear db;
clear rms;
clear sum;
clear ms;
clear oadb;
clear pressure;
%
disp(' ')
disp(' Select file input method ');
disp('   1=external ASCII file ');
disp('   2=file preloaded into Matlab ');
file_choice = input('');
%
if(file_choice==1)
    [filename, pathname] = uigetfile('*.*');
    filename = fullfile(pathname, filename);
%      
    fid = fopen(filename,'r');
    THM = fscanf(fid,'%g %g',[2 inf]);
    THM=THM';        
%    
else
    THM = input(' Enter the matrix name:  ');
end
%
dB=THM(:,2);
%
[oadb]=oaspl_function(dB);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
clear f;
clear fc;
clear aspl;
clear summ;
summ=0.;
%
f=THM(:,1);
aspl=THM(:,2);
%
disp(' ');
disp(' Convert to one-third octave format');
disp(' ');
%
	fc(1)=10.;
	fc(2)=12.5; 
	fc(3)=16.;
	fc(4)=20.;
	fc(5)=25.;
	fc(6)=31.5;
	fc(7)=40.;
	fc(8)=50.;
    fc(9)=63.;
	fc(10)=80.;
	fc(11)=100.;
	fc(12)=125.;
	fc(13)=160.;
	fc(14)=200.;
	fc(15)=250.;
	fc(16)=315.;
    fc(17)=400.;
	fc(18)=500.;
	fc(19)=630.;
	fc(20)=800.;
	fc(21)=1000.;
	fc(22)=1250.;
	fc(23)=1600.;
	fc(24)=2000.;
    fc(25)=2500.;
	fc(26)=3150.;
	fc(27)=4000.;
	fc(28)=5000.;
	fc(29)=6300.;
	fc(30)=8000.;
	fc(31)=10000.;
	fc(32)=12500.;
	fc(33)=16000.;
	fc(34)=20000.;
	fc(35)=25000.;
	fc(36)=31500.;
%
    num=max(size(THM(:,1)));
    k=1;
	for(i=1:36)
%
		for(j=1:(num-1))
%
			if(fc(i)>f(j) && fc(i) < f(j+1) )
%
				x1=f(j);
				x2=f(j+1);
%                
				x=fc(i);
%
				y1=aspl(j);
				y2=aspl(j+1);
%
				LXL=log10(x2)-log10(x1);
%
				if(LXL <=1.0e-20)
					disp(' LXL error ');
                end
%
				c2=(log10(x)-log10(x1))/LXL;
				c1=1-c2;
%
				bspl(k)=c1*y1+c2*y2;
%
				db=bspl(k);
                freq(k)=fc(i);
                k=k+1;             
				ms = ref*10^(db/20);
				summ=summ+(ms^2);
%
				break;
            end
			if(fc(i)==f(j))
				bspl(k)=aspl(j);
				db=bspl(k);
                freq(k)=fc(i);
                k=k+1;
				ms = ref*10.^(db/20);
				summ=summ+(ms^2);
				break;
            end
     		if(fc(i)==f(j+1))
				bspl(k)=aspl(j+1);
				db=bspl(k);
                freq(k)=fc(i);
                k=k+1;
				ms = ref*10.^(db/20);
				summ=summ+(ms^2);
				break;
            end       
        end
    end
%
	summ=sqrt(summ);
%
	rms=20.*log10(summ/ref);
%
%%	out1=sprintf('\n\n  Overall Level = %8.4g dB\n',rms);
%%    disp(out1);
%
bspl=bspl-(rms-oadb);
%
    spl_out=[freq' bspl'];
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
out1=sprintf('\n  Overall Level = %8.4g dB \n',oadb);
disp(out1)
figure(1);
plot(spl_out(:,1),spl_out(:,2));
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','lin')
grid on;
out1=sprintf(' One-Third Octave Sound Pressure Level  OASPL = %8.4g dB ',oadb);
title(out1)
xlabel(' Center Frequency (Hz) ');
ylabel(' SPL (dB) ');
%
disp(' ');
disp(' Output matrix is:  spl_out ');
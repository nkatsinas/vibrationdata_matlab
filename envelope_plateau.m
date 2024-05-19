disp(' ');	
disp(' envelope_plateau.m   ver 1.7   March 7, 2013');
disp(' ');	
disp(' by Tom Irvine ');
disp(' Email:  tomirvine@aol.com ');
disp(' ');	
disp(' This program determines an optimum envelope for an acceleration');
disp(' power spectral density.');
disp(' ');	
disp(' The optimum envelope is the that which yields the lowest GRMS and ');
disp(' Velocity RMS values. ');
disp(' ');	
disp(' The acceleration is assumed to be the base excitation for an array');
disp(' of independent, parallel single-degree-of-freedom systems.');
disp(' ');	
disp(' The vibration response spectrum method is used to justify the envelope.');
disp(' ');	
disp(' The damping ratio is fixed at 0.05, equivalent to Q=10. ');
disp(' The natural frequency is an independent variable.');
disp(' ');	
disp(' The user must input a power spectral density file. ');
disp(' The file must be ASCII text with two columns: ');
disp(' Freq(Hz) PSD(G^2/Hz) ');
disp(' ');	
disp(' The format is free, but no header lines are allowed. ');
disp('________________________________________________________________________');
%
clear THM;
clear input_vrs;
clear best_psd;
clear best_vrs;
clear fin;
clear psdint;
clear f_ref;
clear interp_psdin;
%
tpi=2.*pi;
dam=0.05;
%
MAX=20000;
MAX2=100000;
%
% nbreak   number of breakpoints
% ntrials  number of trails
% ntrials2
% n_ref    number of reference coordinates
%
record = 1.0e+90;
grmslow=1.0e+50;
vrmslow=1.0e+50;
drmslow=1.0e+50;
%
% f_ref[MAX]    reference natural frequency
% a_ref[MAX]    reference vrs(GRMS)
%
% fin[MAX]      input frequency
% psdin[MAX]    input PSD
% inslope[MAX]  input slope
%
% interp_psdin[MAX] interpolated input PSD
%
% f_sam[MAX]    frequency of sample breakpoint
% apsd_sam[MAX] acceleration PSD amplitude of sample breakpoint
% slope[MAX]
%
% f_samfine[MAX]    frequency of sample breakpoint, interpolated
% apsd_samfine[MAX] acceleration PSD of sample breakpoint, interpolated  
%
    disp(' ');
	disp(' Enter goal.  Minimize: ');
    disp(' ');
	disp(' 1=acceleration ');
	disp(' 2=acceleration, velocity ');
	disp(' 3=acceleration, velocty, displacement ');
	disp(' 4=acceleration, displacement ');
	disp(' 5=displacement ');
%
    goal=input(' ');	
%	
	disp(' Input number of trials ');
    ntrials=input(' ');
%
%	 disp(' Input number of trials for phase 2 (refinement phase): ');
%    scanf("%ld", &ntrials2);
%
if(ntrials > MAX2)
		disp(' The maximum number of trials is 100,000 ');
		ntrials=MAX2;
end
%
disp(' ');
disp(' Enter number of breakpoints for envelope (min=3 max=12): ');
nbreak=input(' ');
%
if(nbreak < 3  )
    nbreak=3;  
end
if(nbreak > 12 )
    nbreak=12; 
end
%
f_ref=zeros(nbreak,1);
a_ref=zeros(nbreak,1);   
f_sam=zeros(nbreak,1);
apsd_sam=zeros(nbreak,1);
slope=zeros(nbreak,1);
f_samfine=zeros(nbreak,1);
apsd_samfine=zeros(nbreak,1);
vrs_samfine=zeros(nbreak,1);
xf=zeros(nbreak,1);
xapsd=zeros(nbreak,1);
%
disp(' ');
disp(' Constrain slopes?  1=yes 2=no ');
%   
ic=input(' '); 
%   
if(ic==1)
	   disp(' Enter absolute slope limit (dB/octave): ');
	   slopec=input(' ');
else
	   slopec = 60.;
end
%
slopec=abs(slopec);
slopec=(slopec/10.)/log10(2.);
%
disp(' ');
disp(' Further constrain initial slope to be positive ?  1=yes 2=no ');
initial=input(' ');
%   
disp(' ');
disp(' Further constrain final slope to be negative ?  1=yes 2=no ');
final=input(' ');
%
nin=0;
nnn=0;
%
ocn=1./48.;
%
disp(' ');
disp(' Select octave spacing for interpolation and analysis. ');
disp(' 1=1/12   2=1/24   3=1/48   4=1/96  ');
%
io=input(' ');
%
if(io==1)
    ocn=1./12.;
end
if(io==2)
    ocn=1./24.;
end
if(io==3)
    ocn=1./48.; 
end
if(io==4)
    ocn=1./96.; 
end
%
octave=-1.+(2.^ocn);
%
disp(' Input starting analysis frequency (Hz):  ');
f1=input(' ');
%   
disp(' Input ending analysis frequency (Hz):  ');
f2=input(' ');	
%
 ffmin=f1;
 ffmax=f2;
 %
 if(ffmax<=1000)
     ffmax=1000;
 end
  if(ffmax>1000 && ffmax<=2000)
     ffmax=2000;
  end
% 
%%
%%  Input PSD file
%%
disp(' ');
disp(' Select PSD file input method ');
disp('   1=external ASCII file ');
disp('   2=file preloaded into Matlab ');
disp('   3=Excel file ');
file_choice = input('');
%
clear THM;
%
if(file_choice==1)
        [filename, pathname] = uigetfile('*.*');
        filename = fullfile(pathname, filename);
        fid = fopen(filename,'r');
        THM = fscanf(fid,'%g %g',[2 inf]);
        THM=THM';
end
if(file_choice==2)
        THM = input(' Enter the matrix name:  ');
end
if(file_choice==3)
        [filename, pathname] = uigetfile('*.*');
        xfile = fullfile(pathname, filename);
%        
        THM = xlsread(xfile);
%         
end
%
  fin=THM(:,1);
psdin=THM(:,2);
%
ierror=0;
%
if( min(psdin) <= 0. )
			   disp(' Input error:  each PSD amplitude must be > 0.');
			   ierror = 999;
end               
%
if( min(fin) < 0. )
			   disp(' Input error:  each frequency must be > 0.');
			   ierror = 999;
end               
%
if(fin(1)<1.0e-04)
    fin(1)=1.0e-04;
end
%
clear length;
nin = length(fin);
%
inslope=zeros((nin-1),1);
%
for i=2:nin
    inslope(i-1)= log(psdin(i)/psdin(i-1))/log(fin(i)/fin(i-1));
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
ra=0;
%
for i=1:nin-1
        if(inslope(i) < -1.0001 ||  inslope(i) > -0.9999 )
            ra = ra + ( psdin(i+1) * fin(i+1)- psdin(i)*fin(i))/( inslope(i)+1.);
        else
            ra = ra + psdin(i)*f(i)*log( fin(i+1)/fin(i));
        end
end
grms_input=sqrt(ra);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
out1=sprintf('\n Number of input coordinates = %ld ',nin);
disp(out1);
%
% Interpolate Input PSD
%
if( f1 < fin(1) ) 
        f1 = fin(1); 
end
%
%% if( f2 > fin(nin) )
%%         f2 = fin(nin); 
%% end
%
f_ref=zeros(MAX,1);
%
f_ref(1)=f1;
%
for i=2:MAX
%	
    f_ref(i)=f_ref(i-1)*(2.^ocn);
%
	if(	 f_ref(i) >= f2 )
        f_ref(i)=f2;
        n_ref=i;
        break;
    end    
%	
end
%
clear temp;
temp=f_ref(1:n_ref);
clear f_ref;
f_ref=temp;
clear temp;
%
out1=sprintf(' n_ref=%ld \n',n_ref);
disp(out1);
%
interp_psdin(1)=psdin(1);
%
	for(i=2:n_ref)
		for( j=1:nin-1)
%            
		   if( f_ref(i) >= fin(j) && f_ref(i) <= fin(j+1) )   
		         interp_psdin(i)= psdin(j)*((f_ref(i)/fin(j))^inslope(j));
           end
%           
        end
    end
%
szf=size(f_ref);
if(szf(2)>szf(1))
    f_ref=f_ref';
end
%
szp=size(interp_psdin);
if(szp(2)>szp(1))
    interp_psdin=interp_psdin';
end
%
clear length;
n_ref=min([length(f_ref) length(interp_psdin)]);
%
clear temp;
temp=f_ref;
clear f_ref;
f_ref=temp(1:n_ref);
%
clear temp;
temp=interp_psdin;
clear interp_psdin;
interp_psdin=temp(1:n_ref);
clear temp;
%
interpolated_PSD=[f_ref interp_psdin];
%
% Convert the input PSD to a VRS
%
    [a_ref]=env_make_input_vrs(interp_psdin,n_ref,f_ref,octave,dam);
%
    sz=size(a_ref);
    if(sz(2)>sz(1))
        a_ref=a_ref';
    end
    input_vrs=[f_ref a_ref];
%
	for ik=1:ntrials
%	   
	   if(rand()>0.5 || ik<20)
%	   
			% Generate the sample psd
            [f_sam,apsd_sam]=env_generate_sample_psd_plateau(n_ref,...
                               nbreak,f_ref,ik,slopec,initial,final,f1,f2);            
%
	   else
%
			[f_sam,apsd_sam]=env_generate_sample_psd2_plateau(n_ref,...
                      nbreak,f_ref,xf,xapsd,slopec,initial,final,ik,f1,f2);
%
       end
%
       if(rand()>0.4)
            for i=3:2:nbreak
                apsd_sam(i)=apsd_sam(i-1);
            end 
       else
            for i=2:2:nbreak
                apsd_sam(i)=apsd_sam(i-1);
            end            
       end
%
       for i=1:nbreak
            out1=sprintf(' %8.2f \t %8.4g ',f_sam(i),apsd_sam(i));
            disp(out1);
       end    
%
%      Interpolate the sample psd
       [f_samfine,apsd_samfine]=env_interp_sam(f_sam,apsd_sam,nbreak,n_ref,f_ref);
%                         
%      Calculate the vrs of the sample psd
       [vrs_samfine]=env_vrs_sample(n_ref,f_ref,octave,dam,apsd_samfine);
%    
%      Compare the sample vrs with the reference vrs
	   [scale]=env_compare(n_ref,a_ref,vrs_samfine);
%
%      scale the psd
       scale=(scale^2.);
       apsd_sam=apsd_sam*scale;
%       
%      calculate the grms value 
%             
       [grms]=env_grms_sam(nbreak,f_sam,apsd_sam);
%
       [vrms]=env_vrms_sam(nbreak,f_sam,apsd_sam);
%
       [drms]=env_drms_sam(nbreak,f_sam,apsd_sam);
%	 
       [iflag,record]=env_checklow(grms,vrms,drms,grmslow,vrmslow,drmslow,record,goal);
%       
       if(iflag==1)
%           
           if(drms<drmslow)
				drmslow=drms;
           end
		   if(vrms<vrmslow)
				vrmslow=vrms;
           end
		   if(grms<grmslow)
				grmslow=grms;
           end
%           
		   drmsp=drms;
		   vrmsp=vrms;
		   grmsp=grms;
%
		   ikbest=ik;
%          
           nnn=ntrials;
%
           xf=f_sam;
 		   xapsd=apsd_sam;	           
%
           xslope=slope;
%       
% Interpolate the best psd
%
          sz=size(f_ref);
          if(sz(2)>sz(1))
             f_ref=f_ref';
          end 
%         
          [xapsdfine]=env_interp_best(nbreak,n_ref,xf,xapsd,f_ref);
%
          sz=size(xapsdfine);
          if(sz(2)>sz(1))
             xapsdfine=xapsdfine';
          end 
%
          sz=size(xf);
          if(sz(2)>sz(1))
             xf=xf';
          end 
%
          sz=size(xapsd);
          if(sz(2)>sz(1))
             xapsd=xapsd';
          end           
%
          best_psd=[xf xapsd];
%
% Calculate the vrs of the best vrs
%
          [xvrs]=env_vrs_best(n_ref,dam,octave,xapsdfine,f_ref);          
%
          sz=size(xvrs);
          if(sz(2)>sz(1))
             xvrs=xvrs';
          end
%
          best_vrs=[f_ref xvrs];
%
	          f_sam=xf;
		   apsd_sam=xapsd;
%           
       end      
%	  
        out1=sprintf('   Trial: drms=%10.4g  vrms=%10.4g  grms=%10.4g ',drms,vrms,grms); 
        out2=sprintf('  Record: drms=%10.4g  vrms=%10.4g  grms=%10.4g \n',drmsp,vrmsp,grmsp); 
        disp(out1);
        disp(out2);
%
    end
%
	nnn=0;
%
	disp('________________________________________________________________________');
%
    f_sam=xf;
	apsd_sam=xapsd;    
%
	disp('Optimum Case');
    disp(' ');
%
    out1=sprintf(' drms=%10.4g  vrms=%10.4g  grms=%10.4g ',drmsp,vrmsp,grmsp);
    disp(out1);	
%	
	disp('________________________________________________________________________');
%
    disp(' ');
    disp('         Input VRS written to file:  input_vrs ');
	disp('       Optimum PSD written to file:  best_psd ');
	disp('       Optimum VRS written to file:  best_vrs ');
 %
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %
 figure(1)
 %
 ymin=min(psdin);
 if(ymin>min(best_psd(:,2)))
     ymin=min(best_psd(:,2));
 end
 %
 ymax=max(psdin);
 if(ymax<max(best_psd(:,2)))
     ymax=max(best_psd(:,2));
 end
 %
 ymax= 10^(round(log10(ymax)+0.8));
 ymin= 10^(round(log10(ymin)-0.2));
 %
 plot(fin,psdin,best_psd(:,1),best_psd(:,2));
 title('Power Spectral Density ');
 out1=sprintf('Input, %6.3g GRMS',grms_input);
 out2=sprintf('Envelope, %6.3g GRMS',grmsp);
 legend (out1,out2);    
 grid on;
 xlabel('Frequency(Hz)');
 ylabel('Accel(G^2/Hz)');
 set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log','XminorTick','off','YminorTick','on');
 axis([ffmin,ffmax,ymin,ymax]);
 %
 if(f1==20 && ffmax==2000)
        set(gca,'xtick',[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
        set(gca,'XTickLabel',{'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})
 end
 if(f1==10 && ffmax==2000)
        set(gca,'xtick',[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
        set(gca,'XTickLabel',{'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})   
 end
 if(f1==10 && ffmax==1000)
        set(gca,'xtick',[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000])
        set(gca,'XTickLabel',{'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000'})   
 end
 %
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %
 figure(2)
 %
 ymin=min(input_vrs(:,2));
 if(ymin>min(best_vrs(:,2)))
     ymin=min(best_vrs(:,2));
 end
 %
 ymax=max(input_vrs(:,2));
 if(ymax<max(best_vrs(:,2)))
     ymax=max(best_vrs(:,2));
 end
 %
 ymax= 10^(round(log10(ymax)+0.8));
 ymin= 10^(round(log10(ymin)-0.2));
 %
 plot(input_vrs(:,1),input_vrs(:,2),best_vrs(:,1),best_vrs(:,2));
 title('Vibration Response Spectra Q=10 ');
 legend ('Input','Envelope');       
 grid on;
 xlabel('Natural Frequency(Hz)');
 ylabel('Accel(GRMS)');
 %
 set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log','XminorTick','off','YminorTick','on');
 axis([ffmin,ffmax,ymin,ymax]);
 %
 if(f1==20 && ffmax==2000)
        set(gca,'xtick',[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
        set(gca,'XTickLabel',{'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})
 end
 if(f1==10 && ffmax==2000)
        set(gca,'xtick',[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
        set(gca,'XTickLabel',{'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})   
 end
 if(f1==10 && ffmax==1000)
        set(gca,'xtick',[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000])
        set(gca,'XTickLabel',{'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000'})   
 end
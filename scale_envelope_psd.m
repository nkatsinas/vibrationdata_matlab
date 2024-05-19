
%
%   scale_envelope_psd.m  ver 1.0  by Tom Irvine
%
%   This script fine-tunes an envelope psd with two goals:
%     1.  verify that is covers the fds for Q=10 & 30 and b=4 & 8
%     2.  optimize the psd so that it has the least overall level
%         while still meeting the first goal
%
%   ---------  Input  ---------     
%
%   The input_psd array must have two columns:  
%      freq(Hz) accel(G^2/Hz)
%
%   The input psd must have one of the following sets of coordinates &
%   corresponding shape
%
%   2 arbitrary
%   3 arbitrary
%   3 ramp-plateau
%   4 arbitrary
%   4 ramp-plateu-ramp
%   5 arbitrary
%   5 ramp-plateau-ramp-plateau
%   6 ramp-plateau-ramp-plateau-ramp
%   5 ramp-ramp-plateau-ramp
%   4 ramp-ramp-plateau
%   6 arbitrary
%   7 arbitrary
%   8 arbitrary
%   9 arbitrary
%   10 arbitrary
%
%   The script will automatically detect which of these formats the input
%   psd meets
%
%
%   The input_fds array must have five columns:  
%      natural freq(Hz) fds_Q10_b4 fds_Q10_b8 fds_Q30_b4 fds_Q30_b8
%
%   
%   Each frequency column must be in some fractional octave format such as:
%    1/3, 1/6, 1/12, 1/24, 1/48
%    
%
%   T is the psd duration (sec)
%
%
%   ntrials = number of trials, such as 1000
%
%   goal: optimization goal, minimize:
%    1=acceleration
%    2=acceleration & velocity
%    3=acceleration, velocity, displacement
%    4=displacement
%    5=velocity & displacement
%    6=acceleration & jerk
%    7=velocity, acceleration & jerk
%
%   ---------  Output  ---------   
%
%   The best_envelope_psd array has two columns:  
%      freq(Hz) accel(G^2/Hz)
%
%   The best_envelope_fds array has five columns:  
%      natural freq(Hz) fds_Q10_b4 fds_Q10_b8 fds_Q30_b4 fds_Q30_b8
%
function[best_envelope_psd,best_envelope_fds]=scale_envelope_psd(input_psd,input_fds,T,ntrials,goal)
%

tic

disp(' ');
disp(' * * * * * * * * * * * *');
disp(' ');

fig_num=1;

nmetric=1;

T_out=T;

f=input_psd(:,1);
a=input_psd(:,2);

fn=input_fds(:,1);

n_ref=length(fn);

f1=fn(1);
f2=fn(end);

foct=fn;

nbreak=length(f);

Q = [10 30];
b = [4 8];

bex=b;
fds_ref=input_fds(:,2:end);

%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nbreak>=11)
    disp(' The input psd is limited to 10 coordinates');
    return;
end


if(nbreak==2)
    npb=1;          % 1
end
if(nbreak==3)
    npb=2;          % 2
    if(a(2)==a(3))
        npb=3;      % 3
    end    
end
if(nbreak==4)
    npb=4;          % 4 
    if(a(2)==a(3))
        npb=5;      % 5 
    end
    if(a(3)==a(4))
        npb=10;     % 10 
    end        
end
if(nbreak==5)
    npb=6;          % 6 
    if(a(2)==a(3) && a(4)==a(5))
        npb=7;      % 7 
    end
    if(a(2)~=a(3) && a(4)==a(5))
        npb=9;      % 9 
    end    
end
if(nbreak==6)
    npb=11;         % 11 
    if(a(2)==a(3) && a(4)==a(5))
        npb=8;      % 8 
    end     
end
if(nbreak==7)
    npb=12;         % 12      
end
if(nbreak==8)
    npb=13;         % 13      
end
if(nbreak==9)
    npb=14;         % 14      
end
if(nbreak==10)
    npb=15;         % 15      
end

NQ=length(Q);

for i=1:NQ
    damp(i)=1/(2*Q(i));
end

Q=[ Q(1) Q(1) Q(2) Q(2) ];
damp=[ damp(1) damp(1) damp(2) damp(2) ]; 
 bex=[  bex(1)  bex(2)  bex(1)  bex(2) ];

iu=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%

record = 1.0e+90;
jrmslow=1.0e+50;
grmslow=1.0e+50;
vrmslow=1.0e+50;
drmslow=1.0e+50;
error_rec=1.0e+50;

%

slopec=18;  % maximum slope is 18 dB/octave

slopec=(slopec/10.)/log10(2.);

xf=input_psd(:,1);
xapsd=input_psd(:,2);

initial=2;
final=2;

disp(' ');
disp(' Generate sample PSDs');
disp(' ');
%

progressbar;

plateau=0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for ik=1:ntrials
    
    progressbar(ik/ntrials);
    
%	   
   if(ik==1)
       
       f_sam=xf;
       apsd_sam=xapsd;
       
   else
       [f_sam,apsd_sam,max_sss,slopec]=...
                env_generate_sample_psd2_altz(n_ref,nbreak,npb,fn,xf,xapsd,slopec,initial,final,ik,f1,f2,plateau,foct);
   end
 
   
%%
%
%      Interpolate the sample psd

    [fn,apsd_samfine]=env_interp_sam(f_sam,apsd_sam,nbreak,n_ref,fn);
% 
    a11=max(apsd_samfine);
    a22=min(apsd_samfine);
    
    if(a22<1.0e-20)
    
        out1=sprintf('\n max(apsd_samfine)=%8.4g  min(apsd_samfine)=%8.4g \n',a11,a22);
        disp(out1);    
    
    end

    
    if( max(apsd_samfine)==0 || min(apsd_samfine)==0 )
        disp('error');
        return;
    end
    
%      Calculate the fds of the sample psd


    [fds_samfine]=env_fds_batch_alt(apsd_samfine,n_ref,fn,damp,bex,T_out,iu,nmetric);
    
    
%    
%      Compare the sample fds with the reference fds
    [scale]=env_compare_alt(n_ref,fds_ref,fds_samfine,bex);
%

if(ntrials==1)
    scale=1;
end


%      scale the psd
    scale=(scale^2.);
    apsd_sam=apsd_sam*scale;
%       
%      calculate the grms value 
%  
    [jrms]=env_jrms_sam(nbreak,f_sam,apsd_sam);
%
    [grms]=env_grms_sam(nbreak,f_sam,apsd_sam);
%
    [vrms]=env_vrms_sam(nbreak,f_sam,apsd_sam);
%
    [drms]=env_drms_sam(nbreak,f_sam,apsd_sam);
%	 
    [iflag,record]=env_checklow22(jrms,grms,vrms,drms,jrmslow,grmslow,vrmslow,drmslow,record,goal,apsd_sam); 
% 
    [max_sss,min_fff]=freq_slope_check(f_sam,apsd_sam);


    
    if( ik==1 || (iflag==1 && max_sss<slopec))      
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
        if(jrms<jrmslow)
			jrmslow=jrms;
        end        
%
        f_sam=fix_size(f_sam);
        apsd_sam=fix_size(apsd_sam);

        xf=f_sam;
 		xapsd=apsd_sam;
        
        power_spectral_density=[f_sam(1:nbreak) apsd_sam(1:nbreak)];
        
        drms_rec=drms;
        vrms_rec=vrms;
        grms_rec=grms;
        jrms_rec=jrms;
 
        out1=sprintf('\n Trial %ld, PSD Coordinates \n',ik);
        disp(out1);
        disp('  Freq(Hz)  Accel(G^2/Hz) '); 
        for i=1:nbreak
            out1=sprintf(' %8.2f \t %8.4g ',f_sam(i),apsd_sam(i));
            disp(out1);
        end
        
        disp(' ');      
%
        out1=sprintf('   Trial: drms=%9.4g  vrms=%9.4g  grms=%9.4g  jrms=%9.4g',drms,vrms,grms,jrms); 
        out2=sprintf('  Record: drms=%9.4g  vrms=%9.4g  grms=%9.4g  jrms=%9.4g\n',drms_rec,vrms_rec,grms_rec,jrms_rec); 
        disp(out1);
        disp(out2);
        
%    
    end

end

xf=round(xf);

pause(0.3);
progressbar(1);

%       
% Interpolate the best psd
%         
[xapsdfine]=env_interp_best(nbreak,n_ref,xf,xapsd,fn);

%
% Calculate the fds of the best psd
% 
[xfds]=env_fds_batch_alt(xapsdfine,n_ref,fn,damp,bex,T_out,iu,nmetric);

best_envelope_fds=[fn xfds];

%
% [grms]=env_grms_sam(nbreak,f_sam,xapsd);
%
% [vrms]=env_vrms_sam(nbreak,f_sam,xapsd);
%
% [drms]=env_drms_sam(nbreak,f_sam,xapsd);
%
   grms=grms_rec;
   vrms=vrms_rec;
   drms=drms_rec;

fmin=f1;
fmax=f2;
    
%
disp('_____________________________________________________________________');
%
%
disp('Optimum Case   (copy and paste into Excel)');
disp(' ');

out1=sprintf(' Freq(Hz) \t Accel(G^2/Hz)  ');
disp(out1);

for i=1:nbreak
    out1=sprintf(' %6.1f \t%8.4g  ',power_spectral_density(i,1),power_spectral_density(i,2));
    disp(out1);
end


[max_sss,min_fff]=freq_slope_check(power_spectral_density(:,1),power_spectral_density(:,2));
    
out1=sprintf('\n max slope=%8.3g  min freq sep=%8.4g\n',max_sss,min_fff);
disp(out1);       



[~,grms] = calculate_PSD_slopes(power_spectral_density(:,1),power_spectral_density(:,2));

%
out1=sprintf(' drms=%9.4g  vrms=%9.4g  grms=%9.4g ',drms,vrms,grms);
disp(out1);	
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
t_string=...
sprintf(' Power Spectral Density  Overall Level = %6.3g GRMS ',grms); 
if(iu==1)
    ylab='Accel (G^2/Hz)';
else
    ylab='Accel ((m/sec^2)^2/Hz)';    
end    
x_label=sprintf(' Frequency (Hz)');

[fig_num,h2]=plot_PSD_function(fig_num,x_label,ylab,t_string,power_spectral_density,fmin,fmax);

fsize=11.5;
set(gca,'Fontsize',fsize);

pname='optimized_psd_plot.emf';
print(h2,pname,'-dmeta','-r300');

%
best_envelope_psd=power_spectral_density;

%
x_label=sprintf(' Natural Frequency (Hz)');
ylab='Damage Index';
%
disp(' ');
disp(' FDS output arrays: ');
disp('   ');
%

uiu=(length(unique(damp))+length(unique(bex)));

for i=1:length(damp)
    
%
        xx=zeros(n_ref,1);
        ff=zeros(n_ref,1);
%        
        for k=1:n_ref
            xx(k)=xfds(k,i);
            ff(k)=fds_ref(k,i);
        end
%
        xx=fix_size(xx);
        ff=fix_size(ff);
        fn=fix_size(fn);
%
        fds1=[fn xx];
        fds2=[fn ff];
%
%%%%%%%%%%%
%
%
%%%%%%%%%%%
%
        if(uiu~=4)
            leg_a=sprintf('PSD Envelope');
            leg_b=sprintf('Measured Data');
%
            [fig_num,h3]=...
            plot_fds_two_h2(fig_num,x_label,ylab,fds1,fds2,leg_a,leg_b,Q(i),bex(i),iu,nmetric);    
        
        end
%
    
end    
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(uiu==4)
    [fig_num,h3]=fds_plot_2x2_alt_h2(fig_num,Q,bex,fn,ff,xx,xfds,fds_ref,nmetric,iu);
    
    pname='fds_comparison_plot.emf';
    print(h3,pname,'-dmeta','-r300');
    
 %       

    [fig_num,h4]=psd_fds_plot_2x2_alt_h2(fig_num,Q,bex,fn,xfds,...
                                         fds_ref,nmetric,iu,t_string,...
                                         power_spectral_density,fmin,fmax);    
 
    pname='psd_fds_comparison_plot.emf';
    print(h4,pname,'-dmeta','-r300');                                     
                                     
end    
 
%%%%%

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

disp(' ');
disp(' The fatigue damage spectra is calculated from the amplitude (peak-valley)/2 ');



%%
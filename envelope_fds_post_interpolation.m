

% envelope_fds_post_interpolation.m  ver 1.1  by Tom Irvine


function[power_spectral_density,grms,xfds]=...
    envelope_fds_post_interpolation(nbreak,xf,xapsd,fn,n_ref,damp,bex,T_out,iu,nmetric,f_sam)

%       
% Interpolate the best psd
%

fn=fix_size(fn); 
%         
[xapsdfine]=env_interp_best(nbreak,n_ref,xf,xapsd,fn);
%

xapsdfine=fix_size(xapsdfine);

xf=fix_size(xf);

xapsd=fix_size(xapsd);

%
power_spectral_density=[xf xapsd];
 
 
%
% Calculate the fds of the best psd
% 
[xfds]=env_fds_batch(xapsdfine,n_ref,fn,damp,bex,T_out,iu,nmetric);
%
disp('_____________________________________________________________________');
%
%
disp('Optimum Case');
disp(' ');

if(iu<=2)
    disp(' Freq(Hz)  Accel(G^2/Hz) ');
else
    disp(' Freq(Hz)  Accel((m/sec^2)^2/Hz) ');    
end
    
for i=1:nbreak
    out1=sprintf(' %6.1f \t%8.4g  ',power_spectral_density(i,1),power_spectral_density(i,2));
    disp(out1);
end    
%

[~,grms] = calculate_PSD_slopes(power_spectral_density(:,1),power_spectral_density(:,2));

omega=2*pi*xf;

a=power_spectral_density(:,2);
v=zeros(nbreak,1);
d=zeros(nbreak,1);

for i=1:nbreak
    v(i)=a(i)/omega(i)^2;
    d(i)=v(i)/omega(i)^2;         
end


if(iu==1)
      v=v*386^2;
      d=d*386^2;  
end
if(iu==2)
      v=v*(9.81*100)^2;
      d=d*(9.81*1000)^2;       
end
if(iu==3)
      v=v*(100)^2;
      d=d*(1000)^2;       
end  

[~,vrms] = calculate_PSD_slopes(xf,v);
[~,drms] = calculate_PSD_slopes(xf,d);
  

disp('  ');
disp(' Overall Levels ');
disp('  ');

if(iu<=2)
    out1=sprintf('  acceleration = %7.3g GRMS ',grms);
else
    out1=sprintf('  acceleration = %7.3g (m/sec^2)RMS ',grms); 
end
disp(out1);

if(iu<=1)
    out1=sprintf('      velocity = %7.3g (in/sec)RMS ',vrms);
else
    out1=sprintf('      velocity = %7.3g (m/sec)RMS ',vrms); 
end
disp(out1);

if(iu<=1)
    out1=sprintf('  displacement = %7.3g in RMS ',drms);
else
    out1=sprintf('  displacement = %7.3g mm RMS ',drms); 
end
disp(out1);


output_name='optimum_psd';

out1=sprintf('\n  Output Array:   %s  ',output_name);
disp(out1);

assignin('base', output_name, power_spectral_density); 

f_sam=power_spectral_density(:,1);
apsd_sam=power_spectral_density(:,2);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[fn,apsd_samfine]=env_interp_sam(f_sam,apsd_sam,nbreak,n_ref,fn);

optimum_psd_int=[fn apsd_samfine];

output_name='optimum_psd_int';

out1=sprintf('\n  Output Array interpolated at FDS natual frequencies:   %s  ',output_name);
disp(out1);

assignin('base', output_name, optimum_psd_int); 

%
%   env_generate_sample_psd_spl_altq2.m  ver 1.8   by Tom Irvine
%
%   used by:  vibrationdata_envelope_psd.m
%             vibrationdata_envelope_fds.m
%             vibrationdata_envelope_fds_batch.m 
%
%
function[f_sam,apsd_sam,spla,x,y]=...
    env_generate_sample_psd_spl_altq2(n_ref,nbreak,npb,f_ref,ik,slopec,initial,final,f1,f2,fc,reference,xr,yr)
%

f_sam=fc;     

fcq=fc;

x=xr;

y=yr;
x=sort(x);  

for i=1:length(yr)
    y(i)=yr(i)+(-0.1+0.2*rand());
end



ymax=max(y);
YL=ymax-12;

for i=1:length(y)
    if(y(i)<YL)
        y(i)=YL;
    end
end

if(y(end)>y(end-1))
    y(end)=y(end-1);
end
   

% spla = interp1(x,y,fcq);

% n=3;
% p = polyfit(x,y,n);
% spla=(  p(1)*tt.^3 +p(2)*tt.^2 + p(3)*tt + p(4));

if(npb==1)
    n=2;
    p = polyfit(x,y,n);
    spla=(  p(1)*fcq.^2 +p(2)*fcq + p(3));
end   
if(npb>=2 && npb<=8)
    spla = spline(x,y,fcq);
end    
if(npb==9)
    spla=y;
end


ymax=max(spla);
YL=ymax-25;

for i=1:length(spla)
    if(spla(i)<YL)
        spla(i)=YL;
    end
end


for i=1:length(spla)
    if(isinf(spla(i)))
        disp('spla inf');
            pause(2)
    end    
end
for i=1:length(spla)
    if(isnan(spla(i)))
        disp('spla NaN');
            pause(2)
    end    
end


[apsd_sam]=one_third_octave_spl_to_pressure_psd(fc,spla,reference);
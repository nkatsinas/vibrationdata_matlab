%
%   MWinter_function.m  ver 1.0  by Tom Irvine
%

function[psd]=MWinter_function(stationdiam_ft,W_lbm_per_ft2,cmat_ft_per_sec,f,spl)

[~,fc,ac]=MW_points();

ilast=length(spl);

cmat=cmat_ft_per_sec;
cref=200000./12.;  % feet per second
 
% scale = cmat/cref; 
 
scale=sqrt(10/stationdiam_ft);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

reference = 2.90e-09;  % zero dB reference for psi

psd=zeros(ilast,2);
 
for i=1:ilast
%
        [~, index] = min(abs(fc-f(i)));

        pressure_rms=reference*(10.^(spl(index)/20.) );
        
        psd(i,2)=((pressure_rms/W_lbm_per_ft2)^2)*ac(index);
        psd(i,1)=fc(index)*scale;
        
        out1=sprintf('fc=%8.4g spl=%8.4g  pr=%8.4g  md=%8.4g',fc(index),spl(index),pressure_rms,W_lbm_per_ft2);
        disp(out1);
%
end






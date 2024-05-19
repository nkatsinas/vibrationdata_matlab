%
%   relative_displacement_from_two_psds.m  ver 1.1  by Tom Irvine
%
%   This script calculates the relative displacement from two acceleration
%   PSDs for a family of uniform phase angle cases
%
%   (Real phase angle would vary with frequency)
%
%   Input array:
%
%   accel_psd must have three columns:  
%         freq(Hz), accel 1 (G^2/Hz)   accel 2 (G^2/Hz)
%
%   The frequency step should be constant
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Internal variables: 
%
%   df=frequency step
%
%   disp_psd1=displacement psd 1  (inch^2/Hz)
%   disp_psd2=displacement psd 2  (inch^2/Hz)
% 
%   disp1=displacement 1 Fourier magnitude (inch peak)
%   disp2=displacement 2 Fourier magnitude (inch peak)
%
%   rd_ft=relative displacement Fourier magnitude
%   rel_disp=overall relative displacement (inch RMS)
%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function[max_rel_disp,min_rel_disp]=relative_displacement_from_two_psds(accel_psd)
%
if(accel_psd(1,1)==0)
    accel_psd(1,:)=[];
end
%
sz=size(accel_psd);
%
num=sz(1);
%
f=accel_psd(:,1);
df=(f(end)-f(1))/(num-1);
%
omega=2*pi*f;
%
disp_psd1=zeros(num,1);
disp_psd2=zeros(num,1);
%
for i=1:num
    omega4=omega(i)^4;
    disp_psd1(i)=386^2*accel_psd(i,2)/omega4;
    disp_psd2(i)=386^2*accel_psd(i,3)/omega4;
end
%
rel_disp=zeros(90,1);

%
%  90 phase angle cases, spaced 4 degree apart
%
num_phase=360;
%
phase=zeros(num_phase,1);
%
for i=1:num_phase
    phase(i)=(i-1);
    theta=phase(i)*pi/180;
%
%  Calculate displacement Fourier magnitudes
%
    rd_ft=zeros(num,1);
        
    for j=1:num
       disp1=sqrt(disp_psd1(j)*df);
       disp2=sqrt(disp_psd2(j)*df);
       disp2=(cos(theta)+1i*sin(theta))*disp2;
       rd_ft(j)=abs(disp1-disp2);
    end    
%
%  Calculate the overall displacement response, square-root-of-the-sum-of-the-squares
%
    rd_ft=rd_ft/sqrt(2);
    rel_disp(i)=sqrt( sum( (rd_ft.^2 ) ));
    
end    


max_rel_disp=max(rel_disp);
min_rel_disp=min(rel_disp);

figure(1)
plot(phase,rel_disp);
title('Relative Displacement vs. Uniform Phase Angle');
ylabel('Rel Disp (inch RMS)');
xlabel('Phase Angle (deg)');
grid on;

fprintf('\n Displacement limits (inch RMS) \n');
fprintf(' max=%8.4g   min=%8.4g  \n\n',max_rel_disp,min_rel_disp);



%
%   fatigue_psd_check.m  ver 1.0  by Tom Irvine
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% 
%   Input variables
%
%      THM = psd array with two columns:  freq(Hz) & amplitude(unit^2/Hz)
%      scf = stress concentration scale factor
%      scf = 1 for no scaling
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%
%  Output variables
%
%     f,a = input psd frequency & psd amplitude
%       s = slopes
%     rms = overall rms value
%      df = frequency step
%     THM = input psd matrix excluding first row if first frequency was zero
%   fi,ai = interpolated frequency & psd amplitude
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  External functions
%
%    calculate_PSD_slopes
%    interpolate_PSD
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[f,a,s,rms,df,THM,fi,ai]=fatigue_psd_check(THM,scf)
%
if(THM(1,1)<1.0e-04)
    THM(1,:)=[];
end
 
f=THM(:,1);
a=THM(:,2);
%
if(f(1)<0.001)
    f(1)=0.001;
end   

% apply stress concentration factor to psd amplitude

a=a*scf^2;

[s,rms]=calculate_PSD_slopes(f,a);

% interpolate with frequency step = 1/20th of starting frequency

df=f(1)/20;  

[fi,ai]=interpolate_PSD(f,a,s,df);
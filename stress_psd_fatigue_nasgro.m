
%
%  stress_psd_fatigue_nasgro.m  ver 1.0  by Tom Irvine
%
%   Input variables
%
%   scf:  stress concentration factor to be applied as scale factor
%         if not already included
%
%         Set scf=1 for no scaling
%
%   duration (sec)
%
%   stress_psd:  freq(Hz) stess(psi^2/Hz)
%
%   A,B,C,P  Nasgro coefficients referenced to ksi
%   R = Smin/Smax   
%   R=-1 for full reversed stress with zero mean
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   The critical number of cycles Nf for a given stress level is
%
%      log10(Nf) = A - B*log10( Seq - C )
%
%   The equivalent stress Seq is given by
%
%      Seq=Smax*(1-R)^P
%
%   The constants A,B,C and P depend on the material per the NASGO NASFORM
%   manual.  See also MIL-HDBK-5J & MMPDS
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Output variables
%
%    damage      = cumulative damage index
%    damage_rate = damage per second
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  External functions
%
%     fatigue_psd_check
%     spectral_moments_nasgro
%     Dirlik_nasgro_probability
%     Dirlik_nasgro
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function[damage,damage_rate]=stress_psd_fatigue_nasgro(scf,duration,A,B,C,P,R,stress_psd)
 
stress_psd(:,2)=stress_psd(:,2)/1000^2;

% apply scale factor & interpolte stress_psd
[~,~,~,~,df,~,fi,ai]=fatigue_psd_check(stress_psd,scf);

%
tau=duration;

n=length(fi);
%
%  Calculate spectral moments & Dirlik coefficient
%
[m0,~,~,~,~,~,~,~,~,EP,~,~,D1,D2,D3,Q,Rd]=...
                                     spectral_moments_nasgro(n,B,ai,fi,df);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Note that range = (peak-valley)
%
%  maxS is the assumed upper limit of the the histogram.
%
%  The value 8*grms is used as conservative estimate of the upper
%  range maxS for all cycles.  
%
%  The histogram will have 400 bins.  This number is chosen
%  via engineering judgement.
%
%    ds is the bin range width       
%     n is the number of bins
%     N is the cycle count per bin
%     S is the range level for each bin
%
%   m0 is the variance
%
rms=sqrt(m0);

maxS=8*rms;  % maximum bin stress
%
ds=maxS/800;
%
n=round(maxS/ds);  % number of bins
%
EP_tau=EP*tau;

[N,range,dz]=Dirlik_nasgro_probability(n,m0,Q,D1,D2,D3,ds,Rd);

[damage]=Dirlik_nasgro(n,A,B,C,P,R,EP_tau,N,range,dz);

damage_rate=damage/tau;
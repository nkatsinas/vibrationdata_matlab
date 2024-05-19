%
%  stress_psd_fatigue_function.m  ver 1.0  by Tom Irvine
%
%  Cumulative damage index from stress response PSD via Dirlik method

%  Input variables
%
%  stress_psd - two columns:  f(Hz) stress(psi^2/Hz)
%
%  T = duration (sec)
%
%  S/N Coefficients from MIL-HDBK-5J, MMPDS or NASGRO:  A,B,C,P
%  
%    log Nf = A - B log(Seq - C)
%  
%    where Nf is the critical number of cycles
%
%  The equivalent stress Seq is
%
%     Seq = Smax*(1-R)^P   
%
%  R = Stress ratio ( Min Stress / Max Stress).  
%      Typically R=-1 for fully reversed stress with zero mean
%
%  The A,B,C,P coefficients are based on an S/N curve in units of ksi
%
%  scf = stress concentration factor to scale up stress if appropriate
%      set scf=1 to leave stress as is
%
%   Output variables
%
%         damage = cumulative damage index from Dirlik method
%
%    damage_rate = damage per second 
%

function[damage,damage_rate]=stress_psd_fatigue_function(stress_psd,T,A,B,C,P,R,scf)

THM=stress_psd;

THM(:,2)=THM(:,2)/1000^2;  % psi to ksi

[~,~,~,~,df,~,fi,ai]=fatigue_psd_check(THM,scf);  


tau=T;

n=length(fi);

[m0,~,~,~,~,~,~,~,~,EP,~,~,D1,D2,D3,Q,Rd]=...
                                     spectral_moments_nasgro(n,B,ai,fi,df);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Note that range = (peak-valley)
%
%  maxS is the assumed upper limit of the the histogram.
%
%  The value 6*grms is used as conservative estimate of the upper
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
rms=sqrt(m0);

maxS=8*rms;  
%
ds=maxS/800;
%
n=round(maxS/ds);
%
EP_tau=EP*tau;

%%%%
%
%   Dirlik
%

[Dirlik_N,range,dz]=Dirlik_nasgro_probability(n,m0,Q,D1,D2,D3,ds,Rd);

[damage]=Dirlik_nasgro(n,A,B,C,P,R,EP_tau,Dirlik_N,range,dz);

damage_rate=damage/T;


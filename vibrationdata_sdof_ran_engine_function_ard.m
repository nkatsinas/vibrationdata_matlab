%
%    vibrationdata_sdof_ran_engine_function_ard.m   ver 1.1   by Tom Irvine
%
function[a_vrs,rd_vrs,trans,opsd,rd_psd] = ...
           vibrationdata_sdof_ran_engine_function_ard(fi,ai,damp,natural_frequency)
%
    last=length(fi);
    fn=natural_frequency;
%
%   absolute acceleration
%
    trans=zeros(last,1);
    opsd=zeros(last,1);
%
    for j=1:last 
%
		rho = fi(j)/natural_frequency;
		tdr=2.*damp*rho;
%
        c1= tdr^ 2.;
		c2= (1.- (rho^2.))^ 2.;
%
		trans(j) = (1.+ c1 ) / ( c2 + c1 );
%
        opsd(j)=trans(j)*ai(j);
%      
    end
%        
    [~,a_vrs] = calculate_PSD_slopes_no(fi,opsd);   % approx
%
%   relative displacement
%
    rd_psd=zeros(last,1);
%
    omegan=2*pi*fn;
    omn2=omegan^2;
%
    for j=1:last 
        
        rho=fi(j)/natural_frequency;
%
        H = 1/(  omn2*sqrt( (1-rho^2)^2 + (2*damp*rho)^2) );
		t= H^2;
%
        rd_psd(j) = t*ai(j);
    end
%    
    [~,rd_vrs] = calculate_PSD_slopes_no(fi,rd_psd);   % approx
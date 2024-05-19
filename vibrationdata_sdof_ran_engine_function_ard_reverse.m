%
%    vibrationdata_sdof_ran_engine_function_ard_reverse.m   ver 1.0
%    by Tom Irvine
%
function[trans,ipsd,rd_psd] = ...
           vibrationdata_sdof_ran_engine_function_ard_reverse(fi,ai,damp,natural_frequency)
%
    disp(' ')
%
    last=length(fi);
    fn=natural_frequency;
%
%   absolute acceleration
%
    trans=zeros(last,1);
    ipsd=zeros(last,1);
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
        ipsd(j)=ai(j)/trans(j);
%      
    end
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
%
		t= H^2;
%
        rd_psd(j) = ai(j)/t;
    end

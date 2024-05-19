%
%   vrs_engine_f.m  ver 1.1  June 17, 2013
%
function[fn,a_vrs,rd_vrs] = vrs_engine_f(fi,ai,damp,df)
%
    disp(' Calculating VRS.... ')
    disp(' ')
%
	fn(1)=5.;
    oct=1./24.;
    tpi=2.*pi;
    tpi_sq=tpi^2;
    last=length(fi);
%
	for i=1:1000   % natural frequency loop
%
%   absolute acceleration
%
        sum=0.; 
%
		for j=1:last 
%
		    rho = fi(j)/fn(i);
			tdr=2.*damp*rho;
%
            c1= tdr^ 2.;
			c2= (1.- (rho^2.))^ 2.;
%
			t= (1.+ c1 ) / ( c2 + c1 );
            sum = sum + t*ai(j)*df;
%       
        end
%        
        a_vrs(i)=sqrt(sum);
%    
%
%   relative displacement
%
		sum=0.; 
%
        omegan=2*pi*fn(i);
        omn2=omegan^2;  
%
		for j=1:last 
%       
            rho=fi(j)/fn(i);
%
            H = 1/(  omn2*sqrt( (1-rho^2)^2 + (2*damp*rho)^2) );
%
            t= H^2;
%
            rd_psd(j) = t*ai(j);   
%
            sum = sum + t*ai(j)*df;
        end
%
        rd_vrs(i)=sqrt(sum)/tpi_sq;
%
        if(fn(i) > 10000. )
            break;
        end
        if(fn(i) > 2.*fi(last) )
            break;
        end    
     	fn(i+1)=fn(i)*(2.^oct);   
    end
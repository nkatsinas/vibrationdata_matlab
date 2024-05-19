%
%   vrs_engine_f_batch.m  ver 1.1   by Tom Irvine
%
function[fn,a_vrs,rd_vrs] = vrs_engine_f_batch(fi,ai,damp,df,ioct)
%
    disp(' Calculating VRS.... ')
%
    maxfi=max(fi);

	fn(1)=fi(1);
    
    if(ioct==1)
        oct=1/3;
    end
    if(ioct==2)
        oct=1/6;
    end
    if(ioct==3)
        oct=1/12;
    end
    if(ioct==4)
        oct=1/24;
    end       
    
        
    i=2;
    while(1)
        
       fn(i)=fn(i-1)*2^oct;
       
       if(fn(i)>maxfi)
           fn(i)=maxfi;
           break;
       end
       
       i=i+1;
       
    end
    
    
    
    tpi=2.*pi;
    tpi_sq=tpi^2;
    last=length(fi);
%

    fnl=length(fn);



	for i=1:fnl   % natural frequency loop
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
    end
    

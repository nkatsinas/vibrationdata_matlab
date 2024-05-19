%
%    sdof_ran_engine_function.m   ver 1.1  April 6, 2009
%
function[a_vrs,rd_vrs,trans,opsd] = ...
                 sdof_ran_engine_function(fi,ai,damp,df,natural_frequency)
%
    disp(' ')
%
    tpi=2.*pi;
    last=length(fi);
    fn=natural_frequency;
%
%   absolute acceleration
%    fid = fopen('vrs.dat','w')
%
        ssum=0.; 
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
            ssum = ssum + opsd(j)*df;
%
%       fprintf(fid,'%9.3g %9.3g %9.3g %9.3g %9.3g %9.3g t=%9.3g ai(j)=%9.3g df=%9.3g ssum=%9.3g \n',fi(j),fn(i),rho,tdr,c1,c2,t,ai(j),df,ssum);
%       
        end
    a_vrs=sqrt(ssum);
%    fclose(fid);           
%
%   relative displacement
%
		ssum=0.; 
%
		for j=1:last 
%
            c1= ((fn^2.)-(fi(j)^2.) )^2.;
			c2= ( 2.*damp*fn*fi(j))^2.;
%
			t= 1. / ( c2 + c1 );
%
            ssum = ssum + t*ai(j)*df;
        end
         rd_vrs=sqrt(ssum)/(tpi^2.);
%
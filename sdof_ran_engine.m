function[a_vrs,rd_vrs,trans,opsd] = sdof_ran_engine(fi,ai,damp,df,natural_frequency);
%
%    sdof_ran_engine.m   ver 1.1  April 6, 2009
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
        sum=0.; 
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
            sum = sum + opsd(j)*df;
%
%       fprintf(fid,'%9.3g %9.3g %9.3g %9.3g %9.3g %9.3g t=%9.3g ai(j)=%9.3g df=%9.3g sum=%9.3g \n',fi(j),fn(i),rho,tdr,c1,c2,t,ai(j),df,sum);
%       
        end
    a_vrs=sqrt(sum);
%    fclose(fid);           
%
%   relative displacement
%
		sum=0.; 
%
		for j=1:last 
%
            c1= ((fn^2.)-(fi(j)^2.) )^2.;
			c2= ( 2.*damp*fn*fi(j))^2.;
%
			t= 1. / ( c2 + c1 );
%
            sum = sum + t*ai(j)*df;
        end
         rd_vrs=sqrt(sum)*386./(tpi^2.);
%
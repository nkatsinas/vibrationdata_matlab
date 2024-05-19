%
%  vibrationdata_disp_correction.m  ver 1.1  August 14, 2014
%
function[velox,dispx]=vibrationdata_disp_correction(vel,dt,kvn,fstart)
%
       n=length(vel);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
      [d]=integrate_function(vel,dt);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       
       xt=linspace(0,(n-1)*dt,n);
%
       xt=fix_size(xt); 
%
       dispx=fix_size(d);
%
       p = polyfit(xt,dispx,2);
       f = polyval(p,xt);
%
       y=dispx-f;
%       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
%
       fper1=0.005;
       fper2=(1/fstart)/(n*dt);
       fper=max([fper1 fper2]);
%
       if(kvn<10)
%
            na=round(fper*n);
            nb=n-na;
            delta=n-nb;
%
            for i=1:na
                arg=pi*(( (i-1)/(na-1) )+1); 
                y(i)=y(i)*0.5*(1+(cos(arg)));
            end
%
            for i=nb:n
                arg=pi*( (i-nb)/delta );
                y(i)=y(i)*(1+cos(arg))*0.5;
            end
       end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
       dispx=y;
%
       [velox]=differentiate_function(dispx,dt);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%  gust_velox_correction.m  ver 1.5  November 15, 2012
%
function[velox,dispx]=gust_velox_correction(acc,dt,kvn,fstart)
%
       n=length(acc);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
      [dispx]=integrate_function(acc,dt);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       
       xt=linspace(0,(n-1)*dt,n);
%
       xt=fix_size(xt);
       dispx=fix_size(dispx);
%
       p = polyfit(xt,dispx,2);
       f = polyval(p,xt);
%
       y=dispx-f;
%       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
%
       fper1=0.005;
       fper2=(0.5/fstart)/(n*dt);
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
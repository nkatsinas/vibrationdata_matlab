%
%  velox_correction_HH.m  ver 1.0  July 27, 2015
%
function[acc,velox,dispx]=velox_correction_HH(acc,dt,kvn,fstart,iunit)
%
       n=length(acc);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
      [v]=integrate_function(acc,dt);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       
       xt=linspace(0,(n-1)*dt,n);
%
       xt=fix_size(xt); 
%
       [dispx]=integrate_function(v,dt);
%
       xt=fix_size(xt);
       dispx=fix_size(dispx);
%
       p = polyfit(xt,dispx,3);
       f = polyval(p,xt);
%
       y=dispx-f;
%       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
%
       fper1=0.01;
       fper=max([fper1]);
%
       if(kvn<10)
%
            na=round(fper*n);
            nb=n-na;
            delta=n-nb;
%
            for i=1:na
                arg=pi*(( (i-1)/(na-1) )+1); 
                y(i)=y(i)*(0.5*(1+(cos(arg))))^2;
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
         [acc]=differentiate_function(velox,dt);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
if(iunit==1)
       velox=velox*386;
       dispx=dispx*386;
else
       velox=velox*9.81*100;
       dispx=dispx*9.81*1000;    
end    
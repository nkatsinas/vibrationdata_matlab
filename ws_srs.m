
% ws_srs.m   ver 1.2  by Tom Irvine

function[xxmax,xxmin,xmax,xmin]=ws_srs(nspec,th,a1,a2,b1,b2,b3,f)
%
%%****************************** initialize arrays ******************/
%

  
%
   last_p=length(th);
   last_t=length(th)+round(0.75/f(1));   % includes residual
%   
   yy=zeros(last_t,1);
   yy(1:last_p)=th;
%

   xmax=zeros(nspec,1);
   xmin=zeros(nspec,1);

   for j=1:nspec

        resp=filter([ b1(j),  b2(j),  b3(j) ],[     1, -a1(j), -a2(j) ], yy);
%
        xmax(j)= abs(max(resp));
        xmin(j)= abs(min(resp));
   end
% 


   for j=1:nspec
% 
       if( abs(xmax(j)) <= 1.0e-20 || abs(xmin(j)) <= 1.0e-20 )
% 
          out1=sprintf(' Error SRS  j=%ld  xmax=%8.4g  xmin=%8.4g \n',j,xmax(j),xmin(j));
          out2=sprintf('            f(j)=%8.4g  \n',f(j));
          disp(out1);
          disp(out2);
%
       end
   end
 %
   xxmax=xmax;
   xmin=abs(xmin);
   xxmin=xmin;
%
   xxmax = max(xxmax, abs(xmin));
   xxmin = max(xxmin, abs(xmax));

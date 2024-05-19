
% vibrationdata_modified_Gram_Schmidt.m  ver 1.0  by Tom Irvine


function[yhat]=vibrationdata_modified_Gram_Schmidt(mass,trial)

x=trial;

sz=size(mass);
nr=sz(1,1);

m=size(x);  % number of columns
nc=m(1,2);
%
yhat=zeros(nr,nc);
%
% mass
%
    scale=x(:,1)'*mass*x(:,1);
    yhat(:,1)=x(:,1)/sqrt(abs(scale));
    
    progressbar;
    
    for i=2:nc
        progressbar(i/nc);
                
        for j=i:nc
            x(:,j)=x(:,j)-(yhat(:,i-1)'*mass*x(:,j))*yhat(:,i-1);
        end
        
        scale=x(:,i)'*mass*x(:,i);
        yhat(:,i)=x(:,i)/sqrt(abs(scale));
    end  
    pause(0.2);
    progressbar(1);
%
%%    rcm=yhat'*mm*yhat;
%
ModeShapes=yhat;
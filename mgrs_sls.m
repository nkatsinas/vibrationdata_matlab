%
disp(' ');
disp(' mgrs_sls.m  ver 1.0   ');
disp(' by Tom Irvine ');
disp(' ');

clear x;
clear yhat;
clear yhat_r;


% Modified Gram-Schmidt Orthogonalization
%
% The inner product of two column vectors H and J is H'*J.
%
% Sample Data :
%
clear x;
clear yhat;
clear yhat_i;
clear trans_m;
clear trans_k;
clear trans_m_r;
clear trans_k_r;
clear mass;
clear stiff;
clear q;

%
% disp(' ');
% disp(' Select method: ');
% disp('  1=normalize with respect to mass matrix ');
% disp('  2=normalize with respect to identity matrix ');
% im=input(' ');

im=1;

%
% if(im==1)
%     disp(' ');
%     mass=input(' Enter mass matrix: ');
% end

mass=mr;
stiff=stiffr;

%
% disp(' ');
% x=input(' Enter trial vector matrix:  ');
%

error_max=1.0e+99;

sn=3;

x=modeshapesr;
yhat_r=x;

m=size(x);  % number of columns
n=m(1,2);


progressbar;

nt=1500000;

mu=round(nt/100);

for ijk=1:nt

    progressbar(ijk/nt);

    q=max(max(abs(x)));

    if(ijk<=mu || rand()>0.9)
        
        ia=1;
    
        for i=1:n
            for j=sn:10
                x(i,j)=(q/2)*(-0.5+rand());
            end
        end
    
    else
        
        
        x=yhat_r;
        
        if(rand()>0.5)
            
            ia=2;
        
            for i=1:n
                for j=sn:10
                    x(i,j)=yhat_r(i,j)*(0.96+0.08*rand());
                end
            end       
        
        else
            
            ia=3;           
 
            for i=1:n
                for j=sn:10
                    x(i,j)=yhat_r(i,j)*(0.99+0.02*rand());
                end
            end                   
            
        end
        
    end

%
    yhat=zeros(n,n);
%
% mass
%
    scale=x(:,1)'*mass*x(:,1);
    yhat(:,1)=x(:,1)/sqrt(abs(scale));
    for i=2:n
        for j=i:n
            x(:,j)=x(:,j)-(yhat(:,i-1)'*mass*x(:,j))*yhat(:,i-1);
        end
        scale=x(:,i)'*mass*x(:,i);
        yhat(:,i)=x(:,i)/sqrt(abs(scale));
    end  
%
    trans_m=yhat'*mass*yhat;
    trans_k=yhat'*stiff*yhat;    
%

    
    kt=abs(trans_k);
    
    kt(logical(eye(size(kt)))) = 0;
    
    error=sum(sum(kt));


    if(error<error_max)
       
        error_max=error;
        
        yhat_r=yhat;
        trans_m_r=trans_m;
        trans_k_r=trans_k;
        
        out1=sprintf('%d  %8.4g  %d',ijk,error_max,ia);
        disp(out1);
        
    end
    
end
%
pause(0.5);
progressbar(1);


yhat_r

disp(' yhatT*mass*yhat = ');
trans_m_r
%

disp(' yhatT*stiff*yhat = ');
trans_k_r


modeshapesr-yhat_r

max(max(abs(modeshapesr-yhat_r)))


yhat_i=pinv(yhat_r);

K = yhat_i'*trans_k_r*yhat_i

max(max(abs(stiffr-K)))









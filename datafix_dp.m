%
%  datafix_dp.m  ver 1.1  December 12, 2015
%
function[iflag,ss]=datafix_dp(x)
%
iflag=0;
% 
if (abs(x)==0.)       
    ss=sprintf(' %15.8f',x);
    iflag=1;
end
%
if( abs(x) > 0 && abs(x)  < 0.01 )
%        
    if(x >= 0.)
        ss=sprintf(' %15.8f',x);
    else                
        ss=sprintf(' %15.8f',x);
    end
%
    iflag=1;
end
if( abs(x) >= 0.01 && abs(x)  < 0.1 )
%        
    if(x >= 0.)
        ss=sprintf(' %15.8f',x);
    else            
        ss=sprintf(' %15.8f',x);
    end
%
    iflag=1;
end
if( abs(x) >= 0.1 && abs(x)  < 1. )
%        
    if(x >= 0.)
        ss=sprintf(' %15.8f',x);
    else              
        ss=sprintf(' %15.8f',x);
    end
    if(length(ss)==9)
        ss=ss(1:8);
    end       
% 
    iflag=1;
end
if( abs(x)  >= 1. && abs(x)  < 10. )
%        
    if(x >= 0.)    
        ss=sprintf(' %15.8f',x);
    else
        ss=sprintf(' %15.8f',x);
    end
    if(length(ss)==9)
        ss=ss(1:8);
    end       
% 
    iflag=1;
end
if( abs(x)  >= 10. && abs(x)  < 100. )
%        
    if(x >= 0.)
        ss=sprintf(' %15.7f',x);
    else                
        ss=sprintf(' %15.7f',x);
    end
    if(length(ss)==9)
        ss=ss(1:8);
    end       
%    
    iflag=1;
end
if( abs(x)  >= 100. && abs(x)  < 1000. )
%        
    if(x >= 0.)
        ss=sprintf(' %15.6f',x);
    else
        ss=sprintf(' %15.6f',x);
    end
    if(length(ss)==9)
        ss=ss(1:8);
    end       
%
    iflag=1;
end
if( abs(x)  >= 1000. && abs(x)  < 10000. )
%        
    if(x >= 0.)
        ss=sprintf(' %15.5f',x);
    else
        ss=sprintf(' %15.5f',x);
    end
    if(length(ss)==9)
        ss=ss(1:8);
    end       
% 
    iflag=1;
end
if( abs(x)  >= 10000. && abs(x)  < 100000. )
%       
    if(x >= 0.)
        ss=sprintf(' %15.4f',x);
    else
        ss=sprintf(' %15.4f',x);
    end
    if(length(ss)==9)
        ss=ss(1:8);
    end       
%    
    iflag=1;
end
if(iflag==0)
%       
    n = floor( log10 (abs(x)) );
    n=n-1;
% 
    a= log10( abs(x)) - n ;
    b= 10.^a;
% 
    if( b >=9.9999)          
        b=b/10.;
        n=n+1;
    end
%
    if( x >= 0. )           
        ss=sprintf(' %12.2f',b);
    else
        ss=sprintf('-%12.2f',b);
    end
 %
    ss=strcat(ss,'e');
 %
    if(n>=0)         
        st=sprintf('+%d',n);
    else
        st=sprintf('%d',n);
    end
    ss=strcat(ss,st);
end
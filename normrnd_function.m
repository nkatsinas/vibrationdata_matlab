%
%  normrnd_function.m  ver 1.0  by Tom Irvine
%
function[a] = normrnd_function(sigma,np)
%
%  Initialize probability table 
%
clear sum;
%
e=1./sqrt(2.*pi);
ss = zeros(1,600);
%
b=linspace(1,600,600);
b=b/100;
ab=-b;
delta=(b-ab)/1000.;
%
for j=1:600
%
    for i=0:1000
        z=(delta(j)*i)+ab(j);
        ss(j)=ss(j)+exp( ( -(z^2.) )/2.);
    end
%
end
sum=ss.*delta;
sum=sum*e;
%
%  Calculating time history points
%
a = zeros(1,(np+1));
%    
%  The gauss function determines the probability for each Nsigma value.
%
for i=0:np
%             
    x=rand;
%		            
    for j=1:599
%
%   x is a probability value.  0 < x < 1 
%			  
        if( x >= sum(j) &&  x <= sum(j+1) )
%
%	 a = Nsigma value which corresponds to probability x.
%
            a(i+1)=b(j+1);
            break;
        end
    end
end
%         
% 	 50% of the amplitude points are multiplied by -1.
%
for i=0:np
    if( rand < 0.5 )
        a(i+1)=-a(i+1);
    end     
end    
%
%	   
%    scale for the std deviation
%
ave=mean(a);
stddev=std(a);
sss=sigma/stddev;
%	 
a=(a-ave)*sss; 
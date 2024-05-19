%
%   white_basic.m  version 1.2    December 5, 2012
%   By Tom Irvine   
%
function[a] = white_basic(~,np)
%
sdg = 1;
e=1./sqrt(2.*pi);
%
%	b(j) is a standard deviation.  The maximum b(j) is six sigma.
%     	
%	sum(j) is the area under the Gaussian curve from 0 to b(j). 
%  	
disp(' ');
disp(' Initialize probability table ');
%
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
disp(' ');
disp(' Calculating time history points ');
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
disp(' ');
disp(' Apply polarity ');
%
for i=0:np
    if( rand < 0.5 )
        a(i+1)=-a(i+1);
    end     
end    
%	   
%    scale for the std deviation
%
disp(' ');
disp(' Scale for standard deviation ');
%
ave=mean(a);
stddev=std(a);
sss=sdg/stddev;
%	 
a=(a-ave)*sss;         
%
%    simple_filter_coefficients.m   ver 1.2  October 20, 2012
%
%    Butterworth 6th order
%    
function[a,b,iflag] = simple_filter_coefficients(f,dt,iband,iflag)
%
%% disp(' filter coefficients ');

L=6;
%
a=zeros(4,4);
b=zeros(4,5);
%  
%*** normalize the frequency ***
%
targ=pi*f*dt;
om=tan(targ);
%     
%*** solve for the poles *******
%
s_complex=zeros(2*L,1);
%
for k=1:(2*L)
%       
	arg = (2.*k +L-1)*pi/(2.*L);
%			
    s_complex(k) = cos(arg) + 1i*sin(arg);
%
end
%
%  plot transfer function magnitude
%
for i=1:200
%     
    arg = (i-1)/40.;
%		   
    h_complex = -real(s_complex(1)) + 1i*( arg - imag(s_complex(1))); 
%
    for jk=1:(L-1)	   
%
        theta_complex = -real(s_complex(jk)) + 1i*( arg - imag(s_complex(jk))); 
%			   
        temp_complex = h_complex*theta_complex;
%
	    h_complex = temp_complex;
%
    end 
%
end
%
%*** solve for alpha values ****
%   
alpha = 2*real(s_complex);
%
%*** solve for filter coefficients **
%
om2=(om^2);
% 
if( iband == 1 )
%
    for k=1:(L/2)
%        
        den = om2-alpha(k)*om+1.;
%		
	    a(k,1)=0.;
	    a(k,2)=2.*(om2 -1.)/den;
        a(k,3)=(om2 +alpha(k)*om+ 1.)/den;
%
	    b(k,1)=om2/den;
        b(k,2)=2.*b(k,1);
        b(k,3)=b(k,1);
%		
    end
%    
else
%
    for k=1:(L/2)
%
        den = 1. -alpha(k)*om +om2;
%		
	    a(k,1)=0.;
	    a(k,2)=2.*(-1.+ om2)/den;
        a(k,3)=( 1.+alpha(k)*om+ om2)/den;
%
	    b(k,1)= 1./den;
        b(k,2)=-2.*b(k,1);
        b(k,3)=    b(k,1);
    end
%
end
%


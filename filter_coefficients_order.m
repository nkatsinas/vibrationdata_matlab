%
%    filter_coefficients_order.m   ver 1.0  by Tom Irvine
%
%    Butterworth 6th order
%    
function[a,b,iflag] = filter_coefficients_order(f,dt,iband,iflag,L_order)
%
disp(' filter coefficients ');

L=L_order;

%% freq=f;
%
iflag=iflag*1;
%
a=zeros(4,4);
b=zeros(4,5);
%  
%
%*** normalize the frequency ***
%
disp(' normalize the frequency ');
targ=pi*f*dt;
om=tan(targ);
%     
%*** solve for the poles *******
%
disp(' calculate poles ');
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
%%    x_complex=1./h_complex;
%
%%     h_complex=x_complex;
%
%%    a1 = freq*arg;
%		   
%%    a2=sqrt( (real(h_complex))^2 + (imag(h_complex))^2 );
%          
%%    a3 = (a2^2);
%
%    fprintf(pFile[3],"\n %lf %lf %lf", a1, a2, a3);    
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
disp(' ');
disp(' a coefficients ');
for k=1:(L/2)
    out3 = sprintf('%d. %8.4g  %8.4g  %8.4g',k,a(k,1),a(k,2),a(k,3));
    disp(out3);
end
disp(' ');
disp(' b coefficients ');
for k=1:(L/2)
    out3 = sprintf('%d. %8.4g  %8.4g  %8.4g',k,b(k,1),b(k,2),b(k,3));
    disp(out3);
end
disp(' ');
%
%*** plot digital transfer function **
%
%	dtrans();
%
%*** check stability ****************
%
als=0.5e-06;
%
als=als*6.;
%
out3=sprintf('\n stability reference threshold= %14.7e ', als);
disp(out3);
%    
for i=1:L/2
%        
    at1= -a(i,2);
    at2= -a(i,3);
%
    out3 = sprintf('\n stability coordinates: (%12.7g, %14.7g) ',at1,at2);
    disp(out3);
%        
    h2=at2;
% 
    a1=h2-1.;
    d3=at1-a1;
 %        
    a1=1.-h2;
    d2=a1-at1;
    d1=at2+1.;
%		
    out3 = sprintf(' d1=%14.5g  d2=%14.5g  d3=%14.5g',d1,d2,d3);
    disp(out3);
%
    dlit=d1;
%
    if(dlit > d2)
        dlit=d2;
    end
    if(dlit > d3)
        dlit=d3;
    end
%            
    out3 = sprintf('\n stage %ld     dlit= %14.5g ',i, dlit);
    disp(out3);
%
    if(dlit > als)
	    disp('  good stability'); 
    end
    if( (dlit < als) && (dlit > 0.))
        disp('  marginally unstable ');
    end
    if(dlit < 0.)
	    disp('  unstable ');
        iflag=905;
    end
end
disp(' ');
out3 = sprintf(' iflag=%d ',iflag);
disp(out3);
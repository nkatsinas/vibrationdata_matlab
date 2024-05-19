
%  SN_coefficients.m  ver 1.2  by Tom Irvien

function[mlab,As,Bs,Cs,Ps]=SN_coefficients(n)

mlab = ' ';
As=' ';
Bs=' ';
Cs=' ';
Ps=' ';

if(n==1) % Aluminum 6061-T6
    As='20.68';
    Bs='9.84';
    Cs='0';
    Ps='0.63';
    mlab = 'Aluminum 6061-T6';
end
if(n==2) % Aluminum 7050-T7451
    As='9.73';
    Bs='3.24';
    Cs='15.5';
    Ps='0.63';    
    mlab = 'Aluminum 7050-T7451';    
end
if(n==3) % Aluminum 7075-T6
    As='18.22';
    Bs='7.77';
    Cs='10.15';
    Ps='0.62';    
    mlab = 'Aluminum 7075-T6';    
end
if(n==4) % Inconel 718
    As='9.959';
    Bs='2.665';
    Cs='48.54';
    Ps='0.507';    
    mlab = 'Inconel 718';    
end
if(n==5) % Stainless Steel Custom 450 (H1050)
    As='9.59';
    Bs='3.15';
    Cs='33.23';
    Ps='0.607';    
    mlab = 'Stainless Steel Custom 450 (H1050)';    
end
if(n==6) % Stainless Steel 15-5PH
    As='19.69';
    Bs='9.14';
    Cs='18.16';
    Ps='0.595';    
    mlab = 'Stainless Steel 15-5PH';    
end

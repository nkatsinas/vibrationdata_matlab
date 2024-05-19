%
%  cylinder_mdens.m  ver 1.1  by Tom Irvine
%
%  cylinder modal density, one-third octave
%
%  Szchenyi
%
function[mph] = cylinder_mdens(f,fr,L,t)
%
mdc=@(B)(B*L)/(pi*t*fr);
%
F=2^(1/6);
%
vo=f/fr;
    
if(vo<= 0.48)
    B=2.5*sqrt(vo);
end
    
if(vo>0.48 && vo<=0.83)
    B=3.6*vo;    
end
    
if(vo>0.83)
        
    arg1=1.745/(F^2*vo^2);
    arg2=1.745*F^2/vo^2;
        
    A=F*cos(arg1)-(1/F)*cos(arg2);
    B=2+(0.23*A/(F-(1/F)));
end
    
mph=mdc(B);
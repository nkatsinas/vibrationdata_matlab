
%  free_vibration_function.m  ver 1.0  by Tom Irvine

function[acc,rd]=...
       free_vibration_function(rd_initial,rv_initial,domegan,omegad,omegan2,TT)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a1=rd_initial;
a2=(rv_initial+domegan*rd_initial)/omegad;

nt=length(TT);

rd=zeros(nt,1);
acc=zeros(nt,1);


for i=1:nt
%		
	t=TT(i);

%
    omegadt=omegad*t;
    domegant=domegan*t;
%
    ee=exp(-domegant);
    cwdt=cos(omegadt);
    swdt=sin(omegadt);
%
    rd(i) = ee *(a1*cwdt + a2*swdt);
%
    rv= -domegan*rd(i);
    rv=rv+ omegad*ee *(-a1*swdt + a2*cwdt);
%
    acc(i)= -omegan2*rd(i)  - 2.*domegan*rv;
%
end       

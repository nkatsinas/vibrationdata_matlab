%
%   Holzer_printvector.m  ver 1.0  by Tom Irinve
%
function[top]=Holzer_printvector(kv,ibc,idisks,omega,x)
%
TPI=2*pi;
%
if(kv <= idisks)

    out1=sprintf('\n omega %d = %9.4g rad/sec ',kv, omega);
    out2=sprintf('         = %9.4g Hz \n', omega/TPI);
    
    disp(out1);
    disp(out2);
    
    out1=sprintf(' Displacement vector %d ',kv);
    disp(out1);
    
    for i=1:length(x)
        out2=sprintf('%8.4g',x(i));
        disp(out2);
    end
    
end
%
top=omega;
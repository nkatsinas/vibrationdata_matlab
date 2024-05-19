%
%   Convert SRS G into pseudo velocity and determine severity
%
G=input('Enter accel (G):  ');
fn=input('Enter fn (Hz):  ');
%
pv=G*386/(2*pi*fn);
%
fprintf('\n pseudo velocity = %6.3g in/sec \n',pv);
%
if(pv>=50)
    disp('level is severe');
else
    disp('level is not severe');    
end
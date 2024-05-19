%  
%  triaxial_transformation_time_history.m  ver 1.0  by Tom Irvine
%
%  This script performs a 2D coordinate transform for triaxial time history.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Input Variables:
%
%  TH_in = input time history with four columns:
%    
%          time(sec), X, Y, Z    
%
%   axis = axis of rotation  
%          X
%          Y
%          Z
%
%  theta = input angle (degrees)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Output Variable:
%
%  TH_out = output time history
%
%           time(sec), X', Y', Z'
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function[TH_out]=triaxial_transformation_time_history(TH_in,theta,axis)

sz=size(TH_in);
num=sz(1);

if(strcmp(axis,'X') || strcmp(axis,'x') ) 
    R=rotx(theta);
end
if(strcmp(axis,'Y') || strcmp(axis,'y')) 
    R=roty(theta);
end
if(strcmp(axis,'Z') || strcmp(axis,'z') )
    R=rotz(theta);
end

disp(' ');
disp(' Rotation matrix ');
disp('  ');
R

TH_out=zeros(num,4);

TH_out(:,1)=TH_in(:,1);

for i=1:num
    TH_out(i,2:end)=R*TH_in(i,2:4)';
end
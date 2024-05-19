%  
%  biaxial_transformation_time_history.m  ver 1.0  by Tom Irvine
%
%  This script performs a 2D coordinate transform for a biaxial or 
%  triaxial time history.
%
%  The Z-axis is the axis of rotation.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Input Variables:
%
%  TH_in = input time history with three or four columns:
%    
%          time(sec), X , Y & optional Z    
%
%  theta = input angle (degrees)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Output Variables:
%
%  TH_out = output time history
%
%           time(sec), X' , Y' & optional Z
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function[TH_out]=biaxial_transformation_time_history(TH_in,theta)

sz=size(TH_in);
num=sz(1);

R=rotz(theta);

if(sz(2)==3)
    R(:,3)=[];
    R(3,:)=[];
end

TH_out=zeros(num,sz(2));

TH_out(:,1)=TH_in(:,1);

for i=1:num
    TH_out(i,2:end)=R*TH_in(i,2:end)';
end
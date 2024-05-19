%
%   SRS_specification_interpolation_nw.m  ver 1.3  by Tom Irvine
%
function[f,spec]=SRS_specification_interpolation_nw(fr,r,ioct)
%
nn=length(fr);

%%  disp(' ');
%%  for i=1:nn
%%     out1=sprintf('%8.4g %8.4g',fr(i),r(i));
%%     disp(out1); 
%%  end
%%  disp(' ');

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%  Calculate slopes between input points
%

[s,num]=calculate_slopes(fr,r);

%
clear f;
clear spec;
 
%
%%  Interpolate
%
%
octave=(1./3.);
%
if ioct==2
    octave=(1./6.);
end
%
if ioct==3
    octave=(1./12.);
end
%
if ioct==4
    octave=(1./24.);
end
if ioct==5
    octave=(1./48.);
end
if ioct==6
    octave=(1./96.);
end
if ioct==7
    octave=(1./192.);
end
%
if(min(fr<=0))
    disp('error 3')
    fr
end    
[f,spec]=octave_interpolation(octave,fr,r,s,num);

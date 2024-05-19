%
%   extract_function.m  ver 1.1  by Tom Irvine
%
%   This script extracts a segment from a time history.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Input variables
%
%      THM = input time history with time & amplitude
%       ts = start time   
%       te = end time  
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Output variables
%
%       TT = new time vector
%        x = new amplitude
%       dt = time step
%        n = new number of points
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function [TT,x,dt,n]=extract_function(THM,ts,te)

if(ts>te)
    warndlg('Start time > end time');
end

t=double(THM(:,1));
y=double(THM(:,2));


[~,n1]=min(abs(ts-THM(:,1)));
[~,n2]=min(abs(te-THM(:,1)));

try
    dt=(THM(n1,1)-THM(n2,1))/(n2-n1);
catch
    warndlg('dt error');
end
    
x=y(n1:n2);
TT=t(n1:n2);
%
n=length(TT);
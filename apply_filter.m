%
%   apply_filter.m  ver 1.0  October 20, 2012
%
function[y]=apply_filter(y,iphase,~,a,b)
%
disp(' ')
disp(' apply filter ')
%
if(iphase==1)
%
    disp(' begin reversal ');	
%
    clear temp;
    clear length;
    temp=y(end:-1:1);  
    y=temp;
%
end
%
%  cascade stage 1
%
disp('  stage 1');
%
ik=1;
%
%
    forward=[ b(ik,1),  b(ik,2),      b(ik,3) ];
    back   =[     1, a(ik,2), a(ik,3) ];
    yt=filter(forward,back,y);
%
%
%  cascade stage 2
%
disp('  stage 2');
%
ik=2;
%
% stage 2
%
    forward=[ b(ik,1),  b(ik,2),      b(ik,3) ];
    back   =[     1, a(ik,2), a(ik,3) ];    
    y=filter(forward,back,yt);	
%
%
%  cascade stage 3
%
disp('  stage 3');
%
ik=3;
%
%
    forward=[ b(ik,1),  b(ik,2),      b(ik,3) ];
    back   =[     1, a(ik,2), a(ik,3) ];
    yt=filter(forward,back,y);
%
%
y=yt;
%
disp(' end apply filter');
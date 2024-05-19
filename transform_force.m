%
%  transform_force.m ver 1.0  by Tom Irvine
%
function[num_modes,FP]=transform_force(f,Q,QT,Mwd,nt)
%
%%
n=max(size(Q));
%
num_modes=n;
%
FP=zeros(num_modes,nt);
%
for i=1:nt 
    ff=f(i,:);
    FP(:,i)=-QT*Mwd*ff';    
end  
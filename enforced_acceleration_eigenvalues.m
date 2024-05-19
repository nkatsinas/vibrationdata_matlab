
% enforced_acceleration_eigenvalues.m  ver 1.0 by Tom Irvine

function[fn,omegan,omn2,ModeShapes,MST,part]=enforced_acceleration_eigenvalues(Kww,Mww,num,nff)


disp(' Calculating eigenvalues ');
if(num<=10)
    [fn,omegan,ModeShapes,MST]=Generalized_Eigen(Kww,Mww,1);
else
    [fn,omegan,ModeShapes,MST]=Generalized_Eigen(Kww,Mww,2);   
end
%
omn2=omegan.^2;

r=ones(nff,1);
%
part = MST*Mww*r;
%
if(num<=6)
    disp(' Participation Factors  ');
    part
end    
%
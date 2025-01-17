
%
% tdof_fn_results.m  ver 1.2  by Tom Irvine
%

function[fn,ModeShapes,pff,emm]=tdof_fn_results(mass,stiffness)

[fn,~,ModeShapes,MST]=Generalized_Eigen(stiffness,mass,2);
%
dof=length(fn);
%
v=ones(dof,1)';

disp(' ');
mass

stiffness


%
disp('        Natural    Participation    Effective      ');
disp('Mode   Frequency      Factor        Modal Mass     ');
%
LM=MST*mass*v';
pf=LM;
sum=0;
%    
mmm=MST*mass*ModeShapes;   
%

pff=zeros(dof,1);
emm=zeros(dof,1);

fn(abs(fn)<1.0e-05) = 0;

for i=1:dof
        pff(i)=pf(i)/mmm(i,i);
        emm(i)=pf(i)^2/mmm(i,i);
        out1 = sprintf('%d  %10.4g Hz   %10.4g   %10.4g   %10.4g',i,fn(i),pff(i),emm(i));
        disp(out1)
        sum=sum+emm(i);
end
out1=sprintf('\n modal mass sum = %8.4g ',sum);
disp(out1);

ModeShapes

assignin('base', 'two_dof_mass', mass);
assignin('base', 'two_dof_stiffness', stiffness);

assignin('base', 'two_dof_fn', fn);
assignin('base', 'two_dof_ModeShapes', ModeShapes);

disp(' Output arrays:  two_dof_mass       ');  
disp('                 two_dof_stiffness  ');
disp('                 two_dof_fn         ');
disp('                 two_dof_ModeShapes ');


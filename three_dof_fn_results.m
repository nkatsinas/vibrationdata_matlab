
%
% three_dof_fn_results.m  ver 1.1  by Tom Irvine
%

function[fn,ModeShapes,pff,emm]=three_dof_fn_results(mass,stiffness)

tpi=2*pi;

[fn,~,ModeShapes,MST]=Generalized_Eigen(stiffness,mass,2);
%
dof=length(fn);
%
v=ones(dof,1)';

disp(' ');
mass

stiffness


%
disp('        Natural    Participation    Effective   ');
disp('Mode   Frequency      Factor        Modal Mass  ');
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

omegaD=zeros(dof,dof);

flexibility_matrix=zeros(dof,dof);


for i=1:dof

    if(fn(i)>1.0e-05)
    
        omega=tpi*fn(i);
    
        omegaD=1/omega^2;
        
        aabb=omegaD*ModeShapes(:,i)*ModeShapes(:,i)';
    
        flexibility_matrix=flexibility_matrix+aabb;
    end
        
end




for i=1:dof
        
        pff(i)=pf(i)/mmm(i,i);
        emm(i)=pf(i)^2/mmm(i,i);
        
        out1 = sprintf('%d  %10.4g Hz   %10.4g   %10.4g   ',i,fn(i),pff(i),emm(i));
        disp(out1)
        sum=sum+emm(i);
end
out1=sprintf('\n modal mass sum = %8.4g ',sum);
disp(out1);

ModeShapes

flexibility_matrix

disp(' Output arrays:  three_dof_mass, three_dof_stiffness, ModeShapes, fn');

assignin('base', 'three_dof_mass', mass);
assignin('base', 'three_dof_stiffness', stiffness);
assignin('base', 'ModeShapes', ModeShapes);
assignin('base', 'fn', fn);



%
% tdof_fn_etr_results.m  ver 1.3  by Tom Irvine
%

function[fn,ModeShapes,pff,emm]=tdof_fn_etr_results(mass,stiffness,iu)

disp('  ');
disp(' * * * * * * ');
disp(' ');

[fn,~,ModeShapes,MST]=Generalized_Eigen(stiffness,mass,2);
%
dof=length(fn);
%
v=ones(dof,1)';

if(iu==1)
    disp(' Mass unit:  lbf sec^2/in  ');
else
    disp(' Mass unit:  kg  ');    
end
    
mass

if(iu==1)
    disp(' Stiffness unit:  lbf/in  ');
else
    disp(' Stiffness unit:  N/m  ');    
end

stiffness


%
disp('        Natural    Participation    Effective Modal       ');

if(iu==1)
    disp('Mode   Freq (Hz)      Factor        Mass (lbm)     ');
else
    disp('Mode   Freq (Hz)      Factor        Mass (kg)     ');    
end    

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
        if(iu==1)
            out1 = sprintf('%d  %10.4g    %10.4g    %10.4g   %10.4g',i,fn(i),pff(i),emm(i)*386);
            sum=sum+emm(i);            
        else
            out1 = sprintf('%d  %10.4g    %10.4g    %10.4g   %10.4g',i,fn(i),pff(i),emm(i));
            sum=sum+emm(i);              
        end    
        disp(out1)
        
end
if(iu==1)
    out1=sprintf('\n modal mass sum = %8.4g lbm \n',sum*386);
else
    out1=sprintf('\n modal mass sum = %8.4g kg \n',sum);    
end
disp(out1);

disp(' Mass-normalized Mode Shapes ');

ModeShapes


 
etr=zeros(2,2);
em=zeros(2,1);
 
for i=1:2
    for k=1:2
        etr(i,k)=ModeShapes(i,k)*pff(k);
    end    
end

em(1)=pff(1)^2;
em(2)=pff(2)^2;

disp(' ');

if(iu==1)
    disp(' Effective Masses (lbm) ');
    out1=sprintf('\n  M00,1= %7.3g \n  M00,2= %7.3g \n ',em(1)*386,em(2)*386);
else
    disp(' Effective Masses (kg) ');
    out1=sprintf('\n  M00,1= %7.3g \n  M00,2= %7.3g \n ',em(1),em(2));    
end    
   
disp(out1);


disp(' ');
disp(' Effective Transmissibilities ');
disp(' ');

out1=sprintf('  T01,1= %7.3g \n  T01,2= %7.3g \n ',etr(1,1),etr(1,2));
disp(out1);

out1=sprintf('  T02,1= %7.3g \n  T02,2= %7.3g  ',etr(2,1),etr(2,2));
disp(out1);


assignin('base', 'two_dof_mass', mass);
assignin('base', 'two_dof_stiffness', stiffness);

assignin('base', 'two_dof_fn', fn);
assignin('base', 'two_dof_ModeShapes', ModeShapes);

assignin('base', 'two_dof_PF', pff);

disp(' ');
disp(' Output arrays:  two_dof_mass       ');  
disp('                 two_dof_stiffness  ');
disp('                 two_dof_fn         ');
disp('                 two_dof_ModeShapes ');
disp('                 two_dof_PF ');


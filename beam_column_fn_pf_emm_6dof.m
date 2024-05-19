%
%  beam_column_fn_pf_emm_6dof.m  ver 1.0  by Tom Irvine
%
function[pf]=beam_column_fn_pf_emm_6dof(iu,total_mass,dof,fn,mass,ModeShapes,MST,ivector)

v=ivector;

LM=MST*mass*v;
        
pf=LM;

%    
mmm=MST*mass*ModeShapes;   
%  

pff=zeros(dof,3);
emm=zeros(dof,3);

for i=1:dof
    
    for j=1:3
        pff(i,j)=pf(i,j)/mmm(i,i);
        emm(i,j)=pf(i,j)^2;
        
        if(emm(i,j) < 1e-12)
            emm(i,j)=0.;
            pff(i,j)=0.;
        end
        
    end
%
end


%
    disp(' ');
        disp('                       Effective Modal Mass      ');
        disp('           Natural        TX       TY       TZ   ');
    
    if(iu==1)
        disp('Mode       Freq(Hz)      (lbm)    (lbm)    (lbm)  ');
    else
        disp('Mode       Freq(Hz)       (kg)     (kg)     (kg)  ');        
    end
%
    sss=zeros(dof,3);

    
%   
    pdof=dof;
    
    if(pdof>40)
        pdof=40;
    end
  
    
    for i=1:pdof
        
        if(iu==1)
            out1 = sprintf('  %d \t %9.4g \t %8.4g \t %8.4g \t %8.4g  ',i,fn(i),386*emm(i,1),386*emm(i,2),386*emm(i,3));
        else
            out1 = sprintf('  %d \t %9.4g \t %8.4g \t %8.4g \t %8.4g  ',i,fn(i),emm(i,1),emm(i,2),emm(i,3));            
        end
        disp(out1)    
        
    end        
%

    sss(1)=sum(emm(:,1));
    sss(2)=sum(emm(:,2));  
    sss(3)=sum(emm(:,3));     

    disp(' ')
    disp(' Total Effective Mass ');
    
    
    if(iu==1)
        out1 = sprintf(' Longitudinal TX:  %10.4g lbm',sss(1)*386 );
        out2 = sprintf('   Transverse TY:  %10.4g lbm',sss(2)*386 );   
        out3 = sprintf('      Lateral TZ:  %10.4g lbm',sss(3)*386 );        
    else
        out1 = sprintf(' Longitudinal TX:  %10.4g kg',sss(1) );
        out2 = sprintf('   Transverse TY:  %10.4g kg',sss(2) );     
        out3 = sprintf('      Lateral TZ:  %10.4g kg',sss(2) );         
    end
    
    disp(out1)
    disp(out2)
    disp(out3)   
    
    pf=pff;
    
    
    disp(' ')
    
    if(iu==1)
        out1=sprintf(' Total Mass = %7.3g lbm ',total_mass*386);
    else
        out1=sprintf(' Total Mass = %7.3g kg ',total_mass);
    end
    
    disp(out1);
    

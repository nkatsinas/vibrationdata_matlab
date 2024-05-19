%
%  beam_fn_pf_emm.m  ver 1.0  by Tom Irvine
%
function[pf]=beam_fn_pf_emm(iu,total_mass,dof,fn,mass,ModeShapes,MST,dof_status,ivector)

v=ivector;

LM=MST*mass*v;
        
pf=LM;
%    
mmm=MST*mass*ModeShapes;   
%  

pff=zeros(dof,1);
emm=zeros(dof,1);

for i=1:dof
    pff(i)=pf(i)/mmm(i,i);
    emm(i)=pf(i)^2/mmm(i,i);
    if(emm(i) < 1e-20)
        emm(i)=0.;
        pff(i)=0.;
    end    
%
end

rs=0;

%
    disp(' ');
    disp('                                       Effective              Running ');
    disp('           Natural     Participation   Modal Mass    Mass      Sum');
    
    if(iu==1)
        disp('Mode       Freq(Hz)       Factor         (lbm)      Percent   Percent');
    else
        disp('Mode       Freq(Hz)       Factor         (kg)       Percent   Percent');        
    end
%
    sss=0;


   tmm=total_mass;
    
%   
    pdof=dof;
    
    if(pdof>12)
        pdof=12;
    end
  
    
    for i=1:pdof
        frac=100*emm(i)/tmm;
        
        rs=rs+frac;
        
        if(frac<0.0001)
            frac=0;
        end
        
        
        if(iu==1)
            out1 = sprintf('  %d \t %11.5g \t %8.5f \t %9.5f \t   %7.3f \t %7.1f ',i,fn(i),pff(i),386*emm(i),frac,rs);
        else
            out1 = sprintf('  %d \t %11.5g \t %8.5f \t %9.5f \t   %7.3f \t %7.1f ',i,fn(i),pff(i),emm(i),frac,rs);            
        end
        disp(out1)
        
        
        sss=sss+emm(i);
        
        if(i==24)
            break;
        end
    end        
%
    disp(' ')
    
    if(iu==1)
        out1 = sprintf(' Total Effective Modal Mass = %10.4g lbf sec^2/in',sss );
        out2 = sprintf('                            = %10.4g lbm',sss*386 );
    else
        out1 = sprintf(' Total Effective Modal Mass = %10.4g kg',sss );        
    end
    
    disp(out1)
    if(iu==1)
        disp(out2)
    end    
    
    pf=pff;
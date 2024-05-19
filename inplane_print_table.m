%
%  inplane_print_table.m  ver 1.0  by Tom Irvine
%
function[pdof]=inplane_print_table(iu,total_mass,emmx,emmy,fn)

        disp(' ');
        disp('                        ---- X-axis ----     ---- Y-axis ----      ');
        disp('                         Effective              Effective            ');
        disp('            Natural      Modal Mass   Mass      Modal Mass   Mass    ');
    
    if(iu==1)
        disp('Mode        Freq(Hz)       (lbm)      (%)         (lbm)      (%)');
    else
        disp('Mode        Freq(Hz)        (kg)      (%)          (kg)      (%)');        
    end 
%
    sssx=0;
    sssy=0;    
    
    tmm=total_mass;
    
    if(iu==1)
        tmm=tmm/386;
    end
    
    pdof=length(emmx);
    
    if(pdof>40)
        pdof=40;
    end

    for i=1:pdof
        
        fracx=100*emmx(i)/tmm;
        fracy=100*emmy(i)/tmm;        
        
        if(fracx<0.001)
            fracx=0;
        end
        if(fracy<0.001)
            fracy=0;
        end       
        
        emux=emmx;
        emuy=emmy;        
        
        if(iu==1)
            emux=emux*386;
            emuy=emuy*386;            
        end    
        
        out1 = sprintf('  %d \t %11.5g  \t %9.5f \t %6.2f \t %9.5f \t %6.2f',i,fn(i),emux(i),fracx,emuy(i),fracy);
        disp(out1)
        
        
        sssx=sssx+emmx(i);
        sssy=sssy+emmy(i);        
        
        if(i==24)
            break;
        end
    end        
%
    disp(' ')
    disp(' ------------- X-axis ------------- ');
    
    if(iu==1)
        out1 = sprintf(' Total Effective Modal Mass = %10.4g lbf sec^2/in',sssx );
        out2 = sprintf('                            = %10.4g lbm',sssx*386 );
    else
        out1 = sprintf(' Total Effective Modal Mass = %10.4g kg',sssx );        
    end
    
    disp(out1)
    if(iu==1)
        disp(out2)
    end     
    
    
    
    disp(' ')
    disp(' ------------- Y-axis ------------- ');
    
    if(iu==1)
        out1 = sprintf(' Total Effective Modal Mass = %10.4g lbf sec^2/in',sssy );
        out2 = sprintf('                            = %10.4g lbm',sssy*386 );
    else
        out1 = sprintf(' Total Effective Modal Mass = %10.4g kg',sssy );        
    end   
    
    disp(out1)
    if(iu==1)
        disp(out2)
    end    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

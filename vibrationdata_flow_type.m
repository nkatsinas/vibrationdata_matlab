%
%   vibrationdata_flow_type.m  ver 1.0  by Tom Irvine
%

function[Uc,q,F,comp,prms]=vibrationdata_flow_type(ftype,nopt,Uinf,gas_md,M,coeff)

M2=M^2;

Uc=coeff*Uinf;

q=0.5*gas_md*Uinf^2;

WT_ratio=1;

F= 0.5 + WT_ratio*(0.5 + 0.09*M2) + 0.04*M2;

if(ftype==1) % attached flow

    disp(' Attached Flow');
    
	prms = (0.01/F)*q;   
    
    comp=1;

end
if(ftype==2) % separated flow & shockwaves: compression corner
    
    disp(' Separated Flow & Shockwaves: Compression Corner');
    
    if(nopt==1) % cc_plateau_tf
        
        disp(' Plateau, Transonic');
     
        poqcomp = 0.025/(1.+M2);
        prms = poqcomp*q;
        
        comp=3;

    end
    if(nopt==2) % cc_reattachment_tf
        
        disp(' Reattachment, Transonic');        
        
        poqcomp = 0.10/(1.+M2);
        prms = poqcomp*q;
        
        comp=9;
    
    end
    
    if(nopt==3 || nopt==4)
        
        M1=str2num(get(handles.edit_upstream_mach,'String'));
        
        if(M1<1.0)
           warndlg('Upstream Mach must be supersonic.'); 
           return; 
        end
        
        alpha=str2num(get(handles.edit_frustrum_angle,'String'));
        
        alpha=alpha*pi/180.;
        
        theta = alpha + asin(1./M1);

        s2 =  (sin(theta))^2;

        P2P1 = ( (2.8*(M1^2)*s2) - 0.4 )/2.4;  
        
        poqtbl = 0.006/F;
        
    end
    
    if(nopt==3) % cc_plateau_supersonic
              
        
        disp(' Plateau, Supersonic');
        
        poq = poqtbl*P2P1;	  %  plateau
        prms = poq*q;
        
        comp=10;
        
    end    
    if(nopt==4) % cc_separation_or_shockwave
        
        disp(' Separation or Reattachment Shockwave (Local Supersonic)');

        if( P2P1 < 0.593 )

            warndlg('P2P1 < 0.593');
            return;
            
        end

 	    pshock= ( -1.181 + 1.713*P2P1 + 0.468*( P2P1^2) )*(0.006/F)*q;
       
        if( pshock < 0 )
            
            warndlg('pshock < 0');
            return;           
            
        end    
        
        poq = ( -1.181 + 1.713*P2P1 + 0.468*( P2P1^2) )*(0.006/F);        
        prms = poq*q;        
        
        comp=30;
        
    end    
    
end  
if(ftype==3) % separated flow & shockwaves: expansion corner
    
    disp(' Separated Flow & Shockwaves: Expansion Corner');    
    
    if(nopt==1) % exp_plateau
        
        disp(' Plateau');
        
        poqexp  = 0.040/(1 + M2);
        prms=poqexp*q;
        
        comp=3;
    
    end
    if(nopt==2) % exp_reattachment
        
        disp(' Reattachment');
        
        poqexp  = 0.16/(1 + M2);
        prms=poqexp*q;        
        
        comp=9;
        
    end
    
end  
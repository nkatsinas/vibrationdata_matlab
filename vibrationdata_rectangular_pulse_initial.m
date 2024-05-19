%
%  vibrationdata_rectangular_pulse_initial.m  ver 1.1  by Tom Irvine
%
function[a_srs,pv_srs,rd_srs,base_th,a_th,rd_th]=...
             vibrationdata_rectangular_pulse_initial(nat,amp,dur,fn,Q,resp_dur,iunit,rd0,rv0)
% 
damp=1/(2*Q);
%
%
limit=length(fn);
%
a_srs=zeros(limit,3);
pv_srs=zeros(limit,3);
rd_srs=zeros(limit,3);
%
dt2 = dur/32.;
%
%%%%%
omega = pi/dur;

         if(iunit==1)
           amp=amp*386;
        else
           amp=amp*9.81;
        end

%
for ijk=1:limit
%	
		dt = 1./(32.*fn(ijk));
%	
		if(dt>dt2)
            dt=dt2;
        end 
        if(nat==2)   
		    nt = floor(resp_dur/dt);
        else
            T= 1./fn(ijk);
      		nt = round( ( T + dur) /dt );      
        end
%
		omegan=2*pi*fn(ijk);
%
		omegad = omegan*sqrt(1.- (damp^2.));
%
		omegan2=omegan^2.;
%
		domegan=damp*omegan;

        
%
        [acc1,rd1,~,TT,yb]=vb_rectangular_calc(domegan,omegad,damp,...
                                        omega,omegan,omegan2,nt,dt,dur,amp);
%
        acc1=fix_size(acc1);
        rd1=fix_size(rd1);
        TT=fix_size(TT);
        yb=fix_size(yb); 
        
%
        rd_initial=rd0;
        rv_initial=rv0;

        [acc2,rd2]=...
            free_vibration_function(rd_initial,rv_initial,domegan,omegad,omegan2,TT);
        
        acc2=fix_size(acc2);
        rd2=fix_size(rd2);
        
        rd=rd1+rd2;
        acc=acc1+acc2;

%
        pv=omegan*rd;
%        
        if(iunit==1)
           acc=acc/386;
           yb=yb/386;
        else
           acc=acc/9.81;
           yb=yb/9.81;            
           rd=rd*1000;
        end
%
        if(nat==1)
%
             a_srs(ijk,:)=[fn(ijk) max(acc) abs(min(acc))];
            pv_srs(ijk,:)=[fn(ijk) max(pv) abs(min(pv))];
            rd_srs(ijk,:)=[fn(ijk) max(rd) abs(min(rd))];
%
           if(ijk==1)
      
              a_th=[TT acc];
              rd_th=[TT rd];
              base_th=[TT yb];            
           end
%
        end
end
%
if(nat==1)
    setappdata(0,'accleration_srs',a_srs);
    setappdata(0,'pseudo_velocity_srs',pv_srs);
    setappdata(0,'relative_disp_srs',rd_srs);    
else    
    ab_th=[TT yb acc];
    a_th=[TT acc];
    rd_th=[TT rd];
    base_th=[TT yb];
    setappdata(0,'base_input',base_th);
    setappdata(0,'acceleration',a_th);
    setappdata(0,'relative_disp',rd_th);       
end
%
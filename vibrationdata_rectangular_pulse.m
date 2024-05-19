%
%  vibrationdata_rectangular_pulse.m  ver 1.0  by Tom Irvine
%
function[a_srs,pv_srs,rd_srs,base_th,a_th,rd_th]=...
             vibrationdata_rectangular_pulse(nat,amp,dur,fn,Q,resp_dur,iunit)
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
        [acc,rd,~,TT,yb]=vb_rectangular_calc(domegan,omegad,damp,...
                                        omega,omegan,omegan2,nt,dt,dur,amp);
%
        acc=fix_size(acc);
        rd=fix_size(rd);
        TT=fix_size(TT);
        yb=fix_size(yb);        
%
        pv=omegan*rd;
%        
        if(iunit==1)
           rd=rd*386;
           pv=pv*386;
        else
           rd=rd*9.81*1000;
           pv=pv*9.81;
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
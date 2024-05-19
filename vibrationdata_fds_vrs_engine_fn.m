%
%   vibrationdata_fds_vrs_engine_fn.m  ver 1.3  by Tom Irvine
%
function[fn,a_vrs,pv_vrs,rd_vrs,damage]=...
             vibrationdata_fds_vrs_engine_fn(fi,ai,damp,df,iu,idc,irp,bex,dur,fn)
%
    disp(' Calculating VRS.... ')
    disp(' ')
%
    tpi=2*pi;
    tpi_sq=tpi^2;
    last=length(fi);
%
    mn=length(fn);
    damage=zeros(mn,1);
    a_vrs=zeros(mn,1);
    rd_vrs=zeros(mn,1);    
    pv_vrs=zeros(mn,1);
%
    progressbar; 
    for i=1:mn   % natural frequency loop
        progressbar(i/mn);
%
%   absolute acceleration
%
        sum=0.; 
%
        apsd=zeros(last,2);
        apsd(:,1)=fi;
        for j=1:last 
%
		    rho = fi(j)/fn(i);
			tdr=2.*damp*rho;
%
            c1= tdr^2.;
			c2= (1.- (rho^2.))^ 2.;
%
			t= (1.+ c1 ) / ( c2 + c1 );
            apsd(j,2)=t*ai(j);            
            sum = sum + apsd(j,2)*df;
%       
        end
%
        a_vrs(i)=sqrt(sum);
%
%   relative displacement
%
		sum=0.; 
%
        rd_psd=zeros(last,1);
        pv_psd=zeros(last,1);
        rd_psd(:,1)=fi;
        pv_psd(:,1)=fi;
%       
        for j=1:last 
%
            c1= ((fn(i)^2.)-(fi(j)^2.) )^2.;
			c2= ( 2.*damp*fn(i)*fi(j))^2.;
%
			t= 1. / ( c2 + c1 );   
%
            rd_psd(j,2)=t*ai(j);
            sum = sum + rd_psd(j,2)*df;
        end
%
%   pv in m/sec
%
        if(iu==1)
            rd_vrs(i)=sqrt(sum)*386./tpi_sq;
            rd_psd(:,2)=rd_psd(:,2)*(386./tpi_sq)^2;
            pv_vrs(i)=rd_vrs(i)*tpi*fn(i);
        end
        if(iu==2)
            rd_vrs(i)=sqrt(sum)*9.81*1000/tpi_sq;
            rd_psd(:,2)=rd_psd(:,2)*(9.81*1000/tpi_sq)^2; 
            pv_vrs(i)=rd_vrs(i)*tpi*fn(i)/1000;
        end
        if(iu==3)
            rd_vrs(i)=sqrt(sum)*1000/tpi_sq;
            rd_psd(:,2)=rd_psd(:,2)*(1000/tpi_sq)^2;   
            pv_vrs(i)=rd_vrs(i)*tpi*fn(i)/1000;
        end
%
        if(idc==1)  % calculate fds
            if(irp==1)  % accel
                [ddd]=Dirlik_fds(apsd,bex,dur,df);
                damage(i)=ddd;
            end
            if(irp==2)  % pv
                
                for j=1:last                
                    pv_psd(j,2)=rd_psd(j,2)*(tpi*rd_psd(j,1))^2;
                    
                    if(iu>=2)
                        pv_psd(j,2)=pv_psd(j,2)/1000^2;
                    end
                end    
                
                [ddd]=Dirlik_fds(pv_psd,bex,dur,df);
                damage(i)=ddd;
            end   
            if(irp==3)  % rd
                [ddd]=Dirlik_fds(rd_psd,bex,dur,df);
                damage(i)=ddd;
            end 
        end
%
    end
%
    if(idc==2)
        num=length(fn);
        damage=zeros(num,1); 
    end
    pause(0.2);
%
%   fds_vrs_engine.m  ver 1.3  June 20, 2014
%
function[fn,a_vrs,rd_vrs,damage]=...
                           fds_vrs_engine(fi,ai,damp,df,iu,idc,irp,bex,dur)
%
    disp(' Calculating VRS.... ')
    disp(' ')
%
	fn(1)=5.;
    oct=1./24.;
    tpi=2.*pi;
    tpi_sq=tpi^2;
    last=length(fi);
    fff=2.*fi(last);
%
    for i=1:10000
        if(fn(i) > 10000. )
            break;
        end
        if(fn(i) > fff )
            break;
        end    
     	fn(i+1)=fn(i)*(2.^oct);         
    end
%
    mn=length(fn);
    damage=zeros(mn,1);
    a_vrs=zeros(mn,1);
    rd_vrs=zeros(mn,1);    
%
	for i=1:mn   % natural frequency loop
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
        if(idc==1)   % calculate fds
            if(irp==1)  % accel
                [ddd]=Dirlik_fds(apsd,bex,dur,df);
                damage(i)=ddd;
            end
        end
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
        if(iu==1)
            rd_vrs(i)=sqrt(sum)*386./tpi_sq;
            rd_psd(:,2)=rd_psd(:,2)*(386./tpi_sq)^2;
        else
            rd_vrs(i)=sqrt(sum)*9.81*1000/tpi_sq;
            rd_psd(:,2)=rd_psd(:,2)*(9.81*1000/tpi_sq)^2;            
        end
%
        if(idc==1)  % calculate fds
            if(irp==2)  % pv
                for k=1:length(rd_psd(:,1))
                    omega=tpi*fi(k);
                    pv_psd(k,2)=rd_psd(k,2)*omega^2;
                end
                if(iu==2)
                    pv_psd(:,2)=pv_psd(:,2)/100;  % convert to (cm/sec)^2/Hz
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
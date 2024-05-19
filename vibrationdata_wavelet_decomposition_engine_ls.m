%
%   vibrationdata_wavelet_decomposition_engine_ls.m  ver 1.0  by Tom Irvine
%
%
function[acceleration,velocity,displacement,wavelet_table]=...
  vibrationdata_wavelet_decomposition_engine_ls(t,accel,dt,first,...
                            ffmin,ffmax,iunit,nfr,start_time,LF,minw,maxw)
%
tp=2*pi;
%
residual=accel;
%
num2=max(size(accel));
%
fprintf(' number of input points= %d \n',num2);
%
duration=t(num2)-t(1);
%
sr=1/dt;
%
fprintf(' sample rate = %10.4g \n\n',sr);

%
fl=3/duration;
fu=sr/8;

if(LF==1)
    if(fl>ffmin)
        ffmin=fl;
    end
    if(fu<ffmax)
        ffmax=fu;
    end    
else
    ffmin=fl;
    ffmax=fu;
end


%
clear y;
%
progressbar;
%
x1r=zeros(nfr,1);
x2r=zeros(nfr,1);
x3r=zeros(nfr,1);
x4r=zeros(nfr,1);


%
for ie=1:nfr
%
        progressbar(ie/nfr);
%
        fprintf(' frequency case %d \n',ie);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

    ivk=0;

    while(1)
        
        if(ie<=5)
            ia=1;
            ib=num2;
        else
            i1=round(num2*rand());
            i2=round(num2*rand());
            ia=min([i1 i2]);
            ib=max([i1 i2]);
            if(ia<1)
                ia=1;
            end
            if(ib>num2)
                ib=num2;
            end
            if((ib-ia)< num2/5 )
                ia=1;
                ib=num2;
            end   
            
            num2h=round(num2/2);
            
            if(rand()>=0.95)
                ib=num2;
                if(ia<num2h)
                    ia=num2h;
                end
            end
            
        end
        
        rose=residual;
        
        if(length(residual)~=length(t))
            size(t)
            size(residual)            
            warndlg('error 0a');
            return;
        end   
        if(length(residual(ia:ib))~=length(t(ia:ib)))
            size(t)
            size(residual)            
            warndlg('error 0b');
            return;
        end     

        try
            r1=0;
            r2=0;
            ar=0;
            iflag=0;
            
            ijk=ie;
            [ax1r,ax2r,ax3r,ax4r,ar]=decomposition_wgen_ls(t(ia:ib),residual(ia:ib),minw,maxw,start_time,ffmin,ffmax,ijk);
        catch
            size(t)
            size(residual)
            size(r1)
            size(ar)
            size(r2)
            fprintf('ia=%d  ib=%d  iflag=%d \n',ia,ib,iflag);
            warndlg('error 1');
            return;
        end
            
        clear residual;
        
        r1=0;
        r2=0;
        
        try
            r1=rose(1:(ia-1));
        catch
        end
        try
            r2=rose((ib+1):end);
        catch
        end
        
        r1=fix_size(r1);
        r2=fix_size(r2);
        ar=fix_size(ar);
            
        if(ia==1 && ib==num2)
            residual=ar;
            iflag=1;
        end
        
        if(ia==1 && ib<num2)
            residual=[ar; r2];
            iflag=2;
        end
        
        
        if(ia>1 && ib<num2)
            residual=[r1; ar; r2];
            iflag=3;
        end
        
        if(ia>1 && ib==num2)
            residual=[r1; ar];
            iflag=4;
        end
        
        if(length(residual)~=length(t))
            warndlg('error 2');
            return;
        end
        
        
        ivk=ivk+1;
        
        if(ivk>=100)
            break;
        end
       
        if(abs(ax1r)>1.0e-80 && ax2r>1.0e-80)
            break;
        end    
        
    end    
        
        x1r(ie)=ax1r;
        x2r(ie)=ax2r;
        x3r(ie)=ax3r;
        x4r(ie)=ax4r;

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        ave=mean(residual); 
        sd=std(residual);
%
        fprintf(' ave=%12.4g  sd=%12.4g \n\n',ave,sd);  
% 
end
%
pause(0.4);
progressbar(1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
clear aaa;
clear vvv;
clear ddd;
clear mm;
%
aaa=zeros(num2,1); 
vvv=zeros(num2,1); 
ddd=zeros(num2,1); 
%
disp(' ');
%
for i=1:nfr
%
        x4r(i)=x4r(i)-t(1);

        out1=sprintf(' amp=%10.4f   freq=%10.3f Hz   nhs=%d   delay=%10.4f ',x1r(i),x2r(i)/tp,x3r(i),x4r(i));
        disp(out1);
%
        wavelet_table(i,1)=i;
        wavelet_table(i,2)=x2r(i)/tp;   
        wavelet_table(i,3)=x1r(i);
        wavelet_table(i,4)=x3r(i); 
        wavelet_table(i,5)=x4r(i);  
%
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
vlast=zeros(num2,1);
%
iscale=1;
%
progressbar;
for k=1:num2
%
        progressbar(k/num2);
%
        tt=t(k);
%  
        for j=1:nfr
%
            w=0.;
            v=0.;
            d=0.;
%
            t1=x4r(j)+t(1);
%
            if(x2r(j)>=1.0e-10)
%
            else
                x2r(j)=fl*tp;
                x1r(j)=1.0e-20;
                x3r(j)=3;
                x4r(j)=0; 
            end
            t2=tp*x3r(j)/(2.*x2r(j))+t1; 
%
            if( tt>=t1  && tt <=t2  )
%
                arg=x2r(j)*(tt-t1);  
%
                w=  x1r(j)*sin(arg/double(x3r(j)))*sin(arg);
%
                aa=x2r(j)/double(x3r(j));
                bb=x2r(j);
%
                te=tt-t1;
%
                alpha1=aa+bb;
                alpha2=aa-bb;
%
                alpha1te=alpha1*te;
                alpha2te=alpha2*te;   
%
                v1= -sin(alpha1te)/(2.*alpha1);
                v2= +sin(alpha2te)/(2.*alpha2);
%
                d1= +(cos(alpha1te)-1)/(2.*(alpha1^2));
                d2= -(cos(alpha2te)-1)/(2.*(alpha2^2));
%
                v=(v2+v1)*iscale*x1r(j);
                d=(d2+d1)*iscale*x1r(j);
%
                vlast(j)=v;
%
            end
%
            aaa(k)=aaa(k)+w; 
            vvv(k)=vvv(k)+v;
            ddd(k)=ddd(k)+d;
%
            if(x3r(j)<1)
                printf(' error x3r ');
                break;
            end
%
        end
%
end
%
if(iunit==1)
    vvv=vvv*386;
    ddd=ddd*386;
end
if(iunit==2)
    vvv=vvv*9.81*100;
    ddd=ddd*9.81*1000;
end
if(iunit==3)
    vvv=vvv*100;
    ddd=ddd*1000;
end
%
progressbar(1);
%
t=fix_size(t);
aaa=fix_size(aaa);
vvv=fix_size(vvv);
ddd=fix_size(ddd);
%
acceleration=[t aaa];
    velocity=[t vvv];
displacement=[t ddd];
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
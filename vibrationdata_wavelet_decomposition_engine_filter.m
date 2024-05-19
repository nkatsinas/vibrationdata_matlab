%
%   vibrationdata_wavelet_decomposition_engine_filter.m  ver 1.1  by Tom
%   Irvine
%
%
function[acceleration,velocity,displacement,wavelet_table]=...
  vibrationdata_wavelet_decomposition_engine_filter(t,accel,dt,first,...
                                        iunit,nt,start_time,minw,maxw,fc,sd,nwave)
%
tp=2*pi;
%
residual=accel;
%
num2=max(size(accel));
%
out1=sprintf(' number of input points= %d ',num2);
disp(out1);
%
duration=t(num2)-t(1);
%
sr=1/dt;
%
out1=sprintf(' sample rate = %10.4g \n',sr);
disp(out1);
%

nfc=length(fc);

%
clear y;
%

nw=sum(nwave);

  
x1r=zeros(nw,1);
x2r=zeros(nw,1);
x3r=zeros(nw,1);
x4r=zeros(nw,1);

kx=1;

progressbar;


for ijk=1:nfc


    
    for ie=1:nwave(ijk)
%

        ratio=(kx-1)/nw;
        progressbar(ratio);
    

        out1=sprintf(' frequency case %d %d ',ijk,ie);
        disp(out1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%        disp(' ref 1');

        [ax1r,ax2r,ax3r,ax4r]=...
        decomposition_wgen_filter(t,residual,nt,start_time,minw,maxw,fc(ijk),sd(ijk),duration,num2);

%%        disp(' ref 2');
        x1r(kx)=ax1r;
        
        x2r(kx)=ax2r;
        x3r(kx)=ax3r;
        x4r(kx)=ax4r;
        
        for i=1:num2
%
            tt=t(i);
%
            t1=x4r(kx) + t(1);
            t2=t1 + tp*x3r(kx)/(2.*x2r(kx));
%
            if( tt>= t1 && tt <= t2)
%
                arg=x2r(kx)*(tt-t1);  
                y=x1r(kx)*sin(arg/double(x3r(kx)))*sin(arg);   
%
                residual(i)=residual(i)-y;
            end
        end   
        ave=mean(residual); 
        sdv=std(residual);
%
        out1=sprintf(' ave=%12.4g  sd=%12.4g \n\n',ave,sdv);
        disp(out1);          
        
        kx=kx+1;
        
    end

end

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


wavelet_table=zeros(nw,5);

%
for i=1:nw
%
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
        for j=1:nw
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
                x2r(j)=tp;
                x1r(j)=0;
                x3r(j)=3;
                x4r(j)=0;
                t1=x4r(j)+t(1);  
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
%
%   vibrationdata_DSS_waveform_reconstruction.m  ver 1.3 by Tom Irvine
%
function[acceleration,velocity,displacement,srs_syn,wavelet_table]=...
  vibrationdata_DSS_waveform_reconstruction(t,accel,dt,first,freq,...
                                             ffmin,ffmax,damp,iunit,nt,nfr)
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
fl=3/duration;
fu=sr/10;
%
out1=sprintf(' fl = %10.4g Hz   fu = %10.4g Hz \n',fl,fu);
disp(out1);
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
        out1=sprintf(' frequency case %d ',ie);
        disp(out1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
        disp(' ref 1');
        [x1r,x2r,x3r,x4r]=...
        DSS_wgen(num2,t,dt,residual,duration,sr,x1r,x2r,x3r,x4r,fl,fu,nt,ie,ffmin,ffmax,first);
        disp(' ref 2');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
        if(x2r(ie)<fl*tp)
            x2r(ie)=fl*tp;
            x1r(ie)=1.0e-20;    
            x3r(ie)=3;
            x4r(ie)=0;
        end
%
        for i=1:num2
%
            tt=t(i);
%
            t1=x4r(ie) + t(1);
            t2=t1 + tp*x3r(ie)/(2.*x2r(ie));
%
            if( tt>= t1 && tt <= t2)
%
                arg=x2r(ie)*(tt-t1);  
                y=x1r(ie)*sin(arg/double(x3r(ie)))*sin(arg);   
%
                residual(i)=residual(i)-y;
            end
        end   
        ave=mean(residual); 
        sd=std(residual);
%
        out1=sprintf(' ave=%12.4g  sd=%12.4g \n\n',ave,sd);
        disp(out1);   
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
        if(x2r(i)<fl*tp)
            x2r(i)=fl*tp;
            x1r(i)=1.0e-20;
            x3r(i)=3;
            x4r(i)=0;
        end
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
else
    vvv=vvv*9.81;
    ddd=ddd*9.81*1000;
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
%*********************** initialize filter coefficients ***************/
%
[a1,a2,b1,b2,b3,~,~,~,~,~]=srs_coefficients(freq,damp,dt);   
%
clear nnn;
nnn=length(freq);
%
xmax=zeros(nnn,1);
xmin=zeros(nnn,1);
%
for j=1:nnn
% 
    clear resp;
    clear forward;
    clear back;
%   
    forward=[ b1(j),  b2(j),  b3(j) ];
    back   =[ 1, -a1(j), -a2(j) ];
%
    resp=filter(forward,back,aaa);
%
    xmax(j)= abs(max(resp));
    xmin(j)= abs(min(resp));
end 
%
freq=fix_size(freq);
xmax=fix_size(xmax);
xmin=fix_size(xmin);
srs_syn=[freq xmax xmin];
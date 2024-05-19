disp(' ');
disp(' ss_plate_base.m  ver 1.9  April 10, 2013');
disp(' by Tom Irvine  Email: tom@vibrationdata.com ');
disp(' ');
disp(' Normal Modes & Optional Base Excitation for a simply-supported plate. ');
disp(' ');
%
close all;
%
clear root;
clear f;
clear H;
clear HA;
clear HA2;
clear beta;
clear fn;
clear fmn;
clear faux;
clear A;
clear M;
clear D;
clear x;
clear y;
clear z;
clear YY;
clear omegamn;
clear fbig;
clear part;
%
fig_num=1;
%
disp(' ');
disp(' Select units:  1=English  2=metric ');
iu=input(' ');
%
nmodes=5;
mt=nmodes^2;
%
num_nodes=81;
%
[E,rho,mu]=materials(iu);
%
[a,b,h,rho,D,mass]=rectangular_plate_entry_units(E,rho,mu,iu);
%
sq_mass=sqrt(mass);
%
DD=sqrt(D/(rho*h));
%
omegamn=zeros(nmodes,nmodes);
%
n2=nmodes*nmodes;
faux=zeros(nmodes,nmodes);
%
i=1;
for m=1:nmodes
    for n=1:nmodes
        omegamn(m,n)=DD*( (m*pi/a)^2 + (n*pi/b)^2 );
        faux(i)=omegamn(m,n)/(2*pi);
        i=i+1;
    end
end
%
fmn=omegamn/(2*pi);
sort(faux);
%
Amn=2/sqrt(mass);
%
AAA=(2*sqrt(mass)/pi^2);
iv=1;
part=zeros(nmodes,nmodes);
%
fbig=zeros(n2,5);
%
for i=1:nmodes
    for j=1:nmodes
        part(i,j)=(cos(i*pi)-1)*(cos(j*pi)-1);
        part(i,j)=AAA*part(i,j)/(i*j);
        fbig(iv,1)=faux(iv);
        fbig(iv,2)=i;
        fbig(iv,3)=j;
        fbig(iv,4)=part(i,j);
        fbig(iv,5)=(part(i,j))^2;
        iv=iv+1;
    end
end
fbig=sortrows(fbig,1);
%
disp(' ');
disp('    fn(Hz)   m   n        PF    EMM ratio');
for i=1:mt  
    out1=sprintf(' %9.5g \t %d\t %d\t %8.4g\t %8.4g  ',fbig(i,1),fbig(i,2),fbig(i,3),fbig(i,4),fbig(i,5)/mass);
    disp(out1);
end
disp(' ');
%
dx=a/80;
dy=b/80;
%
pa=pi/a;
pb=pi/b;
%
clear z;
clear zmn;
%
x=zeros(1,num_nodes);
y=zeros(1,num_nodes);
z=zeros(num_nodes,num_nodes);
zmn=zeros(mt,num_nodes,num_nodes);
%
for i=1:num_nodes
    x(i)=pa*(i-1)*dx;   
    y(i)=pb*(i-1)*dy;  
end
%
xx=x*a/max(x);
yy=y*b/max(y);
%
for iv=1:mt
    for i=1:num_nodes
        term1=sin(fbig(iv,2)*x(i));
        for j=1:num_nodes    
            z(i,j)=term1*sin(fbig(iv,3)*y(j));
            zmn(iv,i,j)=z(i,j);
        end        
    end
    if(iv<=4)
        figure(fig_num);
        fig_num=fig_num+1;
        zzr=z';
        surf(xx,yy,zzr);
        out1=sprintf('Mode %d   fn=%8.4g Hz',iv,fbig(iv,1));
        title(out1);
    end
%
end
%
z=z*Amn;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' Calculate Frequency Response Function ');
disp(' 1=yes  2=no ');
%
ia=input(' ');
%
if(ia==1)
%
    clear f;
    clear x;
    clear y;
    clear damp;
    clear Z;
    clear H;
    clear HA;
    clear om;
%    
    disp(' ');    
    out1=sprintf(' Enter uniform modal damping ratio ');
    disp(out1);
    damp=input(' ');
%    
    disp(' ');
    disp(' Enter response location distance x ');
    x=input(' ');
    if(x>a)
        disp(' Warning: x reset to total length');
        x=a;
    end
%
    disp(' ');
    disp(' Enter response location distance y ');
    y=input(' ');
    if(y>b)
        disp(' Warning: y reset to total length');
        y=b;
    end
%
   disp(' ');
   disp(' Enter maximum base excitation frequency Hz ');
   MAXF=input(' ');
%
   nf=20000;
   f(1)=1;
   for k=2:nf
        f(k)=f(k-1)*2^(1/48);
        if(f(k)>MAXF)
            break;
        end    
   end
   nf=max(size(f));
%
    pax=x*pi/a;
    pby=y*pi/b;
%
   Amn=2/sqrt(mass);
%
    sq_mass=sqrt(mass);
%
    tpi=2*pi; 
%
    clear H;
    clear Hv;
    clear HA;
%
    n2=nmodes*nmodes;
%
     H=zeros(n2,1);
    Hv=zeros(n2,1);
    HA=zeros(n2,1);
    Hsxx=zeros(n2,1);    
    Hsyy=zeros(n2,1);
    Htxy=zeros(n2,1);    
%
    for k=1:nf
         H(k)=0;
        Hv(k)=0;
        HA(k)=0;
 %
        Hsxx(k)=0;
        Hsyy(k)=0;    
        Htxy(k)=0;        
 %       
        om=tpi*f(k);
 %
        for i=1:nmodes
            for jk=1:nmodes          
 %                  
                clear num;
                clear den;
                clear pY;
                clear omn;
 %               
                sss=sin(i*pax)*sin(jk*pby);
                ccc=cos(i*pax)*cos(jk*pby);               
 %               
                nmode=Amn*sss;  
                pY=part(i,jk)*nmode;
                omn=omegamn(i,jk);
                num=-pY;
                den=(omn^2-om^2)+(1i)*2*damp*om*omn;
                num_den=num/den;
                H(k)=H(k)+num_den;
 %
                A=pi^2*m^2/a^2;
                B=pi^2*n^2/b^2;
 %
                Hsxx(k)=Hsxx(k)-pY*(A+mu*B)*Amn*sss/den;
                Hsyy(k)=Hsyy(k)-pY*(mu*A+B)*Amn*sss/den;
                Htxy(k)=Htxy(k)-pY*(pi^2*(m*n)/(a*b))*Amn*ccc/den;             
 %
                HA(k)=HA(k)-om^2*num_den;
 %      
            end
 %
        end
 %
        Hv(k)=(1i)*om*H(k);
 %
    end
%
    z=h/2;
    term1=-(E*z/(1-mu^2));    
    term2=-(E*z/(1+mu));
%
    H=abs(H);
    Hv=abs(Hv);
%    
    if(iu==1)
        H=386*H;
        Hv=386*Hv;
    else
        H=9.81*H;
        Hv=9.81*Hv;        
    end    
%   
    Hsxx=term1*Hsxx;
    Hsyy=term1*Hsyy;  
    Htxy=term2*Htxy;  
%
    clear HM_stress_vM;
%
    HM_stress_vM=zeros(nf,1);
    for k=1:nf
        HM_stress_vM(k)=sqrt( Hsxx(k)^2 + Hsyy(k)^2 - Hsxx(k)*Hsyy(k) + 3*Htxy(k)^2 );
    end
%
    Hsxx=abs(Hsxx);
    Hsyy=abs(Hsyy);  
    Htxy=abs(Htxy); 
%    
    HM_stress_vM=abs(HM_stress_vM);      
%    
    HA=HA+1;
    HA=abs(HA);
    HA2=HA.*HA;
%
    maxH=0;
    maxHv=0;
    maxHA=0;
%
    for k=1:nf
        if(H(k)>maxH)
            maxH=H(k);
            maxF=f(k);
        end
        if(Hv(k)>maxHv)
            maxHv=Hv(k);
            maxFv=f(k);
        end      
        if(HA(k)>maxHA)
            maxHA=HA(k);
            maxFA=f(k);
        end
    end       
%
    f=f';
%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(f,H);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
    if(iu==1)
        out1=sprintf('Rel Disp Frequency Response Function  x=%7.4g in  y=%7.4g in',x,y);
        ylabel('Rel Disp (in)/ Base Accel (G) ');
    else
        out1=sprintf('Rel Disp Frequency Response Function  x=%7.4g m  y=%7.4g m',x,y);
        ylabel('Rel Disp (m)/ Base Accel (G) ');        
    end
    title(out1);
    xlabel('Frequency (Hz)');
    grid on;
%
    rel_disp_H = [f H];    
%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(f,Hv);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
    if(iu==1)
        out1=sprintf('Rel Vel Frequency Response Function  x=%7.4g in  y=%7.4g in',x,y);
        ylabel('Rel Vel (in/sec)/ Base Accel (G) ');
    else
        out1=sprintf('Rel Vel Frequency Response Function  x=%7.4g m  y=%7.4g m',x,y);
        ylabel('Rel Vel (m/sec)/ Base Accel (G) ');        
    end
    xlabel('Frequency (Hz)')
    title(out1);
    grid on;
%
    rel_vel_H = [f Hv];
%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(f,HA);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
    if(iu==1)
        out1=sprintf('Accel Frequency Response Function  x=%7.4g in  y=%7.4g in',x,y);
    else
        out1=sprintf('Accel Frequency Response Function  x=%7.4g m  y=%7.4g m',x,y);        
    end
    title(out1);
    ylabel('Response Accel / Base Accel ');
    xlabel('Frequency (Hz)');
    grid on; 
%
    accel_H = [f HA];    
%    
    figure(fig_num);
    fig_num=fig_num+1;
    plot(f,HA2);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
    if(iu==1)
        out1=sprintf('Power Transmissibility  x=%7.4g in  y=%7.4g in',x,y);
    else
        out1=sprintf('Power Transmissibility  x=%7.4g m  y=%7.4g m',x,y);        
    end
    title(out1);
    ylabel('Trans (G^2/G^2) ');
    xlabel('Frequency (Hz)');
    grid on;
%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(f,Hsxx,f,Hsyy);
    legend('sxx','syy');
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
    if(iu==1)
        out1=sprintf('Bending Stress  x=%7.4g in  y=%7.4g in',x,y);
        ylabel('Trans (psi/G) ');
    else
        out1=sprintf('Bending Stress  x=%7.4g m  y=%7.4g m',x,y);
        ylabel('Trans (Pa/G) ');        
    end
    title(out1);
    xlabel('Frequency (Hz)');
    grid on;
%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(f,Htxy);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
    if(iu==1)
        out1=sprintf('Shear Stress  x=%7.4g in  y=%7.4g in',x,y);
        ylabel('Trans (psi/G) ');
    else
        out1=sprintf('Shear Stress  x=%7.4g m  y=%7.4g m',x,y);
        ylabel('Trans (Pa/G) ');        
    end
    title(out1);
    xlabel('Frequency (Hz)');
    grid on;  
%    
    figure(fig_num);
    fig_num=fig_num+1;
    plot(f,HM_stress_vM);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
    if(iu==1)
        out1=sprintf('von Mises Stress  x=%7.4g in  y=%7.4g in',x,y);
        ylabel('Trans (psi/G) ');
    else
        out1=sprintf('von Mises Stress  x=%7.4g m  y=%7.4g m',x,y);
        ylabel('Trans (Pa/G) ');        
    end
    title(out1);
    xlabel('Frequency (Hz)');
    grid on;      
%
    disp(' ');
    accel_H2 = [f HA2];   
%
    disp(' ');
%
    if(iu==1)
        out1=sprintf('  max Rel Disp FRF = %8.3g (in/G) at %8.4g Hz ',maxH,maxF);
        out2=sprintf('  max Rel Vel FRF = %8.3g (in/sec/G) at %8.4g Hz ',maxHv,maxFv);
    else
        out1=sprintf('  max Rel Disp FRF = %8.3g (m/G) at %8.4g Hz ',maxH,maxF);
        out2=sprintf('  max Rel Vel FRF = %8.3g (m/sec/G) at %8.4g Hz ',maxHv,maxFv);   
    end
    disp(out1);
    disp(out2);
%   
    out1=sprintf('  max Accel FRF    = %8.4g (G/G)     at %8.4g Hz ',maxHA,maxFA);
    disp(out1);
    disp(' ');
    out1=sprintf('  max Power Trans  = %8.4g (G^2/G^2) at %8.4g Hz ',maxHA^2,maxFA);
    disp(out1); 
%%
%
    disp(' ');
    disp(' Perform modal transient analysis for base excitation? ');
    disp('  1=yes 2=no ');
%
    imta=input(' ');
%
    if(imta==1)
         n2=nmodes*nmodes;
%
            fn=zeros(n2,1);
       m_index=zeros(n2,1);
       n_index=zeros(n2,1);
            PF=zeros(n2,1);
%
       ijk=1;
       for i=1:nmodes
            for j=1:nmodes
                fn(ijk)=omegamn(i,j)/tpi;
                PF(ijk)=part(i,j);
                m_index(ijk)=i;
                n_index(ijk)=j;
                ijk=ijk+1;
            end
       end     
       NT=nmodes^2;        
%
        disp(' ');
        disp(' Apply half-sine base input?  1=yes  2=no ');
        isb=input(' ');
        if(isb==1)              
%
            [fig_num,acc_hs,rd_hs]=plate_base_half_sine(fn,damp,PF,NT,...
                                  Amn,pax,pby,x,y,m_index,n_index,fig_num,iu);
%
        end
%
        disp(' ');
        disp(' Apply arbitrary base input?  1=yes  2=no ');
        iarb=input(' ');
        if(iarb==1)              
%
            [fig_num,acc_arb,vel_arb,rd_arb]=....
            plate_base_arbitrary(h,a,b,mu,E,fn,damp,PF,NT,Amn,pax,pby,x,y,m_index,...
                                                          n_index,fig_num,iu);
%
        end
%
    end
%
    disp(' ');
    disp(' Output arrays: ');
    disp(' ');
    disp('    rel_disp_H ');
    disp('    rel_vel_H ');    
    disp('    accel_H    ');  
    disp('    accel_H2   ');
% 
    if(imta==1 && isb==1)
        disp(' ');
        disp('    acc_hs    ');  
        disp('    rd_hs     ');        
    end    
%
    if(imta==1 && iarb==1)
        disp(' ');
        disp('    acc_arb    ');  
        disp('    rv_arb    ');
        disp('    rd_arb     ');        
    end  
%
end  
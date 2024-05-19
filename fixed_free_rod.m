disp(' ');
disp(' fixed_free_rod.m  ver 1.2  March 1, 2012');
disp(' by Tom Irvine  Email: tomirvine@aol.com ');
disp(' ');
disp(' Normal Modes & Optional Base Excitation ');
disp(' ');
%
close all hidden;
%
clear fn;
clear omega;
clear PF;
clear U;
clear Ud;
clear x;
clear H;
clear HA;
clear YY;
clear part;
clear f;
clear damp;
clear emm;
%
fig_num=1;
iu=1;
%
disp(' Enter number of modes ');
n = input(' ');
%
disp(' ');
icross=input(' Enter the cross-section: \n 1=rectangle  2=solid cylinder  3=other ');
disp(' ');
if(icross==1)
			width=input(' Enter the width (inch) ');
			thick=input(' Enter the thickness (inch) ');
			A=width*thick;
end
if(icross==2)
			diam=input(' Enter the diameter (inch) ');
			A=(pi/4.)*(diam^2.);
end
if(icross ~=1 & icross ~=2);
            %
            disp(' ');
            A = input(' Enter the cross-section area (in^2) ');
end
%
[E,rho,v]=materials(iu);
%
c=sqrt(E/rho);
rho=rho*A;   % mass per unit length
%
disp(' ');
L = input(' Enter the length (inch) ');
mass=rho*L;
%
disp(' ')
out1=sprintf(' mass = %8.4g lbm',mass*386);
disp(out1);
%
sq_mass=sqrt(mass);
%
out1=sprintf('\n c = %8.4g in/sec \n',c);
disp(out1);
%
d=sqrt(2/mass);
%
for(i=1:n)
    omegan(i)=((2*i-1)/2)*pi*c/L;
    fn(i)=omegan(i)/(2*pi);
    PF(i)=rho*d*c/omegan(i);
%
    emm(i)=PF(i)^2;
%
end
emm=emm*386;
%
disp(' mode     fn(Hz)      PF     EM Mass(lbm)');
%
for(i=1:n)
    out1=sprintf('   %d  \t %8.4g \t %8.4g \t %8.4g ',i,fn(i),PF(i),emm(i));
    disp(out1);
end
%
disp(' ');
out1=sprintf(' Total Effecitve Modal Mass = %8.4g lbm',sum(emm));
disp(out1);
%
dx=L/200;
for(j=1:n)
    for(i=1:201)
        x(i)=(i-1)*dx;
        U(j,i)=d*sin(omegan(j)*x(i)/c);
        Ud(j,i)=d*(omegan(j)/c)*cos(omegan(j)*x(i)/c);
    end
end
%
for(i=1:n)
    figure(fig_num);
    fig_num=fig_num+1;
    plot(x,U(i,:));
    grid on;
    out1=sprintf('Mode %d  fn=%8.4g Hz',i,fn(i));
    title(out1);
    xlabel('x (inch)');
end
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%
disp(' ');
disp(' Calculated Frequency Response Function? ');
disp(' 1=yes  2=no ');
ifrf=input(' ');
%
if(ifrf==1)
%
disp(' ');
for(i=1:n)
        out1=sprintf(' Enter damping ratio for mode: %d',i);
        disp(out1);
        damp(i)=input(' ');
end
%
clear x;
disp(' ');
disp(' Enter distance x ');
x=input(' ');
if(x>L)
        disp(' Warning: x reset to total length');
        x=L;
end
%
part=PF;
%
   for(i=1:n)
        arg=omegan(i)*x/c;
        YY(i)=d*sin(omegan(i)*x/c);
   end
%
 clear f;
   nf=20000;
   j=sqrt(-1);
   f(1)=1;
   for(k=2:nf)
        f(k)=f(k-1)*2^(1/48);
        if(f(k)>20000)
            break;
        end    
   end
   nf=max(size(f));
%       
   for(k=1:nf)
        H(k)=0;
        HA(k)=0;
        om=2*pi*f(k);
        for(i=1:n)
            pY=part(i)*YY(i);
            omn=2*pi*fn(i);
            num=-pY;
            den=(omn^2-om^2)+j*2*damp(i)*om*omn;
            H(k)=H(k)+num/den;
 %
            num=om^2*pY;
            HA(k)=HA(k)+(num/den);
 %
        end
   end
    H=abs(H);
    HA=abs(HA)+1;   
%
    maxH=0.;
    maxHA=0.;
%
    for(k=1:nf)
        if(H(k)>maxH)
            maxH=H(k);
            maxF=f(k);
        end
        if(HA(k)>maxHA)
            maxHA=HA(k);
            maxFA=f(k);
        end
    end       
%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(f,H);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
    out1=sprintf('Frequency Response Function  x=%7.4g inch',x);
    title(out1);
    ylabel('Rel Disp / Base Accel ');
    xlabel('Frequency (Hz)');
    grid on;
    disp(' ');
    out1=sprintf('  max Rel Disp FRF = %8.3e at %8.4g Hz ',maxH,maxF);
    disp(out1);
%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(f,HA);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
    out1=sprintf('Frequency Response Function  x=%7.4g inch',x);
    title(out1);
    ylabel('Response Accel / Base Accel ');
    xlabel('Frequency (Hz)');
    grid on;
    disp(' ');
    out1=sprintf('  max Accel FRF = %8.4g at %8.4g Hz ',maxHA,maxFA);
    disp(out1);
 %
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   disp(' ');
    disp(' Calculate specific case for sine excitation? ');
    disp(' 1=yes  2=no ');
%
    clear YYd;
    ib=input(' ');
%    
    if(ib==1)
%
        for(i=1:n)
            arg=0;
            YYd(i)=(d*omegan(i)/c)*cos(arg);
        end
%
        disp(' ');
        disp(' Excite at fundamential frequency? ');
        disp(' 1=yes  2=no ');
        iff=input(' ');
        f(1)=fn(1);
%
        if(iff==2)
            disp(' ');
            disp(' Enter base excitation frequency (Hz) ');
            f(1)=input(' ');
        end
        disp(' ');
        disp(' Enter amplitude (G) ');
        amp=input(' ');      
        nf=1;
        for(k=1:nf)
            sH=0;
            sHA=0;
            strain=0;
            om=2*pi*f(k);
            for(i=1:n)
                pY=part(i)*YY(i);
                omn=2*pi*fn(i);
                num=-pY;
                den=(omn^2-om^2)+j*2*damp(i)*om*omn;
                sH=sH+num/den;
 %
                num=om^2*pY;
                sHA=sHA+(num/den);
 %
                num=-part(i)*YYd(i);
                strain=strain+(num/den);
 %
            end
        end
        sH=abs(sH);
        sHA=abs(sHA+1); 
        strain=abs(strain)*386*amp;
 %
        disp(' '); 
        out1 =sprintf(' Base excitation = %8.4g G at %8.4g Hz',amp,f(1));
        out2 =sprintf('\n Response at x=%8.4g inch ',x);
        out3 = sprintf('\n   Accel = %8.4g G',sHA*amp);
        out4 = sprintf('   Rel Disp = %8.4g in \n',sH*amp*386);
        out5 = sprintf('   Stress at fixed end = %8.4g lbf/in^2',strain*E);
%        
        disp(out1);  
        disp(out2);      
        disp(out3);
        disp(out4);
        disp(out5);
 %
    end

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %
end 
%
%  transfer_beam_stress_fea.m  ver 2.0  by Tom Irvine
%
function[H_stress]=...
    transfer_beam_stress_fea(freq,fnv,dampv,QE,omn2,nf,num_columns,i,k,nrb,ii,xx,E,cna,L)
%
H_stress=0;
nL=length(xx);
nLq=round(nL/4);
nLh=round(nL/2);
nLt=round(3*nL/4);
%

if(length(xx)<8)
   warndlg('Need at least eight elements for stress calculation'); 
   return; 
end

if(ii==1)
    xs=0;
    i1=i;
    i2=i+2;
    i3=i+4;
    i4=i+6;
    i5=i+8;
    xq=[xx(1) xx(2)  xx(3)  xx(4) xx(5)];
end
%
if(ii>=2 && ii<=4)
    i1=i-4;
    i2=i-2;
    i3=i;
    i4=i+2;
    i5=i+4;
end
%
if(ii==5)
    xs=L;
    i1=i-8;
    i2=i-6;
    i3=i-4;
    i4=i-2;
    i5=i;
    xq=[xx(nL-4) xx(nL-3)  xx(nL-2)  xx(nL-1) xx(nL)];
end
%
if(ii==2)
    xs=L/4;
    xq=[xx(nLq-2) xx(nLq-1)  xx(nLq)  xx(nLq+1) xx(nLq+2)];    
end
if(ii==3)
    xs=L/2;
    xq=[xx(nLh-2) xx(nLh-1)  xx(nLh)  xx(nLh+1) xx(nLh+2)];
end
if(ii==4)
    xs=3*L/4;
    xq=[xx(nLt-2) xx(nLt-1)  xx(nLt)  xx(nLt+1) xx(nLt+2)];        
end
%

ddy=zeros(num_columns,1);


for r=(1+nrb):num_columns  % natural frequency loop
 
    yq=[QE(i1,r) QE(i2,r) QE(i3,r) QE(i4,r) QE(i5,r)];
    
    [P,S,MU] = polyfit(xq,yq,4);
    
    xh=(xs-MU(1))/MU(2);
    
    ddy(r)= (4*3*P(1)*xh^2 + 3*2*P(2)*xh + 2*P(3))/(MU(2))^2;
    
end  



%
%
  H_stress=zeros(nf,1); 
%  
    if(nf>4)
       progressbar;
    end
%
    for s=1:nf   % excitation frequency loop
%
        if(nf>4)
            progressbar(s/nf);
        end    
%
        for r=(1+nrb):num_columns  % natural frequency loop
            if(fnv(r)<1.0e+30)
%
                rho=freq(s)/fnv(r);
                den=1-rho^2+(1i)*2*dampv(r)*rho;
%
                if(abs(den)<1.0e-20)
                    disp(' den error ');
                    return;
                end
                if(abs(omn2(r))<1.0e-20)
                    disp(' omn2 error ');
                    return;
                end                
%
                term=-(ddy(r)*QE(k,r)/den)/omn2(r); 
                H_stress(s)=H_stress(s)+term;                  
%
            end
        end   
%
    end
    progressbar(1);
%
H_stress=H_stress*E*cna;
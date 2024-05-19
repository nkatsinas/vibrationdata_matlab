%
%  transfer_beam_stress_fea_alt.m  ver 2.0  by Tom Irvine
%
function[H_stress]=...
    transfer_beam_stress_fea_alt(freq,fnv,dampv,QE,omn2,nf,num_columns,i,k,nrb,xx,E,cna,L)
%
H_stress=0;
nL=length(xx);
%
ii=i;

if(length(xx)<8)
   warndlg('Need at least eight elements for stress calculation'); 
   return; 
end

if(i==1)
    xs=0;
    i1=1;
    i2=2;
    i3=3;
    i4=4;
    i5=5;
end
xq=[xx(i1) xx(i2)  xx(i3)  xx(i4) xx(i5)];


ddy=zeros(num_columns,1);


for r=(1+nrb):num_columns  % natural frequency loop
 
    yq=[QE(i1,r) QE(i2,r) QE(i3,r) QE(i4,r) QE(i5,r)];
    
    [P,~,MU] = polyfit(xq,yq,4);
    
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
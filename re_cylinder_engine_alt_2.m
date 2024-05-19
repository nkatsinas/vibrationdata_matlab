%
%  re_cylinder_engine_alt_2.m  ver 1.2  by Tom Irvine
%
%   NASA CR-111840   
%
function[rad_eff,mph]=...
        re_cylinder_engine_alt_2(mu,diam,L,h,mmax,nmax,air_c,CL,fcr,fring,fl,fu)
             
vg=fcr/fring;

a=diam/2; % radius

disp(' ');
disp(' Calculating Modal Frequencies... ');
%

ff=zeros(mmax,nmax);
afast=zeros(nmax,nmax);
%

progressbar;

jjj=1;

for m=1:mmax  % axial

    progressbar(m/mmax);
%  
    ky=(m-1)*pi/L;

    for n=1:nmax  % circumferential
%
        kx=(n-1)/a;
        akx=(n-1);

        if(kx>0 || ky>0)

            term=(kx^2+ky^2)^2;
            A=((h*a)^2/12)*term;
            B=(1-mu^2)*ky^4/term;
            v=sqrt(A+B);
            ff(m,n)=v*fring;

            fff(jjj)=ff(m,n);
            jjj=jjj+1;

            if( (akx*air_c/CL)<v && v<vg )

                term=sqrt(1-mu^2)-v*sqrt((1-(v/vg)^2));
                term=sqrt(term);

                if(akx>=(CL/air_c)*real(term))
                    afast(m,n)=1;
                end
            end    
        end
    end
end
progressbar(1);

NL=length(fu);

rad_eff=zeros(NL,1);
nun=zeros(NL,1);
num_fast=zeros(NL,1);
num_slow=zeros(NL,1);
mph=zeros(NL,1);

for m=1:mmax
    
    for n=1:nmax

        for k=1:NL

            if(ff(m,n)>=fl(k) && ff(m,n)<fu(k) )   

                nun(k)=nun(k)+1;

                if(afast(m,n)==1)
                    num_fast(k)=num_fast(k)+1;
                else   
                    num_slow(k)=num_slow(k)+1;
                end
            end        
        end
    end
end    

for j=1:NL
    rad_eff(j)=0.001;

    if(num_fast(j)>=1 && nun(j)>=1)
        rad_eff(j)=num_fast(j)/nun(j);
    end

    bw=fu(j)-fl(j);
    mph(j)=nun(j)/bw;

    % fprintf(' %8.4g %8.4g %8.4g %8.4g %8.4g %8.4g\n',sqrt(fl(j)*fu(j)),bw,mph(j),rad_eff(j),num_fast(j),nun(j));
end    

disp('fff')
fff=fix_size(fff);
fff=sort(fff);
for i=1:200
    fprintf(' %8.4g \n',fff(i));
end

%
%  env_fds_batch_spl_alt.m  ver 1.4  by Tom Irvine
%
function[fds_ref,kflag]=env_fds_batch_spl_alt(interp_psdin,nnn,fn,dam,bex,T,iu,nmetric,kflag)

%
tpi=2*pi;
%
n=length(dam);


if(isnan(interp_psdin(1)))

                kflag
    
                disp(' inerp_psdin(1) error in env_fds_batch.m');
                disp(' '); 
                
                interp_psdin

                kflag=0;
                return;
end


%
fds_ref=zeros(nnn,n);
%
for ijk=1:n
%
%%        out1=sprintf(' ijk=%d dam=%g  ',ijk,dam(ijk));
%%       disp(out1);
%
        for i=1:nnn
            
%
            apsd=zeros(nnn,1);
%
            for j=1:nnn
%		
              % fn(i) is the natural frequency
			  % fn(j) is the forcing frequency
%
	          rho=fn(j)/fn(i);
%			  
			  tdr=2.*dam(ijk)*rho;
%
			  tden=((1.-(rho^2))^2)+(tdr^2);             
              
              
              if(nmetric==1)
                tnum=1.+(tdr^2);
                trans=tnum/tden;
                
              end
              if(nmetric>=2)
                  
                c1= ((fn(i)^2)-(fn(j)^2) )^2.;
                c2= ( 2*dam(ijk)*fn(i)*fn(j))^2.;
%
                trans= (1. / ( c2 + c1 ))/tpi^4;  % rd
                
              end  
              if(nmetric==2)
                  
                   trans=trans*(tpi*fn(j))^2;   % convert from rd to rv
                   
                   if(iu==1)
                       trans=trans*386^2;
                   end
%   
             
              end    
              if(nmetric==3)
                  
                    if(iu==1)
                       trans=trans*386^2;
                   end                 
              end    
%			  
%
              apsd(j)=trans*interp_psdin(j);
%	  
            end  % forcing freq 

            
%
            [m0,grms]=cm0(apsd,fn,nnn);
                 [m1]=cm1(apsd,fn,nnn);
                 [m2]=cm2(apsd,fn,nnn);
                 [m4]=cm4(apsd,fn,nnn);
                 
                 
            if(grms>=1.0e-20 && grms<=1.0e+30)
            else
                kflag=0;
                return;
            end    
                   
%
            [D1,D2,D3,R,Q,EP]=Dirlik_coefficients(m0,m1,m2,m4);                 
%

            maxS=8*grms;           
%
            ds=maxS/400;
%
            n=round(maxS/ds);
            
            if(n>=1 && n<=1.0e+05)
            else
                kflag=2;
                return;
            end
%
            [~,cumu,S]=Dirlik_pdf(m0,D1,D2,D3,Q,R,ds,EP,T,n);
%

            dcumu=diff(cumu);
            dcumu(n)=0;

            amp=S/2;
               
%               d=trapz(amp.^bex(nv));
  
                d=trapz(dcumu.*(amp.^bex(ijk)));
 
                fds_ref(i,ijk)=d;
%
%
        end % fn
%  
end  % dam
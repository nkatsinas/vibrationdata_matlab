%
%  env_fds_batch_alt2.m  ver 1.4  by Tom Irvine
%
function[fds_ref]=env_fds_batch_alt2(interp_psdin,nnn,fn,dam,bex,T,iu,nmetric)

%
tpi=2*pi;
%
n_dam=length(dam);
n_bex=length(bex);
%

if(isnan(interp_psdin(1)))
    
                disp(' inerp_psdin(1) error in env_fds_batch.m');
                disp(' '); 
                
                interp_psdin(1)

                disp(' ');
                disp('  Type  Ctrl-C ');
                aaa=input(' ');
                return;
end


%
fds_ref=zeros(n_dam,n_bex,nnn);
%
for ijk=1:n_dam
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
                 
                 
            if(grms>=1.0e-12 && grms<=1.0e+20)
            else
                disp(' grms error in env_fds_batch.m');
                disp(' '); 
                
                for iv=1:length(fn)
                    out1=sprintf(' %8.4g  %8.4g  %8.4g ',fn(iv),apsd(iv),interp_psdin(iv));
                    disp(out1);                    
                end

                disp(' ');
                disp('  Type  Ctrl-C ');
                aaa=input(' ');
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
                disp(' n error in env_fds_batch.m');
                disp(' ');
                out1=sprintf('\n n=%d  grms=%7.3g  max=%7.3g  ds=%7.3g',n,grms,maxS,ds);
                disp(out1);
                out1=sprintf('max(interp_psdin)=%8.4g  min(interp_psdin)=%8.4g',max(interp_psdin),min(interp_psdin));
                disp(out1);                      
                out1=sprintf('max(apsd)=%8.4g  min(apsd)=%8.4g',max(apsd),min(apsd));
                disp(out1);                   
                out1=sprintf('fn=%8.4g  nnn=%g',fn(j),nnn);
                disp(out1);                
                out1=sprintf('maxS=%8.4g  grms=%8.4g',maxS,grms);
                disp(out1);
                disp(' ');
                disp('  Type  Ctrl-C ');
                aaa=input(' ');
                return;
            end
%
            [~,cumu,S]=Dirlik_pdf(m0,D1,D2,D3,Q,R,ds,EP,T,n);

%

            dcumu=diff(cumu);
            dcumu(n)=0;

            amp=S/2;

            for nv=1:n_bex
                
%               d=trapz(amp.^bex(nv));
  
                d=trapz(dcumu.*(amp.^bex(nv)));
 
                fds_ref(ijk,nv,i)=d;
%
            end
            
%
        end % fn
%  
end  % dam
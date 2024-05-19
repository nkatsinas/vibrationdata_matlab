%
%  env_make_input_fds.m  ver 1.0  November 25, 2013
%
function[fds_ref]=env_make_input_vrs(interp_psdin,n_ref,f_ref,dam,bex,T)
%
n_dam=length(dam);
n_bex=length(bex);
%
%
fds_ref=zeros(n_dam,n_bex,n_ref);
%
for ijk=1:n_dam
%        
        m0=0;
        m1=0;
        m2=0;
        m4=0;
%        
        for i=1:n_ref
%	
            sum=0.;
%
            for j=1:n_ref
%		
              % f_ref(i) is the natural frequency
			  % f_ref(j) is the forcing frequency
%
	          rho=f_ref(j)/f_ref(i);
%			  
			  tdr=2.*dam(ijk)*rho;
%
			  tden=((1.-(rho^2))^2)+(tdr^2);
			  tnum=1.+(tdr^2);
%
			  trans=tnum/tden;
%
              dfi=f_ref(j)*octave;
%
              apsd=trans*interp_psdin(j);
%
              m0=m0+apsd*dfi;
              m1=m1+apsd*f_ref(j)*dfi;
              m2=m2+apsd*f_ref(j)^2*dfi;
              m4=m4+apsd*f_ref(j)^4*dfi;
%              
			  sum=sum+apsd*dfi;
%	  
            end  % forcing freq
%
            grms=sqrt(sum);
%
            [D1,D2,D3,R,Q,EP]=Dirlik_coefficients(m0,m1,m2,m4);                  
%
            maxS=8*grms;
%
            ds=maxS/400;
%
            n=round(maxS/ds);
%
            N=zeros(n,1);
            S=zeros(n,1);
%
            for j=1:n
                S(j)=(j-1)*ds;
                Z=S(j)/(2*sqrt(m0));
%    
                t1=(D1/Q)*exp(-Z/Q);
                a=-Z^2;
                b=2*R^2;
%    
                t2=(D2*Z/R^2)*exp(a/b);
                t3=D3*Z*exp(-Z^2/2);
%    
                pn=t1+t2+t3;
                pd=2*sqrt(m0);
                p=pn/pd;
%    
                N(j)=p;
            end
            N=N*EP*T;
%
            area=0;
            cumu=zeros(n,1);
            for j=1:n
                area=area+N(j)*ds;
                cumu(j)=area;
            end
%
            num=ceil(cumu(n));
%
            xq=zeros(num,1);
            for j=1:num
                xq(j)=i;    
            end
%
            vq1 = interp1(cumu,S,xq);
%
            clear A;
            clear range;
            clear amp;
%
            A=[xq vq1];
            A(any(isnan(A),2),:)=[];
            range=A(:,2);
            range=sort(range,'descend');
            amp=range/2;
%
            for nv=1:n_bex
                d=0;
                for j=1:length(amp)
                    d=d+amp(j)^bex(nv);
                end
                fds_ref(ijk,nv,i)=d;
            end
%
        end % fn
%  
end  % dam
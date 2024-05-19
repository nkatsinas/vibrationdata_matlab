
%  hs_syn_wavelet_reconstruction.m  ver 1.0  by Tom Irvine

function[aaa,vvv,ddd,amp]=hs_syn_wavelet_reconstruction(num2,t,x1r,x2r,x3r,x4r,tp,nfr,amp,ffmin)
    
    aaa=zeros(num2,1); 
    vvv=zeros(num2,1); 
    ddd=zeros(num2,1); 

%
		tf=0.;
%
		vlast=zeros(num2,1);
%
		for k=1:num2
%
				tt=t(k);
%              
				for(j=1:nfr)
%				
                    w=0.;
					v=0.;
					d=0.;
%
					v1=0.;
					v2=0.;
%
					d1=0.;
					d2=0.;
%
					t1=x4r(j)+t(1);
%
                    if(x2r(j)>=1.0e-10)
%
                    else
                        x2r(j)=ffmin*tp;
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
						alpha1=aa+bb;
					    alpha2=aa-bb;
%
						te=tt-t1;
%
						v1= -sin(alpha1*tf)/(2.*alpha1) + sin(alpha2*tf)/(2.*alpha2);
				        v2= -sin(alpha1*te)/(2.*alpha1) + sin(alpha2*te)/(2.*alpha2);
%
                        d1=  cos(alpha1*tf)/(2.*(alpha1^2)) - cos(alpha2*tf)/(2.*(alpha2^2));
                        d2=  cos(alpha1*te)/(2.*(alpha1^2)) - cos(alpha2*te)/(2.*(alpha2^2));
%
						v=(v2-v1)*x1r(j);
						d=(d2-d1)*x1r(j);
%
						vlast(j)=v;
%
                    end
%
					aaa(k)=aaa(k)+w; 
					vvv(k)=vvv(k)+v;
					ddd(k)=ddd(k)+d;
%
					amp(k)=amp(k)-w;
%
					if(x3r(j)<1)
                        disp(' error x3r ');
                        break;
                    end
%
                end
%
%%               out1=sprintf(' %d t=%8.4g  %8.4g  %8.4g  %8.4g ',k,t(k),aaa(k),vvv(k),ddd(k));
%%               disp(out1);
        end
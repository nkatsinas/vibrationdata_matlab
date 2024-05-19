%
 clear THM; 
 clear aaa;
 clear aaa_r;
 clear amp;
 clear amp_original;
 clear ddd;
 clear ddd_r;
 clear delay;
 clear disp;
 clear duration;
 clear error;
 clear f;
 clear fl;
 clear fmax;
 clear freq;
 clear fu;
 clear iunit;
 clear mm;
 clear nfr;
 clear nhs;
 clear nt;
 clear num2;
 clear out1;
 clear p;
 clear residual;
 clear rsum;
 clear sd;
 clear sr;
 clear t;
 clear tp;
 clear tpi; 
 clear velox;
 clear vlast;
 clear vvv;
 clear vvv_r;
 clear x1r;
 clear x2r;
 clear x3r;
 clear x4r;
 clear y;
 clear ffmax;
 clear ffmin;
%
disp(' ');
disp(' half_sine_synth.m   version 1.2   January 26, 2010');
disp(' By Tom Irvine   Email:  tomirvine@aol.com ');
%
disp(' ');
disp(' This program synthesizes a wavelet series to approximate ');
disp(' a half-sine pulse for shaker table testing. ');
%
MAX=50000;
MAXP=1000;
%
tp=2.*pi;
tpi=tp;
%
sume=1.0e+10;
drecord=1.0e+10;
error_all=1.0e+10;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
iunit=input(' Enter acceleration unit:   1= G   2= m/sec^2  ');	
%
if(iunit==1)
    iscale=386.;
else
    iscale=1.;
end
%
disp(' ');
disp(' Enter duration (sec) ');
hsd=input(' ');
%
disp(' ');
disp(' Enter amplitude (G) ');
amp=input(' ');
%
pamp=amp*0.2;
%
dt=hsd/20;
%
sr=1/dt;
%
srr(1)=5000000;
srr(2)=2000000;
srr(3)=1000000;
srr(4)= 500000;
srr(5)= 200000;
srr(6)= 100000;
srr(7)=  50000;
srr(8)=  20000;
srr(9)=  10000;
srr(10)=   5000;
srr(11)=   2000;
srr(12)=  1000;
srr(13)=   5000;
srr(14)=   2000;
srr(15)=   1000;
srr(16)=    500;
srr(17)=    200;
srr(18)=    100;
srr(19)=     50;
srr(20)=     20;
srr(21)=     10;
srr(22)=      5;
srr(23)=      2;
srr(24)=      1;
%
for(i=2:24)
   if(sr>srr(i-1))
       sr=srr(i);
       break;
   end
end
dt=1/sr;
%
pad=25*hsd
total_dur=hsd + 2*pad;
tmax=total_dur/2;
%
nys=round(total_dur/dt);
%
tt0=0;
tt1=pad+tt0;
tt2= hsd+tt1;
for(i=1:nys)
    t(i)=dt*(i-1);
    y(i)=0;
    if(t(i) >=tt1 && t(i)<=tt2 )
       y(i)=amp*sin(pi*( t(i)-tt1)/hsd);    
    end   
end
AL=0.20*amp;
t=t';
y=y';
amp=y;
amp_original=y;
%
% disp(' ')
% ffmin=input(' Enter minimum frequency (Hz) ');
% disp(' ')
% ffmax=input(' Enter maximum frequency (Hz) ');
%
ffmin=1./(total_dur/2);
ffmax=1/(hsd/20);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' Reference 1 ');
out1=sprintf('\n Enter the acceleration time history output filename: ');
disp(out1);
       output_filename1 = input(' ','s');
out1=sprintf('\n Enter the velocity time history output filename: ');
disp(out1);
       output_filename2 = input(' ','s');
%
out1=sprintf('\n Enter the displacement time history output filename: ');
disp(out1);
       output_filename3 = input(' ','s');
%
out1=sprintf('\n Enter the wavelet table output filename: ');
disp(out1);
       output_filename4 = input(' ','s');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
ik=0;
%      
x1r=zeros(MAXP,1);	
x2r=zeros(MAXP,1);	
x3r=zeros(MAXP,1);	
x4r=zeros(MAXP,1);	
%
disp(' ');		
nt=input(' Enter the number of trials per frequency (suggest 10000 or more). ');
disp(' ');		
nfr=input(' Enter the number of frequencies (suggest 5 or more). ');
disp(' ');
kjv_num=input(' Enter the number of cases to minimize displacement (suggest 25 or more)');
disp(' ');
%
if(nfr>MAXP)
    nfr=MAXP;
end
%		   
fmax=0.;
%
num2=max(size(y));
%
clear y;
%
%% out1=sprintf(' number of input points= %d ',num2)
%% disp(out1);
%		
duration=t(num2)-t(1);
%
sr=duration/(num2-1);
sr=1./sr;
%
out1=sprintf(' sample rate = %10.4g \n',sr);
disp(out1);
%
fl=3./duration;
fu=sr/5.;
%
clear y;
%
for(kjv=1:kjv_num)
%
residual=amp_original;
rsum=residual-residual;
%
for(ie=1:nfr)
%
%%    out1=sprintf(' frequency case %d ',ie);
%%    disp(out1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%    disp(' ref 1');
    [error_max,x1r,x2r,x3r,x4r]=wgen_hs(num2,t,residual,duration,sr,x1r,x2r,x3r,x4r,fl,fu,nt,ie,ffmin,ffmax,tt1,tt2,AL,rsum,amp_original);
%%    disp(' ref 2');
%            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    if(x2r(ie)<ffmin*tp)
        x2r(ie)=ffmin*tp;
        x1r(ie)=1.0e-20;
        x3r(ie)=3;
        x4r(ie)=0;
    end
%
	for(i=1:num2)
%			
	    tt=t(i);
%
		t1=x4r(ie) + t(1);
		t2=t1 + tp*x3r(ie)/(2.*x2r(ie));
%
		y=0.;
%
		if( tt>= t1 && tt <= t2)
%				
			arg=x2r(ie)*(tt-t1);  
			y=x1r(ie)*sin(arg/double(x3r(ie)))*sin(arg);
            rsum(i)=rsum(i)+y;
%
		    residual(i)=residual(i)-y;
        end
    end       
    ave=mean(residual); 
    sd=std(residual);
%
%%    out1=sprintf(' ave=%12.4g  sd=%12.4g \n\n',ave,sd);
%%    disp(out1);       
%			 
end    
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
%		disp(' ');
%
		kk=0;
%
		for(i=1:nfr)
%
            if(x2r(i)<ffmin*tp)
                x2r(i)=ffmin*tp;
                x1r(i)=1.0e-20;
                x3r(i)=3;
                x4r(i)=0;
            end
%
			out1=sprintf(' amp=%10.4f   freq=%10.3f Hz   nhs=%d   delay=%10.4f ',x1r(i),x2r(i)/tp,x3r(i),x4r(i));
            disp(out1);
%
            wavelet_table(i,1)=i;
            wavelet_table(i,2)=x2r(i)/tpi;           
            wavelet_table(i,3)=x1r(i);
            wavelet_table(i,4)=x3r(i); 
            wavelet_table(i,5)=x4r(i);              
%
        end
%
		tf=0.;
%
		vlast=zeros(num2,1);
%
		for(k=1:num2)
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
						v=(v2-v1)*iscale*x1r(j);
						d=(d2-d1)*iscale*x1r(j);
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
                        printf(' error x3r ');
                        break;
                    end
%
                end
%
%%               out1=sprintf(' %d t=%8.4g  %8.4g  %8.4g  %8.4g ',k,t(k),aaa(k),vvv(k),ddd(k));
%%               disp(out1);
        end
%
        dmax=max(abs(ddd));
        sumed=dmax*error_max;
        out1=sprintf(' %d  %g  %g %g \n',kjv,error_max,dmax,sumed);
        disp(out1);
        if( sumed<sume && error_max < 1.3*error_all && dmax < 1.3*drecord) 
            error_all=error_max;
            drecord=dmax;
            sume=sumed;
            out1=sprintf('** %g  %g \n',error_all,drecord);
            disp(out1);
            aaa_r=aaa;
            vvv_r=vvv;
            ddd_r=ddd;
        end
        disp(' ');
end
%%
        error=[t,amp];
        accel=[t,aaa_r];
        velox=[t,vvv_r];
        disp=[t,ddd_r];
        wavelet_table_r=wavelet_table;
%
%
save(output_filename1,'accel','-ASCII')
save(output_filename2,'velox','-ASCII')
save(output_filename3,'disp','-ASCII')
save(output_filename4,'wavelet_table_r','-ASCII')
%
        figure(1);
        plot(t,ddd_r);     
        title(' Displacement Time History ');
        xlabel(' Time(sec)');
        if(iunit==1)
            ylabel(' Displacment(inch)');
        else
            ylabel(' Displacement(m)');          
        end
        grid on;
 %
        figure(2);
        plot(t,vvv_r);     
        title(' Velocity Time History ');
        xlabel(' Time(sec)');
        if(iunit==1)
            ylabel(' Velocity(in/sec)');
        else
            ylabel(' Velocity(m/sec)');          
        end
        grid on;
%        
        figure(3);
        plot(t,amp_original,t,aaa_r);
        legend ('specification','synthesis');         
        title(' Acceleration Time History ');
        xlabel(' Time(sec)');
        if(iunit==1)
            ylabel(' Accel(G)');
        else
            ylabel(' Accel(m/sec^2)');          
        end
        grid on;
%
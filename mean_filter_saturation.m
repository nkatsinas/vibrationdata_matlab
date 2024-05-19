disp(' ');
disp('  mean_filter_saturation.m  version 2.2,  January 27, 2012 ');
disp('  By Tom Irvine   Email:  tomirvine@aol.com ');
disp(' ');
disp('  This program performs mean filtering on a time history ');
disp('  with a sliding window. Note that a mean filter is a type '); 
disp('  of a lowpass filter. ');
disp(' ');
disp('  The mean filtered signal is an estimate of the saturation effect. ');
disp('  The filtered signal is then subtracted from the raw data to obtain ');
disp('  a cleaned signal. ');
%
clear a;
clear b;
clear br;
clear a1;
clear a2;
clear b1;
clear b2;
clear b3;
clear fn;
clear t;
clear y;
clear max_ref;
clear xmax;
clear min_ref;
clear xmin;
clear ps;
clear pn;
clear slope_p;
clear slope_n;
clear mf;
clear mfr;
%
nkv=0;
tpi=2.*pi;
%
rand('state',0);
%
disp(' ');
[t,a,dt,sr,tmx,tmi,n,ncontinue]=enter_time_history();
%
figure(1);
plot(t,a)
grid on;
title(' Raw Data ');
xlabel(' Time(sec) ');
ylabel(' Accel(G)  ');
%
last=n;
%
%
disp(' ');
fn(1)=input(' Enter the starting frequency (Hz)  ');
if fn(1)>sr/30.
    fn(1)=sr/30.;
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    br=zeros(n,1);
%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
idamp=input(' Enter damping format:  1= damping ratio   2= Q  ');	
%
disp(' ')
if(idamp==1)
    damp=input(' Enter damping ratio (typically 0.05) ');
    Q=1./(2.*damp);
else
    Q=input(' Enter the amplification factor (typically Q=10) ');
    damp=1./(2.*Q);
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
fmax=sr/9.;
%
if(fmax>12000)
    fmax=12000.;
end    
%
j=2;
while(1)
%
    fn(j)=fn(1)*(2.^(j*(1./6.)));
%
    if( fn(j)>fmax)
        break;
    end    
%
    nspec=j;
	j=j+1;
end
%
tpi=2*pi;
%
for(j=1:nspec)
%    
    omega=tpi*fn(j);
    omegad=omega*sqrt(1.-(damp^2));
    cosd=cos(omegad*dt);
    sind=sin(omegad*dt);
    domegadt=damp*omega*dt;
%
	a1(j)=2.*exp(-domegadt)*cosd;
    a2(j)=-exp(-2.*domegadt);
    b1(j)=2.*domegadt;
	b2(j)=omega*dt*exp(-domegadt);
	b2(j)=b2(j)*( (omega/omegad)*(1.-2.*(damp^2))*sind -2.*damp*cosd );
	b3(j)=0.;
%            
end
%
disp(' ');
disp(' Enter the desired initial slope (dB/octave). Typical value=6 dB/oct ');
slope_goal=input(' ');
%
b=a;
good_freq=1.0e+20;
max_ref=zeros(nspec,1);
min_ref=zeros(nspec,1);
[xmax,xmin,dmax,slope_p,slope_n,ref_error,ppp,nnn,nnnoct]=mr_SRS(dt,nspec,last,b,a1,a2,b1,b2,b3,fn,good_freq,max_ref,min_ref,slope_goal);
%
figure(2);
sz=max(size(xmax));
fff=fn(1:sz);
plot(fff,xmax,fff,abs(xmin),'-.');
legend ('positive','negative');
if(Q==10)
   out1=sprintf(' SRS Q=10    Raw signal ',Q);  
else
   out1=sprintf(' SRS Q=%5.3g    Raw signal ',Q);
end   
title(out1);
xlabel(' Natural Frequency (Hz) ');
ylabel(' Accel(G)  ');
grid;
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');
%
%
disp('  Enter the frequency (Hz) above which the data is assumed to be good. ');
for(j=nspec:-1:2)	
%
%        printf(" f=%8.4g Hz  xmax=%8.4g  xmin=%8.4g \n",f(j),xmax(j),xmin(j)); 
%
		if( xmax(j)>0 && abs(xmin(j))>0)
%		
			aaa=abs(20.*log10(  xmax(j)/abs(xmin(j)  ) ) );
			bbb=abs(20.*log10(xmax(j-1)/abs(xmin(j-1)) ) );
%
%			printf("      aaa=%8.4g  bbb=%8.4g \n",aaa,bbb); 
%
			if(aaa>=4. && bbb>=4.)
%
				out1=sprintf('  ( Suggest: %8.4g Hz ) ',fn(j-1));
                disp(out1);
%
				break;
            end
        end
end
%
good_freq=input(' ');
%
disp('  Enter the maximum number of passes. ( suggest >= 1 ). ');
max_passes=input(' ');
%
disp('  Enter the maximum window size. ( suggest >= 20 ). ');
max_window=input(' ');
%
if(max_passes>10000)
		max_passes=9999;
end
if(max_window>10000)
		max_window=9999;
end
%
disp('  Enter the number of trials ');
nt=input(' ');
%
if(nt>10000)
        nt=10000;
end 
if(nt>(max_passes*max_window))
        nt=(max_passes*max_window);                          
end
%
b=a;
%
[xmax,xmin,dmax,slope_p,slope_n,ref_error,ppp,nnn,nnnoct]=mr_SRS(dt,nspec,last,b,a1,a2,b1,b2,b3,fn,good_freq,max_ref,min_ref,slope_goal);
%
max_ref=xmax;
min_ref=xmin;
%
record=1.0e+90;
%
disp(' ');
%
nmp = 1;
%
for(iq=1:nt)
%
	if(nmp==100)
%
	   out1=sprintf(' %d  ',iq);
       disp(out1);
%
	   nmp=1;
%
    else
	   nmp=nmp+1;
    end
%			 
    window_size=1+2*fix(max_window*rand/2.);
    if(window_size<3)
        window_size=3;
    end
    number_passes=1+round(max_passes*rand);
%      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% void average()
%
    w=window_size;
	k=fix(double(w-1)/2.);
	np=number_passes;
	npr_hold=np; % number of passes
	kr_hold=k;   % window size
%
    mf=zeros(last,1);
	for(m=1:np)	
		for(i=1:last)
%
			ave=0.;
			n=0;
%
			for(j=(i-k):(i+k))
				if(j>=1 && j<=last )
					ave=ave+a(j);
					n=n+1;
                end		
            end
			if(n>1)			
				mf(i)=ave/double(n);
            end
        end
    end
%
    b=a-mf;
    ams=std(a);
    bms=std(b);
%
	arms=sqrt(ams/double(last));
	brms=sqrt(bms/double(last));
%
	if(arms<1.0e-20 || brms<1.0e-20 )
%
		disp('  Error 2 ');
		out1=sprintf('  arms=%8.4g  brms=%8.4g \n\n',arms,brms);
        disp(out1);
%
    end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
	[xmax,xmin,dmax,slope_p,slope_n,ref_error,ppp,nnn,nnnoct]=mr_SRS(dt,nspec,last,b,a1,a2,b1,b2,b3,fn,good_freq,max_ref,min_ref,slope_goal);
%
	dbc=dmax;   % want to minimize
%
	slope_pc=slope_p;
	slope_nc=slope_n;
%
	total_db = ref_error + dbc + ( slope_pc + slope_nc );
%
	if( total_db<record )
%
		record=total_db;
%
        mfr=mf;
        br=b;
%
		ps=xmax;
		pn=abs(xmin);
%
		npr=number_passes;
		kr=window_size;
%
		slope_pos=20.*log10(ppp)/nnnoct;
		slope_neg=20.*log10(nnn)/nnnoct;
%
 		out1=sprintf(' %ld  err=%8.4g dB  np=%ld  ws=%ld  +slope=%6.3g dB  -slope=%6.3g dB ',iq,record,number_passes,window_size,slope_pos,slope_neg);
        disp(out1);
    end
%            
end  %% iq loop
%
b=br;
[xmax,xmin,dmax,slope_p,slope_n,ref_error,ppp,nnn,nnnoct]=mr_SRS(dt,nspec,last,b,a1,a2,b1,b2,b3,fn,good_freq,max_ref,min_ref,slope_goal);
%
	out1=sprintf(' \n Best case: \n\n  Window size=%ld  Passes=%ld \n',kr,npr);   
    disp(out1);
%    
clear n;
clear v;
%
n=last;
v(1)=b(1)*dt/2;
for(i=2:(n-1))
    v(i)=v(i-1)+b(i)*dt;
end
v(n)=v(n-1)+b(n)*dt/2;
v=v*386;
%
sz=size(b);
if(sz(2)>sz(1))
    b=b';
end
sz=size(mfr);
if(sz(2)>sz(1))
    mfr=mfr';
end
%
saturation=[t mfr];
cleaned=[t b];
%
figure(3);
plot(t,mfr)
grid on;
title(' Saturation Estimate ');
xlabel(' Time(sec) ');
ylabel(' Accel(G)  ');
%
figure(4);
plot(t,b)
grid on;
title(' Acceleration Cleaned Signal ');
xlabel(' Time(sec) ');
ylabel(' Accel(G)  ');
%
figure(5);
plot(t,v)
grid on;
title(' Velocity Cleaned Signal ');
xlabel(' Time(sec) ');
ylabel(' Velocity(in/sec)  ');
%
figure(6);
sz=max(size(xmax));
fff=fn(1:sz);
plot(fff,xmax,fff,abs(xmin),'-.');
legend ('positive','negative');
if(Q==10)
   out1=sprintf(' SRS Q=10    Cleaned signal ',Q);  
else
   out1=sprintf(' SRS Q=%5.3g    Cleaned signal ',Q);
end   
title(out1);
xlabel(' Natural Frequency (Hz) ');
ylabel(' Accel(G)  ');
grid;
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');
%
disp(' ');
disp(' Output Files:  ');
disp('    saturation ');
disp('    cleaned    ');
%
clear THF;
clear THS;
%
clear a1;
clear a2;
clear accel;
clear acceleration;
clear alpha;
clear amp;
clear b1;
clear b2;
clear beta;
clear damp_ratio;
clear disp;
clear displacement;
clear f;
clear fn;
clear omega;
clear ramp;
clear rrr;
clear rrrold;
clear sa;
clear sb;
clear sc;
clear shock_response;
clear srs_spec;
clear sz;
clear t;
clear td;
clear upper;
clear velocity;
clear velox;
clear wavelet_low;
clear wavelet_up;
clear x;
clear xabs;
clear xmax;
clear xmin;
clear yb;
%
mflag=0;
%
disp(' ');
disp(' wavelet_scale_SRS.m, ver 1.6, June 29, 2009 ');
disp(' by Tom Irvine, Email: tomirvine@aol.com ');
disp(' ');
disp(' This programs scales the individual wavelets of a wavelet series  ');
disp(' so that the resulting time history satisfies an SRS specification. ');
%
NUM_W = 1000;
NUM_SRS = 1000;
isu = 1.;
emax1=1.0e+20;
emax2=1.0e+20;
tpi=2.*pi;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Enter data
%
    disp(' ');
	disp(' Enter the sample rate (samples/sec)');
	ssr=input(' ');
%
	disp(' Enter the duration (sec) ');
    dur=input(' ');
%
    disp(' ');
	disp(' The SRS specification must have two columns: '); 
    disp(' fn(Hz) & peak accel(G) ' );
    disp(' It should already be interpolated into '); 
    disp(' 1/12, 1/6, or some other desired format ');
%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    disp(' ');
    disp(' Select data input method ')
    disp('  1=data preloaded in matlab ')  
    disp('  2=external ASCII file ');
    disp('  3=Excel file ');
%
    method=input('');                 
    disp(' ')
%
    if(method==1)
        THS = input(' Enter the input filename:  ');    
    end
%    
    if(method==2)
        [filename, pathname] = uigetfile('*.*');
        filename = fullfile(pathname, filename);
        fid = fopen(filename,'r');
        THS=load(filename);            
    end 
%
    if(method==3)
        [filename, pathname] = uigetfile('*.*');
        xfile = fullfile(pathname, filename);
        THS = xlsread(xfile);
    end   
%
       szTHS=size(THS)
          fn=THS(:,1);
    srs_spec=THS(:,2);
%
disp(' ');
THS
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    disp(' ');
	disp(' The wavelet table must have five columns:  ');
	disp(' 1.index  2.accel(G)  3.freq(Hz)  4.number of half-sines  5.delay(sec) ');
    disp(' ');   
%
    disp(' Select data input method ')
    disp('  1=data preloaded in matlab ')  
    disp('  2=external ASCII file ');
    disp('  3=Excel file ');
%
    method=input('');                 
    disp(' ')
%
    if(method==1)
        THF = input(' Enter the input filename:  ');    
    end
%    
    if(method==2)
        [filename, pathname] = uigetfile('*.*');
        filename = fullfile(pathname, filename);
        fid = fopen(filename,'r');
        THF=load(filename);            
    end 
%
    if(method==3)
        [filename, pathname] = uigetfile('*.*');
        xfile = fullfile(pathname, filename);
        THF = xlsread(xfile);
    end   
%
    sz=size(THF);
%
	amp=THF(:,3);
    clear ramp;
    ramp=amp;
	f=THF(:,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if(min(f)<=0)
        disp(' Frequency input error ');
        ppp=input(' ');
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	NHS=round(THF(:,4));
    if(min(NHS)<=0)
        disp(' NHS input error ');
        ppp=input(' ');
    end   
	td=THF(:,5);   
%
out1=sprintf('\n fmin=%8.4g  fmax=%8.4g   \n',min(f),max(f));
out2=sprintf('\n NHSmin=%d  NHSmax=%d   \n',min(NHS),max(NHS));
disp(out1)
disp(out2)
%
clear wavelet_table_add;
wavelet_table_add=THF;
%
	last_wavelet=sz(1);
%
	dt=1./ssr;
%
	nt=round(dur/dt);
%
	out1=sprintf(' last_wavelet= %d \n',last_wavelet);
    disp(out1);
	out1=sprintf(' nt= %d \n',nt);
    disp(out1);
	out1=sprintf(' dt= %9.5g sec \n',dt);
    disp(out1);   
%
disp(' ');
damp_ratio=input(' Enter damping ratio ');
%
% ********************** initialize filter coefficients ***************/
%
a1=     zeros(NUM_SRS,1);
a2=     zeros(NUM_SRS,1);
b1=     zeros(NUM_SRS,1);
b2=     zeros(NUM_SRS,1); 
%
omega=tpi*fn;
%
for(j=1:szTHS(1))
%
		omegad=omega(j)*sqrt(1.-(damp_ratio^2));
		cosd=cos(omegad*dt);
		sind=sin(omegad*dt);
		domegadt=damp_ratio*omega(j)*dt;
%
		a1(j)=2.*exp(-domegadt)*cosd;
		a2(j)=-exp(-2.*domegadt);
		b1(j)=2.*domegadt;
		b2(j)=omega(j)*dt*exp(-domegadt);
		b2(j)=b2(j)*( (omega(j)/omegad)*(1.-2.*(damp_ratio^2))*sind -2.*damp_ratio*cosd );
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
iter1=input(' Enter number of iterations ');
%
%% disp(' ');
%% iter2=input(' Enter number of iterations for phase 2 ');
%
rrold=ones(last_wavelet,1);
rrr=ones(max(size(amp)),1);
%
disp(' ');
disp(' multiply velocity and displacement by 386 ? ');
disp(' 1=yes 2=no ');
%
imul=input(' ');
%
if(imul==1)
	isu=386.;
end
disp(' ');
%
beta=tpi*f;
for(i=1:last_wavelet)
    alpha(i)=beta(i)/double(NHS(i));
    upper(i)=td(i)+(NHS(i)/(2.*f(i))); 
end
%
disp(' ref 1 ');
%
for(i=1:last_wavelet)
%    
    wavelet_low(i)=round( 0.5 +   (td(i)/dur)*nt);
     wavelet_up(i)=round(-0.5 +(upper(i)/dur)*nt);   
%    
    if(wavelet_low(i)==0)
        wavelet_low(i)=1;       
    end
    if(wavelet_up(i)>nt)
        wavelet_up(i)=nt;       
    end   
% 
end
%
disp(' ref 2 ');
%
t=linspace(0,nt*dt,nt);  
%
disp(' ref 3 ');
%
%   SRS interpolation for wavelet frequencies
%
last_srs=szTHS(1);
%
srsa=zeros(last_wavelet,1);
c1=zeros(last_wavelet,1);
c2=zeros(last_wavelet,1);
index=round(zeros(last_wavelet,1));
%
for(i=1:last_wavelet)
%
		for(j=1:(last_srs-1))
%
			if(  f(i)>= fn(j) && f(i)<= fn(j+1) )
%
                index(i)=j;
				len=fn(j+1)-fn(j);
				x=f(i)-fn(j);
				c2(i)=x/len;
				c1(i)=1.-c2(i);
				srsa(i) = c1(i)*srs_spec(j) + c2(i)*srs_spec(j+1);
%
				break;
%
            end
        end
end
%
ferr=mean(f);
serr=0.;
%
disp(' ref 4 ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% pre
    ijk=0;
    rrr=ones(max(size(amp)),1);
    accel=zeros(nt,1);
 	for(i=1:last_wavelet)
%%        progressbar(i/last_wavelet) % Update figure       
%
        sa=zeros(nt,1);
        sb=zeros(nt,1);
        sc=zeros(nt,1);
%
        ia=wavelet_low(i);
        ib=wavelet_up(i);
%       
        sa(ia:ib)=sin( alpha(i)*( t(ia:ib)-td(i) ) );
        sb(ia:ib)=sin(  beta(i)*( t(ia:ib)-td(i) ) );
        sc=amp(i)*sa.*sb;
%
		accel(ia:ib)=accel(ia:ib)+sc(ia:ib);
%
    end
%
    iflag=1;
%
    [xabs,xmax,xmin]=wqsrs(a1,a2,b1,b2,last_srs,iflag,accel,fn,dt); 
    [wavelet_table_add,amp,ramp,emax1,emax2,last_wavelet,ferr,serr]=werror3(wavelet_table_add,mflag,fn,xabs,xmin,xmax,srs_spec,last_srs,last_wavelet,rrr,amp,ramp,emax1,emax2,ijk);   
%
    clear rrr;   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% end pre
%
jjj=1;
for(ijk=1:iter1)
%
    rrr=ones(max(size(amp)),1);
    if(jjj==1001)
        out1=sprintf(' %d ',ijk);
        disp(out1);
        jjj=1;
    end
    jjj=jjj+1;
%   
%    progressbar % Create figure and set starting time 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    accel=zeros(nt,1);
    method=rand;   
%
    mflag=0;
    ieon=0;
    ichoice=rand;
    if(ijk>round(iter1*0.2) && ichoice>0.6)
        ieon=1;
        mflag=1;
    end
 %   
    if(mflag==0)
        if(method<0.5 && ijk>4)
            rrr=rand(max(size(amp)),1);
            rrr= 0.99 + 0.02*rrr;
            clear temp;
            temp(1:max(size(amp)))=ramp(1:max(size(amp)));
            clear ramp;
            ramp=temp';
            amp=rrr.*ramp; 
        else
            if(ijk>1)
                if(rand>0.8)
                    rrr=ones(max(size(amp)),1);
                else
                    rrr=rand(max(size(amp)),1);
                    rrr= 0.99 + 0.02*rrr;
                end
%    
%           Scaling
%
                nex=(rand^3);
                for(i=1:last_wavelet)
                    current = c1(i)*xabs(index(i)) + c2(i)*xabs( index(i)+1 );
	                if(current>1.0e-20 && current<1.0e+20)
                        ratio = abs(srsa(i)/current);
                    else
                        ratio=1;
                    end    
		            amp(i)=ramp(i)*(ratio^nex);
                end
            end
 %
        end
    else  % else branch for adding a wavelet
%        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
        i=last_wavelet;
        x33=rand;
% 
        NHS(i+1)= 3+(2*round(x33*30));	% nhs
        minf=min(f);
        maxf=max(f);
        qqq=rand;
        if(qqq<0.33)
            f(i+1)=ferr;
        end
        if(qqq>=0.33 && qqq <=0.67)
            f(i+1)=ferr*(0.5+1.5*rand);
            if(f(i+1)<minf)
                f(i+1)=minf;
            end
        end
        if(qqq>0.67)
            f(i+1)=minf+(maxf-minf)*rand;
        end
        amp(i+1)=0.1*serr*rand;
        if(rand>0.5)
            amp(i+1)=-amp(i+1);    
        end
%
        td(i+1)=(dur- (1.5/f(i+1)) )*rand;
%
        x3=NHS(i+1);
        x2=f(i+1);
        x4=td(i+1);
	    while(1)
	        if( tpi*x3/(2.*x2) + x4 < dur )
			    break;
		    else
			    x3=x3-2;
                if(x3<3)
                    x3=3;
                    x4=0.;
                    break;
                end
            end
        end 
        NHS(i+1)=x3; 
        td(i+1)=x4;
%
        wavelet_table_add(i+1,1)=i+1;
        wavelet_table_add(i+1,2)=f(i+1);
        wavelet_table_add(i+1,3)=amp(i+1);
        wavelet_table_add(i+1,4)=NHS(i+1); 
        wavelet_table_add(i+1,5)=td(i+1);          
%
        beta(i+1)=tpi*f(i+1);
        alpha(i+1)=beta(i+1)/double(NHS(i+1));
        upper(i+1)=td(i+1)+(NHS(i+1)/(2.*f(i+1)));
%
        ramp(i+1)=amp(i+1);
%    
        wavelet_low(i+1)=round( 0.5 +   (td(i+1)/dur)*nt);
        wavelet_up(i+1)=round(-0.5 +(upper(i+1)/dur)*nt);   
%    
        if(wavelet_low(i+1)==0)
            wavelet_low(i+1)=1;       
        end
        if(wavelet_up(i+1)>nt)
            wavelet_up(i+1)=nt;       
        end
%
		for(j=1:(last_srs-1))
%
			if(  f(i+1)>= fn(j) && f(i+1)<= fn(j+1) )
%
                index(i+1)=j;
				len=fn(j+1)-fn(j);
				x=f(i+1)-fn(j);
				c2(i+1)=x/len;
				c1(i+1)=1.-c2(i+1);
				srsa(i+1) = c1(i+1)*srs_spec(j) + c2(i+1)*srs_spec(j+1);
%
				break;
%
            end
        end
        rrr=ones(max(size(amp)),1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    end  % end else branch for adding wavelets;
%    
	for(i=1:last_wavelet+ieon)
%%        progressbar(i/last_wavelet) % Update figure       
%
        sa=zeros(nt,1);
        sb=zeros(nt,1);
        sc=zeros(nt,1);
%
        ia=wavelet_low(i);
        ib=wavelet_up(i);
%       
        sa(ia:ib)=sin( alpha(i)*( t(ia:ib)-td(i) ) );
        sb(ia:ib)=sin(  beta(i)*( t(ia:ib)-td(i) ) );
        sc=amp(i)*sa.*sb;
%
		accel(ia:ib)=accel(ia:ib)+sc(ia:ib);
%
    end
%
    iflag=1;
%
    [xabs,xmax,xmin]=wqsrs(a1,a2,b1,b2,last_srs,iflag,accel,fn,dt); 
    [wavelet_table_add,amp,ramp,emax1,emax2,last_wavelet,ferr,serr]=werror2(wavelet_table_add,mflag,fn,xabs,xmin,xmax,srs_spec,last_srs,last_wavelet,rrr,amp,ramp,emax1,emax2,ijk);   
%
    clear rrr;
%
end 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
%
%   final time history files
%
amp=ramp;
%
       accel=zeros(nt,1);
    velocity=zeros(nt,1);
displacement=zeros(nt,1);
%    
	for(i=1:last_wavelet)
        progressbar(i/last_wavelet) % Update figure       
%
        sa=zeros(nt,1);
        sb=zeros(nt,1);
        sc=zeros(nt,1);
%
        ia=wavelet_low(i);
        ib=wavelet_up(i);
%       
        sa(ia:ib)=sin( alpha(i)*( t(ia:ib)-td(i) ) );
        sb(ia:ib)=sin(  beta(i)*( t(ia:ib)-td(i) ) );
        sc=sa.*sb;
        sc=sc*amp(i);
%
		accel(ia:ib)=accel(ia:ib)+sc(ia:ib);
%
    end
%
    clear AI;
    clear amb;
    clear apb;
    alpha=alpha';
    apb=alpha+beta;
    amb=alpha-beta;
    AI=amp/2.;
%
	for(i=1:last_wavelet)
        progressbar(i/last_wavelet) % Update figure
%        
        sa=zeros(nt,1);
        sb=zeros(nt,1);
%        
        ia=wavelet_low(i);
        ib=wavelet_up(i);
%        
        sa(ia:ib)=sin( apb(i)*( t(ia:ib)-td(i) ) )/(apb(i));
        sb(ia:ib)=sin( amb(i)*( t(ia:ib)-td(i) ) )/(amb(i));
%
		velocity(ia:ib)=velocity(ia:ib)+AI(i)*(-sa(ia:ib)+sb(ia:ib));
%
    end
    velocity=velocity*isu;
%
	for(i=1:last_wavelet)
        progressbar(i/last_wavelet) % Update figure
%
        sa=zeros(nt,1);
        sb=zeros(nt,1);
%
        ia=wavelet_low(i);
        ib=wavelet_up(i);
%       
        sa(ia:ib)=(-1+cos( apb(i)*( t(ia:ib)-td(i) ) ) )/(apb(i)^2);
        sb(ia:ib)=(-1+cos( amb(i)*( t(ia:ib)-td(i) ) ) )/(amb(i)^2);
%
		displacement(ia:ib)=displacement(ia:ib)+AI(i)*(sa(ia:ib)-sb(ia:ib));
%        
    end
    displacement=displacement*isu;
%
    clear AI;
    clear amb;
    clear apb;   
%    
[xabs,xmax,xmin]=wqsrs(a1,a2,b1,b2,last_srs,iflag,accel,fn,dt);    
%
t=t';
acceleration=[t,accel];
velocity=[t,velocity];
displacement=[t,displacement];
xmax=xmax';
xmin=xmin';
shock_response=[fn,xmax,abs(xmin)];
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
figure(1);
plot(fn,srs_spec,fn,xmax,fn,abs(xmin),'-.');
legend ('spec','positive','negative'); 
iunit=1;
if iunit==1
        ylabel('Peak Accel (G)');
else
        ylabel('Peak Accel (m/sec^2)');
end
xlabel('Natural Frequency (Hz)');
out5 = sprintf(' Acceleration Shock Response Spectrum  damping=%8.4g ',damp_ratio);
title(out5);
grid on;
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
figure(2);
plot(t,accel);
grid on;
xlabel('Time (sec)')
ylabel('Accel (G)');
%
disp(' Output Time History Files: ');
%
disp(' acceleration ');
disp(' velocity     ');
disp(' displacement ');
%
disp(' The output SRS file is:  shock_response');
%
disp(' ');
disp(' The output wavelet table is: ');
disp(' wavelet_table_add ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ')
disp('Output Acceleration Response Text File?')
choice=input(' 1=yes  2=no  ' );
disp(' ')
%
if choice == 1 
%
      [writefname, writepname] = uiputfile('*.dat','Save acceleration data as');
	  writepfname = fullfile(writepname, writefname);
	  writedata = acceleration;
	  fid = fopen(writepfname,'w');
	  fprintf(fid,'  %g \t %g\n',writedata');
	  fclose(fid);
%    
end
%
disp(' ')
disp('Output Velocity Response Text File?')
choice=input(' 1=yes  2=no  ' );
disp(' ')
%
if choice == 1 
%
      [writefname, writepname] = uiputfile('*.dat','Save velocity data as');
	  writepfname = fullfile(writepname, writefname);
	  writedata = velocity;
	  fid = fopen(writepfname,'w');
	  fprintf(fid,'  %g \t %g\n',writedata');
	  fclose(fid);
%    
end
%
disp(' ')
disp('Output Displacement Response Text File?')
choice=input(' 1=yes  2=no  ' );
disp(' ')
%
if choice == 1 
%
      [writefname, writepname] = uiputfile('*.dat','Save displacement data as');
	  writepfname = fullfile(writepname, writefname);
	  writedata = displacement;
	  fid = fopen(writepfname,'w');
	  fprintf(fid,'  %g \t %g\n',writedata');
	  fclose(fid);
%    
end
%
disp(' ')
disp('Output SRS Text File?')
choice=input(' 1=yes  2=no  ' );
disp(' ')
%
if choice == 1 
%
      [writefname, writepname] = uiputfile('*.dat','SRS data as');
	  writepfname = fullfile(writepname, writefname);
	  writedata = shock_response;
	  fid = fopen(writepfname,'w');
	  fprintf(fid,'  %g \t %g \t %g\n',writedata');
	  fclose(fid);
%    
end
%
disp(' ')
disp('Output Wavelet Table Text File?')
choice=input(' 1=yes  2=no  ' );
disp(' ')
%
if choice == 1 
%
      [writefname, writepname] = uiputfile('*.dat','Save wavelet data as');
	  writepfname = fullfile(writepname, writefname);
	  writedata = wavelet_table_add;
	  fid = fopen(writepfname,'w');
	  fprintf(fid,'  %g \t %g \t %g \t %g \t %g \n',writedata');
	  fclose(fid);
%    
end
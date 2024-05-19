disp(' ')
disp(' srs_conv.m   ver 1.0   November 5, 2007')
disp(' by Tom Irvine   Email: tomirvine@aol.com')
disp(' ')
disp(' This program calculates the shock response spectrum')
disp(' of an acceleration time history, which is pre-loaded into Matlab.')
disp(' The time history must have two columns: time(sec) & acceleration')
disp(' ')
%
clear t;
clear y;
clear yy;
clear n;
clear fn;
clear a1;
clear a2
clear b1;
clear b2;
clear jnum;
clear THM;
clear resp;
clear x_pos;
clear x_neg;
%
iunit=input(' Enter acceleration unit:   1= G   2= m/sec^2  ');	
%
disp(' ')
disp(' Select file input method ');
disp('   1=external ASCII file ');
disp('   2=file preloaded into Matlab ');
file_choice = input('');
%
if(file_choice==1)
    [filename, pathname] = uigetfile('*.*');
    filename = fullfile(pathname, filename);
%      
    fid = fopen(filename,'r');
    THM = fscanf(fid,'%g %g',[2 inf]);
    THM=THM';
else
    THM = input(' Enter the matrix name:  ');
end
%
t=double(THM(:,1));
y=double(THM(:,2));
%
tmx=max(t);
tmi=min(t);
n = length(y);
%
out1 = sprintf('\n  %d samples ',n);
disp(out1)
%
dt=(tmx-tmi)/(n-1);
sr=1./dt;
%
disp(' ')
disp(' Time Step ');
dtmin=min(diff(t));
dtmax=max(diff(t));
%
out4 = sprintf(' dtmin  = %8.4g sec  ',dtmin);
out5 = sprintf(' dt     = %8.4g sec  ',dt);
out6 = sprintf(' dtmax  = %8.4g sec  ',dtmax);
disp(out4)
disp(out5)
disp(out6)
%
disp(' ')
disp(' Sample Rate ');
out4 = sprintf(' srmin  = %8.4g samples/sec  ',1/dtmax);
out5 = sprintf(' sr     = %8.4g samples/sec  ',1/dt);
out6 = sprintf(' srmax  = %8.4g samples/sec  \n',1/dtmin);
disp(out4)
disp(out5)
disp(out6)
%
ncontinue=1;
if(((dtmax-dtmin)/dt)>0.01)
    disp(' ')
    disp(' Warning:  time step is not constant.  Continue calculation? 1=yes 2=no ')
    ncontinue=input(' ')
end
if(ncontinue==1)
%
    fn(1)=input(' Enter the starting frequency (Hz)  ');
    if fn(1)>sr/30.
        fn(1)=sr/30.;
    end
%
    idamp=input(' Enter damping format:  1= damping ratio   2= Q  ');	
%
    disp(' ')
    if(idamp==1)
        damp=input(' Enter damping ratio (typically 0.05) ');
    else
        Q=input(' Enter the amplification factor (typically Q=10) ');
        damp=1./(2.*Q);
    end
%
    tmax=(tmx-tmi) + 1./fn(1);
    limit = round( tmax/dt );
    n=limit;
    clear tt;
    clear yy;
    limit=2^17;
    iflag=0;
    for(i=1:limit)
%        
        yy(i)=0;
        if(i<=length(y))
            yy(i)=y(i);
        end
 %       
        tt(i)=(i-1)*dt;
 %
        if(i>length(y))
            for(n=1:17)
                if(i==2^n)
                    iflag=1;
                    break;
                end
            end
        end
        if(iflag==1)
            break
        end
 %
    end    
    length(yy)
    clear Y;
    Y = fft(yy);    
%
    disp(' ')
    disp(' Calculating response..... ')
%
%  SRS engine
%
    sqd=sqrt(1.-(damp^2));
    tpi=2*pi;
%
    disp(' ');
    disp('   fn (Hz)   Pos (G)   Neg (G)  ');
%
    for j=1:1000
        clear h;
        clear H;
        clear w;
        clear ot;
%
        omega=tpi*fn(j);
        omegad=omega*sqd;
%
        omegan=omega; 
%
        c1=omegad^2-(damp*omegan)^2;
        c2=2*damp*omegan*omegad;
%            
        dwn=-damp*omega;
        ot=tt*omegad;    
%
        ccc=c2*cos(ot);
        sss=c1*sin(ot);
%        
        cs=sss+ccc;
        ee=exp(dwn*tt);
 %       
%%        for i=1:length(yy)
%%            h(i)=exp(dwn*tt(i))ee.*cs;
%%        end
%
        h=ee.*cs;
%
        H=fft(h);
%                
%%%        w = conv(yy,h);
%%%%% X = fft([x zeros(1,length(y)-1)])and 
%%%%% Y = fft([y zeros(1,length(x)-1)])then conv(x,y) = ifft(X.*Y)
%
        w=(dt/omegad)*real(ifft(Y.*H));
%       
        x_pos(j)=max(w);
        x_neg(j)=min(w);
 %
        out1 = sprintf('   %8.4g  %8.4g  %8.4g ',fn(j),x_pos(j),x_neg(j));
        disp(out1);
 %
        if  fn(j) > sr/8.
            break
        end
        fn(j+1)=fn(1)*(2. ^ (j*(1./12.)));   
        jnum=j;
    end
%
    maximaxSRS=max(x_pos,abs(x_neg)); 
%
    fmax=0;
    zmax=0;
    for(i=1:length(fn))
        if(x_pos(i)>zmax)
            zmax=x_pos(i);
            fmax=fn(i);
        end
        if(abs(x_neg(i))>zmax)
            zmax=abs(x_neg(i));
            fmax=fn(i);
        end 
    end
%
    if(iunit==1)
        out5 = sprintf('\n Absolute Peak is %10.5g G at %10.5g Hz ',zmax,fmax);
    else
        out5 = sprintf('\n Absolute Peak is %10.5g m/sec^2 at %10.5g Hz ',zmax,fmax);
    end
    disp(out5)
%
%  Output options
%
    disp(' ')
    disp(' Select output option ');
    choice=input(' 1=plot only   2=plot & output text file  ' );
    disp(' ')
%
    if choice == 2 
%%
        [writefname, writepname] = uiputfile('*','Save positive & negative SRS data as');
	    writepfname = fullfile(writepname, writefname);
	    writedata = [fn' x_pos' (abs(x_neg))' ];
	    fid = fopen(writepfname,'w');
	    fprintf(fid,'  %g  %g  %g\n',writedata');
	    fclose(fid);
%%
        [writefname, writepname] = uiputfile('*','Save maximax SRS data as');
	    writepfname = fullfile(writepname, writefname);
	    writedata = [fn' maximaxSRS' ];
	    fid = fopen(writepfname,'w');
	    fprintf(fid,'  %g  %g \n',writedata');
	    fclose(fid);
%%
%   disp(' Enter output filename ');
%   SRS_filename = input(' ','s');
%
%   fid = fopen(SRS_filename,'w');
%   for j=1:jnum
%        fprintf(fid,'%7.2f %10.3f %10.3f \n',fn(j),x_pos(j),abs(x_neg(j)));
%   end
%   fclose(fid);
    end
%
%  Plot SRS
%
    disp(' ')
    disp(' Plotting output..... ')
%
%  Find limits for plot
%
    srs_max = max(x_pos);
    if max( abs(x_neg) ) > srs_max
        srs_max = max( abs(x_neg ));
    end
    srs_min = min(x_pos);
    if min( abs(x_neg) ) < srs_min
        srs_min = min( abs(x_neg ));
    end  
%
    disp(' select plot type:  1=positive & negative   2=maximax ');
    ipt=input(' ');
%
    clear figure(1);
    figure(1);
%
    if(ipt==1)
        plot(fn,x_pos,fn,abs(x_neg),'-.');
        legend ('positive','negative'); 
    else
        plot(fn,maximaxSRS);
    end
%
    SRS_pn=[fn',x_pos',abs(x_neg)'];
    SRS_max=[fn',x_pos',maximaxSRS']; 
%
    if iunit==1
        ylabel('Peak Accel (G)');
    else
        ylabel('Peak Accel (m/sec^2)');
    end
    xlabel('Natural Frequency (Hz)');
    Q=1./(2.*damp);
    out5 = sprintf(' Acceleration Shock Response Spectrum Q=%g ',Q);
    title(out5);
    grid;
    set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');
%
    ymax= 10^(round(log10(srs_max)+0.8));
    ymin= 10^(round(log10(srs_min)-0.6));
%
    fmax=max(fn);
    fmin=fmax/10.;
%
    fmax= 10^(round(log10(fmax)+0.5));
%
    if  fn(1) >= 0.1
        fmin=0.1;
    end
    if  fn(1) >= 1
        fmin=1;
    end
    if  fn(1) >= 10
        fmin=10;
    end
    if  fn(1) >= 100
        fmin=100;
    end
    axis([fmin,fmax,ymin,ymax]);
%
    disp(' Matlab matrices: ')
    disp('      SRS_pn  - Acceleration SRS positive & negative ')
    disp('      SRS_max - Acceleration SRS maximax             ') 
%
    disp(' ')
    disp(' Plot pseudo velocity? ');
    vchoice=input(' 1=yes   2=no  ' );
    if(vchoice==1)
        disp(' select plot type:  1=positive & negative   2=maximax ');
        ipt=input(' ');     
%
%   Convert to pseudo velocity
%
        for j=1:jnum  
            if iunit==1   
                x_pos(j)=386.*x_pos(j)/(2.*pi*fn(j));
                x_neg(j)=386.*x_neg(j)/(2.*pi*fn(j));   
            else
                x_pos(j)=x_pos(j)/(2.*pi*fn(j));
                x_neg(j)=x_neg(j)/(2.*pi*fn(j));   
            end
        end    
%
        srs_max = max(x_pos);
        if max( abs(x_neg) ) > srs_max
            srs_max = max( abs(x_neg ));
        end
        srs_min = min(x_pos);
        if min( abs(x_neg) ) < srs_min
            srs_min = min( abs(x_neg ));
        end  
%
        clear figure(2);
        figure(2);
        clear xpn;
        xpn=max(x_pos,abs(x_neg)); 
        figure(2);
        if(ipt==1)
            plot(fn,x_pos,fn,abs(x_neg),'-.');
            legend ('positive','negative');   
        else     
            plot(fn,xpn);    
        end
        pseudo_velocity_pn=[fn',x_pos',abs(x_neg)'];
        pseudo_velocity_max=[fn',xpn'];  
%
        if iunit==1
            ylabel('Velocity (in/sec)');
        else
            ylabel('Velocity (m/sec)');   
        end
        xlabel('Natural Frequency (Hz)');
        Q=1./(2.*damp);
        out5 = sprintf(' Pseudo Velocity Shock Response Spectrum Q=%g ',Q);
        title(out5);
        grid;
        set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');
%
        ymax= 10^(round(log10(srs_max)+0.8));
        ymin= 10^(round(log10(srs_min)-0.6));
%
        axis([fmin,fmax,ymin,ymax]);
    end
%
%
    disp(' Matlab matrices: ')
    disp('      pseudo_velocity_pn  - pseudo_velocity SRS positive & negative ')
    disp('      pseudo_velocity_max - pseudo_velocity SRS maximax             ') 
%
end
disp(' ')
disp(' srs.m   ver 4.2   July 1, 2013')
disp(' by Tom Irvine   Email: tom@vibrationdata.com')
disp(' ')
disp(' This program calculates the shock response spectrum')
disp(' of an acceleration time history, which is pre-loaded into Matlab.')
disp(' The time history must have two columns: time(sec) & acceleration')
disp(' ')
%
close all;
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
clear x_std;
clear rd_pos;
clear rd_neg;
%
while(1)
    disp(' Select units ');
    disp('  1=English: accel(G),       vel(in/sec),  disp(in)  ');
    disp('  2=metric : accel(G),        vel(m/sec),  disp(mm)  ');
    disp('  3=metric : accel(m/sec^2),  vel(m/sec),  disp(mm)  ');   
    iunit=input(' ');
    if(iunit==1 || iunit==2 || iunit==3)
        break;
    end
end	
%
[t,y,dt,sr,tmx,tmi,n,ncontinue]=enter_time_history();
nnn=n;
%
ifn=1;
figure(ifn);
ifn=ifn+1;
plot(t,y);
grid on;
ylabel('Accel(G)');
xlabel('Time(sec)');
%
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
j=1;
while(1)
    if (fn(j) > sr/8.)
        break
    end
    fn(j+1)=fn(1)*(2. ^ (j*(1./12.))); 
    j=j+1;
end
%
[a1,a2,b1,b2,b3,rd_a1,rd_a2,rd_b1,rd_b2,rd_b3]=...
                                   srs_coefficients(fn,damp,dt);
%
disp(' ');
disp(' Include residual? ');
disp('  1=yes  2=no ')
ire=input(' ');
%
if(ire==1)
%
%   Add trailing zeros for residual response
%
    tmax=(tmx-tmi) + 1./fn(1);
else
    tmax=(tmx-tmi);
end
    
    limit = round( tmax/dt );
    n=limit;
    yy=zeros(1,limit);
    for i=1:max(nnn)
        yy(i)=y(i);
    end    
%
    disp(' ')
    disp(' Calculating response..... ')
%
%  SRS engine
%
    ns=max(size(fn));
%
    x_pos=zeros(ns,1);
    x_neg=zeros(ns,1);    
    x_std=zeros(ns,1);
%
    rd_neg=zeros(ns,1);
    rd_pos=zeros(ns,1);
%
    for j=1:ns
%
        forward=[ b1(j),  b2(j),  b3(j) ];    
        back   =[     1, -a1(j), -a2(j) ];    
%    
        resp=filter(forward,back,yy);
%
        x_pos(j)= max(resp);
        x_neg(j)= min(resp);
        x_std(j)= std(resp);
%
%%%%%% relative displacement %%%
%
        rd_forward=[ rd_b1(j),  rd_b2(j),  rd_b3(j) ];    
        rd_back   =[     1, -rd_a1(j), -rd_a2(j) ];  
%        
        rd_resp=filter(rd_forward,rd_back,yy);
%        
        rd_pos(j)= max(rd_resp);
        rd_neg(j)= min(rd_resp);      
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
        jnum=j;    
    end
%
    if iunit==1
          rd_pos=rd_pos*386;
          rd_neg=rd_neg*386;
    end
    if iunit==2
          rd_pos=rd_pos*9.81*1000;
          rd_neg=rd_neg*9.81*1000;       
    end
    if iunit==3
          rd_pos=rd_pos*1000;
          rd_neg=rd_neg*1000;              
    end
%
    maximaxSRS=max(x_pos,abs(x_neg)); 
%
    fmax=0;
    zmax=0;
    for i=1:ns
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
    fn=fix_size(fn);
    x_pos=fix_size(x_pos);
    x_neg=fix_size(x_neg);
%
    clear SRS_max;
    SRS_pn=[fn,x_pos,abs(x_neg)];
    SRS_max=[fn,maximaxSRS];
%    
    [zmax,fz_max]=find_max(SRS_max);
%
    if(iunit==1 || iunit==2)
        out5 = sprintf('\n Absolute Peak is %10.5g G at %10.5g Hz ',zmax,fz_max);
    else
        out5 = sprintf('\n Absolute Peak is %10.5g m/sec^2 at %10.5g Hz ',zmax,fz_max);
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
        n=length(fn);
%
        [writefname, writepname] = uiputfile('*','Save positive & negative SRS data as');
	    writepfname = fullfile(writepname, writefname);
	    fid = fopen(writepfname,'w');
        axn=(abs(x_neg));
        for i=1:n
            fprintf(fid,' %g \t %g \t %g\n',fn(i),x_pos(i),axn(i));
        end    
	    fclose(fid);
%%
        [writefname, writepname] = uiputfile('*','Save maximax SRS data as');
	    writepfname = fullfile(writepname, writefname);
	    fid = fopen(writepfname,'w');
        for i=1:n
	        fprintf(fid,' %g \t %g \n',fn(i),maximaxSRS(i));
        end
        fclose(fid);
%%
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
    figure(ifn);
    ifn=ifn+1;
%
    if(ipt==1)
        plot(fn,x_pos,fn,abs(x_neg),'-.');
        legend ('positive','negative'); 
    else
        plot(fn,maximaxSRS);
    end
%
    if(iunit==1 || iunit==2)
        ylabel('Peak Accel (G)');
    else
        ylabel('Peak Accel (m/sec^2)');        
    end
%
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
   if  fn(1) >= 0.001
        fmin=0.001;
    end
    if  fn(1) >= 0.01
        fmin=0.01;
    end
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
            omegan=2*pi*fn(j);
            x_pos(j)=x_pos(j)/omegan;
            x_neg(j)=x_neg(j)/omegan;  
        end
%        
        if iunit==1   
                x_pos=386.*x_pos;
                x_neg=386.*x_neg;   
        end
        if iunit==2
                x_pos=9.81*x_pos;
                x_neg=9.81*x_neg;   
        end
%
%
        figure(ifn);
        ifn=ifn+1;  
        clear xpn;
        xpn=max(x_pos,abs(x_neg)); 
        if(ipt==1)
            plot(fn,x_pos,fn,abs(x_neg),'-.');
            legend ('positive','negative');   
        else     
            plot(fn,xpn);    
        end
        pseudo_velocity_pn=[fn,x_pos,abs(x_neg)];
        pseudo_velocity_max=[fn,xpn];  
%
        [zmax,fz_max]=find_max(pseudo_velocity_max);
%
        if(iunit==1)
            out5 = sprintf('\n Absolute Peak is %10.5g in/sec at %10.5g Hz ',zmax,fz_max);
        else
            out5 = sprintf('\n Absolute Peak is %10.5g m/sec at %10.5g Hz ',zmax,fz_max);
        end
        disp(out5)
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
        srs_max=max(xpn);
        srs_min=min(xpn);
        ymax= 10^(round(log10(srs_max)+0.8));
        ymin= 10^(round(log10(srs_min)-0.6));
%
        axis([fmin,fmax,ymin,ymax]);
 %
        disp(' Matlab matrices: ')
        disp('      pseudo_velocity_pn  - pseudo_velocity SRS positive & negative ')
        disp('      pseudo_velocity_max - pseudo_velocity SRS maximax             ')        
    end
%
    disp(' ');
    disp(' Plot relative displacement? ');
    rdchoice=input(' 1=yes   2=no  ' );
%
    if(rdchoice==1)
        disp(' select plot type:  1=positive & negative   2=maximax ');
        ipt=input(' ');
%
        figure(ifn);
        ifn=ifn+1;
        clear rd_pn;
        rd_pn=max(rd_pos,abs(rd_neg));        
        if(ipt==1)
           plot(fn,rd_pos,fn,abs(rd_neg),'-.');
           legend ('positive','negative');        
        else
           plot(fn,rd_pn);
        end       
        if iunit==1
            ylabel('Rel Disp (in)');
        else
            ylabel('Rel Disp (mm)');   
        end        
        xlabel('Natural Frequency (Hz)');
        Q=1./(2.*damp);
        out5 = sprintf(' Relative Displacement Shock Response Spectrum Q=%g ',Q);
        title(out5);
        grid;
        set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');
%
        rel_disp_pn=[fn,rd_pos,abs(rd_neg)];
        rel_disp_max=[fn,rd_pn];  
%
        disp(' Matlab matrices: ')
        disp('      rel_disp_pn  - relative displacement SRS positive & negative ')
        disp('      rel_disp_max - relative displacement SRS maximax             ')
%
    end    
%
    disp(' ')
    disp(' Plot std dev response spectrum? ');
    sdchoice=input(' 1=yes   2=no  ' );
    if(sdchoice==1)
        figure(ifn);
        ifn=ifn+1;
        plot(fn,x_std);
%
        if(iunit==1 || iunit==2)
            ylabel('Peak Accel (G)');
        else
            ylabel('Peak Accel (m/sec^2)');        
        end
%
        xlabel('Natural Frequency (Hz)');
        Q=1./(2.*damp);
        out5 = sprintf(' Std Dev Shock Response Spectrum Q=%g ',Q);
        title(out5);
        grid;
        set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log'); 
    end     
%
end
%
clear srs_max;
clear srs_min;
%
disp(' ')
disp(' vc_velox.m   ver 1.1  May 27, 2013 ')
disp(' by Tom Irvine  Email: tom@vibrationdata.com ')
disp(' ')
disp(' This program calculates the one-third velocity spectrum ')
disp(' of a time history for comparison with ISO Generic Vibration ');
disp(' Criteria for Vibration-Sensitive Equipment.')
disp(' ')
disp(' The input time history may be either acceleration or velocity. ');
disp(' ');
disp(' The time history must be in a two-column matrix format: ')
disp(' Time(sec)  & amplitude ')
disp(' ')
%
close all;
%
clear t;
clear f;
clear n;
clear Y;
clear amp;
clear tim;
clear N;
clear df;
clear dt;
clear Mag;
clear full;
clear freq;
clear complex_FFT;
clear THM;
clear mu;
clear mean;
clear length;
%
fig_num=1;
%
[t,amp,dt,sr,tmx,tmi,~,ncontinue]=enter_time_history();
%
disp(' ');
disp(' Enter input amplitude type ');
disp('  1=acceleration  2=velocity ');
iat=input(' ');
%
amp=detrend(amp,'linear');
%
if(iat==1)
    disp(' ');
    disp(' Enter input acceleration unit ');
    disp('  1=G  2=m/sec^2 ');
    iau=input(' ');
    if(iau==1)
        amp=amp*9.81;  % convert to G to m/sec^2   
    end
%
    iband=2;  % highpass filter 
    iphase=1; % refiltering for phase correction
    fl=2;
    fh=2;
    [amp,~,~,~]=...
                Butterworth_filter_function_alt(amp,dt,iband,fl,fh,iphase);
    [amp]=integrate_function(amp,dt);
    amp=detrend(amp,'linear');  
%
else
    disp(' ');
    disp(' Enter input velocity unit ');
    disp('  1=in/sec  2=m/sec ');
    iau=input(' ');
    if(iau==1)
        amp=amp*0.0254; % convert in/sec to m/sec
    end    
end
%
amp=amp*1.0e+06;  % convert to micro meters/sec
%
THM=[t amp];
%
p_unit=sprintf('micro meters/sec');
x_label=sprintf('Time(sec)');
y_label=sprintf('Velocity(%s)',p_unit);
t_string=sprintf('Time History');
[fig_num]=plot_TH(fig_num,x_label,y_label,t_string,THM);
%
disp(' ');
st=input(' Enter starting time (sec) ');
%
disp(' ');
te=input(' Enter ending time (sec) ');
%
j=1;
jfirst=1;
jlast=max(size(THM));
for i=1:max(size(THM))
    if(THM(i,1)<st)
        jfirst=i;
    end
    if(THM(i,1)>te)
        jlast=i;
        break;
    end
end
%
tim=double(THM(jfirst:jlast,1));
amp=double(THM(jfirst:jlast,2));    
%
n = max(size(amp));
%
N=2^(floor(log(n)/log(2)));
%
out4 = sprintf(' time history length = %d ',n);
disp(out4)
disp(' ');
%
mu=mean(amp);
amp=amp-mu;
%
if(ncontinue==1)
%
    max_df=2; 
    [dt,df,mmm,NW,io]=FFT_advise_limit(tim,amp,max_df);
%
    [mk,freq,time_a,dt,NW]=FFT_time_freq_set(mmm,NW,dt,df,tmi,io);
%
    [store,store_p,freq_p,max_a,max_f]=FFT_core_seg(NW,mmm,mk,freq,amp,io);                               
%
    store=store';
%
    sz=size(store);
    imax=sz(1);
    jmax=sz(2);
    full=zeros(imax,1);
    for i=1:imax
 %
        ms=0;  
        for j=1:jmax
            ms=ms+0.5*store(i,j)^2;
        end
 %
        full(i)=sqrt(ms/jmax);   % rms
    end
%
    full=sqrt(2)*full;  % peak
%
    [fl,fc,fu,imax]=one_third_octave_frequencies();
%
    [sv]=convert_FFT_to_one_third(freq,fl,fu,full);                   
%
    fstart=4;
    fend=80;
    [pf,pv]=trim_frequency_function(fc,sv,fstart,fend);  
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    figure(fig_num);
    fig_num=fig_num+1;
    fs=[4 8 80]';
    ws=[1600 800 800]';
    of=0.5*ws;
    res=0.5*of;
    th=0.5*res;
    vca=0.5*th;
    vcb=0.5*vca;
    vcc=0.5*vcb;
    vcd=0.5*vcc;
    vce=0.5*vcd;
    plot(pf,pv,fs,ws,'k',fs,of,'k',fs,res,'k',fs,th,'k',fs,vca,'k',...
                              fs,vcb,'k',fs,vcc,'k',fs,vcd,'k',fs,vce,'k');
    title('One Third Octave Band Spectral Velocity'); 
    ylabel('Velocity (micro meters/sec)');
    xlabel('Center Frequency (Hz)');
%
    grid on;
    set(gca,'MinorGridLineStyle','none','GridLineStyle','none','XScale',...
                                                     'log','YScale','log');
    fmin=4;
    fmax=80;
%    
    yyy=max(pv);
    if(yyy<1600)
        yyy=1600;
    end
%    
    yss=min(pv);
    if(yss>min(vce))
        yss=min(vce);
    end
%
%%    ymax=10^ceil(log10(max(yyy)));
    ymax=3200;
%%    ymin=10^floor(log10(min(yss)));
    ymin=3.125;
    axis([fmin,fmax,ymin,ymax]);
%
    set(gca,'ytick',[3.125 6.25 12.5 25 50 100 200 400 800 1600 3200])
    set(gca,'YTickLabel',{'3.125';'6.25';'12.5';'25';'50';'100';'200';'400';'800';'1600';'3200'}) 
%
    set(gca,'xtick',[4 5 6.3 8 10 12.5 16 20 25 31.5 40 50 63 80])
    set(gca,'XTickLabel',{'4';'5';'6.3';'8';'10';'12.5';'16';'20';'25';'31.5';'40';'50';'63';'80';})    
%
    text('Position',[81 800],'String','Workshop','color','k','FontWeight','normal','FontSize',9) 
    text('Position',[81 400],'String','Office','color','k','FontWeight','normal','FontSize',9)
    text('Position',[81 200],'String','Residential','color','k','FontWeight','normal','FontSize',9)
    text('Position',[81 100],'String','Theater','color','k','FontWeight','normal','FontSize',9) 
    text('Position',[81 50],'String','VC-A','color','k','FontWeight','normal','FontSize',9) 
    text('Position',[81 25],'String','VC-B','color','k','FontWeight','normal','FontSize',9)
    text('Position',[81 12.5],'String','VC-C','color','k','FontWeight','normal','FontSize',9)     
    text('Position',[81 6.25],'String','VC-D','color','k','FontWeight','normal','FontSize',9) 
    text('Position',[81 3.125],'String','VC-E','color','k','FontWeight','normal','FontSize',9)   
%
    pos = get(gca,'position'); % This is in normalized coordinates 
    pos(3:4)=pos(3:4)*.92; % Shrink the axis by a factor of .92 
    pos(1:2)=pos(1:2)+pos(3:4)*.05; % Center it in the figure window 
    set(gca,'position',pos);
%
    [pf]=fix_size(pf);
    [pv]=fix_size(pv);
%
    spectral_velocity=[pf pv];
%    
    [xmax,ymax]=find_max(spectral_velocity);    
%
    out1=sprintf('\n maximum: %8.4g micro meters/sec at %6.2g Hz ',xmax,ymax);
    disp(out1);
%
    disp(' ');
    disp(' Write the spectral velocity data to a external file? ')
    choice = input(' 1=yes 2=no ');
%
    if(choice == 1)
        disp(' ');   
        disp(' Enter the output filename ');
        filename1 = input(' ','s');
        fid1 = fopen(filename1,'w');  
        for k=1:max(size(pf))
            fprintf(fid1,'%11.4e \t %11.4e \n',pf(k), pv(k));    
        end
        fclose(fid1);
    end    
%
    disp(' ');
    disp(' Matlab filename:  spectral_velocity');
%
end
%
%   accel_psd_syn_function.m  ver 1.1  by Tom Irvine
%
%   This script synthesizes a time history to satisfy an acceleration
%   power spectral density specification.
%
%   The corresponding velocity and displacement time histories will each
%   oscillate about their respective zero baselines.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   
%   Input variables:
%
%     psd_spec - freq(Hz) & accel(G^2/Hz)
%     dur - duration(sec)
%     nseed - random number seed integer
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Output variables:
%
%     acceleration - time(sec) & accel(G)
%     velocity     - time(sec) & vel(in/sec)
%     displacement - time(sec) & disp(in)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   External functions:
%
%       calculate_PSD_slopes
%       PSD_syn_white_noise_seed
%       full_FFT_core
%       interpolate_PSD_spec
%       PSD_syn_FFT_core
%       PSD_syn_scale_time_history
%       wnb_PSD_syn_verify
%       wnaccel_psd_syn_correction
%       kurtosis_stats
%       FFT_core
%       velox_correction
%       integrate_function
%       differentiate_function
%       fix_size 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[acceleration,velocity,displacement]=...
                                   accel_psd_syn_function(psd_spec,dur,nseed)
                         
    fig_num=1;

    [mmm,~,m_choice,h_choice,original_spec,maxf,iunit]=initial(psd_spec);
                                       
    [data,dt,~,np,~]=advise_syn(maxf,dur);
    
    [~,ij]=min(abs( data(:,4)-4));
    NW=data(ij,1);
    
    [~,freq,amp]=check_psd_spec(psd_spec);
    
    [slope,spec_rms] = calculate_PSD_slopes(freq,amp);
                                           
    [np,white_noise,~]=PSD_syn_white_noise_seed(dt,np,nseed);
    
    % Technique for improving time history accuracy
    
    [~,~,~,complex_FFT]=full_FFT_core(m_choice,h_choice,white_noise,np,dt);
    alpha1=atan2(complex_FFT(:,2),complex_FFT(:,3));
    XX=( cos(alpha1) + (1i)*sin(alpha1)); 
    white_noise=ifft(XX,np,'symmetric');
    
    
    %  Interpolate PSD spec
    %

    df=1/(np*dt);
    [~,spec]=interpolate_PSD_spec(np,freq,amp,slope,df);
    
    fmax=max(freq);
    
    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %
    nsegments = 1;
    %
    sq_spec=sqrt(spec);
    %
    
    [~,psd_th,~]=PSD_syn_FFT_core(nsegments,mmm,np,fmax,df,sq_spec,white_noise);
    %
    
    [TT,psd_th,dt]=PSD_syn_scale_time_history(psd_th,spec_rms,np,dur);
    %
    
    [amp,mr_choice,h_choice,~]=...
                           wnb_PSD_syn_verify(TT,psd_th,spec_rms,dt,df,mmm,NW);
     %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %
    nnt=4;
    %
    freq_spec=original_spec(:,1);
     amp_spec=original_spec(:,2);
    
    %
    [amp,velox,dispx,freq,full,tim,~]=...
          wnaccel_psd_syn_correction(nnt,amp,dt,spec_rms,NW,freq_spec,...
                              amp_spec,mr_choice,h_choice,TT,iunit,spec_rms);
    
    scale=std(amp)/spec_rms;
     
    amp=amp*scale;
    velox=velox*scale;
    dispx=dispx*scale;
    
    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %
    
    [~,~,rms,~,kt]=kurtosis_stats(amp);
    
    crest=max(abs(amp))/rms;
    
    fprintf('\n  Overall RMS = %10.3g \n',rms);
    fprintf('  Three Sigma = %10.3g \n',3*rms);
    
    mx=max(amp);
    mi=min(amp);
        
    fprintf('      Maximum = %8.4g \n',mx);
    fprintf('      Minimum = %8.4g \n',mi);
    
    fprintf('     Kurtosis = %10.3g \n',kt);
    fprintf(' Crest Factor = %10.3g \n\n',crest);
    
    %
    TT=tim;
    psd_TH=amp;
    psd_velox=velox;
    psd_dispx=dispx;
    %
    TT=fix_size(TT);
    %
    clear length;
    na=length(psd_TH);
    %
    TT=TT(1:na);
    
    %
    psd_velox=fix_size(psd_velox);
    psd_dispx=fix_size(psd_dispx);
    
    acceleration=[TT psd_TH];
    velocity    =[TT psd_velox];
    displacement=[TT psd_dispx];


    unit='G';
    aat=sprintf('Acceleration Time History Synthesis  %7.3g %sRMS',std(psd_th),unit);
    ay=sprintf('Acceleration (%s)',unit);
        
    unit='in/sec';
    vvt=sprintf('Velocity Time History Synthesis  %7.3g %s RMS',std(psd_velox),unit);
    vy=sprintf('Velocity (%s)',unit);
                
    unit='in';
    ddt=sprintf('Displacement Time History Synthesis  %7.3g %s RMS',std(psd_dispx),unit);
    dy=sprintf('Displacement (%s)',unit);

    freq_spec=psd_spec(:,1);
    amp_spec=psd_spec(:,2);   
                 
    tt=TT;
    a=psd_TH;
    v=psd_velox;
    d=psd_dispx;
    [fig_num,~]=plot_avd_time_histories_subplots_altp_titles(fig_num,tt,a,v,d,ay,vy,dy,aat,vvt,ddt);

    %%%%%

    nbars=31;

    ppp=[TT psd_TH];

    xL='Time (sec)';
    yL=sprintf('Accel (G)');

    t_string=sprintf('Accel Time History Synthesis  %7.3g GRMS',std(psd_TH));
 
    [fig_num]=plot_time_history_histogram(fig_num,ppp,t_string,xL,yL,nbars);  

    %%%%%
                      
    figure(fig_num);
    plot(freq,full,'b',freq_spec,amp_spec,'r',...
                       freq_spec,sqrt(2)*amp_spec,'k',freq_spec,amp_spec/sqrt(2),'k');
    legend ('Synthesis','Specification','+/- 1.5 dB tol ');
    %   
    fmin=freq_spec(1);
    fmax=max(freq_spec);
    ymax=max(full);
    %  
    xlabel(' Frequency (Hz)');

    at=sprintf('Power Spectral Density %7.3g %s GRMS',rms);               
                              
    out1=sprintf('Accel (G^2/Hz)');
    ylabel(out1); 
 
    title(at);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log'); 
    grid;
            
    tb=sqrt(sqrt(2));
    ymax=10^(ceil(+0.1+log10(ymax)));
    ymin = min(amp_spec/tb);
    ymin=10^(floor(-0.1+log10(ymin)));
    %
    fmax=10^(ceil(log10(fmax)));
    fmin=10^(floor(log10(fmin)));
    %
    xlim([fmin,fmax]);
    ylim([ymin,ymax]);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[psd_spec,freq,amp]=check_psd_spec(psd_spec)

    if(psd_spec(1,1)<1.0e-09)  % check for zero frequency
        psd_spec(1,1)=10^(floor(-0.1+log10(psd_spec(2,1))));
    end
    %
    if(psd_spec(1,2)<1.0e-30)  % check for zero amplitude
        noct=log(psd_spec(2,1)/psd_spec(1,1))/log(2);
        psd_spec(1,2)=(noct/4)*psd_spec(2,2);         % 6 db/octave 
    end
    
    nsz=max(size(psd_spec));
    freq=zeros(nsz+1,1);
    amp=zeros(nsz+1,1);
    %
    k=1;
    for i=1:nsz
        if(psd_spec(i,1)>0)
            amp(k)=psd_spec(i,2);
            freq(k)=psd_spec(i,1);
            k=k+1;
        end
    end
    
    %
    freq(nsz+1)=freq(nsz)*2^(1/48);
    amp(nsz+1)=amp(nsz);
    
end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
function[mmm,nseed,m_choice,h_choice,original_spec,maxf,iunit]=initial(psd_spec)
    
    mmm=0; % not used
    nseed=2;
    m_choice=1; % mean removal
    h_choice=1; % rectangular window
    
    iunit=1;
    
    maxf=psd_spec(end,1);
    
    original_spec=psd_spec;

end          
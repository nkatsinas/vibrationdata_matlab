 
%
%   waterfall_fft_function.m  ver 1.0  by Tom Irvine
%
%   This function calculates the Waterfall FFT of a time history
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Input Variables
%
%        amp: 1D array: amplitude  
%         dt: time step (sec)    (data must have constant time step)
%     tstart: starting time (sec)
%
%         mr: mean removal   1=yes  2=no
%     window: 1=rectangular  2=Hanning
%
%       fmin: minimum frequency (Hz)
%       fmax: maximum frequency (Hz)
%
%         io: overlap   1=none  2=50%
%
%         NW: number of segments  (32 is a typical value)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Output Array
%
%     waterfall_array
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   External Functions
%
%     fix_size
%     waterfall_FFT_time_freq_set
%     waterfall_FFT_core_window
%     mean_removal_Hanning
%     plot_loglin_function_h2
%     xtick_label
%     yaxis_limits_linear
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[waterfall_array]=waterfall_fft_function(amp,dt,tstart,mr,window,fmin,fmax,io,NW)

    fig_num=1;
        
    amp=fix_size(amp);
            
    if(mr==1)
        amp=amp-mean(amp);
    end    
  
    num=length(amp);
            
    mmm=floor(num/NW);

    df=1/(mmm*dt); 
            
    %%%%
               
    ff1=1.e-06;
            
    if(fmin<ff1)
        fmin=ff1;
    end
            
    tmi=tstart;
            
    fprintf('* mmm=%d   \n',mmm);
    fprintf('* dt=%g   \n',dt);
    fprintf('* mmm*dt=%g   \n',mmm*dt);
    fprintf('* df=%g   \n',df);
            
    [mk,freq,time_a,~,NW]=...
        waterfall_FFT_time_freq_set(mmm,NW,dt,df,fmax,tmi,io);

    imag=1;
    reference=1;
            
    [~,store_p,freq_p,max_a,max_f]=...
        waterfall_FFT_core_window(NW,mmm,mk,freq,amp,fmin,io,window,imag,reference);
            
    freq_p=fix_size(freq_p);
            
    if(fmin<=ff1)
        fmin=0;
    end
            
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    disp(' ')   
    disp(' Peak Values ');
    disp(' Time(sec)  Freq(Hz)  Amplitude ');
    for ij=1:NW
        fprintf(' \t  %6.3f  \t  %6.3f  \t  %6.3f \n',time_a(ij),max_f(ij),max_a(ij));
    end

    [maxa,index]=max(max_a);

    ss=sprintf(' Time = %8.4g sec \n Freq = %8.4g Hz \n Amp = %8.4g ',time_a(index),max_f(index),maxa);

    fprintf('\n\n %s \n\n',ss)
           
    nnn=length(time_a)*length(freq_p);

    wdata=zeros(nnn,3);

    k=1;
    for i=1:length(time_a)
        for j=1:length(freq_p)
            wdata(k,1)=[time_a(i)];
            wdata(k,2)=[freq_p(j)];
            wdata(k,3)=[store_p(i,j)];
            k=k+1;
        end    
    end

    waterfall_array=wdata;
            
    if(1)

        figure(fig_num);
        fig_num=fig_num+1;
                
        set(gcf,'renderer','OpenGL' );
                           
        p=waterfall(freq_p,time_a,store_p);

        colormap(hsv(1));
                
        hXLabel=xlabel(' Frequency (Hz)');
        hYLabel=ylabel(' Time (sec)'); 
            
        if(imag<3)
            hZLabel=zlabel(' Magnitude');
        else
            hZLabel=zlabel(' Magnitude (dB)');    
        end
                
        hTitle=title('Waterfall FFT');
        view([-15 70]);   
        % Adjust font
        fz=12;

        set(gca, 'FontName', 'Helvetica')
        set([hTitle, hXLabel, hYLabel, hZLabel], 'FontName', 'AvantGarde')
        set([hXLabel, hYLabel, hZLabel], 'FontSize', fz)
        set(hTitle, 'FontSize', fz, 'FontWeight' , 'bold')
        set(gca,'xlim',[fmin fmax])
        set(gca,'Fontsize',fz); 

    end
            
    if(1)        
        figure(fig_num);
        fig_num=fig_num+1;
        colormap(hsv(128));
        surf(freq_p,time_a,store_p,'edgecolor','none')
        colormap(jet); axis tight;
        view(0,90);
        set(gca,'xlim',[fmin fmax])
        ylabel('Time (sec)'); 
        xlabel('Frequency (Hz)');
        title('Spectrogram');   
    end
            
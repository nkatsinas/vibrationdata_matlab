   
%  smc_s_16_psd_function.m  ver 1.0  by Tom Irvine

function[fig_num]=smc_s_16_psd_function()

       fig_num=1;
        
          smc_s_016=[  20   0.0053
                      150   0.04
                      800   0.04
                     2000   0.0064];
        ppp=smc_s_016;
        ttt='PSD  SMC-S-016 Minimum Workmanship  6.94 GRMS';
        output_name='smc_s_016';
        assignin('base', output_name, smc_s_016);
        fmin=20;
        fmax=2000;
        x_label='Frequency (Hz)';
        y_label='Accel (G^2/Hz)';        
        [fig_num,h2]=plot_PSD_function(fig_num,x_label,y_label,ttt,ppp,fmin,fmax); 
        
        smc_s_016_plus_6dB=[smc_s_016(:,1) smc_s_016(:,2)*3.98];
        output_name='smc_s_016_plus_6dB';
        assignin('base', output_name, smc_s_016_plus_6dB);   
        
        smc_s_016_plus_12dB=[smc_s_016(:,1) smc_s_016(:,2)*15.8];
        output_name='smc_s_016_plus_12dB';
        assignin('base', output_name, smc_s_016_plus_12dB);
        
        smc_s_016_plus_18dB=[smc_s_016(:,1) smc_s_016(:,2)*63.1];
        output_name='smc_s_016_plus_18dB';
        assignin('base', output_name, smc_s_016_plus_18dB);        
        
        out1=sprintf('      Units: freq(Hz) & G^2/Hz \n');
        out2=sprintf('Array Names: smc_s_016 ');
        out3=sprintf('             smc_s_016_plus_6dB');
        out4=sprintf('             smc_s_016_plus_12dB');   
        out5=sprintf('             smc_s_016_plus_18dB');         
        disp(out1);
        disp(out2);
        disp(out3);
        disp(out4);
        disp(out5);
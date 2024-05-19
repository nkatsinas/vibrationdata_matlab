
% read_data_function.m  ver 1.2  by Tom Irvine

function[]=read_data_function(p,n)

    fig_num=200;

    iflag=0;
    
    if(p==1) % Acceleration Time History
     
        xlab='Time (sec)';
        ylab='Accel (G)';
        
        if(n==1)
            load('srs2000G_accel_alt.txt');
            aa=srs2000G_accel_alt;
            
            out1=sprintf('Array Name: srs2000G_accel_1    units: time(sec) & accel(G)');    
            output_name='srs2000G_accel_1';
            assignin('base', output_name, srs2000G_accel_alt);   
            ttt='SRS 2000G Acceleration';
        end
        if(n==2)
            load('srs2000G_accel_2.txt');
            aa=srs2000G_accel_2;
            
            out1=sprintf('Array Name: srs2000G_accel_2    units: time(sec) & accel(G)');    
            output_name='srs2000G_accel_2';
            assignin('base', output_name, srs2000G_accel_2);   
            ttt='SRS 2000G Acceleration';
        end    
        if(n==3)
            load('srs1000G_accel.txt');
            aa=srs1000G_accel;
            
            out1=sprintf('Array Name: srs1000G_accel    units: time(sec) & accel(G)');
            output_name='srs1000G_accel';
            assignin('base', output_name, srs1000G_accel);
            ttt='SRS 1000G Acceleration';
        end
        
        if(n==4)
            load('flight_accel_data.txt');
            aa=flight_accel_data;
            
            out1=sprintf('Array Name:  flight_accel_data    units: time(sec) & accel(G)');
        
            output_name='flight_accel_data';
            assignin('base', output_name, flight_accel_data);  
            ttt='Flight Accelerometer Data, Suborbital Launch Vehicle';
        end
        if(n==5)
            load('solid_motor.dat'); 
            aa=solid_motor;
            
            out1=sprintf('Array Name:  solid_motor    units: time(sec) & accel(G)');
        
            output_name='solid_motor';
            assignin('base', output_name, solid_motor);  
            ttt='Solid Rocket Motor, Resonant Burn, Flight Data';
        end
        if(n==6)
            load('channel.txt');
            aa=channel;
            
            out1=sprintf('Array Name:  channel    units: time(sec) & accel(G)');
        
            output_name='channel';
            assignin('base', output_name, channel);
            ttt='Channel Beam';
        end    
        if(n==7)
            load('drop.txt');
            aa=drop;
            
            out1=sprintf('Array Name:  drop    units: time(sec) & accel(G)');
        
            output_name='drop';
            assignin('base', output_name, drop);
            ttt='Drop Transient, Launch Vehicle';
        end    
        if(n==8)
            load('srb_iea.txt');
            aa=srb_iea;
            
            out1=sprintf('Array Name:  srb_iea   units: time(sec) & accel(G)');
        
            output_name='srb_iea';
            assignin('base', output_name, srb_iea);
            ttt='Space Shuttle SRB FWD IEA Slashdown';
        end    
        if(n==9)
            load('Taurus_auto.dat');
            aa=Taurus_auto;
            
            out1=sprintf('Array Name:  Taurus_auto   units: time(sec) & accel(G)');
        
            output_name='Taurus_auto';
            assignin('base', output_name, Taurus_auto); 
            ttt='Taurus Auto Console 65 mph';
        end  
        if(n==10)
            load('complex_pulse.txt');
            aa=complex_pulse;
            
            out1=sprintf('Array Name:  complex_pulse   units: time(sec) & accel(G)');
        
            output_name='complex_pulse';
            assignin('base', output_name, complex_pulse); 
            ttt='Complex Oscillating Pulse';
        end      
    
        if(n==11)
            load('fwd_dome_ignition.mat');
            aa=fwd_dome_ignition;
            ttt='Fwd Dome Ignition, Solid Motor, Static Fire Test';
    
            out1=sprintf('Array Name:  fwd_dome_ignition   units: time(sec) & accel(G)');
           
            output_name='fwd_dome_ignition';
            assignin('base', output_name, fwd_dome_ignition); 
        end     
        if(n==12)
            load('Orion_PA1_LS51v.mat');
            aa=Orion_PA1_LS51v;
            ttt='Orion Pad Abort Test';
            
            out1=sprintf('Array Name:  Orion_PA1_LS51v   units: time(sec) & accel(G)');
           
            output_name='Orion_PA1_LS51v';
            assignin('base', output_name, Orion_PA1_LS51v); 
        end   
        if(n==13)
            load('bike_1d.mat');
            aa=bike;
            ttt='Bike over Gravel Road';
            
            out1=sprintf('Array Name:  bike   units: time(sec) & accel(G)');
           
            output_name='bike';
            assignin('base', output_name, bike); 
        end          
     
     %%%%   
        
        figure(1);
        plot(aa(:,1),aa(:,2),'b');
        grid on;
        xlabel(xlab);
        ylabel(ylab);
        title(ttt);
        
        if(n==1)
            openfig('srs2000G_synthesized_alt.fig');
        end 
        if(n==2)
            openfig('srs2000G_synthesized_2.fig');
        end     
        if(n==3)
            openfig('srs1000G_synthesized_alt.fig');
        end     
    end
    if(p==2) % Acoustic Time History    
        if(n==1)
            load('tuning_fork.txt');
            aa=tuning_fork;
            ttt='Tuning Fork';
            
            out1=sprintf('Array Name:  tuning_fork   units: time(sec) & unscaled sound pressure');
        
            output_name='tuning_fork';
            assignin('base', output_name, tuning_fork);      
        end    
        if(n==2)
            [aa,ttt,out1]=load_transformer();     
        end   
        if(n==3)
            load('Q400.mat');
            dt=1/8000;
            t=(0:230559)*dt;
            Q400(:,1)=t';        
            aa=Q400;
            ttt='Q400 Turboprop Aircraft';
            
            out1=sprintf('Array Name:  Q400   units: time(sec) & unscaled sound pressure');
           
            output_name='Q400';
            assignin('base', output_name, Q400);  
        
        end   
     %%   
        if(n==4)
            [aa,ttt,out1]=load_apache();
        end  
        
        if(n==5)  
            load('Hoover_dam.mat');
            aa=Hoover_dam;
            ttt='Hoover Dam Generators';
            
            out1=sprintf('Array Name:  Hoover_dam   units: time(sec) & unscaled sound pressure');
        
            output_name='Hoover_dam';
            assignin('base', output_name, Hoover_dam);      
        end  
        if(n==6)
            load('LS009v_sm.txt');
            aa=LS009v_sm;
            iflag=1;
            ttt='LAS Pad One Test LS009v';
            
            out1=sprintf('Array Name:  LS009v_sm   units: time(sec) & sound pressure (psi)');
        
            output_name='LS009v_sm';
            assignin('base', output_name, LS009v_sm);      
        end    
        if(n==7)
            [aa,ttt,out1]=load_versa();
        end   
        if(n==8)
            [aa,ttt,out1]=load_B717();
        end  
        if(n==9)
            [aa,ttt,out1]=load_train_horn();
        end        
        
     %%   
        plot_th(aa,ttt,iflag);  
        
    end
    
    
    if(p==3) % Pyrotechnic Shock Time History
     
        xlab='Time (sec)';
        ylab='Accel (G)';
    
        if(n==1)
                load('rv_separation_raw.txt');
                aa=rv_separation_raw;
                
                out1=sprintf('Array Name:  rv_separation_raw    units: time(sec) & accel(G)');
            
                output_name='rv_separation_raw';
                assignin('base', output_name, rv_separation_raw);  
                ttt='Re-entry Vehicle Separation, LSC, Raw Data';
        end
        if(n==2)
                load('rv_separation_cleaned.txt');
                aa=rv_separation_cleaned;
                
                out1=sprintf('Array Name:  rv_separation_cleaned    units: time(sec) & accel(G)');
            
                output_name='rv_separation_cleaned';
                assignin('base', output_name, rv_separation_cleaned);  
                ttt='Re-entry Vehicle Separation, LSC, Cleaned Data';
        end    
        if(n==3)
                load('flight_stage_sep.txt');
                aa=flight_stage_sep;
                
                out1=sprintf('Array Name:  flight_stage_sep   units: time(sec) & accel(G)');
            
                output_name='flight_stage_sep';
                assignin('base', output_name, flight_stage_sep); 
                ttt='Flight Stage Separation Shock, Suborbital Vehicle';
        end 
        if(n==4)
    
                load('midfield_shock.txt');
                aa=midfield_shock;
                
                out1=sprintf('Array Name:  midfield_shock   units: time(sec) & accel(G)');
            
                output_name='midfield_shock';
                assignin('base', output_name, midfield_shock); 
                ttt='NASA HDBK 7005  Mid-Field Pyrotechnic Shock';
        end  
        if(n==5)
     
                load('pyro_sep_test.mat');
                aa=pyro_sep_test;
                
                out1=sprintf('Array Name:  pyro_sep_test   units: time(sec) & accel(G)');
            
                output_name='pyro_sep_test';
                assignin('base', output_name, pyro_sep_test); 
                ttt='Ground Pyrotechnic Separation Test';
        end  
    
        figure(1);
        plot(aa(:,1),aa(:,2),'b');
        grid on;
        xlabel(xlab);
        ylabel(ylab);
        title(ttt);
    
    end
    
    
    
    if(p==4) % Earthquake Time History
        
        xlab='Time (sec)';
        ylab='Accel (G)';
        
        if(n==1)
            load('elcentro_NS.dat');
            aa=elcentro_NS;
            ttt='El Centro NS';
            
            out1=sprintf('Array Name:  elcentro_NS   units: time(sec) & accel(G)');
        
            output_name='elcentro_NS';
            assignin('base', output_name, elcentro_NS);      
        end  
        if(n==2)
            load('elcentro_EW.dat');
            aa=elcentro_EW;
            ttt='El Centro EW';
            
            out1=sprintf('Array Name:  elcentro_EW   units: time(sec) & accel(G)');
        
            output_name='elcentro_EW';
            assignin('base', output_name, elcentro_EW);      
        end       
        if(n==3)
            load('elcentro_UP.dat');
            aa=elcentro_UP;
            ttt='El Centro UP';
            
            out1=sprintf('Array Name:  elcentro_UP   units: time(sec) & accel(G)');
        
            output_name='elcentro_UP';
            assignin('base', output_name, elcentro_UP);      
        end             
        if(n==4)
            load('elcentro_triaxial.dat');
            aa=elcentro_triaxial;
            ttt='elcentro_triaxial';
            
            out1=sprintf('Array Name:  elcentro_triaxial: NS,EW,UP \n  units: time(sec), accel(G), accel(G), accel(G)');
        
            output_name='elcentro_triaxial';
            assignin('base', output_name, elcentro_triaxial);   
            
            
            figure(1);
            
            subplot(3,1,1);
            plot(aa(:,1),aa(:,2));
            title('El Centro NS, EW, UP');
            ylabel(ylab);
            grid on;
            
            subplot(3,1,2);   
            plot(aa(:,1),aa(:,3));
            ylabel(ylab);         
            grid on;
            
            subplot(3,1,3);    
            plot(aa(:,1),aa(:,4));
            ylabel(ylab);       
            grid on;
            
            xlabel(xlab);
            
        end    
        
        if(n==5)
            load('solomon.txt');
            aa=solomon;
            ttt='Solomon Island Earthquake 2004';
            
            out1=sprintf('Array Name:  solomon   units: time(sec) & unscaled relative displacement');
        
            output_name='solomon';
            assignin('base', output_name, solomon);
            ylab='Unscaled Relative Displacement';
        end        
        if(n==6)
             
            try
                load('zone4_acceleration.txt');
                aa=zone4_acceleration;
            catch
                warndlg('load zone4_acceleration.txt failed');
                return; 
            end
            
            ttt='GR 63 Zone 4 Synthesis  2% Damping';
            
            out1=sprintf('Array Name:  zone4_acceleration   units: time(sec) & accel(G)');
            disp(out1);
            
            output_name='zone4_acceleration';
            assignin('base', output_name, zone4_acceleration);
            ylab='Accel (G)';
            
            load('zone4_SRS.txt');
            
            out1=sprintf('Array Name:  zone4_SRS   units: fn(Hz) & peak accel(G)');
            disp(out1);    
            
            output_name='zone4_SRS';
            assignin('base', output_name, zone4_SRS);
            
    %%%%%        
            
            GR63_zone4=[0.3	0.2;
                   0.6	2.0;
                   2.0	5.0;
                   5.0   5.0;
                  15.0	1.6;
                  50.0	1.6];        
            
            assignin('base', 'GR63_zone4', GR63_zone4 ); 
            out1=sprintf('Array Name: GR63_zone4    units: fn(Hz) & peak accel(G)');             
        end    
        
        
        if(n~=4)
            figure(1);
            
            try
                plot(aa(:,1),aa(:,2));        
            catch
                warndlg(' aa not found ');
                return;
            end
            
            grid on;
            xlabel(xlab);
            ylabel(ylab);
            title(ttt);       
            
            if(n==6)
                
                fn=zone4_SRS(:,1);
                a_pos=zone4_SRS(:,2);
                a_neg=zone4_SRS(:,3);
                
                srs_spec=GR63_zone4;
                
                y_lab='Accel (G)';
    
                
                fmin=0.3;
                fmax=50;
                t_string='SRS GR63 Zone 4 Synthesis  2% damping';  
      
                
                fig_num=2;
                tol=1.5;
                           
                [fig_num,h]=...
                    srs_plot_function_spec_h(fig_num,fn,a_pos,a_neg,t_string,y_lab,fmin,fmax,srs_spec,tol);           
                
            end
            
        end    
    
        
    end
    if(p==5) % Stress Time History
        if(n==1)
            load('ASTM_test.txt');
            aa=ASTM_test;
            
            out1=sprintf('Array Name:  ASTM_test   units: time(sec) & stress');
        
            output_name='ASTM_test';
            assignin('base', output_name, ASTM_test); 
            xlab='Time';
            ylab='Stress';
            ttt='ASTM E 1049 85 - Rainflow Stress';
        end
        
        figure(1);
        plot(aa(:,1),aa(:,2));
        grid on;
        xlabel(xlab);
        ylabel(ylab);
        title(ttt);     
    end    
    if(p==6) % PSD 
        
        x_label='Frequency (Hz)';
        y_label='Accel (G^2/Hz)';
        
        if(n==1)
            load('navmat_spec.psd');
            out1=sprintf('Array Name: navmat_spec    units: freq(Hz) & G^2/Hz');
            ttt='NAVMAT PSD Specification  6.06 GRMS';
            ppp=navmat_spec;
            output_name='navmat_spec';
            assignin('base', output_name, navmat_spec);
            fmin=20;
            fmax=2000;
            [fig_num,h2]=plot_PSD_function(fig_num,x_label,y_label,ttt,ppp,fmin,fmax);
    
        end
        if(n==2)
            smc_s_016=[20           0.0053
                        150         0.04
                        800         0.04
                        2000       0.0064];
            ppp=smc_s_016;
            out1=sprintf('Array Name: smc_s_016    units: freq(Hz) & G^2/Hz');
            ttt='SMC-S-016 Minimum Workmanship PSD  6.9 GRMS';
            output_name='smc_s_016';
            assignin('base', output_name, smc_s_016);
            fmin=20;
            fmax=2000;
            [fig_num,h2]=plot_PSD_function(fig_num,x_label,y_label,ttt,ppp,fmin,fmax);
    
        end   
        if(n==3)
            load('mil_std_1540b.psd');         
            out1=sprintf('Array Name: mil_std_1540b    units: freq(Hz) & G^2/Hz');
            ttt='MIL-STD-1540B Minimum Workmanship PSD  6.14 GRMS';
            ppp=mil_std_1540b;
            output_name='mil_std_1540b';
            assignin('base', output_name, mil_std_1540b);   
            fmin=20;
            fmax=2000;
            [fig_num,h2]=plot_PSD_function(fig_num,x_label,y_label,ttt,ppp,fmin,fmax);        
      
        end
        if(n==4)  
            handles.s= vibrationdata_aircraft_fuselage_psd;                  
            set(handles.s,'Visible','on')
        end
        if(n==5)
            load('HALT_psd.txt');
            out1=sprintf('Array Name: HALT_psd    units: freq(Hz) & G^2/Hz');
            ttt='HALT PSD Sample  16.9 GRMS';
            ppp=HALT_psd;        
            output_name='HALT_psd';
            assignin('base', output_name, HALT_psd); 
            fmin=10;
            fmax=10000;
            [fig_num,h2]=plot_PSD_function(fig_num,x_label,y_label,ttt,ppp,fmin,fmax);        
       
        end    
        if(n==6)
            load('flight_data.psd');
            out1=sprintf('Array Name: flight_data    units: freq(Hz) & G^2/Hz');
            ttt='Flight Data  2.9 GRMS';
            ppp=flight_data;        
            output_name='flight_data';
            assignin('base', output_name, flight_data); 
            fmin=20;
            fmax=2000;
            [fig_num,h2]=plot_PSD_function(fig_num,x_label,y_label,ttt,ppp,fmin,fmax);        
       
        end 
        if(n==7)
            load('test_spec.psd');
            out1=sprintf('Array Name: test_spec    units: freq(Hz) & G^2/Hz');
            ttt='Test Spec  7.8 GRMS';
            ppp=test_spec;        
            output_name='test_spec';
            assignin('base', output_name, test_spec); 
            fmin=20;
            fmax=2000;
            [fig_num,h2]=plot_PSD_function(fig_num,x_label,y_label,ttt,ppp,fmin,fmax);        
       
        end     
        if(n==8)
            load('sub_bulkhead.txt');
            out1=sprintf('Array Name: sub_bulkhead    units: freq(Hz) & G^2/Hz');
            ttt='Suborbital Vehicle Bulkhead  5.93 GRMS';
            ppp=sub_bulkhead;        
            output_name='sub_bulkhead';
            assignin('base', output_name, sub_bulkhead); 
            fmin=20;
            fmax=2000;
            [fig_num,h2]=plot_PSD_function(fig_num,x_label,y_label,ttt,ppp,fmin,fmax);        
       
        end     
        if(n==9)
            load('saturn_v_honeycomb_psd.txt');
            out1=sprintf('Array Name: saturn_v_honeycomb_psd    units: freq(Hz) & G^2/Hz');
            ttt=sprintf('Saturn V Honeycomb Sandwich Test \n One-Third Octave PSD  66.9 GRMS');
            ppp=saturn_v_honeycomb_psd;        
            output_name='saturn_v_honeycomb_psd';
            assignin('base', output_name, saturn_v_honeycomb_psd); 
            fmin=20;
            fmax=2000;
            [fig_num,h2]=plot_PSD_function(fig_num,x_label,y_label,ttt,ppp,fmin,fmax);        
       
        end      
        if(n==10)
            
            NAME='Saturn_V_data.mat';
    
            struct=load(NAME);
            structnames = fieldnames(struct, '-full'); % fields in the struct
    
            k=length(structnames);
    
            for i=1:k
                namevar=strcat('struct.',structnames{i});
                value=eval(namevar);
                assignin('base',structnames{i},value);
                disp(structnames{i})
            end
            
            out1='PSD arrays loaded to Workspace.  Names fxx, where xx is figure number in NASA/TM-2009-215902';
        end
        if(n==11)
            
             disp('Array names:');
             disp(' ');
            
             load('NASA_TN_D1836_psd.mat');
            
             output_name{1}='NASA_TN_D1836_actuator';                        
             output_name{2}='NASA_TN_D1836_aft_bulkheads';                   
             output_name{3}='NASA_TN_D1836_beams';                           
             output_name{4}='NASA_TN_D1836_combustion_chamber_section';      
             output_name{5}='NASA_TN_D1836_fwd_bulkheads';                   
             output_name{6}='NASA_TN_D1836_skin_panels';                     
             output_name{7}='NASA_TN_D1836_skin_stiffners';                  
             output_name{8}='NASA_TN_D1836_turbopump'; 
             
             assignin('base', output_name{1}, NASA_TN_D1836_actuator);                         
             assignin('base', output_name{2}, NASA_TN_D1836_aft_bulkheads);                    
             assignin('base', output_name{3}, NASA_TN_D1836_beams);                            
             assignin('base', output_name{4}, NASA_TN_D1836_combustion_chamber_section);       
             assignin('base', output_name{5}, NASA_TN_D1836_fwd_bulkheads);                    
             assignin('base', output_name{6}, NASA_TN_D1836_skin_panels);                      
             assignin('base', output_name{7}, NASA_TN_D1836_skin_stiffners);                   
             assignin('base', output_name{8}, NASA_TN_D1836_turbopump);          
             
             for i=1:8
                 disp(output_name{i});
             end
             
             disp(' ');
             disp(' Note some coordinates were scaled upward to give overall GRMS in ');
             disp(' agreement with NASA TN-D-1836 overall levels');
             
             fig_num=100;
             fmin=20;
             fmax=2000;
             x_label='Frequency (Hz)';
             y_label='Accel (G^2/Hz)';
             
             ppp=NASA_TN_D1836_actuator;
             [~,grms] = calculate_PSD_slopes(ppp(:,1),ppp(:,2));
             t_string=sprintf('PSD  NASA TN D1836 Actuator  %6.3g GRMS ',grms);
             [fig_num,h2]=plot_loglog_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);         
             
             ppp=NASA_TN_D1836_aft_bulkheads;                   
             [~,grms] = calculate_PSD_slopes(ppp(:,1),ppp(:,2));
             t_string=sprintf('PSD  NASA TN D1836 Aft Bulkheads  %6.3g GRMS ',grms);
             [fig_num,h2]=plot_loglog_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);  
             
             ppp=NASA_TN_D1836_beams;                   
             [~,grms] = calculate_PSD_slopes(ppp(:,1),ppp(:,2));
             t_string=sprintf('PSD  NASA TN D1836 Beams  %6.3g GRMS ',grms);
             [fig_num,h2]=plot_loglog_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);        
             
             ppp=NASA_TN_D1836_combustion_chamber_section;                   
             [~,grms] = calculate_PSD_slopes(ppp(:,1),ppp(:,2));
             t_string=sprintf('PSD  NASA TN D1836 Combustion Chamber Section %6.3g GRMS ',grms);
             [fig_num,h2]=plot_loglog_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax); 
             
             
             ppp=NASA_TN_D1836_fwd_bulkheads;
             [~,grms] = calculate_PSD_slopes(ppp(:,1),ppp(:,2));
             t_string=sprintf('PSD  NASA TN D1836 Fwd Bulkheads  %6.3g GRMS ',grms);
             [fig_num,h2]=plot_loglog_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);         
             
             ppp=NASA_TN_D1836_skin_panels;                   
             [~,grms] = calculate_PSD_slopes(ppp(:,1),ppp(:,2));
             t_string=sprintf('PSD  NASA TN D1836 Skin Panels  %6.3g GRMS ',grms);
             [fig_num,h2]=plot_loglog_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);  
             
             ppp=NASA_TN_D1836_skin_stiffners;                   
             [~,grms] = calculate_PSD_slopes(ppp(:,1),ppp(:,2));
             t_string=sprintf('PSD  NASA TN D1836 Skin Stiffners  %6.3g GRMS ',grms);
             [fig_num,h2]=plot_loglog_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);        
             
             ppp=NASA_TN_D1836_turbopump;                   
             [~,grms] = calculate_PSD_slopes(ppp(:,1),ppp(:,2));
             t_string=sprintf('PSD  NASA TN D1836 Turbopump  %6.3g GRMS ',grms);
             [fig_num,h2]=plot_loglog_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax); 
                     
        end  
        if(n==12)
             vpsd=[  5 	     0.015 
                    40 	     0.015 
                    500 	   0.00015 ];
    
             tpsd=[ 5 	  1.3e-04 
                    10 	  1.3e-04 
                    20 	  6.5e-04 
                    30 	  6.5e-04 
                    78 	  2.0e-05 
                    79 	  1.9e-04 
                    120 	  1.9e-04 
                    500 	  1.0e-05 ];
    
             lpsd=[ 5 	  6.5e-03 
                    20 	  6.5e-03 
                    120 	  2.0e-04 
                    121 	  3.0e-03 
                    200 	  3.0e-03 
                    240 	  1.5e-03 
                    340 	  3.0e-05 
                    500 	  1.5e-04 ];
    
             assignin('base', 'MIL_STD_810H_vertical', vpsd);                         
             assignin('base', 'MIL_STD_810H_transverse', tpsd); 
             assignin('base', 'MIL_STD_810H_longitudinal', lpsd); 
    
             t_string='PSD  MIL-STD-810H Common Carrier';
             leg1='Vertical 1.08 GRMS';
             leg2='Transverse 0.21 GRMS';
             leg3='Longitudinal 0.76 GRMS';
             ppp1=vpsd;
             ppp2=tpsd;
             ppp3=lpsd;
             y_label='Accel (G^2/Hz)';
             x_label='Frequency (Hz)';
             fmin=5;
             fmax=500;
             md=5;
             [fig_num]=plot_loglog_function_md_three(fig_num,x_label,...
                   y_label,t_string,ppp1,ppp2,ppp3,leg1,leg2,leg3,fmin,fmax,md);
    
             ss=sprintf(' MIL_STD_810H_vertical \n MIL_STD_810H_transverse \n MIL_STD_810H_longitudinal');
             msgbox(ss)
        end    
    
    end
    if(p==7) % SPL
        if(n==1)
            load('mil_std_1540c_spl.txt');
            output_name='m1540_spl';
            assignin('base', output_name, mil_std_1540c_spl );      
    
            n_type=1;
        
            f=mil_std_1540c_spl(:,1);
            dB=mil_std_1540c_spl(:,2);
        
            [~]=spl_plot(fig_num,n_type,f,dB);
        
            out1='Array Name: m1540_spl    units: f(Hz) & SPL(dB) ref: 20 micro Pa';
        
        end  
        if(n==2)
            load('avionics_module_liftoff_spl.txt');
            output_name='avionics_module_liftoff_spl';
            assignin('base', output_name, avionics_module_liftoff_spl );      
    
            n_type=1;
        
            f=avionics_module_liftoff_spl(:,1);
            dB=avionics_module_liftoff_spl(:,2);
        
            [~]=spl_plot(fig_num,n_type,f,dB);
        
            out1='Array Name: avionics_module_liftoff_spl    units: f(Hz) & SPL(dB) ref: 20 micro Pa';
        
        end 
    
        if(n==3)  
            load('saturn_v_reference_spl.txt');
            output_name='saturn_v_reference_spl';
            assignin('base', output_name, saturn_v_reference_spl );      
    
            n_type=1;
        
            f=saturn_v_reference_spl(:,1);
            dB=saturn_v_reference_spl(:,2);
        
            [~]=spl_plot(fig_num,n_type,f,dB);
            
            disp('  ');
            disp(' Saturn V (NASA/TM—2009–215902) ');
            disp('  ');    
            
            out1='Array Name: saturn_v_reference_spl    units: f(Hz) & SPL(dB) ref: 20 micro Pa';
        
        end      
        
        if(n==4)  
            load('p31_liftoff_spl.txt');
            output_name='p31_liftoff_spl';
            assignin('base', output_name, p31_liftoff_spl );      
     
            n_type=1;
        
            f=p31_liftoff_spl(:,1);
            dB=p31_liftoff_spl(:,2);
        
            [~]=spl_plot(fig_num,n_type,f,dB);
        
            out1='Array Name: p31_liftoff_spl    units: f(Hz) & SPL(dB) ref: 20 micro Pa';
        
        end  
        if(n==5)  
            load('p32_liftoff_spl.txt');
            output_name='p32_liftoff_spl';
            assignin('base', output_name, p32_liftoff_spl );      
     
            n_type=1;
        
            f=p32_liftoff_spl(:,1);
            dB=p32_liftoff_spl(:,2);
        
            [~]=spl_plot(fig_num,n_type,f,dB);
        
            out1='Array Name: p32_liftoff_spl    units: f(Hz) & SPL(dB) ref: 20 micro Pa';
        
        end     
        if(n==6)  
            
            liftoff_ground_spl=[20 	    152.62 
            25 	    153.62 
          31.5 	    154.62 
            40 	    155.62 
            50 	    156.62 
            63 	    157.62 
            80 	    158.62 
           100 	    159.16 
           125 	    159.53 
           160 	    159.95 
           200 	    160.01 
           250 	     159.7 
           315 	    159.34 
           400 	    158.77 
           500 	    158.05 
           630 	     157.4 
           800 	    156.53 
          1000 	    155.53 
          1250 	    154.57 
          1600 	    153.51 
          2000 	    152.46 
          2500 	    151.34 
          3150 	    150.17 
          4000 	    149.17 
          5000 	    148.43 
          6300 	    147.67 
          8000 	    146.88 
         10000 	    146.15 ];
            
            output_name='liftoff_ground_spl';
            assignin('base', output_name, liftoff_ground_spl );      
     
            n_type=1;
        
            f=liftoff_ground_spl(:,1);
            dB=liftoff_ground_spl(:,2);
        
            [~]=spl_plot(fig_num,n_type,f,dB);
        
            out1='Array Name: liftoff_ground_spl    units: f(Hz) & SPL(dB) ref: 20 micro Pa';
           
        end         
        if(n==7)  
            
            strake_spl=[20 	    158.69 
            25 	    157.88 
          31.5 	    156.68 
            40 	    155.75 
            50 	    154.93 
            63 	    153.72 
            80 	    152.85 
           100 	    151.36 
           125 	    150.26 
           160 	    150.15 
           200 	    149.85 
           250 	    150.11 
           315 	    148.86 
           400 	    147.98 
           500 	    147.04 
           630 	    146.48 
           800 	    145.41 
          1000 	    144.13 
          1250 	    142.68 
          1600 	    137.23 
          2000 	    131.99 
          2500 	    127.56 
          3150 	    122.29 
          4000 	     117.4 
          5000 	    112.44 
          6300 	    107.68 
          8000 	    102.89 
         10000 	    98.103  ];
            
            output_name='strake_spl';
            assignin('base', output_name, strake_spl );      
     
            n_type=1;
        
            f=strake_spl(:,1);
            dB=strake_spl(:,2);
        
            [~]=spl_plot(fig_num,n_type,f,dB);
        
            out1='Array Name: strake_spl    units: f(Hz) & SPL(dB) ref: 20 micro Pa';
           
        end         
        if(n==8)
          NG_PLF_spl=[  25 	   120 
          31.5 	       123 
            40 	     126.5 
            50 	       127 
            63 	       127 
            80 	       128 
           100 	       130 
           125 	       131 
           160 	       131 
           200 	       131 
           250 	       130 
           315 	       128 
           400 	       126 
           500 	       124 
           630 	       122 
           800 	     119.5 
          1000 	     117.8 
          1250 	     116.4 
          1600 	     114.5 
          2000 	     112.5 
          2500 	       111 
          3150 	       109 
          4000 	       108 
          5000 	       107 
          6300 	       106 
          8000 	       104 
         10000 	       102 ];
        
            output_name='NG_PLF_spl';
            assignin('base', output_name, NG_PLF_spl );      
     
            n_type=1;
        
            f=NG_PLF_spl(:,1);
            dB=NG_PLF_spl(:,2);
        
            [~]=spl_plot(fig_num,n_type,f,dB);
        
            out1='Array Name: PLF_spl    units: f(Hz) & SPL(dB) ref: 20 micro Pa';
        end
        
    end
    if(p==8) % SRS
        if(n==1)
            load('crash_srs.txt');
        
            output_name='crash_srs';
            assignin('base', output_name, crash_srs );
        
            fn=crash_srs(:,1);
            accel=crash_srs(:,2);
            y_lab='Accel (G)';
            fmin=10;
            fmax=2000;
            t_string='SRS Crash Hazard Q=10';
    %
            [~]=abs_srs_plot_function(fig_num,fn,accel,t_string,y_lab,fmin,fmax);
        
            out1=sprintf('Array Name: crash_srs    units: fn(Hz) & peak accel(G)');   
        
        end
        if(n==2)
        
            load('vafb_1p.txt');  
            
            output_name='vafb_1p';
            assignin('base', output_name, vafb_1p ); 
        
        
            fn=vafb_1p(:,1);
            accel=vafb_1p(:,2);
            y_lab='Accel (G)';
            fmin=0.1;
            fmax=100;
            t_string='SRS VAFB  1% damping';    
            [~]=abs_srs_plot_function(fig_num,fn,accel,t_string,y_lab,fmin,fmax);    
        
            out1=sprintf('Array Name: vafb_1p    units: fn(Hz) & peak accel(G)');    
        
        end
        if(n==3)
        
            load('Harris_2p.txt');  
            
            output_name='Harris_2p';
            assignin('base', output_name, Harris_2p );    
        
            fn=Harris_2p(:,1);
            accel=Harris_2p(:,2);
            y_lab='Accel (G)';
            fmin=0.1;
            fmax=100;
            t_string='SRS Harris  2% damping';    
            [~]=abs_srs_plot_function(fig_num,fn,accel,t_string,y_lab,fmin,fmax);      
        
            out1=sprintf('Array Name: Harris_2p    units: fn(Hz) & peak accel(G)');    
        
        end
        if(n==4)
            handles.s=IEEE_RSS;    
            set(handles.s,'Visible','on');
        end
        
       
        
        if(n==5)    
            
            GR63_zone4=[0.3	0.2;
                   0.6	2.0;
                   2.0	5.0;
                   5.0   5.0;
                  15.0	1.6;
                  50.0	1.6];        
            
            assignin('base', 'GR63_zone4', GR63_zone4 ); 
        
            fn=GR63_zone4(:,1);
            accel=GR63_zone4(:,2);
            y_lab='Accel (G)';
            fmin=0.3;
            fmax=50;
            t_string='SRS GR63 Zone 4  2% damping';    
            [~]=abs_srs_plot_function(fig_num,fn,accel,t_string,y_lab,fmin,fmax);      
        
            out1=sprintf('Array Name: GR63_zone4    units: fn(Hz) & peak accel(G)');        
        
        end
        if(n==6)
            
            
            GR63_zone3=[0.3	0.2;
                        0.6	2.0;
                        1.0	3.0;
                        5.0 3.0;
                        15.0 1.0;
                        50.0 1.0];
    
                    
            assignin('base', 'GR63_zone3', GR63_zone3 ); 
                       
                    
            fn=GR63_zone3(:,1);
            accel=GR63_zone3(:,2);
            y_lab='Accel (G)';
            fmin=0.3;
            fmax=50;
            t_string='SRS GR63 Zone 3  2% damping';    
            [~]=abs_srs_plot_function(fig_num,fn,accel,t_string,y_lab,fmin,fmax);      
        
            out1=sprintf('Array Name: GR63_zone3    units: fn(Hz) & peak accel(G)');  
                    
                    
        end
        if(n==7)
       
            GR63_zone1_2=[ 0.3	0.2;
                           0.6	2.0;
                           5.0   2.0;
                           15.0	0.6;
                           50.0	0.6];           
            
            assignin('base', 'GR63_zone1_2', GR63_zone1_2 ); 
                   
                       
                       
            fn=GR63_zone1_2(:,1);
            accel=GR63_zone1_2(:,2);
            y_lab='Accel (G)';
            fmin=0.3;
            fmax=50;
            t_string='SRS GR63 Zones 1 & 2  2% damping';    
            [~]=abs_srs_plot_function(fig_num,fn,accel,t_string,y_lab,fmin,fmax);      
        
            out1=sprintf('Array Name: GR63_zone1_2    units: fn(Hz) & peak accel(G)');  
            
        end
        if(n==8)
       
            ANSI_C37_98=[ 1	0.25;
                           4	2.5;
                           16   2.5;
                           33	1.0;
                           50	1.0];           
            
            assignin('base', 'ANSI_C37_98', ANSI_C37_98 ); 
                   
                       
                       
            fn=ANSI_C37_98(:,1);
            accel=ANSI_C37_98(:,2);
            y_lab='Accel (G)';
            fmin=1;
            fmax=50;
            t_string='SRS ANSI C37.98 Normalized  5% damping';    
            [~]=abs_srs_plot_function(fig_num,fn,accel,t_string,y_lab,fmin,fmax);      
        
            out1=sprintf('Array Name: ANSI_C37_98   units: fn(Hz) & peak accel(G)');  
            
        end
        if(n==9)
       
            FJ_source_26grpft=[ 100	  100;
                                4200  16000;
                               10000  16000];           
            
            assignin('base', 'FJ_source_26grpft', FJ_source_26grpft ); 
                   
                       
                       
            fn=FJ_source_26grpft(:,1);
            accel=FJ_source_26grpft(:,2);
            y_lab='Accel (G)';
            fmin=fn(1);
            fmax=fn(end);
            t_string='SRS Frangible Joint Source Shock 26 grains/ft  Q=10';    
            [~]=abs_srs_plot_function(fig_num,fn,accel,t_string,y_lab,fmin,fmax);      
        
            out1=sprintf('Array Name: FJ_source_26grpft   units: fn(Hz) & peak accel(G)');  
            
        end 
        if(n==10)
       
            LSC_source_30grpft=[32	    320;
                                1150	11593;
                                1550	13731;
                                1970	14943;
                                2470	15683;
                                3050	15873;
                                3940	15493;
                                5000	14234];           
            
            assignin('base', 'LSC_source_30grpft',LSC_source_30grpft ); 
                   
                       
                       
            fn=LSC_source_30grpft(:,1);
            accel=LSC_source_30grpft(:,2);
            y_lab='Accel (G)';
            fmin=fn(1);
            fmax=fn(end);
            t_string='SRS  NASA LSC Source Shock 30 grains/ft  Q=10';    
            [~]=abs_srs_plot_function(fig_num,fn,accel,t_string,y_lab,fmin,fmax);      
        
            out1=sprintf('Array Name: LSC_source_30grpft   units: fn(Hz) & peak accel(G)');  
            
        end     
        if(n==11)
       
            generic_min_srs=[10 8; 80 64; 500 64];      
            
            assignin('base', 'generic_min_srs',generic_min_srs );
                      
            fn=generic_min_srs(:,1);
            accel=generic_min_srs(:,2);
            y_lab='Accel (G)';
            fmin=fn(1);
            fmax=fn(end);
            t_string='SRS Q=10  Generic Minimum';    
            [~]=abs_srs_plot_function(fig_num,fn,accel,t_string,y_lab,fmin,fmax);      
        
            out1=sprintf('Array Name: generic_min_srs   units: fn(Hz) & peak accel(G)');  
            
        end     
       
        if(n==12)
       
            fifty_ips=[10  8; 10000 8000];      
            
            assignin('base', 'fifty_ips',fifty_ips );
                      
            fn=fifty_ips(:,1);
            accel=fifty_ips(:,2);
            y_lab='Accel (G)';
            fmin=fn(1);
            fmax=fn(end);
            t_string='SRS Q=10   50 in/sec';    
            [~]=abs_srs_plot_function(fig_num,fn,accel,t_string,y_lab,fmin,fmax);      
        
            out1=sprintf('Array Name: fifty_ips   units: fn(Hz) & peak accel(G)');  
            
        end     
        if(n==13)
       
            Ariane5 =[100          20;
             400         650;
             665         880;
            1000        2000;
           10000        2000];   
            
            assignin('base', 'Ariane5',Ariane5 );
                      
            fn=Ariane5(:,1);
            accel=Ariane5(:,2);
            y_lab='Accel (G)';
            fmin=fn(1);
            fmax=fn(end);
            t_string='SRS Q=10   Ariane 5  Spacecraft Interface';    
            [~]=abs_srs_plot_function(fig_num,fn,accel,t_string,y_lab,fmin,fmax);      
        
            out1=sprintf('Array Name:  Ariane5   units: fn(Hz) & peak accel(G)');  
            
        end  
        if(n==14)
       
            RUAG_3100SX =[100          20;
            1000        1000;
           10000        1000];   
            
            assignin('base', 'RUAG_3100SX',RUAG_3100SX );
                      
            fn=RUAG_3100SX(:,1);
            accel=RUAG_3100SX(:,2);
            y_lab='Accel (G)';
            fmin=fn(1);
            fmax=fn(end);
            t_string='SRS Q=10   RUAG Payload Adapter System 3100SX';    
            [~]=abs_srs_plot_function(fig_num,fn,accel,t_string,y_lab,fmin,fmax);      
        
            out1=sprintf('Array Name:  RUAG_3100SX   units: fn(Hz) & peak accel(G)');  
            
        end        
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if(p==9) % Wavelet Table
        if(n==1)
            load('wavelet_2k.txt');
            out1=sprintf('Array Name: wavelet_2k    units: index f(Hz) Accel(G) NHS Delay(sec)');
        
            output_name='wavelet_2k';
            assignin('base', output_name, wavelet_2k);  
       
        end        
        if(n==2)
            load('wavelet_11k.txt');
            out1=sprintf('Array Name: wavelet_11k    units: index f(Hz) Accel(G) NHS Delay(sec)');
        
            output_name='wavelet_11k';
            assignin('base', output_name, wavelet_11k);  
       
        end        
    end
    
    try
        if(~isempty(out1))
            try
                msgbox(out1);
            catch
            end
        end
    catch
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if(p==10) % Sound Files

        iflag=0;
        
        if(n==1)
            filename='apache.wav';
            [aa,ttt,out1]=load_apache();
            plot_th(aa,ttt,iflag);

        end        
        if(n==2)
            filename='sweep.wav';
        end 
        if(n==3)
            filename='transformer.mp3';
            [aa,ttt,out1]=load_transformer();
            plot_th(aa,ttt,iflag);
        end        
        if(n==4)
            filename= 'tuningfork440.mp3';         
        end 
        if(n==5)
            filename= 'versa.mp3'; 
            [aa,ttt,out1]=load_versa();
            plot_th(aa,ttt,iflag);
        end 
        if(n==6)
            filename='Boeing_717_buzz.mp3';
            [aa,ttt,out1]=load_B717();
            plot_th(aa,ttt,iflag);
        end    
        if(n==7)
            filename='K5LA_Horn_Doppler.mp3';
            [aa,ttt,out1]=load_train_horn();
            plot_th(aa,ttt,iflag);
        end            
        
        [signal, Fs] = audioread(filename);
        player = audioplayer(signal, Fs);
        play(player)
        pause(max(size(signal))/Fs);

        try
            if(~isempty(out1))
                try
                    msgbox(out1);
                catch
                end
            end
        catch
        end
    
    end
    
    if(p==11)
        sound_power_sample=[        10 	    127.16 
          12.5 	    130.33 
            16 	    133.82 
            20 	     136.8 
            25 	    138.41 
          31.5 	    140.08 
            40 	    141.77 
            50 	    143.06 
            63 	     144.4 
            80 	    145.71 
           100 	    146.41 
           125 	    146.99 
           160 	    147.33 
           200 	    147.61 
           250 	    147.61 
           315 	    147.62 
           400 	    147.55 
           500 	    146.91 
           630 	    146.24 
           800 	     145.5 
          1000 	     144.5 
          1250 	     143.5 
          1600 	     142.5 
          2000 	     141.5 ];
      
          fig_num=10;
          [~]=spl_power_bar_alt(fig_num,sound_power_sample(:,1),sound_power_sample(:,2));
      
          assignin('base', 'sound_power_sample',sound_power_sample );     
          fprintf('Array Name:  sound_power_sample   units: fc(Hz) & power (dB) ref: 1 pW \n');
          return;
    end

end

function[]=plot_th(aa,ttt,iflag)
    figure(1);
    plot(aa(:,1),aa(:,2));
    grid on;
    xlabel('Time (sec)');
    if(iflag==0)
        ylabel('Unscaled Sound Pressure');
    else
         ylabel('Sound Pressure (psi)');       
    end
    title(ttt);
end    
function[aa,ttt,out1]=load_apache()

    load('apache.mat');
    aa=apache;
    ttt='Apache Helicopter Flyover';
            
    out1=sprintf('Array Name:  apache   units: time(sec) & unscaled sound pressure');
        
    output_name='apache';
    assignin('base', output_name, apache);   
end
function [aa,ttt,out1]=load_transformer()
    load('transformer.txt');
    aa=transformer;
    ttt='Transformer Magnetostriction';
            
    out1=sprintf('Array Name:  transformer   units: time(sec) & unscaled sound pressure');
        
    output_name='transformer';
    assignin('base', output_name, transformer);  
end  
function[aa,ttt,out1]=load_versa()

    load('versa.mat');
    aa=versa;
    ttt='Versa Side Window Buffet';
            
    out1=sprintf('Array Name:  Versa   units: time(sec) & unscaled sound pressure');
        
    output_name='Versa';
    assignin('base', output_name, versa);   
end
function[aa,ttt,out1]=load_B717()

    load('turbofan_buzz.mat');
    aa=turbofan_buzz;

    ttt='Boeing 717-200 Turbofan Buzz';
            
    out1=sprintf('Array Name:  turbofan_buzz   units: time(sec) & unscaled sound pressure');
        
    output_name='turbofan_buzz';
    assignin('base', output_name, turbofan_buzz);   
end
function[aa,ttt,out1]=load_train_horn()

    load('train_horn.mat');
    aa=train_horn;

    ttt='Train Horn Doppler Shift';
            
    out1=sprintf('Array Name:  train_horn   units: time(sec) & unscaled sound pressure');
        
    output_name='train_horn';
    assignin('base', output_name, train_horn);   
end
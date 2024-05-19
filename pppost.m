app.MsgEditField.Value='b';
            
            xf=round(xf);
            
            pause(0.3);
            progressbar(1);
            
            %       
            % Interpolate the best psd
            %
 
            [xapsdfine]=env_interp_best(nbreak,n_ref,xf,xapsd,fn);
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %
            xapsdfine=fix_size(xapsdfine);
            
            %
            % Calculate the fds of the best psd
            %
            n_ref=length(xapsdfine);
            
            [xfds]=env_fds_batch_alt_apvtp(xapsdfine,n_ref,fn,damp,app.bex,app.T_out,app.iu,app.nmetric);
   
            %
               grms=grms_rec;
               vrms=vrms_rec;
               drms=drms_rec;

            app.MsgEditField.Value='c';

            %
            disp('_____________________________________________________________________');
            %
            disp('Optimum Case');
            disp(' ');
            
            ss=sprintf('Optimum Case ');

            if(app.iu==1)
                fprintf(' Freq(Hz) \t Accel(G^2/Hz)  \n');
                ss2=sprintf(' Freq(Hz) \t Accel(G^2/Hz)  \n');
            end
            if(app.iu==2)
                fprintf(' Freq(Hz) \t Accel((m/sec^2)^2)/Hz)  \n');
                ss2=sprintf(' Freq(Hz) \t Accel((m/sec^2)^2)/Hz  \n');
            end
            if(app.iu==3)
                fprintf(' Freq(Hz) \t Pressure(psi^2/Hz)  \n');
                ss2=sprintf(' Freq(Hz) \t Pressure(psi^2/Hz)  \n');
            end

            ss=sprintf('%s\n\n%s',ss,ss2);

            nbreak=length(app.power_spectral_density(:,1));
            
            for i=1:nbreak
                out1=sprintf(' %6.1f \t%8.4g  ',app.power_spectral_density(i,1),app.power_spectral_density(i,2));
                disp(out1);

                ss=sprintf('%s\n%s',ss,out1);
            end

            [max_sss,min_fff]=freq_slope_check(app.power_spectral_density(:,1),app.power_spectral_density(:,2));
                
            fprintf('\n max slope=%8.4g  min freq sep=%8.4g\n\n',max_sss,min_fff);
            
            %
            fprintf(' drms=%10.4g  vrms=%10.4g  grms=%10.4g \n',drms,vrms,grms);
            %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %

            fn=fn(1:n_ref);
            xfds=xfds(1:n_ref,:);
            fds_ref=fds_ref(1:n_ref,:);
            
            for i=1:length(damp)    
            %
                xx=zeros(n_ref,1);
                ff=zeros(n_ref,1);
            %        
                for k=1:n_ref
                    xx(k)=xfds(k,i);
                    ff(k)=fds_ref(k,i);
                end
            %
                xx=fix_size(xx);
                ff=fix_size(ff);
                fn=fix_size(fn);
            %
                fds1=[fn xx];
                fds2=[fn ff];
            %
            end    

            if(app.nmetric<=3)
                ylab='Accel (G^2/Hz)';
                t_string=sprintf(' Power Spectral Density  Overall Level = %6.3g GRMS ',grms);
                s4=sprintf(' Overall Level = %6.3g GRMS ',grms);
            else 
                if(app.iu==3)
                    ylab='Pressure (psi^2/Hz)';   
                    t_string=sprintf(' Power Spectral Density  Overall Level = %6.3g psi rms ',grms);
                    s4=sprintf(' Overall Level = %6.3g psi rms ',grms);
                else
                    ylab='Pressure (Pa^2/Hz)';   
                    t_string=sprintf(' Power Spectral Density  Overall Level = %6.3g Pa rms ',grms);
                    s4=sprintf(' Overall Level = %6.3g Pa rms ',grms);
                end    
            end  

             app.MsgEditField.Value='0';

            try
                 app.MsgEditField.Value='1';
            
                x_label=sprintf(' Frequency (Hz)');
                
                [fig_num,h2]=plot_PSD_function(fig_num,x_label,ylab,t_string,app.power_spectral_density,app.fmin,app.fmax);
                   
                %
                app.MsgEditField.Value='2';
                
                app.MsgEditField.Value='3';

            catch
                app.MsgEditField.Value='psd plot failed'           
                % warndlg('psd plot failed')
                return;
            end

            app.MsgEditField.Value='5';

            try
                    app.MsgEditField.Value='6';

                    %
                    x_label=sprintf(' Natural Frequency (Hz)');
                    ylab='Damage Index';
                    %
                    disp(' ');
                    disp(' FDS output arrays: ');
                    disp('   ');
                    
                    uiu=(length(unique(damp))+length(unique(app.bex))); 

                    fn=fn(1:n_ref);
                    xfds=xfds(1:n_ref,:);
                    fds_ref=fds_ref(1:n_ref,:);
                    
                    for i=1:length(damp)            
                    %
                            xx=zeros(n_ref,1);
                            ff=zeros(n_ref,1);
                    %        
                            for k=1:n_ref
                                xx(k)=xfds(k,i);
                                ff(k)=fds_ref(k,i);
                            end
                    %
                            xx=fix_size(xx);
                            ff=fix_size(ff);
                            fn=fix_size(fn);
                    %
                            fds1=[fn xx];
                            fds2=[fn ff];
                    %
                    %%%%%%%%%%%
                    %
                            sbex=sprintf('%g',app.bex(i));
                            sbex=strrep(sbex, '.', 'p');
                            output_name=sprintf('psd_fds_Q%g_b%s',app.Q(i),sbex);
                            output_name2=sprintf('    %s',output_name);
                            disp(output_name2);
                            assignin('base', output_name, fds1);
                    %
                    %%%%%%%%%%%
                    %       
                            output_name_ref=sprintf('time_history_fds_Q%g_b%s',app.Q(i),sbex);
                            assignin('base', output_name_ref, fds2);
                    
                            fprintf('    %s\n',output_name_ref);        
                    %
                    %%%%%%%%%%%
                    %
                            if(uiu~=4)
                                leg_a=sprintf('PSD Envelope');
                                leg_b=sprintf('Measured Data');
                    %
                                [fig_num,h3]=...
                                plot_fds_two_h2(fig_num,x_label,ylab,fds1,fds2,leg_a,leg_b,app.Q(i),app.bex(i),app.iu,app.nmetric);    
                            
                            end
                    %                        
                    end    
   
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %
                    
                    if(uiu==4)
                       
                        [fig_num,h3]=fds_plot_2x2_alt_h2(fig_num,app.Q,app.bex,fn,ff,xx,xfds,fds_ref,app.nmetric,app.iu);
                
                        [fig_num,h4]=psd_fds_plot_2x2_alt_h2(fig_num,app.Q,app.bex,fn,xfds,...
                                                             fds_ref,app.nmetric,app.iu,t_string,...
                                                             app.power_spectral_density,app.fmin,app.fmax);    
                    end

            catch
                warndlg('uiu 4 failed');
                return;
            end

            %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %
            app.MsgEditField.Value='7';

            try
            
                disp(' ');
                disp(' The fatigue damage spectra is calculated from the amplitude (peak-valley)/2 ');
                            
                output_name=strtrim(app.OptimizedPSDOuputNameEditField.Value);
                
                if(isempty(output_name))
                    warndlg('Enter output PSD name');
                    return;
                end 

                ss=sprintf('%s\n\n Duration = %g sec \n\n PSD output name: \n %s \n',ss,app.T_out,output_name);
            
            catch
                warndlg('ref 10:  failed ');
                return;
            end

            app.MsgEditField.Value='8';

            try
                    ss=sprintf('%s\n FDS of PSD Envelope \n',ss);
        
                    for i=1:length(damp)    
                    %
                            xx=zeros(n_ref,1);
                            ff=zeros(n_ref,1);
                    %        
                            for k=1:n_ref
                                xx(k)=xfds(k,i);
                                ff(k)=fds_ref(k,i);
                            end
                    %
                            xx=fix_size(xx);
                            ff=fix_size(ff);
                            fn=fix_size(fn);
                    %
                            fds1=[fn xx];
                            fds2=[fn ff];
                    %
                    %%%%%%%%%%%
                    %
                            sbex=sprintf('%g',app.bex(i));
                            sbex=strrep(sbex, '.', 'p');
                            output_name=sprintf('psd_fds_Q%g_b%s',app.Q(i),sbex);
                            output_name2=sprintf('    %s',output_name);
                            disp(output_name2);
                            assignin('base', output_name, fds1);
                            ss=sprintf('%s\n%s',ss,output_name2);
                    end

            catch
                warndlg('fds assignin failed');
                return;
            end
            
            app.MsgEditField.Value='9';

            try
                app.ResultsTextArea.Value=ss;
                app.ResultsTextArea.Visible='on';
                app.ResultsTextAreaLabel.Visible='on';
                app.ExportOutputsButton.Visible='on';
            catch
                warndlg('Text Area failed');
                return;
            end

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            try
                app.big=FDS_PSD;
            catch
                warndlg('app.big failed');
            end

            sx=strtrim(app.OptimizedPSDOuputNameEditField.Value);

            disp(' ');
            disp(' Optimized PSD output name: ');
            fprintf('  %s \n',sx);
            try
                assignin('base',sx,app.power_spectral_density);
                ss=sprintf('Output PSD array: %s',sx);
                msgbox(ss)
            catch
                warndlg('PSD save failed');
            end  

            sy=strtrim(app.OptimizedSineOuputNameEditField.Value);

            disp(' ');
            disp(' Optimized PSD output name: ');
            fprintf('  %s \n',sy);
            try
                assignin('base',sy,sine);
                ss=sprintf('Output sine array: %s',sy);
                msgbox(ss)
            catch
                warndlg('Sine save failed');
            end   

            % ChangeRows(app);

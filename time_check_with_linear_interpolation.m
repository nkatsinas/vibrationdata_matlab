
%   time_check_with_linear_interpolation.m  ver 1.3  by Tom Irvine

function[THM,iflag]=time_check_with_linear_interpolation(THM)

    iflag=1;

    tstart=THM(1,1);
    tend=THM(end,1);
            
    tdif=diff(THM(:,1));
    min_dt=min(tdif);
    max_dt=max(tdif);

    % fprintf('\n\n min_dt=%8.4g  max_dt=%8.4g \n\n',min_dt,max_dt);

    if(min_dt==0)       
        
                answer = questdlg('Possible significant digit problem. Fix time step?', ...
                	'Time Step', ...
                	'Yes','No','Yes');
                % Handle response
                switch answer
                    case 'No'
                        iflag=999;
                        warndlg('No output generated');
                        return;
                    case 'Yes'
                        
                        dt=mean(tdif);
                        dlgtitle=sprintf('SR=%8.4g Hz',1/dt);
                        
                        nsr=sprintf('%8.4g',1/dt);
                        
                        prompt = {'Enter New Sample Rate (Hz)'};
                        dims = [1 60];
                        definput = {nsr};
                        new_sr = inputdlg(prompt,dlgtitle,dims,definput);
                       
                        new_sr=strtrim(char(new_sr));
                        
                        new_sr=str2num(new_sr);
                        
                        try
                            new_dt=1/new_sr;
                        catch
                            iflag=999;
                            warndlg('New Sample Rate error');
                            return;
                        end
                        
                        try
                            
                            x=((1:length(THM(:,1)))-1)*new_dt;
                            THM(:,1)=x;
                            
   
                        catch
                            
                            warndlg('Interpolation failed');
                            iflag=999;
                            return;
                        end

                        try
                            dlgtitle=sprintf('Save');
                            prompt = {'Enter corrected time history output name'};
                            dims = [1 60];
                            definput = {''};
                            name = char(inputdlg(prompt,dlgtitle,dims,definput));
                            assignin('base',name,THM);
                            return;
                        catch

                        end
                end
    end    

    %%%%%%%%%%%%%%%

    ratio=abs((max_dt-min_dt)/max_dt);
       
    % fprintf('\n ratio=%8.4g \n',ratio)

    if(ratio>0.05)

                answer = questdlg('Time step must be constant. Perform linear interpolation?', ...
                	'Time Step', ...
                	'Yes','No','Yes');
                % Handle response
                switch answer
                    case 'No'
                        iflag=999;
                        warndlg('No output generated');
                        return;
                    case 'Yes'
                        
                        mmm=mode(tdif);
                        
                        mode_dt=mmm(1);
                        
                        dlgtitle=sprintf('SR_mode=%8.4g Hz',1/mode_dt);
                        
                        nsr=sprintf('%8.4g',2/mode_dt);
                        
                        prompt = {'Enter New Sample Rate (Hz)'};
                        dims = [1 60];
                        definput = {nsr};
                        new_sr = inputdlg(prompt,dlgtitle,dims,definput);
                       
                        new_sr=strtrim(char(new_sr));
                        
                        new_sr=str2num(new_sr);
                        
                        try
                            new_dt=1/new_sr;
                        catch
                            iflag=999;
                            warndlg('New Sample Rate error');
                            return;
                        end
                        
                        n=floor((tend-tstart)/new_dt);
                        
                        upper=(n*new_dt)+tstart;
                        
                        fprintf('\n sr=%8.4g  dt=%8.4g  n=%d  tstart=%8.4g  upper=%8.4g \n',new_sr,new_dt,n,tstart,upper);
                        
                        x=THM(:,1);
                        y=THM(:,2);
                        
                        try
                            
                            %   This method is more reliable than Matlab's interp1

                            [xi,yi]=linear_interpolation(x,y,new_dt);   
                            
                            xi=fix_size(xi);
                            yi=fix_size(yi);
                            
                            THM=[xi yi];                            
                            
                        catch
                            
                            warndlg('Interpolation failed');
                            iflag=999;
                            return;
                        end

                        try
                            dlgtitle=sprintf('Save');
                            prompt = {'Enter corrected time history output name'};
                            dims = [1 60];
                            definput = {''};
                            name = char(inputdlg(prompt,dlgtitle,dims,definput));
                            try
                                assignin('base',name,THM);
                            catch
                                warndlg('assignin failed');
                            end
                        catch

                        end
                end
    end
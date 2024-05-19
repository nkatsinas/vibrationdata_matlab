
%
%  update_1D_array.m  ver 1.0  by Tom Irvine
%

function[cell_array]=update_1D_array()

            vars = evalin('base', 'whos');
            cell_array = cell(size(vars));
            for i=1:length(vars)
                cell_array{i} ='999';
                vars(i).name;
                if(contains(vars(i).name,'myHandle') || ...
                   contains(vars(i).name,'vname_list') || ...
                   contains(vars(i).name,'Dirlik_N') || ...
                   strcmp(vars(i).name,'mode_1') || ...
                   strcmp(vars(i).name,'mode_2') || ...
                   strcmp(vars(i).name,'mode_3') || ...              
                   strcmp(vars(i).name,'mode_4') || ...
                   strcmp(vars(i).name,'mode_5') || ... 
                   strcmp(vars(i).name,'mode_6') || ...           
                   strcmp(vars(i).name,'two_dof_ModeShapes') || ...
                   strcmp(vars(i).name,'stress_th') || ...
                   contains(vars(i).name,'amp_cycles') || ...
                   contains(vars(i).name,'range_cycles') || ...
                   contains(vars(i).name,'amp_mean_cycles') || ...
                   contains(vars(i).name,'smc_s_016') || ...
                   contains(vars(i).name,'crash_srs') ||...
                   contains(vars(i).name,'range_cycles_max_min'))          

                   cell_array{i} ='999';
                else    
                    try
               
                        TTT=evalin('base',vars(i).name);
                        sz=size(TTT);


                        if(sz(1)>=2 && sz(2)==1)
                            cell_array{i} = vars(i).name;
                        else
                            cell_array{i} ='999';
                        end    

                    catch
                        % disp('evalin failed');
                    end
                end    
            end

            try
                for i=length(vars):-1:1
                    if(contains(cell_array{i},'999'))
                        cell_array(i,:)=[];
                    end
                end    
            catch
                disp(' 999 failure');
            end
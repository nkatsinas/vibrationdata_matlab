
%
%  update_spl_3.m  ver 1.0  by Tom Irvine
%

function[cell_array]=update_spl_3()

            vars = evalin('base', 'whos');
            cell_array = cell(size(vars));

            for i=1:length(vars)

                vars(i).name;

                cell_array{i} ='999';
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
                   contains(vars(i).name,'range_cycles_max_min')|| ...
                   strcmp(vars(i).name,'two_dof_mass') ||...
                   strcmp(vars(i).name,'point_mass_matrix') ||...
                   contains(vars(i).name,'Hanning') ||...
                   strcmp(vars(i).name,'sz'))       
                   cell_array{i} ='999';
                else    

                    ggg=evalin('base',vars(i).name);
                    sz=size(ggg);
                    mint2=0;
                    try
                        mint2=min(ggg(:,2));
                    catch
                    end

                    try
                        % disp('oct test');
                        [ioct_flag,~]=octave_test(ggg);
    
                        if(sz(2)==3 && mint2>=0 && ioct_flag==1)
                            cell_array{i} = vars(i).name;
                        else
                            cell_array{i} ='999';
                        end
                    catch
                        % warndlg('octave test failed')
                    end    
                end    
            end
            length(vars);
            for i=length(vars):-1:1
                if(contains(cell_array{i},'999'))
                    cell_array(i,:)=[];
                end
            end

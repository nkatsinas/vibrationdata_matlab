hFig = figure(1);
                xwidth=900;
                ywidth=400;
                set(gcf,'PaperPositionMode','auto')
                set(hFig, 'Position', [0 0 xwidth ywidth])
                table1 = uitable;
                set(table1,'ColumnWidth',{27})
               
                columnname =   {'Mode','Natural Freq (Hz)','Participation Factor','Modal Mass Ratio',...
                       'Phase Speed (ft/sec)','Wavenumber (rad/ft)'};
                columnformat = {'numeric', 'numeric','numeric','numeric','numeric','numeric'};
                columneditable = [false false false false false false];  
                columnwidth = {50,110,130,110,120,120};
                
                for i=1:n
                    kw=app.omegan(i)/cp(i);
                    emm(i)=app.part(i)^2/mass;
    
                    data_s{i,1}=['<html><tr><td width=9999 align=center>',sprintf('%d',i)];
                    data_s{i,2}=['<html><tr><td width=9999 align=center>',sprintf('%8.4g',app.fn(i))];
                    data_s{i,3}=['<html><tr><td width=9999 align=center>',sprintf('%7.3g',app.part(i))];
                    data_s{i,4}=['<html><tr><td width=9999 align=center>',sprintf('%7.3f',emm(i))];
                    data_s{i,5}=['<html><tr><td width=9999 align=center>',sprintf('%7.4g',cp(i))];
                    data_s{i,6}=['<html><tr><td width=9999 align=center>',sprintf('%7.3g',kw)];
                end

                try
                    table1 = uitable('Units','normalized','Position',...
                            [0 0 1 1], 'Data', data_s,... 
                            'ColumnName', columnname,...
                            'ColumnFormat', columnformat,...
                            'ColumnEditable', columneditable,...
                            'ColumnWidth',columnwidth,...
                            'RowName',[]);

                    table1.FontSize = 9;

                catch
                end
function varargout = plot_multiple_curves_alt(varargin)
% PLOT_MULTIPLE_CURVES_ALT MATLAB code for plot_multiple_curves_alt.fig
%      PLOT_MULTIPLE_CURVES_ALT, by itself, creates a new PLOT_MULTIPLE_CURVES_ALT or raises the existing
%      singleton*.
%
%      H = PLOT_MULTIPLE_CURVES_ALT returns the handle to a new PLOT_MULTIPLE_CURVES_ALT or the handle to
%      the existing singleton*.
%
%      PLOT_MULTIPLE_CURVES_ALT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOT_MULTIPLE_CURVES_ALT.M with the given input arguments.
%
%      PLOT_MULTIPLE_CURVES_ALT('Property','Value',...) creates a new PLOT_MULTIPLE_CURVES_ALT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plot_multiple_curves_alt_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plot_multiple_curves_alt_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plot_multiple_curves_alt

% Last Modified by GUIDE v2.5 24-Feb-2021 08:49:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plot_multiple_curves_alt_OpeningFcn, ...
                   'gui_OutputFcn',  @plot_multiple_curves_alt_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before plot_multiple_curves_alt is made visible.
function plot_multiple_curves_alt_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plot_multiple_curves_alt (see VARARGIN)

% Choose default command line output for plot_multiple_curves_alt
handles.output = hObject;

listbox_xplotlimits_Callback(hObject, eventdata, handles);
listbox_yplotlimits_Callback(hObject, eventdata, handles);
listbox_num_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes plot_multiple_curves_alt wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plot_multiple_curves_alt_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%

try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end    


disp(' ');
disp(' * * * * * * ');
disp(' ');

N=get(handles.listbox_num,'Value');
 
A=get(handles.uitable_data,'Data');

k=1;

for i=1:N
    array{i}=A{k}; k=k+1;
end
for i=1:N
    leg{i}=A{k}; k=k+1;
end
for i=1:N
    pp{i}=A{k}; k=k+1;
end
 
 
%
nx_type=get(handles.listbox_xaxis,'Value');
ny_type=get(handles.listbox_yaxis,'Value');
ng=get(handles.listbox_grid,'Value');
nx_limits=get(handles.listbox_xplotlimits,'Value');
ny_limits=get(handles.listbox_yplotlimits,'Value');
fig_num=get(handles.listbox_figure_number,'Value');
nlegend=get(handles.listbox_legend,'Value');

ttt=get(handles.edit_title,'String');
xxx=get(handles.edit_xlabel,'String');
yyy=get(handles.edit_ylabel,'String');

ttt=strrep(ttt,'_',' ');

%

cmap(1,:)=[0 0 0.8];        % dark blue
cmap(2,:)=[0.8 0 0];        % red
cmap(3,:)=[0 0 0];          % black
cmap(4,:)=[0.6 0.3 0];      % brown
cmap(5,:)=[0 0.5 0.5];      % teal
cmap(6,:)=[1 0.5 0];        % orange
cmap(7,:)=[0.5 0.5 0];      % olive
cmap(8,:)=[0.13 0.55 0.13]; % forest green  
cmap(9,:)=[0.5 0 0];        % maroon
cmap(10,:)=[0.5 0.5 0.5 ];  % grey
cmap(11,:)=[1. 0.4 0.4];    % pink-orange
cmap(12,:)=[0.5 0.5 1];     % lavender
cmap(13,:)=[0.05 0.7 1.];   % light blue
cmap(14,:)=[0  0.8 0.4 ];   % green
cmap(15,:)=[1 0.84 0];      % gold
cmap(16,:)=[0 0.8 0.8];     % turquoise

for i=17:N
    cmap(i,:)=[rand() rand() rand()];
end

%%%%

xmin=1.0e+90;
xmax=-xmin;


yymin=1.0e+90;
yymax=-yymin;


iflag=0;

hp=figure(fig_num);
hold on;

for i=1:N

    leg{i}=strrep(leg{i},'_',' ');
    
    if(pp{i}==1)
        
        iflag=1;
        
        try
            THM=evalin('base',array{i});
            
            if(nlegend==3)
                plot(THM(:,1),THM(:,2),'Color',cmap(i,:));
            else  
                plot(THM(:,1),THM(:,2),'Color',cmap(i,:),'DisplayName',leg{i});
            end 
            
            try
                if(THM(1,1)<xmin)
                    xmin=THM(1,1);
                end
                if(THM(end,1)>xmax)
                    xmax=THM(end,1);
                end
            
                maxy=max(THM(:,2));
                miny=min(THM(:,2));            
            
                if(miny<yymin)
                    yymin=miny;
                end
                if(maxy>yymax)
                    yymax=maxy;
                end
            catch
            end
            
        catch
            array{i}
            try
                size(THM)
            catch
            end
            out1=sprintf(' plot failed:  %s   ',array{i});
            warndlg(out1);
            return;
            
        end
        
    end

end

title(ttt);
xlabel(xxx);
ylabel(yyy);

if(nx_limits==1 ) % automatic
    
else    % manual
    
    xmin=str2num(get(handles.edit_xmin,'String'));
    xmax=str2num(get(handles.edit_xmax,'String'));
            
    xlim([xmin xmax]);    
    
end 

if(nx_type==2)  % log
        
    try
            [xtt,xTT,iflag]=xtick_label(xmin,xmax);
            
            if(iflag==1)
                set(gca,'xtick',xtt);
                set(gca,'XTickLabel',xTT);
                fmin=min(xtt);
                fmax=max(xtt);
                xlim([fmin,fmax]);                
            end
    catch    
    end
        
end


if(ny_limits==2 ) % manual 

    ymin=str2num(get(handles.edit_ymin,'String'));
    ymax=str2num(get(handles.edit_ymax,'String'));
    
    ylim([ymin ymax]);
    
end    

grid off;
%


if(ng==1)
    
    grid on;
    set(gca, 'xminorgrid', 'on', 'yminorgrid', 'on')
    
    if(nx_type==1 && ny_type==1)
        set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','lin','YScale','lin');
    end 
    if(nx_type==1 && ny_type==2)
        set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','lin','YScale','log');
    end
    if(nx_type==2 && ny_type==1)
        set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log','YScale','lin');
    end
    if(nx_type==2 && ny_type==2)
        set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log','YScale','log');
    end    
    
end    
if(ng==2)
    
    grid on;
    set(gca, 'xminorgrid', 'on', 'yminorgrid', 'on')
 
 
    if(nx_type==1 && ny_type==1)
        set(gca,'MinorGridLineStyle','none','GridLineStyle','-','XScale','lin','YScale','lin');
    end    
    if(nx_type==1 && ny_type==2)
        set(gca,'MinorGridLineStyle','none','GridLineStyle','-','XScale','lin','YScale','log');
    end
    if(nx_type==2 && ny_type==1)
        set(gca,'MinorGridLineStyle','none','GridLineStyle','-','XScale','log','YScale','lin');
    end
    if(nx_type==2 && ny_type==2)
        set(gca,'MinorGridLineStyle','none','GridLineStyle','-','XScale','log','YScale','log');
    end    
    
end
if(ng==3)

    if(nx_type==1 && ny_type==1)
        set(gca,'MinorGridLineStyle','none','GridLineStyle','none','XScale','lin','YScale','lin');
    end
    if(nx_type==1 && ny_type==2)
        set(gca,'MinorGridLineStyle','none','GridLineStyle','none','XScale','lin','YScale','log');
    end
    if(nx_type==2 && ny_type==1)
        set(gca,'MinorGridLineStyle','none','GridLineStyle','none','XScale','log','YScale','lin');
    end
    if(nx_type==2 && ny_type==2)
        set(gca,'MinorGridLineStyle','none','GridLineStyle','none','XScale','log','YScale','log');
    end    
    
end

if(ny_limits==1 && ny_type==2)  % automatic log
        
    try
        [ymin,ymax]=ytick_log(yymin,yymax);
        ylim([ymin,ymax]);
    catch    
    end    
end    


if(nlegend<=2)
    legend show;
    if(nlegend==2)
        legend('location','eastoutside')
        set(hp, 'Position', [0 0 1400 900]);
        set(gca,'Fontsize',20);
    end    
end 


hold off;




% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(plot_multiple_curves_alt);

% --- Executes on selection change in listbox_num.
function listbox_num_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num


Nrows=get(handles.listbox_num,'Value');
Ncolumns=3;
 
A=get(handles.uitable_data,'Data');
 
sz=size(A);
Arows=sz(1);
 
for i=1:Nrows
    for j=1:(Ncolumns-1)
        data_s{i,j}='';
    end 
    data_s{i,3}=true;
end    
 
if(~isempty(A))
    
    M=min([ Arows Nrows ]);
    
    for i=1:M
        for j=1:(Ncolumns-1)
            data_s{i,j}=A{i,j};
        end   
        data_s{i,3}=true;
    end   
 
end

try
    columnformat={[],[],'logical'};
    set(handles.uitable_data,'Data',data_s,'ColumnFormat',columnformat)
catch
end


% --- Executes during object creation, after setting all properties.
function listbox_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xlabel_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xlabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xlabel as text
%        str2double(get(hObject,'String')) returns contents of edit_xlabel as a double


% --- Executes during object creation, after setting all properties.
function edit_xlabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xlabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_xplotlimits.
function listbox_xplotlimits_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_xplotlimits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_xplotlimits contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_xplotlimits


n=get(handles.listbox_xplotlimits,'Value');

if(n==1)
    set(handles.edit_xmin,'Enable','off');
    set(handles.edit_xmax,'Enable','off'); 
else
    set(handles.edit_xmin,'Enable','on');
    set(handles.edit_xmax,'Enable','on');  
end

% --- Executes during object creation, after setting all properties.
function listbox_xplotlimits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_xplotlimits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_xaxis.
function listbox_xaxis_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_xaxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_xaxis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_xaxis


% --- Executes during object creation, after setting all properties.
function listbox_xaxis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_xaxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xmin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xmin as text
%        str2double(get(hObject,'String')) returns contents of edit_xmin as a double


% --- Executes during object creation, after setting all properties.
function edit_xmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xmax as text
%        str2double(get(hObject,'String')) returns contents of edit_xmax as a double


% --- Executes during object creation, after setting all properties.
function edit_xmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_delete.
function pushbutton_delete_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Nrows=get(handles.listbox_num,'Value');
 
Ncolumns=3;
 
data_s=get(handles.uitable_data,'Data');

nd=get(handles.listbox_delete,'Value');
 

if(nd<=Nrows)
    
    temp=data_s;
    clear data_s;
    
    
    
    for i=1:(nd-1)
        for j=1:(Ncolumns-1)
            try
                data_s{i,j}=temp{i,j};
            catch
            end
            
        end    
    end  
    
    for i=(nd+1):Nrows
        for j=1:(Ncolumns-1)
            try
                data_s{i-1,j}=temp{i,j};
            catch
            end
            
        end    
    end      
    
    Nrows=Nrows-1;
    set(handles.listbox_num,'Value',Nrows);    
end
 
try
    columnformat={[],[],'logical'};
    set(handles.uitable_data,'Data',data_s,'ColumnFormat',columnformat)
catch
end

 
set(handles.listbox_num,'Value',Nrows);



% --- Executes on selection change in listbox_delete.
function listbox_delete_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_delete contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_delete


% --- Executes during object creation, after setting all properties.
function listbox_delete_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function[data_s]=clear_data_s(Nrows)

for i=1:Nrows
        data_s{i,1}='';
        data_s{i,2}='';
        data_s{i,3}=false;        
end


% --- Executes on button press in pushbutton_reset.
function pushbutton_reset_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Nrows=get(handles.listbox_num,'Value');


[data_s]=clear_data_s(Nrows);

set(handles.uitable_data,'Data',data_s);

pushbutton_change(hObject, eventdata, handles);

listbox_num_Callback(hObject, eventdata, handles);


% --- Executes on button press in pushbutton_save_plot_file.
function pushbutton_save_plot_file_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_plot_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    data=get(handles.uitable_data,'Data');
    PlotMultAlt.data=data;
catch
end

try
    num=get(handles.listbox_num,'Value');
    PlotMultAlt.num=num;
catch
end

try
    xaxis=get(handles.listbox_xaxis,'Value');
    PlotMultAlt.xaxis=xaxis;
catch
end

try
    xplotlimits=get(handles.listbox_xplotlimits,'Value');
    PlotMultAlt.xplotlimits=xplotlimits;
catch
end

try
    yaxis=get(handles.listbox_yaxis,'Value');
    PlotMultAlt.yaxis=yaxis;
catch
end

try
    yplotlimits=get(handles.listbox_yplotlimits,'Value');
    PlotMultAlt.yplotlimits=yplotlimits;
catch
end



try
    legend=get(handles.listbox_legend,'Value');
    PlotMultAlt.legend=legend;
catch
end

try
    grid=get(handles.listbox_grid,'Value');
    PlotMultAlt.grid=grid;
catch
end

try
    figure_number=get(handles.listbox_figure_number,'Value');
    PlotMultAlt.figure_number=figure_number;
catch
end

try
    xmin=get(handles.edit_xmin,'String');
    PlotMultAlt.xmin=xmin;
catch
end

try
    xmax=get(handles.edit_xmax,'String');
    PlotMultAlt.xmax=xmax;
catch
end

try
    ymin=get(handles.edit_ymin,'String');
    PlotMultAlt.ymin=ymin;
catch
end

try
    ymax=get(handles.edit_ymax,'String');
    PlotMultAlt.ymax=ymax;
catch
end

try
    title=get(handles.edit_title,'String');
    PlotMultAlt.title=title;
catch
end

% % %
 
structnames = fieldnames(PlotMultAlt, '-full'); % fields in the struct
 
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);
 
    try
 
        save(elk, 'PlotMultAlt'); 
 
    catch
        warndlg('Save error');
        return;
    end
 




% --- Executes on button press in pushbutton_load_plot_file.
function pushbutton_load_plot_file_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_plot_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%%%%%%%%%%%%%%%%%%%%%

[filename, pathname] = uigetfile('*.mat', 'Select plot save file');
 
NAME = [pathname,filename];
 
struct=load(NAME);
structnames = fieldnames(struct, '-full'); % fields in the struct
 
k=length(structnames);
 
for i=1:k
    namevar=strcat('struct.',structnames{i});
    value=eval(namevar);
    assignin('base',structnames{i},value);
end
 
% struct
 
try
 
   PlotMultAlt=evalin('base','PlotMultAlt');
 
catch
   warndlg(' evalin failed ');
   return;
end
 
%%%%%%%%%%%%%%%%%%%%%

try
    data=PlotMultAlt.data; 
    set(handles.uitable_data,'Data',data);
catch
end

try
    num=PlotMultAlt.num;    
    set(handles.listbox_num,'Value',num);
catch
end


try
    xaxis=PlotMultAlt.xaxis;    
    set(handles.listbox_xaxis,'Value',xaxis);
catch
end

try
    xplotlimits=PlotMultAlt.xplotlimits;    
    set(handles.listbox_xplotlimits,'Value',xplotlimits);
catch
end

try
    yaxis=PlotMultAlt.yaxis;    
    set(handles.listbox_yaxis,'Value',yaxis);
catch
end

try
    yplotlimits=PlotMultAlt.yplotlimits;    
    set(handles.listbox_yplotlimits,'Value',yplotlimits);
catch
end


try
    legend=PlotMultAlt.legend; 
    set(handles.listbox_legend,'Value',legend);
catch
end

try
    grid=PlotMultAlt.grid; 
    set(handles.listbox_grid,'Value',grid);
catch
end

try
    figure_number=PlotMultAlt.figure_number;    
    set(handles.listbox_figure_number,'Value',figure_number);
catch
end



try
    xmin=PlotMultAlt.xmin;    
    set(handles.edit_xmin,'String',xmin);
catch
end

try
    xmax=PlotMultAlt.xmax;    
    set(handles.edit_xmax,'String',xmax);
catch
end

try
    ymin=PlotMultAlt.ymin;    
    set(handles.edit_ymin,'String',ymin);
catch
end

try
    ymax=PlotMultAlt.ymax;    
    set(handles.edit_ymax,'String',ymax);
catch
end

try
    title=PlotMultAlt.title;    
    set(handles.edit_title,'String',title);
catch
end


%%%%%%%%%%%%%%%%%%%%%

listbox_xplotlimits_Callback(hObject, eventdata, handles);
listbox_yplotlimits_Callback(hObject, eventdata, handles);

%%%%%%%%%%%%%%%%%%%%%



function edit_ylabel_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ylabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ylabel as text
%        str2double(get(hObject,'String')) returns contents of edit_ylabel as a double


% --- Executes during object creation, after setting all properties.
function edit_ylabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ylabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_yaxis.
function listbox_yaxis_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_yaxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_yaxis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_yaxis


% --- Executes during object creation, after setting all properties.
function listbox_yaxis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_yaxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_yplotlimits.
function listbox_yplotlimits_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_yplotlimits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_yplotlimits contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_yplotlimits

n=get(handles.listbox_yplotlimits,'Value');

if(n==1)
    set(handles.edit_ymin,'Enable','off');
    set(handles.edit_ymax,'Enable','off'); 
else
    set(handles.edit_ymin,'Enable','on');
    set(handles.edit_ymax,'Enable','on');  
end


% --- Executes during object creation, after setting all properties.
function listbox_yplotlimits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_yplotlimits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ymin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ymin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ymin as text
%        str2double(get(hObject,'String')) returns contents of edit_ymin as a double


% --- Executes during object creation, after setting all properties.
function edit_ymin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ymin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ymax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ymax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ymax as text
%        str2double(get(hObject,'String')) returns contents of edit_ymax as a double


% --- Executes during object creation, after setting all properties.
function edit_ymax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ymax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_title_Callback(hObject, eventdata, handles)
% hObject    handle to edit_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_title as text
%        str2double(get(hObject,'String')) returns contents of edit_title as a double


% --- Executes during object creation, after setting all properties.
function edit_title_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_legend.
function listbox_legend_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_legend contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_legend


% --- Executes during object creation, after setting all properties.
function listbox_legend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_grid.
function listbox_grid_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_grid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_grid contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_grid


% --- Executes during object creation, after setting all properties.
function listbox_grid_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_grid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_figure_number.
function listbox_figure_number_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_figure_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_figure_number contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_figure_number


% --- Executes during object creation, after setting all properties.
function listbox_figure_number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_figure_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_legend.
function listbox11_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_legend contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_legend


% --- Executes during object creation, after setting all properties.
function listbox11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_old_Callback(hObject, eventdata, handles)
% hObject    handle to edit_old (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_old as text
%        str2double(get(hObject,'String')) returns contents of edit_old as a double


% --- Executes during object creation, after setting all properties.
function edit_old_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_old (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_new_Callback(hObject, eventdata, handles)
% hObject    handle to edit_new (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_new as text
%        str2double(get(hObject,'String')) returns contents of edit_new as a double


% --- Executes during object creation, after setting all properties.
function edit_new_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_new (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_replace.
function pushbutton_replace_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_replace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Nrows=get(handles.listbox_num,'Value');
Ncolumns=3;
 
A=get(handles.uitable_data,'Data');

old=get(handles.edit_old,'String');
new=get(handles.edit_new,'String');
 
for i=1:Nrows
    for j=1:(Ncolumns-1)
        A{i,j}=strrep(A{i,j},old,new);
    end 
end    



try
    columnformat={[],[],'logical'};
    set(handles.uitable_data,'Data',A,'ColumnFormat',columnformat)
catch
end

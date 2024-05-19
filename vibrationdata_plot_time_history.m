function varargout = vibrationdata_plot_time_history(varargin)
% VIBRATIONDATA_PLOT_TIME_HISTORY MATLAB code for vibrationdata_plot_time_history.fig
%      VIBRATIONDATA_PLOT_TIME_HISTORY, by itself, creates a new VIBRATIONDATA_PLOT_TIME_HISTORY or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_PLOT_TIME_HISTORY returns the handle to a new VIBRATIONDATA_PLOT_TIME_HISTORY or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_PLOT_TIME_HISTORY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_PLOT_TIME_HISTORY.M with the given input arguments.
%
%      VIBRATIONDATA_PLOT_TIME_HISTORY('Property','Value',...) creates a new VIBRATIONDATA_PLOT_TIME_HISTORY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_plot_time_history_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_plot_time_history_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_plot_time_history

% Last Modified by GUIDE v2.5 12-Aug-2021 19:30:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_plot_time_history_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_plot_time_history_OutputFcn, ...
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


% --- Executes just before vibrationdata_plot_time_history is made visible.
function vibrationdata_plot_time_history_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_plot_time_history (see VARARGIN)

% Choose default command line output for vibrationdata_plot_time_history
handles.output = hObject;


set(handles.listbox_method,'Value',1);
set(handles.listbox_time_limits,'Value',1);

listbox_time_limits_Callback(hObject, eventdata, handles);
listbox_amp_limits_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_plot_time_history wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_plot_time_history_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_plot_time_history);


% --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%

Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );



for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end


%%%%%%%%%%%

fig_num=get(handles.listbox_figure_number,'Value');

nplot=get(handles.listbox_plot_files,'Value');

fsize=8+get(handles.listbox_fsize,'Value');

LWI=get(handles.listbox_linewidth,'Value');

LLL=[0.5 0.8 1.0 1.5 2.0];

LW=LLL(LWI);


k=get(handles.listbox_method,'Value');
 
if(k==1)
  FS=get(handles.edit_input_array,'String');
  THM=evalin('base',FS);   
else
  THM=getappdata(0,'THM');
end

title_label=get(handles.edit_title,'String');
xaxis_label=get(handles.edit_xaxis_label,'String');
yaxis_label=get(handles.edit_yaxis_label,'String');


title_label=strrep(title_label,'_',' ');

mark=get(handles.listbox_marker,'Value');

sz=size(THM);
namp=sz(2)-1;


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

for i=17:namp
    cmap(i,:)=[rand() rand() rand()];
end


try

    hp=figure(fig_num);
    hold on;

    if(namp==1)
        if(mark==2)
            plot(THM(:,1),THM(:,2),'linewidth',LW);
        else
            plot(THM(:,1),THM(:,2),'-o');        
        end
        
    else
         
        for i=1:namp
            ss=sprintf('Amp %d',i);
            plot(THM(:,1),THM(:,i+1),'Color',cmap(i,:),'DisplayName',ss);
        end  
         legend show; 
    end    
    title(title_label );
    xlabel(xaxis_label);
    ylabel(yaxis_label);
    grid on;

catch
    LW
    size(THM)
    warndlg('Plot failed');
    return;
    
end

m=get(handles.listbox_time_limits,'Value');

if(m==2)
    t1=str2num(get(handles.edit_start_time,'String'));
    t2=str2num(get(handles.edit_end_time,'String'));
    xlim([t1 t2]);
end

n=get(handles.listbox_amp_limits,'Value');

if(n==2)
    y1=str2num(get(handles.edit_ymin,'String'));
    y2=str2num(get(handles.edit_ymax,'String'));
    
    ymin=min([y1 y2]);
    ymax=max([y1 y2]);
    
    ylim([ymin ymax]);
end

set(gca,'Fontsize',fsize);


if(nplot==1)

    psave=get(handles.listbox_psave,'Value');
    
    if(psave==1 || psave==2 || psave==3)
    
%%%%    % put twice
%%%%    if(nlegend==1)
%%%%        legend show;
%%%%    end  
    
        pname=get(handles.edit_png_name,'String'); 
            
        if(psave==1)
            print(hp,pname,'-dmeta','-r300');        
        end
        if(psave==2)        
            print(hp,pname,'-dpng','-r300');        
        end
        if(psave==3)        
            print(hp,pname,'-dsvg');        
        end         
    
        out1=sprintf('Plot file: %s exported to hard drive',pname);
        msgbox(out1);
   
    end
else
    pname='a.emf';    
    print(hp,pname,'-dmeta','-r300');
    out1=sprintf('Plot file:  %s',pname');
%    disp(out1);
    msgbox(out1);
end

set(hp, 'Position', [0 0 1000 450]);
hold off;

function edit_yaxis_label_Callback(hObject, eventdata, handles)
% hObject    handle to edit_yaxis_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_yaxis_label as text
%        str2double(get(hObject,'String')) returns contents of edit_yaxis_label as a double


% --- Executes during object creation, after setting all properties.
function edit_yaxis_label_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_yaxis_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xaxis_label_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xaxis_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xaxis_label as text
%        str2double(get(hObject,'String')) returns contents of edit_xaxis_label as a double


% --- Executes during object creation, after setting all properties.
function edit_xaxis_label_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xaxis_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method

n=get(hObject,'Value');

set(handles.edit_input_array,'String',' ');

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');

if(n==1)
   set(handles.edit_input_array,'enable','on') 
else
   set(handles.edit_input_array,'enable','off')
   set(handles.text_input_array_name,'Visible','off');
   set(handles.edit_input_array,'Visible','off');
   
   [filename, pathname] = uigetfile('*.*');
   filename = fullfile(pathname, filename);
   fid = fopen(filename,'r');
   THM = fscanf(fid,'%g %g',[2 inf]);
   THM=THM';
    
   setappdata(0,'THM',THM);
end



% --- Executes during object creation, after setting all properties.
function listbox_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_input_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
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



function edit_start_time_Callback(hObject, eventdata, handles)
% hObject    handle to edit_start_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_start_time as text
%        str2double(get(hObject,'String')) returns contents of edit_start_time as a double


% --- Executes during object creation, after setting all properties.
function edit_start_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_start_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_end_time_Callback(hObject, eventdata, handles)
% hObject    handle to edit_end_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_end_time as text
%        str2double(get(hObject,'String')) returns contents of edit_end_time as a double


% --- Executes during object creation, after setting all properties.
function edit_end_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_end_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_time_limits.
function listbox_time_limits_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_time_limits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_time_limits contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_time_limits

n=get(handles.listbox_time_limits,'Value');

if(n==1) % auto
    set(handles.text_start_time,'Visible','off');
    set(handles.text_end_time,'Visible','off');
    set(handles.edit_start_time,'Visible','off');
    set(handles.edit_end_time,'Visible','off');    
else % manual
    set(handles.text_start_time,'Visible','on');
    set(handles.text_end_time,'Visible','on');
    set(handles.edit_start_time,'Visible','on');
    set(handles.edit_end_time,'Visible','on');      
end



% --- Executes during object creation, after setting all properties.
function listbox_time_limits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_time_limits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_amp_limits.
function listbox_amp_limits_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_amp_limits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_amp_limits contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_amp_limits

n=get(handles.listbox_amp_limits,'Value');

if(n==1) % auto
    set(handles.text_max,'Visible','off');
    set(handles.text_min,'Visible','off');
    set(handles.edit_ymin,'Visible','off');
    set(handles.edit_ymax,'Visible','off');    
else % manual
    set(handles.text_max,'Visible','on');
    set(handles.text_min,'Visible','on');
    set(handles.edit_ymin,'Visible','on');
    set(handles.edit_ymax,'Visible','on');      
end




% --- Executes during object creation, after setting all properties.
function listbox_amp_limits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_amp_limits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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


% --- Executes on selection change in listbox_plot_files.
function listbox_plot_files_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_plot_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_plot_files contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_plot_files


n=get(handles.listbox_plot_files,'Value');

if(n==1)
    set(handles.text_pfn,'Visible','on');
    set(handles.edit_png_name,'Visible','on');
 
else
    set(handles.text_pfn,'Visible','off');
    set(handles.edit_png_name,'Visible','off');  
   
end

% --- Executes during object creation, after setting all properties.
function listbox_plot_files_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_plot_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_png_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_png_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_png_name as text
%        str2double(get(hObject,'String')) returns contents of edit_png_name as a double


% --- Executes during object creation, after setting all properties.
function edit_png_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_png_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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


% --- Executes on selection change in listbox_fsize.
function listbox_fsize_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_fsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_fsize contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_fsize


% --- Executes during object creation, after setting all properties.
function listbox_fsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_fsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_linewidth.
function listbox_linewidth_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_linewidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_linewidth contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_linewidth


% --- Executes during object creation, after setting all properties.
function listbox_linewidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_linewidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_psave.
function listbox_psave_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_psave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_psave contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_psave


% --- Executes during object creation, after setting all properties.
function listbox_psave_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_psave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_marker.
function listbox_marker_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_marker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_marker contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_marker


% --- Executes during object creation, after setting all properties.
function listbox_marker_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_marker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig_num=get(handles.listbox_figure_number,'Value');

Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );



for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end


%%%%%%%%%%%

fig_num=get(handles.listbox_figure_number,'Value');

k=get(handles.listbox_method,'Value');
 
if(k==1)
  FS=get(handles.edit_input_array,'String');
  THM=evalin('base',FS);   
else
  THM=getappdata(0,'THM');
end

figure(fig_num);
plot(THM(:,1));
grid on;

m=get(handles.listbox_time_limits,'Value');

if(m==2)
    t1=str2num(get(handles.edit_start_time,'String'));
    t2=str2num(get(handles.edit_end_time,'String'));
    ylim([t1 t2]);
end

xaxis_label=get(handles.edit_xaxis_label,'String');

ylabel(xaxis_label);
xlabel('Index');

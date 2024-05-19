function varargout = vibrationdata_power_transmissibility_TH(varargin)
% VIBRATIONDATA_POWER_TRANSMISSIBILITY_TH MATLAB code for vibrationdata_power_transmissibility_TH.fig
%      VIBRATIONDATA_POWER_TRANSMISSIBILITY_TH, by itself, creates a new VIBRATIONDATA_POWER_TRANSMISSIBILITY_TH or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_POWER_TRANSMISSIBILITY_TH returns the handle to a new VIBRATIONDATA_POWER_TRANSMISSIBILITY_TH or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_POWER_TRANSMISSIBILITY_TH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_POWER_TRANSMISSIBILITY_TH.M with the given input arguments.
%
%      VIBRATIONDATA_POWER_TRANSMISSIBILITY_TH('Property','Value',...) creates a new VIBRATIONDATA_POWER_TRANSMISSIBILITY_TH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_power_transmissibility_TH_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_power_transmissibility_TH_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_power_transmissibility_TH

% Last Modified by GUIDE v2.5 23-Oct-2020 10:10:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_power_transmissibility_TH_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_power_transmissibility_TH_OutputFcn, ...
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


% --- Executes just before vibrationdata_power_transmissibility_TH is made visible.
function vibrationdata_power_transmissibility_TH_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_power_transmissibility_TH (see VARARGIN)

% Choose default command line output for vibrationdata_power_transmissibility_TH
handles.output = hObject;




set(handles.pushbutton_calculate,'Enable','off');
set(handles.pushbutton_view_options,'Enable','off');
set(handles.listbox_numrows,'Enable','off');
set(handles.listbox_numrows,'Visible','off');
set(handles.text_select_option,'Visible','off');

mn_common(hObject, eventdata, handles);

set(handles.uitable_advise,'Visible','off');


%% set(handles.listbox_export_plot,'Value',2);



listbox_export_plot_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_power_transmissibility_TH wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function mn_common(hObject, eventdata, handles)


set(handles.text_IAN_1,'Visible','off');
set(handles.text_IAN_2,'Visible','off');
set(handles.edit_input_array_1,'Visible','off');
set(handles.edit_input_array_2,'Visible','off');
set(handles.edit_input_array_1,'String','');
set(handles.edit_input_array_2,'String','');


n=get(handles.listbox_format,'Value');

if(n==1)
    set(handles.text_IAN_1,'Visible','on');
    set(handles.edit_input_array_1,'Visible','on');
    set(handles.text_IAN_1,'String','Input Array Name');
end
if(n==2)
    set(handles.text_IAN_1,'Visible','on');
    set(handles.text_IAN_2,'Visible','on');
    set(handles.edit_input_array_1,'Visible','on');
    set(handles.edit_input_array_2,'Visible','on');
    set(handles.text_IAN_1,'String','Input Array Name');
    set(handles.text_IAN_2,'String','Response Array Name');    
end


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_power_transmissibility_TH_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox3.
function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox3


% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox4.
function listbox4_Callback(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox4


% --- Executes during object creation, after setting all properties.
function listbox4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox5.
function listbox5_Callback(hObject, eventdata, handles)
% hObject    handle to listbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox5


% --- Executes during object creation, after setting all properties.
function listbox5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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


set(handles.pushbutton_calculate,'Enable','off');
set(handles.pushbutton_view_options,'Enable','off');
set(handles.listbox_numrows,'Enable','off');
set(handles.listbox_numrows,'Visible','off');
set(handles.text_select_option,'Visible','off');
set(handles.uitable_advise,'Visible','off');

n=get(hObject,'Value');

set(handles.pushbutton_view_options,'Enable','on');


set(handles.edit_output_array,'Enable','off');


set(handles.pushbutton_save,'Enable','off');

set(handles.edit_input_array_1,'String',' ');

set(handles.text_IAN_1,'Visible','on');
set(handles.edit_input_array_1,'Visible','on');

if(n==1)
   set(handles.edit_input_array_1,'enable','on') 
else
   set(handles.edit_input_array_1,'enable','off')
   set(handles.text_IAN_1,'Visible','off');
   set(handles.edit_input_array_1,'Visible','off');   
   
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


% --- Executes on selection change in listbox_input_type.
function listbox_input_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_input_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_input_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_input_type


% --- Executes during object creation, after setting all properties.
function listbox_input_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_input_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ylabel_input_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ylabel_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ylabel_input as text
%        str2double(get(hObject,'String')) returns contents of edit_ylabel_input as a double


% --- Executes during object creation, after setting all properties.
function edit_ylabel_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ylabel_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_input_array_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_mean_removal.
function listbox_mean_removal_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_mean_removal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_mean_removal contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_mean_removal


% --- Executes during object creation, after setting all properties.
function listbox_mean_removal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_mean_removal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_window.
function listbox_window_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_window contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_window


% --- Executes during object creation, after setting all properties.
function listbox_window_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_view_options.
function pushbutton_view_options_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view_options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB

disp('  ');
disp(' * * * * * * * * * * ');
disp('  ');

n=get(handles.listbox_format,'Value');

set(handles.pushbutton_calculate,'Enable','on');
set(handles.listbox_numrows,'Enable','on');
set(handles.uitable_advise,'Visible','on');
set(handles.listbox_numrows,'Visible','on');
set(handles.text_select_option,'Visible','on');

set(handles.listbox_numrows,'String',' ');


try

%
   FS=get(handles.edit_input_array_1,'String');
   THM_1=evalin('base',FS); 
%
   if(n==1)
      t1=THM_1(:,1);
      t2=t1;      
       a=THM_1(:,2);
       b=THM_1(:,3);
   else
%     
       FS=get(handles.edit_input_array_2,'String');
       THM_2=evalin('base',FS);
%     
       t1=THM_1(:,1);
       t2=THM_2(:,1);
       a=THM_1(:,2);
       b=THM_2(:,2);       
   end
   
   iflag=1;

catch
   
    warndlg(' Input Array Error ');
    return;
    
end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n1=length(t1);
n2=length(t2);

if(n1~=n2)
    warndlg('Time histories have different lengths');
    return;
end

dur1=t1(n1)-t1(1);
dur2=t2(n2)-t2(1);

if( abs(dur2-dur1)>(dur1/1000))
    warndlg('Time histories have different durations');
    return;  
end

t=t1;

setappdata(0,'t',t);
setappdata(0,'a',a);
setappdata(0,'b',b);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[num_seg,time_seg,samples_seg,data,dt,rows]=advise_function(t);

cn={' No. of Segments ',' Samples/Segments ',' Time/Segment (sec) ',' df (Hz) ',' dof '};

set(handles.uitable_advise,'Data',data,'ColumnWidth','auto','ColumnName',cn);

set(handles.listbox_numrows,'String',rows,'Enable','on','Visible','on');


%%%%%%%%%

istart=1;
iend=length(t);

setappdata(0,'n1',istart);
setappdata(0,'n2',iend);
setappdata(0,'dt',dt);
setappdata(0,'num_seg',num_seg);
setappdata(0,'samples_seg',samples_seg);

set(handles.pushbutton_calculate,'Enable','on');

cn={'No. of Segments ','Samples/Segments','Time/Segment (sec)','df (Hz)','dof'};

set(handles.uitable_advise,'Data',data,'ColumnWidth','auto','ColumnName',cn);

setappdata(0,'advise_data',data);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_power_transmissibility_TH);

% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_save,'Value');

if(n==1)
    data=getappdata(0,'trans');
end
if(n==2)
    data=getappdata(0,'power_trans');
end
if(n==3)
    data=getappdata(0,'PSD_A');
end
if(n==4)
    data=getappdata(0,'PSD_B');
end

output_name=strtrim(get(handles.edit_output_array,'String'));
assignin('base', output_name, data);

msgbox('Save Complete'); 

%%% set(handles.pushbutton_convert_octave,'Enable','on');



function edit_output_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_numrows.
function listbox_numrows_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_numrows (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_numrows contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_numrows


% --- Executes during object creation, after setting all properties.
function listbox_numrows_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_numrows (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end   


disp('  ');
disp(' * * * * * * * * * * ');
disp('  ');

fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_fmax,'String'));


if(isempty(fmin))
    warndlg('Enter minimum frequency');
    return;
end
if(isempty(fmax))
    warndlg('Enter maxmimum frequency');
    return;
end


set(handles.pushbutton_save,'Enable','On');    
set(handles.edit_output_array,'Enable','On'); 


t=getappdata(0,'t');
a=getappdata(0,'a');
b=getappdata(0,'b');

n=length(t);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%(' Number of   Samples per   Time per        df               ');
%%(' Segments     Segment      Segment(sec)   (Hz)     dof     ');

dt=getappdata(0,'dt');

nv=get(handles.listbox_numrows,'Value');
num_seg=getappdata(0,'num_seg');
samples_seg=getappdata(0,'samples_seg');

NW=num_seg(nv);

mmm=samples_seg(nv);

df=1/(mmm*dt);
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mr_choice=get(handles.listbox_mean_removal,'Value');

h_choice =get(handles.listbox_window,'Value');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[~,a_full,a_rms]=psd_core(mmm,NW,mr_choice,h_choice,a,df);
[freq,b_full,b_rms]=psd_core(mmm,NW,mr_choice,h_choice,b,df);
%

   clear power_spectral_density;
%
    freq=fix_size(freq);
    a_full=fix_size(a_full);
    b_full=fix_size(b_full);    
%
    a_power_spectral_density=[freq a_full]; 
    b_power_spectral_density=[freq b_full];     
    
    setappdata(0,'PSD_A',a_power_spectral_density);
    setappdata(0,'PSD_B',b_power_spectral_density);
    
%
%    [~,fmax]=find_max(power_spectral_density);
%


%    out5 = sprintf(' Peak occurs at %10.5g Hz \n',fmax);
%    disp(out5)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

YS_input=get(handles.edit_ylabel_input,'String');
YS_response=get(handles.edit_ylabel_response,'String');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

m_input=get(handles.listbox_input_type,'Value');
m_response=get(handles.listbox_response_type,'Value');


fig_num=1;
xlabel2='Time (sec)';

data1=[t a];
data2=[t b];



if(YS_input=='G')
    t_string1=sprintf(' Input %7.3g GRMS',a_rms);
else
    t_string1=sprintf(' Input %7.3g %s RMS',a_rms,YS_input);
end

if(YS_response=='G')
    t_string2=sprintf(' Response %7.3g GRMS',b_rms);   
else
    t_string2=sprintf(' Response %7.3g %s RMS',b_rms,YS_response);    
end



if(m_input==1)
    ylabel1=sprintf('Accel (%s)',YS_input);
    ylabel11=sprintf('Accel (%s^2/Hz)',YS_input);    
end
if(m_input==2)
    ylabel1=sprintf('Vel (%s)',YS_input);
    ylabel11=sprintf('Vel (%s^2/Hz)',YS_input);    
end
if(m_input==3)
    ylabel1=sprintf('Disp (%s)',YS_input);
    ylabel11=sprintf('Disp (%s^2/Hz)',YS_input);     
end
if(m_input==4)
    ylabel1=sprintf('Force (%s)',YS_input);
    ylabel11=sprintf('Force (%s^2/Hz)',YS_input);     
end
if(m_input==5)
    ylabel1=sprintf('Pressure (%s)',YS_input);
    ylabel11=sprintf('Pressure (%s^2/Hz)',YS_input);     
end
if(m_input==6)
    ylabel1=sprintf('(%s)',YS_input);
    ylabel11=sprintf('(%s^2/Hz)',YS_input);     
end

if(m_response==1)
    ylabel2=sprintf('Accel (%s)',YS_response);
    ylabel22=sprintf('Accel (%s^2/Hz)',YS_response);    
end
if(m_response==2)
    ylabel2=sprintf('Vel (%s)',YS_response);
    ylabel22=sprintf('Vel (%s^2/Hz)',YS_response);      
end
if(m_response==3)
    ylabel2=sprintf('Disp (%s)',YS_response);
    ylabel22=sprintf('Disp (%s^2/Hz)',YS_response);      
end
if(m_response==4)
    ylabel2=sprintf('Force (%s)',YS_response);
    ylabel22=sprintf('Force (%s^2/Hz)',YS_response);
end
if(m_response==5)
    ylabel2=sprintf('Pressure (%s)',YS_response);
    ylabel22=sprintf('Pressure (%s^2/Hz)',YS_response);
end
if(m_response==6)
    ylabel2=sprintf('(%s)',YS_response);
    ylabel22=sprintf('(%s^2/Hz)',YS_response);    
end

%%%%%%%%%%%%%%%%%%%%

[fig_num]=subplots_two_linlin_two_titles_scale(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2);


    disp(' ');
    disp(' Overall Levels ');
    disp(' ');
    disp(t_string1);
    disp(t_string2);    
    disp(' ');
    
%%%%%%%%%%%%%%%%%%%%

md=5;
x_label='Frequency (Hz)';

ppp1=a_power_spectral_density;
ppp2=b_power_spectral_density;

leg1=t_string1;
leg2=t_string2;

k = strfind(YS_input,'/');

if(m_input==m_response)
    m=m_input;
    
    if(m==1)
        y_label=sprintf('Accel (%s^2/Hz)',YS_input);
        if( k>=1)
            y_label=sprintf('Accel ((%s)^2/Hz)',YS_input);        
        end
    end
    if(m==2)
        y_label=sprintf('Vel ((%s)^2/Hz)',YS_input);
        if( k>=1)
            y_label=sprintf('Vel ((%s)^2/Hz)',YS_input);        
        end    
    end
    if(m==3)
        y_label=sprintf('Disp (%s^2/Hz)',YS_input);
    end
    if(m==4)
        y_label=sprintf('Force (%s^2/Hz)',YS_input);
    end
    if(m==5)
        y_label=sprintf('Pressure (%s^2/Hz)',YS_input);
        if( k>=1)
            y_label=sprintf('Pressure ((%s)^2/Hz)',YS_input);        
        end     
    end
    if(m==6)
        y_label=sprintf('(%s^2/Hz)',YS_input);
    end

    t_string='Power Spectral Density';


    [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);
    
else
    nfont=10;
    data1=ppp1;
    data2=ppp2;
    
    t_string1=sprintf('PSD  %s ',t_string1);
    t_string2=sprintf('PSD  %s ',t_string2);
    
    [fig_num,h2]=subplots_two_loglog_1x2_xlim_h2(fig_num,xlabel2,...
          ylabel11,ylabel22,data1,data2,t_string1,t_string2,nfont,fmin,fmax);
end
           
%%%%%%%%%%%%%%%%%%%%

%%  a_power_spectral_density=[freq a_full]; 
%%  b_power_spectral_density=[freq b_full]; 


ptrans=b_full./a_full;


power_trans=[freq ptrans];
setappdata(0,'power_trans',power_trans); 


trans(:,1)=freq;

for i=1:length(freq)
   trans(i,2)=sqrt(ptrans(i)); 
end

setappdata(0,'trans',trans);

ppp=power_trans;

t_string='Power Transmissibility';

y_label=sprintf('Trans (%s^2/%s^2)',YS_response,YS_input);

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

    [aaa,fmax]=find_max(power_trans);
%
    out5 = sprintf(' Peak occurs is %7.3g (%s^2/%s^2) at %10.5g Hz \n',aaa,YS_input,YS_response,fmax);
    disp(out5)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




% --- Executes on key press with focus on edit_input_array_1 and none of its controls.
function edit_input_array_1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



set(handles.uitable_advise,'Visible','off');
set(handles.pushbutton_calculate,'Enable','off');
set(handles.pushbutton_view_options,'Enable','off');
set(handles.listbox_numrows,'Enable','off');
set(handles.listbox_numrows,'Visible','off');
set(handles.text_select_option,'Visible','off');


set(handles.pushbutton_view_options,'Enable','on');



% --- Executes on key press with focus on listbox_numrows and none of its controls.
function listbox_numrows_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to listbox_numrows (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



function edit_fmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmax as text
%        str2double(get(hObject,'String')) returns contents of edit_fmax as a double


% --- Executes during object creation, after setting all properties.
function edit_fmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fmin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmin as text
%        str2double(get(hObject,'String')) returns contents of edit_fmin as a double


% --- Executes during object creation, after setting all properties.
function edit_fmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_convert_octave.
function pushbutton_convert_octave_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_convert_octave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s= vibrationdata_psd_oct;   
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_spec.
function pushbutton_spec_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_spec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


prompt = {'Enter spec array name'};
dlg_title = 'Input';
num_lines = 1;

try  
    temp=inputdlg(prompt,dlg_title,num_lines);
    FS=temp{:};
    THM=evalin('base',FS);  
catch 
    warndlg('Input Array does not exist.  Try again.');
    return;
end

[aslope,srms] = calculate_PSD_slopes(THM(:,1),THM(:,2));

ppp=getappdata(0,'PSD');
qqq=THM; 

irms=getappdata(0,'irms');

x_label=getappdata(0,'xlab');
y_label=getappdata(0,'ylab');
% t_string=getappdata(0,'t_string');
fmin=getappdata(0,'fmin');
fmax=getappdata(0,'fmax');

yu=get(handles.edit_ylabel_input,'String');

fig_num=getappdata(0,'fig_num');

leg_b=sprintf('input %6.3g %sRMS',irms,yu);
leg_a=sprintf('spec  %6.3g %sRMS',srms,yu);

t_string='Power Spectral Density';

%% nps=get(handles.listbox_export_plot,'Value');    

%% if(nps==1)
%%     pname=get(handles.edit_plot_name,'String');
%% else
%%     pname=' ';
%% end    



[fig_num]=plot_PSD_two_f(fig_num,x_label,y_label,t_string,qqq,ppp,leg_a,leg_b,fmin,fmax,pname,nps);
    


% --- Executes on selection change in listbox_export_plot.
function listbox_export_plot_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_export_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_export_plot contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_export_plot

%% n=get(handles.listbox_export_plot,'Value');

%% if(n==1)
%%     set(handles.text_plot_name,'Visible','on');
%%     set(handles.edit_plot_name,'Visible','on');
%% else
%%     set(handles.text_plot_name,'Visible','off');
%%     set(handles.edit_plot_name,'Visible','off');   
%% end


% --- Executes during object creation, after setting all properties.
function listbox_export_plot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_export_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_plot_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_plot_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_plot_name as text
%        str2double(get(hObject,'String')) returns contents of edit_plot_name as a double


% --- Executes during object creation, after setting all properties.
function edit_plot_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_plot_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_crms.
function listbox_crms_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_crms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_crms contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_crms


% --- Executes during object creation, after setting all properties.
function listbox_crms_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_crms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_format.
function listbox_format_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_format contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_format
mn_common(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_format_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_input_array_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_save.
function listbox_save_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_save contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_save


% --- Executes during object creation, after setting all properties.
function listbox_save_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_response_type.
function listbox_response_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_response_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_response_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_response_type


% --- Executes during object creation, after setting all properties.
function listbox_response_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_response_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ylabel_response_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ylabel_response (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ylabel_response as text
%        str2double(get(hObject,'String')) returns contents of edit_ylabel_response as a double


% --- Executes during object creation, after setting all properties.
function edit_ylabel_response_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ylabel_response (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

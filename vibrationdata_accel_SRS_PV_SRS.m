function varargout = vibrationdata_accel_SRS_PV_SRS(varargin)
% VIBRATIONDATA_ACCEL_SRS_PV_SRS MATLAB code for vibrationdata_accel_SRS_PV_SRS.fig
%      VIBRATIONDATA_ACCEL_SRS_PV_SRS, by itself, creates a new VIBRATIONDATA_ACCEL_SRS_PV_SRS or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_ACCEL_SRS_PV_SRS returns the handle to a new VIBRATIONDATA_ACCEL_SRS_PV_SRS or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_ACCEL_SRS_PV_SRS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_ACCEL_SRS_PV_SRS.M with the given input arguments.
%
%      VIBRATIONDATA_ACCEL_SRS_PV_SRS('Property','Value',...) creates a new VIBRATIONDATA_ACCEL_SRS_PV_SRS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_accel_SRS_PV_SRS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_accel_SRS_PV_SRS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_accel_SRS_PV_SRS

% Last Modified by GUIDE v2.5 09-Dec-2014 14:00:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_accel_SRS_PV_SRS_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_accel_SRS_PV_SRS_OutputFcn, ...
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


% --- Executes just before vibrationdata_accel_SRS_PV_SRS is made visible.
function vibrationdata_accel_SRS_PV_SRS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_accel_SRS_PV_SRS (see VARARGIN)

% Choose default command line output for vibrationdata_accel_SRS_PV_SRS
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_accel_SRS_PV_SRS wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_accel_SRS_PV_SRS_OutputFcn(hObject, eventdata, handles) 
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
delete(vibrationdata_accel_SRS_PV_SRS);

% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('  ');
disp(' * * * * ');
disp('  ');


try
    FS=get(handles.edit_input_array_name,'String');
    SRS=evalin('base',FS);  
catch
    warndlg('Input Array does not exist.  Try again.')
    return;
end

Q=str2num(get(handles.edit_Q,'String'));


sz=size(SRS);
nc=sz(2);

tpi=2*pi;

fn=SRS(:,1);

omegan=tpi*fn;

num=length(fn);

iu=get(handles.listbox_unit,'Value');

if(nc==2)
    accel=SRS(:,2);

    pv=zeros(num,1);

    for i=1:num
        pv(i)=accel(i)/omegan(i);
    end    
    
    if(iu==1)
        pv=pv*386;
    else
        pv=pv*9.81*100;
    end    
    
    pv_srs=[fn pv];    
    
else
    a_pos=SRS(:,2);
    a_neg=SRS(:,3);
    
    pv_neg=zeros(num,1);    
    pv_pos=zeros(num,1);  
    
    for i=1:num
        pv_neg(i)=a_neg(i)/omegan(i);
        pv_pos(i)=a_pos(i)/omegan(i);        
    end    
    
    if(iu==1)
        pv_neg=pv_neg*386;
    else
        pv_pos=pv_pos*9.81*100;
    end        
   
    pv_srs=[fn pv_pos pv_neg];
end

setappdata(0,'pv_srs',pv_srs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

fig_num=1;

fmin=min(fn);
fmax=max(fn);


x_lab='Natural Frequency (Hz)';
y_lab='Peak Accel (G)';
t_string=sprintf('Acceleration Shock Response Spectrum Q=%g',Q);

if(nc==2)
    
    [fig_num]=abs_srs_plot_function(fig_num,fn,accel,t_string,y_lab,fmin,fmax);
     
    if(iu==1)
        y_lab='Peak PV (in/sec)';
    else
        y_lab='Peak PV (cm/sec)';
    end
    
    t_string=sprintf('Pseudo Velocity Shock Response Spectrum Q=%g',Q);    
    [fig_num]=abs_srs_plot_function(fig_num,fn,pv,t_string,y_lab,fmin,fmax);

    disp('');
    disp('Maximum PV = ');
    
    if(iu==1)
        out1=sprintf(' %9.4g in/sec  ',max(pv));
    else
        out1=sprintf(' %9.4g cm/sec  ',max(pv));        
    end
    disp(out1);
    
else

    [fig_num]=srs_plot_function(fig_num,fn,a_pos,a_neg,t_string,y_lab,fmin,fmax);
    
    if(iu==1)
        y_lab='Peak PV (in/sec)';
    else
        y_lab='Peak PV (cm/sec)';
    end
    
    t_string=sprintf('Pseudo Velocity Shock Response Spectrum Q=%g',Q);
    [fig_num]=srs_plot_function(fig_num,fn,pv_pos,pv_neg,t_string,y_lab,fmin,fmax);
    
    max_pv=max([pv_pos abs(pv_neg)]);
    
    disp('');
    disp('Maximum PV = ');
    
    if(iu==1)
        out1=sprintf(' %9.4g in/sec  ',max_pv);
    else
        out1=sprintf(' %9.4g cm/sec  ',max_pv);        
    end
    disp(out1);    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pv_srs=[fn pv];

[fig_num,h]=srs_tripartite_function_h(iu,fig_num,pv_srs,Q);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


set(handles.uipanel_save,'Visible','on');

msgbox(' Results written to Command Window ');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




function edit_input_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit
set(handles.uipanel_save,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Q_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q as text
%        str2double(get(hObject,'String')) returns contents of edit_Q as a double


% --- Executes during object creation, after setting all properties.
function edit_Q_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_output_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


output_name=get(handles.edit_output_array_name,'String');

data=getappdata(0,'pv_srs');    

assignin('base', output_name, data);

h = msgbox('Save Complete'); 


% --- Executes on key press with focus on edit_input_array_name and none of its controls.
function edit_input_array_name_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');

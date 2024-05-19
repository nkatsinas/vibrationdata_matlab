function varargout = Multiple_PSD_Envelope_normal_tolerance(varargin)
% MULTIPLE_PSD_ENVELOPE_NORMAL_TOLERANCE MATLAB code for Multiple_PSD_Envelope_normal_tolerance.fig
%      MULTIPLE_PSD_ENVELOPE_NORMAL_TOLERANCE, by itself, creates a new MULTIPLE_PSD_ENVELOPE_NORMAL_TOLERANCE or raises the existing
%      singleton*.
%
%      H = MULTIPLE_PSD_ENVELOPE_NORMAL_TOLERANCE returns the handle to a new MULTIPLE_PSD_ENVELOPE_NORMAL_TOLERANCE or the handle to
%      the existing singleton*.
%
%      MULTIPLE_PSD_ENVELOPE_NORMAL_TOLERANCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MULTIPLE_PSD_ENVELOPE_NORMAL_TOLERANCE.M with the given input arguments.
%
%      MULTIPLE_PSD_ENVELOPE_NORMAL_TOLERANCE('Property','Value',...) creates a new MULTIPLE_PSD_ENVELOPE_NORMAL_TOLERANCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Multiple_PSD_Envelope_normal_tolerance_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Multiple_PSD_Envelope_normal_tolerance_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Multiple_PSD_Envelope_normal_tolerance

% Last Modified by GUIDE v2.5 07-Nov-2018 09:35:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Multiple_PSD_Envelope_normal_tolerance_OpeningFcn, ...
                   'gui_OutputFcn',  @Multiple_PSD_Envelope_normal_tolerance_OutputFcn, ...
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


% --- Executes just before Multiple_PSD_Envelope_normal_tolerance is made visible.
function Multiple_PSD_Envelope_normal_tolerance_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Multiple_PSD_Envelope_normal_tolerance (see VARARGIN)

% Choose default command line output for Multiple_PSD_Envelope_normal_tolerance
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Multiple_PSD_Envelope_normal_tolerance wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Multiple_PSD_Envelope_normal_tolerance_OutputFcn(hObject, eventdata, handles) 
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

delete(Multiple_PSD_Envelope_normal_tolerance);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * * * * * * ');
disp(' ');


Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end


fig_num=1;


try
    FS=get(handles.edit_input_array,'String');
    THM=evalin('base',FS);
catch
    warndlg('Input array not found.');
    return; 
end       

sz=size(THM);

nsamples=sz(2)-1;
nrows=sz(1);

f=THM(:,1);

A=THM(:,2:sz(2));

p=str2num(get(handles.edit_probability,'String'));
c=str2num(get(handles.edit_confidence,'String'));

idt=get(handles.listbox_dtype,'Value');


if(nsamples<2)
    warndlg('At least 2 samples required');
    return;
end

h='%';
out1=sprintf(' probabilty = %g %s ',p,h);
out2=sprintf(' confidence = %g %s \n',c,h);
out3=sprintf(' number samples = %d ',nsamples);
disp(out1)
disp(out2)
disp(out3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[k,lambda_int,Z,mu]=tolerance_factor_core(p,c,nsamples);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
ss=sprintf('%8.4g',k);
 
 
out1=sprintf('\n noncentrality parameter = %8.4g ',mu);
disp(out1);
out1=sprintf('\n k=%8.4g    T=%8.4g  Z=%8.4g',k,lambda_int,Z);
disp(out1);
 
disp(' ');
sss=sprintf(' Tolerance factor k = %8.4g',k);
disp(sss);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(idt==2) % log-normal
    for i=1:nrows
        for j=1:nsamples
            A(i,j)=log10(A(i,j));
        end    
    end    
end

psd_mu=zeros(nrows,1);
psd_std=zeros(nrows,1);

for i=1:nrows
    psd_mu(i)=mean(A(i,:));
    psd_std(i)=std(A(i,:));
end

psd_env=psd_mu + k*psd_std;

if(idt==2) % log-normal
    for i=1:nrows
        psd_env(i)=10^psd_env(i);
    end      
end

[~,grms_env] = calculate_PSD_slopes(f,psd_env);

%%%%%%%%%%%%%%%%%%%%%

x_label='Frequency (Hz)';
y_label='Accel (G^2/Hz)';

fmin=f(1);
fmax=f(end);

t_string=sprintf('PSD  P%g/%g  Derivation ',p,c);

for i=1:nsamples
    [~,grms] = calculate_PSD_slopes(f,A(:,i));
    leg{i+1}=sprintf('%d.  %7.3g GRMS',i,grms);
end

leg{1}=sprintf('P%g/%g  %7.4g GRMS',p,c,grms_env);

ppp=[f psd_env A];

[fig_num]=plot_loglog_multiple_function(fig_num,x_label,y_label,t_string,ppp,leg,fmin,fmax);

%%%%%%%%%%%%%%%%%%%%%

t_string=sprintf('PSD  P%g/%g   Overall %7.4g grms',p,c,grms_env);

ppp_env=[f psd_env];

md=6;

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp_env,fmin,fmax,md);

%%%%%%%%%%%%%%%%%%%%%

setappdata(0,'psd_env',ppp);

set(handles.uipanel_save,'Visible','on');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function edit_probability_Callback(hObject, eventdata, handles)
% hObject    handle to edit_probability (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_probability as text
%        str2double(get(hObject,'String')) returns contents of edit_probability as a double


% --- Executes during object creation, after setting all properties.
function edit_probability_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_probability (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_confidence_Callback(hObject, eventdata, handles)
% hObject    handle to edit_confidence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_confidence as text
%        str2double(get(hObject,'String')) returns contents of edit_confidence as a double


% --- Executes during object creation, after setting all properties.
function edit_confidence_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_confidence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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


% --- Executes on selection change in listbox_dtype.
function listbox_dtype_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_dtype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_dtype contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_dtype

set(handles.uipanel_save,'Visible','off');


% --- Executes during object creation, after setting all properties.
function listbox_dtype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_dtype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

output_array=get(handles.edit_output_array_name,'String');

data=getappdata(0,'psd_env');

assignin('base',output_array,data);

msgbox('Export complete');


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


% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_probability and none of its controls.
function edit_probability_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_probability (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_confidence and none of its controls.
function edit_confidence_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_confidence (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');

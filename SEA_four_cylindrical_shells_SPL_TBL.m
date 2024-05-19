function varargout = SEA_four_cylindrical_shells_SPL_TBL(varargin)
% SEA_FOUR_CYLINDRICAL_SHELLS_SPL_TBL MATLAB code for SEA_four_cylindrical_shells_SPL_TBL.fig
%      SEA_FOUR_CYLINDRICAL_SHELLS_SPL_TBL, by itself, creates a new SEA_FOUR_CYLINDRICAL_SHELLS_SPL_TBL or raises the existing
%      singleton*.
%
%      H = SEA_FOUR_CYLINDRICAL_SHELLS_SPL_TBL returns the handle to a new SEA_FOUR_CYLINDRICAL_SHELLS_SPL_TBL or the handle to
%      the existing singleton*.
%
%      SEA_FOUR_CYLINDRICAL_SHELLS_SPL_TBL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEA_FOUR_CYLINDRICAL_SHELLS_SPL_TBL.M with the given input arguments.
%
%      SEA_FOUR_CYLINDRICAL_SHELLS_SPL_TBL('Property','Value',...) creates a new SEA_FOUR_CYLINDRICAL_SHELLS_SPL_TBL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SEA_four_cylindrical_shells_SPL_TBL_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SEA_four_cylindrical_shells_SPL_TBL_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SEA_four_cylindrical_shells_SPL_TBL

% Last Modified by GUIDE v2.5 13-Dec-2017 13:17:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SEA_four_cylindrical_shells_SPL_TBL_OpeningFcn, ...
                   'gui_OutputFcn',  @SEA_four_cylindrical_shells_SPL_TBL_OutputFcn, ...
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


% --- Executes just before SEA_four_cylindrical_shells_SPL_TBL is made visible.
function SEA_four_cylindrical_shells_SPL_TBL_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SEA_four_cylindrical_shells_SPL_TBL (see VARARGIN)

% Choose default command line output for SEA_four_cylindrical_shells_SPL_TBL
handles.output = hObject;

try
   
    FS=getappdata(0,'SPL_nine_name');
    
    if(isempty(FS))
    else
        set(handles.edit_input_array,'String',FS);
    end
    
catch
end


data_s{1,1} = 'Center Freq (Hz)';  
data_s{2,1} = 'Input SPL 1 (dB)'; 
data_s{3,1} = 'Input SPL 2 (dB)'; 
data_s{4,1} = 'Input SPL 3 (dB)'; 
data_s{5,1} = 'Input SPL 4 (dB)'; 
data_s{6,1} = 'Loss Factor 1'; 
data_s{7,1} = 'Loss Factor 2'; 
data_s{8,1} = 'Loss Factor 3'; 
data_s{9,1} = 'Loss Factor 4';  


set(handles.uitable_variables,'Data',data_s);

iu=getappdata(0,'iu');

if(iu==1)
    ss='delta* is boundary layer displacement thickness (in)';
else
    ss='delta* is boundary layer displacement thickness (m)';
end

set(handles.text_delta_text,'String',ss);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SEA_four_cylindrical_shells_SPL_TBL wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SEA_four_cylindrical_shells_SPL_TBL_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_enter.
function pushbutton_enter_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_enter (see GCBO)

% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try  
    FS=get(handles.edit_input_array,'String');
    THM=evalin('base',FS);  

catch  
    warndlg('Input Array does not exist.  Try again.')
    return;
end


sz=size(THM);

if(sz(2)~=9)
    warndlg('Input Array must have nine columns');
    return;
end

setappdata(0,'SPL_nine',THM);
setappdata(0,'SPL_nine_name',FS);

%%%

meters_per_inch=0.0254;

N=4;

A=get(handles.uitable_coordinates,'Data');

A

A{1}

A{1,1}

A(1,1)

whos A

return

B=str2num(A{1,1});

B

Reynolds=B(1:N);
delta_star=B((N+1):(2*N));

Reynolds
delta_star


Reynolds=fix_size(Reynolds);
delta_star=fix_size(delta_star);


setappdata(0,'Reynolds',Reynolds);
setappdata(0,'delta_star_orig',delta_star);

if(iu==1)
    delta_star=delta_star*meters_per_inch;
end

setappdata(0,'delta_star',delta_star);

%%%

gamma_1=str2num(get(handles.edit_gamma_1,'String'));
gamma_3=str2num(get(handles.edit_gamma_3,'String'));

setappdata(0,'gamma_1',gamma_1);
setappdata(0,'gamma_3',gamma_3);


%%%

delete(SEA_four_cylindrical_shells_SPL_TBL);






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


% --- Executes during object creation, after setting all properties.
function uitable_coordinates_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uitable_coordinates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% set(hObject, 'RowName', {'R1', 'R2', 'R3', 'R4'}, 'ColumnName', {'C1', 'C2'});



function edit_gamma1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_gamma1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_gamma1 as text
%        str2double(get(hObject,'String')) returns contents of edit_gamma1 as a double


% --- Executes during object creation, after setting all properties.
function edit_gamma1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gamma1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_gamma_3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_gamma_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_gamma_3 as text
%        str2double(get(hObject,'String')) returns contents of edit_gamma_3 as a double


% --- Executes during object creation, after setting all properties.
function edit_gamma_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gamma_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

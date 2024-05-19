function varargout = SEA_four_cylindrical_shells_SPL_old(varargin)
% SEA_FOUR_CYLINDRICAL_SHELLS_SPL_OLD MATLAB code for SEA_four_cylindrical_shells_SPL_old.fig
%      SEA_FOUR_CYLINDRICAL_SHELLS_SPL_OLD, by itself, creates a new SEA_FOUR_CYLINDRICAL_SHELLS_SPL_OLD or raises the existing
%      singleton*.
%
%      H = SEA_FOUR_CYLINDRICAL_SHELLS_SPL_OLD returns the handle to a new SEA_FOUR_CYLINDRICAL_SHELLS_SPL_OLD or the handle to
%      the existing singleton*.
%
%      SEA_FOUR_CYLINDRICAL_SHELLS_SPL_OLD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEA_FOUR_CYLINDRICAL_SHELLS_SPL_OLD.M with the given input arguments.
%
%      SEA_FOUR_CYLINDRICAL_SHELLS_SPL_OLD('Property','Value',...) creates a new SEA_FOUR_CYLINDRICAL_SHELLS_SPL_OLD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SEA_four_cylindrical_shells_SPL_old_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SEA_four_cylindrical_shells_SPL_old_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SEA_four_cylindrical_shells_SPL_old

% Last Modified by GUIDE v2.5 02-May-2018 13:36:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SEA_four_cylindrical_shells_SPL_old_OpeningFcn, ...
                   'gui_OutputFcn',  @SEA_four_cylindrical_shells_SPL_old_OutputFcn, ...
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


% --- Executes just before SEA_four_cylindrical_shells_SPL_old is made visible.
function SEA_four_cylindrical_shells_SPL_old_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SEA_four_cylindrical_shells_SPL_old (see VARARGIN)

% Choose default command line output for SEA_four_cylindrical_shells_SPL_old
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


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SEA_four_cylindrical_shells_SPL_old wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SEA_four_cylindrical_shells_SPL_old_OutputFcn(hObject, eventdata, handles) 
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

delete(SEA_four_cylindrical_shells_SPL);



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

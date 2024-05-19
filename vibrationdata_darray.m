function varargout = vibrationdata_darray(varargin)
% VIBRATIONDATA_DARRAY MATLAB code for vibrationdata_darray.fig
%      VIBRATIONDATA_DARRAY, by itself, creates a new VIBRATIONDATA_DARRAY or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_DARRAY returns the handle to a new VIBRATIONDATA_DARRAY or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_DARRAY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_DARRAY.M with the given input arguments.
%
%      VIBRATIONDATA_DARRAY('Property','Value',...) creates a new VIBRATIONDATA_DARRAY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_darray_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_darray_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_darray

% Last Modified by GUIDE v2.5 18-Oct-2018 12:53:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_darray_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_darray_OutputFcn, ...
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


% --- Executes just before vibrationdata_darray is made visible.
function vibrationdata_darray_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_darray (see VARARGIN)

% Choose default command line output for vibrationdata_darray
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_darray wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_darray_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_view.
function pushbutton_view_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * * ');
disp(' ');

try
    FS=get(handles.edit_input_array,'String');
    THM=evalin('base',FS);  

catch  
    warndlg('Input Array does not exist.  Try again.')
    return;
end

sz=size(THM);

disp(' ');
disp(' Format:  %9.0f '); 
disp(' ');

for i=1:sz(1)
    out1=sprintf(' %9.0f \t %9.0f ',THM(i,1),THM(i,2));
    disp(out1); 
end

disp(' ');
disp(' Format:  %9.1f '); 
disp(' ');

for i=1:sz(1)
    out1=sprintf(' %9.1f \t %9.1f ',THM(i,1),THM(i,2));
    disp(out1); 
end

disp(' ');
disp(' Format:  %8.1e '); 
disp(' ');

for i=1:sz(1)
    out1=sprintf(' %9.5g \t %8.1e ',THM(i,1),THM(i,2));
    disp(out1); 
end

disp(' ');
disp(' Format:  %8.2e '); 
disp(' ');

for i=1:sz(1)
    out1=sprintf(' %9.5g \t %8.2e ',THM(i,1),THM(i,2));
    disp(out1); 
end

disp(' ');
disp(' Format:  %8.3e '); 
disp(' ');

for i=1:sz(1)
    out1=sprintf(' %9.5g \t %8.3e ',THM(i,1),THM(i,2));
    disp(out1); 
end

disp(' ');
disp(' Format:  %9.5g '); 
disp(' ');

for i=1:sz(1)
    out1=sprintf(' %9.5g \t %9.5g ',THM(i,1),THM(i,2));
    disp(out1); 
end

clipboard('copy',THM);

disp(' ');
disp(' Data copied to clipboard ');
disp(' ');





% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(vibrationdata_darray);

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

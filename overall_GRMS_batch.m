function varargout = overall_GRMS_batch(varargin)
% OVERALL_GRMS_BATCH MATLAB code for overall_GRMS_batch.fig
%      OVERALL_GRMS_BATCH, by itself, creates a new OVERALL_GRMS_BATCH or raises the existing
%      singleton*.
%
%      H = OVERALL_GRMS_BATCH returns the handle to a new OVERALL_GRMS_BATCH or the handle to
%      the existing singleton*.
%
%      OVERALL_GRMS_BATCH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OVERALL_GRMS_BATCH.M with the given input arguments.
%
%      OVERALL_GRMS_BATCH('Property','Value',...) creates a new OVERALL_GRMS_BATCH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before overall_GRMS_batch_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to overall_GRMS_batch_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help overall_GRMS_batch

% Last Modified by GUIDE v2.5 29-Aug-2017 14:38:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @overall_GRMS_batch_OpeningFcn, ...
                   'gui_OutputFcn',  @overall_GRMS_batch_OutputFcn, ...
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


% --- Executes just before overall_GRMS_batch is made visible.
function overall_GRMS_batch_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to overall_GRMS_batch (see VARARGIN)

% Choose default command line output for overall_GRMS_batch
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes overall_GRMS_batch wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = overall_GRMS_batch_OutputFcn(hObject, eventdata, handles) 
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

delete(overall_GRMS_batch);



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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    FS=get(handles.edit_input_array,'String');
    sarray=evalin('base',FS);
catch
    warndlg('Input string array not found.');
    return; 
end    

if(iscell(sarray)==0)
    warndlg('Input must be array of strings (class=cell)');  
    return;
end

 
kv=length(sarray);


disp('  ');
disp(' * * * * * ');
disp('  ');

for i=1:kv
    
    ss=char(sarray(i,:));
    
    THM=evalin('base',ss);
    
    t=double(THM(:,1));
    y=double(THM(:,2));
    
    [~,grms] = calculate_PSD_slopes(t,y);
    
    out1=sprintf(' %s \t %7.3g  ',ss,grms);
    disp(out1);
    
end

msgbox('Calculation complete. Results written to Command Window');

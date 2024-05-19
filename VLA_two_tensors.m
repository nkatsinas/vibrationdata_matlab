function varargout = VLA_two_tensors(varargin)
% VLA_TWO_TENSORS MATLAB code for VLA_two_tensors.fig
%      VLA_TWO_TENSORS, by itself, creates a new VLA_TWO_TENSORS or raises the existing
%      singleton*.
%
%      H = VLA_TWO_TENSORS returns the handle to a new VLA_TWO_TENSORS or the handle to
%      the existing singleton*.
%
%      VLA_TWO_TENSORS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VLA_TWO_TENSORS.M with the given input arguments.
%
%      VLA_TWO_TENSORS('Property','Value',...) creates a new VLA_TWO_TENSORS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VLA_two_tensors_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VLA_two_tensors_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VLA_two_tensors

% Last Modified by GUIDE v2.5 23-Feb-2015 16:23:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VLA_two_tensors_OpeningFcn, ...
                   'gui_OutputFcn',  @VLA_two_tensors_OutputFcn, ...
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


% --- Executes just before VLA_two_tensors is made visible.
function VLA_two_tensors_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VLA_two_tensors (see VARARGIN)

% Choose default command line output for VLA_two_tensors
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes VLA_two_tensors wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VLA_two_tensors_OutputFcn(hObject, eventdata, handles) 
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

delete(VLA_two_tensors);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    FS=get(handles.edit_A,'String');
    A=evalin('base',FS); 
catch
    warndlg('Input Tensor A does not exist');
    return;
end

try
    FS=get(handles.edit_B,'String');
    B=evalin('base',FS); 
catch
    warndlg('Input Tensor B does not exist');
    return;
end

sza=size(A);
szb=size(B);

A
B

n=get(handles.listbox_analysis,'Value');

disp(' ');

if(n==1) % A B
    AB=A*B
    output_name='AB';
    assignin('base', output_name, AB);    
end
if(n==2) % A' B   
    ATB=A'*B
    output_name='ATB';   
    assignin('base', output_name, ATB);     
end
if(n==3) % A B'      
    ABT=A*B'
    output_name='ABT';     
    assignin('base', output_name, ABT);     
end
if(n==4) % A B A'         
    ABAT=A*B*A'
    output_name='ABAT';     
    assignin('base', output_name, ABAT);     
end
if(n==5) % A' B A     
    ATBA=A'*B*A
    output_name='ATBA';     
    assignin('base', output_name, ATBA);     
end
if(n==6) % inner product
    c=trace(A*B);
    out1=sprintf(' inner product = trace(AB) = %8.4g',c);
    disp(out1);
end

if(n<=5)
    out1=sprintf('output name= %s ',output_name);
    disp(out1);
end

msgbox('Results written to Command Window');



function edit_A_Callback(hObject, eventdata, handles)
% hObject    handle to edit_A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_A as text
%        str2double(get(hObject,'String')) returns contents of edit_A as a double


% --- Executes during object creation, after setting all properties.
function edit_A_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_analysis.
function listbox_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis


% --- Executes during object creation, after setting all properties.
function listbox_analysis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_B_Callback(hObject, eventdata, handles)
% hObject    handle to edit_B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_B as text
%        str2double(get(hObject,'String')) returns contents of edit_B as a double


% --- Executes during object creation, after setting all properties.
function edit_B_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function varargout = vibe_test_array_alt(varargin)
% VIBE_TEST_ARRAY_ALT MATLAB code for vibe_test_array_alt.fig
%      VIBE_TEST_ARRAY_ALT, by itself, creates a new VIBE_TEST_ARRAY_ALT or raises the existing
%      singleton*.
%
%      H = VIBE_TEST_ARRAY_ALT returns the handle to a new VIBE_TEST_ARRAY_ALT or the handle to
%      the existing singleton*.
%
%      VIBE_TEST_ARRAY_ALT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBE_TEST_ARRAY_ALT.M with the given input arguments.
%
%      VIBE_TEST_ARRAY_ALT('Property','Value',...) creates a new VIBE_TEST_ARRAY_ALT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibe_test_array_alt_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibe_test_array_alt_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibe_test_array_alt

% Last Modified by GUIDE v2.5 03-May-2021 14:23:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibe_test_array_alt_OpeningFcn, ...
                   'gui_OutputFcn',  @vibe_test_array_alt_OutputFcn, ...
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


% --- Executes just before vibe_test_array_alt is made visible.
function vibe_test_array_alt_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibe_test_array_alt (see VARARGIN)

% Choose default command line output for vibe_test_array_alt
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibe_test_array_alt wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibe_test_array_alt_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_process.
function pushbutton_process_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_process (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    FS=get(handles.edit_input_array,'String');
    THM=evalin('base',FS);  
catch
    warndlg('Input Array not found');
    return;
end

prefix=get(handles.edit_prefix,'String');
    

THM(:,7)=[];
THM(:,6)=[];
THM(:,5)=[];
THM(:,4)=[];
THM(:,2)=[];


sz=size(THM);

num=sz(1);

clear f;
clear c;

f=THM(:,1);
c=THM(:,2);

tch1=zeros(num,2);
tch2=zeros(num,2);
tch3=zeros(num,2);
tch4=zeros(num,2);
tch5=zeros(num,2);
tch6=zeros(num,2);
tch7=zeros(num,2);
tch8=zeros(num,2);
tch9=zeros(num,2);
tch10=zeros(num,2);
tch11=zeros(num,2);
tch12=zeros(num,2);
tch13=zeros(num,2);
tch14=zeros(num,2);
tch15=zeros(num,2);

disp(' ');
disp(' Power Transmissibility Arrays');
disp(' ');

for i=1:num
    
    try
        a=[f THM(:,i+2)./c(:)];
        name=sprintf('%s_th%d',prefix,i);
        assignin('base',name,a); 
        fprintf(' %s \n',name);
    catch
    end 
    
end    
    
   
       






% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(vibe_test_array_alt);



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



function edit_prefix_Callback(hObject, eventdata, handles)
% hObject    handle to edit_prefix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_prefix as text
%        str2double(get(hObject,'String')) returns contents of edit_prefix as a double


% --- Executes during object creation, after setting all properties.
function edit_prefix_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_prefix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function varargout = simple_range_mean_counting(varargin)
% SIMPLE_RANGE_MEAN_COUNTING MATLAB code for simple_range_mean_counting.fig
%      SIMPLE_RANGE_MEAN_COUNTING, by itself, creates a new SIMPLE_RANGE_MEAN_COUNTING or raises the existing
%      singleton*.
%
%      H = SIMPLE_RANGE_MEAN_COUNTING returns the handle to a new SIMPLE_RANGE_MEAN_COUNTING or the handle to
%      the existing singleton*.
%
%      SIMPLE_RANGE_MEAN_COUNTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMPLE_RANGE_MEAN_COUNTING.M with the given input arguments.
%
%      SIMPLE_RANGE_MEAN_COUNTING('Property','Value',...) creates a new SIMPLE_RANGE_MEAN_COUNTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before simple_range_mean_counting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to simple_range_mean_counting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help simple_range_mean_counting

% Last Modified by GUIDE v2.5 27-Aug-2015 09:50:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @simple_range_mean_counting_OpeningFcn, ...
                   'gui_OutputFcn',  @simple_range_mean_counting_OutputFcn, ...
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


% --- Executes just before simple_range_mean_counting is made visible.
function simple_range_mean_counting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to simple_range_mean_counting (see VARARGIN)

% Choose default command line output for simple_range_mean_counting
handles.output = hObject;

set(handles.uibuttongroup_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes simple_range_mean_counting wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = simple_range_mean_counting_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% b=str2num(get(handles.edit_b,'String'));

try
    FS=get(handles.edit_input_array_name,'String');
    THM=evalin('base',FS);
catch
    warndlg('Input array not found');
    return; 
end
    
THM=fix_size(THM);


sz=size(THM);

dur=0.;

if(sz(2)==1)
    y=THM(:,1);
    m=length(y)-1;
else    
    y=THM(:,2);
    m=length(y)-1;
    dur=THM(m,1)-THM(1,1);
end


a=zeros(m,1);
t=zeros(m,1);
a(1)=y(1);
t(1)=1;
k=2;
%
out1=sprintf('\n total input points =%d ',m);
disp(out1)
%
disp(' Begin slope calculation ')
%
slope1=(  y(2)-y(1));
for i=2:m
     slope2=(y(i+1)-y(i));
     if((slope1*slope2)<=0)
          a(k)=y(i);
          t(k)=i;
          k=k+1;
     end
     slope1=slope2;
end
%
a(k)=y(m+1);
t(k)=t(k-1)+1;
k=k+1;
%
disp(' End slope calculation ')
disp(' ');
%
a=a/2;

D=0;

for i=1:(length(t)-1);
   D=D+0.5*(abs(a(i+1)-a(i)))^b; 
end

tc=length(t)/2;

out1=sprintf(' Fatigue Exponent = %g \n',b);
disp(out1);

out1=sprintf(' Total Cycles = %d ',tc);
disp(out1);

out1=sprintf(' Damage      = %8.4g ',D);
disp(out1);

if(dur>1.0e-20)
    out2=sprintf(' Damage rate = %8.4g ',D/dur);
    disp(out2);
    out3=sprintf('%8.4g ',D/dur);
    clipboard('copy', out3)
end

set(handles.uibuttongroup_save,'Visible','on');
    
msgbox('Results written to Command Window');

function edit_b_Callback(hObject, eventdata, handles)
% hObject    handle to edit_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_b as text
%        str2double(get(hObject,'String')) returns contents of edit_b as a double


% --- Executes during object creation, after setting all properties.
function edit_b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(simple_range_mean_counting);


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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


% --- Executes on key press with focus on edit_input_array_name and none of its controls.
function edit_input_array_name_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uibuttongroup_save,'Visible','off');

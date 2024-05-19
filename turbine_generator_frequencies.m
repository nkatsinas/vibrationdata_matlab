function varargout = turbine_generator_frequencies(varargin)
% TURBINE_GENERATOR_FREQUENCIES MATLAB code for turbine_generator_frequencies.fig
%      TURBINE_GENERATOR_FREQUENCIES, by itself, creates a new TURBINE_GENERATOR_FREQUENCIES or raises the existing
%      singleton*.
%
%      H = TURBINE_GENERATOR_FREQUENCIES returns the handle to a new TURBINE_GENERATOR_FREQUENCIES or the handle to
%      the existing singleton*.
%
%      TURBINE_GENERATOR_FREQUENCIES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TURBINE_GENERATOR_FREQUENCIES.M with the given input arguments.
%
%      TURBINE_GENERATOR_FREQUENCIES('Property','Value',...) creates a new TURBINE_GENERATOR_FREQUENCIES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before turbine_generator_frequencies_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to turbine_generator_frequencies_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help turbine_generator_frequencies

% Last Modified by GUIDE v2.5 13-Mar-2014 10:51:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @turbine_generator_frequencies_OpeningFcn, ...
                   'gui_OutputFcn',  @turbine_generator_frequencies_OutputFcn, ...
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


% --- Executes just before turbine_generator_frequencies is made visible.
function turbine_generator_frequencies_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to turbine_generator_frequencies (see VARARGIN)

% Choose default command line output for turbine_generator_frequencies
handles.output = hObject;

set(handles.listbox_frequency,'Value',1);

clear_results(hObject, eventdata, handles); 

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes turbine_generator_frequencies wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function clear_results(hObject, eventdata, handles)
%
set(handles.edit_results,'String',' ');
set(handles.edit_results,'Visible','off');

% --- Outputs from this function are returned to the command line.
function varargout = turbine_generator_frequencies_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox_frequency.
function listbox_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_frequency contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_frequency
clear_results(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to edit_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_frequency as text
%        str2double(get(hObject,'String')) returns contents of edit_frequency as a double


% --- Executes during object creation, after setting all properties.
function edit_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_vanes_Callback(hObject, eventdata, handles)
% hObject    handle to edit_vanes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_vanes as text
%        str2double(get(hObject,'String')) returns contents of edit_vanes as a double


% --- Executes during object creation, after setting all properties.
function edit_vanes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_vanes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_poles_Callback(hObject, eventdata, handles)
% hObject    handle to edit_poles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_poles as text
%        str2double(get(hObject,'String')) returns contents of edit_poles as a double


% --- Executes during object creation, after setting all properties.
function edit_poles_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_poles (see GCBO)
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

n=get(handles.listbox_frequency,'Value');

f=str2num(get(handles.edit_frequency,'String'));

if(n==2)
    f=f/60.;
end    

v=str2num(get(handles.edit_vanes,'String'));

p=str2num(get(handles.edit_poles,'String'));

freq(1)=f;     S{1}='Rotor Speed';
freq(2)=f*v;   S{2}=sprintf('Rotor Speed x %d Vanes',v);   
freq(3)=2*f*v; S{3}=sprintf('2 x Rotor Speed x %d Vanes',v); 
freq(4)=3*f*v; S{4}=sprintf('3 x Rotor Speed x %d Vanes',v); 
freq(5)=f*p;   S{5}=sprintf('Rotor Speed x %d Poles',p);   
freq(6)=2*f*p; S{6}=sprintf('2 x Rotor Speed x %d Poles',p); 
freq(7)=3*f*p; S{7}=sprintf('3 x Rotor Speed x %d Poles',p); 
freq(8)=(1/2)*f*p; S{8}=sprintf('(1/2) x Rotor Speed x %d Poles',p); 

clear length;

fff=zeros(length(freq),2);

for i=1:length(freq);
   fff(i,1)=freq(i);
   fff(i,2)=i;
end    


ggg=sortrows(fff,1);

s1=sprintf('  %8.4g Hz,  %s \n',ggg(1,1),S{ggg(1,2)});


for i=2:length(freq) 
    s2=sprintf('\n %8.4g Hz,  %s \n',ggg(i,1),S{ggg(i,2)});
    s1=strcat(s1,s2);
end

set(handles.edit_results,'Max',length(freq)+1);
set(handles.edit_results,'String',s1,'Visible','on');




function edit_results_Callback(hObject, eventdata, handles)
% hObject    handle to edit_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_results as text
%        str2double(get(hObject,'String')) returns contents of edit_results as a double


% --- Executes during object creation, after setting all properties.
function edit_results_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_frequency and none of its controls.
function edit_frequency_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_frequency (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_vanes and none of its controls.
function edit_vanes_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_vanes (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_poles and none of its controls.
function edit_poles_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_poles (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(turbine_generator_frequencies);


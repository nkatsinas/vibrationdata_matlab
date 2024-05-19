function varargout = foot_force_filtering(varargin)
% FOOT_FORCE_FILTERING MATLAB code for foot_force_filtering.fig
%      FOOT_FORCE_FILTERING, by itself, creates a new FOOT_FORCE_FILTERING or raises the existing
%      singleton*.
%
%      H = FOOT_FORCE_FILTERING returns the handle to a new FOOT_FORCE_FILTERING or the handle to
%      the existing singleton*.
%
%      FOOT_FORCE_FILTERING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FOOT_FORCE_FILTERING.M with the given input arguments.
%
%      FOOT_FORCE_FILTERING('Property','Value',...) creates a new FOOT_FORCE_FILTERING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before foot_force_filtering_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to foot_force_filtering_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help foot_force_filtering

% Last Modified by GUIDE v2.5 07-Dec-2020 19:57:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @foot_force_filtering_OpeningFcn, ...
                   'gui_OutputFcn',  @foot_force_filtering_OutputFcn, ...
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


% --- Executes just before foot_force_filtering is made visible.
function foot_force_filtering_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to foot_force_filtering (see VARARGIN)

% Choose default command line output for foot_force_filtering
handles.output = hObject;

set(handles.listbox_window_size,'Value',13);
set(handles.pushbutton_calculate,'Enable','off');

set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes foot_force_filtering wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = foot_force_filtering_OutputFcn(hObject, eventdata, handles) 
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
delete(foot_force_filtering);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * * * * * * ');
disp(' ');

fig_num=1;

sr=str2double(get(handles.edit_SR,'String'));
dt=1/sr;


try
    THM=getappdata(0,'THM');
catch
    warndlg('Input array not found');
    return;
end


sz=size(THM);
n=sz(1);
t=[0:n-1]*dt;
t=t';

A = table2array(THM); 

%%%%%%%%%%%%%%%%%%%%%%%

YS='Force (lbf)';

ts={'FX Input';'FY Input';'FZ Input'};

%%%%%%%%%%%%%%%%%%%%%%%

np=str2num(get(handles.edit_np,'String'));
sws=get(handles.listbox_window_size,'Value');
w=2*sws+1;

k=fix(double(w-1)/2.);


xlabel2='Time (sec)';
ylabel1=YS;
ylabel2=YS;

B=zeros(sz(1),3);

t_string2='Mean Filtered';

disp(' Maximum Values ');

for ijk=1:3

    a=A(:,ijk);

    [mf]=mean_filter_function(a,np,k);

    data1=[t a];
    data2=[t mf];
    
    B(:,ijk)=mf;

    t_string1=ts{ijk};

    [fig_num]=subplots_two_linlin_two_titles_scale_same(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2);    
    
    fprintf(' %s:  %7.3g \n',ts{ijk},max(abs(mf)));
    
end    

setappdata(0,'B',[t B]);     

set(handles.uipanel_save,'Visible','on');


function edit_SR_Callback(hObject, eventdata, handles)
% hObject    handle to edit_SR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_SR as text
%        str2double(get(hObject,'String')) returns contents of edit_SR as a double
set(handles.uipanel_save,'Visible','off');

% --- Executes during object creation, after setting all properties.
function edit_SR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_SR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_np_Callback(hObject, eventdata, handles)
% hObject    handle to edit_np (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_np as text
%        str2double(get(hObject,'String')) returns contents of edit_np as a double
set(handles.uipanel_save,'Visible','off');

% --- Executes during object creation, after setting all properties.
function edit_np_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_np (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_window_size.
function listbox_window_size_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_window_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_window_size contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_window_size
set(handles.uipanel_save,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_window_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_window_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_input.
function pushbutton_input_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


try
    [filename, pathname] = uigetfile('*.xls*');
    filename = fullfile(pathname, filename);
    THM = readtable(filename);
    setappdata(0,'THM',THM);
    set(handles.pushbutton_calculate,'Enable','on');
    msgbox('Input complete.  Click on Calculate');
catch
    warndlg('Input array not found');
    return;
end


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

B=getappdata(0,'B');

p=get(handles.edit_prefix,'String');

tx=sprintf('%s_FX',p);
ty=sprintf('%s_FY',p);
tz=sprintf('%s_FZ',p);

t=B(:,1);
B(:,1)=[];

assignin('base', tx, [t B(:,1)]);
assignin('base', ty, [t B(:,2)]);
assignin('base', tz, [t B(:,3)]);

disp(' ');
disp(' Output Arrays ');
fprintf(' %s \n',tx);
fprintf(' %s \n',ty);
fprintf(' %s \n',tz);

h = msgbox('Save Complete'); 





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


% --- Executes on key press with focus on edit_np and none of its controls.
function edit_np_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_np (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_SR and none of its controls.
function edit_SR_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_SR (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');

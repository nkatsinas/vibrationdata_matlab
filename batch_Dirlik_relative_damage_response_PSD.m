function varargout = batch_Dirlik_relative_damage_response_PSD(varargin)
% BATCH_DIRLIK_RELATIVE_DAMAGE_RESPONSE_PSD MATLAB code for batch_Dirlik_relative_damage_response_PSD.fig
%      BATCH_DIRLIK_RELATIVE_DAMAGE_RESPONSE_PSD, by itself, creates a new BATCH_DIRLIK_RELATIVE_DAMAGE_RESPONSE_PSD or raises the existing
%      singleton*.
%
%      H = BATCH_DIRLIK_RELATIVE_DAMAGE_RESPONSE_PSD returns the handle to a new BATCH_DIRLIK_RELATIVE_DAMAGE_RESPONSE_PSD or the handle to
%      the existing singleton*.
%
%      BATCH_DIRLIK_RELATIVE_DAMAGE_RESPONSE_PSD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BATCH_DIRLIK_RELATIVE_DAMAGE_RESPONSE_PSD.M with the given input arguments.
%
%      BATCH_DIRLIK_RELATIVE_DAMAGE_RESPONSE_PSD('Property','Value',...) creates a new BATCH_DIRLIK_RELATIVE_DAMAGE_RESPONSE_PSD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before batch_Dirlik_relative_damage_response_PSD_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to batch_Dirlik_relative_damage_response_PSD_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help batch_Dirlik_relative_damage_response_PSD

% Last Modified by GUIDE v2.5 08-Jun-2018 15:03:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @batch_Dirlik_relative_damage_response_PSD_OpeningFcn, ...
                   'gui_OutputFcn',  @batch_Dirlik_relative_damage_response_PSD_OutputFcn, ...
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


% --- Executes just before batch_Dirlik_relative_damage_response_PSD is made visible.
function batch_Dirlik_relative_damage_response_PSD_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to batch_Dirlik_relative_damage_response_PSD (see VARARGIN)

% Choose default command line output for batch_Dirlik_relative_damage_response_PSD
handles.output = hObject;

clear_damage(hObject, eventdata, handles)



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes batch_Dirlik_relative_damage_response_PSD wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = batch_Dirlik_relative_damage_response_PSD_OutputFcn(hObject, eventdata, handles) 
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
delete(batch_Dirlik_relative_damage_response_PSD);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%%%%%%%%%%%%%%%%

bex=str2num(get(handles.edit_b,'String'));

duration=str2num(get(handles.edit_duration,'String'));

eoa=get(handles.edit_output_array,'String');


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
 
disp(' ');
disp(' * * * * * ');
disp(' ');


damage=zeros(kv,1);


for ijk=1:kv

    ss=char(sarray(ijk,:));
    
    THM=evalin('base',ss);

    f=THM(:,1);
    a=THM(:,2);

    df=f(1)/20;

    if(df==0)
        df=0.1;
    end

    [s,rms]=calculate_PSD_slopes(f,a);
%
    [fi,ai]=interpolate_PSD(f,a,s,df);

    m0=0;
    m1=0;
    m2=0;
    m4=0;
%
    num=length(ai);
%
    for i=1:num
%    
        m0=m0+ai(i)*df;
        m1=m1+ai(i)*fi(i)*df;
        m2=m2+ai(i)*fi(i)^2*df;
        m4=m4+ai(i)*fi(i)^4*df;
%    
    end
%

    EP=sqrt(m4/m2);

    [damage(ijk)]=Dirlik_basic(duration,bex,m0,m1,m2,m4,EP,rms);

%    out1=sprintf('%s \t %8.4g',ss,damage(ijk));
%    disp(out1);

    ssq{ijk}=ss;

end    

ssq=ssq';

Array=ssq;
Relative_Damage=damage;


out1=sprintf('\n  Damage: (unit^%g) \n',bex);
disp(out1);

T = table(Array,Relative_Damage);

T


%%%

for i=1:kv
    data_s{i,1} = ssq{i}; 
    data_s{i,2} = sprintf('%9.4g',damage(i)); 
end


hFig = figure(100);

ssww=sprintf('Rel Damage (unit^%g)',bex);

columnname =   {'    Array    ',ssww};
columnformat = {'numeric', 'numeric'};
columneditable = [false false];   
columnwidth={ 140 140 };

xwidth=300;
ywidth=500;
set(gcf,'PaperPositionMode','auto')
set(hFig, 'Position', [0 0 xwidth ywidth])
table1 = uitable;


%
    table1 = uitable('Units','normalized','Position',...
            [0 0 1 1], 'Data', data_s,... 
            'ColumnName', columnname,...
            'ColumnFormat', columnformat,...
            'ColumnEditable', columneditable,...
            'ColumnWidth', columnwidth,...
            'RowName',[]);  

    table1.FontSize = 9;

%%%

%

assignin('base', eoa, data_s);

%%%

disp(' ');

msgbox('Calculation complete');


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



function edit_damage_Callback(hObject, eventdata, handles)
% hObject    handle to edit_damage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_damage as text
%        str2double(get(hObject,'String')) returns contents of edit_damage as a double


% --- Executes during object creation, after setting all properties.
function edit_damage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_damage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_b and none of its controls.
function edit_b_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_b (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


clear_damage(hObject, eventdata, handles);


function edit_duration_Callback(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_duration as text
%        str2double(get(hObject,'String')) returns contents of edit_duration as a double


% --- Executes during object creation, after setting all properties.
function edit_duration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_duration and none of its controls.
function edit_duration_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_damage(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_damage(hObject, eventdata, handles)


function clear_damage(hObject, eventdata, handles)



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

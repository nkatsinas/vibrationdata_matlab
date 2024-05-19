function varargout = ESS_screening_strength(varargin)
% ESS_SCREENING_STRENGTH MATLAB code for ESS_screening_strength.fig
%      ESS_SCREENING_STRENGTH, by itself, creates a new ESS_SCREENING_STRENGTH or raises the existing
%      singleton*.
%
%      H = ESS_SCREENING_STRENGTH returns the handle to a new ESS_SCREENING_STRENGTH or the handle to
%      the existing singleton*.
%
%      ESS_SCREENING_STRENGTH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ESS_SCREENING_STRENGTH.M with the given input arguments.
%
%      ESS_SCREENING_STRENGTH('Property','Value',...) creates a new ESS_SCREENING_STRENGTH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ESS_screening_strength_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ESS_screening_strength_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ESS_screening_strength

% Last Modified by GUIDE v2.5 04-Aug-2015 14:35:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ESS_screening_strength_OpeningFcn, ...
                   'gui_OutputFcn',  @ESS_screening_strength_OutputFcn, ...
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


% --- Executes just before ESS_screening_strength is made visible.
function ESS_screening_strength_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ESS_screening_strength (see VARARGIN)

% Choose default command line output for ESS_screening_strength
handles.output = hObject;

listbox_type_Callback(hObject, eventdata, handles);

set(handles.uipanel_ss,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ESS_screening_strength wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ESS_screening_strength_OutputFcn(hObject, eventdata, handles) 
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

delete(ESS_screening_strength);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_type,'Value');



if(n==1)  % random vibration
    
    GRMS=str2num(get(handles.edit1,'String'));
       t=str2num(get(handles.edit2,'String'));

       SSRV=1-exp(-0.0046*GRMS^1.71*t);
       
       disp(' ');
       disp(' Random Vibration ');
       out1=sprintf('\n SSRV=%8.4g',SSRV);
       disp(out1);
       
       S=SSRV;
end

if(n==2)  % burn-in
    
       TR=-25+str2num(get(handles.edit1,'String'));
       Tb=    str2num(get(handles.edit2,'String'));

       SS=1-exp(-0.0017*(TR+0.6)^0.6*Tb);
 
       disp(' ');
       disp(' Burn-in ');       
       out1=sprintf('\n SS=%8.4g',SS);
       disp(out1);
       
       S=SS;    
    
end    

if(n==3)  % thermal cycle
     
        high=str2num(get(handles.edit1,'String'));    
         low=str2num(get(handles.edit2,'String'));
          dT=str2num(get(handles.edit3,'String'));         
         Ncy=str2num(get(handles.edit4,'String'));         
    
         TR=high-low;
         
         aa=(log(exp(1)+dT))^3;
         
        SSTC=1-exp(-0.0017*(TR+0.6)^0.6*aa*Ncy);
 
        disp(' ');
        disp(' Thermal Cycle ');       
        out1=sprintf('\n SSTC=%8.4g',SSTC);
        disp(out1);
       
        S=SSTC;            
         
end

sq=sprintf('%8.4g',S);
set(handles.edit_ss,'String',sq);

set(handles.uipanel_ss,'Visible','on');


% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type

set(handles.uipanel_ss,'Visible','off');

n=get(handles.listbox_type,'Value');

set(handles.edit3,'Visible','off');
set(handles.edit4,'Visible','off');

set(handles.text33,'Visible','off');
set(handles.text44,'Visible','off');


if(n==1)  % random vibration
    set(handles.text11,'String','Accel (GRMS)');
    set(handles.text22,'String','Time (min)');
end
if(n==2)  % burn-in
    set(handles.text11,'String','Temp (deg C)');
    set(handles.text22,'String','Time (hours)');    
end
if(n==3)  % thermal cycling
    set(handles.edit3,'Visible','on');
    set(handles.edit4,'Visible','on');
    
    set(handles.text33,'Visible','on');
    set(handles.text44,'Visible','on');    
    
    set(handles.text11,'String','High Temp (deg C)');
    set(handles.text22,'String','Low Temp (deg C)');    
    set(handles.text33,'String','Rate (deg C/min)');
    set(handles.text44,'String','Number of Cycles'); 
        
end


% --- Executes during object creation, after setting all properties.
function listbox_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ss_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ss as text
%        str2double(get(hObject,'String')) returns contents of edit_ss as a double


% --- Executes during object creation, after setting all properties.
function edit_ss_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit1 and none of its controls.
function edit1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_ss,'Visible','off');


% --- Executes on key press with focus on edit2 and none of its controls.
function edit2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_ss,'Visible','off');


% --- Executes on key press with focus on edit3 and none of its controls.
function edit3_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_ss,'Visible','off');


% --- Executes on key press with focus on edit4 and none of its controls.
function edit4_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_ss,'Visible','off');

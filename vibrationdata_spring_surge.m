function varargout = vibrationdata_spring_surge(varargin)
% VIBRATIONDATA_SPRING_SURGE MATLAB code for vibrationdata_spring_surge.fig
%      VIBRATIONDATA_SPRING_SURGE, by itself, creates a new VIBRATIONDATA_SPRING_SURGE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_SPRING_SURGE returns the handle to a new VIBRATIONDATA_SPRING_SURGE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_SPRING_SURGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_SPRING_SURGE.M with the given input arguments.
%
%      VIBRATIONDATA_SPRING_SURGE('Property','Value',...) creates a new VIBRATIONDATA_SPRING_SURGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_spring_surge_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_spring_surge_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_spring_surge

% Last Modified by GUIDE v2.5 09-Aug-2014 15:34:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_spring_surge_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_spring_surge_OutputFcn, ...
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


% --- Executes just before vibrationdata_spring_surge is made visible.
function vibrationdata_spring_surge_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_spring_surge (see VARARGIN)

% Choose default command line output for vibrationdata_spring_surge
handles.output = hObject;

change_unit_configuration(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_spring_surge wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_spring_surge_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_spring_surge);

% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_results,'Visible','on');

   iu=get(handles.listbox_unit,'Value');

atype=get(handles.listbox_configuration,'Value');


 k=str2num(get(handles.edit_stiffness,'String'));
ml=str2num(get(handles.edit_spring_mass,'String'));

if(iu==1)
% 
else
    k=k*1000;    
end    

if(atype>=4)
    
    M=str2num(get(handles.edit_end_mass,'String'));
    
    if(iu==1)
%
    end
end

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

if(atype==1)
    nroot(1)=pi;
end
%
if(atype==2)
    nroot(1)=pi/2;
end
%
if(atype==3)
    nroot(1)=pi;
end
if(atype==4)
%
    a=M/ml; 
    for j=1:8
        x=10^(j-4);
        for i=1:100
            fx=cot(x)-a*x;
%
            fxp=sin(x);
            fxp=fxp^2;
            fxp=-1/fxp;
            fxp=fxp-a;
%    
            x=x-(fx/fxp);
        end
        nroot(j)=x;
    end
%
end
if(atype==5)

    a=M/ml;
    for j=1:8
        x=10^(j-4);
        for i=1:100
            fx=tan(x)+a*x;
%
            fxp=cos(x);
            fxp=fxp^2;
            fxp=1/fxp;
            fxp=fxp+a;
%    
            x=x-(fx/fxp);
        end
        nroot(j)=x;
    end    
end
%
nroot=sort(nroot);
%
for j=1:length(nroot)
    if(nroot(j)>1.0e-10)
        out5 = sprintf('\n root=%g ',nroot(j));
        disp(out5);
        lambda=nroot(j);
        break;
    end
end
%
if(iu==1)
    fn=(lambda/(2*pi))*sqrt(386*k/ml);
else
    fn=(lambda/(2*pi))*sqrt(k/ml);    
end
out5 = sprintf('\n fn=%g Hz',fn);
disp(out5);
%

s_fn=sprintf('%8.4g',fn);

set(handles.edit_fn,'String',s_fn);




% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit

change_unit_configuration(hObject, eventdata, handles);



function change_unit_configuration(hObject, eventdata, handles)

n=get(handles.listbox_unit,'Value');
m=get(handles.listbox_configuration,'Value');

set(handles.text_end_mass,'Visible','off');
set(handles.edit_end_mass,'Visible','off');

if(m>=4)
    set(handles.text_end_mass,'Visible','on');
    set(handles.edit_end_mass,'Visible','on');    
end

if(n==1)
   set(handles.text_stiffness,'String','Enter Spring Stiffness (lbf/in)'); 
   set(handles.text_spring_mass,'String','Enter Spring Mass (lbm)');
   
   if(m>=4)
        set(handles.text_end_mass,'String','Enter End Mass (lbm)');       
   end
   
else
   set(handles.text_stiffness,'String','Enter Stiffness (N/mm)');  
   set(handles.text_spring_mass,'String','Enter Spring Mass (kg)');
   
   if(m>=4)
        set(handles.text_end_mass,'String','Enter End Mass (kg)');        
   end
   
end

clear_results(hObject, eventdata, handles)



function clear_results(hObject, eventdata, handles)
%
set(handles.uipanel_results,'Visible','off');




% --- Executes during object creation, after setting all properties.
function listbox_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_configuration.
function listbox_configuration_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_configuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_configuration contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_configuration
change_unit_configuration(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_configuration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_configuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_stiffness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stiffness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stiffness as text
%        str2double(get(hObject,'String')) returns contents of edit_stiffness as a double


% --- Executes during object creation, after setting all properties.
function edit_stiffness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stiffness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_spring_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_spring_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_spring_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_spring_mass as a double


% --- Executes during object creation, after setting all properties.
function edit_spring_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_spring_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_end_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_end_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_end_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_end_mass as a double


% --- Executes during object creation, after setting all properties.
function edit_end_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_end_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_stiffness and none of its controls.
function edit_stiffness_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_stiffness (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_spring_mass and none of its controls.
function edit_spring_mass_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_spring_mass (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_end_mass and none of its controls.
function edit_end_mass_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_end_mass (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);



function edit_fn_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fn as text
%        str2double(get(hObject,'String')) returns contents of edit_fn as a double


% --- Executes during object creation, after setting all properties.
function edit_fn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

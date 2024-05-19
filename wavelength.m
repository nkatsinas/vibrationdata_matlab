function varargout = wavelength(varargin)
% WAVELENGTH MATLAB code for wavelength.fig
%      WAVELENGTH, by itself, creates a new WAVELENGTH or raises the existing
%      singleton*.
%
%      H = WAVELENGTH returns the handle to a new WAVELENGTH or the handle to
%      the existing singleton*.
%
%      WAVELENGTH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WAVELENGTH.M with the given input arguments.
%
%      WAVELENGTH('Property','Value',...) creates a new WAVELENGTH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before wavelength_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to wavelength_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help wavelength

% Last Modified by GUIDE v2.5 17-Sep-2022 10:05:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @wavelength_OpeningFcn, ...
                   'gui_OutputFcn',  @wavelength_OutputFcn, ...
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


% --- Executes just before wavelength is made visible.
function wavelength_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to wavelength (see VARARGIN)

% Choose default command line output for wavelength
handles.output = hObject;

set(handles.listbox_calculation,'Value',1);
set(handles.listbox_ctype,'Value',1);
set(handles.listbox_speed_unit,'Value',1);
set(handles.listbox_wf_unit,'Value',1);

set(handles.edit_results,'Enable','off');

set_wavespeed(hObject, eventdata, handles);
set_wf(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes wavelength wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = wavelength_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox_ctype.
function listbox_ctype_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_ctype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_ctype contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_ctype

set_wavespeed(hObject, eventdata, handles);
set(handles.edit_results,'String','');


% --- Executes during object creation, after setting all properties.
function listbox_ctype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_ctype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_calculation.
function listbox_calculation_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_calculation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_calculation contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_calculation

set_wf(hObject, eventdata, handles);
set(handles.edit_results,'String','');


function set_wf(hObject, eventdata, handles)

n=get(handles.listbox_calculation,'Value');

if(n==1)
    str='Enter Wavelength';
    string_list{1}='meters';
    string_list{2}='feet';
    string_list{3}='inches';
else
    str='Enter Frequency';
    string_list{1}='Hz';
    string_list{2}='KHz';
    string_list{3}='MHz'; 
    string_list{4}='GHz';    
end

set(handles.text_wf,'String',str);
set(handles.listbox_wf_unit,'String',string_list);





% --- Executes during object creation, after setting all properties.
function listbox_calculation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_calculation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_wavespeed_Callback(hObject, eventdata, handles)
% hObject    handle to edit_wavespeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_wavespeed as text
%        str2double(get(hObject,'String')) returns contents of edit_wavespeed as a double


% --- Executes during object creation, after setting all properties.
function edit_wavespeed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_wavespeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function set_wavespeed(hObject, eventdata, handles)

n=get(handles.listbox_ctype,'Value');
m=get(handles.listbox_speed_unit,'Value');

c=0;

if(n==1) % light
    if(m==1) % m/sec
        c=3.0e+08;
    end
    if(m==2) % miles/hr
        c=6.7108e+08;
    end
    if(m==3) % ft/sec
        c=9.8425e+08;
    end
end
if(n==2) % sound    
    if(m==1) % m/sec
        c=343;
    end
    if(m==2) % miles/hr
        c=767;
    end
    if(m==3) % ft/sec
        c=1125;
    end
end
if(n==3) % other
   % nothing to do 
end

if(n<=2)
   str=sprintf('%8.4g',c);
   set(handles.edit_wavespeed,'String',str);
end



% --- Executes on selection change in listbox_speed_unit.
function listbox_speed_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_speed_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_speed_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_speed_unit
set_wavespeed(hObject, eventdata, handles);
set(handles.edit_results,'String','');

% --- Executes during object creation, after setting all properties.
function listbox_speed_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_speed_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%

feet_per_meter=3.2808;
inches_per_meter=39.37;

meters_per_feet=1/feet_per_meter;
meters_per_inch=1/inches_per_meter;

%%

set(handles.edit_results,'Enable','on');

n=get(handles.listbox_calculation,'Value');
p=get(handles.listbox_speed_unit,'Value');
q=get(handles.listbox_wf_unit,'Value');

c=str2num(get(handles.edit_wavespeed,'String'));

if(p==2) % convert miles/hour to meters/sec
    c=c*0.44704;
end
if(p==3) % convert ft/sec to meters/sec
    CO=c;
    c=c*meters_per_feet;
end
if(p==4) % convert in/sec to meters/sec
    c=c*meters_per_inch;    
end


if(n==1) % calculate frequency (Hz)
%    
    lambda=str2num(get(handles.edit_wf,'String'));
    
    LO=lambda;
    
    if(q==2) % feet
        lambda=lambda*meters_per_feet; 
    end
    if(q==3) % inches
        lambda=lambda*meters_per_inch; 
    end

    f=c/lambda;
%
else     % calculate wavelength (m)
% 
    f=str2num(get(handles.edit_wf,'String'));

    if(q==2) % KHz
       f=f*1000;
    end
    if(q==3) % MHz
       f=f*1.0e+06; 
    end
    if(q==4) % GHz
       f=f*1.0e+09; 
    end    

    lambda=c/f;
%
end


str1=sprintf(' Wave Speed');
str2=sprintf('\n =%8.4g meters/sec',c);

if(p==3)
    str3=sprintf('\n =%8.4g ft/sec',CO); 
else
    str3=sprintf('\n =%8.4g ft/sec',c*feet_per_meter);
end

str4=sprintf('\n\n Frequency');
str5=sprintf('\n =%8.4g Hz',f);
str6=sprintf('\n =%8.4g KHz',f/1000);
str7=sprintf('\n =%8.4g MHz',f/1.0e+06);
str8=sprintf('\n =%8.4g GHz',f/1.0e+09);

str9=sprintf('\n\n Period');
str10=sprintf('\n =%8.4g sec',1/f);

str11=sprintf('\n\n Wavelength');
str12=sprintf('\n =%8.4g centimeters',lambda*100);
str13=sprintf('\n =%8.4g meters',lambda);

if(q==2 && n==1)
   str14=sprintf('\n =%8.4g feet',LO);
   str15=sprintf('\n =%8.4g inches',LO*12.);    
else    
   str14=sprintf('\n =%8.4g feet',lambda*feet_per_meter);
   str15=sprintf('\n =%8.4g inches',lambda*inches_per_meter);    
end

if(q==3 && n==1)
   str14=sprintf('\n =%8.4g feet',LO/12);
   str15=sprintf('\n =%8.4g inches',LO); 
else
   str14=sprintf('\n =%8.4g feet',lambda*feet_per_meter);
   str15=sprintf('\n =%8.4g inches',lambda*inches_per_meter);
end    

wavenumber=2*pi/lambda;

str16=sprintf('\n\n Wave Number');
str17=sprintf('\n =%8.4g rad/meters',wavenumber);
str18=sprintf('\n =%8.4g rad/in',wavenumber/inches_per_meter);
str19=sprintf('\n =%8.4g rad/ft',wavenumber/feet_per_meter);

str=strcat(str1,str2,str3,str4,str5,str6,str7,str8,str9,str10,str11,...
                                str12,str13,str14,str15,str16,str17,str18,str19);

set(handles.edit_results,'String',str);


% --- Executes on button press in pushbutton_return.
function pushbutton_r2eturn_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(wavelength);



function edit_wf_Callback(hObject, eventdata, handles)
% hObject    handle to edit_wf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_wf as text
%        str2double(get(hObject,'String')) returns contents of edit_wf as a double


% --- Executes during object creation, after setting all properties.
function edit_wf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_wf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_wf_unit.
function listbox_wf_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_wf_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_wf_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_wf_unit
set(handles.edit_results,'String','');

% --- Executes during object creation, after setting all properties.
function listbox_wf_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_wf_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on key press with focus on edit_wavespeed and none of its controls.
function edit_wavespeed_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_wavespeed (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_results,'String','');


% --- Executes on key press with focus on edit_wf and none of its controls.
function edit_wf_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_wf (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_results,'String','');


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton_return.
function pushbutton_return_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(wavelength);

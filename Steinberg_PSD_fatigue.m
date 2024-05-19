function varargout = Steinberg_PSD_fatigue(varargin)
% STEINBERG_PSD_FATIGUE MATLAB code for Steinberg_PSD_fatigue.fig
%      STEINBERG_PSD_FATIGUE, by itself, creates a new STEINBERG_PSD_FATIGUE or raises the existing
%      singleton*.
%
%      H = STEINBERG_PSD_FATIGUE returns the handle to a new STEINBERG_PSD_FATIGUE or the handle to
%      the existing singleton*.
%
%      STEINBERG_PSD_FATIGUE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STEINBERG_PSD_FATIGUE.M with the given input arguments.
%
%      STEINBERG_PSD_FATIGUE('Property','Value',...) creates a new STEINBERG_PSD_FATIGUE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Steinberg_PSD_fatigue_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Steinberg_PSD_fatigue_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Steinberg_PSD_fatigue

% Last Modified by GUIDE v2.5 10-Nov-2014 11:12:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Steinberg_PSD_fatigue_OpeningFcn, ...
                   'gui_OutputFcn',  @Steinberg_PSD_fatigue_OutputFcn, ...
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


% --- Executes just before Steinberg_PSD_fatigue is made visible.
function Steinberg_PSD_fatigue_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Steinberg_PSD_fatigue (see VARARGIN)

% Choose default command line output for Steinberg_PSD_fatigue
handles.output = hObject;

listbox_unit_Callback(hObject, eventdata, handles);

clear_D(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Steinberg_PSD_fatigue wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Steinberg_PSD_fatigue_OutputFcn(hObject, eventdata, handles) 
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

delete(Steinberg_PSD_fatigue);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end    




n=get(handles.listbox_unit,'Value');

FS=get(handles.edit_input_array,'String');
THF=evalin('base',FS); 

disp(' ');
disp('***************************************************');

out1=sprintf('\n PSD filename:  %s \n',FS);
disp(out1);

[~,rms]=calculate_PSD_slopes(THF(:,1),THF(:,2));

if(n==1)
    out1=sprintf(' Overall level = %8.4g inch RMS \n',rms);
else
    out1=sprintf(' Overall level = %8.4g mm RMS \n',rms);    
end

disp(out1);


Z=str2num(get(handles.edit_Z,'String'));


if(n==2)  % mm to inch conversion
    scale=25.4;
    THF(:,2)=THF(:,2)/scale^2;
    Z=Z/scale;
end

T=str2num(get(handles.edit_duration,'String'));

[~,amp,EP]=Dirlik_cycles(THF,T);

num=length(amp);

rd_Z_ratio = amp/Z;

CDI=0;

for i=1:num
    
    cycles=1;
%
    if(rd_Z_ratio(i)>=6)
        disp(' Failure:  relative displacement exceeds upper limit. ');
        warndlg(' Failure:  relative displacement exceeds upper limit. ');
        return
    end
%
    N=10^(6.05-6.4*log10(rd_Z_ratio(i)));
%
    d=(cycles/N);    
    
    CDI=CDI+d;
end

out44=sprintf(' Max amp = %8.4g \n',max(amp));
disp(out44);

out00=sprintf(' Max rd_Z_ratio = %8.4g \n',max(rd_Z_ratio));
disp(out00);

out11=sprintf(' Duration = %g sec   Cycles=%9.5g \n',T,T*EP);
disp(out11);

out22=sprintf(' CDI = %8.4g \n',CDI);
disp(out22);

rate=CDI/T;

out33=sprintf(' Damage Rate = %8.4g per sec\n',rate);
disp(out33);

tfail=(0.7/rate);

out2=sprintf(' Time to failure (R=0.7):  %8.4g sec   Cycles=%9.5g \n',tfail,tfail*EP);
disp(out2);

h=floor(tfail/3600);
m=floor((tfail-h*3600)/60);
s=floor( tfail-h*3600-m*60);


string=sprintf('                          = %g hr %g min %g sec \n',h,m,s);
disp(string)


dsec=3600*24;
ysec=dsec*365;

y=floor(tfail/ysec);
d=floor((tfail-y*ysec)/dsec);

h=floor((tfail-y*ysec-d*dsec)/3600);
m=floor((tfail-y*ysec-d*dsec-h*3600)/60);
s=floor( tfail-y*ysec-d*dsec-h*3600-m*60);



string=sprintf('                          =  %g years %g days %g hr %g min %g sec',y,d,h,m,s);
disp(string);

Ds=sprintf('%8.4g',CDI);

set(handles.edit_damage,'String',Ds,'Enable','on');



   


% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit

n=get(handles.listbox_unit,'Value');

if(n==1)
   set(handles.text_Z,'String','inch (3-sigma)');
else
   set(handles.text_Z,'String','mm (3-sigma)');    
end

clear_D(hObject, eventdata, handles);




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



function edit_Z_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Z as text
%        str2double(get(hObject,'String')) returns contents of edit_Z as a double


% --- Executes during object creation, after setting all properties.
function edit_Z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

clear_D(hObject, eventdata, handles);


function clear_D(hObject, eventdata, handles)

set(handles.edit_damage,'String','');
set(handles.edit_damage,'Enable','off');


% --- Executes on key press with focus on edit_duration and none of its controls.
function edit_duration_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

clear_D(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_Z and none of its controls.
function edit_Z_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Z (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

clear_D(hObject, eventdata, handles);

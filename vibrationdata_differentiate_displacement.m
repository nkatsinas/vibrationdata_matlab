function varargout = vibrationdata_differentiate_displacement(varargin)
% VIBRATIONDATA_DIFFERENTIATE_DISPLACEMENT MATLAB code for vibrationdata_differentiate_displacement.fig
%      VIBRATIONDATA_DIFFERENTIATE_DISPLACEMENT, by itself, creates a new VIBRATIONDATA_DIFFERENTIATE_DISPLACEMENT or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_DIFFERENTIATE_DISPLACEMENT returns the handle to a new VIBRATIONDATA_DIFFERENTIATE_DISPLACEMENT or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_DIFFERENTIATE_DISPLACEMENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_DIFFERENTIATE_DISPLACEMENT.M with the given input arguments.
%
%      VIBRATIONDATA_DIFFERENTIATE_DISPLACEMENT('Property','Value',...) creates a new VIBRATIONDATA_DIFFERENTIATE_DISPLACEMENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_differentiate_displacement_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_differentiate_displacement_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_differentiate_displacement

% Last Modified by GUIDE v2.5 21-Apr-2015 10:40:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_differentiate_displacement_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_differentiate_displacement_OutputFcn, ...
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


% --- Executes just before vibrationdata_differentiate_displacement is made visible.
function vibrationdata_differentiate_displacement_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_differentiate_displacement (see VARARGIN)

% Choose default command line output for vibrationdata_differentiate_displacement
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');
set(handles.listbox_psave,'Value',2);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_differentiate_displacement wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_differentiate_displacement_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_differentiate_displacement);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

displacement=getappdata(0,'displacement');

if(length(displacement)==0)
    warndlg('displacement array does not exist');
    return;
end

dt=getappdata(0,'dt');
iunit=getappdata(0,'iunit');

ay=getappdata(0,'ay');
vy=getappdata(0,'vy');
dy=getappdata(0,'dy');


try
   fig_num=getappdata(0,'fig_num');
catch 
   fig_num=1;
end
 
 
if( length(fig_num)==0)
    fig_num=1;
end

tt=displacement(:,1);
d=displacement(:,2);

[v]=differentiate_function(d,dt);
[a]=differentiate_function(v,dt);

if(iunit==1) % G, in/sec, in
    a=a/386;
end
if(iunit==2) % G, cm/sec, mm
    v=v/10;
    a=a/(9.81*1000);
end
if(iunit==3) % m/sec^2, cm/sec, mm
    v=v/10;
    a=a/1000;
end




hp=figure(fig_num);
fig_num=fig_num+1;
subplot(3,1,1);
plot(tt,d);
ylabel(dy);
grid on;


subplot(3,1,2);
plot(tt,v);
ylabel(vy);
grid on;

subplot(3,1,3);
plot(tt,a);
ylabel(ay);
grid on;
xlabel('Time(sec)');


%%%

psave=get(handles.listbox_psave,'Value');


if(psave==1)
    
    pname='differentiated_data';
    
    
    set(gca,'Fontsize',12);
    print(hp,pname,'-dpng','-r300');
    
    out1=sprintf('\n Plot File:  %s.png',pname);
    disp(out1);
    
    msgbox('Plot file exported to hard drive: differentiated_data.png');
   
end


%%%

a=fix_size(a);
v=fix_size(v);
d=fix_size(d);

aa=[tt a];
vv=[tt v];
dd=[tt d];

setappdata(0,'acceleration',aa);
setappdata(0,'velocity',vv);
setappdata(0,'displacement',dd);

setappdata(0,'fig_num',fig_num);

set(handles.uipanel_save,'Visible','on');


% --- Executes on selection change in listbox_output.
function listbox_output_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output


% --- Executes during object creation, after setting all properties.
function listbox_output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_output,'Value');

if(n==1)
    data=getappdata(0,'acceleration');
end
if(n==2)
    data=getappdata(0,'velocity');
end
if(n==3)
    data=getappdata(0,'displacement');
end

output_name=get(handles.edit_output_array_name,'String');

assignin('base', output_name, data);

h = msgbox('Save Complete'); 





function edit_output_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on selection change in listbox_psave.
function listbox_psave_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_psave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_psave contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_psave


% --- Executes during object creation, after setting all properties.
function listbox_psave_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_psave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

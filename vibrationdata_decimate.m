function varargout = vibrationdata_decimate(varargin)
% VIBRATIONDATA_DECIMATE MATLAB code for vibrationdata_decimate.fig
%      VIBRATIONDATA_DECIMATE, by itself, creates a new VIBRATIONDATA_DECIMATE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_DECIMATE returns the handle to a new VIBRATIONDATA_DECIMATE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_DECIMATE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_DECIMATE.M with the given input arguments.
%
%      VIBRATIONDATA_DECIMATE('Property','Value',...) creates a new VIBRATIONDATA_DECIMATE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_decimate_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_decimate_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_decimate

% Last Modified by GUIDE v2.5 05-Jun-2018 16:51:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_decimate_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_decimate_OutputFcn, ...
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


% --- Executes just before vibrationdata_decimate is made visible.
function vibrationdata_decimate_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_decimate (see VARARGIN)

% Choose default command line output for vibrationdata_decimate
handles.output = hObject;

set(handles.listbox_method,'Value',1);
set(handles.listbox_filter,'Value',1);
set(handles.listbox_factor,'Value',1);

set(handles.pushbutton_calculate,'Enable','off');

set(handles.pushbutton_read_matlab,'Enable','on');
set(handles.edit_input_array,'enable','on')    

set(handles.edit_current_sr,'String','');
set(handles.edit_new_sr,'String','');

listbox_filter_Callback(hObject, eventdata, handles);
 

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_decimate wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_decimate_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

new_data=getappdata(0,'new_data');
  
output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, new_data);

h = msgbox('Save Complete'); 



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



function edit_ylabel_input_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ylabel_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ylabel_input as text
%        str2double(get(hObject,'String')) returns contents of edit_ylabel_input as a double


% --- Executes during object creation, after setting all properties.
function edit_ylabel_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ylabel_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sample_rate(hObject, eventdata, handles)
%
try
    THM=getappdata(0,'THM');
catch
    return; 
end    

t=double(THM(:,1));
y=double(THM(:,2));

n=length(y);

dt=(t(n)-t(1))/(n-1);

csr=1/dt;

setappdata(0,'csr',csr); 

css=sprintf('%10.4g',csr);

set(handles.edit_current_sr,'String',css);

nfactor=1+get(handles.listbox_factor,'Value');

nsr=csr/nfactor;

nss=sprintf('%10.4g',nsr);

set(handles.edit_new_sr,'String',nss);

ss=sprintf('Filter frequency should be < %9.4g Hz',0.8*nsr/2);
set(handles.text_filter,'String',ss);


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

YS_input=get(handles.edit_ylabel_input,'String');

THM=getappdata(0,'THM');
 
sample_rate(hObject, eventdata, handles);

t=double(THM(:,1));
y=double(THM(:,2));


figure(1);
plot(t,y);
grid on;
title('Input Data');
xlabel('Time(sec)');
ylabel(YS_input);

nfactor=1+get(handles.listbox_factor,'Value');

nfilter=get(handles.listbox_filter,'Value');


if(nfilter<=2)
    iphase=1;
    csr=getappdata(0,'csr');
    dt=1/csr;
    
    value_low = get(handles.edit_low,'String');
    
    if isempty(value_low)
        msgbox('Enter lowpass frequency')
        return;
    end     
    
end

if(nfilter==1)
    
    fc=str2num(value_low);
    
%    iband:   1=lowpass  2=highpass  3=bandpass 
%
%    iphase=1  for refiltering for phase correction
%          =2  for no refiltering    

    iband=1;

    fl=fc;
    fh=fc;
    
    [y,mu,sd,rms]=Butterworth_filter_function_alt(y,dt,iband,fl,fh,iphase);    
   
end
if(nfilter==2)
    
    iband=3;
    
    value_high = get(handles.edit_high,'String');
    
    if isempty(value_high)
        msgbox('Enter high frequency')
        return;
    end     
    
    fh=str2num(value_low);
    fl=str2num(value_high);
    
    [y,mu,sd,rms]=Butterworth_filter_function_alt(y,dt,iband,fl,fh,iphase);  
    
end    

tn=t(1:nfactor:end);
yn=y(1:nfactor:end);


tn = fix_size(tn);
yn = fix_size(yn);

new_data=[tn yn];


figure(2);
plot(tn,yn);
grid on;
title('Downsampled Data');
xlabel('Time(sec)');
ylabel(YS_input);


setappdata(0,'new_data',new_data);    
    
set(handles.pushbutton_save,'Enable','on');    
set(handles.edit_output_array,'Enable','on'); 



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(vibrationdata_decimate)


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method


set(handles.pushbutton_calculate,'Enable','off'); 

set(handles.edit_current_sr,'String','');
set(handles.edit_new_sr,'String','');

n=get(hObject,'Value');

set(handles.pushbutton_save,'Enable','off');
set(handles.edit_input_array,'String',' ');


set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');


set(handles.edit_input_array,'enable','off')    
set(handles.pushbutton_read_matlab,'enable','off'); 


if(n==1)
   set(handles.edit_input_array,'enable','on')    
   set(handles.pushbutton_read_matlab,'enable','on');   
else
    
   set(handles.text_input_array_name,'Visible','off');
   set(handles.edit_input_array,'Visible','off');

   set(handles.edit_input_array,'enable','off')
   
   [filename, pathname] = uigetfile('*.*');
   filename = fullfile(pathname, filename);
   fid = fopen(filename,'r');
   THM = fscanf(fid,'%g %g',[2 inf]);
   THM=THM';
    
   setappdata(0,'THM',THM);
   
   sample_rate(hObject, eventdata, handles);
   
   set(handles.pushbutton_calculate,'Enable','on');
   
end



% --- Executes during object creation, after setting all properties.
function listbox_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_filter.
function listbox_filter_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_filter contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_filter

n=get(handles.listbox_filter,'value');


set(handles.text_low,'Visible','off');
set(handles.edit_low,'Visible','off');

set(handles.text_high,'Visible','off');
set(handles.edit_high,'Visible','off');


if(n<=2)
    set(handles.text_low,'Visible','on');
    set(handles.edit_low,'Visible','on');
end


if(n==1)  % lowpass
    set(handles.text_low,'String','Lowpass  Frequency (Hz)');
end
if(n==2)  % bandpass
    set(handles.text_low,'String','Lower Frequency (Hz)');
    set(handles.text_high,'String','Upper Frequency (Hz)');
    
    set(handles.text_high,'Visible','on');
    set(handles.edit_high,'Visible','on');
end      




% --- Executes during object creation, after setting all properties.
function listbox_filter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_low_Callback(hObject, eventdata, handles)
% hObject    handle to edit_low (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_low as text
%        str2double(get(hObject,'String')) returns contents of edit_low as a double




% --- Executes during object creation, after setting all properties.
function edit_low_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_low (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_factor.
function listbox_factor_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_factor contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_factor

sample_rate(hObject, eventdata, handles);




% --- Executes during object creation, after setting all properties.
function listbox_factor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_current_sr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_current_sr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_current_sr as text
%        str2double(get(hObject,'String')) returns contents of edit_current_sr as a double


% --- Executes during object creation, after setting all properties.
function edit_current_sr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_current_sr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_new_sr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_new_sr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_new_sr as text
%        str2double(get(hObject,'String')) returns contents of edit_new_sr as a double


% --- Executes during object creation, after setting all properties.
function edit_new_sr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_new_sr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton_read_matlab.
function pushbutton_read_matlab_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_read_matlab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

FS=get(handles.edit_input_array,'String');
THM=evalin('base',FS);
setappdata(0,'THM',THM);

sample_rate(hObject, eventdata, handles);

set(handles.pushbutton_calculate,'Enable','on'); 


% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_calculate,'Enable','off'); 


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over edit_input_array.
function edit_input_array_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_calculate,'Enable','off'); 



function edit_high_Callback(hObject, eventdata, handles)
% hObject    handle to edit_high (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_high as text
%        str2double(get(hObject,'String')) returns contents of edit_high as a double


% --- Executes during object creation, after setting all properties.
function edit_high_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_high (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

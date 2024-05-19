function varargout = add_trailing_zeros(varargin)
% ADD_TRAILING_ZEROS MATLAB code for add_trailing_zeros.fig
%      ADD_TRAILING_ZEROS, by itself, creates a new ADD_TRAILING_ZEROS or raises the existing
%      singleton*.
%
%      H = ADD_TRAILING_ZEROS returns the handle to a new ADD_TRAILING_ZEROS or the handle to
%      the existing singleton*.
%
%      ADD_TRAILING_ZEROS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ADD_TRAILING_ZEROS.M with the given input arguments.
%
%      ADD_TRAILING_ZEROS('Property','Value',...) creates a new ADD_TRAILING_ZEROS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before add_trailing_zeros_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to add_trailing_zeros_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help add_trailing_zeros

% Last Modified by GUIDE v2.5 13-Mar-2018 17:09:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @add_trailing_zeros_OpeningFcn, ...
                   'gui_OutputFcn',  @add_trailing_zeros_OutputFcn, ...
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


% --- Executes just before add_trailing_zeros is made visible.
function add_trailing_zeros_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to add_trailing_zeros (see VARARGIN)

% Choose default command line output for add_trailing_zeros
handles.output = hObject;

set(handles.pushbutton_calculate,'Enable','off');
set(handles.uipanel_save,'Visible','off');

listbox_method_Callback(hObject, eventdata, handles)


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes add_trailing_zeros wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = add_trailing_zeros_OutputFcn(hObject, eventdata, handles) 
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

delete(add_trailing_zeros);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

THM=getappdata(0,'THM');
LM=get(handles.listbox_method,'Value');

TZ=get(handles.listbox_zero,'Value');

num=str2num(get(handles.edit_number,'String'));


n=getappdata(0,'n');
dur=getappdata(0,'dur');
dt=getappdata(0,'dt');

t=THM(:,1);
a=THM(:,2);

if(LM==1)  %  Total Duration
    
    if(num<=dur)
       warndlg('Total duration must be > input duration'); 
       return; 
    end
    
    m=round(num/dt);
        
else       %  Total Points
    
    if(num<=n)
       warndlg('Total points must be > input points'); 
       return; 
    end
    
    m=num;

end


tt=zeros(m,1);
tt(1:n)=t(1:n);
    
b=zeros(m,1);
b(1:n)=b(1:n)+a(1:n);
    
ijk=1;
    
for i=(n+1):m
    tt(i)=(ijk*dt)+t(n);
    ijk=ijk+1;
end

if(TZ==1)
   tt=tt-t(1); 
end

tt=fix_size(tt);
b=fix_size(b);

setappdata(0,'signal',[tt b]);
set(handles.uipanel_save,'Visible','on');

figure(1);
plot(tt,b);
grid on;
title('Signal with Zero-padding');
xlabel('Time (sec)');



% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'signal');

output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

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


% --- Executes on button press in pushbutton_read.
function pushbutton_read_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_read (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
      FS=get(handles.edit_input_array,'String');
      THM=evalin('base',FS);
%      disp('ref 2')
catch
      warndlg('Unable to read input file','Warning');
      return;
end    

% disp('ref 3')
setappdata(0,'THM',THM);
% disp('ref 4')
set(handles.pushbutton_calculate,'Enable','on');
% disp('ref 5')


y=double(THM(:,2));
n=length(y);
dur=THM(n,1)-THM(1,1);
dt=dur/(n-1);


setappdata(0,'n',n);
setappdata(0,'dur',dur);
setappdata(0,'dt',dt);


sss=sprintf('Duration = %8.4g sec \n Number of Points = %d',dur,n);

set(handles.edit_stats,'String',sss);


msgbox('Data read');


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method


LL=get(handles.listbox_method,'Value');

if(LL==1)
    sss='Enter Total Duration (sec)';
else
    sss='Enter Total Number of Points';   
end

set(handles.text_enter_number,'String',sss);




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



function edit_number_Callback(hObject, eventdata, handles)
% hObject    handle to edit_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_number as text
%        str2double(get(hObject,'String')) returns contents of edit_number as a double


% --- Executes during object creation, after setting all properties.
function edit_number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_stats_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stats as text
%        str2double(get(hObject,'String')) returns contents of edit_stats as a double


% --- Executes during object creation, after setting all properties.
function edit_stats_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_zero.
function listbox_zero_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_zero (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_zero contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_zero


% --- Executes during object creation, after setting all properties.
function listbox_zero_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_zero (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function varargout = vibrationdata_power_transmissibility(varargin)
% VIBRATIONDATA_POWER_TRANSMISSIBILITY MATLAB code for vibrationdata_power_transmissibility.fig
%      VIBRATIONDATA_POWER_TRANSMISSIBILITY, by itself, creates a new VIBRATIONDATA_POWER_TRANSMISSIBILITY or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_POWER_TRANSMISSIBILITY returns the handle to a new VIBRATIONDATA_POWER_TRANSMISSIBILITY or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_POWER_TRANSMISSIBILITY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_POWER_TRANSMISSIBILITY.M with the given input arguments.
%
%      VIBRATIONDATA_POWER_TRANSMISSIBILITY('Property','Value',...) creates a new VIBRATIONDATA_POWER_TRANSMISSIBILITY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_power_transmissibility_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_power_transmissibility_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_power_transmissibility

% Last Modified by GUIDE v2.5 01-Aug-2014 12:12:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_power_transmissibility_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_power_transmissibility_OutputFcn, ...
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


% --- Executes just before vibrationdata_power_transmissibility is made visible.
function vibrationdata_power_transmissibility_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_power_transmissibility (see VARARGIN)

% Choose default command line output for vibrationdata_power_transmissibility
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_power_transmissibility wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_power_transmissibility_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_power_transmissibility);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig_num=1;

nni=get(handles.listbox_interpolate,'Value');

clear length;
%
FS1=strtrim(get(handles.edit_array_1,'String'));
THM1=evalin('base',FS1);
%
FS2=strtrim(get(handles.edit_array_2,'String'));
THM2=evalin('base',FS2);

%
if(THM1(1,1)<=1.0e-12)
    THM1(1,:)=[];
end
if(THM2(1,1)<=1.0e-12)
    THM2(1,:)=[];
end
%

yone=double(THM1(:,2));
xone=double(THM1(:,1));
sz1=size(THM1);
fprintf(' size = %d x %d \n\n',sz1(1),sz1(2));

ytwo=double(THM2(:,2));
xtwo=double(THM2(:,1));
sz2=size(THM2);
fprintf(' size = %d x %d \n\n',sz2(1),sz2(2));
%
if(sz2(1)~=sz1(1))
    disp(' ');
    disp(' size difference ');
    disp(' ');
end
%
df=0.5;
%
iflag=1;

if(sz1(1)==sz2(1))
  
  if( abs(xone(1)-xtwo(1))<0.01)  
    if( abs(xone(sz1(1))-xtwo(sz2(1)))<0.01)   
        iflag=0;
    end
  end
  
  for i=1:sz1(1)
      if(xone(i)~=xtwo(i))
          iflag=1;
      end
  end
  
end

if(iflag==0)
  Q1=THM1;
  Q2=THM2;
else
  if(nni==1)
    Q1 = real_mult_intlin(xone,yone,df);
    Q2 = real_mult_intlin(xtwo,ytwo,df);      
  else    
    Q1 = real_mult_intlog(xone,yone,df);
    Q2 = real_mult_intlog(xtwo,ytwo,df);
  end  
end

f1=Q1(:,1);
a1=Q1(:,2);

f2=Q2(:,1);
a2=Q2(:,2);
%
df2=df/2;
%
ijk=1;
for i=1:length(f1)
    for j=1:length(f2)
        if(abs(f1(i)-f2(j))<df2)
            ab(ijk)=a1(i)/a2(j);
            ff(ijk)=(f1(i)+f2(j))/2.;
            ijk=ijk+1;
            break;
        end
    end
end    
%

ff=fix_size(ff);
ab=fix_size(ab);

trans=[ff ab];

ppp=trans;

t_string=get(handles.edit_title,'String');
y_label=get(handles.edit_yaxis,'String');

fmin=str2num(get(handles.edit_f1,'String'));
fmax=str2num(get(handles.edit_f2,'String')); 

x_label='Frequency (Hz)';

%
[fig_num,h2]=plot_loglog_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax)


setappdata(0,'trans',trans);

set(handles.pushbutton_save,'Enable','on');


function edit_array_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_array_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_array_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_array_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_array_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_array_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_array_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_array_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_array_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_array_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_array_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_array_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'trans');

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



function edit_yaxis_Callback(hObject, eventdata, handles)
% hObject    handle to edit_yaxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_yaxis as text
%        str2double(get(hObject,'String')) returns contents of edit_yaxis as a double


% --- Executes during object creation, after setting all properties.
function edit_yaxis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_yaxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_title_Callback(hObject, eventdata, handles)
% hObject    handle to edit_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_title as text
%        str2double(get(hObject,'String')) returns contents of edit_title as a double


% --- Executes during object creation, after setting all properties.
function edit_title_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_f1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_f1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_f1 as text
%        str2double(get(hObject,'String')) returns contents of edit_f1 as a double


% --- Executes during object creation, after setting all properties.
function edit_f1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_f1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_f2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_f2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_f2 as text
%        str2double(get(hObject,'String')) returns contents of edit_f2 as a double


% --- Executes during object creation, after setting all properties.
function edit_f2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_f2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_interpolate.
function listbox_interpolate_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_interpolate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_interpolate contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_interpolate


% --- Executes during object creation, after setting all properties.
function listbox_interpolate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_interpolate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

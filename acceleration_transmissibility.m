function varargout = acceleration_transmissibility(varargin)
% ACCELERATION_TRANSMISSIBILITY MATLAB code for acceleration_transmissibility.fig
%      ACCELERATION_TRANSMISSIBILITY, by itself, creates a new ACCELERATION_TRANSMISSIBILITY or raises the existing
%      singleton*.
%
%      H = ACCELERATION_TRANSMISSIBILITY returns the handle to a new ACCELERATION_TRANSMISSIBILITY or the handle to
%      the existing singleton*.
%
%      ACCELERATION_TRANSMISSIBILITY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ACCELERATION_TRANSMISSIBILITY.M with the given input arguments.
%
%      ACCELERATION_TRANSMISSIBILITY('Property','Value',...) creates a new ACCELERATION_TRANSMISSIBILITY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before acceleration_transmissibility_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to acceleration_transmissibility_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help acceleration_transmissibility

% Last Modified by GUIDE v2.5 10-Jul-2015 13:37:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @acceleration_transmissibility_OpeningFcn, ...
                   'gui_OutputFcn',  @acceleration_transmissibility_OutputFcn, ...
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


% --- Executes just before acceleration_transmissibility is made visible.
function acceleration_transmissibility_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to acceleration_transmissibility (see VARARGIN)

% Choose default command line output for acceleration_transmissibility
handles.output = hObject;

set(handles.listbox_format,'Value',1);
set(handles.listbox_method,'Value',1);

set(handles.pushbutton_analysis_page,'Enable','off');

set(handles.text_IAN_2,'Visible','off');
set(handles.edit_input_array_2,'Visible','off');
set(handles.edit_input_array_2,'String','');

set(handles.text_IAN_1,'Visible','on');
set(handles.edit_input_array_1,'Visible','on');
set(handles.text_IAN_1,'String','Input Array Name');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes acceleration_transmissibility wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = acceleration_transmissibility_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_input_array_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method
mn_common(hObject, eventdata, handles);

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


% --- Executes on selection change in listbox_format.
function listbox_format_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_format contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_format
mn_common(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_format_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_input_array_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_read_data.
function pushbutton_read_data_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_read_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

YS=get(handles.edit_ylabel,'String');

n=get(handles.listbox_format,'Value');
m=get(handles.listbox_method,'Value');

if(m==1)
%
   FS=get(handles.edit_input_array_1,'String');
   THM_1=evalin('base',FS); 
%
   if(n==1)
      t1=THM_1(:,1);
      t2=t1;      
       a=THM_1(:,2);
       b=THM_1(:,3);
   else
%     
       FS=get(handles.edit_input_array_2,'String');
       THM_2=evalin('base',FS);
%     
       t1=THM_1(:,1);
       t2=THM_2(:,1);
       a=THM_1(:,2);
       b=THM_2(:,2);       
   end
end

if(m==2)
%     
   THM_1=getappdata(0,'THM_1');
%   
   if(n==1)     
     t1=THM_1(:,1);
     t2=t1;
     a=THM_1(:,2);
     b=THM_1(:,3);
   else
%
     THM_2=getappdata(0,'THM_2');
%
       t1=THM_1(:,1);
        a=THM_1(:,2);
       t2=THM_2(:,1);
        b=THM_2(:,2);    
   end
end


%%


figure(1);
plot(t1,a);
grid on;
xlabel('Time(sec)');
ylabel(YS);
title('Input Signal');

figure(2);
plot(t2,b);
grid on;
xlabel('Time(sec)');
ylabel(YS);
title('Response Signal');

%%%

if(m==1)
   num=length(t1);
   dt=(t1(num)-t1(1))/(num-1);
else
   num1=length(t1);
   dt1=(t1(num1)-t1(1))/(num1-1);   
%   
   num2=length(t2);
   dt2=(t2(num2)-t2(1))/(num2-1);  
%
%  Truncate if necessary
%
    if(num1<num2)
        num2=num1;
    end
    if(num2<num1)
        num1=num2;
    end
    num=num1;
%
    pe=abs((dt1-dt2)/dt1);
%
    dt=(dt1+dt2)/2;
%
    if(pe>0.01)
        out1=sprintf('Warning: dt1=%8.4g  dt2=%8.4g ',dt1,dt2);
        msgbox(out1,'Warning','warn');
    end 
%
end
%
THM_C=[t1(1:num) a(1:num) b(1:num)];

setappdata(0,'THM_C',THM_C);
      
set(handles.pushbutton_analysis_page,'Enable','on');




% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(acceleration_transmissibility);


% --- Executes on button press in pushbutton_analysis_page.
function pushbutton_analysis_page_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analysis_page (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.s= acceleration_transmissibility_psd;
set(handles.s,'Visible','on');






function mn_common(hObject, eventdata, handles)

set(handles.pushbutton_analysis_page,'Enable','off');

set(handles.text_IAN_1,'Visible','off');
set(handles.text_IAN_2,'Visible','off');
set(handles.edit_input_array_1,'Visible','off');
set(handles.edit_input_array_2,'Visible','off');
set(handles.edit_input_array_1,'String','');
set(handles.edit_input_array_2,'String','');


n=get(handles.listbox_format,'Value');
m=get(handles.listbox_method,'Value');

if(n==1 && m==1)
    set(handles.text_IAN_1,'Visible','on');
    set(handles.edit_input_array_1,'Visible','on');
    set(handles.edit_text_IAN_1,'String','Input Array Name');
end
if(n==2 && m==1)
    set(handles.text_IAN_1,'Visible','on');
    set(handles.text_IAN_2,'Visible','on');
    set(handles.edit_input_array_1,'Visible','on');
    set(handles.edit_input_array_2,'Visible','on');
    set(handles.text_IAN_1,'String','Input Array Name');
    set(handles.text_IAN_2,'String','Response Array Name');    
end
if(m==2)
%
   if(n==1)
%
      [filename, pathname] = uigetfile('*.*','Select the time history file.');
      filename = fullfile(pathname, filename);
      fid = fopen(filename,'r');
%
      THM_1 = fscanf(fid,'%g %g %g',[3 inf]);
      THM_1=THM_1';
      setappdata(0,'THM_1',THM_1);   
      sz=size(THM_1);
      if(sz(2)~=3)
         errordlg('Input array does not have three columns.','File Error');      
      end
   else
%
      [filename, pathname] = uigetfile('*.*','Select the first time history file.');
      filename = fullfile(pathname, filename);
      fid_1 = fopen(filename,'r');
%
      THM_1 = fscanf(fid_1,'%g %g',[2 inf]);
      THM_1=THM_1';
      setappdata(0,'THM_1',THM_1);
      sz=size(THM_1);
      if(sz(2)~=2)
         errordlg('Input array does not have two columns.','File Error');          
      end      
 %
      [filename, pathname] = uigetfile('*.*','Select the second time history file.');
      filename = fullfile(pathname, filename);
      fid_2 = fopen(filename,'r');
%
      THM_2 = fscanf(fid_2,'%g %g',[2 inf]);
      THM_2=THM_2';
      setappdata(0,'THM_2',THM_2);
      sz=size(THM_2);
      if(sz(2)~=2)
         errordlg('Input array does not have two columns.','File Error');          
      end   
 %
   end
%
end



function edit_ylabel_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ylabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ylabel as text
%        str2double(get(hObject,'String')) returns contents of edit_ylabel as a double


% --- Executes during object creation, after setting all properties.
function edit_ylabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ylabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

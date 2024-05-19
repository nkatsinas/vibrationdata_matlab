function varargout = modal_frf(varargin)
% MODAL_FRF MATLAB code for modal_frf.fig
%      MODAL_FRF, by itself, creates a new MODAL_FRF or raises the existing
%      singleton*.
%
%      H = MODAL_FRF returns the handle to a new MODAL_FRF or the handle to
%      the existing singleton*.
%
%      MODAL_FRF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MODAL_FRF.M with the given input arguments.
%
%      MODAL_FRF('Property','Value',...) creates a new MODAL_FRF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before modal_frf_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to modal_frf_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help modal_frf

% Last Modified by GUIDE v2.5 02-Jul-2013 14:20:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @modal_frf_OpeningFcn, ...
                   'gui_OutputFcn',  @modal_frf_OutputFcn, ...
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


% --- Executes just before modal_frf is made visible.
function modal_frf_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to modal_frf (see VARARGIN)

% Choose default command line output for modal_frf
handles.output = hObject;


set(handles.listbox_format,'Value',1);
set(handles.listbox_method,'Value',1);
set(handles.listbox_analysis,'Value',1);

set(handles.pushbutton_analysis_page,'Enable','off');

set(handles.text_IAN_2,'Visible','off');
set(handles.edit_input_array_2,'Visible','off');
set(handles.edit_input_array_2,'String','');

set(handles.text_IAN_1,'Visible','on');
set(handles.edit_input_array_1,'Visible','on');
set(handles.text_IAN_1,'String','Input Array Name');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes modal_frf wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = modal_frf_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on selection change in listbox_analysis.
function listbox_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis


% --- Executes during object creation, after setting all properties.
function listbox_analysis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_read_data.
function pushbutton_read_data_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_read_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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

if(length(t1)~=length(t2))
    warndlg('Array lengths not equal');
    return;
end


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
    pe=abs((dt1-dt2)/dt1);
%
    dt=(dt1+dt2)/2;
%
    if(pe>0.01)
        out1=sprintf('Warning: dt1=%8.4g  dt2=%8.4g ',dt1,dt2);
        msgbox(out1,'Warning','warn');
        return;
    end 
%
end
%

if(n==2)
% 
    num1=length(t1);
    num2=length(t2);
    num=min([num1 num2]);
%    
end

figure(1);
plot(t1,a);
grid on;
xlabel('Time(sec)');
ylabel(' ');
title('Force Signal');

figure(2);
plot(t2,b);
grid on;
xlabel('Time(sec)');
ylabel(' ');
title('Response Signal');

THM_C=[t1(1:num) a(1:num) b(1:num)];

setappdata(0,'THM_C',THM_C);
      
set(handles.pushbutton_analysis_page,'Enable','on');



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(modal_frf);

% --- Executes on button press in pushbutton_analysis_page.
function pushbutton_analysis_page_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analysis_page (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

p=get(handles.listbox_analysis,'Value');

if(p==1)
    handles.s= modal_frf_ensemble;
else
    handles.s= modal_frf_single;
end

set(handles.s,'Visible','on');


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
    set(handles.text_IAN_1,'String','Input Common Array Name');
end
if(n==2 && m==1)
    set(handles.text_IAN_1,'Visible','on');
    set(handles.text_IAN_2,'Visible','on');
    set(handles.edit_input_array_1,'Visible','on');
    set(handles.edit_input_array_2,'Visible','on');
    set(handles.text_IAN_1,'String','Input Force Array Name');
    set(handles.text_IAN_2,'String','Input Response Array Name');    
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
      [filename, pathname] = uigetfile('*.*','Select the force time history file.');
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
      [filename, pathname] = uigetfile('*.*','Select the response time history file.');
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

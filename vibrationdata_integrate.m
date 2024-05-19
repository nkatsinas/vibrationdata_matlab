function varargout = vibrationdata_integrate(varargin)
% VIBRATIONDATA_INTEGRATE MATLAB code for vibrationdata_integrate.fig
%      VIBRATIONDATA_INTEGRATE, by itself, creates a new VIBRATIONDATA_INTEGRATE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_INTEGRATE returns the handle to a new VIBRATIONDATA_INTEGRATE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_INTEGRATE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_INTEGRATE.M with the given input arguments.
%
%      VIBRATIONDATA_INTEGRATE('Property','Value',...) creates a new VIBRATIONDATA_INTEGRATE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_integrate_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_integrate_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_integrate

% Last Modified by GUIDE v2.5 26-Jun-2014 13:43:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_integrate_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_integrate_OutputFcn, ...
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


% --- Executes just before vibrationdata_integrate is made visible.
function vibrationdata_integrate_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_integrate (see VARARGIN)

% Choose default command line output for vibrationdata_integrate
handles.output = hObject;


set(handles.listbox_method,'Value',1);
set(handles.edit_input_array,'Visible','on');
set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Enable','on');
set(handles.text_input_array_name,'Enable','on');

set(handles.listbox_scale_factor,'Value',2);
set(handles.edit_scale_factor,'Enable','on');


set(handles.pushbutton_save,'Enable','off');
set(handles.edit_output_array,'Enable','off');
set(handles.edit_fc,'Enable','Off');


set(handles.listbox_trend_removal,'Value',1);
set(handles.listbox_trend_removal_post,'Value',1);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_integrate wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_integrate_OutputFcn(hObject, eventdata, handles) 
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

integ_th=getappdata(0,'integ_th');

output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, integ_th);

h = msgbox('Save Complete') 




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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


set(handles.pushbutton_save,'Enable','On');    
set(handles.edit_output_array,'Enable','On'); 


m=get(handles.listbox_scale_factor,'Value');

if(m==2)
%    
    sp=get(handles.edit_scale_factor,'String');
%    
    if( isempty(sp) )
        msgbox('Enter Scale Factor');
        return;
    else
        scale=str2num(sp);
    end    
end


YS_input=get(handles.edit_ylabel_input,'String');
YS_output=get(handles.edit_ylabel_output,'String');

k=get(handles.listbox_method,'Value');
 
if(k==1)
  FS=get(handles.edit_input_array,'String');
  THM=evalin('base',FS);   
else
  THM=getappdata(0,'THM');
end

tt=THM(:,1);


y=double(THM(:,2));

n=length(y);

dur=THM(n,1)-THM(1,1);

dt=dur/(n-1);


q=get(handles.listbox_trend_removal,'Value');

if(q==2)
    y=y-mean(y);
end
if(q==3)
    y=detrend(y);    
end
if(q==4)
    fc=str2num(get(handles.edit_fc,'String'));
    y=detrend(y);      
    [y]=Butterworth_filter_highpass_function(y,fc,dt);    
end

v=zeros(n,1);
v(1)=y(1)*dt/2;

for i=2:(n-1)
    v(i)=v(i-1)+y(i)*dt;
end
v(n)=v(n-1)+y(n)*dt/2;


v=fix_size(v);

mw=get(handles.listbox_trend_removal_post,'Value');

if(mw==2)
    v=v-mean(v);    
end    
if(mw==3)
    v=detrend(v);        
end 
if(mw==4)
    n = 2;
    p = polyfit(tt,v,n);
    v= v - (  p(1)*tt.^2 + p(2)*tt + p(3));
end 
if(mw==5)
    n = 3;
    p = polyfit(tt,v,n);
    v= v - (  p(1)*tt.^3 + p(2)*tt.^2 + p(3)*tt + p(4));
end


if(m==2)
    v=v*scale;
end

    figure(1);
    plot(THM(:,1),THM(:,2));
    title('Input Time History');
    xlabel(' Time(sec) ')
    ylabel(YS_input)
    grid on;

    figure(2);
    plot(THM(:,1),v);
    title('Integrated Time History');
    xlabel(' Time(sec) ')
    ylabel(YS_output)
    grid on;



integ_th=[THM(:,1),v];    
    
setappdata(0,'integ_th',integ_th);    
    
  



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(vibrationdata_integrate)

% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method
n=get(hObject,'Value');

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');

if(n==1)
   set(handles.edit_input_array,'enable','on') 
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



function edit_ylabel_output_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ylabel_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ylabel_output as text
%        str2double(get(hObject,'String')) returns contents of edit_ylabel_output as a double


% --- Executes during object creation, after setting all properties.
function edit_ylabel_output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ylabel_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_scale_factor.
function listbox_scale_factor_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_scale_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_scale_factor contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_scale_factor
n=get(hObject,'Value');

set(handles.pushbutton_save,'Enable','off'); 

if(n==2)
   set(handles.edit_scale_factor,'Enable','on'); 
else
   set(handles.edit_scale_factor,'Enable','off');  
end



% --- Executes during object creation, after setting all properties.
function listbox_scale_factor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_scale_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_scale_factor_Callback(hObject, eventdata, handles)
% hObject    handle to edit_scale_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_scale_factor as text
%        str2double(get(hObject,'String')) returns contents of edit_scale_factor as a double


% --- Executes during object creation, after setting all properties.
function edit_scale_factor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_scale_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_trend_removal.
function listbox_trend_removal_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_trend_removal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_trend_removal contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_trend_removal

n=get(hObject,'Value');

set(handles.edit_fc,'Enable','Off'); 
set(handles.edit_fc,'String',' '); 

if(n==4)
    set(handles.edit_fc,'Enable','On');    
end


% --- Executes during object creation, after setting all properties.
function listbox_trend_removal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_trend_removal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over listbox_trend_removal.
function listbox_trend_removal_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to listbox_trend_removal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit_fc_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fc as text
%        str2double(get(hObject,'String')) returns contents of edit_fc as a double


% --- Executes during object creation, after setting all properties.
function edit_fc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_trend_removal_post.
function listbox_trend_removal_post_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_trend_removal_post (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_trend_removal_post contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_trend_removal_post


% --- Executes during object creation, after setting all properties.
function listbox_trend_removal_post_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_trend_removal_post (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function varargout = Steinberg_TH_fatigue(varargin)
% STEINBERG_TH_FATIGUE MATLAB code for Steinberg_TH_fatigue.fig
%      STEINBERG_TH_FATIGUE, by itself, creates a new STEINBERG_TH_FATIGUE or raises the existing
%      singleton*.
%
%      H = STEINBERG_TH_FATIGUE returns the handle to a new STEINBERG_TH_FATIGUE or the handle to
%      the existing singleton*.
%
%      STEINBERG_TH_FATIGUE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STEINBERG_TH_FATIGUE.M with the given input arguments.
%
%      STEINBERG_TH_FATIGUE('Property','Value',...) creates a new STEINBERG_TH_FATIGUE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Steinberg_TH_fatigue_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Steinberg_TH_fatigue_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Steinberg_TH_fatigue

% Last Modified by GUIDE v2.5 10-Nov-2014 16:25:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Steinberg_TH_fatigue_OpeningFcn, ...
                   'gui_OutputFcn',  @Steinberg_TH_fatigue_OutputFcn, ...
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


% --- Executes just before Steinberg_TH_fatigue is made visible.
function Steinberg_TH_fatigue_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Steinberg_TH_fatigue (see VARARGIN)

% Choose default command line output for Steinberg_TH_fatigue
handles.output = hObject;

set(handles.listbox_method,'Value',1);

listbox_method_Callback(hObject, eventdata, handles);

listbox_unit_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Steinberg_TH_fatigue wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Steinberg_TH_fatigue_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox_numerical_engine.
function listbox_numerical_engine_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_numerical_engine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_numerical_engine contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_numerical_engine


% --- Executes during object creation, after setting all properties.
function listbox_numerical_engine_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_numerical_engine (see GCBO)
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


function clear_D(hObject, eventdata, handles)

set(handles.edit_damage,'String','');
set(handles.edit_damage,'Enable','off');


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method

clear_D(hObject, eventdata, handles);

n=get(handles.listbox_method,'Value');

set(handles.edit_input_array,'String',' ');

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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

num_eng=get(handles.listbox_numerical_engine,'Value');

k=get(handles.listbox_method,'Value')
 
if(k==1)
  FS=get(handles.edit_input_array,'String');
  THM=evalin('base',FS);   
else
  THM=getappdata(0,'THM');
end

n=get(handles.listbox_unit,'Value');


figure(1);
plot(THM(:,1),THM(:,2));
title('Relative Displacement');
xlabel('Time(sec)');
grid on;
if(n==1)
    ylabel('Rel Disp (in)');
    YS='Rel Disp (in)';
else
    ylabel('Rel Disp (mm)');
    YS='Rel Disp (mm)';
end



scale=25.4;

Z=str2num(get(handles.edit_Z,'String'));


if(n==2)
    THM(:,2)=THM(:,2)/scale;
    Z=Z/scale;
end





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(num_eng==1)
    ndf=2;
    [range_cycles,~]=vibrationdata_rainflow_function(THM,YS,ndf);
    amp_cycles=[range_cycles(:,1)/2 range_cycles(:,2)];
else

%
    y=THM(:,2); 
                                     
    [ac1,ac2,~]=rainflow_basic_dyn_mex(y);                                 
                                     
%
    sz=size(ac1);
    if(sz(2)>sz(1))
        ac1=ac1';
        ac2=ac2';
    end
%
    amp_cycles=[ ac1 ac2];
    
%    range_cycles=[2*amp_cycles(:,1) amp_cycles(:,2)];
%    
    clear ac1;
    clear ac2;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
end

amp=amp_cycles(:,1);
cycles=amp_cycles(:,2);

rd_Z_ratio = amp/Z;

nn=length(THM(:,1));

T=THM(nn,1)-THM(1,1);

num=length(amp);

CDI=0;

for i=1:num
%
    if(rd_Z_ratio(i)>=6)
        disp(' Failure:  relative displacement exceeds upper limit. ');
        warndlg(' Failure:  relative displacement exceeds upper limit. ');
        return
    end
%
    N=10^(6.05-6.4*log10(rd_Z_ratio(i)));
%
    d=(cycles(i)/N);    
    
    CDI=CDI+d;
end

EP=sum(cycles)/T;

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

out2=sprintf(' Time to failure = %8.4g sec   Cycles=%9.5g \n',tfail,tfail*EP);
disp(out2);

h=floor(tfail/3600);
m=floor((tfail-h*3600)/60);
s=floor( tfail-h*3600-m*60);


string=sprintf('                 =  %g hr %g min %g sec \n',h,m,s);
disp(string)


dsec=3600*24;
ysec=dsec*365;

y=floor(tfail/ysec);
d=floor((tfail-y*ysec)/dsec);

h=floor((tfail-y*ysec-d*dsec)/3600);
m=floor((tfail-y*ysec-d*dsec-h*3600)/60);
s=floor( tfail-y*ysec-d*dsec-h*3600-m*60);



string=sprintf('                 =  %g years %g days %g hr %g min %g sec',y,d,h,m,s);
disp(string)

Ds=sprintf('%8.4g',CDI);

set(handles.edit_damage,'String',Ds,'Enable','on');



%


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(Steinberg_TH_fatigue);


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


% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_D(hObject, eventdata, handles);


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

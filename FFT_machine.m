function varargout = FFT_machine(varargin)
% FFT_MACHINE MATLAB code for FFT_machine.fig
%      FFT_MACHINE, by itself, creates a new FFT_MACHINE or raises the existing
%      singleton*.
%
%      H = FFT_MACHINE returns the handle to a new FFT_MACHINE or the handle to
%      the existing singleton*.
%
%      FFT_MACHINE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FFT_MACHINE.M with the given input arguments.
%
%      FFT_MACHINE('Property','Value',...) creates a new FFT_MACHINE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FFT_machine_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FFT_machine_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FFT_machine

% Last Modified by GUIDE v2.5 03-Jul-2013 14:26:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FFT_machine_OpeningFcn, ...
                   'gui_OutputFcn',  @FFT_machine_OutputFcn, ...
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


% --- Executes just before FFT_machine is made visible.
function FFT_machine_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FFT_machine (see VARARGIN)

% Choose default command line output for FFT_machine
handles.output = hObject;

set(handles.listbox_frequency_unit,'Value',1);

set(handles.listbox_output,'Value',1);
set(handles.listbox_method,'Value',1);
%
set(handles.edit_output_filename,'Enable','off');
set(handles.pushbutton_save,'Enable','off');

set(handles.listbox_mean_removal,'Value',1);
set(handles.listbox_window,'Value',1);

set(handles.listbox_output_units,'Value',1);


%% set(handles.listbox_output,'Enable','off');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FFT_machine wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FFT_machine_OutputFcn(hObject, eventdata, handles) 
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


n=get(handles.listbox_output,'Value');

if(n==1)
    data=getappdata(0,'acceleration_FFT'); 
end
if(n==2)
    data=getappdata(0,'velocity_FFT'); 
end
if(n==3)
    data=getappdata(0,'displacement_FFT'); 
end

output_name=get(handles.edit_output_filename,'String');
assignin('base', output_name,data);

h = msgbox('Save Complete'); 

function edit_output_filename_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_filename as text
%        str2double(get(hObject,'String')) returns contents of edit_output_filename as a double


% --- Executes during object creation, after setting all properties.
function edit_output_filename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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

set(handles.edit_output_filename,'Enable','off');
set(handles.listbox_output,'Enable','off');

set(handles.pushbutton_save,'Enable','off');

set(handles.edit_input_array,'String',' ');

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


set(handles.edit_output_filename,'Enable','on');
set(handles.listbox_output,'Enable','on');
set(handles.pushbutton_save,'Enable','on');

k=get(handles.listbox_method,'Value');
 
if(k==1)
  FS=get(handles.edit_input_array,'String');
  THM=evalin('base',FS);   
else
  THM=getappdata(0,'THM');
end

t=THM(:,1);
amp=double(THM(:,2));

fig_num=1;
figure(fig_num);
fig_num=fig_num+1;
plot(t,amp);
grid on;
xlabel('Time (sec)');
ylabel('Accel (G)');
title('Time History');


n=length(amp);
dur=THM(n,1)-THM(1,1);
dt=dur/(n-1);

N=2^floor(log(n)/log(2));

df=1/(N*dt);

m_choice=get(handles.listbox_mean_removal,'Value');

h_choice=get(handles.listbox_window,'Value');

if(h_choice==2)
    m_choice=1;
end

ifru=get(handles.listbox_frequency_unit,'Value');
iu=get(handles.listbox_output_units,'Value');

%%%%%%%%%%%%%%

sfmin=get(handles.edit_fmin,'String');
sfmax=get(handles.edit_fmax,'String');


if isempty(sfmin)
    string=sprintf('%8.4g',df);
    set(handles.edit_fmin,'String',string); 
    sfmin=get(handles.edit_fmin,'String');    
end

if isempty(sfmax)
    sr=1/dt;
    nyf=sr/2;    
    string=sprintf('%8.4g',nyf);
    set(handles.edit_fmax,'String',string);
    sfmax=get(handles.edit_fmax,'String');    
end

fmin=str2num(sfmin);
fmax=str2num(sfmax);

%%%%%%%%%%%%%%

[freq,full,phase,complex_FFT]=full_FFT_core(m_choice,h_choice,amp,N,dt);

%
    if(ifru==2)
        freq=freq*60;
    end
%
    clear accel_FFT;
    accel_FFT=[freq full];
    velox_FFT=accel_FFT;
     disp_FFT=accel_FFT;
%
    n=length(freq);
%    
    for i=1:n
        omegan=2*pi*freq(i);
        velox_FFT(i,2)= velox_FFT(i,2)/omegan;  
         disp_FFT(i,2)=2*disp_FFT(i,2)/omegan^2;    
    end
%
    if(iu==1)
        velox_FFT(:,2)= 386*velox_FFT(:,2);    
         disp_FFT(:,2)= 386*disp_FFT(:,2);         
    else
        velox_FFT(:,2)= 9.81*1000*velox_FFT(:,2);    
         disp_FFT(:,2)= 9.81*1000*disp_FFT(:,2);         
    end
%
    ff=freq;
    for i=n:-1:1
        if(ff(i)<1.0)
            ff(i)=[];
            velox_FFT(i,:)=[];
            disp_FFT(i,:)=[];
        end
    end
%
    if(ifru==1)
       flabel='Hz';
       xplabel=sprintf('Frequency (Hz)');       
    else
       flabel='cycles/min';    
       xplabel=sprintf('Frequency (cycles/min)');       
    end
%

%%%%%%%%%%%%%%

    freq=fix_size(freq);
    full=fix_size(full);

    figure(fig_num);
    fig_num=fig_num+1;
    plot(freq,full)
    acceleration_FFT=[freq full];
    ylabel(' Accel (G)');
    xlabel(xplabel);
    grid on; 
    zoom on;
    [y1,y2,RMS]=find_log_plot_limits(fmin,fmax,accel_FFT);   
    axis([fmin fmax  y1 y2]);
    out4=sprintf(' Acceleration FFT Magnitude   Overall %7.3g GRMS',RMS);
    title(out4);   
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');    
%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(ff,velox_FFT(:,2))
    if(iu==1)
        ylabel(' Velocity (in/sec)');
    else
        ylabel(' Velocity (mm/sec)');        
    end
    xlabel(xplabel);
    grid on; 
    zoom on;
    [y1,y2,RMS]=find_log_plot_limits(fmin,fmax,velox_FFT);    
    axis([fmin fmax y1 y2]);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
%
    disp(' ');
    disp(' Overall velocity RMS within plotted frequency limits: ');
    if(iu==1)
       out1=sprintf('  %7.3g in/sec RMS  ',RMS); 
       out4=sprintf(' Velocity FFT Magnitude   Overall %7.3g in/sec RMS',RMS); 
    else
       out1=sprintf('  %7.43 mm/sec RMS  ',RMS);  
       out4=sprintf(' Velocity FFT Magnitude   Overall %7.3g mm/sec RMS',RMS);        
    end
    disp(out1);
    title(out4);
%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(ff,disp_FFT(:,2))
    [y1,y2,~]=find_log_plot_limits(fmin,fmax,disp_FFT);
    axis([fmin fmax  y1 y2]);  
    dFF=[disp_FFT(:,1) 0.5*disp_FFT(:,2)];
    [~,~,RMS]=find_log_plot_limits(fmin,fmax,dFF);
    if(iu==1)
        ylabel(' Displacement (in pk-pk)');
        out4=sprintf(' Displacement FFT Magnitude   Overall %7.3g in RMS',RMS);         
    else
        ylabel(' Displacement (mm pk-pk)');
        out4=sprintf(' Displacement FFT Magnitude   Overall %7.3g mm RMS',RMS);        
    end
    xlabel(xplabel);
    title(out4);
    grid on; 
    zoom on;
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
%
    setappdata(0,'acceleration_FFT',acceleration_FFT); 
    setappdata(0,'velocity_FFT',velox_FFT); 
    setappdata(0,'displacement_FFT',disp_FFT);     

%%%%%%%%%%%%%%


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(FFT_machine);


% --- Executes on selection change in listbox_mean_removal.
function listbox_mean_removal_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_mean_removal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_mean_removal contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_mean_removal


% --- Executes during object creation, after setting all properties.
function listbox_mean_removal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_mean_removal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_window.
function listbox_window_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_window contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_window


% --- Executes during object creation, after setting all properties.
function listbox_window_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fmin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmin as text
%        str2double(get(hObject,'String')) returns contents of edit_fmin as a double


% --- Executes during object creation, after setting all properties.
function edit_fmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmax as text
%        str2double(get(hObject,'String')) returns contents of edit_fmax as a double


% --- Executes during object creation, after setting all properties.
function edit_fmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_frequency_unit.
function listbox_frequency_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_frequency_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_frequency_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_frequency_unit


% --- Executes during object creation, after setting all properties.
function listbox_frequency_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_frequency_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_output_units.
function listbox_output_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output_units


% --- Executes during object creation, after setting all properties.
function listbox_output_units_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function varargout = acoustic_seismic_coupling(varargin)
% ACOUSTIC_SEISMIC_COUPLING MATLAB code for acoustic_seismic_coupling.fig
%      ACOUSTIC_SEISMIC_COUPLING, by itself, creates a new ACOUSTIC_SEISMIC_COUPLING or raises the existing
%      singleton*.
%
%      H = ACOUSTIC_SEISMIC_COUPLING returns the handle to a new ACOUSTIC_SEISMIC_COUPLING or the handle to
%      the existing singleton*.
%
%      ACOUSTIC_SEISMIC_COUPLING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ACOUSTIC_SEISMIC_COUPLING.M with the given input arguments.
%
%      ACOUSTIC_SEISMIC_COUPLING('Property','Value',...) creates a new ACOUSTIC_SEISMIC_COUPLING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before acoustic_seismic_coupling_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to acoustic_seismic_coupling_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help acoustic_seismic_coupling

% Last Modified by GUIDE v2.5 17-Aug-2020 13:39:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @acoustic_seismic_coupling_OpeningFcn, ...
                   'gui_OutputFcn',  @acoustic_seismic_coupling_OutputFcn, ...
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


% --- Executes just before acoustic_seismic_coupling is made visible.
function acoustic_seismic_coupling_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to acoustic_seismic_coupling (see VARARGIN)

% Choose default command line output for acoustic_seismic_coupling
handles.output = hObject;


set(handles.pushbutton_save,'Enable','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes acoustic_seismic_coupling wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = acoustic_seismic_coupling_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig_num=1;

K=str2double(get(handles.edit_K,'String'));

FS=get(handles.edit_input_array,'String');
THM=evalin('base',FS);   

ipress=1;


dB=THM(:,2);
%
[oadb]=oaspl_function(dB);
%
out1=sprintf('\n  Overall Level = %8.4g dB \n',oadb);
disp(out1)
disp('  ');
disp(' zero dB Reference = 20 micro Pascal ');
disp('  ');
%
figure(fig_num);
fig_num=fig_num+1;
%
plot(THM(:,1),THM(:,2));
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','lin')
grid on;
out1=sprintf(' One-Third Octave Sound Pressure Level  OASPL = %8.4g dB ',oadb);
title(out1)
xlabel(' Center Frequency (Hz) ');
ylabel(' SPL (dB) ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(ipress==1)
    reference = 2.9e-09;
end
if(ipress==2)
    reference = 20.e-06;
end
if(ipress==3) 
    reference = 20.;
end
%
fc=THM(:,1);
spl=THM(:,2);
%
rms=0.;
%   
num=length(fc);
psd=zeros(num,1);
%
%
delta=(2.^(1./6.)) - 1./(2.^(1./6.));
%
for i=1:num    
%	
    if( spl(i) >= 1.0e-50)
%		
        pressure_rms=reference*(10.^(spl(i)/20.) );
%
		df=fc(i)*delta;
%
        if( df > 0. )	
            psd(i)=(pressure_rms^2.)/df;
			rms=rms+psd(i)*df;
        end
    end
end
%
%
rms=sqrt(rms);

if(ipress==1)
    disp(' Dimensions are: freq(Hz) & PSD(psi^2/Hz) ');
    ylab='Pressure (psi^2/Hz)';
    tstring=sprintf('Pressure Power Spectral Density  %8.4g psi rms overall',rms);
end
if(ipress==2)
    disp(' Dimensions are: freq(Hz) & PSD(Pascal^2/Hz) ');
    ylab='Pressure (Pascal^2/Hz)'; 
    tstring=sprintf('Pressure Power Spectral Density  %8.4g Pa rms overall',rms);    
end
if(ipress==3)
    disp(' Dimensions are: freq(Hz) & PSD(micro Pascal^2/Hz) ');
    ylab='Pressure (micro Pascal^2/Hz)';     
    tstring=sprintf('Pressure Power Spectral Density  %8.4g micro Pa rms overall',rms);    
end

%
%     
figure(fig_num);
fig_num=fig_num+1;
plot(fc,psd);
xlabel('Frequency (Hz)');
ylabel(ylab);
title(tstring);
grid on;
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log')

%%%%%%%

velox_psd=K^2*psd;
accel_psd=zeros(num,1);

for i=1:num
    omega2=(2*pi*fc(i))^2;
    accel_psd(i)=velox_psd(i)*omega2/386^2;
end

fmin=str2double(get(handles.edit_fmin,'String'));
fmax=str2double(get(handles.edit_fmax,'String'));

[~,i]=min(abs(fc-fmin));
[~,j]=min(abs(fc-fmax));        

fc=fc(i:j);
velox_psd=velox_psd(i:j);
accel_psd=accel_psd(i:j);

[~,vrms] = calculate_PSD_slopes(fc,velox_psd);
[~,grms] = calculate_PSD_slopes(fc,accel_psd);


velox_psd=[fc velox_psd];
accel_psd=[fc accel_psd];

%%%%%%%

md=6;
x_label='Frequency (Hz)';
fmin=fc(1);
fmax=fc(end);

t_string=sprintf('Velocity PSD   %7.3g in/sec RMS overall',vrms);
y_label='Vel ((in/sec)^2/Hz)';
ppp=velox_psd;
[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

t_string=sprintf('Acceleration PSD   %7.3g GRMS overall',grms);
y_label='Accel (G^2/Hz)';
ppp=accel_psd;
[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

%%%%%%%

set(handles.pushbutton_save,'Enable','on');

setappdata(0,'accel_psd',accel_psd);
setappdata(0,'velox_psd',velox_psd);

% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(acoustic_seismic_coupling);



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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_output_PSD,'Value');

if(n==1)
   data=getappdata(0,'accel_psd'); 
else
   data=getappdata(0,'velox_psd'); 
end

output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 


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
set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');

n=get(hObject,'Value');

if(n==1)
   set(handles.edit_input_array,'enable','on') 
else
   set(handles.edit_input_array,'enable','off')
   
   set(handles.text_input_array_name,'Visible','off');
   set(handles.edit_input_array,'Visible','off');   
   
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


% --- Executes on selection change in listbox_dimension.
function listbox_dimension_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_dimension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_dimension contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_dimension


% --- Executes during object creation, after setting all properties.
function listbox_dimension_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_dimension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_output_PSD.
function listbox_output_PSD_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output_PSD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output_PSD contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output_PSD


% --- Executes during object creation, after setting all properties.
function listbox_output_PSD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output_PSD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_K_Callback(hObject, eventdata, handles)
% hObject    handle to edit_K (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_K as text
%        str2double(get(hObject,'String')) returns contents of edit_K as a double


% --- Executes during object creation, after setting all properties.
function edit_K_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_K (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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

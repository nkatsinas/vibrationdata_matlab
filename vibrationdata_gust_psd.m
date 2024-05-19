function varargout = gust_psd(varargin)
% GUST_PSD MATLAB code for gust_psd.fig
%      GUST_PSD, by itself, creates a new GUST_PSD or raises the existing
%      singleton*.
%
%      H = GUST_PSD returns the handle to a new GUST_PSD or the handle to
%      the existing singleton*.
%
%      GUST_PSD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUST_PSD.M with the given input arguments.
%
%      GUST_PSD('Property','Value',...) creates a new GUST_PSD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gust_psd_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gust_psd_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gust_psd

% Last Modified by GUIDE v2.5 14-Aug-2014 10:53:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gust_psd_OpeningFcn, ...
                   'gui_OutputFcn',  @gust_psd_OutputFcn, ...
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


% --- Executes just before gust_psd is made visible.
function gust_psd_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gust_psd (see VARARGIN)

% Choose default command line output for gust_psd
handles.output = hObject;

set(handles.listbox_destination,'Value',1);
set(handles.listbox_save_type,'Value',2);

set(handles.listbox_destination,'Enable','off');
set(handles.listbox_save_type,'Enable','off');

set(handles.listbox_units,'Value',1);
set(handles.edit_speed_altitude,'String','85');


set(handles.listbox_profile,'Value',1);
set(handles.listbox_axis,'Value',1);
set(handles.listbox_velox_method,'Value',1);

set(handles.edit_fmin,'String','0.01');
set(handles.edit_fmax,'String','100');

set(handles.pushbutton_Save_PSD,'Enable','off');

set(handles.edit_output_name,'Visible','on');
set(handles.edit_output_name,'String','');

set(handles.text_array_name,'Enable','on');

set(handles.pushbutton_th,'Visible','off');

speed_title(hObject, eventdata, handles)

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gust_psd wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gust_psd_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units



speed_title(hObject, eventdata, handles);



% --- Executes during object creation, after setting all properties.
function listbox_units_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_profile.
function listbox_profile_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_profile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_profile contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_profile


% --- Executes during object creation, after setting all properties.
function listbox_profile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_profile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_axis.
function listbox_axis_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_axis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_axis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_axis


% --- Executes during object creation, after setting all properties.
function listbox_axis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_axis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_gust_length_Callback(hObject, eventdata, handles)
% hObject    handle to edit_gust_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_gust_length as text
%        str2double(get(hObject,'String')) returns contents of edit_gust_length as a double


% --- Executes during object creation, after setting all properties.
function edit_gust_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gust_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_velox_method.
function listbox_velox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_velox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_velox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_velox_method

speed_title(hObject, eventdata, handles);


function speed_title(hObject, eventdata, handles)

n=get(handles.listbox_units,'Value');
m=get(handles.listbox_velox_method,'Value');

set(handles.edit_speed_altitude,'String','');

if(n==1)     % English
    if(m==1) % speed
        set(handles.text_speed_altitude,'String','Enter Gust Speed RMS (ft/sec)');  
        set(handles.edit_speed_altitude,'String','85');
    
    else     % altitude
        set(handles.text_speed_altitude,'String','Enter Altitude (ft)');  
    end
else         % metric
    if(m==1) % speed
        set(handles.text_speed_altitude,'String','Enter Gust Speed RMS (m/sec)');
        set(handles.edit_speed_altitude,'String','25.9');        
    else     % altitude 
        set(handles.text_speed_altitude,'String','Enter Altitude (m)');  
    end       
end

if(n==1)
    set(handles.text_aircraft_speed,'String','Enter Aircraft Speed (ft/sec)');
else
    set(handles.text_aircraft_speed,'String','Enter Aircraft Speed (m/sec)');
end

if(n==1)
   set(handles.text_scale,'String','Enter Scale of Turbulence (ft)');
   set(handles.edit_gust_length,'String','2500');
else
   set(handles.text_scale,'String','Enter Scale of Turbulence (m)');
   set(handles.edit_gust_length,'String','762');
end

if(n==1)
   str{1}='Reduced PSD (ft/sec)^2/(cycles/ft)';
   str{2}='Velocity PSD (ft/sec)^2/Hz'; 
else
   str{1}='Reduced PSD (m/sec)^2/(cycles/m)';   
   str{2}='Velocity PSD (m/sec)^2/Hz';
end

%%%  str{3}='Acceleration PSD G^2/Hz';  

set(handles.listbox_save_type,'String',str);



set(handles.pushbutton_Save_PSD,'Enable','off');


% --- Executes during object creation, after setting all properties.
function listbox_velox_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_velox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_speed_altitude_Callback(hObject, eventdata, handles)
% hObject    handle to edit_speed_altitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_speed_altitude as text
%        str2double(get(hObject,'String')) returns contents of edit_speed_altitude as a double


% --- Executes during object creation, after setting all properties.
function edit_speed_altitude_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_speed_altitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_aircraft_speed_Callback(hObject, eventdata, handles)
% hObject    handle to edit_aircraft_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_aircraft_speed as text
%        str2double(get(hObject,'String')) returns contents of edit_aircraft_speed as a double


% --- Executes during object creation, after setting all properties.
function edit_aircraft_speed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_aircraft_speed (see GCBO)
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

fig_num=1;

feet_per_meters =3.28084;
meters_per_feet=1./feet_per_meters;
tpi=2*pi;

       units=get(handles.listbox_units,'Value');
     profile=get(handles.listbox_profile,'Value');
        axis=get(handles.listbox_axis,'Value');
velox_method=get(handles.listbox_velox_method,'Value');

if(profile==1)
    out_model='Dryden';
else
    out_model='von Karman';
end

if(axis==1)
    out_axis='Lateral/Vertical';
else
    out_axis='Longitudinal';
end



    L=str2num(get(handles.edit_gust_length,'String'));
    V=str2num(get(handles.edit_aircraft_speed,'String'));

if(velox_method==1)
    s=str2num(get(handles.edit_speed_altitude,'String'));
    
    sorig=s;
    
    if(units==2)
      s=s*feet_per_meters;
    end
else
    h=str2num(get(handles.edit_speed_altitude,'String'));  
%  
    ALT1=30000;
    ALT2=80000;
    d=ALT2-ALT1;
%
    if(units==1)
        if(h<=ALT1)
            s=85;
        end
        if(h>ALT1)
            if(h<=ALT2)
                x=h-ALT1;
                c2=x/d;
                c1=1-c2;
                s=c1*85+c2*30;
            end
        end
        if(h>ALT2)
            disp(' Warning: altitude is too high ');
            s=30;
        end        
    else
        h=h*feet_per_meters;
        if(h<=ALT1)
            s=85;
        end
        if(h>ALT1)
            if(h<=ALT2)
                x=h-ALT1;
                c2=x/d;
                c1=1-c2;
                s=c1*85+c2*30;
            end
        end
        if(h>ALT2)
            disp(' Warning: altitude is too high ');
            s=30;
        end
    end
%
    sorig=s;
    
    if(units==2)
      sorig=s/feet_per_meters;
    end    
%    
end
if(units==2)
    L=L*feet_per_meters;
    V=V*feet_per_meters;  
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
fmin=1.0e-05;
fmax=0.1;
%
i=1;
%
while(1);
%
    if(i==1)  
       Omega(i)=fmin;
    else
       Omega(i)=Omega(i-1)*2^(1/12);
    end
%
    if(Omega(i)>fmax)
        Omega(i)=[];
        break;
    end
%
    om=Omega(i);
    LO=L*om;  
%
    if(profile==1)  % Dryden
%
        term=LO^2;
        den=(1+term)^2;
%
        if(axis==1) % lateral/vertical
%
            num=1+3*term;
%           
        else         % longitudinal
            num=1;
        end
%
    else       % von Karman
%
        term=(1.339*LO)^2;
%
        if(axis==1) % lateral/vertical
%
            num=1+(8/3)*term;
            den=(1+term)^(11/6);
%           
        else         % longitudinal
            num=1;
            den=(1+term)^(5/6);     
        end
    end
%
    GPSD(i)=num/den;
%        
    i=i+1;
%
end  
%
if(axis==1)
    GPSD=GPSD*(s^2*L/pi);
else
    GPSD=GPSD*(s^2*(2*L)/pi);
end
%
if(units==2) 
   Omega=Omega*feet_per_meters;
    GPSD= GPSD*meters_per_feet^3;
end
%
Omega=Omega';
Omega_tpi=Omega/tpi;
%
GPSD=GPSD';
GPSD=tpi*GPSD;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%
%

s=sorig;

sss=sprintf('%6.3g',s);

if(s==85)
    sss='85';
end

if(s==25.9)
    sss='25.9';
end

%
%%%%%%%%%%%%%%%%%%%%%%%%%%
%
figure(fig_num);
fig_num=fig_num+1;
plot(Omega_tpi,GPSD);
reduced_psd=[Omega_tpi,GPSD];
setappdata(0,'reduced_psd',reduced_psd);
if(units==1)
   out1=sprintf('Reduced %s Continuous Gust PSD, %s, Gust Velocity=%s ft/sec',out_model,out_axis,sss);
   xlabel('Reduced Frequency (cycles/ft)');
   ylabel('PSD (ft/sec)^2/(cycles/ft)');  
else
   out1=sprintf('Reduced %s Continuous Gust PSD, %s, Gust Velocity=%s m/sec',out_model,out_axis,sss);    
   xlabel('Reduced Frequency (cycles/m)');
   ylabel('PSD (m/sec)^2/(cycles/m)');  
end
title(out1);
grid on;
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
figure(fig_num);
fig_num=fig_num+1;
n=length(Omega_tpi);
wl=zeros(n,1);
for i=1:n
    wl(i)=1/Omega_tpi(i);
end
plot(wl,GPSD);
wavelength_gust_psd=[wl,GPSD];
if(units==1)
   out1=sprintf('Reduced %s Continuous Gust PSD, %s, Gust Velocity=%s ft/sec',out_model,out_axis,sss);
   xlabel('Wavelength (ft)');
   ylabel('PSD (ft/sec)^2/(cycles/ft)');  
else
   out1=sprintf('Reduced %s Continuous Gust PSD, %s, Gust Velocity=%s m/sec',out_model,out_axis,sss);    
   xlabel('Wavelength (m)');
   ylabel('PSD (m/sec)^2/(cycles/m)');  
end
title(out1);
grid on;
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_fmax,'String'));
%
if(fmin<1.0e-04)
    fmin=1.0e-04;
    sss=sprintf('%8.4g',fmin);
    set(handles.edit_fmin,'String',sss);
end
%
alpha=2*pi*L/V;
%
i=1;
%
while(1);
%
    if(i==1)
       freq(i)=fmin;
    else
       freq(i)=freq(i-1)*2^(1/12);
    end
%
    if(freq(i)>fmax)
        freq(i)=[];
        break;
    end
%
    af=alpha*freq(i);
%
    if(profile==1)  % Dryden  
%
        term=af^2;
        den=(1+term)^2;
%
        if(axis==1) % lateral/vertical
%
            num=1+3*term;
%           
        else         % longitudinal
            num=1;
        end
%
    else       % von Karman
%
        term=(1.339*af)^2;
%
        if(axis==1) % lateral/vertical
%
            num=1+(8/3)*term;
            den=(1+term)^(11/6);
%           
        else         % longitudinal
            num=1;
            den=(1+term)^(5/6);     
        end
    end
%
    VPSD(i)=num/den;
%
    i=i+1;
%
end  
%
if(axis==1)
    VPSD=VPSD*(s^2*alpha/pi);  
else
    VPSD=VPSD*(s^2*(2*alpha)/pi);  
end
%
if(units==2) 
    VPSD=VPSD*meters_per_feet^2;
end
%
freq=fix_size(freq);
VPSD=fix_size(VPSD);
%
[~,vrms]=calculate_PSD_slopes(freq,VPSD);
%
clear length
%
for i=1:length(freq)
    APSD(i)=VPSD(i)*(tpi*freq(i))^2;
end
%
if(units==1)
    out1=sprintf('\n Overall velocity level = %8.4g (ft/sec) RMS \n',vrms);
    APSD=APSD/32.2^2;
else
    out1=sprintf('\n Overall velocity level = %8.4g (m/sec) RMS \n',vrms);
    APSD=APSD/386^2;    
end 
%
APSD=fix_size(APSD);
%
disp(out1);
%
n=length(VPSD);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(fig_num);
fig_num=fig_num+1;
plot(freq,VPSD);
if(units==1)
    out1=sprintf('%s Continuous Gust PSD, %s, Gust Velocity=%s ft/sec',out_model,out_axis,sss);
    ylabel('PSD (ft/sec)^2/Hz');    
else
    out1=sprintf('%s Continuous Gust PSD, %s, Gust Velocity=%s m/sec',out_model,out_axis,sss);
    ylabel('PSD (m/sec)^2/Hz');
end
title(out1);
xlabel('Frequency (Hz)');  
grid on;
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');

                          
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                 
                 
gust_vpsd_data=[freq,VPSD];
setappdata(0,'gust_vpsd_data',gust_vpsd_data);                 
                 
gust_apsd_data=[freq,APSD];
setappdata(0,'gust_apsd_data',gust_apsd_data); 


set(handles.pushbutton_Save_PSD,'Enable','on');
set(handles.listbox_destination,'Enable','on');
set(handles.listbox_save_type,'Enable','on');
set(handles.pushbutton_Save_PSD,'Enable','on');

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%


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


% --- Executes on button press in pushbutton_Save_PSD.
function pushbutton_Save_PSD_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Save_PSD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


n=get(handles.listbox_save_type,'Value');

if(n==1)
    data=getappdata(0,'reduced_psd');
end
if(n==2)
    data=getappdata(0,'gust_vpsd_data');
end
if(n==3)
    data=getappdata(0,'gust_apsd_data');
end

output_name=get(handles.edit_output_name,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete');

set(handles.listbox_destination,'Value',1);
set(handles.pushbutton_th,'Visible','on');

% --- Executes on selection change in listbox_save_type.

% hObject    handle to listbox_save_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_save_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_save_type



% --- Executes during object creation, after setting all properties.
function listbox_save_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_save_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_destination.
function listbox_destination_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_destination (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_destination contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_destination

n=get(hObject,'Value');

if(n==1)
   set(handles.edit_output_name,'Visible','on');
   set(handles.pushbutton_Save_PSD,'Enable','on');
   set(handles.text_array_name,'Enable','on');
else
   set(handles.edit_output_name,'Visible','off');
   set(handles.pushbutton_Save_PSD,'Enable','off');  
   set(handles.text_array_name,'Enable','off');
   
   m=get(handles.listbox_save_type,'Value');
   
   if(m==1)
       data=getappdata(0,'reduced_psd');
   else
       data=getappdata(0,'gust_psd_data');
   end 

   
   [filename, pathname] = uiputfile('*.txt','Save PSD As');
   writepfname = fullfile(pathname, filename);
   fid = fopen(writepfname,'w');
   
   n=length(data(:,1));
   
   for k=1:n
            fprintf(fid,'%13.6e \t %11.4e \n',data(k,1), data(k,2));    
   end
   
   fclose(fid);
   
   h = msgbox('Save Complete');
   
   set(hObject,'Value',1);
   
end

% --- Executes during object creation, after setting all properties.
function listbox_destination_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_destination (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_output_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_name as text
%        str2double(get(hObject,'String')) returns contents of edit_output_name as a double


% --- Executes during object creation, after setting all properties.
function edit_output_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_save_type.
function listbox_save_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_save_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_save_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_save_type


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(gust_psd);


% --- Executes on button press in pushbutton_th.
function pushbutton_th_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_th (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s= vibrationdata_PSD_vel_synth;       
set(handles.s,'Visible','on'); 


% --- Executes on key press with focus on edit_gust_length and none of its controls.
function edit_gust_length_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_gust_length (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

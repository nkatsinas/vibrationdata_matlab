function varargout = pipe_internal_spl_estimate(varargin)
% PIPE_INTERNAL_SPL_ESTIMATE MATLAB code for pipe_internal_spl_estimate.fig
%      PIPE_INTERNAL_SPL_ESTIMATE, by itself, creates a new PIPE_INTERNAL_SPL_ESTIMATE or raises the existing
%      singleton*.
%
%      H = PIPE_INTERNAL_SPL_ESTIMATE returns the handle to a new PIPE_INTERNAL_SPL_ESTIMATE or the handle to
%      the existing singleton*.
%
%      PIPE_INTERNAL_SPL_ESTIMATE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PIPE_INTERNAL_SPL_ESTIMATE.M with the given input arguments.
%
%      PIPE_INTERNAL_SPL_ESTIMATE('Property','Value',...) creates a new PIPE_INTERNAL_SPL_ESTIMATE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pipe_internal_spl_estimate_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pipe_internal_spl_estimate_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pipe_internal_spl_estimate

% Last Modified by GUIDE v2.5 19-Aug-2021 13:03:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pipe_internal_spl_estimate_OpeningFcn, ...
                   'gui_OutputFcn',  @pipe_internal_spl_estimate_OutputFcn, ...
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


% --- Executes just before pipe_internal_spl_estimate is made visible.
function pipe_internal_spl_estimate_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pipe_internal_spl_estimate (see VARARGIN)

% Choose default command line output for pipe_internal_spl_estimate
handles.output = hObject;

change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pipe_internal_spl_estimate wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = pipe_internal_spl_estimate_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_Calculate.
function pushbutton_Calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Calculate (see GCBO)
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

fig_num=1;

Pa_per_psi = 6894.;

n=get(handles.listbox_units,'Value');


C=str2num(get(handles.edit_C,'String'));
geo=str2num(get(handles.edit_geo,'String'));
S=str2num(get(handles.edit_S,'String'));

deltaP=str2num(get(handles.edit_deltaP,'String'));

ef=str2num(get(handles.edit_ef,'String'));

m=get(handles.listbox_geometry,'Value');

if(m==1)
    D=geo;
else    
    D=sqrt(geo*4/pi);
end


if(n==1)
    C=C*12;
    deltaP=deltaP*Pa_per_psi;
end

fp=0.2*C/D;

ss=sprintf('%8.3g',fp);
set(handles.edit_freq,'String',ss);

fco=0.293*C/(D/2);

ssc=sprintf('%8.3g',fco);
set(handles.edit_fco,'String',ssc);


Prms=(ef/100)*deltaP;
oaspl=20*log10(Prms/20e-06);

fc=one_third();  

[~,idx]=min(abs(fc-fp));

L=zeros(length(fc),1);

LL(2)=1;

noct1=log2(fp/fc(1));
noct2=log2(fc(end)/fp);

LL(1)=1-2.5*noct1;
LL(3)=1-4.5*noct2;

ff(1)=log10(fc(1));
ff(2)=log10(fp);
ff(3)=log10(fc(end));

[p] = polyfit(ff,LL,3);

for i=1:length(fc)
   x=log10(fc(i)); 
   L(i)=p(1)*x^3 + p(2)*x^2 + p(3)*x + p(4);    
end

for i=1:length(fc)
     fprintf(' %8.4g %8.4g  \n',fc(i),L(i));
end

[oadb]=oaspl_function(L);

diff=oaspl-oadb;

L=L+diff;

[oadb]=oaspl_function(L);

n_type=1;

[fig_num]=spl_plot(fig_num,n_type,fc,L);

sso=sprintf('%8.3g',oadb);
set(handles.edit_oaspl,'String',sso);

% convert SPL to Pressure PSD

ref = 20.e-06;

%
spl=L;
%
[power_spectral_density,rms]=one_octave_spl_to_psd_function(fc,spl,ref);

f=power_spectral_density(:,1);
a=power_spectral_density(:,2);

[s,rrms] = calculate_PSD_slopes(f,a);

scale=Prms/rms;
power_spectral_density(:,2)=power_spectral_density(:,2)*scale^2;

f=power_spectral_density(:,1);
a=power_spectral_density(:,2);

[s,rrms] = calculate_PSD_slopes(f,a);


if(n==1)
    power_spectral_density(:,2)=power_spectral_density(:,2)/Pa_per_psi^2;
    rms=rms/Pa_per_psi;
    y_label='Pressure (psi^2/Hz)';
    t_string=sprintf('Pressure PSD   Overall %8.3g psi rms',rms);
else
    y_label='Pressure (Pa^2/Hz)'; 
    t_string=sprintf('Pressure PSD   Overall %8.3g Pa rms',rms);    
end

% plot PSD

ppp=power_spectral_density;
x_label='Frequency (Hz)';

fmin=fc(1);
fmax=fc(end);

md=5;
[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

% save PSD

setappdata(0,'psd',power_spectral_density);

set(handles.uipanel_results,'Visible','on');



function[fc]=one_third()

    fc(1)=20.;
	fc(2)=25.;
	fc(3)=31.5;
	fc(4)=40.;
	fc(5)=50.;
	fc(6)=63.;
	fc(7)=80.;
	fc(8)=100.;
	fc(9)=125.;
	fc(10)=160.;
	fc(11)=200.;
	fc(12)=250.;
	fc(13)=315.;
	fc(14)=400.;
	fc(15)=500.;
	fc(16)=630.;
	fc(17)=800.;
	fc(18)=1000.;
	fc(19)=1250.;
	fc(20)=1600.;
	fc(21)=2000.;
    
    fc=fix_size(fc);

% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(pipe_internal_spl_estimate);


function edit_freq_Callback(hObject, eventdata, handles)
% hObject    handle to edit_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_freq as text
%        str2double(get(hObject,'String')) returns contents of edit_freq as a double


% --- Executes during object creation, after setting all properties.
function edit_freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units

change(hObject, eventdata, handles);


function change(hObject, eventdata, handles)

m=get(handles.listbox_geometry,'Value');

n=get(handles.listbox_units,'Value');

if(n==1)
    ssc='Speed of Sound (ft/sec)';
    ssp='Pressure Drop (psi)';
else
    ssc='Speed of Sound (m/sec)';  
    ssp='Pressure Drop (Pa)';    
end

set(handles.text_C,'String',ssc);
set(handles.text_deltaP,'String',ssp);

if(m==1)
    if(n==1)
        ssd='Diameter (in)';
    else
        ssd='Diameter (m)';        
    end

else
    if(n==1)
        ssd='Area (in^2)';
    else
        ssd='Area (m^2)';        
    end   
end

set(handles.text_geo,'String',ssd);

set(handles.uipanel_results,'Visible','off');


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



function edit_geo_Callback(hObject, eventdata, handles)
% hObject    handle to edit_geo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_geo as text
%        str2double(get(hObject,'String')) returns contents of edit_geo as a double


% --- Executes during object creation, after setting all properties.
function edit_geo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_geo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_C_Callback(hObject, eventdata, handles)
% hObject    handle to edit_C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_C as text
%        str2double(get(hObject,'String')) returns contents of edit_C as a double


% --- Executes during object creation, after setting all properties.
function edit_C_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_S_Callback(hObject, eventdata, handles)
% hObject    handle to edit_S (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_S as text
%        str2double(get(hObject,'String')) returns contents of edit_S as a double


% --- Executes during object creation, after setting all properties.
function edit_S_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_S (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_geo and none of its controls.
function edit_geo_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_geo (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_results,'Visible','off');


% --- Executes on key press with focus on edit_C and none of its controls.
function edit_C_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_C (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_results,'Visible','off');


% --- Executes on key press with focus on edit_S and none of its controls.
function edit_S_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_S (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_results,'Visible','off');



function edit_fco_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fco (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fco as text
%        str2double(get(hObject,'String')) returns contents of edit_fco as a double


% --- Executes during object creation, after setting all properties.
function edit_fco_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fco (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_deltaP_Callback(hObject, eventdata, handles)
% hObject    handle to edit_deltaP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_deltaP as text
%        str2double(get(hObject,'String')) returns contents of edit_deltaP as a double


% --- Executes during object creation, after setting all properties.
function edit_deltaP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_deltaP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ef_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ef as text
%        str2double(get(hObject,'String')) returns contents of edit_ef as a double


% --- Executes during object creation, after setting all properties.
function edit_ef_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_oaspl_Callback(hObject, eventdata, handles)
% hObject    handle to edit_oaspl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_oaspl as text
%        str2double(get(hObject,'String')) returns contents of edit_oaspl as a double


% --- Executes during object creation, after setting all properties.
function edit_oaspl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_oaspl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_ef and none of its controls.
function edit_ef_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_ef (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');


% --- Executes on key press with focus on edit_deltaP and none of its controls.
function edit_deltaP_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_deltaP (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');



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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'psd');

name=get(handles.edit_output_name,'String');

assignin('base', name, data);
 
msgbox('Data saved');


% --- Executes on selection change in listbox_geometry.
function listbox_geometry_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_geometry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_geometry contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_geometry
change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_geometry_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_geometry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

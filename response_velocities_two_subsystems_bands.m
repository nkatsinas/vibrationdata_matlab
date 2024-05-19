function varargout = response_velocities_two_subsystems_bands(varargin)
% RESPONSE_VELOCITIES_TWO_SUBSYSTEMS_BANDS MATLAB code for response_velocities_two_subsystems_bands.fig
%      RESPONSE_VELOCITIES_TWO_SUBSYSTEMS_BANDS, by itself, creates a new RESPONSE_VELOCITIES_TWO_SUBSYSTEMS_BANDS or raises the existing
%      singleton*.
%
%      H = RESPONSE_VELOCITIES_TWO_SUBSYSTEMS_BANDS returns the handle to a new RESPONSE_VELOCITIES_TWO_SUBSYSTEMS_BANDS or the handle to
%      the existing singleton*.
%
%      RESPONSE_VELOCITIES_TWO_SUBSYSTEMS_BANDS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESPONSE_VELOCITIES_TWO_SUBSYSTEMS_BANDS.M with the given input arguments.
%
%      RESPONSE_VELOCITIES_TWO_SUBSYSTEMS_BANDS('Property','Value',...) creates a new RESPONSE_VELOCITIES_TWO_SUBSYSTEMS_BANDS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before response_velocities_two_subsystems_bands_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to response_velocities_two_subsystems_bands_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help response_velocities_two_subsystems_bands

% Last Modified by GUIDE v2.5 06-Jan-2016 10:51:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @response_velocities_two_subsystems_bands_OpeningFcn, ...
                   'gui_OutputFcn',  @response_velocities_two_subsystems_bands_OutputFcn, ...
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


% --- Executes just before response_velocities_two_subsystems_bands is made visible.
function response_velocities_two_subsystems_bands_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to response_velocities_two_subsystems_bands (see VARARGIN)

% Choose default command line output for response_velocities_two_subsystems_bands
handles.output = hObject;


clc;
set(hObject, 'Units', 'pixels');
axes(handles.axes1);
bg = imread('tcss_a.jpg');
info.Width=313;
info.Height=296;

axes(handles.axes1);
image(bg);
set(handles.axes1, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [30 120 info.Width info.Height]);
axis off; 

listbox_units_Callback(hObject, eventdata, handles);

data_s{1,1} = 'Center Freq (Hz)';  
data_s{2,1} = 'Input Power 1'; 
data_s{3,1} = 'Input Power 2'; 
data_s{4,1} = 'Dissipation Loss Factor 1'; 
data_s{5,1} = 'Dissipation Loss Factor 2'; 
data_s{6,1} = 'Coupling Loss Factor 12'; 
data_s{7,1} = 'Coupling Loss Factor 21'; 
 
 


set(handles.uitable_variables,'Data',data_s)



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes response_velocities_two_subsystems_bands wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = response_velocities_two_subsystems_bands_OutputFcn(hObject, eventdata, handles) 
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

delete(coupling_loss_factors_two_subsystems);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tpi=2*pi;


try  
    FS=get(handles.edit_input_array,'String');
    THM=evalin('base',FS);  

catch  
    warndlg('Input Array does not exist.  Try again.')
    return;
end



iu=get(handles.listbox_units,'value');


S1 = get(handles.edit_m1, 'String');
if isempty(S1)
  warndlg('Enter mass 1');  
  return;
else
    m1=str2num(S1);  
end

%%

S2 = get(handles.edit_m2, 'String');
if isempty(S2)
  warndlg('Enter mass 2');  
  return;
else
    m2=str2num(S2);  
end
 
 
if(iu==1)
    m1=m1/386;
    m2=m2/386;         
end


fc=THM(:,1);
omega=tpi*fc;

power_1=THM(:,2);
power_2=THM(:,3);

lf1=THM(:,4);
lf2=THM(:,5);

clf_12=THM(:,6);
clf_21=THM(:,7);

NL=length(fc);

v1=zeros(NL,1);
v2=zeros(NL,1);

a1=zeros(NL,1);
a2=zeros(NL,1);

for i=1:NL

    A=[ lf1(i)+clf_12(i)  -clf_21(i)  ; -clf_12(i)  lf2(i)+clf_21(i)  ];
    B=[ power_1(i); power_2(i)]/omega(i);

    E=A\B;

    E1=E(1);
    E2=E(2);
    
    [v1(i),a1(i)]=energy_to_velox_accel(E1,m1,omega(i));    
    [v2(i),a2(i)]=energy_to_velox_accel(E2,m2,omega(i));

end    

if(iu==2)
   v1=v1*1000;
   v2=v2*1000;
end

if(iu==1)
   a1=a1/386;
   a2=a2/386;
else
   a1=a1/9.81;
   a2=a2/9.81;    
end


if(iu==1)
    seu='in-lbf';
    spu='in-lbf/sec';
    spv='in/sec';
else
    seu='J';
    spu='W';
    spv='mm/sec';    
end

disp(' ');
disp(' * * * * ');
disp(' ');
disp(' Freq      v1       v2         a1       a2');
   
if(iu==1)
    disp(' (Hz)   (in/sec)   (in/sec)    (G)      (G)');    
else
    disp(' (Hz)   (mm/sec)   (mm/sec)    (G)      (G)');  
end
    
    
for i=1:NL
    
    out1=sprintf(' %g   %8.4g   %8.4g  %8.4g  %8.4g',fc(i),v1(i),v2(i),a1(i),a2(i));
    disp(out1);
    
end


fig_num=1;
x_label='Frequency (Hz)';
y_label=sprintf('Velocity (%s) rms',spv);

fmin=10;
fmax=20000;

f1=min(fc);
f2=max(fc);

if(f1>20)
    fmin=20;
end 
if(f1>100)
    fmin=100;
end    
if(f2<10000)
    fmax=10000;
end
if(f2<1000)
    fmax=1000;
end


md=5;
leg1='V1';
leg2='V2';

ppp1=[fc v1];
ppp2=[fc v2];

aaa1=[fc a1];
aaa2=[fc a2];

t_string='Velocity Spectrum';

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);

           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

y_label=sprintf('Accel (G rms)');
t_string='Acceleration Spectrum';

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,aaa1,aaa2,leg1,leg2,fmin,fmax,md);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

leg1='P1';
leg2='P2';
qqq1=[fc power_1];
qqq2=[fc power_2];

t_string='Input Power Spectrum';

if(iu==1)
   y_label='Power (in-lbf/sec)'; 
else
   y_label='Power (W)';    
end

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,qqq1,qqq2,leg1,leg2,fmin,fmax,md);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t_string='Loss Factors';
y_label='Loss Factor'; 

rrr1=[fc lf1];
rrr2=[fc lf2];
rrr3=[fc clf_12];
rrr4=[fc clf_21];
leg1='lf 1';
leg2='lf 2';
leg3='clf 12';
leg4='clf 21';

[fig_num,h2]=plot_loglog_function_md_four_h2(fig_num,x_label,...
               y_label,t_string,rrr1,rrr2,rrr3,rrr4,leg1,leg2,leg3,leg4,fmin,fmax,md);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nb=get(handles.listbox_band,'Value');
 
if(nb<=2)
    
    [psd1,grms1]=psd_from_spectrum(nb,fc,a1);    
    [psd2,grms2]=psd_from_spectrum(nb,fc,a2);         
 
    disp(' ');
    disp(' Power Spectral Density ');
    disp(' ');
    disp('   Freq    PSD 1     PSD 2  ');
    disp('   (Hz)   (G^2/Hz)  (G^2/Hz)');
           
    for i=1:NL
    
        out1=sprintf('  %g    %8.4g  %8.4g',fc(i),psd1(i),psd2(i));
        disp(out1);
    
    end
 

    leg1=sprintf('Subsystem 1 %7.3g GRMS',grms1);
    leg2=sprintf('Subsystem 2 %7.3g GRMS',grms2);
    
    disp(' ');
    disp(' Overall Levels ');
    disp(' ');   
    out1=sprintf(' Subsystem 1 = %8.4g GRMS',grms1);
    disp(out1);
    out2=sprintf(' Subsystem 2 = %8.4g GRMS',grms2);
    disp(out2);    
    
    psd1=[fc psd1];
    psd2=[fc psd2];    
    
    qqq1=psd1;
    qqq2=psd2;    
    
    y_label='Accel (G^2/Hz)';
    
    t_string=sprintf('Power Spectral Density');
 
    [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,qqq1,qqq2,leg1,leg2,fmin,fmax,md);    
end
 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp(' Output Arrays:');

disp(' ');
disp(' Power Spectra: vel_ps_1, vel_ps_2, accel_ps_1, accel_ps_2 ');          

assignin('base', 'vel_ps_1',ppp1);
assignin('base', 'vel_ps_2',ppp2);
 
assignin('base', 'accel_ps_1',aaa1);
assignin('base', 'accel_ps_2',aaa2); 

if(nb<=2)
    assignin('base', 'accel_psd_1',psd1);
    assignin('base', 'accel_psd_2',psd2);     
    disp(' Power Spectral Densities: accel_psd_1, accel_psd_2 ');
end    

disp(' '); 

 
 msgbox('Results written to Command Window');


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units

iu=get(handles.listbox_units,'value');


if(iu==1)
    set(handles.text_pu,'String','Power Unit: in-lbf/sec');     
    set(handles.text_m1,'String','Mass 1 (lbm)');
    set(handles.text_m2,'String','Mass 2 (lbm)');
else
    set(handles.text_pu,'String','Power Unit: W');    
    set(handles.text_m1,'String','Mass 1 (kg)');
    set(handles.text_m2,'String','Mass 2 (kg)');    
end




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



function edit_m1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_m1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_m1 as text
%        str2double(get(hObject,'String')) returns contents of edit_m1 as a double


% --- Executes during object creation, after setting all properties.
function edit_m1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_m1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_m2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_m2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_m2 as text
%        str2double(get(hObject,'String')) returns contents of edit_m2 as a double


% --- Executes during object creation, after setting all properties.
function edit_m2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_m2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_v1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_v1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_v1 as text
%        str2double(get(hObject,'String')) returns contents of edit_v1 as a double


% --- Executes during object creation, after setting all properties.
function edit_v1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_v1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_v2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_v2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_v2 as text
%        str2double(get(hObject,'String')) returns contents of edit_v2 as a double


% --- Executes during object creation, after setting all properties.
function edit_v2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_v2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_lf1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lf1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lf1 as text
%        str2double(get(hObject,'String')) returns contents of edit_lf1 as a double


% --- Executes during object creation, after setting all properties.
function edit_lf1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_lf1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_lf2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lf2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lf2 as text
%        str2double(get(hObject,'String')) returns contents of edit_lf2 as a double


% --- Executes during object creation, after setting all properties.
function edit_lf2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_lf2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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



function edit_md2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_md2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_md2 as text
%        str2double(get(hObject,'String')) returns contents of edit_md2 as a double


% --- Executes during object creation, after setting all properties.
function edit_md2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_md2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_md1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_md1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_md1 as text
%        str2double(get(hObject,'String')) returns contents of edit_md1 as a double


% --- Executes during object creation, after setting all properties.
function edit_md1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_md1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_clf_12_Callback(hObject, eventdata, handles)
% hObject    handle to edit_clf_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_clf_12 as text
%        str2double(get(hObject,'String')) returns contents of edit_clf_12 as a double


% --- Executes during object creation, after setting all properties.
function edit_clf_12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_clf_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_clf_21_Callback(hObject, eventdata, handles)
% hObject    handle to edit_clf_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_clf_21 as text
%        str2double(get(hObject,'String')) returns contents of edit_clf_21 as a double


% --- Executes during object creation, after setting all properties.
function edit_clf_21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_clf_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_power_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_power_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_power_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_power_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_power_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_power_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1



function edit_power_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_power_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_power_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_power_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_power_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_power_2 (see GCBO)
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


% --- Executes on button press in pushbutton_eq.
function pushbutton_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
     A = imread('velox_two_subsystems.jpg');
     figure(999) 
     imshow(A,'border','tight','InitialMagnification',100)


% --- Executes on selection change in listbox_band.
function listbox_band_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_band (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_band contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_band


% --- Executes during object creation, after setting all properties.
function listbox_band_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_band (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

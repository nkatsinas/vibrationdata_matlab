function varargout = three_subsystems_a_multi(varargin)
% THREE_SUBSYSTEMS_A_MULTI MATLAB code for three_subsystems_a_multi.fig
%      THREE_SUBSYSTEMS_A_MULTI, by itself, creates a new THREE_SUBSYSTEMS_A_MULTI or raises the existing
%      singleton*.
%
%      H = THREE_SUBSYSTEMS_A_MULTI returns the handle to a new THREE_SUBSYSTEMS_A_MULTI or the handle to
%      the existing singleton*.
%
%      THREE_SUBSYSTEMS_A_MULTI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in THREE_SUBSYSTEMS_A_MULTI.M with the given input arguments.
%
%      THREE_SUBSYSTEMS_A_MULTI('Property','Value',...) creates a new THREE_SUBSYSTEMS_A_MULTI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before three_subsystems_a_multi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to three_subsystems_a_multi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help three_subsystems_a_multi

% Last Modified by GUIDE v2.5 06-Jan-2016 11:39:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @three_subsystems_a_multi_OpeningFcn, ...
                   'gui_OutputFcn',  @three_subsystems_a_multi_OutputFcn, ...
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


% --- Executes just before three_subsystems_a_multi is made visible.
function three_subsystems_a_multi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to three_subsystems_a_multi (see VARARGIN)

% Choose default command line output for three_subsystems_a_multi
handles.output = hObject;


clc;

fstr='three_subsystems_a.jpg';

bg = imread(fstr);
info = imfinfo(fstr);
w = info.Width;  %An integer indicating the width of the image in pixels
h = info.Height; %An integer indicating the height of the image in pixels
 
axes(handles.axes1);
image(bg);
pos1 = getpixelposition(handles.axes1,true);
 
set(handles.axes1, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [pos1(1) pos1(2) w h]);
axis off; 



%%%%%%%%%%%

listbox_units_Callback(hObject, eventdata, handles);


data_s{1,1} = 'Center Freq (Hz)';  
data_s{2,1} = 'Input Power 1'; 
data_s{3,1} = 'Input Power 2'; 
data_s{4,1} = 'Input Power 3';
data_s{5,1} = 'Dissipation Loss Factor 1'; 
data_s{6,1} = 'Dissipation Loss Factor 2'; 
data_s{7,1} = 'Dissipation Loss Factor 3'; 

data_s{8,1} = 'Coupling Loss Factor 12'; 
data_s{9,1} = 'Coupling Loss Factor 21'; 
 
data_s{10,1} = 'Coupling Loss Factor 23'; 
data_s{11,1} = 'Coupling Loss Factor 32'; 
 


set(handles.uitable_variables,'Data',data_s)


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes three_subsystems_a_multi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = three_subsystems_a_multi_OutputFcn(hObject, eventdata, handles) 
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

delete(three_subsystems_a_multi);


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
[m1,iflag]=read_mass(S1);
if(iflag==1)
  return;
end

S2 = get(handles.edit_m2, 'String');
[m2,iflag]=read_mass(S2);
if(iflag==1)
  return;
end

S3 = get(handles.edit_m3, 'String');
[m3,iflag]=read_mass(S3);
if(iflag==1)
  return;
end



%%%
 
if(iu==1)
    m1=m1/386;
    m2=m2/386;         
    m3=m3/386;
end


fc=THM(:,1);

sz=size(THM);

if(sz(2)~=11)
    warndlg('Input file must have 11 columns ');
    return;
end

omega=tpi*fc;

power_1=THM(:,2);
power_2=THM(:,3);
power_3=THM(:,4);

NL=length(fc);

v1=zeros(NL,1);
v2=zeros(NL,1);
v3=zeros(NL,1);

a1=zeros(NL,1);
a2=zeros(NL,1);
a3=zeros(NL,1);

n=3;

for i=1:NL
    
    clf=zeros(n,n);
    
    lf(1)=THM(i,5);
    lf(2)=THM(i,6);
    lf(3)=THM(i,7);

    clf(1,2)=THM(i,8);
    clf(2,1)=THM(i,9);

    clf(2,3)=THM(i,10);
    clf(3,2)=THM(i,11);    
    
    [A]=SEA_coefficients(n,lf,clf);
    
   
    B=[ power_1(i); power_2(i); power_3(i)]/omega(i);

    E=A\B;

    E1=E(1);
    E2=E(2);
    E3=E(3);
    
    [v1(i),a1(i)]=energy_to_velox_accel(E1,m1,omega(i));
    [v2(i),a2(i)]=energy_to_velox_accel(E2,m2,omega(i));
    [v3(i),a3(i)]=energy_to_velox_accel(E3,m3,omega(i));
       
end    

if(iu==2)
   v1=v1*1000;
   v2=v2*1000;
   v3=v3*1000;
end

if(iu==1)
   a1=a1/386;
   a2=a2/386;
   a3=a3/386;
else
   a1=a1/9.81;
   a2=a2/9.81;
   a3=a3/9.81;
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
disp('    Velocity RMS');
disp(' ');
disp(' Freq      v1        v2        v3 ');
   
if(iu==1)
    disp(' (Hz)   (in/sec)  (in/sec)  (in/sec)');    
else
    disp(' (Hz)   (mm/sec)  (mm/sec)  (mm/sec)');  
end
    
    
for i=1:NL
    
    out1=sprintf(' %g   %8.4g   %8.4g  %8.4g',fc(i),v1(i),v2(i),v3(i));
    disp(out1);
    
end

%%%%%%%%%%%%%%%%%%%

disp(' ');
disp('    Acceleration RMS');
disp(' ');
    disp(' Freq      a1         a2         a3  ');
    disp(' (Hz)      (G)        (G)        (G) ');   
    
    
for i=1:NL
    
    out1=sprintf(' %g   %8.4g   %8.4g  %8.4g ',fc(i),a1(i),a2(i),a3(i));
    disp(out1);
    
end

%%%%%%%%%%%%%%%%%%%


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


md=4;
leg1='V1';
leg2='V2';
leg3='V3';

ppp1=[fc v1];
ppp2=[fc v2];
ppp3=[fc v3];

aaa1=[fc a1];
aaa2=[fc a2];
aaa3=[fc a3];

t_string='Velocity Spectrum';

[fig_num,h2]=plot_loglog_function_md_three_h2(fig_num,x_label,...
              y_label,t_string,ppp1,ppp2,ppp3,leg1,leg2,leg3,fmin,fmax,md);

           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

y_label=sprintf('Accel (G rms)');
t_string='Acceleration Spectrum';

leg1='A1';
leg2='A2';
leg3='A3';

[fig_num,h2]=plot_loglog_function_md_three_h2(fig_num,x_label,...
              y_label,t_string,aaa1,aaa2,aaa3,leg1,leg2,leg3,fmin,fmax,md);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

leg1='P1';
leg2='P2';
leg3='P3';
qqq1=[fc power_1];
qqq2=[fc power_2];
qqq3=[fc power_3];

t_string='Input Power Spectrum';

if(iu==1)
   y_label='Power (in-lbf/sec)'; 
else
   y_label='Power (W)';    
end

[fig_num,h2]=plot_loglog_function_md_three_h2(fig_num,x_label,...
               y_label,t_string,qqq1,qqq2,qqq3,leg1,leg2,leg3,fmin,fmax,md);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t_string='Loss Factors';
y_label='Loss Factor'; 

rrr1=[fc THM(:,5)];
rrr2=[fc THM(:,6)];
rrr3=[fc THM(:,7)];

leg1='lf 1';
leg2='lf 2';
leg3='lf 3';

[fig_num,h2]=plot_loglog_function_md_three_h2(fig_num,x_label,...
               y_label,t_string,rrr1,rrr2,rrr3,leg1,leg2,leg3,fmin,fmax,md);
           
           
t_string='Coupling Loss Factors';
y_label='CLF';            

leg1='clf 12';
leg2='clf 21';
leg3='clf 23';
leg4='clf 32';
           
rrr1=[fc THM(:,8)];
rrr2=[fc THM(:,9)];
rrr3=[fc THM(:,10)];
rrr4=[fc THM(:,11)];

[fig_num,h2]=plot_loglog_function_md_four_h2(fig_num,x_label,...
    y_label,t_string,rrr1,rrr2,rrr3,rrr4,leg1,leg2,leg3,leg4,fmin,fmax,md);
           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nb=get(handles.listbox_band,'Value');
 
if(nb<=2)
    
    [psd1,grms(1)]=psd_from_spectrum(nb,fc,a1);    
    [psd2,grms(2)]=psd_from_spectrum(nb,fc,a2);   
    [psd3,grms(3)]=psd_from_spectrum(nb,fc,a3); 
    
    disp(' ');
    disp(' Power Spectral Density ');
    disp(' ');
    disp('   Freq    PSD 1     PSD 2     PSD 3  ');
    disp('   (Hz)   (G^2/Hz)  (G^2/Hz)  (G^2/Hz)');
      
    for i=1:NL
        
        out1=sprintf('  %g    %8.4g  %8.4g  %8.4g',fc(i),psd1(i),psd2(i),psd3(i));
        disp(out1);
    
    end
    
    leg1=sprintf('Subsystem 1 %7.3g GRMS',grms(1));
    leg2=sprintf('Subsystem 2 %7.3g GRMS',grms(2));
    leg3=sprintf('Subsystem 3 %7.3g GRMS',grms(3));
    
    disp(' ');
    disp(' Overall Levels ');
    disp(' ');   
    out1=sprintf(' Subsystem 1 = %8.4g GRMS',grms(1));
    out2=sprintf(' Subsystem 2 = %8.4g GRMS',grms(2));
    out3=sprintf(' Subsystem 3 = %8.4g GRMS',grms(3));
    disp(out1);   
    disp(out2);     
    disp(out3);        
    
    psd1=[fc psd1];
    psd2=[fc psd2];  
    psd3=[fc psd3];      
    
    qqq1=psd1;
    qqq2=psd2;
    qqq3=psd3;     
    
    y_label='Accel (G^2/Hz)';
    
    t_string=sprintf('Power Spectral Density');
 
    [fig_num,h2]=plot_loglog_function_md_three_h2(fig_num,x_label,...
               y_label,t_string,qqq1,qqq2,qqq3,leg1,leg2,leg3,fmin,fmax,md);    
end
 
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
disp(' ');
disp(' Output Arrays:');
 
disp(' ');
disp(' Power Spectra:   vel_ps_1, vel_ps_2, vel_ps_3  ');
disp('                accel_ps_1, accel_ps_2, accel_ps_3 ');          
 
assignin('base', 'vel_ps_1',ppp1);
assignin('base', 'vel_ps_2',ppp2);
assignin('base', 'vel_ps_3',ppp3);
 
assignin('base', 'accel_ps_1',aaa1);
assignin('base', 'accel_ps_2',aaa2);
assignin('base', 'accel_ps_3',aaa3)
 
if(nb<=2)
    assignin('base', 'accel_psd_1',psd1);
    assignin('base', 'accel_psd_2',psd2); 
    assignin('base', 'accel_psd_3',psd3);     
    disp(' Power Spectral Densities: accel_psd_1, accel_psd_2, accel_psd_3 ');
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
    set(handles.text_m3,'String','Mass 3 (lbm)');    
else
    set(handles.text_pu,'String','Power Unit: W');           
    set(handles.text_m1,'String','Mass 1 (kg)');
    set(handles.text_m2,'String','Mass 2 (kg)');    
    set(handles.text_m3,'String','Mass 3 (kg)');     
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
     A = imread('velox_three_subsystems_a.jpg');
     figure(999) 
     imshow(A,'border','tight','InitialMagnification',100) 



function edit_m3_Callback(hObject, eventdata, ~)
% hObject    handle to edit_m3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_m3 as text
%        str2double(get(hObject,'String')) returns contents of edit_m3 as a double


% --- Executes during object creation, after setting all properties.
function edit_m3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_m3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function[m,iflag]=read_mass(S)
%
iflag=0;
m=0;

if isempty(S)
  warndlg('Enter mass');  
  iflag=1;
else
    m=str2num(S);  
end


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

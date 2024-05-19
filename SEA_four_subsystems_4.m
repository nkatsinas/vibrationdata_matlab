function varargout = SEA_four_subsystems_4(varargin)
% SEA_FOUR_SUBSYSTEMS_4 MATLAB code for SEA_four_subsystems_4.fig
%      SEA_FOUR_SUBSYSTEMS_4, by itself, creates a new SEA_FOUR_SUBSYSTEMS_4 or raises the existing
%      singleton*.
%
%      H = SEA_FOUR_SUBSYSTEMS_4 returns the handle to a new SEA_FOUR_SUBSYSTEMS_4 or the handle to
%      the existing singleton*.
%
%      SEA_FOUR_SUBSYSTEMS_4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEA_FOUR_SUBSYSTEMS_4.M with the given input arguments.
%
%      SEA_FOUR_SUBSYSTEMS_4('Property','Value',...) creates a new SEA_FOUR_SUBSYSTEMS_4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SEA_four_subsystems_4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SEA_four_subsystems_4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SEA_four_subsystems_4

% Last Modified by GUIDE v2.5 04-Jan-2016 13:44:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SEA_four_subsystems_4_OpeningFcn, ...
                   'gui_OutputFcn',  @SEA_four_subsystems_4_OutputFcn, ...
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


% --- Executes just before SEA_four_subsystems_4 is made visible.
function SEA_four_subsystems_4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SEA_four_subsystems_4 (see VARARGIN)

% Choose default command line output for SEA_four_subsystems_4
handles.output = hObject;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;

fstr='four_4_f.jpg';

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


listbox_units_Callback(hObject, eventdata, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data_s{1,1} = 'Center Freq (Hz)';  
data_s{2,1} = 'Input Power 1'; 
data_s{3,1} = 'Input Power 2'; 
data_s{4,1} = 'Input Power 3'; 
data_s{5,1} = 'Input Power 4'; 
data_s{6,1} = 'Dissipation Loss Factor 1'; 
data_s{7,1} = 'Dissipation Loss Factor 2'; 
data_s{8,1} = 'Dissipation Loss Factor 3'; 
data_s{9,1} = 'Dissipation Loss Factor 4';  

data_s{10,1} = 'Coupling Loss Factor 12'; 
data_s{11,1} = 'Coupling Loss Factor 21'; 

data_s{12,1} = 'Coupling Loss Factor 13'; 
data_s{13,1} = 'Coupling Loss Factor 31'; 

data_s{14,1} = 'Coupling Loss Factor 14'; 
data_s{15,1} = 'Coupling Loss Factor 41'; 
 
data_s{16,1} = 'Coupling Loss Factor 23'; 
data_s{17,1} = 'Coupling Loss Factor 32'; 
 
data_s{18,1} = 'Coupling Loss Factor 24'; 
data_s{19,1} = 'Coupling Loss Factor 42'; 
 
data_s{20,1} = 'Coupling Loss Factor 34'; 
data_s{21,1} = 'Coupling Loss Factor 43'; 


set(handles.uitable_variables,'Data',data_s);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SEA_four_subsystems_4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SEA_four_subsystems_4_OutputFcn(hObject, eventdata, handles) 
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
delete(SEA_four_subsystems_1);



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
    set(handles.text_m4,'String','Mass 4 (lbm)');     
else    
    set(handles.text_pu,'String','Power Unit: W');       
    set(handles.text_m1,'String','Mass 1 (kg)');
    set(handles.text_m2,'String','Mass 2 (kg)');    
    set(handles.text_m3,'String','Mass 3 (kg)');  
    set(handles.text_m4,'String','Mass 4 (kg)');    
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



function edit_m3_Callback(hObject, eventdata, handles)
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



function edit_m4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_m4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_m4 as text
%        str2double(get(hObject,'String')) returns contents of edit_m4 as a double


% --- Executes during object creation, after setting all properties.
function edit_m4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_m4 (see GCBO)
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

tpi=2*pi;


try  
    FS=get(handles.edit_input_array,'String');
    THM=evalin('base',FS);  

catch  
    warndlg('Input Array does not exist.  Try again.')
    return;
end


iu=get(handles.listbox_units,'value');

%%

S1 = get(handles.edit_m1, 'String');
if isempty(S1)
  warndlg('Enter mass 1');  
  return;
else
    m(1)=str2num(S1);  
end

%%

S2 = get(handles.edit_m2, 'String');
if isempty(S2)
  warndlg('Enter mass 2');  
  return;
else
    m(2)=str2num(S2);  
end


%%


S3 = get(handles.edit_m3, 'String');
if isempty(S3)
  warndlg('Enter mass 3');  
  return;
else
    m(3)=str2num(S3);  
end

%%


S4 = get(handles.edit_m4, 'String');
if isempty(S4)
  warndlg('Enter mass 4');  
  return;
else
    m(4)=str2num(S4);  
end

%%


 
if(iu==1)
    m=m/386;
end


fc=THM(:,1);
NL=length(fc);

sz=size(THM);

if(sz(2)~=21)
    warndlg('Input array must have 21 columns ');
    return;
end

omega=tpi*fc;

power_1=THM(:,2);
power_2=THM(:,3);
power_3=THM(:,4);
power_4=THM(:,5);

lf(:,1)=THM(:,6);
lf(:,2)=THM(:,7);
lf(:,3)=THM(:,8);
lf(:,4)=THM(:,9);  

n=4;

clf=zeros(NL,n,n);
      
clf(:,1,2)=THM(:,10);
clf(:,2,1)=THM(:,11);

clf(:,1,3)=THM(:,12);
clf(:,3,1)=THM(:,13);

clf(:,1,4)=THM(:,14);
clf(:,4,1)=THM(:,15);

clf(:,2,3)=THM(:,16);
clf(:,3,2)=THM(:,17);    
    
clf(:,2,4)=THM(:,18);
clf(:,4,2)=THM(:,19);

clf(:,3,4)=THM(:,20);
clf(:,4,3)=THM(:,21); 



v=zeros(NL,4);
a=zeros(NL,4);

for i=1:NL
    
    [A]=SEA_coefficients_arr(n,lf,clf,i);
    
   
    B=[ power_1(i); power_2(i); power_3(i); power_4(i)]/omega(i);

    E=A\B;

    for j=1:4
        [v(i,j),a(i,j)]=energy_to_velox_accel(E(j),m(j),omega(i));
    end 
end    

if(iu==2)
   v=v*1000;
end

if(iu==1)
   a=a/386;
else
   a=a/9.81;
end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp(' * * * * ');
disp(' ');
    disp(' Freq      v1         v2         v3        v4');
   
if(iu==1)
    disp(' (Hz)   (in/sec)   (in/sec)   (in/sec)   (in/sec)');    
else
    disp(' (Hz)   (mm/sec)   (mm/sec)   (mm/sec)   (mm/sec)');  
end
    
    
for i=1:NL
    
    out1=sprintf(' %g   %8.4g   %8.4g  %8.4g  %8.4g',fc(i),v(i,1),v(i,2),v(i,3),v(i,4));
    disp(out1);
    
end

%%%%%%%%%%%%%%%%%%%%%

disp(' ');
    disp(' Freq      a1         a2         a3        a4');
    disp(' (Hz)      (G)        (G)        (G)      (G)');   
    
    
for i=1:NL
    
    out1=sprintf(' %g   %8.4g   %8.4g  %8.4g  %8.4g',fc(i),a(i,1),a(i,2),a(i,3),a(i,4));
    disp(out1);
    
end

%%%%%%%%%%%%%%%%%%%%%

if(iu==1)
    spv='in/sec';
else
    spv='mm/sec';
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
 
 
md=4;
leg1='V1';
leg2='V2';
leg3='V3';
leg4='V4';
 
ppp1=[fc v(:,1)];
ppp2=[fc v(:,2)];
ppp3=[fc v(:,3)];
ppp4=[fc v(:,4)];
 
aaa1=[fc a(:,1)];
aaa2=[fc a(:,2)];
aaa3=[fc a(:,3)];
aaa4=[fc a(:,4)];
 
t_string='Velocity Spectrum';
 
[fig_num,h2]=plot_loglog_function_md_four_h2(fig_num,x_label,...
              y_label,t_string,ppp1,ppp2,ppp3,ppp4,leg1,leg2,leg3,leg4,fmin,fmax,md);
 
           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
y_label=sprintf('Accel (G rms)');
t_string='Acceleration Spectrum';
 
leg1='A1';
leg2='A2';
leg3='A3';
leg4='A4';
 
[fig_num,h2]=plot_loglog_function_md_four_h2(fig_num,x_label,...
              y_label,t_string,aaa1,aaa2,aaa3,aaa4,leg1,leg2,leg3,leg4,fmin,fmax,md);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
leg1='P1';
leg2='P2';
leg3='P3';
leg4='P4';
qqq1=[fc power_1];
qqq2=[fc power_2];
qqq3=[fc power_3];
qqq4=[fc power_4]; 



t_string='Input Power Spectrum';
 
if(iu==1)
   y_label='Power (in-lbf/sec)'; 
else
   y_label='Power (W)';    
end
 
[fig_num,h2]=plot_loglog_function_md_four_h2(fig_num,x_label,...
               y_label,t_string,qqq1,qqq2,qqq3,qqq4,leg1,leg2,leg3,leg4,fmin,fmax,md);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
t_string='Loss Factors';
y_label='Loss Factor'; 

 
rrr1=[fc lf(:,1)];
rrr2=[fc lf(:,2)];
rrr3=[fc lf(:,3)];
rrr4=[fc lf(:,4)];
 


leg1='lf 1';
leg2='lf 2';
leg3='lf 3';
leg4='lf 4';
 
[fig_num,h2]=plot_loglog_function_md_four_h2(fig_num,x_label,...
               y_label,t_string,rrr1,rrr2,rrr3,rrr4,leg1,leg2,leg3,leg4,fmin,fmax,md);
           
           
t_string='Coupling Loss Factors';
y_label='CLF';            
 
leg1='clf 12';
leg2='clf 21';
leg3='clf 23';
leg4='clf 32';
leg5='clf 34';
leg6='clf 43';

rrr1=[fc clf(:,1,2)];
rrr2=[fc clf(:,2,1)];
rrr3=[fc clf(:,2,3)];
rrr4=[fc clf(:,3,2)];
rrr5=[fc clf(:,3,4)];
rrr6=[fc clf(:,4,3)];

 
[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
    y_label,t_string,rrr1,rrr2,leg1,leg2,fmin,fmax,md);

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
    y_label,t_string,rrr3,rrr4,leg3,leg4,fmin,fmax,md);

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
    y_label,t_string,rrr5,rrr6,leg5,leg6,fmin,fmax,md);

           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 disp(' ');
 disp(' Output Arrays:  ');
 disp('     vel_1,   vel_2,   vel_3,   vel 4');
 disp('   accel_1, accel_2, accel_3, accel_4');
           
 assignin('base', 'vel_1',ppp1);
 assignin('base', 'vel_2',ppp2);
 assignin('base', 'vel_3',ppp3);
 assignin('base', 'vel_4',ppp4);

 
 assignin('base', 'accel_1',aaa1);
 assignin('base', 'accel_2',aaa2);
 assignin('base', 'accel_3',aaa3);
 assignin('base', 'accel_4',aaa4);

 
 msgbox('Results written to Command Window');






% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_eq.
function pushbutton_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

     A = imread('power_balance_n.jpg');
     figure(999) 
     imshow(A,'border','tight','InitialMagnification',100)


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
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

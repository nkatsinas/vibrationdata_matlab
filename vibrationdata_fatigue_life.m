function varargout = vibrationdata_fatigue_life(varargin)
% VIBRATIONDATA_FATIGUE_LIFE MATLAB code for vibrationdata_fatigue_life.fig
%      VIBRATIONDATA_FATIGUE_LIFE, by itself, creates a new VIBRATIONDATA_FATIGUE_LIFE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_FATIGUE_LIFE returns the handle to a new VIBRATIONDATA_FATIGUE_LIFE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_FATIGUE_LIFE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_FATIGUE_LIFE.M with the given input arguments.
%
%      VIBRATIONDATA_FATIGUE_LIFE('Property','Value',...) creates a new VIBRATIONDATA_FATIGUE_LIFE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_fatigue_life_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_fatigue_life_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_fatigue_life

% Last Modified by GUIDE v2.5 26-Aug-2015 15:23:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_fatigue_life_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_fatigue_life_OutputFcn, ...
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


% --- Executes just before vibrationdata_fatigue_life is made visible.
function vibrationdata_fatigue_life_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_fatigue_life (see VARARGIN)

% Choose default command line output for vibrationdata_fatigue_life
handles.output = hObject;

change_unit(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_fatigue_life wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_fatigue_life_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_fatigue_life);


% --- Executes on selection change in listbox_material.
function listbox_material_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_material
change_unit(hObject, eventdata, handles); 

% --- Executes during object creation, after setting all properties.
function listbox_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_m_Callback(hObject, eventdata, handles)
% hObject    handle to edit_m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_m as text
%        str2double(get(hObject,'String')) returns contents of edit_m as a double


% --- Executes during object creation, after setting all properties.
function edit_m_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_A_Callback(hObject, eventdata, handles)
% hObject    handle to edit_A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_A as text
%        str2double(get(hObject,'String')) returns contents of edit_A as a double


% --- Executes during object creation, after setting all properties.
function edit_A_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function change_unit(hObject, eventdata, handles) 
%
n=get(handles.listbox_unit,'Value');
n_mat=get(handles.listbox_material,'Value');

[mlab,m,A,ss,ms,As]=Basquin_coefficients(n,n_mat);

set(handles.text_unit,'String',ss);
set(handles.edit_m,'String',ms);
set(handles.edit_A,'String',As);

setappdata(0,'mlab',mlab);
setappdata(0,'A_label',ss); 

set(handles.text_unit,'String',ss);
 
set(handles.edit_m,'String',ms);
set(handles.edit_A,'String',As);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

RT=str2num(get(handles.edit_RT,'String'));

scf=str2num(get(handles.edit_scf,'String'));

FS=get(handles.edit_input_array,'String');
THM=evalin('base',FS); 

disp(' ');
disp('***************************************************');

out1=sprintf('\n PSD filename:  %s \n',FS);
disp(out1);


f=THM(:,1);
a=THM(:,2);

a=a*scf^2;

%
if(f(1)<0.0001)
    f(1)=0.0001;
end    

%
[s,rms]=calculate_PSD_slopes(f,a);
%

fig_num=1;

n=get(handles.listbox_unit,'Value');

fmin=f(1);
fmax=max(f);


xlab='Frequency (Hz)';

if(n==1)
    ylab='Stress (psi^2/Hz)';
    t_string=sprintf('Stress PSD  %7.3g psi RMS',rms);
end
if(n==2)
    ylab='Stress (ksi^2/Hz)';
    t_string=sprintf('Stress PSD  %7.3g ksi RMS',rms);
end
if(n==3)
    ylab='Stress (MPa^2/Hz)';
    t_string=sprintf('Stress PSD  %7.3g MPa RMS',rms);
end

out1=sprintf('PSD unit:  %s ',ylab);
disp(out1);

mlab=getappdata(0,'mlab');
 
out1=sprintf('\n Material: %s ',mlab);
disp(out1);


[fig_num]=plot_PSD_function(fig_num,xlab,ylab,t_string,THM,fmin,fmax);

%
sigma_s=rms;
%
df=f(1)/20;
if(df==0)
    df=0.001;
end
[fi,ai]=interpolate_PSD(f,a,s,df);


m=str2num(get(handles.edit_m,'String'));
A=str2num(get(handles.edit_A,'String'));

tau=1;  % duration


out1=sprintf(' Fatigue exponent m = %g ',m);
disp(out1);
out1=sprintf(' Fatigue strength coefficient = %g ',A);
disp(out1);
out1=sprintf(' Stress concentration factor = %g \n',scf);
disp(out1);
out1=sprintf(' Miners failure threshold = %g  \n',RT);
disp(out1);


clear length;
n=length(fi);
%
m0=0;
m1=0;
m2=0;
m4=0;
M2m=0;
Mkp2=0;
m0p75=0;
m1p5=0;
%
m_fatigue_exponent=0;
%
ae=2/m;
be=ae+2;
%
for i=1:n
%    
    m0=m0+ai(i)*df;
    m1=m1+ai(i)*fi(i)*df;
    m2=m2+ai(i)*fi(i)^2*df;
    m4=m4+ai(i)*fi(i)^4*df;
    M2m=M2m+ai(i)*fi(i)^ae*df;
    Mkp2=Mkp2+ai(i)*fi(i)^be*df;
%    
    m0p75=m0p75+ai(i)*fi(i)^0.75*df;
    m1p5=m1p5+ai(i)*fi(i)^1.5*df;
%
    m_fatigue_exponent=m_fatigue_exponent+ai(i)*fi(i)^m*df;
%
end
%
 m2_norm=0;
M2m_norm=0;
%
for i=1:n
     m2_norm=m2_norm+(ai(i)/m0)*fi(i)^2*df;    
    M2m_norm=M2m_norm+(ai(i)/m0)*fi(i)^ae*df;
end    
%
out1=sprintf('m0=%8.4g \nm1=%8.4g \nm2=%8.4g \nm4=%8.4g \n',m0,m1,m2,m4);
disp(out1);
out1=sprintf('M2m=%8.4g \nMkp2=%8.4g \nm0p75=%8.4g \nm1p5=%8.4g \n',M2m,Mkp2,m0p75,m1p5);
disp(out1);
%% out1=sprintf('m_fatigue_exponent=%8.4g \n',m_fatigue_exponent);
%% disp(out1);
%
%
alpha_0p75=m0p75/sqrt(m0*m1p5);
alpha_1=m1/sqrt(m0*m2);
alpha_2=m2/sqrt(m0*m4);
%
vo=sqrt(m2/m0);
vp=sqrt(m4/m2);
%
alpha=vo/vp;
e=sqrt(1-alpha^2);
%
delta=sqrt(1-alpha_1);
%
arg=0.5*m+1;
gf=gamma(arg);
%
beta=sqrt(m2*M2m/(m0*Mkp2));
betaem=beta^m;
%
lambda_oc=betaem/alpha;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

denR=(M2m_norm^(m/2))*gf*(sqrt(2)*sigma_s)^m;

tRaj=  A/denR;  % Rajcher

Raj=1/tRaj;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
DNB=((vo*tau)/A)*gf*(sqrt(2)*sigma_s)^m;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
DOC=DNB*lambda_oc;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
a=0.926-0.033*m;
b=1.587*m-2.323;
ee=sqrt(1-alpha_2);
lambda_wl=a+(1-a)*(1-ee)^b;
%
DWL=DNB*lambda_wl;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
lambda_ll=M2m^(m/2)/(vo*sigma_s^m);
DLL=DNB*lambda_ll;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
h=1+alpha_1*alpha_2-(alpha_1+alpha_2);
term1=1.112*h*exp(2.11*alpha_2);
term2=(alpha_1-alpha_2);
%
b=(alpha_1-alpha_2)*(term1+term2)/(alpha_2-1)^2;
lambda_bt=(b+(1-b)*alpha_2^(m-1));
DBT=DNB*lambda_bt;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
DAL=alpha_0p75^2*DNB;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
[DZB]=sf_Zhao_Baker(fi,ai,m,A,df,sigma_s,tau,vp,m0,m1,m2,m4,alpha_2);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
T=tau;

[DDK]=sf_Dirlik(m,A,T,m0,m1,m2,m4);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
out1=sprintf('     Rate of Zero Crossings = %8.4g per sec',vo);
out2=sprintf('              Rate of Peaks = %8.4g per sec',vp);
out3=sprintf('  Irregularity Factor alpha = %8.4g ',alpha);
out4=sprintf('   Spectral Width Parameter = %8.4g ',e);
out42=sprintf('       Vanmarckes Parameter = %8.4g ',delta);

%



DNBr=DNB/tau;
DDKr=DDK/tau; 
DALr=DAL/tau;
DOCr=DOC/tau;
DZBr=DZB/tau;
DLLr=DLL/tau;
DWLr=DWL/tau; 
DBTr=DBT/tau;
                                   

tDNB=RT/DNBr;
tDDK=RT/DDKr; 
tDAL=RT/DALr;
tDOC=RT/DOCr;
tDZB=RT/DZBr;
tDLL=RT/DLLr;
tDWL=RT/DWLr; 
tDBT=RT/DBTr;

%
disp(' ');
disp(out1);
disp(out2);
disp(' ');
disp(out3);
disp(out4);
disp(out42);
disp(' ');


         disp('          Method     Fatigue Life    Damage Rate');
         disp('                        (sec)           (1/sec) ');
         
 out8=sprintf('         Narrowband    %8.4e    %8.4e',tDNB,DNB);
 out9=sprintf('             Dirlik    %8.4e    %8.4e',tDDK,DDK);
out10=sprintf('            Rajcher    %8.4e    %8.4e',tRaj,Raj); 
out11=sprintf('         Alpha 0.75    %8.4e    %8.4e',tDAL,DAL);
out12=sprintf('         Ortiz Chen    %8.4e    %8.4e',tDOC,DOC);
out13=sprintf('         Zhao Baker    %8.4e    %8.4e',tDZB,DZB);
out14=sprintf('       Lutes Larsen    %8.4e    %8.4e',tDLL,DLL);
out15=sprintf('    Wirsching Light    %8.4e    %8.4e',tDWL,DWL); 
out16=sprintf('   Benasciutti Tovo    %8.4e    %8.4e',tDBT,tDBT);

                       
disp(out8);
disp(out9);
disp(out10);
disp(out11);
disp(out12);
disp(out13);
disp(out14);
disp(out15);
disp(out16);


disp(' ');
disp('         Method     Fatigue Life   ');
disp(' ');

[y,d,h,m,s]=time_format_conversion(tDNB);
out20=sprintf('          Narrowband  %g years %g days %g hr %g min %g sec',y,d,h,m,s);

[y,d,h,m,s]=time_format_conversion(tDDK);
out21=sprintf('              Dirlik  %g years %g days %g hr %g min %g sec',y,d,h,m,s);


[y,d,h,m,s]=time_format_conversion(tRaj);
out22=sprintf('             Rajcher  %g years %g days %g hr %g min %g sec',y,d,h,m,s);

[y,d,h,m,s]=time_format_conversion(tDAL);
out23=sprintf('          Alpha 0.75  %g years %g days %g hr %g min %g sec',y,d,h,m,s);

[y,d,h,m,s]=time_format_conversion(tDOC);
out24=sprintf('          Ortiz Chen  %g years %g days %g hr %g min %g sec',y,d,h,m,s);

[y,d,h,m,s]=time_format_conversion(tDZB);
out25=sprintf('          Zhao Baker  %g years %g days %g hr %g min %g sec',y,d,h,m,s);

[y,d,h,m,s]=time_format_conversion(tDLL);
out26=sprintf('        Lutes Larsen  %g years %g days %g hr %g min %g sec',y,d,h,m,s);

[y,d,h,m,s]=time_format_conversion(tDWL);
out27=sprintf('     Wirsching Light  %g years %g days %g hr %g min %g sec',y,d,h,m,s);

[y,d,h,m,s]=time_format_conversion(tDBT);
out28=sprintf('    Benasciutti Tovo  %g years %g days %g hr %g min %g sec',y,d,h,m,s);


disp(out20);
disp(out21);
disp(out22);
disp(out23);
disp(out24);
disp(out25);
disp(out26);
disp(out27);
disp(out28);


flife=[tDNB,tDDK,tRaj,tDAL,tDOC,tDZB,tDLL,tDWL,tDBT];

maxl=max(flife);
minl=min(flife);
meanl=mean(flife);

disp(' ');
disp('        Summary  ');
disp(' ');

[y,d,h,m,s]=time_format_conversion(maxl);
out40=sprintf('      Maximum  %g years %g days %g hr %g min %g sec',y,d,h,m,s);  

[y,d,h,m,s]=time_format_conversion(meanl);
out41=sprintf('         Mean  %g years %g days %g hr %g min %g sec',y,d,h,m,s);

[y,d,h,m,s]=time_format_conversion(minl);
out42=sprintf('      Minimum  %g years %g days %g hr %g min %g sec',y,d,h,m,s);

disp(out40);
disp(out41);
disp(out42);
msgbox('Calculation complete. Results written to Command Window.');



function edit_scf_Callback(hObject, eventdata, handles)
% hObject    handle to edit_scf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_scf as text
%        str2double(get(hObject,'String')) returns contents of edit_scf as a double


% --- Executes during object creation, after setting all properties.
function edit_scf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_scf (see GCBO)
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


% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit
change_unit(hObject, eventdata, handles); 

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



function edit_RT_Callback(hObject, eventdata, handles)
% hObject    handle to edit_RT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_RT as text
%        str2double(get(hObject,'String')) returns contents of edit_RT as a double


% --- Executes during object creation, after setting all properties.
function edit_RT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_RT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

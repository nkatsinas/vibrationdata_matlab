function varargout = vibrationdata_stress_psd_fatigue_special(varargin)
% VIBRATIONDATA_STRESS_PSD_FATIGUE_SPECIAL MATLAB code for vibrationdata_stress_psd_fatigue_special.fig
%      VIBRATIONDATA_STRESS_PSD_FATIGUE_SPECIAL, by itself, creates a new VIBRATIONDATA_STRESS_PSD_FATIGUE_SPECIAL or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_STRESS_PSD_FATIGUE_SPECIAL returns the handle to a new VIBRATIONDATA_STRESS_PSD_FATIGUE_SPECIAL or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_STRESS_PSD_FATIGUE_SPECIAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_STRESS_PSD_FATIGUE_SPECIAL.M with the given input arguments.
%
%      VIBRATIONDATA_STRESS_PSD_FATIGUE_SPECIAL('Property','Value',...) creates a new VIBRATIONDATA_STRESS_PSD_FATIGUE_SPECIAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_stress_psd_fatigue_special_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_stress_psd_fatigue_special_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_stress_psd_fatigue_special

% Last Modified by GUIDE v2.5 24-Feb-2016 10:01:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_stress_psd_fatigue_special_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_stress_psd_fatigue_special_OutputFcn, ...
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


% --- Executes just before vibrationdata_stress_psd_fatigue_special is made visible.
function vibrationdata_stress_psd_fatigue_special_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_stress_psd_fatigue_special (see VARARGIN)

% Choose default command line output for vibrationdata_stress_psd_fatigue_special
handles.output = hObject;


change_unit(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_stress_psd_fatigue_special wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function change_unit(hObject, eventdata, handles) 
%
n=get(handles.listbox_unit,'Value');
n_mat=get(handles.listbox_material,'Value');


 
mlab='other'; 
 
if(n_mat==1) % aluminum 6061-T6
    m=9.25; 
    mlab='aluminum 6061-T6';
end
if(n_mat==2) % butt-welded steel
    m=3.5;
    mlab='butt-welded steel';
end    
if(n_mat==3) % stainless steel
    m=6.54;
    mlab='stainless steel';
end
 
if(n_mat==4) % Petrucci: aluminum
    m=7.3; 
    mlab='Petrucci: aluminum 2219-T851';
end
if(n_mat==5) % Petrucci: steel
    m=3.324;
    mlab='Petrucci: steel';    
end    
if(n_mat==6) % Petrucci: spring steel
    m=11.760;
    mlab='Petrucci: spring steel';       
end
 
setappdata(0,'mlab',mlab);
 
 
 
if(n_mat==1)  % aluminum 6061-T6
 
    Aksi=9.7724e+17;
    
    if(n==1)
        A=((Aksi^(1/m))*1000)^m;
    end
    if(n==2)
        A=Aksi;        
    end    
    if(n==3)
        A=5.5757e+25;        
    end
    
end
if(n_mat==2)  % butt-welded steel
 
      
    Aksi=1.255e+11;
    
    if(n==1)
        A=((Aksi^(1/m))*1000)^m;
    end
    if(n==2)
        A=Aksi;        
    end    
    if(n==3)
        A=1.080e+14;      
    end    
    
end
if(n_mat==3)  % stainless steel
   
    Aksi=1.32E+18;
    
    if(n==1)
        A=((Aksi^(1/m))*1000)^m;
    end
    if(n==2)
        A=Aksi;        
    end    
    if(n==3)
        A=4.0224e+23;      
    end        
    
end
if(n_mat==4)  % Petrucci: aluminum
   
    Aksi=5.18E+13;
    
    if(n==1)
        A=((Aksi^(1/m))*1000)^m;
    end
    if(n==2)
        A=Aksi;        
    end    
    if(n==3)
        A=6.85E+19;      
    end        
    
end
if(n_mat==5)  % Petrucci: steel
   
    Aksi=3.16E+09;
    
    if(n==1)
        A=((Aksi^(1/m))*1000)^m;
    end
    if(n==2)
        A=Aksi;        
    end    
    if(n==3)
        A=1.93E+12;      
    end        
    
end
if(n_mat==6)  % Petrucci: spring steel
   
    Aksi=1.95E+27;
    
    if(n==1)
        A=((Aksi^(1/m))*1000)^m;
    end
    if(n==2)
        A=Aksi;        
    end    
    if(n==3)
        A=1.41E+37;      
    end        
    
end
 
 
 
 
if(n_mat<=6)
    ms=sprintf('%g',m);    
    As=sprintf('%8.4g',A);
    
    
    if(n==1)
        ss=sprintf('psi^%g',m);
    end
    if(n==2)
        ss=sprintf('ksi^%g',m);        
    end
    if(n==3)
        ss=sprintf('MPa^%g',m);        
    end
    
else
    ms='';    
    As='';    

    if(n==1)
        ss=sprintf('psi^m');
    end
    if(n==2)
        ss=sprintf('ksi^m');        
    end
    if(n==3)
        ss=sprintf('MPa^m');        
    end
   
end

set(handles.text_unit,'String',ss);
 
set(handles.edit_m,'String',ms);
set(handles.edit_A,'String',As);




% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_stress_psd_fatigue_special_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_stress_psd_fatigue);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

scf=str2num(get(handles.edit_scf,'String'));

FS=get(handles.edit_input_array,'String');
THM=evalin('base',FS); 

disp(' ');
disp('***************************************************');

out1=sprintf('\n PSD filename:  %s \n',FS);
disp(out1);

[f,a,s,rms,df,THM,fi,ai]=fatigue_psd_check(THM,scf);

%

fig_num=1;

n=get(handles.listbox_unit,'Value');

fmin=f(1);
fmax=max(f);

t_string='Stress PSD';
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

                 

m=str2num(get(handles.edit_m,'String'));
A=str2num(get(handles.edit_A,'String'));
tau=str2num(get(handles.edit_duration,'String'));


out1=sprintf(' Fatigue exponent m = %g ',m);
disp(out1);
out1=sprintf(' Fatigue strength coefficient = %g ',A);
disp(out1);
out1=sprintf(' Duration = %g sec \n',tau);
disp(out1);
out1=sprintf(' Stress concentration factor = %g \n',scf);
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
out5=sprintf('     Wirsching Light = %8.4g ',lambda_wl);
out6=sprintf('          Ortiz Chen = %8.4g ',lambda_oc);
out7=sprintf('      Lutes & Larsen = %8.4g ',lambda_ll);
%


DNBr=DNB/tau;
DDKr=DDK/tau; 
DALr=DAL/tau;
DOCr=DOC/tau;
DZBr=DZB/tau;
DLLr=DLL/tau;
DWLr=DWL/tau; 
DBTr=DBT/tau;

%

%
 out8=sprintf('         Narrowband DNB = %7.3g, \t %8.4e, \t %8.4e',DNB,DNBr,A*DNBr);
 out9=sprintf('             Dirlik DDK = %7.3g, \t %8.4e, \t %8.4e',DDK,DDKr,A*DDKr); 
out10=sprintf('         Alpha 0.75 DAL = %7.3g, \t %8.4e, \t %8.4e',DAL,DALr,A*DALr);
out11=sprintf('         Ortiz Chen DOC = %7.3g, \t %8.4e, \t %8.4e',DOC,DOCr,A*DOCr);
out12=sprintf('         Zhao Baker DZB = %7.3g, \t %8.4e, \t %8.4e',DZB,DZBr,A*DZBr);
out13=sprintf('       Lutes Larsen DLL = %7.3g, \t %8.4e, \t %8.4e',DLL,DLLr,A*DLLr);
out14=sprintf('    Wirsching Light DWL = %7.3g, \t %8.4e, \t %8.4e',DWL,DWLr,A*DWLr); 
out15=sprintf('   Benasciutti Tovo DBT = %7.3g, \t %8.4e, \t %8.4e',DBT,DBTr,A*DBTr);
%
out2001=sprintf('%s \t %8.4e \t %8.4e \t %8.4e \t %8.4e \t %8.4e \t %8.4e \t %8.4e \t %8.4e \t %8.4e \t %8.4e',...
                                       FS,DNBr,DDKr,DALr,DOCr,DZBr,DLLr,DWLr,DBTr,vo,vp);
                                
data=[DNBr DDKr DALr DOCr DZBr DLLr DWLr DBTr vo vp];

mss=get(handles.edit_m,'String');
ms=sprintf('%s',mss);
ms = strrep(ms, '.', 'p');
output_name=sprintf('%s_%s_smf',FS,ms);
assignin('base', output_name, data);                                   
%
disp(' ');
disp(out1);
disp(out2);
disp(' ');
disp(out3);
disp(out4);
disp(out42);
disp(' ');
disp(' Lambda Values   ');
disp(' ');
disp(out5);
disp(out6);
disp(out7);
disp(' ');

nn=get(handles.listbox_unit,'Value');

              disp('      Cumulative Damage             Damage Rate           A*rate  '); 

if(nn==1)
    out999=sprintf('                                      (1/sec)         ((psi^%g)/sec) ',m);
end
if(nn==2)
    out999=sprintf('                                      (1/sec)         ((ksi^%g)/sec) ',m);
end
if(nn==3)
    out999=sprintf('                                      (1/sec)         ((MPa^%g)/sec) ',m);
end  
disp(out999);


disp(' ');
disp(out8);
disp(out9);
disp(out10);
disp(out11);
disp(out12);
disp(out13);
disp(out14);
disp(out15);
%
disp(' ');
disp(' Average of DAL,DOC,DLL,DBT,DZB,DDK ');
%
av=(DAL+DOC+DLL+DBT+DZB+DDK)/6;
%
out16=sprintf('\n          average=%8.4g \n',av);
disp(out16);

%% disp(out2001);   
clipboard('copy', out2001)

%% msgbox('Calculation complete. Results written to Command Window.');


function edit_duration_Callback(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_duration as text
%        str2double(get(hObject,'String')) returns contents of edit_duration as a double


% --- Executes during object creation, after setting all properties.
function edit_duration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
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

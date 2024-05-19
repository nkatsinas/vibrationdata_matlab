function varargout = batch_Dirlik_Miners_damage_stress_psd_Basquin(varargin)
% BATCH_DIRLIK_MINERS_DAMAGE_STRESS_PSD_BASQUIN MATLAB code for batch_Dirlik_Miners_damage_stress_psd_Basquin.fig
%      BATCH_DIRLIK_MINERS_DAMAGE_STRESS_PSD_BASQUIN, by itself, creates a new BATCH_DIRLIK_MINERS_DAMAGE_STRESS_PSD_BASQUIN or raises the existing
%      singleton*.
%
%      H = BATCH_DIRLIK_MINERS_DAMAGE_STRESS_PSD_BASQUIN returns the handle to a new BATCH_DIRLIK_MINERS_DAMAGE_STRESS_PSD_BASQUIN or the handle to
%      the existing singleton*.
%
%      BATCH_DIRLIK_MINERS_DAMAGE_STRESS_PSD_BASQUIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BATCH_DIRLIK_MINERS_DAMAGE_STRESS_PSD_BASQUIN.M with the given input arguments.
%
%      BATCH_DIRLIK_MINERS_DAMAGE_STRESS_PSD_BASQUIN('Property','Value',...) creates a new BATCH_DIRLIK_MINERS_DAMAGE_STRESS_PSD_BASQUIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before batch_Dirlik_Miners_damage_stress_psd_Basquin_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to batch_Dirlik_Miners_damage_stress_psd_Basquin_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help batch_Dirlik_Miners_damage_stress_psd_Basquin

% Last Modified by GUIDE v2.5 08-Jun-2018 17:24:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @batch_Dirlik_Miners_damage_stress_psd_Basquin_OpeningFcn, ...
                   'gui_OutputFcn',  @batch_Dirlik_Miners_damage_stress_psd_Basquin_OutputFcn, ...
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


% --- Executes just before batch_Dirlik_Miners_damage_stress_psd_Basquin is made visible.
function batch_Dirlik_Miners_damage_stress_psd_Basquin_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to batch_Dirlik_Miners_damage_stress_psd_Basquin (see VARARGIN)

% Choose default command line output for batch_Dirlik_Miners_damage_stress_psd_Basquin
handles.output = hObject;


change_unit(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes batch_Dirlik_Miners_damage_stress_psd_Basquin wait for user response (see UIRESUME)
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
function varargout = batch_Dirlik_Miners_damage_stress_psd_Basquin_OutputFcn(hObject, eventdata, handles) 
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

delete(batch_Dirlik_Miners_damage_stress_psd_Basquin);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


disp(' ');
disp('***************************************************');

eoa=get(handles.edit_output_array,'String');

scf=str2num(get(handles.edit_scf,'String'));
n=get(handles.listbox_unit,'Value');

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

try
    FS=get(handles.edit_input_array,'String');
    sarray=evalin('base',FS);
catch
    warndlg('Input string array not found.');
    return; 
end    
 
if(iscell(sarray)==0)
    warndlg('Input must be array of strings (class=cell)');  
    return;
end
 


kv=length(sarray);


DOC=zeros(kv,1);
DWL=zeros(kv,1);
DLL=zeros(kv,1);
DNB=zeros(kv,1);
DBT=zeros(kv,1);
DAL=zeros(kv,1);
DZB=zeros(kv,1);
DDK=zeros(kv,1);

 
for ijk=1:kv
    
    ss=char(sarray(ijk,:));
    THM=evalin('base',ss);

    [f,a,s,rms,df,THM,fi,ai]=fatigue_psd_check(THM,scf);

    sigma_s=rms;
%

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
    DNB(ijk)=((vo*tau)/A)*gf*(sqrt(2)*sigma_s)^m;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    DOC(ijk)=DNB(ijk)*lambda_oc;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    a=0.926-0.033*m;
    b=1.587*m-2.323;
    ee=sqrt(1-alpha_2);
    lambda_wl=a+(1-a)*(1-ee)^b;
%
    DWL(ijk)=DNB(ijk)*lambda_wl;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    lambda_ll=M2m^(m/2)/(vo*sigma_s^m);
    DLL(ijk)=DNB(ijk)*lambda_ll;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    h=1+alpha_1*alpha_2-(alpha_1+alpha_2);
    term1=1.112*h*exp(2.11*alpha_2);
    term2=(alpha_1-alpha_2);
%
    b=(alpha_1-alpha_2)*(term1+term2)/(alpha_2-1)^2;
    lambda_bt=(b+(1-b)*alpha_2^(m-1));
    DBT(ijk)=DNB(ijk)*lambda_bt;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    DAL(ijk)=alpha_0p75^2*DNB(ijk);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    [DZB(ijk)]=sf_Zhao_Baker(fi,ai,m,A,df,sigma_s,tau,vp,m0,m1,m2,m4,alpha_2);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

    T=tau;

    [DDK(ijk)]=sf_Dirlik(m,A,T,m0,m1,m2,m4);
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
%
    ssq{ijk}=ss;

    

end    


Narrowband=DNB;
Dirlik=DDK;
Alpha_0p75=DAL;
Ortiz_Chen=DOC;
Zhao_Baker=DZB;
Lutes_Larsen=DLL;
Wirsching_Light=DWL;
Benasciutti_Tovo=DBT; 

ssq=ssq';

Array=ssq;

disp(' ');
disp('   Damage Table ');

T = table(Array,Narrowband,Dirlik,Alpha_0p75,Ortiz_Chen,Zhao_Baker,Lutes_Larsen,Wirsching_Light,Benasciutti_Tovo);

T

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:kv
    data_s{i,1} = ssq{i};  
    data_s{i,2} = sprintf('%9.4g',Narrowband(i)); 
    data_s{i,3} = sprintf('%9.4g',Dirlik(i)); 
    data_s{i,4} = sprintf('%9.4g',Alpha_0p75(i)); 
    data_s{i,5} = sprintf('%9.4g',Ortiz_Chen(i)); 
    data_s{i,6} = sprintf('%9.4g',Zhao_Baker(i)); 
    data_s{i,7} = sprintf('%9.4g',Lutes_Larsen(i));  
    data_s{i,8} = sprintf('%9.4g',Wirsching_Light(i)); 
    data_s{i,9} = sprintf('%9.4g',Benasciutti_Tovo(i)); 


    data_ss{i,1} = ssq{i};   
    data_ss{i,2} = sprintf('%9.4g',Dirlik(i)); 

end



assignin('base', eoa, data_ss);


hFig = figure(100);

columnname =   {'Array','Narrowband','Dirlik','Alpha 0.75','Ortiz Chen','Zhao Baker','Lutes Larsen','Wirsching Light','Benasciutti Tovo'};
columnformat = {'numeric', 'numeric','numeric', 'numeric','numeric', 'numeric','numeric', 'numeric','numeric'};
columneditable = [false false false false false false false false false];   
columnwidth={ 140 100 100 100 100 100 100 100 100 };

xwidth=1200;
ywidth=500;
set(gcf,'PaperPositionMode','auto')
set(hFig, 'Position', [0 0 xwidth ywidth])
table1 = uitable;


%
    table1 = uitable('Units','normalized','Position',...
            [0 0 1 1], 'Data', data_s,... 
            'ColumnName', columnname,...
            'ColumnFormat', columnformat,...
            'ColumnEditable', columneditable,...
            'ColumnWidth', columnwidth,...
            'RowName',[]);  

    table1.FontSize = 9;

%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


disp(' ');


msgbox('Calculation complete');


%% disp(out2001);   
%% clipboard('copy', out2001)

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


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



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

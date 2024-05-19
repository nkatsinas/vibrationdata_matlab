function varargout = batch_Dirlik_Miners_damage_stress_psd_Basquin_mean(varargin)
% BATCH_DIRLIK_MINERS_DAMAGE_STRESS_PSD_BASQUIN_MEAN MATLAB code for batch_Dirlik_Miners_damage_stress_psd_Basquin_mean.fig
%      BATCH_DIRLIK_MINERS_DAMAGE_STRESS_PSD_BASQUIN_MEAN, by itself, creates a new BATCH_DIRLIK_MINERS_DAMAGE_STRESS_PSD_BASQUIN_MEAN or raises the existing
%      singleton*.
%
%      H = BATCH_DIRLIK_MINERS_DAMAGE_STRESS_PSD_BASQUIN_MEAN returns the handle to a new BATCH_DIRLIK_MINERS_DAMAGE_STRESS_PSD_BASQUIN_MEAN or the handle to
%      the existing singleton*.
%
%      BATCH_DIRLIK_MINERS_DAMAGE_STRESS_PSD_BASQUIN_MEAN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BATCH_DIRLIK_MINERS_DAMAGE_STRESS_PSD_BASQUIN_MEAN.M with the given input arguments.
%
%      BATCH_DIRLIK_MINERS_DAMAGE_STRESS_PSD_BASQUIN_MEAN('Property','Value',...) creates a new BATCH_DIRLIK_MINERS_DAMAGE_STRESS_PSD_BASQUIN_MEAN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before batch_Dirlik_Miners_damage_stress_psd_Basquin_mean_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to batch_Dirlik_Miners_damage_stress_psd_Basquin_mean_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help batch_Dirlik_Miners_damage_stress_psd_Basquin_mean

% Last Modified by GUIDE v2.5 11-Jun-2018 14:58:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @batch_Dirlik_Miners_damage_stress_psd_Basquin_mean_OpeningFcn, ...
                   'gui_OutputFcn',  @batch_Dirlik_Miners_damage_stress_psd_Basquin_mean_OutputFcn, ...
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


% --- Executes just before batch_Dirlik_Miners_damage_stress_psd_Basquin_mean is made visible.
function batch_Dirlik_Miners_damage_stress_psd_Basquin_mean_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to batch_Dirlik_Miners_damage_stress_psd_Basquin_mean (see VARARGIN)

% Choose default command line output for batch_Dirlik_Miners_damage_stress_psd_Basquin_mean
handles.output = hObject;

change_unit(hObject, eventdata, handles);
listbox_mean_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes batch_Dirlik_Miners_damage_stress_psd_Basquin_mean wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = batch_Dirlik_Miners_damage_stress_psd_Basquin_mean_OutputFcn(hObject, eventdata, handles) 
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


disp(' ');
disp('***************************************************');
disp(' ');


scf=str2num(get(handles.edit_scf,'String'));

n=get(handles.listbox_unit,'Value');

m=str2num(get(handles.edit_m,'String'));
A=str2num(get(handles.edit_A,'String'));
tau=str2num(get(handles.edit_duration,'String'));
T=tau;

eoa=get(handles.edit_output_array,'String');
 
 
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
 
 
out1=sprintf(' Fatigue exponent m = %g ',m);
disp(out1);
out1=sprintf(' Fatigue strength coefficient = %g ',A);
disp(out1);
out1=sprintf(' Duration = %g sec \n',tau);
disp(out1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');

mc=get(handles.listbox_mean,'Value');

if(mc>=2)
    mean_stress=str2num(get(handles.edit_mean_stress,'String'));    
    aux_stress=str2num(get(handles.edit_stress_aux,'String'));
end


    if(mc==2) % Gerber Ultimate Stress 
        disp(' Gerber mean stress correction ');
    end
    if(mc==3) % Goodman Ultimate Stress 
        disp(' Goodman mean stress correction ');
    end
    if(mc==4) % Morrow True Fracture
        disp(' Morrow mean stress correction ');
    end
    if(mc==5) % Soderberg Yield Stress
        disp(' Soderberg mean stress correction '); 
    end
    
    disp(' ');

    if(mc>=2)
        iu=get(handles.listbox_unit,'Value');
        if(iu==1)
                out1=sprintf('          Mean Stress = %8.4g psi',mean_stress);
            if(mc==2 || mc==3)
                out2=sprintf('      Ultimate Stress = %8.4g psi',aux_stress);
            end 
            if(mc==4)
                out2=sprintf(' True Fracture Stress = %8.4g psi',aux_stress);
            end              
            if(mc==5)
                out2=sprintf('         Yield Stress = %8.4g psi',aux_stress);
            end             
        end
        if(iu==2)
                out1=sprintf('          Mean Stress = %8.4g ksi',mean_stress);  
             if(mc==2 || mc==3)
                out2=sprintf('      Ultimate Stress = %8.4g ksi',aux_stress);
            end 
            if(mc==4)
                out2=sprintf(' True Fracture Stress = %8.4g ksi',aux_stress);
            end              
            if(mc==5)
                out2=sprintf('         Yield Stress = %8.4g ksi',aux_stress);
            end            
        end
        if(iu==3)
                out1=sprintf('          Mean Stress = %8.4g MPa',mean_stress);
            if(mc==2 || mc==3)
                out2=sprintf('      Ultimate Stress = %8.4g MPa',aux_stress);
            end 
            if(mc==4)
                out2=sprintf(' True Fracture Stress = %8.4g MPa',aux_stress);
            end              
            if(mc==5)
                out2=sprintf('         Yield Stress = %8.4g MPa',aux_stress);
            end             
        end        
        disp(out1);
        disp(out2);
    end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%

kv=length(sarray); 

damage=zeros(kv,1);
 
for ijk=1:kv
 
    ss=char(sarray(ijk,:));
    THM=evalin('base',ss);

    [f,a,s,rms,df,THM,fi,ai]=fatigue_psd_check(THM,scf);
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
    end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    [D1,D2,D3,R,Q,EP]=Dirlik_coefficients(m0,m1,m2,m4);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Note that range = (peak-valley)
%
%  maxS is the assumed upper limit of the the histogram.
%
%  The value 6*grms is used as conservative estimate of the upper
%  range maxS for all cycles.  
%
%  The histogram will have 400 bins.  This number is chosen
%  via engineering judgement.
%
%    ds is the bin range width       
%     n is the number of bins
%     N is the cycle count per bin
%     S is the range level for each bin
%
    rms=sqrt(m0);
%
    maxS=6*rms;  
%
    ds=maxS/400;
%
    n=round(maxS/ds);
%
    N=zeros(n,1);
    S=zeros(n,1);
%
    area=0;
%
%
    for i=1:n
        S(i)=(i-1)*ds;
        Z=S(i)/(2*sqrt(m0));
%    
        t1=(D1/Q)*exp(-Z/Q);
        a=-Z^2;
        b=2*R^2;
%    
        t2=(D2*Z/R^2)*exp(a/b);
        t3=D3*Z*exp(-Z^2/2);
%    
        pn=t1+t2+t3;
        pd=2*sqrt(m0);
        p=pn/pd;
%    
        N(i)=p;
        Se=S(i);
%%
        if(mc==2) % Gerber Ultimate Stress 
            C=1-(mean_stress/aux_stress)^2;
        end
        if(mc==3) % Goodman Ultimate Stress 
            C=1-(mean_stress/aux_stress);
        end
        if(mc==4) % Morrow True Fracture
            C=1-(mean_stress/aux_stress);
        end
        if(mc==5) % Soderberg Yield Stress
            C=1-(mean_stress/aux_stress);
        end
    
        if(mc==1)
            area=area+(Se^m)*N(i)*ds;
        else    
            Se=S(i)/C;
%
            if(Se>=aux_stress)
                disp('Failure:  stress exceeds limit');
                warndlg('Failure:  stress exceeds limit');
                return;
            else
                if(Se<aux_stress)
                    area=area+(Se^m)*N(i)*ds;
                end     
            end
%
        end
%%

    end
%
    DDK=(area*EP*T/A)/(2^m);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    ssq{ijk}=ss;

    damage(ijk)=DDK;
end    

for i=1:kv
    data_s{i,1} = ssq{i}; 
    data_s{i,2} = sprintf('%9.4g',damage(i)); 
end


ssq=ssq';

Array=ssq;
Damage=damage;


disp('  Dirlik cumulative damage  ');
 
T = table(Array,Damage);

T


assignin('base', eoa, data_s);

%%%

hFig = figure(100);

columnname =   {'    Array    ','Damage'};
columnformat = {'numeric', 'numeric'};
columneditable = [false false];   
columnwidth={ 140 140 };

xwidth=300;
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


disp(' ');

msgbox('Calculation complete');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(batch_Dirlik_Miners_damage_stress_psd_Basquin_mean);


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

m=get(handles.listbox_mean,'Value');

if(n==1)
    set(handles.text_mean_stress,'String','Mean Stress (psi)');
    if(m>=2 && m<=3)
        set(handles.text_aux_stress,'String','Ultimate Stress Limit (psi)');
    end
    if(m==4)
        set(handles.text_aux_stress,'String','True Fracture Stress (psi)');    
    end
    if(m==5)
        set(handles.text_aux_stress,'String','Yield Stress Limits (psi)');      
    end
end
if(n==2)
    set(handles.text_mean_stress,'String','Mean Stress (ksi)');
    if(m>=2 && m<=3)
        set(handles.text_aux_stress,'String','Ultimate Stress Limit (ksi)');
    end
    if(m==4)
        set(handles.text_aux_stress,'String','True Fracture Stress (ksi)');    
    end
    if(m==5)
        set(handles.text_aux_stress,'String','Yield Stress Limits (ksi)');      
    end
end    
if(n==3)
    set(handles.text_mean_stress,'String','Mean Stress (MPa)');
    if(m>=2 && m<=3)
        set(handles.text_aux_stress,'String','Ultimate Stress Limit (MPa)');
    end
    if(m==4)
        set(handles.text_aux_stress,'String','True Fracture Stress (MPa)');    
    end
    if(m==5)
        set(handles.text_aux_stress,'String','Yield Stress Limits (MPa)');      
    end
end    



% --- Executes on selection change in listbox_mean.
function listbox_mean_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_mean contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_mean

n=get(handles.listbox_mean,'Value');

if(n==1)
    set(handles.edit_mean_stress,'Visible','off');
    set(handles.text_mean_stress,'Visible','off');
    set(handles.edit_stress_aux,'Visible','off');
    set(handles.text_aux_stress,'Visible','off');    
else
    set(handles.edit_mean_stress,'Visible','on');
    set(handles.text_mean_stress,'Visible','on');
    set(handles.edit_stress_aux,'Visible','on');
    set(handles.text_aux_stress,'Visible','on');     
end

iu=get(handles.listbox_unit,'Value');

if(n==2) % Gerber
    if(iu==1)
            set(handles.text_aux_stress,'String','Ultimate Stress Limit (psi)'); 
    end
    if(iu==2)
            set(handles.text_aux_stress,'String','Ultimate Stress Limit (ksi)'); 
    end
    if(iu==3)
            set(handles.text_aux_stress,'String','Ultimate Stress Limit (MPa)'); 
    end    
end
if(n==3) % Goodman
    if(iu==1)
            set(handles.text_aux_stress,'String','Ultimate Stress Limit (psi)');   
    end
    if(iu==2)
            set(handles.text_aux_stress,'String','Ultimate Stress Limit (ksi)');   
    end
    if(iu==3)
            set(handles.text_aux_stress,'String','Ultimate Stress Limit (MPa)');   
    end    
   
end
if(n==4) % Morrow
    if(iu==1)
            set(handles.text_aux_stress,'String','True Fracture Stress (psi)');   
    end
    if(iu==2)
            set(handles.text_aux_stress,'String','True Fracture Stress (ksi)');   
    end
    if(iu==3)
            set(handles.text_aux_stress,'String','True Fracture Stress (MPa)');   
    end    
  
end
if(n==5) % Soderberg
    if(iu==1)
            set(handles.text_aux_stress,'String','Yield Stress Limit (psi)');   
    end
    if(iu==2)
            set(handles.text_aux_stress,'String','Yield Stress Limit (ksi)');   
    end
    if(iu==3)
            set(handles.text_aux_stress,'String','Yield Stress Limit (MPa)');   
    end      
end








% --- Executes during object creation, after setting all properties.
function listbox_mean_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mean_stress_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mean_stress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mean_stress as text
%        str2double(get(hObject,'String')) returns contents of edit_mean_stress as a double


% --- Executes during object creation, after setting all properties.
function edit_mean_stress_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mean_stress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_stress_aux_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stress_aux (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stress_aux as text
%        str2double(get(hObject,'String')) returns contents of edit_stress_aux as a double


% --- Executes during object creation, after setting all properties.
function edit_stress_aux_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stress_aux (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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

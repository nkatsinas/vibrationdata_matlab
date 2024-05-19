function varargout = vibrationdata_long_force_frf(varargin)
% VIBRATIONDATA_LONG_FORCE_FRF MATLAB code for vibrationdata_long_force_frf.fig
%      VIBRATIONDATA_LONG_FORCE_FRF, by itself, creates a new VIBRATIONDATA_LONG_FORCE_FRF or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_LONG_FORCE_FRF returns the handle to a new VIBRATIONDATA_LONG_FORCE_FRF or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_LONG_FORCE_FRF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_LONG_FORCE_FRF.M with the given input arguments.
%
%      VIBRATIONDATA_LONG_FORCE_FRF('Property','Value',...) creates a new VIBRATIONDATA_LONG_FORCE_FRF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_long_force_frf_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_long_force_frf_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_long_force_frf

% Last Modified by GUIDE v2.5 29-Jul-2014 13:16:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_long_force_frf_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_long_force_frf_OutputFcn, ...
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


% --- Executes just before vibrationdata_long_force_frf is made visible.
function vibrationdata_long_force_frf_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_long_force_frf (see VARARGIN)

% Choose default command line output for vibrationdata_long_force_frf
handles.output = hObject;

change_unit_mat(hObject, eventdata, handles);
listbox_num_modes_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_long_force_frf wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function change_unit_mat(hObject, eventdata, handles)
%

  n_mat=get(handles.listbox_mat,'Value');
 n_unit=get(handles.listbox_unit,'Value');
n_cross=get(handles.listbox_cross,'Value');
 
 if(n_unit==1)
    set(handles.text_elastic_modulus,'String','Elastic Modulus (psi)');
    set(handles.text_mass_density,'String','Mass Density (lbm/in^3)');
    set(handles.text_length_unit,'String','inch');
 else
    set(handles.text_elastic_modulus,'String','Elastic Modulus (GPa)');
    set(handles.text_mass_density,'String','Mass Density (kg/m^3)');
    set(handles.text_length_unit,'String','meters');     
 end
 
%

 if(n_cross==1) % circular
    set(handles.text_area,'String','Diameter');
    if(n_unit==1)
        set(handles.text_area_unit,'String','inch');
    else
        set(handles.text_area_unit,'String','cm');   
    end
 else           % other 
    set(handles.text_area,'String','Area'); 
    if(n_unit==1)
        set(handles.text_area_unit,'String','in^2');
    else
        set(handles.text_area_unit,'String','cm^2');   
    end   
 end

% 
 
 if(n_unit==1)  % English
    if(n_mat==1) % aluminum
        E=1e+007;
        rho=0.1;  
    end  
    if(n_mat==2)  % steel
        E=3e+007;
        rho= 0.28;         
    end
    if(n_mat==3)  % copper
        E=1.6e+007;
        rho=  0.322;
    end
else                 % metric
    if(n_mat==1)  % aluminum
        E=70;
        rho=  2700;
    end
    if(n_mat==2)  % steel
        E=205;
        rho=  7700;        
    end
    if(n_mat==3)   % copper
        E=110;
        rho=  8900;
    end
end
 
if(n_mat<=3)
    ss1=sprintf('%8.4g',E);
    ss2=sprintf('%8.4g',rho);
 
    set(handles.edit_elastic_modulus,'String',ss1);
    set(handles.edit_mass_density,'String',ss2); 
else
    set(handles.edit_elastic_modulus,'String',' ');
    set(handles.edit_mass_density,'String',' ');    
end



% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_long_force_frf_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_long_force_frf);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

   kmax=get(handles.listbox_num_modes,'value');
 n_unit=get(handles.listbox_unit,'value');
n_cross=get(handles.listbox_cross,'Value');

     L=str2num(get(handles.edit_length,'String'));
  fmax=str2num(get(handles.edit_fmax,'String'));

  E=str2num(get(handles.edit_elastic_modulus,'String'));
rho=str2num(get(handles.edit_mass_density,'String'));

Q(1)=str2num(get(handles.edit_Q1,'String'));
Q(2)=str2num(get(handles.edit_Q2,'String'));
Q(3)=str2num(get(handles.edit_Q3,'String'));
Q(4)=str2num(get(handles.edit_Q4,'String'));


for i=1:kmax
    damp(i)=1/(2*Q(i));
end


 if(n_cross==1) % circular
     
    d=str2num(get(handles.edit_d_or_a,'String')); 
     
    area=pi*d^2/4; 
    
 else           % other 
    area=str2num(get(handles.edit_d_or_a,'Value')); 
 end

 if(n_unit==1)
    rho=rho/386;
 else    
   area=area/100^2; 
 end     
 
%
x=L;
%
QM=2/(rho*area*L);
%
j=sqrt(-1);
%
tpi=2*pi;
%
disp(' ');
disp(' Natural Frequency (Hz) ');
%
omegan=zeros(12,1);
%
c=sqrt(E/rho);
%
for k=1:kmax
%
    i=2*k-1;
%    
    omegan(k)=i*pi*c/(2*L);
    out1=sprintf(' %8.4g ',omegan(k)/(2*pi));
    disp(out1);
%    
    fn(k)=omegan(k)/tpi;
%
end
%
clear freq;
clear H;
clear Hm;
clear Hp;
clear Hstrain;
clear Hstrain_mag;
clear HL;
%
for jk=1:10000
    f=jk;
    if(f>fmax)
        break;
    end
    freq(jk)=f;
    omega=2*pi*f;
    H(jk)=0;
    Hstrain(jk)=0;
%    
    for k=1:kmax
%    
        i=2*k-1;
%    
        omegad=omegan(k)*sqrt(1-damp(k)^2);
        den=omegan(k)^2-omega^2 + j*2*damp(k)*omega*omegan(k);
        arg1=omegan(k)*L/c;    
%
        x=L;
        arg2=omegan(k)*x/c;
        num=sin(arg1)*sin(arg2);
%
        H(jk)=H(jk)+ num/den;
%
        x=0;
        arg2=omegan(k)*x/c;
        num=sin(arg1)*cos(arg2);
%
        Hstrain(jk)=Hstrain(jk)+ (omegan(k)/c)*(num/den);        
%
    end
end
%
sz=size(freq);
if(sz(2)>sz(1))
    freq=freq';
end
%
H=H*QM;
HM=abs(H);
%
%
sz=size(HM);
if(sz(2)>sz(1))
    HM=HM';
end
%
HL=[freq HM];
HLP=[freq HM.*HM];
%
Hstrain=Hstrain*QM;
Hstrain_mag=abs(Hstrain);
%
sz=size(Hstrain_mag);
if(sz(2)>sz(1))
    Hstrain_mag=Hstrain_mag';
end
%
Hstrain_trans=[freq Hstrain_mag];
HstrainP_trans=[freq Hstrain_mag.*Hstrain_mag];
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
figure(2);
plot(freq,Hstrain_mag);
xlabel(' Frequency (Hz) ');
ylabel(' H (strain/force) ');
title('Strain/Force Magnitude at x=0');
grid on;
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
%
figure(1);
plot(freq,HM);
xlabel(' Frequency (Hz) ');
ylabel(' H (in/lbf) ');
title('Receptance Magnitude at x=L');
grid on;
%
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
%
%%%%%%%%%%%%%%%
% 
%%%%%%%%%%%%%%%
%
Hstress_mag=E*Hstrain_mag;
%
Hstress_trans=[freq Hstress_mag];
HstressP_trans=[freq Hstress_mag.*Hstress_mag];
%
HstressP=[freq Hstress_mag.*Hstress_mag];
%
figure(3);
plot(freq,abs(Hstress_trans(:,2)));
xlabel(' Frequency (Hz) ');
ylabel(' H (stress/force) ');
title('Stress/Force Magnitude at x=0');
grid on;
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
%

setappdata(0,'HL',HL); 
setappdata(0,'HLP',HLP); 
setappdata(0,'Hstress_trans',Hstress_trans); 
setappdata(0,'HstressP_trans',HstressP_trans);

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
 
 
function edit_elastic_modulus_Callback(hObject, eventdata, handles)
% hObject    handle to edit_elastic_modulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_elastic_modulus as text
%        str2double(get(hObject,'String')) returns contents of edit_elastic_modulus as a double


% --- Executes during object creation, after setting all properties.
function edit_elastic_modulus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_elastic_modulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_mat.
function listbox_mat_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_mat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_mat contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_mat

change_unit_mat(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_mat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_mat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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

change_unit_mat(hObject, eventdata, handles);


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



function edit_length_Callback(hObject, eventdata, handles)
% hObject    handle to edit_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_length as text
%        str2double(get(hObject,'String')) returns contents of edit_length as a double


% --- Executes during object creation, after setting all properties.
function edit_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit_elastic_modulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_elastic_modulus as text
%        str2double(get(hObject,'String')) returns contents of edit_elastic_modulus as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_elastic_modulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_mat.
function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_mat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_mat contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_mat


% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_mat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mass_density_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mass_density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mass_density as text
%        str2double(get(hObject,'String')) returns contents of edit_mass_density as a double


% --- Executes during object creation, after setting all properties.
function edit_mass_density_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass_density (see GCBO)
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


% --- Executes on selection change in listbox_num_modes.
function listbox_num_modes_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num_modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num_modes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num_modes

n=get(handles.listbox_num_modes,'Value');

set(handles.edit_Q1,'Visible','on');
set(handles.edit_Q2,'Visible','off');
set(handles.edit_Q3,'Visible','off');
set(handles.edit_Q4,'Visible','off');

set(handles.text_Q1,'Visible','on');
set(handles.text_Q2,'Visible','off');
set(handles.text_Q3,'Visible','off');
set(handles.text_Q4,'Visible','off');


if(n>=2)
    set(handles.edit_Q2,'Visible','on');
    set(handles.text_Q2,'Visible','on');    
end
if(n>=3)
    set(handles.edit_Q3,'Visible','on'); 
    set(handles.text_Q3,'Visible','on');      
end
if(n==4)
    set(handles.edit_Q4,'Visible','on'); 
    set(handles.text_Q4,'Visible','on');    
end




% --- Executes during object creation, after setting all properties.
function listbox_num_modes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_num_modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_d_or_a_Callback(hObject, eventdata, handles)
% hObject    handle to edit_d_or_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_d_or_a as text
%        str2double(get(hObject,'String')) returns contents of edit_d_or_a as a double


% --- Executes during object creation, after setting all properties.
function edit_d_or_a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_d_or_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_cross.
function listbox_cross_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_cross (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_cross contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_cross
change_unit_mat(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_cross_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_cross (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Q1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q1 as text
%        str2double(get(hObject,'String')) returns contents of edit_Q1 as a double


% --- Executes during object creation, after setting all properties.
function edit_Q1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Q2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q2 as text
%        str2double(get(hObject,'String')) returns contents of edit_Q2 as a double


% --- Executes during object creation, after setting all properties.
function edit_Q2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Q3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q3 as text
%        str2double(get(hObject,'String')) returns contents of edit_Q3 as a double


% --- Executes during object creation, after setting all properties.
function edit_Q3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Q4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q4 as text
%        str2double(get(hObject,'String')) returns contents of edit_Q4 as a double


% --- Executes during object creation, after setting all properties.
function edit_Q4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_save,'Value');


if(n==1)
    data=getappdata(0,'HL');     
end
if(n==2)
    data=getappdata(0,'HLP');    
end
if(n==3)
    data=getappdata(0,'Hstress_trans');     
end
if(n==4)
    data=getappdata(0,'HstressP_trans');     
end

sz=size(data);

if(max(sz)==0)
    h = msgbox('Data size is zero ');    
else
    output_name=get(handles.edit_output_filename,'String');
    assignin('base', output_name,data);
    h = msgbox('Export Complete.  Press Return. ');
end



function edit_output_filename_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_filename as text
%        str2double(get(hObject,'String')) returns contents of edit_output_filename as a double


% --- Executes during object creation, after setting all properties.
function edit_output_filename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_save.
function listbox_save_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_save contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_save


% --- Executes during object creation, after setting all properties.
function listbox_save_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

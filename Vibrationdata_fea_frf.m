function varargout = Vibrationdata_fea_frf(varargin)
% VIBRATIONDATA_FEA_FRF MATLAB code for Vibrationdata_fea_frf.fig
%      VIBRATIONDATA_FEA_FRF, by itself, creates a new VIBRATIONDATA_FEA_FRF or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_FEA_FRF returns the handle to a new VIBRATIONDATA_FEA_FRF or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_FEA_FRF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_FEA_FRF.M with the given input arguments.
%
%      VIBRATIONDATA_FEA_FRF('Property','Value',...) creates a new VIBRATIONDATA_FEA_FRF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Vibrationdata_fea_frf_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Vibrationdata_fea_frf_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Vibrationdata_fea_frf

% Last Modified by GUIDE v2.5 28-Mar-2014 15:03:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Vibrationdata_fea_frf_OpeningFcn, ...
                   'gui_OutputFcn',  @Vibrationdata_fea_frf_OutputFcn, ...
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


% --- Executes just before Vibrationdata_fea_frf is made visible.
function Vibrationdata_fea_frf_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Vibrationdata_fea_frf (see VARARGIN)

% Choose default command line output for Vibrationdata_fea_frf
handles.output = hObject;

set(handles.listbox_frf_type,'Value',1);
set(handles.pushbutton_save,'Visible','off');

set_dof_boxes(hObject, eventdata, handles);

fig_num=1;
setappdata(0,'fig_num',fig_num);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Vibrationdata_fea_frf wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function set_dof_boxes(hObject, eventdata, handles)
%    
fn=getappdata(0,'fn');
%% ModeShapes=getappdata(0,'ModeShapes');


clear length;
n=length(fn);

for i=1:n
    string_th{i}=sprintf('%d',i);
end

set(handles.listbox_dof1,'String',string_th);
set(handles.listbox_dof2,'String',string_th);

s1=sprintf('%d',n);

set(handles.edit_num,'String',s1);


% --- Outputs from this function are returned to the command line.
function varargout = Vibrationdata_fea_frf_OutputFcn(hObject, eventdata, handles) 
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
delete(Vibrationdata_fea_frf);


% --- Executes on selection change in listbox_frf_type.
function listbox_frf_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_frf_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_frf_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_frf_type


% --- Executes during object creation, after setting all properties.
function listbox_frf_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_frf_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_dof1.
function listbox_dof1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_dof1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_dof1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_dof1


% --- Executes during object creation, after setting all properties.
function listbox_dof1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_dof1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_dof2.
function listbox_dof2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_dof2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_dof2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_dof2


% --- Executes during object creation, after setting all properties.
function listbox_dof2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_dof2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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

num_columns=str2num(get(handles.edit_num,'String'));

n=get(handles.listbox_frf_type,'Value');

if(n==1)
    t_string='Receptance FRF';
end
if(n==2)
    t_string='Mobility FRF';
end
if(n==3)
    t_string='Acclerance FRF';
end

iam=n;

nrb=0;

dof1=get(handles.listbox_dof1,'Value');
dof2=get(handles.listbox_dof2,'Value');

fnv=getappdata(0,'fn');
ModeShapes=getappdata(0,'ModeShapes');
QE=ModeShapes;

clear length;
nf=length(fnv);
dampv=zeros(nf,1);

try
    
    dtype=getappdata(0,'damping_type');
    
    if(dtype(1)==1)
        dratio=getappdata(0,'uniform_dratio');
        
        dampv(1:nf)=dratio;
        
    else
        dtab=getappdata(0,'table_dratio');
        
        sz=size(dtab);
        kd=sz(1);
        
        for i=1:nf
            for j=1:(kd-1)
                
               if(fnv(i)==dtab(j,1))
                   dampv(i)=dtab(j,2);
                   break;
               end 
               if(fnv(i)==dtab(j+1,1))
                   dampv(i)=dtab(j,2);
                   break;
               end 
               
               if(fnv(i)>dtab(j,1) && fnv(i)<dtab(j+1,1))
                   L=dtab(j+1,1)-dtab(j,1);
                   x=fnv(i)-dtab(j,1);
                   C2=x/L;
                   C1=1-C2;
                   dampv(i)=C1*dtab(j,2)+C2*dtab(j+1,2);
                   break;
               end
                   
            end
        end
        
    end
    
catch
   warndlg('Warning: damping values not entered yet.');
   return;
end

f1=str2num(get(handles.edit_f1,'String'));
f2=str2num(get(handles.edit_f2,'String'));
df=str2num(get(handles.edit_df,'String'));

minf=f1;
maxf=f2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(maxf<=minf)
    maxf=100*minf;
end
%
nf=floor((maxf-minf)/df);
clear omega;
%
freq=zeros(nf,1);
omega=zeros(nf,1);
omega2=zeros(nf,1);

for i=1:nf
    freq(i)=(i-1)*df+minf;
    omega(i)=2*pi*freq(i);
    omega2(i)=(omega(i))^2;
end

clear length;
for i=1:length(fnv)
    
    if(fnv(i)<1.0e-06)
        nrb=nrb+1;
    end
    
    if(i>6)
        break;
    end
    
end

clear omn;
omn=tpi*fnv;
omn2=omn.*omn;
%
sz=size(QE);
if(num_columns>sz(2))
    num_columns=sz(2);
end
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

i=dof1;
k=dof2;


  H=zeros(nf,1); 
%   
   progressbar;
%
    for s=1:nf   % excitation frequency loop
%
        progressbar(s/nf);
%
        for r=(1+nrb):num_columns  % natural frequency loop
            if(fnv(r)<1.0e+30)
%
                rho=freq(s)/fnv(r);
                den=1-rho^2+(1i)*2*dampv(r)*rho;
%                
                term=(QE(i,r)*QE(k,r)/den)/omn2(r);
%        
                if(iam==2)
                    term=term*omega(s);                   
                end
                if(iam==3)
                    term=term*omega2(s);                    
                end 
                H(s)=H(s)+term;                
%
            end
        end   
%
    end
    progressbar(1);
    
    HM=abs(H);
    HP=(180/pi)*angle(H);
    
    freq=fix_size(freq);
    ff=freq;
    
    H=fix_size(H);
    HM=fix_size(HM);
    HP=fix_size(HP);

    frf_complex=[freq H];
    frf_mag_phase=[freq HM HP];

    frf_p=HP;
    frf_m=HM;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setappdata(0,'frf_complex',frf_complex);
setappdata(0,'frf_mag_phase',frf_mag_phase);    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fmin=f1;
fmax=f2;
y_label='Magnitude';
md=5;

fig_num=getappdata(0,'fig_num');
if(isempty(fig_num)==1)
    fig_num=1;
end


figure(fig_num);
fig_num=fig_num+1;

[fig_num]=plot_frf_md(fig_num,freq,H,fmin,fmax,t_string,y_label,md);

set(handles.pushbutton_save,'Visible','on');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_output_format,'Value');

if(n==1)
    data=getappdata(0,'frf_complex');
else
    data=getappdata(0,'frf_mag_phase');    
end    
    
output_name=get(handles.edit_array_name,'String');
assignin('base', output_name, data);


msgbox('FRF Saved');


function edit_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_output_format.
function listbox_output_format_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output_format contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output_format


% --- Executes during object creation, after setting all properties.
function listbox_output_format_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_f1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_f1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_f1 as text
%        str2double(get(hObject,'String')) returns contents of edit_f1 as a double


% --- Executes during object creation, after setting all properties.
function edit_f1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_f1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_f2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_f2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_f2 as text
%        str2double(get(hObject,'String')) returns contents of edit_f2 as a double


% --- Executes during object creation, after setting all properties.
function edit_f2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_f2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_df_Callback(hObject, eventdata, handles)
% hObject    handle to edit_df (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_df as text
%        str2double(get(hObject,'String')) returns contents of edit_df as a double


% --- Executes during object creation, after setting all properties.
function edit_df_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_df (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_num_Callback(hObject, eventdata, handles)
% hObject    handle to edit_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_num as text
%        str2double(get(hObject,'String')) returns contents of edit_num as a double


% --- Executes during object creation, after setting all properties.
function edit_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

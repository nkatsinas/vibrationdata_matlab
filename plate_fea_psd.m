function varargout = plate_fea_psd(varargin)
% PLATE_FEA_PSD MATLAB code for plate_fea_psd.fig
%      PLATE_FEA_PSD, by itself, creates a new PLATE_FEA_PSD or raises the existing
%      singleton*.
%
%      H = PLATE_FEA_PSD returns the handle to a new PLATE_FEA_PSD or the handle to
%      the existing singleton*.
%
%      PLATE_FEA_PSD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLATE_FEA_PSD.M with the given input arguments.
%
%      PLATE_FEA_PSD('Property','Value',...) creates a new PLATE_FEA_PSD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plate_fea_psd_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plate_fea_psd_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plate_fea_psd

% Last Modified by GUIDE v2.5 24-Mar-2022 15:19:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plate_fea_psd_OpeningFcn, ...
                   'gui_OutputFcn',  @plate_fea_psd_OutputFcn, ...
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


% --- Executes just before plate_fea_psd is made visible.
function plate_fea_psd_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plate_fea_psd (see VARARGIN)

% Choose default command line output for plate_fea_psd
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

fig_num=300;
setappdata(0,'pfig',fig_num);

set(handles.pushbutton_spectral_moments,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes plate_fea_psd wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plate_fea_psd_OutputFcn(hObject, eventdata, handles) 
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

delete(plate_fea_psd);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


try
     FS=get(handles.edit_input_array,'String');
     THM=evalin('base',FS);   
catch
     warndlg('Input array does not exist.');
     return;
end


nmodes=str2num(get(handles.edit_nmodes,'String'));

num=length(THM(:,1));
 
fmin=THM(1,1);
fmax=THM(num,1);  

fig_num=getappdata(0,'pfig');

node=str2num(get(handles.edit_node,'String'));


damp=getappdata(0,'damp_ratio');

iu=getappdata(0,'iu');


%% fn=getappdata(0,'part_fn');
omega=getappdata(0,'part_omega');
ModeShapes=getappdata(0,'part_ModeShapes');

MST=ModeShapes';

TT=getappdata(0,'TT');

Mwd=getappdata(0,'Mwd');
Mww=getappdata(0,'Mww');

ngw=getappdata(0,'ngw');

TZ_tracking_array=getappdata(0,'TZ_tracking_array');

nem=getappdata(0,'nem');

sz=size(Mww);
nff=sz(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

omegan=omega;
omn2=omegan.^2;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f(1)=fmin;
oct=2^(1/48);

k=2;
while(1)
    f(k)=f(k-1)*oct;
    
    if(f(k)>fmax)
        f(k)=fmax;
        break;
    end
    
    k=k+1;
end

freq=f;

np=length(f);

omega=2*pi*f;
om2=omega.^2;

N=zeros(nff,1);
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[base_psd]=interp_psd_oct(THM(:,1),THM(:,2),freq);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nff=min([nff nmodes]);

y=ones(nem,1);

A=-MST*Mwd*y;
%
acc=zeros(np,1);
rd=zeros(np,1);
%

progressbar;

for k=1:np  % for each excitation frequency
    
    progressbar(k/np);
    
    for i=1:nff  % dof
        N(i)=A(i)/(omn2(i)-om2(k) + (1i)*2*damp(i)*omegan(i)*omega(k));
    end
    
    Ud=zeros(nem,1); 
    for i=1:nem  % convert acceleration input to displacement
        Ud(i)=1/(-om2(k));
    end
%
    Uw=ModeShapes*N;   

    Udw=[Ud; Uw];

    U=TT*Udw;    
    
    nu=length(U);
    
    Ur=zeros(nu,1);
    
    for i=1:nu
       Ur(ngw(i))=U(i);   
    end    
        
    ij=TZ_tracking_array(node);
    acc(k)=om2(k)*abs(Ur(ij));
    
    rd(k)=abs(Ur(ij)-Ud(1));
 
end

progressbar(1);

f=fix_size(f);
acc=fix_size(acc);
rd=fix_size(rd);

ah=[f acc];


if(iu==1)
%    y_label='Trans (in/G)';
    scale=386;
else
%    y_label='Trans (mm/G)';
    scale=9.81*1000;    
end  

rh=[f scale*rd];

ah_power=[f ah(:,2).^2];
rh_power=[f rh(:,2).^2];
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numf=length(f);

accel_psd=zeros(numf,2);
rel_disp_psd=zeros(numf,2);

accel_psd(:,1)=f;
rel_disp_psd(:,1)=f;


for i=1:length(f)
       accel_psd(i,2)=ah_power(i,2)*base_psd(i);
    rel_disp_psd(i,2)=rh_power(i,2)*base_psd(i);
end         

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[s,input_rms] = calculate_PSD_slopes_no(f,base_psd);
[s,accel_rms] = calculate_PSD_slopes_no(f,accel_psd(:,2));
   [s,rd_rms] = calculate_PSD_slopes_no(f,rel_disp_psd(:,2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x_label='Frequency (Hz) ';
y_label_a='Accel (G^2/Hz)';

t_string_a=sprintf('Acceleration PSD  Node %d ',node);


if(iu==1)
    y_label_d='Rel Disp (in^2/Hz)';
    t_string_rd=sprintf('Relative Displacement PSD %6.3g in RMS',rd_rms);
else
    y_label_d='Rel Disp (mm^2/Hz)';
    t_string_rd=sprintf('Relative Displacement PSD %6.3g mm RMS',rd_rms);
end


[fig_num,h2]=plot_PSD_function(fig_num,x_label,y_label_d,t_string_rd,rel_disp_psd,fmin,fmax);

ppp=THM;
qqq=accel_psd;

leg_a=sprintf('Input %6.3g GRMS',input_rms);
leg_b=sprintf('Response %6.3g GRMS',accel_rms);

[fig_num,h2]=plot_PSD_two_h2(fig_num,x_label,y_label_a,t_string_a,ppp,qqq,leg_a,leg_b);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

L=length(base_psd);
power_trans=zeros(L,2);

power_trans(:,1)=f;


for i=1:L
    power_trans(i,2)=accel_psd(i,2)/base_psd(i);
end

md=6;
t_string='Power Transmissibility';
y_label='Trans (G^2/G^2)';
ppp=power_trans;

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


setappdata(0,'power_trans',power_trans);
setappdata(0,'accel_psd',accel_psd);
setappdata(0,'rel_disp_psd',rel_disp_psd);

setappdata(0,'pfig',fig_num);

set(handles.uipanel_save,'Visible','on');


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



function edit_node_Callback(hObject, eventdata, handles)
% hObject    handle to edit_node (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_node as text
%        str2double(get(hObject,'String')) returns contents of edit_node as a double


% --- Executes during object creation, after setting all properties.
function edit_node_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_node (see GCBO)
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

n=get(handles.listbox_type,'Value');

if(n==1)
    data=getappdata(0,'accel_psd');
end
if(n==2)
    data=getappdata(0,'rel_disp_psd');
end
if(n==3)
    data=getappdata(0,'power_trans');
end


output_name=get(handles.edit_output_array_name,'String');
assignin('base', output_name, data);

set(handles.pushbutton_spectral_moments,'Visible','on');

h = msgbox('Save Complete');



function edit_output_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type


% --- Executes during object creation, after setting all properties.
function listbox_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_node and none of its controls.
function edit_node_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_node (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on button press in pushbutton_spectral_moments.
function pushbutton_spectral_moments_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_spectral_moments (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=vibrationdata_spectral_moments;    

set(handles.s,'Visible','on'); 



function edit_nmodes_Callback(hObject, eventdata, handles)
% hObject    handle to edit_nmodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_nmodes as text
%        str2double(get(hObject,'String')) returns contents of edit_nmodes as a double


% --- Executes during object creation, after setting all properties.
function edit_nmodes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_nmodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

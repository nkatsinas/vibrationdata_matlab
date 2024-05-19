function varargout = plate_fea_pressure_psd(varargin)
% PLATE_FEA_PRESSURE_PSD MATLAB code for plate_fea_pressure_psd.fig
%      PLATE_FEA_PRESSURE_PSD, by itself, creates a new PLATE_FEA_PRESSURE_PSD or raises the existing
%      singleton*.
%
%      H = PLATE_FEA_PRESSURE_PSD returns the handle to a new PLATE_FEA_PRESSURE_PSD or the handle to
%      the existing singleton*.
%
%      PLATE_FEA_PRESSURE_PSD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLATE_FEA_PRESSURE_PSD.M with the given input arguments.
%
%      PLATE_FEA_PRESSURE_PSD('Property','Value',...) creates a new PLATE_FEA_PRESSURE_PSD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plate_fea_pressure_psd_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plate_fea_pressure_psd_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plate_fea_pressure_psd

% Last Modified by GUIDE v2.5 12-Dec-2019 16:01:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plate_fea_pressure_psd_OpeningFcn, ...
                   'gui_OutputFcn',  @plate_fea_pressure_psd_OutputFcn, ...
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


% --- Executes just before plate_fea_pressure_psd is made visible.
function plate_fea_pressure_psd_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plate_fea_pressure_psd (see VARARGIN)

% Choose default command line output for plate_fea_pressure_psd
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes plate_fea_pressure_psd wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plate_fea_pressure_psd_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(plate_fea_pressure_psd);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


disp(' ');
disp(' * * * * * * * ');
disp(' ');

FS=get(handles.edit_input_array_name,'String');

try
    THM=evalin('base',FS);  
catch
    warndlg('Input array not found');
    return;
end

fa=THM(:,1);

fmin=fa(1);
fmax=fa(end);

field=get(handles.listbox_field,'Value');

try
    fig_num=getappdata(0,'tfig');
catch
    fig_num=900;
end

if(isempty(fig_num))
    fig_num=900;
end

node=str2num(get(handles.edit_node,'String'));

iu=getappdata(0,'iu');

ndof=getappdata(0,'ndof_constrained');

area=getappdata(0,'area');
mass=getappdata(0,'total_mass');

fn=getappdata(0,'fn');
damp=getappdata(0,'damp_ratio');
QE=getappdata(0,'ModeShapes');

   
num_modes=str2num(get(handles.edit_num_modes,'String'));

if(num_modes>ndof)
    num_modes=ndof;
    ss=sprintf('%d',ndof);
    set(handles.edit_num_modes,'String',ss);
    msgbox('Number of Modes reset');    
end



%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

constraint_matrix=getappdata(0,'constraint_matrix');

node_matrix=getappdata(0,'node_matrix');

szn=size(node_matrix);
NL=szn(1);

sz=size(constraint_matrix);
CL=sz(1);


dof_matrix=zeros(NL,3);


for i=1:CL
    j=constraint_matrix(i,1);
    dof_matrix(j,:)=[ constraint_matrix(i,2) constraint_matrix(i,3) constraint_matrix(i,4)  ];
end


% dof matrix  row index is node.   Three columns for TZ, RX, RY.  1=constrained
% dof_matrix


nzeros=nnz(~dof_matrix);

cr_matrix=zeros(nzeros,2);


k=1;

for i=1:NL
   
    if(dof_matrix(i,1)==0)
        cr_matrix(k,:)=[i 1];
        k=k+1;
    end
    if(dof_matrix(i,2)==0)
        cr_matrix(k,:)=[i 2];
        k=k+1;
    end    
    if(dof_matrix(i,3)==0)
        cr_matrix(k,:)=[i 3];
        k=k+1;
    end    

    
end    

response_dof=0;

for i=1:nzeros
    if(node==cr_matrix(i,1) && cr_matrix(i,2)==1)
        response_dof=i;
    end
end

if(response_dof==0)
   warndlg('Response node not found');
   return;
end

% cr matrix format:  node & free dof
% cr_matrix

out1=sprintf('Response Node at dof = %d ',response_dof);
disp(out1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%

N=24;
%
[freq,omega,np]=frequencies_octave_spaced(fmin,fmax,N);
[fpsd]=interp_psd_oct(THM(:,1),THM(:,2),freq);

numf=np;
nf=np;

fmin=freq(1);
fmax=freq(end);

%%%

if(field==1)
    S=ones(ndof,ndof);
end
if(field==2)
    msgbox('Option to be added in future revision');
    return;
end
if(field==3)
    S=eye(ndof,ndof);
end

%%%

accel_psd=zeros(numf,ndof);   
vel_psd=zeros(numf,ndof);    
disp_psd=zeros(numf,ndof);

H_disp_force_complex=zeros(numf,ndof,ndof);

nrb=0;
num_columns=num_modes;
iam=1;
fnv=fn;
dampv=damp;

omega2=omega.^2;
omegan=2*pi*fn;
omn2=omegan.*omegan;


disp(' ref 0');

progressbar;

for j=1:ndof
    
    progressbar(j/ndof);
    
    for k=1:ndof    
        [aaa]=transfer_core_np(freq,fnv,dampv,QE,omn2,omega,omega2,iam,nf,num_columns,i,k,nrb);
        H_disp_force_complex(:,j,k)=aaa;
    end
end
    
H_disp_force_complex=H_disp_force_complex*area/mass;


QQ=H_disp_force_complex(:,response_dof,response_dof);

x_label='Frequency (Hz)';
y_label=' ';
t_string=' ';

ppp=[freq abs(QQ)];

md=7;

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

return;

progressbar(1);

disp(' ref 1');      

for i=1:numf

    SS=S*fpsd(i);

    H=zeros(ndof,ndof);

    for j=1:ndof
        for k=1:ndof
            H(j,k)=H_disp_force_complex(i,j,k);
        end
    end  
           
    HC=conj(H);    
    d=H*SS*HC';
    
    disp_psd(i,:)=abs(diag(d));
    
    H=H*(1i)*omega(i);
    HC=conj(H);
    v=H*SS*HC';  
    vel_psd(i,:)=abs(diag(v));
    
    H=H*(1i)*omega(i);
    HC=conj(H);
    a=H*SS*HC';  
    accel_psd(i,:)=abs(diag(a));    
    
end

disp(' ref 2');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp_psd

GD=disp_psd(:,response_dof);


[~,rms] = calculate_PSD_slopes(freq,GD);

ppp=[freq GD];

if(iu==1)
    t_string=sprintf('Displacement Response PSD   Node %d \n %7.4g in rms overall',node,rms);
    y_label='Disp (in^2/Hz)';
else
    t_string=sprintf('Displacement Response PSD   Node %d \n %7.4g mm rms overall',node,rms);   
    y_label='Disp (mm^2/Hz)';    
end
   
x_label='Frequency (Hz)';

md=7;

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

disp(' ');
disp(t_string);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ref 3');




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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



n=get(handles.listbox_save,'Value');


if(n==1)
    data=getappdata(0,'displacement_transfer');
end  
if(n==2)
    data=getappdata(0,'displacement_power_transfer');
end
if(n==3)
    data=getappdata(0,'displacement_psd');
end
if(n==4)
    data=getappdata(0,'stress_transfer');
end  
if(n==5)
    data=getappdata(0,'stress_power_transfer');
end


sz=size(data);

if(max(sz)==0)
    h = msgbox('Data size is zero ');    
else
    output_name=get(handles.edit_output_filename,'String');
    assignin('base', output_name,data);
    h = msgbox('Export Complete.  Press Return. ');
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



function edit_input_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_field.
function listbox_field_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_field (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_field contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_field


% --- Executes during object creation, after setting all properties.
function listbox_field_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_field (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_num_modes_Callback(hObject, eventdata, handles)
% hObject    handle to edit_num_modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_num_modes as text
%        str2double(get(hObject,'String')) returns contents of edit_num_modes as a double


% --- Executes during object creation, after setting all properties.
function edit_num_modes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_num_modes (see GCBO)
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

function varargout = transfer_functions_from_modes(varargin)
% TRANSFER_FUNCTIONS_FROM_MODES MATLAB code for transfer_functions_from_modes.fig
%      TRANSFER_FUNCTIONS_FROM_MODES, by itself, creates a new TRANSFER_FUNCTIONS_FROM_MODES or raises the existing
%      singleton*.
%
%      H = TRANSFER_FUNCTIONS_FROM_MODES returns the handle to a new TRANSFER_FUNCTIONS_FROM_MODES or the handle to
%      the existing singleton*.
%
%      TRANSFER_FUNCTIONS_FROM_MODES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRANSFER_FUNCTIONS_FROM_MODES.M with the given input arguments.
%
%      TRANSFER_FUNCTIONS_FROM_MODES('Property','Value',...) creates a new TRANSFER_FUNCTIONS_FROM_MODES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before transfer_functions_from_modes_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to transfer_functions_from_modes_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help transfer_functions_from_modes

% Last Modified by GUIDE v2.5 18-Jun-2016 15:10:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @transfer_functions_from_modes_OpeningFcn, ...
                   'gui_OutputFcn',  @transfer_functions_from_modes_OutputFcn, ...
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


% --- Executes just before transfer_functions_from_modes is made visible.
function transfer_functions_from_modes_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to transfer_functions_from_modes (see VARARGIN)

% Choose default command line output for transfer_functions_from_modes
handles.output = hObject;

listbox_method_Callback(hObject, eventdata, handles);
listbox_damping_Callback(hObject, eventdata, handles);

%% set(handles.listbox_nrb,'Value',1);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes transfer_functions_from_modes wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = transfer_functions_from_modes_OutputFcn(hObject, eventdata, handles) 
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

delete(transfer_functions_from_modes);


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units
listbox_method_Callback(hObject, eventdata, handles);

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


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method

imethod=get(handles.listbox_method,'Value');
iu=get(handles.listbox_units,'Value');

if(imethod==1)
    if(iu==1)
        set(handles.text_box1,'String','Mass Array Name (lbf sec^2/in)');
        set(handles.text_box2,'String','Stiffness Array Name (lbf/in)');
    else
        set(handles.text_box1,'String','Mass Array Name (kg)');
        set(handles.text_box2,'String','Stiffness Array Name (N/m)');        
    end
else
    set(handles.text_box1,'String','Mass-Normalized Eigenvector Array Name');
    set(handles.text_box2,'String','Natural Frequency (Hz) Vector or Array Name');     
end


% --- Executes during object creation, after setting all properties.
function listbox_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_output.
function listbox_output_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output


% --- Executes during object creation, after setting all properties.
function listbox_output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_box1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_box1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_box1 as text
%        str2double(get(hObject,'String')) returns contents of edit_box1 as a double


% --- Executes during object creation, after setting all properties.
function edit_box1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_box1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_box2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_box2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_box2 as text
%        str2double(get(hObject,'String')) returns contents of edit_box2 as a double


% --- Executes during object creation, after setting all properties.
function edit_box2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_box2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_damping.
function listbox_damping_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_damping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_damping contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_damping

n=get(handles.listbox_damping,'Value');

if(n==1)
    set(handles.text_box3,'String','Uniform Damping Ratio');
else
    set(handles.text_box3,'String','Damping Array Name');    
end





function edit_box3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_box3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_box3 as text
%        str2double(get(hObject,'String')) returns contents of edit_box3 as a double


% --- Executes during object creation, after setting all properties.
function edit_box3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_box3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_max_num_Callback(hObject, eventdata, handles)
% hObject    handle to edit_max_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_max_num as text
%        str2double(get(hObject,'String')) returns contents of edit_max_num as a double


% --- Executes during object creation, after setting all properties.
function edit_max_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_max_num (see GCBO)
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



function edit_minf_Callback(hObject, eventdata, handles)
% hObject    handle to edit_minf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_minf as text
%        str2double(get(hObject,'String')) returns contents of edit_minf as a double


% --- Executes during object creation, after setting all properties.
function edit_minf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_minf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_maxf_Callback(hObject, eventdata, handles)
% hObject    handle to edit_maxf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_maxf as text
%        str2double(get(hObject,'String')) returns contents of edit_maxf as a double


% --- Executes during object creation, after setting all properties.
function edit_maxf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_maxf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_nrb.
function listbox_nrb_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_nrb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_nrb contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_nrb


% --- Executes during object creation, after setting all properties.
function listbox_nrb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_nrb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dof1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dof1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dof1 as text
%        str2double(get(hObject,'String')) returns contents of edit_dof1 as a double


% --- Executes during object creation, after setting all properties.
function edit_dof1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dof1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dof2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dof2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dof2 as text
%        str2double(get(hObject,'String')) returns contents of edit_dof2 as a double


% --- Executes during object creation, after setting all properties.
function edit_dof2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dof2 (see GCBO)
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


try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end    



fig_num=1;

tpi=2*pi;

iu=get(handles.listbox_units,'Value');
imethod=get(handles.listbox_method,'Value');
iam=get(handles.listbox_output,'Value');
ndamp=get(handles.listbox_damping,'Value');

try
    FS=get(handles.edit_box1,'String');
    THM1=evalin('base',FS); 
catch
    warndlg('Array not found');
    return;
end
 
try
    FS=get(handles.edit_box2,'String');
    THM2=evalin('base',FS); 
catch
    warndlg('Array not found');    
    return;
end

if(imethod==1)
    mass=THM1;
    stiffness=THM2;
    [fnv,omega,ModeShapes,MST]=Generalized_Eigen(stiffness,mass,1);
    QE=ModeShapes;  
%
else
%    
    QE=THM1;
    fff=THM2;
    sz=size(fff);
    fnv=zeros(sz(1),1);
    if(sz(1)==sz(2))
        for i=1:sz(1)
            fnv(i)=fff(i,i);
        end
    else
        fnv=fff;
    end  
end


num_modes=max(size(fnv));

if(ndamp==1)
    d=str2num(get(handles.edit_box3,'String'));    
    if isempty(d)
        warndlg('Damping value not found');
        return;
    else
        damp=d*ones(num_modes,1);
    end
else
    try
        FS=get(handles.edit_box2,'String');
        damp=evalin('base',FS); 
    catch
        warndlg('Damping vector not found');    
        return;
    end
end    
dampv=damp;

num_damp=max(size(damp));

if(num_damp~=num_modes)
   out1=sprintf('Number of damping values does not equal \n number of natural frequencies. \n num_modes=%d  ndamp=%d',num_modes,ndamp); 
   warndlg(out1); 
   return; 
end

max_num=str2num(get(handles.edit_max_num,'String'));

if (isempty(max_num) || max_num>num_modes)
   max_num=num_modes; 
   ss=sprintf('%d',max_num);
   set(handles.edit_max_num,'String',ss);
end    


df=str2num(get(handles.edit_df,'String'));    
if isempty(df)
    warndlg('Enter Freq Step');
    return;
end

minf=str2num(get(handles.edit_minf,'String'));    
if isempty(minf)
    warndlg('Enter Min Freq');
    return;
end

maxf=str2num(get(handles.edit_maxf,'String'));    
if isempty(maxf)
    warndlg('Enter Max Freq');
    return;
end

nf=floor((maxf-minf)/df);

%%%%%%%

%%% nrb=-1+get(handles.listbox_nrb,'Value');

nrb=0;  % leave zero

if(nrb>=num_modes)
   warndlg('number of rigid body modes >= num_modes'); 
   return; 
end

%%%%%%%

freq=zeros(nf,1);
omega=zeros(nf,1);
omega2=zeros(nf,1);

for i=1:nf
    freq(i)=(i-1)*df+minf;
    omega(i)=2*pi*freq(i);
    omega2(i)=(omega(i))^2;
end
%
clear omn;
omn=tpi*fnv;
omn2=omn.*omn;
%
sz=size(QE);
num_dof=sz(1);
num_columns=sz(2);

%
%%%%%%%

response_dof=str2num(get(handles.edit_dof1,'String'));

if isempty(response_dof)
   warndlg('Enter response dof'); 
   return; 
end

if(response_dof>num_dof)
    out1=sprintf('Error: response_dof=%d  num_dof=%d',response_dof,num_dof);
    warndlg(out1);
    return;
end

%%%%%%%
    
excitation_dof=str2num(get(handles.edit_dof2,'String'));
 
if isempty(excitation_dof)
   warndlg('Enter excitation dof'); 
   return; 
end
 
if(excitation_dof>num_dof)
    out1=sprintf('Error: excitation_dof=%d  num_dof=%d',excitation_dof,num_dof);
    warndlg(out1);
    return;
end

%%%%%%%
    
i=response_dof;
k=excitation_dof;

[H_response_force]=...
transfer_core_n(freq,fnv,dampv,QE,omn2,omega,omega2,iam,nf,num_columns,i,k,nrb,max_num);
%
if(iam ~=7)
    H=H_response_force;
else
    [H_base_force]=...
    transfer_core_n(freq,fnv,dampv,QE,omn2,omega,omega2,iam,nf,num_columns,k,k,nrb,max_num);
%
    H=zeros(nf,1);
    for s=1:nf % frequency loop  
        H(s)=H_response_force(s)/H_base_force(s);
    end
%
end

%%%%%%%

H=-H;

HM=abs(H);
HP=angle(H)*180/pi;

%
if(iam==3 && iu==1)
    H=H/386;
    HM=HM/386;
end
%
clear PPP;
PPP=zeros(nf,1);
PHA=zeros(nf,1);

%    
for ia=1:nf
    PPP(ia)=HM(ia);
    PHA(ia)=HP(ia);
%
    if(PHA(ia)<-180)
        PHA(ia)=PHA(ia)+360.;
    end
    if(PHA(ia)>180)
        PHA(ia)=PHA(ia)-360.;
    end    
%
end  

%
freq=fix_size(freq);
H=fix_size(H);
HM=fix_size(HM);
PPP=fix_size(PPP);       
PHA=fix_size(PHA);
AAA=angle(H);
%
[varname1,varname2,varname3]=transfer_from_modes_H_files_alt(iam,i,k,freq,H,HM);
% 

disp(' ');
disp(' Matlab array names ');

    disp(' ');
    eval([varname1 ' = [freq H];']);    % need to do in main script
    out1=sprintf('           Complex:  %s ',varname1);
    disp(out1);
    assignin('base',varname1,[freq H]);
%
    eval([varname2 ' = [freq PPP];']);
    out1=sprintf('         Magnitude:  %s ',varname2);
    disp(out1);
    assignin('base',varname2,[freq PPP]);    
%
    eval([varname3 ' = [freq PPP AAA];']);
    out1=sprintf(' Magnitude & phase:  %s ',varname3);
    disp(out1);   
    assignin('base',varname3,[freq PPP AAA]);    
%

[fig_num]=...
transfer_from_modes_plots_alt2(iu,iam,i,k,fig_num,minf,maxf,H,freq,PPP,PHA);    
%


% --- Executes during object creation, after setting all properties.
function listbox_damping_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_damping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

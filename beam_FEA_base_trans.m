function varargout = beam_FEA_base_trans(varargin)
% BEAM_FEA_BASE_TRANS MATLAB code for beam_FEA_base_trans.fig
%      BEAM_FEA_BASE_TRANS, by itself, creates a new BEAM_FEA_BASE_TRANS or raises the existing
%      singleton*.
%
%      H = BEAM_FEA_BASE_TRANS returns the handle to a new BEAM_FEA_BASE_TRANS or the handle to
%      the existing singleton*.
%
%      BEAM_FEA_BASE_TRANS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BEAM_FEA_BASE_TRANS.M with the given input arguments.
%
%      BEAM_FEA_BASE_TRANS('Property','Value',...) creates a new BEAM_FEA_BASE_TRANS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before beam_FEA_base_trans_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to beam_FEA_base_trans_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help beam_FEA_base_trans

% Last Modified by GUIDE v2.5 04-Mar-2017 10:02:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @beam_FEA_base_trans_OpeningFcn, ...
                   'gui_OutputFcn',  @beam_FEA_base_trans_OutputFcn, ...
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


% --- Executes just before beam_FEA_base_trans is made visible.
function beam_FEA_base_trans_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to beam_FEA_base_trans (see VARARGIN)

% Choose default command line output for beam_FEA_base_trans
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

disp(' ');
disp(' * * * * * * * * * * * * ');
disp(' ');

BC=getappdata(0,'BC');

if(BC==1)
    disp(' Fixed-Free Beam');
end
if(BC==2)
    disp(' Pinned-Pinned Beam');    
end
if(BC==3)
    disp(' Fixed-Fixed Beam');    
end
disp(' ');


if(BC==1)
    string_th{1}=sprintf('Acceleration Transmissibilty at Free End');
    string_th{2}=sprintf('Relative Transmissibility at Free End');
    string_th{3}=sprintf('Bending Stress at Fixed End');    
    m=3;
   
end
if(BC==2)
    string_th{1}=sprintf('Acceleration Transmissibilty at Midspan');
    string_th{2}=sprintf('Relative Transmissibility at Midspan');
    string_th{3}=sprintf('Bending Stress at Midspan');        
    m=3;     
end
if(BC==3)
    string_th{1}=sprintf('Acceleration Transmissibilty at Midspan');
    string_th{2}=sprintf('Relative Transmissibility at Midspan');    
    string_th{3}=sprintf('Bending Stress at Fixed End');    
    m=3;     
end

set(handles.listbox_amplitude_type, 'Value', m);   % do not change
set(handles.listbox_amplitude_type,'Value',1);
set(handles.listbox_amplitude_type,'String',string_th)


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes beam_FEA_base_trans wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = beam_FEA_base_trans_OutputFcn(hObject, eventdata, handles) 
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

delete(beam_FEA_base_trans);


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



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

na=get(handles.listbox_amplitude_type,'Value');

if(na==1)
    data=getappdata(0,'H_atrans');
end
if(na==2)
    data=getappdata(0,'H_rd_trans');
end
if(na==3)
    data=getappdata(0,'H_strans');    
end


output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);
 
msgbox('Data saved');


% --- Executes on selection change in listbox_amplitude_type.
function listbox_amplitude_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_amplitude_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_amplitude_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_amplitude_type


% --- Executes during object creation, after setting all properties.
function listbox_amplitude_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_amplitude_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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


% --- Executes on selection change in listbox_format.
function listbox_format_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_format contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_format


% --- Executes during object creation, after setting all properties.
function listbox_format_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fstart_edit_Callback(hObject, eventdata, handles)
% hObject    handle to fstart_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fstart_edit as text
%        str2double(get(hObject,'String')) returns contents of fstart_edit as a double


% --- Executes during object creation, after setting all properties.
function fstart_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fstart_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fend_edit_Callback(hObject, eventdata, handles)
% hObject    handle to fend_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fend_edit as text
%        str2double(get(hObject,'String')) returns contents of fend_edit as a double


% --- Executes during object creation, after setting all properties.
function fend_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fend_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_number_modes.
function listbox_number_modes_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_number_modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_number_modes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_number_modes
set(handles.uipanel_save,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_number_modes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_number_modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_force_location.
function listbox_force_location_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_force_location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_force_location contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_force_location
set(handles.uipanel_save,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_force_location_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_force_location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_response_location.
function listbox_response_location_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_response_location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_response_location contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_response_location
set(handles.uipanel_save,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_response_location_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_response_location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on fstart_edit and none of its controls.
function fstart_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to fstart_edit (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on fend_edit and none of its controls.
function fend_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to fend_edit (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');



% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


tpi=2*pi;

fmin=str2num(get(handles.fstart_edit,'String'));
fmax=str2num(get(handles.fend_edit,'String'));
  
    if(fmin<=0.01)
        fmin=0.01;
    end    
    
    
     stiff=getappdata(0,'stiff_unc');
      mass=getappdata(0,'mass_unc');    
  

 ModeShapes=getappdata(0,'ModeShapes_full');
        iu=getappdata(0,'unit');
        
        
fn=getappdata(0,'fn');  
if(isempty(fn))  
    warndlg('fn not found.  Run beam_beam_excitation_FEA');
    return;
end           
        
damp=getappdata(0,'damp_ratio');  
if(isempty(damp))  
    warndlg('damp not found.  Run damping');
    return;
end        
      
E=getappdata(0,'E');  
if(isempty(E))  
    warndlg('E not found.  Run beam_beam_excitation_FEA');
    return;
end
 
cna=getappdata(0,'cna');        
if(isempty(cna))  
    warndlg('cna not found.  Run beam_beam_excitation_FEA');
    return;
end        
         
         

fig_num=getappdata(0,'fig_num');
if( isempty(fig_num))
    fig_num=1;
end        


%
N=48;
%
[freq,omega,np]=frequencies_octave_spaced(fmin,fmax,N);


om2=omega.^2;

%
QE=ModeShapes;
fnv=fn;
num_modes=length(fnv);
%
fn(1);
%
out1=sprintf('\n number of modes =%d \n',num_modes);
disp(out1);
%

%
nrb=0;
for i=1:num_modes
    if(fn(i)<0.001)
        nrb=nrb+1;
    end
end
%
if(nrb>=1)
    disp(' ');
    out1=sprintf(' %d Rigid-body modes detected. \n\n Rigid-body modes will be suppressed.',nrb);
    disp(out1);
end
%
num_columns=get(handles.listbox_number_modes,'Value');

%
sz=size(QE);
if(num_columns>sz(2))
    num_columns=sz(2);
end

if(num_columns> length(fn))
    num_columns=length(fn);
end

%

BC=getappdata(0,'BC');


[mass,stiff,nem,num,nff,ea,ngw,dof,mid_dof]=beam_partition(BC,mass,stiff);

dtype=2;

if(num<5)
    dtype=1;
end


etype=1;  % enforced acceleration
[TT,T1,T2,Mwd,Mww,Kwd,Kww]=enforced_partition_matrices(num,ea,mass,stiff,etype,dtype);
%

[fn,omegan,omn2,ModeShapes,MST,part]=enforced_acceleration_eigenvalues(Kww,Mww,num,nff);


%

N=zeros(nff,np);
%

adisp=zeros(np,num);
acc=zeros(np,num);
rel_disp=zeros(np,num);


out1=sprintf('\n nem=%d  length(damp)=%d \n',nem,length(damp));
disp(out1);


y=ones(nem,1);


%%%%%%%%%%
%
%    
    A=-MST*Mwd*y;
    
    nk=min([ length(A) length(damp) num_columns]);
%
    for i=1:nk  % number of included modes
        for k=1:np
            N(i,k)=A(i)/(omn2(i)-om2(k) + (1i)*2*damp(i)*omegan(i)*omega(k));
        end
    end
%
    Ud=zeros(nem,np); 
    for i=1:np  % convert acceleration input to displacement
        Ud(:,i)=1/(-om2(i));
    end
%
    disp('ModeShapes');
    size(ModeShapes);
    
    Uw=ModeShapes*N;
%
    Udw=[Ud; Uw];
%
    U=TT*Udw;
%
%   Fix order
%
    for i=1:num
        for j=1:np
            adisp(j,ngw(i))=U(i,j);
            acc(j,ngw(i))=om2(j)*abs(U(i,j));
            rel_disp(j,ngw(i))=U(i,j)-Ud(1,j);
        end        
    end
%
%
%%%%%%%%%%%%%


HM_accel_left=zeros(np,1);
HM_accel_mid=zeros(np,1);
HM_accel_right=zeros(np,1);

HM_rd_left=zeros(np,1);
HM_rd_mid=zeros(np,1);
HM_rd_right=zeros(np,1);

mid_dof=7

for j=1:np
    
    HM_accel_left(j) =acc(j,1);
    HM_accel_mid(j)  =acc(j,mid_dof);   
    HM_accel_right(j)=acc(j,(dof-1));   
    
    HM_rd_left(j)    =rel_disp(j,1);
    HM_rd_mid(j)     =rel_disp(j,mid_dof);   
    HM_rd_right(j)   =rel_disp(j,(dof-1));    

end


dx=getappdata(0,'deltax');

L=dx;

out1=sprintf('\n dx=%8.4g  cna=%8.4g  dof=%d\n',dx,cna,dof);
disp(out1);


if(iu==1)
        y_label_st='Stress/Accel (psi/G)';
else
        y_label_st='Stress/Accel (Pa/G)';    
end

if(iu==1)
        y_label_rd='(Rel Disp)/Accel (in/G)';
else
        y_label_rd='(Rel Disp)/Accel (m/G)';    
end
    
x_label='Frequency (Hz)';
y_label_ar='Accel Ratio (G/G)';

fmin=min(freq);
fmax=max(freq);


%
%  http://home.sogang.ac.kr/sites/cmlab/Coursework/course001/Lists/b141/Attachments/1/Ch.02%20(pp.%2017-40)%20Bars%20and%20Beams.%20Linear%20Static%20Analysis.pdf
%

if(iu==1)
   rs=386; 
else
   rs=9.81; 
end

HM_rd_left =abs(HM_rd_left*rs);
HM_rd_mid  =abs(HM_rd_mid*rs);
HM_rd_right=abs(HM_rd_right*rs);

HM_stress_left=zeros(np,1);
HM_stress_mid=zeros(np,1);
HM_stress_right=zeros(np,1);

md=4;

if(BC==1)
    t_string_at='Accleration Transmissibility at Free End';    
    t_string_rt='Relative Displacement Transmissibility at Free End Rel to Base';
    t_string_st='Stress Transmissibility at Fixed End';    
end
if(BC==2)
    t_string_at='Accleration Transmissibility at Midspan';
    t_string_rt='Relative Displacement Transmissibility at Midspan Rel to Base';    
    t_string_st='Stress Transmissibility at Midspan';      
end
if(BC==3)
    t_string_at='Accleration Transmissibility at Midspan';
    t_string_rt='Relative Displacement Transmissibility at Midspan'; 
    t_string_st='Stress Transmissibility at Left Fixed End Relative to Base';      
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(BC==1 || BC==3)     

     x=0;
    [B]=beam_stress_B(x,L)

    for j=1:np

        Y=zeros(dof+1,1);

        Y(1)=(adisp(j,1));

        Y(3:(dof+1))=(adisp(j,2:dof));
    
        fprintf(' %7.3g %7.3g %7.3g %7.3g \n',abs(Y(1)),abs(Y(2)),abs(Y(3)),abs(Y(4)))

        d=[Y(1)  Y(2) Y(3) Y(4) ]';
 
        HM_stress_left(j)=rs*abs(cna*E*B*d);
    
    end
    
end 

if(BC==2)
    
    x=L;
    [B]=beam_stress_B(x,L);
    
    L1=mid_dof-2;
    L2=mid_dof-1;    
    L3=mid_dof;
    L4=mid_dof+1; 
    

    for j=1:np
        
        Y(1)=(adisp(j,L1));
        Y(2)=(adisp(j,L2));
        Y(3)=(adisp(j,L3));
        Y(4)=(adisp(j,L4));
    
        d=[Y(1)  Y(2) Y(3) Y(4) ]';
 
        HM_stress_mid(j)=rs*abs(cna*E*B*d);
    
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(BC==1)
    ppp_atrans=[freq HM_accel_right];
    ppp_rdtrans=[freq HM_rd_right];
    ppp_strans=[freq HM_stress_left];     
end
if(BC==2)
    ppp_atrans=[freq HM_accel_mid];
    ppp_rdtrans=[freq HM_rd_mid];
    ppp_strans=[freq HM_stress_mid];   
end
if(BC==3)
    ppp_atrans=[freq HM_accel_mid];
    ppp_rdtrans=[freq HM_rd_mid];
    ppp_strans=[freq HM_stress_left]; 
end

[fig_num,h2]=...
    plot_loglog_function_md_h2(fig_num,x_label,y_label_ar,t_string_at,ppp_atrans,fmin,fmax,md);    
    
[fig_num,h2]=...
    plot_loglog_function_md_h2(fig_num,x_label,y_label_rd,t_string_rt,ppp_rdtrans,fmin,fmax,md);        

[fig_num,h2]=...
    plot_loglog_function_md_h2(fig_num,x_label,y_label_st,t_string_st,ppp_strans,fmin,fmax,md);    

    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setappdata(0,'H_atrans',ppp_atrans);
setappdata(0,'H_rd_trans',ppp_rdtrans);
setappdata(0,'H_strans',ppp_strans);

set(handles.uipanel_save,'Visible','on');

function varargout = beam_FEA_base_arbitrary(varargin)
% BEAM_FEA_BASE_ARBITRARY MATLAB code for beam_FEA_base_arbitrary.fig
%      BEAM_FEA_BASE_ARBITRARY, by itself, creates a new BEAM_FEA_BASE_ARBITRARY or raises the existing
%      singleton*.
%
%      H = BEAM_FEA_BASE_ARBITRARY returns the handle to a new BEAM_FEA_BASE_ARBITRARY or the handle to
%      the existing singleton*.
%
%      BEAM_FEA_BASE_ARBITRARY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BEAM_FEA_BASE_ARBITRARY.M with the given input arguments.
%
%      BEAM_FEA_BASE_ARBITRARY('Property','Value',...) creates a new BEAM_FEA_BASE_ARBITRARY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before beam_FEA_base_arbitrary_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to beam_FEA_base_arbitrary_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help beam_FEA_base_arbitrary

% Last Modified by GUIDE v2.5 18-Feb-2017 19:52:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @beam_FEA_base_arbitrary_OpeningFcn, ...
                   'gui_OutputFcn',  @beam_FEA_base_arbitrary_OutputFcn, ...
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


% --- Executes just before beam_FEA_base_arbitrary is made visible.
function beam_FEA_base_arbitrary_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to beam_FEA_base_arbitrary (see VARARGIN)

% Choose default command line output for beam_FEA_base_arbitrary
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

BC=getappdata(0,'BC');


if(BC==1)
    string_th{1}=sprintf('Absolute Acceleration at Free End');
    string_th{2}=sprintf('Relative Displacement at Free End');
    string_th{3}=sprintf('Bending Stress at Fixed End');  
    m=3;
   
end
if(BC>=2)
    string_th{1}=sprintf('Absolute Acceleration at Center');
    string_th{2}=sprintf('Relative Displacement at Center');
    m=2;     
end
if(BC==1)
    string_th{3}=sprintf('Bending Stress at Left Fixed End');  
    m=3;
end


set(handles.listbox_amplitude_type,'Value', m);   % do not change
set(handles.listbox_amplitude_type,'Value',1);
set(handles.listbox_amplitude_type,'String',string_th)





% Update handles structure
guidata(hObject, handles);

% UIWAIT makes beam_FEA_base_arbitrary wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = beam_FEA_base_arbitrary_OutputFcn(hObject, eventdata, handles) 
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

delete(beam_FEA_base_arbitrary);


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


tpi=2*pi;

try
    FS=get(handles.input_edit,'String');
    THM=evalin('base',FS);
catch
    warndlg(' Input array not found.');
    return; 
end    
    
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    acc_trans
%
  

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

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
          
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

NT=length(THM(:,1));
nt=NT;


EA=THM;

dur=EA(NT,1)-EA(1,1);

dt=dur/(NT-1);

sr=1/dt;

out1=sprintf(' NT=%d  dur=%8.4g sec  dt=%8.4g sec',NT,dur,dt);
disp(out1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

omegan=tpi*fn;
         
        
fig_num=getappdata(0,'fig_num');
if( isempty(fig_num))
    fig_num=1;
end        


%
QE=ModeShapes;
fnv=fn;
mfnv=length(fnv);
%

mbox=get(handles.listbox_number_modes,'Value');

num_modes=min([mfnv mbox]);

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sz=size(QE);
if(num_columns>sz(2))
    num_columns=sz(2);
end

if(num_columns> length(fn))
    num_columns=length(fn);
end

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[mass,stiff,nem,num,nff,ea,ngw,dof,mid_dof]=beam_partition(BC,mass,stiff);

dtype=2;

if(num<5)
    dtype=1;
end

etype=1;  % enforced acceleration
[TT,T1,T2,Mwd,Mww,Kwd,Kww]=enforced_partition_matrices(num,ea,mass,stiff,etype,dtype);
%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' Integrating acceleration ');

ndof=dof;

f=THM(:,2);

if(iu==1)
   f=f*386; 
else
   f=f*9.81; 
end    

if(BC==1)
    fin=f;
else
    fin=[ f f]; 
end
    
[dvelox]=integrate_function(f,dt);
 [ddisp]=integrate_function(dvelox,dt);

%
%  Modal Transient
%
clear omegad;
omegad=zeros(nff,1);


for i=1:length(damp)
    omegad(i)=omegan(i)*sqrt(1-damp(i)^2);
end



if(num_modes==0)
   out1=sprintf(' Increase input data sample rate >= %8.3g',10*fn(1));
   warndlg(out1); 
   return; 
end


noo=num_modes;

for i=1:noo
    
    if(sr<10*fn(i))
       num_modes=i-1;
       out1=sprintf('\n Number of included modes = %d due to input data sample rate limitation. ',num_modes);   
       disp(out1);        
       break; 
    end
    
end


disp(' ');
out1=sprintf(' sample rate = %8.4g samples/sec ',sr);
disp(out1);

disp(' ');
disp('  n     fn(Hz)   damp ratio');

for i=1:num_modes 
   out1=sprintf(' %d.  %8.3g  %6.3g ',i,fn(i),damp(i)); 
   disp(out1); 
end


Q=ModeShapes(:,1:num_modes);
QT=Q';



ff=zeros(nem,1);

QTMwd=QT*Mwd;

for i=1:length(f)
    ff(1:nem,i)=f(i);
end

disp(' ');
disp(' Calculating FP ');

FP=-QTMwd*ff;

disp(' Completed FP ')    

out1=sprintf('\n num_modes=%d \n',num_modes);
disp(out1);

%
[a1,a2,df1,df2,df3,~,~,~,af1,af2,af3]=...
              ramp_invariant_filter_coefficients(num_modes,omegan,damp,dt);
          
          
nx=zeros(nt,num_modes);
na=zeros(nt,num_modes);

for j=1:num_modes
%
    amodal=FP(j,:);
%
%  displacement
%
    d_forward=[   df1(j),  df2(j), df3(j) ];
    d_back   =[     1, -a1(j), -a2(j) ];
    d_resp=filter(d_forward,d_back,amodal);
%       
%  acceleration
%   
    a_forward=[   af1(j),  af2(j), af3(j) ];
    a_back   =[     1, -a1(j), -a2(j) ]; 
    a_resp=filter(a_forward,a_back,amodal);
%
    nx(:,j)=d_resp;  % displacement
    na(:,j)=a_resp;  % acceleration  
%
end
%
clear amodal;
clear FP;
clear d_resp;
clear a_resp;
%

disp(' Calculate a');

d=zeros((ndof-nem),nt);
d(:,:)=(Q*(nx(:,:))');
clear nx;

disp(' Calculate d');
a=zeros((ndof-nem),nt);
a(:,:)=(Q*(na(:,:))'); 
clear na;


%%%%


d=d';
a=a';

fin=fix_size(fin);

disp(' Transformation a  ');

Adw=[fin a];

sz=size(Adw);
mqq=sz(2);

A=zeros(nt,mqq);
D=zeros(nt,mqq);


A(:,:)=(TT*Adw(:,:)')';
clear Adw;

disp(' Transformation d ');

if(BC==1)
    Ddw=[ddisp d];
else
    Ddw=[ddisp ddisp d];    
end    

D(:,:)=(TT*Ddw(:,:)')';
clear Ddw;
%


acc=zeros(nt,mqq);
ddd=zeros(nt,mqq);

disp(' Sort  A'); 
acc(:,ngw(:))=A(:,:);
clear A;

disp(' Sort  D'); 
ddd(:,ngw(:))=D(:,:);
clear D;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' Generate complete vectors ');

zz=zeros(nt,1);

sz=size(acc);
nmn=sz(2);

acc=[ acc(:,1) zz acc(:,2:nmn)];
ddd=[ ddisp zz ddd(:,2:nmn)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' Integration ');

dx=getappdata(0,'deltax');

nde=get(handles.listbox_detrend,'Value');

if(BC==1)
   [accel,rel_disp,stress,fig_num]=...
       beam_FEA_base_arbitrary_BC1(ndof,acc,ddd,dt,fn,iu,nde,dx,nt,tpi,cna,E,fig_num,THM);
end
if(BC==2)
   [accel,rel_disp,stress,fig_num]=...
       beam_FEA_base_arbitrary_BC2(ndof,acc,ddd,dt,fn,iu,nde,dx,nt,tpi,cna,E,fig_num,THM,mid_dof);
end
if(BC==3)
   [accel,rel_disp,stress,fig_num]=...
       beam_FEA_base_arbitrary_BC3(ndof,acc,ddd,dt,fn,iu,nde,dx,nt,tpi,cna,E,fig_num,THM);
end


setappdata(0,'accel',accel);
setappdata(0,'rel_disp',rel_disp);
setappdata(0,'stress',stress);

set(handles.uipanel_save,'Visible','on');




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
    data=getappdata(0,'accel');
end
if(na==2)
    data=getappdata(0,'rel_disp');
end
if(na==3)
    data=getappdata(0,'stress');
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



function input_edit_Callback(hObject, eventdata, handles)
% hObject    handle to input_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_edit as text
%        str2double(get(hObject,'String')) returns contents of input_edit as a double


% --- Executes during object creation, after setting all properties.
function input_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_detrend.
function listbox_detrend_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_detrend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_detrend contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_detrend


% --- Executes during object creation, after setting all properties.
function listbox_detrend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_detrend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

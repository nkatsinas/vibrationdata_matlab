function varargout = three_dof_transmissibility(varargin)
% THREE_DOF_TRANSMISSIBILITY MATLAB code for three_dof_transmissibility.fig
%      THREE_DOF_TRANSMISSIBILITY, by itself, creates a new THREE_DOF_TRANSMISSIBILITY or raises the existing
%      singleton*.
%
%      H = THREE_DOF_TRANSMISSIBILITY returns the handle to a new THREE_DOF_TRANSMISSIBILITY or the handle to
%      the existing singleton*.
%
%      THREE_DOF_TRANSMISSIBILITY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in THREE_DOF_TRANSMISSIBILITY.M with the given input arguments.
%
%      THREE_DOF_TRANSMISSIBILITY('Property','Value',...) creates a new THREE_DOF_TRANSMISSIBILITY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before three_dof_transmissibility_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to three_dof_transmissibility_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help three_dof_transmissibility

% Last Modified by GUIDE v2.5 03-Jan-2017 11:42:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @three_dof_transmissibility_OpeningFcn, ...
                   'gui_OutputFcn',  @three_dof_transmissibility_OutputFcn, ...
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


% --- Executes just before three_dof_transmissibility is made visible.
function three_dof_transmissibility_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to three_dof_transmissibility (see VARARGIN)

% Choose default command line output for three_dof_transmissibility
handles.output = hObject;


set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes three_dof_transmissibility wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = three_dof_transmissibility_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in calculate_pushbutton.
function calculate_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to calculate_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


tpi=2*pi;

fig_num=1;

      damp=getappdata(0,'damp_ratio');
ModeShapes=getappdata(0,'ModeShapes');
        fn=getappdata(0,'fn');
      unit=getappdata(0,'unit');
        m2=getappdata(0,'m2'); 

fmin=str2num(get(handles.fstart_edit,'String'));
  fmax=str2num(get(handles.fend_edit,'String'));
  
    if(fmin<=0.01)
        fmin=0.01;
    end    
        
        
iu=unit;        
ndamp=length(fn);

iam=7;

QE=ModeShapes;
fff=fn;

fnv=fix_size(fff);


num_modes=max(size(fnv));

% sz=size(QE);
% num_dof=sz(1);
% num_columns=sz(2);
  
dampv=damp;

num_damp=max(size(damp));

if(num_damp~=num_modes)
   out1=sprintf('Number of damping values does not equal \n number of natural frequencies. \n num_modes=%d  ndamp=%d',num_modes,ndamp); 
   warndlg(out1); 
   return; 
end

max_num=num_modes;

if (isempty(max_num) || max_num>num_modes)
   max_num=num_modes; 
   ss=sprintf('%d',max_num);
   set(handles.edit_max_num,'String',ss);
end    

%%%%%%%

N=48;
%
[freq,omega,np]=frequencies_octave_spaced(fmin,fmax,N);
%

nf=np;

%%%%%%%

nrb=0;  % leave as is, need to include rigid body mode

%%%%%%%

omega2=zeros(nf,1);

for i=1:nf
    omega2(i)=(omega(i))^2;
end
%
clear omn;
omn=tpi*fnv;
omn2=omn.*omn;
%
sz=size(QE);
% num_dof=sz(1);
num_columns=sz(2);

%
%%%%%%%

excitation_dof=1;


for ijk=1:3
    

    response_dof=ijk;

    i=response_dof;
    k=excitation_dof;

    [H_response_force]=...
    transfer_core(freq,fnv,dampv,QE,omn2,omega,omega2,iam,nf,num_columns,i,k,nrb);


%
    if(iam ~=7)
        H=H_response_force;
    else
        [H_base_force]=...
        transfer_core(freq,fnv,dampv,QE,omn2,omega,omega2,iam,nf,num_columns,k,k,nrb);
%
        H=zeros(nf,1);
        for s=1:nf % frequency loop  
            H(s)=H_response_force(s)/H_base_force(s);
            
        end
%
    end
 

%%%%%%%

    HM=abs(H);
    HP=(-atan2(imag(H),real(H))*180)/pi;
    HP=HP+180;
%
%
    if(iam==3 && iu==1)
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
%
    end  
%
%%    ymax=max(PPP);
%%    ymin=min(PPP);
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
    eval([varname1 ' = [freq H];']);    % need to do in main script
    eval([varname2 ' = [freq PPP];']);
    eval([varname3 ' = [freq PPP AAA];']); 
%

end


x_label='Frequency (Hz)';
y_label='Accel Ratio (G/G)';
t_string='Transfer Function Magnitude';
md=4;

ppp1=HM_acc_acc_2_1;
ppp2=HM_acc_acc_3_1;

leg1='Mass 1 / Base Mass';
leg2='Mass 2 / Base Mass';


[fig_num,~]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);


setappdata(0,'HM_acc_acc_2_1',HM_acc_acc_2_1);   
setappdata(0,'HM_acc_acc_3_1',HM_acc_acc_3_1);   



y_label='Accel Ratio (G^2/G^2)';
t_string='Power Transmissibility';
md=5;


power_acc_acc_2_1=HM_acc_acc_2_1;
power_acc_acc_3_1=HM_acc_acc_3_1;

for i=1:nf
    
    power_acc_acc_2_1(i,2)=HM_acc_acc_2_1(i,2)^2;
    power_acc_acc_3_1(i,2)=HM_acc_acc_3_1(i,2)^2;    
    
end

pw1=power_acc_acc_2_1;
pw2=power_acc_acc_3_1;


[fig_num,~]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,pw1,pw2,leg1,leg2,fmin,fmax,md);


setappdata(0,'HM_acc_acc_2_1',HM_acc_acc_2_1);   
setappdata(0,'HM_acc_acc_3_1',HM_acc_acc_3_1);  

setappdata(0,'power_acc_acc_2_1',power_acc_acc_2_1);   
setappdata(0,'power_acc_acc_3_1',power_acc_acc_3_1); 


set(handles.uipanel_save,'Visible','on');

msgbox('Calculation complete.  See External Plots.  ');



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


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(three_dof_transmissibility);


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_save,'Value');

m=get(handles.listbox_trans_type,'Value');
 

if(m==1) % (G/G)
    
    if(n==1)
        data=getappdata(0,'HM_acc_acc_2_1');   
    else
        data=getappdata(0,'HM_acc_acc_3_1');          
    end
    
else     % (G^2/G^2);
    
    if(n==1)
        data=getappdata(0,'power_acc_acc_2_1');      
    else
        data=getappdata(0,'power_acc_acc_3_1');         
    end
        
end
    
    
output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);
 
msgbox('Data saved');


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


% --- Executes on selection change in listbox_trans_type.
function listbox_trans_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_trans_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_trans_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_trans_type


% --- Executes during object creation, after setting all properties.
function listbox_trans_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_trans_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

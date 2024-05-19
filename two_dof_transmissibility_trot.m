function varargout = two_dof_transmissibility_trot(varargin)
% TWO_DOF_TRANSMISSIBILITY_TROT MATLAB code for two_dof_transmissibility_trot.fig
%      TWO_DOF_TRANSMISSIBILITY_TROT, by itself, creates a new TWO_DOF_TRANSMISSIBILITY_TROT or raises the existing
%      singleton*.
%
%      H = TWO_DOF_TRANSMISSIBILITY_TROT returns the handle to a new TWO_DOF_TRANSMISSIBILITY_TROT or the handle to
%      the existing singleton*.
%
%      TWO_DOF_TRANSMISSIBILITY_TROT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TWO_DOF_TRANSMISSIBILITY_TROT.M with the given input arguments.
%
%      TWO_DOF_TRANSMISSIBILITY_TROT('Property','Value',...) creates a new TWO_DOF_TRANSMISSIBILITY_TROT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before two_dof_transmissibility_trot_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to two_dof_transmissibility_trot_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help two_dof_transmissibility_trot

% Last Modified by GUIDE v2.5 12-Feb-2015 18:59:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @two_dof_transmissibility_trot_OpeningFcn, ...
                   'gui_OutputFcn',  @two_dof_transmissibility_trot_OutputFcn, ...
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


% --- Executes just before two_dof_transmissibility_trot is made visible.
function two_dof_transmissibility_trot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to two_dof_transmissibility_trot (see VARARGIN)

% Choose default command line output for two_dof_transmissibility_trot
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');
set(handles.listbox_export_plots,'Value',2);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes two_dof_transmissibility_trot wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = two_dof_transmissibility_trot_OutputFcn(hObject, eventdata, handles) 
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

fmin=str2num(get(handles.fstart_edit,'String'));
  fmax=str2num(get(handles.fend_edit,'String'));
  
    if(fmin<=0.01)
        fmin=0.01;
    end    

   fig_num=getappdata(0,'fig_num');
      damp=getappdata(0,'damping');
ModeShapes=getappdata(0,'ModeShapes');
        fn=getappdata(0,'fn');
      unit=getappdata(0,'unit');
        m2=getappdata(0,'m2');     
        k2=getappdata(0,'k2');    
        mass=getappdata(0,'mass');     
        stiff=getappdata(0,'stiff');          
        
        L1=getappdata(0,'L1');     
        L2=getappdata(0,'L2');         
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N=48;
%
[freq,omega,np]=frequencies_octave_spaced(fmin,fmax,N);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



num=3; % total dof
nem=1; % number of dof with enforce acceleration
ea(1)=1; % dof with enforced

dtype=1; % display partitioned matrices

[acc_trans_xc,rd_trans_xc,abs_disp_trans_xc]=...
    vibrationdata_enforce_acceleration_frf_complex(mass,stiff,damp,num,nem,ea,fmin,fmax,dtype,freq);


if(unit==1)
    scale=386;    
else
    scale=9.81;    
end    

acc_trans_xc(:,3)=scale*acc_trans_xc(:,3);

for j=2:3
    abs_disp_trans_xc(:,j)=scale*abs_disp_trans_xc(:,j);
    rd_trans_xc(:,j)=scale*rd_trans_xc(:,j);    
end


acc_trans = [ acc_trans_xc(:,1) abs(acc_trans_xc(:,2)) abs(acc_trans_xc(:,3)) ];
rd_trans  = [  rd_trans_xc(:,1)  abs(rd_trans_xc(:,2))  abs(rd_trans_xc(:,3)) ];



np=length( acc_trans_xc(:,1)  );

rd_trans_s1_xc=zeros(np,2);
rd_trans_s2_xc=zeros(np,2);

for i=1:np
    omega=2*pi*freq(i);
    omega2=omega^2;
    theta=acc_trans_xc(i,3)/( -omega2 );
    rd_trans_s1_xc(i,2)= rd_trans_xc(i,2)-L1*tan(theta);
    rd_trans_s2_xc(i,2)= rd_trans_xc(i,2)+L2*tan(theta);
end


rd_trans_s1=[ freq abs(rd_trans_s1_xc(:,2)) ];
rd_trans_s2=[ freq abs(rd_trans_s2_xc(:,2)) ];





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

psave=get(handles.listbox_export_plots,'Value');

x_label='Frequency (Hz)';
y_label='Trans(G/G)';
t_string=' C.G. Translational Acceleration Transmissibility Magnitude';
ppp=[freq acc_trans(:,2)];

[fig_num,h2]=plot_loglog_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);

if(psave==1)
    disp(' ');
    disp(' Plot files exported to hard drive as: ');    
    disp(' ');
    pname='translational_accel_trans';
    set(gca,'Fontsize',12);
    print(h2,pname,'-dpng','-r300');    
    out1=sprintf(' %s.png',pname);
    disp(out1);    
end   


y_label='Trans (rad/sec^2/G)';
t_string=' Rotational Acceleration Transmissibility Magnitude';
ppp=[freq acc_trans(:,3)];

[fig_num,h2]=plot_loglog_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);


if(unit==1)
    y_label='Trans (in/G)';
else
    y_label='Trans (m/G)';  
end    

if(psave==1)
    pname='rotational_accel_trans';
    set(gca,'Fontsize',12);
    print(h2,pname,'-dpng','-r300');    
    out1=sprintf(' %s.png',pname);
    disp(out1);    
end   


    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
t_string='Relative Displacement Transmissibility Magnitude';

ppp1=[freq rd_trans_s1(:,2)];
ppp2=[freq    rd_trans(:,2)];
ppp3=[freq rd_trans_s2(:,2)];

leg1='Spring 1';
leg2='C.G.';
leg3='Spring 2';

[fig_num,h2]=plot_loglog_function_md_three_h2(fig_num,x_label,y_label,...
                    t_string,ppp1,ppp2,ppp3,leg1,leg2,leg3,fmin,fmax,5);

                
if(psave==1)
    pname='rel_disp_trans';
    set(gca,'Fontsize',12);
    print(h2,pname,'-dpng','-r300');    
    out1=sprintf(' %s.png',pname);
    disp(out1);    
end                  
%

rot=abs(abs_disp_trans_xc(:,3));

ppp=[freq rot];
t_string='Angular Displacement Transmissibility Magnitude';
y_label='Rotation (rads/G)';  
[fig_num,h2]=plot_loglog_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);

if(psave==1)
    pname='angular_disp_trans';
    set(gca,'Fontsize',12);
    print(h2,pname,'-dpng','-r300');    
    out1=sprintf(' %s.png',pname);
    disp(out1);    
end   


%%

acc_trans_t=[acc_trans(:,1)  acc_trans(:,2)  ];
acc_trans_r=[acc_trans(:,1)  acc_trans(:,3)  ];

setappdata(0,'acc_trans_t',acc_trans_t);
setappdata(0,'acc_trans_r',acc_trans_r);
setappdata(0,'rd_trans',rd_trans);


setappdata(0,'fig_num',fig_num);

set(handles.uipanel_save,'Visible','on');



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_save,'Value');

if(n==1)
    data=getappdata(0,'acc_trans_t');
end
if(n==2)
    data=getappdata(0,'acc_trans_t');
end
if(n==3)
    data=getappdata(0,'rd_trans');
end


output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 


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


% --- Executes on selection change in listbox_export_plots.
function listbox_export_plots_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_export_plots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_export_plots contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_export_plots


% --- Executes during object creation, after setting all properties.
function listbox_export_plots_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_export_plots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

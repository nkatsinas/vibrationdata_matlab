function varargout = two_dof_psd_trot(varargin)
% TWO_DOF_PSD_TROT MATLAB code for two_dof_psd_trot.fig
%      TWO_DOF_PSD_TROT, by itself, creates a new TWO_DOF_PSD_TROT or raises the existing
%      singleton*.
%
%      H = TWO_DOF_PSD_TROT returns the handle to a new TWO_DOF_PSD_TROT or the handle to
%      the existing singleton*.
%
%      TWO_DOF_PSD_TROT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TWO_DOF_PSD_TROT.M with the given input arguments.
%
%      TWO_DOF_PSD_TROT('Property','Value',...) creates a new TWO_DOF_PSD_TROT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before two_dof_psd_trot_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to two_dof_psd_trot_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help two_dof_psd_trot

% Last Modified by GUIDE v2.5 13-Feb-2015 09:45:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @two_dof_psd_trot_OpeningFcn, ...
                   'gui_OutputFcn',  @two_dof_psd_trot_OutputFcn, ...
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


% --- Executes just before two_dof_psd_trot is made visible.
function two_dof_psd_trot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to two_dof_psd_trot (see VARARGIN)

% Choose default command line output for two_dof_psd_trot
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

set(handles.listbox_export_plots,'Value',2);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes two_dof_psd_trot wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = two_dof_psd_trot_OutputFcn(hObject, eventdata, handles) 
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

delete(two_dof_psd_trot);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

FS=get(handles.input_edit,'String');

THM=evalin('base',FS);

THM=fix_size(THM);
%
sz=size(THM);
n=sz(1);
%
fmin=THM(1,1);
fmax=THM(n,1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

       try 
           fig_num=getappdata(0,'fig_num');
       catch
           fig_num=1;
       end
   
   
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

[acc_trans_xc,rd_trans_xc]=...
    vibrationdata_enforce_acceleration_frf_complex(mass,stiff,damp,num,nem,ea,fmin,fmax,dtype,freq);

acc_trans = [ acc_trans_xc(:,1) abs(acc_trans_xc(:,2)) abs(acc_trans_xc(:,3)) ];
rd_trans  = [  rd_trans_xc(:,1)  abs(rd_trans_xc(:,2))  abs(rd_trans_xc(:,3)) ];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
    
if(unit==1)
    scale=386;    
else    
    scale=9.81*1000;    
end    

    acc_trans(:,3)=scale*acc_trans(:,3);
   
    rd_trans_s1(:,2)=scale*rd_trans_s1(:,2);
       rd_trans(:,2)=scale*rd_trans(:,2);
    rd_trans_s2(:,2)=scale*rd_trans_s2(:,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

psd_accel_trans=zeros(np,2);
psd_accel_rot=zeros(np,2);
psd_rd_s1=zeros(np,2);
psd_rd_cg=zeros(np,2);
psd_rd_s2=zeros(np,2);

psd_accel_trans(:,1)=freq;
psd_accel_rot(:,1)=freq;
psd_rd_s1(:,1)=freq;
psd_rd_cg(:,1)=freq;
psd_rd_s2(:,1)=freq;

[fi,psd_amp]=interpolate_PSD_arbitary_frequency(THM(:,1),THM(:,2),freq);


for i=1:np
    psd_accel_trans(i,2)=psd_amp(i)*(acc_trans(i,2))^2;
      psd_accel_rot(i,2)=psd_amp(i)*(acc_trans(i,3))^2;   
          psd_rd_cg(i,2)=psd_amp(i)*(rd_trans(i,2))^2;
          psd_rd_s1(i,2)=psd_amp(i)*(rd_trans_s1(i,2))^2;
          psd_rd_s2(i,2)=psd_amp(i)*(rd_trans_s2(i,2))^2;
end    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

psave=get(handles.listbox_export_plots,'Value');

x_label='Frequency (Hz)';

y_label='Accel (G^2/Hz)';

ppp=[psd_accel_trans(:,1) psd_accel_trans(:,2)];  % trans=translation
qqq=THM;

setappdata(0,'psd_accel_trans',psd_accel_trans);

[aslope,ppp_rms] = calculate_PSD_slopes(ppp(:,1),ppp(:,2));
[aslope,qqq_rms] = calculate_PSD_slopes(qqq(:,1),qqq(:,2));

t_string='Acceleration PSD';

leg_a=sprintf(' C.G.  %6.3g GRMS',ppp_rms);
leg_b=sprintf('Input  %6.3g GRMS',qqq_rms);


[fig_num,h2]=plot_PSD_two_h2(fig_num,x_label,y_label,t_string,ppp,qqq,leg_a,leg_b);

if(psave==1)
    disp(' ');
    disp(' Plot files exported to hard drive as: ');    
    disp(' ');    
    pname='psd_accel_translation';
    set(gca,'Fontsize',12);
    print(h2,pname,'-dpng','-r300');    
    out1=sprintf(' %s.png',pname);
    disp(out1);    
end   


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

y_label='Accel (rad/sec^2)^2/Hz';



ppp=[psd_accel_rot(:,1) psd_accel_rot(:,2)];
[aslope,ppp_rms] = calculate_PSD_slopes(ppp(:,1),ppp(:,2));

t_string=sprintf('Rotational Acceleration PSD  %6.3g rad/sec^2 RMS',ppp_rms);

setappdata(0,'psd_accel_rot',psd_accel_rot);

[fig_num,h2]=plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,5);

if(psave==1)
    pname='psd_accel_rotational';
    set(gca,'Fontsize',12);
    print(h2,pname,'-dpng','-r300');    
    out1=sprintf(' %s.png',pname);
    disp(out1);    
end   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ppp1=psd_rd_s1;
ppp2=psd_rd_cg;
ppp3=psd_rd_s2;

setappdata(0,'psd_rd_s1',psd_rd_s1);
setappdata(0,'psd_rd_cg',psd_rd_cg);
setappdata(0,'psd_rd_s2',psd_rd_s2);

t_string='Relative Displacement PSD';


[aslope,rd_s1_rms] = calculate_PSD_slopes(psd_rd_s1(:,1),psd_rd_s1(:,2));
[aslope,rd_cg_rms] = calculate_PSD_slopes(psd_rd_cg(:,1),psd_rd_cg(:,2));
[aslope,rd_s2_rms] = calculate_PSD_slopes(psd_rd_s2(:,1),psd_rd_s2(:,2));


if(unit==1)
    y_label='Rel Disp (in^2/Hz)';
    leg1=sprintf('Spring 1 %6.3g in RMS',rd_s1_rms);
    leg2=sprintf('    C.G. %6.3g in RMS',rd_cg_rms);
    leg3=sprintf('Spring 2 %6.3g in RMS',rd_s2_rms);
else
    y_label='Rel Disp (mm^2/Hz)';
    leg1=sprintf('Spring 1 %6.3g mm RMS',rd_s1_rms);
    leg2=sprintf('    C.G. %6.3g mm RMS',rd_cg_rms);
    leg3=sprintf('Spring 2 %6.3g mm RMS',rd_s2_rms);    
end


[fig_num,h2]=plot_loglog_function_md_three_h2(fig_num,x_label,y_label,...
                    t_string,ppp1,ppp2,ppp3,leg1,leg2,leg3,fmin,fmax,5);

if(psave==1)
    pname='psd_relative_displacement';
    set(gca,'Fontsize',12);
    print(h2,pname,'-dpng','-r300');    
    out1=sprintf(' %s.png',pname);
    disp(out1);    
end                   

setappdata(0,'fig_num',fig_num);                
                
set(handles.uipanel_save,'Visible','on');


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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_save,'Value');

if(n==1)
    data=getappdata(0,'psd_accel_trans');
end
if(n==2)
    data=getappdata(0,'psd_accel_rot');
end
if(n==3)
    data=getappdata(0,'psd_rd_cg');
end
if(n==4)
    data=getappdata(0,'psd_rd_s1');
end
if(n==5)
    data=getappdata(0,'psd_rd_s2');
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

function varargout = rectangular_plate_corners_psd(varargin)
% RECTANGULAR_PLATE_CORNERS_PSD MATLAB code for rectangular_plate_corners_psd.fig
%      RECTANGULAR_PLATE_CORNERS_PSD, by itself, creates a new RECTANGULAR_PLATE_CORNERS_PSD or raises the existing
%      singleton*.
%
%      H = RECTANGULAR_PLATE_CORNERS_PSD returns the handle to a new RECTANGULAR_PLATE_CORNERS_PSD or the handle to
%      the existing singleton*.
%
%      RECTANGULAR_PLATE_CORNERS_PSD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RECTANGULAR_PLATE_CORNERS_PSD.M with the given input arguments.
%
%      RECTANGULAR_PLATE_CORNERS_PSD('Property','Value',...) creates a new RECTANGULAR_PLATE_CORNERS_PSD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rectangular_plate_corners_psd_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rectangular_plate_corners_psd_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rectangular_plate_corners_psd

% Last Modified by GUIDE v2.5 08-Sep-2014 11:33:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rectangular_plate_corners_psd_OpeningFcn, ...
                   'gui_OutputFcn',  @rectangular_plate_corners_psd_OutputFcn, ...
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


% --- Executes just before rectangular_plate_corners_psd is made visible.
function rectangular_plate_corners_psd_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rectangular_plate_corners_psd (see VARARGIN)

% Choose default command line output for rectangular_plate_corners_psd
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rectangular_plate_corners_psd wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = rectangular_plate_corners_psd_OutputFcn(hObject, eventdata, handles) 
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

FS=get(handles.input_edit,'String');
%
THM=evalin('base',FS);
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

T=getappdata(0,'T');
L=getappdata(0,'L');
W=getappdata(0,'W');  
iu=getappdata(0,'iu');
unit=iu;

E=getappdata(0,'E');
rho=getappdata(0,'rho');
mu=getappdata(0,'mu');

ZAA=getappdata(0,'ZAA');

fn=getappdata(0,'fn');
alpha=getappdata(0,'alpha_r');
beta=getappdata(0,'beta_r');
gamma=getappdata(0,'gamma_r');

part=getappdata(0,'part');

damp=getappdata(0,'damp_ratio');

fig_num=getappdata(0,'fig_num');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a=L;
b=W;
zbar=T/2;
h=zbar;

Ezbar=E*zbar;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n_loc=get(handles.listbox_location,'Value');

xc=0.5*L;
yc=0.5*W;

if(n_loc==1)
    x=xc-0.5*L;
    y=yc-0.5*W;
end
if(n_loc==2)
    x=xc-0.5*L;
    y=yc-0.25*W;
end
if(n_loc==3)
    x=xc-0.25*L;
    y=yc-0.5*W;
end
if(n_loc==4)
    x=xc-0.25*L;
    y=yc-0.25*W;
end

[Z,d2Zdx2,d2Zdy2,d2Zdxdy,SXX,SYY,TXY]=...
                               plate_corner_Z(x,y,a,b,alpha,beta,gamma,mu,ZAA);

%
%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   clear f;
   fmax=max(THM(:,1));
   nf=10000;
   n=length(fn);
%
   disp(' ');
%
   f=zeros(nf,1);
   f(1)=0.8*THM(1,1);
   for k=2:nf
        f(k)=f(k-1)*2^(1/48);
        if(f(k)>fmax)
            break;
        end    
   end
   nf=max(size(f));
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nmodes=1;
                           
[H,Hv,HA,Hsxx,Hsyy,Htxy]=plate_corner_frf(nf,nmodes,f,fn,damp,part,Z,SXX,SYY,TXY);                          
 
%
    
[accel_trans,rv_trans,rd_trans,vM_trans,HA,Hv,H,HM_stress_vM,Hsxx,Hsyy,Htxy]=...
         vibrationdata_plate_transfer_2(nf,iu,E,mu,T,H,Hv,HA,Hsxx,Hsyy,Htxy,f);      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


PSD_in=THM;
%


[acc_response_psd]=psd_mult_trans(PSD_in,accel_trans);
 [rv_response_psd]=psd_mult_trans(PSD_in,rv_trans);
 [rd_response_psd]=psd_mult_trans(PSD_in,rd_trans);
 [vM_response_psd]=psd_mult_trans(PSD_in,vM_trans);


setappdata(0,'acc_response_psd',acc_response_psd); 
setappdata(0,'rv_response_psd',rv_response_psd); 
setappdata(0,'rd_response_psd',rd_response_psd); 
setappdata(0,'vM_response_psd',vM_response_psd); 

%    
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%
[~,accel_rms]=calculate_PSD_slopes( acc_response_psd(:,1),acc_response_psd(:,2)  );
%
[~,vel_rms]=calculate_PSD_slopes(  rv_response_psd(:,1),rv_response_psd(:,2)  );
%
[~,disp_rms]=calculate_PSD_slopes(  rd_response_psd(:,1),rd_response_psd(:,2)  );
%
[~,vM_rms]=calculate_PSD_slopes(  vM_response_psd(:,1),vM_response_psd(:,2)  );
%



freq=acc_response_psd(:,1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(unit==1)
   dd='in';
   vv='in/sec';
   ss='psi';
else
   dd='mm';
   vv='m/sec';
   ss='Pa';
%
   disp_rms=disp_rms*1000;
%
end
%
%
%%
%
disp(' ');
disp('Acceleration Response ');
out1=sprintf(' %8.4g GRMS',accel_rms);
disp(out1);
%
disp(' ');
disp('Relative Velocity Response ');
out1=sprintf(' %8.4g %s RMS',vel_rms,vv);
disp(out1);
%
disp(' ');
disp(' Relative Displacement Response ');
out1=sprintf(' %8.4g %s RMS',disp_rms,dd);
disp(out1);
%
disp(' ');
disp(' von Mises Response ');
out1=sprintf(' %8.4g %s RMS',vM_rms,ss);
disp(out1);
%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
xlab=sprintf(' Frequency (Hz)');
ylab_acc=sprintf('Accel (G^2/Hz)');
%
if(unit==1)
    ylab_rv=sprintf('Rel Vel (in/sec)^2/Hz)');
    ylab_rd=sprintf('Rel Disp (inch^2/Hz)');
    ylab_ss=sprintf('Stress (psi^2/Hz)');    
else
    ylab_rv=sprintf('Rel Vel (m/sec)^2/Hz)');    
    ylab_rd=sprintf('Rel Disp (mm^2/Hz)');
    ylab_ss=sprintf('Stress (Pa^2/Hz)');      
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
[~,input_rms]=calculate_PSD_slopes( THM(:,1),THM(:,2) );
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

    x=xc-x;
    y=yc-y;
%

figure(fig_num);
fig_num=fig_num+1;
setappdata(0,'fig_num',fig_num);
plot(THM(:,1),THM(:,2),acc_response_psd(:,1),acc_response_psd(:,2));
grid on;
xlabel(xlab);
ylabel(ylab_acc);
%
if(iu==1)
    out1=sprintf('Acceleration Response PSD  x=%g in y=%g in',x,y);
else
    out1=sprintf('Acceleration Response PSD  x=%g m y=%g m',x,y);   
end  
title(out1);
%
s0=sprintf('Base Input %6.3g GRMS',input_rms);
s1=sprintf('Response %6.3g GRMS',accel_rms);
%
legend (s0,s1); 
%    
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off')
%
%
    ymin=10^(floor(log10(min(THM(:,2)))));
    ymax=10^(ceil(log10(max(acc_response_psd(:,2)))));
    
    fmin=10^(floor(log10(min(freq))));
    fmax=10^(ceil(log10(max(freq))));
    axis([fmin,fmax,ymin,ymax]);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
figure(fig_num);
fig_num=fig_num+1;
setappdata(0,'fig_num',fig_num);
plot(rv_response_psd(:,1),rv_response_psd(:,2));
grid on;
xlabel(xlab);
ylabel(ylab_rv);
%
if(iu==1)
    out1=sprintf('Relative Velocity PSD  x=%g in y=%g in',x,y);
else
    out1=sprintf('Relative Velocity PSD  x=%g m y=%g m',x,y);   
end  
title(out1);
%
s1=sprintf('Response %6.3g %s RMS',vel_rms,vv);
%
legend(s1); 
%    
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off')
%
    ymin=10^(floor(log10(min(rv_response_psd(:,2)))));
    ymax=10^(ceil(log10(max(rv_response_psd(:,2)))));
 %   
    if(ymin<ymax*1.0e-05)
        ymin=ymax*1.0e-05;
    end    
    
    axis([fmin,fmax,ymin,ymax]);
%

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(unit==2)  % convert to mm^2
    rd_response_psd(:,2)=rd_response_psd(:,2)*1.0e+06;
end
%
figure(fig_num);
fig_num=fig_num+1;
setappdata(0,'fig_num',fig_num);
plot(rd_response_psd(:,1),rd_response_psd(:,2));
grid on;
xlabel(xlab);
ylabel(ylab_rd);
%
if(iu==1)
    out1=sprintf('Relative Displacement PSD  x=%g in y=%g in',x,y);
else
    out1=sprintf('Relative Displacement PSD  x=%g m y=%g m',x,y);   
end  
title(out1);
%
s1=sprintf('Response %6.3g %s RMS',disp_rms,dd);
%
legend(s1); 
%    
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off')
%
    ymin=10^(floor(log10(min(rd_response_psd(:,2)))));
    ymax=10^(ceil(log10(max(rd_response_psd(:,2)))));
 %   
    if(ymin<ymax*1.0e-05)
        ymin=ymax*1.0e-05;
    end    
    
    axis([fmin,fmax,ymin,ymax]);
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
figure(fig_num);
fig_num=fig_num+1;
setappdata(0,'fig_num',fig_num);
plot(vM_response_psd(:,1),vM_response_psd(:,2));
grid on;
xlabel(xlab);
ylabel(ylab_ss);
%

if(iu==1)
    out1=sprintf('von Mises Stress PSD  x=%g in y=%g in',x,y);
else
    out1=sprintf('von Mises Stress PSD  x=%g m y=%g m',x,y);   
end  
title(out1);
%
s1=sprintf('Response %6.3g %s RMS',vM_rms,ss);
%
legend(s1); 
%    
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off')
%
    ymin=10^(floor(log10(min(vM_response_psd(:,2)))));
    ymax=10^(ceil(log10(max(vM_response_psd(:,2)))));
 %   
    if(ymin<ymax*1.0e-05)
        ymin=ymax*1.0e-05;
    end    
    
    axis([fmin,fmax,ymin,ymax]);
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(handles.uipanel_save,'Visible','on');




% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'rectangular_plate_bending_corners_key',1);

handles.s=rectangular_plate_corners_base;   
set(handles.s,'Visible','on'); 
delete(rectangular_plate_corners_psd);


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_type,'Value');

if(n==1)
    data=getappdata(0,'acc_response_psd');
end
if(n==2)
    data=getappdata(0,'rv_response_psd');
end
if(n==3)
    data=getappdata(0,'rd_response_psd');
end
if(n==4)
    data=getappdata(0,'vM_response_psd');
end

output_name=get(handles.edit_output_array_name,'String');
assignin('base', output_name, data);

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


% --- Executes on selection change in listbox_location.
function listbox_location_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_location contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_location


% --- Executes during object creation, after setting all properties.
function listbox_location_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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

function varargout = circular_plate_four_psd(varargin)
% CIRCULAR_PLATE_FOUR_PSD MATLAB code for circular_plate_four_psd.fig
%      CIRCULAR_PLATE_FOUR_PSD, by itself, creates a new CIRCULAR_PLATE_FOUR_PSD or raises the existing
%      singleton*.
%
%      H = CIRCULAR_PLATE_FOUR_PSD returns the handle to a new CIRCULAR_PLATE_FOUR_PSD or the handle to
%      the existing singleton*.
%
%      CIRCULAR_PLATE_FOUR_PSD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CIRCULAR_PLATE_FOUR_PSD.M with the given input arguments.
%
%      CIRCULAR_PLATE_FOUR_PSD('Property','Value',...) creates a new CIRCULAR_PLATE_FOUR_PSD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before circular_plate_four_psd_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to circular_plate_four_psd_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help circular_plate_four_psd

% Last Modified by GUIDE v2.5 19-Sep-2014 11:01:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @circular_plate_four_psd_OpeningFcn, ...
                   'gui_OutputFcn',  @circular_plate_four_psd_OutputFcn, ...
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


% --- Executes just before circular_plate_four_psd is made visible.
function circular_plate_four_psd_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to circular_plate_four_psd (see VARARGIN)

% Choose default command line output for circular_plate_four_psd
handles.output = hObject;


clc;

fstr='circular_plate_four.png';

bg = imread(fstr);
info = imfinfo(fstr);
w = info.Width;  %An integer indicating the width of the image in pixels
h = info.Height; %An integer indicating the height of the image in pixels
 
axes(handles.axes1);
image(bg);
pos1 = getpixelposition(handles.axes1,true);
 
set(handles.axes1, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [pos1(1) pos1(2) w h]);
axis off; 


set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes circular_plate_four_psd wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = circular_plate_four_psd_OutputFcn(hObject, eventdata, handles) 
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
handles.s=circular_plate_four_points_base;

set(handles.s,'Visible','on');

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

tpi=2*pi;

try
    damp=getappdata(0,'damp_ratio');
catch
    warndlg('Damping array does not exist');
    return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fn=getappdata(0,'fn');
part=getappdata(0,'part');  

Z=getappdata(0,'Z'); 
Z_theta=getappdata(0,'Z_theta'); 
Z_r=getappdata(0,'Z_r'); 

iu=getappdata(0,'iu');
unit=iu;

E=getappdata(0,'E');
h=getappdata(0,'T');
radius=getappdata(0,'radius');   
mu=getappdata(0,'mu');
rho=getappdata(0,'rho');
total_mass=getappdata(0,'total_mass');
BC=getappdata(0,'BC');
fig_num=getappdata(0,'fig_num');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


n_loc=get(handles.listbox_location,'Value');

if(n_loc==1)  
    r=0;    
    theta=0;
end
if(n_loc==2) 
    r=0.5;        
    theta=0;  
end
if(n_loc==3)
    r=1;        
    theta=0;
end
if(n_loc==4)
    r=0.5;        
    theta=pi/4;    
end
r=r*radius;


  clear f;
   fmax=max(THM(:,1));
   nf=10000;

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

%%%



tmax=1.0e+90;
rmax=1.0e+90;

i_theta=1;
i_r=1;

for i=1:length(Z_theta)

    terr=abs(Z_theta(i)-theta);
    
    if(terr<tmax)
        tmax=terr;
        i_theta=i;
    end
    
end
for i=1:length(Z_r)

    rerr=abs(Z_r(i)-r);
    
    if(rerr<rmax)
        rmax=rerr;
        i_r=i;
    end    
    
end

ZZ=Z(i_r,i_theta);

[Hrd,Hrv,Haa,accel_trans,rv_trans,rd_trans]=...
                       plate_circular_four_points_frf(f,fn,damp,part,ZZ,iu);

%%%

setappdata(0,'rel_disp_H',rd_trans);
setappdata(0,'rel_vel_H',rv_trans);
setappdata(0,'accel_H',accel_trans);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

Hrd=fix_size(Hrd);
Hrv=fix_size(Hrv);
Haa=fix_size(Haa);

f=fix_size(f);
    
Hrd=abs(Hrd);
Hrv=abs(Hrv);
Haa=abs(Haa);


rd_trans=[f Hrd];
rv_trans =[f Hrv];
accel_trans=[f Haa];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pause(0.3);
progressbar(1);

PSD_in=THM;
%



[acc_response_psd]=psd_mult_trans(PSD_in,accel_trans);
 [rv_response_psd]=psd_mult_trans(PSD_in,rv_trans);
 [rd_response_psd]=psd_mult_trans(PSD_in,rd_trans);



setappdata(0,'acc_response_psd',acc_response_psd); 
setappdata(0,'rv_response_psd',rv_response_psd); 
setappdata(0,'rd_response_psd',rd_response_psd); 

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
%


freq=acc_response_psd(:,1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(unit==1)
   dd='in';
   vv='in/sec';
else
   dd='mm';
   vv='m/sec';
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
figure(fig_num);
fig_num=fig_num+1;
setappdata(0,'fig_num',fig_num);
plot(THM(:,1),THM(:,2),acc_response_psd(:,1),acc_response_psd(:,2));
grid on;
xlabel(xlab);
ylabel(ylab_acc);
%

theta=theta*180/pi;

if(iu==1)
    out1=sprintf('Acceleration Response PSD  r=%g in theta=%g deg',r,theta);
else
    out1=sprintf('Acceleration Response PSD  r=%g m theta=%g deg',r,theta);    
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
    out1=sprintf('Relative Velocity Response PSD  r=%g in theta=%g deg',r,theta);
else
    out1=sprintf('Relative Velocity Response PSD  r=%g m theta=%g deg',r,theta);    
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
    out1=sprintf('Relative Displacement Response PSD  r=%g in theta=%g deg',r,theta);
else
    out1=sprintf('Relative Displacement Response PSD  r=%g m theta=%g deg',r,theta);    
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

set(handles.uipanel_save,'Visible','on');

setappdata(0,'fig_num',fig_num);



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


output_name=get(handles.edit_output_array_name,'String');
assignin('base', output_name, data);



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

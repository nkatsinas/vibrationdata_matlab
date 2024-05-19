function varargout = circular_plate_four_trans(varargin)
% CIRCULAR_PLATE_FOUR_TRANS MATLAB code for circular_plate_four_trans.fig
%      CIRCULAR_PLATE_FOUR_TRANS, by itself, creates a new CIRCULAR_PLATE_FOUR_TRANS or raises the existing
%      singleton*.
%
%      H = CIRCULAR_PLATE_FOUR_TRANS returns the handle to a new CIRCULAR_PLATE_FOUR_TRANS or the handle to
%      the existing singleton*.
%
%      CIRCULAR_PLATE_FOUR_TRANS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CIRCULAR_PLATE_FOUR_TRANS.M with the given input arguments.
%
%      CIRCULAR_PLATE_FOUR_TRANS('Property','Value',...) creates a new CIRCULAR_PLATE_FOUR_TRANS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before circular_plate_four_trans_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to circular_plate_four_trans_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help circular_plate_four_trans

% Last Modified by GUIDE v2.5 15-Sep-2014 13:27:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @circular_plate_four_trans_OpeningFcn, ...
                   'gui_OutputFcn',  @circular_plate_four_trans_OutputFcn, ...
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


% --- Executes just before circular_plate_four_trans is made visible.
function circular_plate_four_trans_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to circular_plate_four_trans (see VARARGIN)

% Choose default command line output for circular_plate_four_trans
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

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




% Update handles structure
guidata(hObject, handles);

% UIWAIT makes circular_plate_four_trans wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = circular_plate_four_trans_OutputFcn(hObject, eventdata, handles) 
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

fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_fmax,'String'));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

damp=getappdata(0,'damp_ratio');

fn=getappdata(0,'fn');
part=getappdata(0,'part');  

Z=getappdata(0,'Z'); 
Z_theta=getappdata(0,'Z_theta'); 
Z_r=getappdata(0,'Z_r'); 

iu=getappdata(0,'iu');
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


nf=20000;
f(1)=fmin;

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

[H,Hv,HA,accel_trans,rv_trans,rd_trans]=...
                       plate_circular_four_points_frf(f,fn,damp,part,ZZ,iu);

%%%

setappdata(0,'rel_disp_H',rd_trans);
setappdata(0,'rel_vel_H',rv_trans);
setappdata(0,'accel_H',accel_trans);
                         
                           
    maxH=0;
    maxHv=0;
    maxHA=0;

    
    maxF=0;
    maxFv=0;
    maxFA=0;
   
%
    for k=1:nf
        if(H(k)>maxH)
            maxH=H(k);
            maxF=f(k);
        end
        if(Hv(k)>maxHv)
            maxHv=Hv(k);
            maxFv=f(k);
        end      
        if(HA(k)>maxHA)
            maxHA=HA(k);
            maxFA=f(k);
        end      
    end       
%
    theta=theta*180/pi;
%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(f,H);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
    if(iu==1)
        out1=sprintf('Relative Displacement FRF  r=%g in  theta=%g deg',r,theta);
        ylabel('Rel Disp (in)/ Base Accel (G) ');
    else
        out1=sprintf('Relative Displacement FRF  r=%g m  theta=%g deg',r,theta);
        ylabel('Rel Disp (m)/ Base Accel (G) ');        
    end
    title(out1);
    xlabel('Frequency (Hz)');
    grid on;
    xlim([fmin fmax]);   
%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(f,Hv);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
    if(iu==1)
        out1=sprintf('Relative Velocity FRF  r=%g in  theta=%g deg',r,theta);
        ylabel('Rel Vel (in/sec)/ Base Accel (G) ');
    else
        out1=sprintf('Relative Velocity FRF  r=%g m  theta=%g deg',r,theta);
        ylabel('Rel Vel (m/sec)/ Base Accel (G) ');        
    end
    xlabel('Frequency (Hz)')
    title(out1);
    grid on;
    xlim([fmin fmax]);    
%
%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(f,HA);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
    if(iu==1)
        out1=sprintf('Acceleration FRF  r=%g in  theta=%g deg',r,theta);
    else
        out1=sprintf('Acceleration FRF  r=%g m  theta=%g deg',r,theta);        
    end
    title(out1);
    ylabel('Response Accel / Base Accel ');
    xlabel('Frequency (Hz)');
    grid on; 
    xlim([fmin fmax]);    
%  
%    
    figure(fig_num);
    fig_num=fig_num+1;
    HA2=HA.*HA;
    plot(f,HA2);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
    if(iu==1)
        out1=sprintf('Accel Power Transmissibility  r=%g in  theta=%g deg',r,theta);
    else
        out1=sprintf('Accel Power Transmissibility  r=%g m  theta=%g deg',r,theta);        
    end
    title(out1);
    ylabel('Trans (G^2/G^2) ');
    xlabel('Frequency (Hz)');
    grid on;
    xlim([fmin fmax]);    
%    
%
    disp(' ');  
%
    disp(' ');
%
    if(iu==1)
        out1=sprintf('  max Relative Displacement FRF = %8.3g (in/G) at %8.4g Hz ',maxH,maxF);
        out2=sprintf('  max Relative Velocity FRF = %8.3g (in/sec/G) at %8.4g Hz ',maxHv,maxFv);
    else
        out1=sprintf('  max Relative Displacement FRF = %8.3g (m/G) at %8.4g Hz ',maxH,maxF);
        out2=sprintf('  max Relative Velocity FRF = %8.3g (m/sec/G) at %8.4g Hz ',maxHv,maxFv);   
    end
    disp(out1);
    disp(out2);
%   
    out1=sprintf('  max Acceleration FRF    = %8.4g (G/G)     at %8.4g Hz ',maxHA,maxFA);
    disp(out1);
    disp(' ');
    out1=sprintf('  max Power Trans  = %8.4g (G^2/G^2) at %8.4g Hz ',maxHA^2,maxFA);
    disp(out1); 
    
 
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
    data=getappdata(0,'accel_H');
end
if(n==2)
    data=getappdata(0,'rel_vel_H');
end
if(n==3)
    data=getappdata(0,'rel_disp_H');
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



function edit_fmin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmin as text
%        str2double(get(hObject,'String')) returns contents of edit_fmin as a double


% --- Executes during object creation, after setting all properties.
function edit_fmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmax as text
%        str2double(get(hObject,'String')) returns contents of edit_fmax as a double


% --- Executes during object creation, after setting all properties.
function edit_fmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

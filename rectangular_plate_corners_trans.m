function varargout = rectangular_plate_corners_trans(varargin)
% RECTANGULAR_PLATE_CORNERS_TRANS MATLAB code for rectangular_plate_corners_trans.fig
%      RECTANGULAR_PLATE_CORNERS_TRANS, by itself, creates a new RECTANGULAR_PLATE_CORNERS_TRANS or raises the existing
%      singleton*.
%
%      H = RECTANGULAR_PLATE_CORNERS_TRANS returns the handle to a new RECTANGULAR_PLATE_CORNERS_TRANS or the handle to
%      the existing singleton*.
%
%      RECTANGULAR_PLATE_CORNERS_TRANS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RECTANGULAR_PLATE_CORNERS_TRANS.M with the given input arguments.
%
%      RECTANGULAR_PLATE_CORNERS_TRANS('Property','Value',...) creates a new RECTANGULAR_PLATE_CORNERS_TRANS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rectangular_plate_corners_trans_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rectangular_plate_corners_trans_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rectangular_plate_corners_trans

% Last Modified by GUIDE v2.5 03-Sep-2014 10:24:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rectangular_plate_corners_trans_OpeningFcn, ...
                   'gui_OutputFcn',  @rectangular_plate_corners_trans_OutputFcn, ...
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


% --- Executes just before rectangular_plate_corners_trans is made visible.
function rectangular_plate_corners_trans_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rectangular_plate_corners_trans (see VARARGIN)

% Choose default command line output for rectangular_plate_corners_trans
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rectangular_plate_corners_trans wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = rectangular_plate_corners_trans_OutputFcn(hObject, eventdata, handles) 
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

setappdata(0,'rectangular_plate_bending_corners_key',1);

handles.s=rectangular_plate_corners_base;   
set(handles.s,'Visible','on'); 

delete(rectangular_plate_corners_trans);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_fmax,'String'));

T=getappdata(0,'T');
L=getappdata(0,'L');
W=getappdata(0,'W');  
iu=getappdata(0,'iu');

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

nmodes=1;
%

[H,Hv,HA,Hsxx,Hsyy,Htxy]=plate_rectangular_frf(nf,nmodes,f,fn,damp,part,Z,SXX,SYY,TXY);

%
     
[accel_trans,rv_trans,rd_trans,vM_trans,HA,Hv,H,HM_stress_vM,Hsxx,Hsyy,Htxy]=...
         vibrationdata_plate_transfer_2(nf,iu,E,mu,T,H,Hv,HA,Hsxx,Hsyy,Htxy,f);     
     
%
setappdata(0,'rel_disp_H',rd_trans);
setappdata(0,'rel_vel_H',rv_trans);
setappdata(0,'accel_H',accel_trans);
setappdata(0,'H_vM',HM_stress_vM);
%
    maxH=0;
    maxHv=0;
    maxHA=0;
    maxvM=0;
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
        if(HM_stress_vM(k)>maxvM)
            maxvM=HM_stress_vM(k);
            maxFvM=f(k);
        end       
    end       
%
    x=xc-x;
    y=yc-y;
%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(f,H);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
    if(iu==1)
        out1=sprintf('Rel Disp Frequency Response Function  x=%g in  y=%g in',x,y);
        ylabel('Rel Disp (in)/ Base Accel (G) ');
    else
        out1=sprintf('Rel Disp Frequency Response Function  x=%g m  y=%g m',x,y);
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
        out1=sprintf('Rel Vel Frequency Response Function  x=%g in  y=%g in',x,y);
        ylabel('Rel Vel (in/sec)/ Base Accel (G) ');
    else
        out1=sprintf('Rel Vel Frequency Response Function  x=%g m  y=%g m',x,y);
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
        out1=sprintf('Accel Frequency Response Function  x=%g in  y=%g in',x,y);
    else
        out1=sprintf('Accel Frequency Response Function  x=%g m  y=%g m',x,y);        
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
        out1=sprintf('Accel Power Transmissibility  x=%g in  y=%g in',x,y);
    else
        out1=sprintf('Accel Power Transmissibility  x=%g m  y=%g m',x,y);        
    end
    title(out1);
    ylabel('Trans (G^2/G^2) ');
    xlabel('Frequency (Hz)');
    grid on;
    xlim([fmin fmax]);    
%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(f,Hsxx,f,Hsyy);
    legend('sxx','syy');
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
    if(iu==1)
        out1=sprintf('Bending Stress  x=%g in  y=%g in',x,y);
        ylabel('Trans (psi/G) ');
    else
        out1=sprintf('Bending Stress  x=%g m  y=%g m',x,y);
        ylabel('Trans (Pa/G) ');        
    end
    title(out1);
    xlabel('Frequency (Hz)');
    grid on;
    xlim([fmin fmax]);    
%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(f,Htxy);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
    if(iu==1)
        out1=sprintf('Shear Stress  x=%g in  y=%g in',x,y);
        ylabel('Trans (psi/G) ');
    else
        out1=sprintf('Shear Stress  x=%g m  y=%g m',x,y);
        ylabel('Trans (Pa/G) ');        
    end
    title(out1);
    xlabel('Frequency (Hz)');
    grid on;  
    xlim([fmin fmax]);    
%    
    figure(fig_num);
    fig_num=fig_num+1;
    plot(f,HM_stress_vM);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
    if(iu==1)
        out1=sprintf('von Mises Stress  x=%g in  y=%g in',x,y);
        ylabel('Trans (psi/G) ');
    else
        out1=sprintf('von Mises Stress  x=%g m  y=%g m',x,y);
        ylabel('Trans (Pa/G) ');        
    end
    title(out1);
    xlabel('Frequency (Hz)');
    grid on;      
    xlim([fmin fmax]);    
%
    disp(' ');  
%
    disp(' ');
%
    if(iu==1)
        out1=sprintf('  max Rel Disp FRF = %8.3g (in/G) at %8.4g Hz ',maxH,maxF);
        out2=sprintf('  max Rel Vel FRF = %8.3g (in/sec/G) at %8.4g Hz ',maxHv,maxFv);
    else
        out1=sprintf('  max Rel Disp FRF = %8.3g (m/G) at %8.4g Hz ',maxH,maxF);
        out2=sprintf('  max Rel Vel FRF = %8.3g (m/sec/G) at %8.4g Hz ',maxHv,maxFv);   
    end
    disp(out1);
    disp(out2);
%   
    out1=sprintf('  max Accel FRF    = %8.4g (G/G)     at %8.4g Hz ',maxHA,maxFA);
    disp(out1);
    disp(' ');
    out1=sprintf('  max Power Trans  = %8.4g (G^2/G^2) at %8.4g Hz ',maxHA^2,maxFA);
    disp(out1); 
    
    disp(' ');
    if(iu==1)
        out1=sprintf('  max von Mises Stress FRF = %8.4g (psi/G) at %8.4g Hz ',maxvM,maxFvM);
    else
        out1=sprintf('  max von Mises Stress FRF = %8.4g (Pa/G) at %8.4g Hz ',maxvM,maxFvM);
    end
    disp(out1); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setappdata(0,'fig_num',fig_num);

set(handles.uipanel_save,'Visible','on');


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
if(n==4)
    data=getappdata(0,'H_vM');
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

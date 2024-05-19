function varargout = circular_plate_trans(varargin)
% CIRCULAR_PLATE_TRANS MATLAB code for circular_plate_trans.fig
%      CIRCULAR_PLATE_TRANS, by itself, creates a new CIRCULAR_PLATE_TRANS or raises the existing
%      singleton*.
%
%      H = CIRCULAR_PLATE_TRANS returns the handle to a new CIRCULAR_PLATE_TRANS or the handle to
%      the existing singleton*.
%
%      CIRCULAR_PLATE_TRANS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CIRCULAR_PLATE_TRANS.M with the given input arguments.
%
%      CIRCULAR_PLATE_TRANS('Property','Value',...) creates a new CIRCULAR_PLATE_TRANS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before circular_plate_trans_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to circular_plate_trans_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help circular_plate_trans

% Last Modified by GUIDE v2.5 19-Sep-2014 15:55:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @circular_plate_trans_OpeningFcn, ...
                   'gui_OutputFcn',  @circular_plate_trans_OutputFcn, ...
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


% --- Executes just before circular_plate_trans is made visible.
function circular_plate_trans_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to circular_plate_trans (see VARARGIN)

% Choose default command line output for circular_plate_trans
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');


bulkhead_type=getappdata(0,'bulkhead_type');
 

string_th{1}=sprintf('Acceleration'); 
string_th{2}=sprintf('Relative Velocity'); 
string_th{3}=sprintf('Relative Displacement'); 
    
if(strcmp(bulkhead_type,'homogeneous'))   
   string_th{4}=sprintf('von Mises Stress'); 
end
 
 
set(handles.listbox_response,'String',string_th) 


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes circular_plate_trans wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = circular_plate_trans_OutputFcn(hObject, eventdata, handles) 
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

setappdata(0,'circular_homogeneous_key',1);

handles.s=vibrationdata_circular_plate_base;   
set(handles.s,'Visible','on'); 

delete(circular_plate_trans);

% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

bulkhead_type=getappdata(0,'bulkhead_type');

tpi=2*pi;

fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_fmax,'String'));

%%%%%%%%%%%%

BC=getappdata(0,'BC');
nn=getappdata(0,'n');
kr=getappdata(0,'k');
Cc=getappdata(0,'CE');
Dc=getappdata(0,'DE');
root=getappdata(0,'root');
fn=getappdata(0,'fn');
part=getappdata(0,'part');    
PF=part;

fig_num=getappdata(0,'fig_num');    
iu=getappdata(0,'iu');
E=getappdata(0,'E');
T=getappdata(0,'T');
radius=getappdata(0,'radius');
mu=getappdata(0,'mu');
rho=getappdata(0,'rho');
total_mass=getappdata(0,'total_mass');

damp=getappdata(0,'damp_ratio');

%%%%%%%%%%%%

nf=20000;
f(1)=fmin;

for k=2:nf
    f(k)=f(k-1)*2^(1/48);
    if(f(k)>fmax)
        break;
    end    
end
nf=max(size(f));

%%%%%%%%%%%%

n_loc=get(handles.listbox_location,'Value');

if(n_loc==1)
    thetaz=0;
    rz=0;
end
if(n_loc==2)
    thetaz=0;
    rz=radius/2;
end
if(n_loc==3)
    thetaz=0;
    rz=radius;
end


%%%%%%%%%%%%

lambda=sqrt(root);

if(BC<=2)    
    
    [Hrd,Hrv,Haa,HvM,Hsr,Hst]=...
        plate_circular_frf(BC,nf,f,fn,damp,nn,kr,PF,Cc,Dc,lambda,rz,radius,thetaz,E,mu,T);
    
end


Hrd=fix_size(Hrd);
Hrv=fix_size(Hrv);
Haa=fix_size(Haa);
HvM=fix_size(HvM);
f=fix_size(f);
    
Hrd=abs(Hrd);
Hrv=abs(Hrv);
Haa=abs(Haa);

if(iu==1)
        Hrd=Hrd*386.;
        Hrv=Hrv*386.;
        HvM=HvM*386.;
else
        Hrd=Hrd*9.81;
        Hrv=Hrv*9.81; 
        HvM=HvM*9.81;        
end

rel_disp_H=[f Hrd];
rel_vel_H =[f Hrv];
accel_H=[f Haa];
stress_vM=[f HvM];

setappdata(0,'rel_disp_H',rel_disp_H);
setappdata(0,'rel_vel_H',rel_vel_H);
setappdata(0,'accel_H',accel_H);
setappdata(0,'H_vM',stress_vM);


%%%%%%%%%%%%

    maxHrd=0;
    maxHrv=0;    
    maxHaa=0;
    maxHvM=0;
  
    maxFrd=0;
    maxFrv=0;    
    maxFaa=0;
    maxFvM=0;    
    
%
    for k=1:nf
        if(Haa(k)>maxHaa)
            maxHaa=Haa(k);
            maxFaa=f(k);
        end
        
        if(Hrv(k)>maxHrv)
            maxHrv=Hrv(k);
            maxFrv=f(k);
        end        
  
        if(Hrd(k)>maxHrd)
            maxHrd=Hrd(k);
            maxFrd=f(k);
        end
        
        if(HvM(k)>maxHvM)
            maxHvM=HvM(k);
            maxFvM=f(k);
        end        
      
    end       

%%%%%%%%%%%%

disp(' ');
%

out1=sprintf('  max Accel FRF    = %8.4g (G/G)     at %8.4g Hz ',maxHaa,maxFaa);
disp(out1);
disp(' ');


if(iu==1)
     out1=sprintf('  max Rel Vel FRF  = %8.3g (in/sec/G) at %8.4g Hz ',maxHrv,maxFrv);
else
    out1=sprintf('  max Rel Vel FRF  = %8.3g (m/sec/G) at %8.4g Hz ',maxHrv,maxFrv);
end
disp(out1);


if(iu==1)
     out1=sprintf('  max Rel Disp FRF = %8.3g (in/G) at %8.4g Hz ',maxHrd,maxFrd);
else
    out1=sprintf('  max Rel Disp FRF = %8.3g (m/G) at %8.4g Hz ',maxHrd,maxFrd);
end
disp(out1);



if(strcmp(bulkhead_type,'homogeneous'))
    
    if(iu==1)
        out1=sprintf('  max von Mises Stress FRF = %8.3g (psi/G) at %8.4g Hz ',maxHvM,maxFvM);
    else
        out1=sprintf('  max von Mises Stress FRF = %8.3g (Pa/G) at %8.4g Hz ',maxHvM,maxFvM);
    end
    disp(out1);

end
    
%%%%%%%%%%%%
 
figure(fig_num);
fig_num=fig_num+1;
plot(f,Haa);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
grid('on');
xlabel('Frequency (Hz)');
ylabel('Accel Trans (G/G)');
xlim([fmin fmax]);   

if(iu==1)
    out1=sprintf('Acceleration Transmissibility  r=%g in  ',rz);
else
    out1=sprintf('Acceleration FRF  r=%g m  ',rz);    
end    
title(out1);
%


%%%%%%%%%%%%

figure(fig_num);
fig_num=fig_num+1;
plot(f,Hrv);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
grid('on');
xlabel('Frequency (Hz)');
xlim([fmin fmax]);   

if(iu==1)
    ylabel('Rel Vel Trans (in/sec/G)');    
    out1=sprintf('Relative Velocity FRF  r=%g in  ',rz);
else
    ylabel('Rel Vel Trans (m/sec/G)');    
    out1=sprintf('Relative Velocity FRF  r=%g m  ',rz);    
end    
title(out1);
%

%%%%%%%%%%%%

figure(fig_num);
fig_num=fig_num+1;
plot(f,Hrd);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
grid('on');
xlabel('Frequency (Hz)');
xlim([fmin fmax]);   

if(iu==1)
    ylabel('Rel Disp Trans (in/G)');    
    out1=sprintf('Relative Displacement FRF  r=%g in  ',rz);
else
    ylabel('Rel Disp Trans (m/G)');    
    out1=sprintf('Relative Displacement FRF  r=%g m  ',rz);    
end    
title(out1);
%

%%%%%%%%%%%%

if(strcmp(bulkhead_type,'homogeneous'))

    figure(fig_num);
    fig_num=fig_num+1;
    plot(f,HvM);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
    grid('on');
    xlabel('Frequency (Hz)');
    xlim([fmin fmax]);   

    if(iu==1)
        ylabel('Stress Trans (psi/G)');    
        out1=sprintf('von Mises Stress FRF  r=%g in  ',rz);
    else
        ylabel('Stress Trans (Pa/G)');    
        out1=sprintf('von Mises Stress FRF  r=%g m  ',rz);    
    end    
    title(out1);
%

end

%%%%%%%%%%%%

setappdata(0,'fig_num',fig_num);

set(handles.uipanel_save,'Visible','on');


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_response,'Value');

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


% --- Executes on selection change in listbox_response.
function listbox_response_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_response (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_response contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_response


% --- Executes during object creation, after setting all properties.
function listbox_response_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_response (see GCBO)
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

function varargout = circular_plate_sine(varargin)
% CIRCULAR_PLATE_SINE MATLAB code for circular_plate_sine.fig
%      CIRCULAR_PLATE_SINE, by itself, creates a new CIRCULAR_PLATE_SINE or raises the existing
%      singleton*.
%
%      H = CIRCULAR_PLATE_SINE returns the handle to a new CIRCULAR_PLATE_SINE or the handle to
%      the existing singleton*.
%
%      CIRCULAR_PLATE_SINE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CIRCULAR_PLATE_SINE.M with the given input arguments.
%
%      CIRCULAR_PLATE_SINE('Property','Value',...) creates a new CIRCULAR_PLATE_SINE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before circular_plate_sine_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to circular_plate_sine_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help circular_plate_sine

% Last Modified by GUIDE v2.5 10-Sep-2014 16:33:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @circular_plate_sine_OpeningFcn, ...
                   'gui_OutputFcn',  @circular_plate_sine_OutputFcn, ...
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


% --- Executes just before circular_plate_sine is made visible.
function circular_plate_sine_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to circular_plate_sine (see VARARGIN)

% Choose default command line output for circular_plate_sine
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes circular_plate_sine wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = circular_plate_sine_OutputFcn(hObject, eventdata, handles) 
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

delete(circular_plate_sine);

% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

bulkhead_type=getappdata(0,'bulkhead_type');

tpi=2*pi;

freq=str2num(get(handles.edit_freq,'String'));
 Ain=str2num(get(handles.edit_accel,'String'));
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

      damp=getappdata(0,'damp_ratio');
   
      if(length(damp)==0)
          warndlg('damping vector does not exist');
          return;
      end    
   
      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f(1)=freq;
nf=1;
num=1;

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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   accel=Ain*abs(Haa);
 rel_vel=Ain*abs(Hrv);
rel_disp=Ain*abs(Hrd);
vMstress=Ain*abs(HvM);   
%
disp(' ');

out1=sprintf(' Base Input:  %g Hz, %g G  \n',freq,Ain);
out2=sprintf(' Response: \n');
out3=sprintf('     Accel = %8.4g G',accel);

if(iu==1)
    out4=sprintf('   Rel Vel = %8.4g in/sec  ',rel_vel);
    out5=sprintf('  Rel Disp = %8.4g in \n',rel_disp);
    out6=sprintf('  von Mises Stress = %8.4g psi',vMstress);
else
    out4=sprintf('   Rel Vel = %8.4g m/sec  ',rel_vel);
    out5=sprintf('  Rel Disp = %8.4g mm \n',rel_disp);
    out6=sprintf('  von Mises Stress = %8.4g Pa',vMstress);     
end    

disp(out1);
disp(out2);
disp(out3);
disp(out4);
disp(out5);

if(strcmp(bulkhead_type,'homogeneous')) 
    disp(out6);
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

msgbox('Calculation complete.  Output written to Matlab Command Window.');



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



function edit_freq_Callback(hObject, eventdata, handles)
% hObject    handle to edit_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_freq as text
%        str2double(get(hObject,'String')) returns contents of edit_freq as a double


% --- Executes during object creation, after setting all properties.
function edit_freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_accel_Callback(hObject, eventdata, handles)
% hObject    handle to edit_accel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_accel as text
%        str2double(get(hObject,'String')) returns contents of edit_accel as a double


% --- Executes during object creation, after setting all properties.
function edit_accel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_accel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

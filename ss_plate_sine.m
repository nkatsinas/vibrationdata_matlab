function varargout = ss_plate_sine(varargin)
% SS_PLATE_SINE MATLAB code for ss_plate_sine.fig
%      SS_PLATE_SINE, by itself, creates a new SS_PLATE_SINE or raises the existing
%      singleton*.
%
%      H = SS_PLATE_SINE returns the handle to a new SS_PLATE_SINE or the handle to
%      the existing singleton*.
%
%      SS_PLATE_SINE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SS_PLATE_SINE.M with the given input arguments.
%
%      SS_PLATE_SINE('Property','Value',...) creates a new SS_PLATE_SINE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ss_plate_sine_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ss_plate_sine_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ss_plate_sine

% Last Modified by GUIDE v2.5 02-Sep-2014 09:12:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ss_plate_sine_OpeningFcn, ...
                   'gui_OutputFcn',  @ss_plate_sine_OutputFcn, ...
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


% --- Executes just before ss_plate_sine is made visible.
function ss_plate_sine_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ss_plate_sine (see VARARGIN)

% Choose default command line output for ss_plate_sine
handles.output = hObject;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ss_plate_sine wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ss_plate_sine_OutputFcn(hObject, eventdata, handles) 
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

delete(ss_plate_sine);


% --- Executes on button press in Calculate.
function Calculate_Callback(hObject, eventdata, handles)
% hObject    handle to Calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * * ');
disp(' ');


freq=str2num(get(handles.edit_freq,'String'));
 Ain=str2num(get(handles.edit_accel,'String'));
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

      damp=getappdata(0,'damp_ratio');
   
      if(length(damp)==0)
          warndlg('damping vector does not exist');
          return;
      end    
      
      
      fbig=getappdata(0,'fbig');
        iu=getappdata(0,'iu');
 num_nodes=getappdata(0,'num_nodes');   

         L=getappdata(0,'L');  
         W=getappdata(0,'W'); 
         T=getappdata(0,'T');
         E=getappdata(0,'E');
         mu=getappdata(0,'mu');
         
       Amn=getappdata(0,'Amn');         
        
a=L;
b=W;
h=T;
       
fn=fbig(:,1);
part=fbig(:,4);

m_index=fbig(:,6);
n_index=fbig(:,7);

num=length(fn);

try
    mt=getappdata(0,'mt');

    if(mt<num)
        num=mt;
    end
  
end   


n_loc=get(handles.listbox_location,'Value');

if(n_loc==1)
    x=0.5*L;
    y=0.5*W;
end
if(n_loc==2)
    x=0.5*L;
    y=0.25*W;
end
if(n_loc==3)
    x=0.25*L;
    y=0.5*W;
end
if(n_loc==4)
    x=0.25*L;
    y=0.25*W;
end

pax=x*pi/a;
pby=y*pi/b;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    nf=1;
    f(1)=freq;
     
     
[accel_trans,rv_trans,rd_trans,vM_trans,HA,Hv,H,HM_stress_vM,Hsxx,Hsyy,Htxy]...
        =ss_plate_trans_core(nf,f,fn,damp,pax,pby,part,Amn,fbig,a,b,T,E,mu,iu);     
     

   accel=Ain*abs(HA);
 rel_vel=Ain*abs(Hv);
rel_disp=Ain*abs(H);
vMstress=Ain*abs(HM_stress_vM);   
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
    out5=sprintf('  Rel Disp = %8.4g mm \n',rel_disp*1000);
    out6=sprintf('  von Mises Stress = %8.4g Pa',vMstress); 
    out7=sprintf('                   = %8.4g MPa',vMstress/(1.0e+06));     
end    

disp(out1);
disp(out2);
disp(out3);
disp(out4);
disp(out5);
disp(out6);

if(iu==2)
    disp(out7);
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

msgbox('Calculation complete.  Output written to Matlab Command Window.');






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

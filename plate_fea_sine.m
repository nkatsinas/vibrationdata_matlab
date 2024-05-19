function varargout = plate_fea_sine(varargin)
% PLATE_FEA_SINE MATLAB code for plate_fea_sine.fig
%      PLATE_FEA_SINE, by itself, creates a new PLATE_FEA_SINE or raises the existing
%      singleton*.
%
%      H = PLATE_FEA_SINE returns the handle to a new PLATE_FEA_SINE or the handle to
%      the existing singleton*.
%
%      PLATE_FEA_SINE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLATE_FEA_SINE.M with the given input arguments.
%
%      PLATE_FEA_SINE('Property','Value',...) creates a new PLATE_FEA_SINE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plate_fea_sine_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plate_fea_sine_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plate_fea_sine

% Last Modified by GUIDE v2.5 01-Aug-2022 20:41:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plate_fea_sine_OpeningFcn, ...
                   'gui_OutputFcn',  @plate_fea_sine_OutputFcn, ...
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


% --- Executes just before plate_fea_sine is made visible.
function plate_fea_sine_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plate_fea_sine (see VARARGIN)

% Choose default command line output for plate_fea_sine
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes plate_fea_sine wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plate_fea_sine_OutputFcn(hObject, eventdata, handles) 
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

delete(plate_fea_sine);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fext=str2num(get(handles.edit_fext,'String'));
Aext=str2num(get(handles.edit_Aext,'String'));

node=str2num(get(handles.edit_node,'String'));

damp=getappdata(0,'damp_ratio');

iu=getappdata(0,'iu');


%% fn=getappdata(0,'part_fn');
omega=getappdata(0,'part_omega');

ModeShapes=getappdata(0,'part_ModeShapes');

sz=size(ModeShapes);

for i=1:sz(1)
    for j=1:sz(2)
        if(isnan(ModeShapes(i,j)))
            warndlg('ModeShape error');
            return;
        end
        if(isinf(ModeShapes(i,j)))
            warndlg('ModeShapes error');
            return;
        end           
    end
end
 
for i=1:length(omega)
    if(isnan(omega(i)))
        warndlg('omega error');
        return;
    end
    if(isinf(omega(i)))
        warndlg('omega error');
        return;
    end    
end

MST=ModeShapes';

TT=getappdata(0,'TT');

Mwd=getappdata(0,'Mwd');
Mww=getappdata(0,'Mww');

ngw=getappdata(0,'ngw');

TZ_tracking_array=getappdata(0,'TZ_tracking_array');

nem=getappdata(0,'nem');

sz=size(Mww);
nff=sz(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

omegan=omega;
omn2=omegan.^2;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f=fext;
np=length(f);

%
 
omega=2*pi*f;
om2=omega.^2;

N=zeros(nff,1);
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nff>12)
    nff=12;
end    

%
y=ones(nem,1);

A=-MST*Mwd*y;
%
acc=zeros(np,1);
rd=zeros(np,1);
%
for k=1:np  % for each excitation frequency

    for i=1:nff  % dof
        den=omn2(i)-om2(k) + (1i)*2*damp(i)*omegan(i)*omega(k);
        N(i)=A(i)/den;
%        fprintf('\n  omn2=%8.4g  om2=%8.4g  damp=%8.4g  omegan=%8.4g  omega=%8.4g  N(i)=%8.4g  \n',omn2(i),om2(k),damp(i),omegan(i),omega(k),N(i));
    end
    
    Ud=zeros(nem,1); 
    for i=1:nem  % convert acceleration input to displacement
        Ud(i)=1/(-om2(k));
    end
%
    Uw=ModeShapes*N;   

    Udw=[Ud; Uw];

%
    U=TT*Udw;    
    
    nu=length(U);
    
    Ur=zeros(nu,1);
    
    for i=1:nu
       Ur(ngw(i))=U(i);   
    end    
    
    
    ij=TZ_tracking_array(node);
    acc(k)=om2(k)*abs(Ur(ij));
    
    rd(k)=abs(Ur(ij)-Ud(1));
 
end

% ah=[f acc];
 
if(iu==1)
%    y_label='Trans (in/G)';
    scale=386;
else
%    y_label='Trans (mm/G)';
    scale=9.81*1000;    
end  
 
% rh=[f scale*rd];

rd=scale*rd;

disp(' ');
out1=sprintf(' Response Results at node %d ',node);
disp(out1);

    out1=sprintf('\n           Acceleration = %8.4g G  at %g Hz ',acc*Aext,fext);
disp(out1);

if(iu==1)
    out1=sprintf('\n  Relative Displacement = %8.4g in  at %g Hz ',rd*Aext,fext);
else
    out1=sprintf('\n  Relative Displacement = %8.4g mm  at %g Hz ',rd*Aext,fext);    
end    
disp(out1);
disp(' ');


msgbox('Results written to Matlab Command Window');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




function edit_fext_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fext as text
%        str2double(get(hObject,'String')) returns contents of edit_fext as a double


% --- Executes during object creation, after setting all properties.
function edit_fext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Aext_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Aext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Aext as text
%        str2double(get(hObject,'String')) returns contents of edit_Aext as a double


% --- Executes during object creation, after setting all properties.
function edit_Aext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Aext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_node_Callback(hObject, eventdata, handles)
% hObject    handle to edit_node (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_node as text
%        str2double(get(hObject,'String')) returns contents of edit_node as a double


% --- Executes during object creation, after setting all properties.
function edit_node_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_node (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    fn=getappdata(0,'part_fn');
    sss=sprintf('%8.4g',fn(1));
    set(handles.edit_fext,'String',sss);
catch
    warndlg('Fundamental Frequency not found');
end
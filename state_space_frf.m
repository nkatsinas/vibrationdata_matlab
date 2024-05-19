function varargout = state_space_frf(varargin)
% STATE_SPACE_FRF MATLAB code for state_space_frf.fig
%      STATE_SPACE_FRF, by itself, creates a new STATE_SPACE_FRF or raises the existing
%      singleton*.
%
%      H = STATE_SPACE_FRF returns the handle to a new STATE_SPACE_FRF or the handle to
%      the existing singleton*.
%
%      STATE_SPACE_FRF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STATE_SPACE_FRF.M with the given input arguments.
%
%      STATE_SPACE_FRF('Property','Value',...) creates a new STATE_SPACE_FRF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before state_space_frf_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to state_space_frf_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help state_space_frf

% Last Modified by GUIDE v2.5 23-Aug-2018 09:57:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @state_space_frf_OpeningFcn, ...
                   'gui_OutputFcn',  @state_space_frf_OutputFcn, ...
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


% --- Executes just before state_space_frf is made visible.
function state_space_frf_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to state_space_frf (see VARARGIN)

% Choose default command line output for state_space_frf
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes state_space_frf wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = state_space_frf_OutputFcn(hObject, eventdata, handles) 
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

delete(state_space_frf);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * * * ');
disp(' ');

fig_num=1;

iu=getappdata(0,'iu');


fmin=str2num(get(handles.edit_fstart,'String'));
fmax=str2num(get(handles.edit_fend,'String'));
  
if(fmin<=0.01)
    fmin=0.01;
end    


A=getappdata(0,'A');
B=getappdata(0,'B');
ar=getappdata(0,'ar');
br=getappdata(0,'br');
lambda=getappdata(0,'lambda');
ModeShapes=getappdata(0,'ModeShapes');
MST=getappdata(0,'MST');
Eigenvalues=getappdata(0,'Eigenvalues');

ar
lambda
ModeShapes


sz=size(ModeShapes);

two_N=sz(1);
N=round(two_N/2);

%
[freq,omega,np]=frequencies_octave_spaced(fmin,fmax,96);

disp(' ');
disp(' Output frf arrays:');
disp(' ');
disp('   Hd=receptance  Hv=mobility  Ha=accelerance ');
disp(' ');

for i=1:N
    
    for j=1:N
        
        
        H=zeros(np,1);
        Hv=zeros(np,1);      
        Ha=zeros(np,1);            
        
        for k=1:np
            
            jomega=omega(k)*1i;

            for r=1:two_N
                
                num=ModeShapes(i,r)*ModeShapes(j,r);
                
                den=ar(r)*( jomega -lambda(r));
                H(k)=H(k)+num/den;
                
            end
            
           
            Hv(k)=jomega*H(k);
            Ha(k)=-omega(k)^2*H(k);
            
            if(iu==1)
                Ha(k)=Ha(k)/386;
            else
                Ha(k)=Ha(k)/9.81;
            end
            
        end            
            
        output_name_d=sprintf('Hd_%d%d',i,j);
        assignin('base', output_name_d, [freq H]);
        
            
        output_name_v=sprintf('Hv_%d%d',i,j);
        assignin('base', output_name_v, [freq Hv]); 
       
            
        output_name_a=sprintf('Ha_%d%d',i,j);
        assignin('base', output_name_a, [freq Ha]);    
         
        out1=sprintf(' %s  %s  %s ',output_name_d,output_name_v,output_name_a);
        disp(out1);
        
        eval(sprintf('Hd_%d%d=[freq H];',i,j));
        eval(sprintf('Hv_%d%d=[freq Hv];',i,j));
        eval(sprintf('Ha_%d%d=[freq Ha];',i,j));
            
        eval(sprintf('Hd_%d%d_abs=[freq abs(H)];',i,j));
        eval(sprintf('Hv_%d%d_abs=[freq abs(Hv)];',i,j));
        eval(sprintf('Ha_%d%d_abs=[freq abs(Ha)];',i,j));            
            
    end
    
end

md=5;

if(N==2)
    [fig_num]=state_space_plots_two(fig_num,md,iu,Hd_11_abs,Hd_12_abs,Hd_22_abs,...
                                                  Hv_11_abs,Hv_12_abs,Hv_22_abs,...
                                                  Ha_11_abs,Ha_12_abs,Ha_22_abs);                                              
end
    


function edit_fstart_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fstart as text
%        str2double(get(hObject,'String')) returns contents of edit_fstart as a double


% --- Executes during object creation, after setting all properties.
function edit_fstart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fend_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fend as text
%        str2double(get(hObject,'String')) returns contents of edit_fend as a double


% --- Executes during object creation, after setting all properties.
function edit_fend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

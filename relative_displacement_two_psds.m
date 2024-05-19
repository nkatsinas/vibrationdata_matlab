function varargout = relative_displacement_two_psds(varargin)
% RELATIVE_DISPLACEMENT_TWO_PSDS MATLAB code for relative_displacement_two_psds.fig
%      RELATIVE_DISPLACEMENT_TWO_PSDS, by itself, creates a new RELATIVE_DISPLACEMENT_TWO_PSDS or raises the existing
%      singleton*.
%
%      H = RELATIVE_DISPLACEMENT_TWO_PSDS returns the handle to a new RELATIVE_DISPLACEMENT_TWO_PSDS or the handle to
%      the existing singleton*.
%
%      RELATIVE_DISPLACEMENT_TWO_PSDS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RELATIVE_DISPLACEMENT_TWO_PSDS.M with the given input arguments.
%
%      RELATIVE_DISPLACEMENT_TWO_PSDS('Property','Value',...) creates a new RELATIVE_DISPLACEMENT_TWO_PSDS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before relative_displacement_two_psds_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to relative_displacement_two_psds_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help relative_displacement_two_psds

% Last Modified by GUIDE v2.5 11-Feb-2021 10:28:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @relative_displacement_two_psds_OpeningFcn, ...
                   'gui_OutputFcn',  @relative_displacement_two_psds_OutputFcn, ...
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


% --- Executes just before relative_displacement_two_psds is made visible.
function relative_displacement_two_psds_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to relative_displacement_two_psds (see VARARGIN)

% Choose default command line output for relative_displacement_two_psds
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes relative_displacement_two_psds wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = relative_displacement_two_psds_OutputFcn(hObject, eventdata, handles) 
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

delete(relative_displacement_two_psds);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    FS=get(handles.edit_input_array,'String');
    accel_psd=evalin('base',FS);    
catch
    warndlg('Input array not found');
    return;
end

if(accel_psd(1,1)==0)
    accel_psd(1,:)=[];
end

fmin=str2double(get(handles.edit_fmin,'string'));
fmax=str2double(get(handles.edit_fmax,'string'));

ff=accel_psd(:,1);

[~,ii]=min(abs(ff-fmin));
[~,jj]=min(abs(ff-fmax));

accel_psd=accel_psd(ii:jj,:);


%
sz=size(accel_psd);
%
num=sz(1);
%
f=accel_psd(:,1);
df=(f(end)-f(1))/(num-1);
%
omega=2*pi*f;
%
disp_psd1=zeros(num,1);
disp_psd2=zeros(num,1);
%
for i=1:num
    omega4=omega(i)^4;
    disp_psd1(i)=386^2*accel_psd(i,2)/omega4;
    disp_psd2(i)=386^2*accel_psd(i,3)/omega4;
end
%
rel_disp=zeros(90,1);

%
%  90 phase angle cases, spaced 4 degree apart
%
num_phase=360;
%
phase=zeros(num_phase,1);
%
for i=1:num_phase
    phase(i)=(i-1);
    theta=phase(i)*pi/180;
%
%  Calculate displacement Fourier magnitudes
%
    rd_ft=zeros(num,1);
        
    for j=1:num
       disp1=sqrt(disp_psd1(j)*df);
       disp2=sqrt(disp_psd2(j)*df);
       disp2=(cos(theta)+1i*sin(theta))*disp2;
       rd_ft(j)=abs(disp1-disp2);
    end    
%
%  Calculate the overall displacement response, square-root-of-the-sum-of-the-squares
%
    rd_ft=rd_ft/sqrt(2);
    rel_disp(i)=sqrt( sum( (rd_ft.^2 ) ));
    
end    

max_rel_disp=max(rel_disp);
min_rel_disp=min(rel_disp);

fprintf('\n Relative Displacement limits (inch RMS) \n\n');
fprintf(' max=%8.4g   min=%8.4g  \n\n',max_rel_disp,min_rel_disp);

fprintf('\n Relative Displacement limits (inch 5-sigma) \n\n');
fprintf(' max=%8.4g   min=%8.4g  \n\n',5*max_rel_disp,5*min_rel_disp);

%%%

fig_num=1;
ppp=[accel_psd(:,1) accel_psd(:,2)]; 
qqq=[accel_psd(:,1) accel_psd(:,3)]; 
x_label='Frequency (Hz)';
y_label='Accel (G^2/Hz)';
t_string='Power Spectral Density';


rms1=sqrt( sum( (accel_psd(:,2)*df ) ));
rms2=sqrt( sum( (accel_psd(:,3)*df ) ));

leg_a=sprintf(' psd 1:  %7.3g GRMS',rms1);
leg_b=sprintf(' psd 2:  %7.3g GRMS',rms2);


[fig_num]=plot_PSD_two(fig_num,x_label,y_label,t_string,ppp,qqq,leg_a,leg_b);

%%%

figure(fig_num);
plot(phase,rel_disp);
title('Relative Displacement vs. Uniform Phase Angle');
ylabel('Rel Disp (inch RMS)');
xlabel('Phase Angle (deg)');
grid on;

msgbox('Results written to command window');


function edit_input_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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

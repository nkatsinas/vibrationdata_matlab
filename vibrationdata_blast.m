function varargout = vibrationdata_blast(varargin)
% VIBRATIONDATA_BLAST MATLAB code for vibrationdata_blast.fig
%      VIBRATIONDATA_BLAST, by itself, creates a new VIBRATIONDATA_BLAST or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_BLAST returns the handle to a new VIBRATIONDATA_BLAST or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_BLAST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_BLAST.M with the given input arguments.
%
%      VIBRATIONDATA_BLAST('Property','Value',...) creates a new VIBRATIONDATA_BLAST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_blast_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_blast_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_blast

% Last Modified by GUIDE v2.5 11-Sep-2018 12:09:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_blast_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_blast_OutputFcn, ...
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


% --- Executes just before vibrationdata_blast is made visible.
function vibrationdata_blast_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_blast (see VARARGIN)

% Choose default command line output for vibrationdata_blast
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_blast wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_blast_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_blast);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end


disp(' ');
disp(' * * * * * * ');
disp('  ');

fig_num=1;

try
    FS=get(handles.edit_th,'String');
    THM=evalin('base',FS); 
catch
    warndlg('Input Time History not found');
    return;
end

t=THM(:,1);
y=THM(:,2);

%
figure(fig_num);
fig_num=fig_num+1;
%
plot(t,y);
title('Input Time History');
grid on;
xlabel('Time(sec)');


tmx=max(t);
tmi=min(t);
n = length(t);
dt=(tmx-tmi)/(n-1);
sr=1./dt;

disp(' ')
disp(' Time Step ');
dtmin=min(diff(t));
dtmax=max(diff(t));
%
out4 = sprintf(' dtmin  = %8.4g sec  ',dtmin);
out5 = sprintf(' dt     = %8.4g sec  ',dt);
out6 = sprintf(' dtmax  = %8.4g sec  ',dtmax);
disp(out4)
disp(out5)
disp(out6)
%

if(((dtmax-dtmin)/dt)>0.01)
   
    warndlg(' Warning:  time step is not constant.');
    return;
end

tmin=t(1);
t=t-tmin;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS=get(handles.edit_H,'String');
    H=evalin('base',FS); 
catch
    warndlg('Transfer function not found');
    return;
end

sz=size(H);

f=H(:,1);

if(sz(2)==2)
    Hr=real(H(:,2));
    Hi=imag(H(:,2));    
end
if(sz(2)==3)
    Hr=H(:,2);
    Hi=H(:,3);    
end

nfs=length(f);

Hm=zeros(nfs,1);
Hc=zeros(nfs,1);

for i=1:nfs
    Hm(i)=norm([Hr(i) Hi(i)]);
    Hc(i)=Hr(i)+(1i)*Hi(i);
end
    
HHc=[f Hc];

%
nf=max(size(H));
%
df=(H(nf,1)-H(1,1))/(nf-1);
%
df_max=max(diff(H(:,1)));
df_min=min(diff(H(:,1)));
%
if(((df_max-df_min)/df)>0.01)
    warndlg(' Warning:  frequency step is not constant.')
    return;
end

ppp=[f Hm];
x_label='Frequency (Hz)';
y_label='Magnitude';
fmin=0;
fmax=max(f);
md=6;
t_string='Frequency Response Function';

[fig_num]=plot_linlog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

itype=get(handles.listbox_type,'Value');

if(itype==1)
    frf=zeros(2*nf,2);
    frf(1:nf,:)=HHc(1:nf,:);
%
    for i=1:nf
        frf(i+nf,1)=(i+nf)*df;
    end
%
    aa=H(:,2);
    bb= flipud(aa);
%
    for i=1:nf
        frf(i+nf,2)=real(bb(i))-(1i)*imag(bb(i));
    end
%
    nf=2*nf;
%
else
    frf=HHc;
    nf=length(frf(:,1));
end

frf_temp=zeros(nf,2);

for i=1:nf
    frf_temp(i,1)=(i-1)*df;
    frf_temp(i,2)=frf(i,2);
end


assignin('base', 'frf_temp', frf_temp);

%
frf_amp=frf(:,2);
%
frf_amp=flipud(frf_amp);
%
disp(' ');
disp(' inverse Fourier transform ');
[t_real,t_imag]=inverse_fourier_transform(frf_amp,nf);
%
impulse_resp=( t_real+(1i)*t_imag );
%
impulse_resp=real(impulse_resp);
%
impulse_dt=1/max(frf(:,1));
tmax=(nf-1)*impulse_dt;
%
t_imp=linspace(0,tmax,nf);
%
%

impulse_resp=impulse_resp*4;
    

[ttt,impulse_resp]=linear_interpolation(t_imp,impulse_resp,dt);


impulse_resp(1)=0.;
%
nt_imp=length(impulse_resp);
%
%
impulse_resp=impulse_resp/nt_imp;   % normalization factor applied
%
cc=conv(y,impulse_resp);

cc=fix_size(cc);

ntc=floor(length(impulse_resp)/2);
%
tc=zeros(ntc,1);
for i=1:ntc
    tc(i)=(i-1)*dt;
end
cc=cc(1:ntc,1);

impulse_resp=impulse_resp(1:ntc,1);    

clear ttt;

for i=1:ntc
    ttt(i)=(i-1)*dt+tmin;
end

ttt=fix_size(ttt);


%
figure(fig_num);
fig_num=fig_num+1;
plot(ttt,impulse_resp);
title('Impulse Response Function');
grid on;
xlabel('Time(sec)');
grid on;
xlabel('Time(sec)')
%
figure(fig_num);
fig_num=fig_num+1;
plot(tc,cc);
title('Response');
grid on;
xlabel('Time(sec)');
%
response=[tc cc];
impulse_response=[ttt impulse_resp];
%
setappdata(0,'response',response);
setappdata(0,'impulse_response',impulse_response);


function edit_th_Callback(hObject, eventdata, handles)
% hObject    handle to edit_th (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_th as text
%        str2double(get(hObject,'String')) returns contents of edit_th as a double


% --- Executes during object creation, after setting all properties.
function edit_th_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_th (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_H_Callback(hObject, eventdata, handles)
% hObject    handle to edit_H (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_H as text
%        str2double(get(hObject,'String')) returns contents of edit_H as a double


% --- Executes during object creation, after setting all properties.
function edit_H_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_H (see GCBO)
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



function edit_output_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_save,'Value');

if(n==1)
    data=getappdata(0,'response');
else
    data=getappdata(0,'impulse_response');    
end

    
output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 


% --- Executes on selection change in listbox_save.
function listbox_save_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_save contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_save


% --- Executes during object creation, after setting all properties.
function listbox_save_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

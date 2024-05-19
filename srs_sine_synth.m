function varargout = srs_sine_synth(varargin)
% SRS_SINE_SYNTH MATLAB code for srs_sine_synth.fig
%      SRS_SINE_SYNTH, by itself, creates a new SRS_SINE_SYNTH or raises the existing
%      singleton*.
%
%      H = SRS_SINE_SYNTH returns the handle to a new SRS_SINE_SYNTH or the handle to
%      the existing singleton*.
%
%      SRS_SINE_SYNTH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SRS_SINE_SYNTH.M with the given input arguments.
%
%      SRS_SINE_SYNTH('Property','Value',...) creates a new SRS_SINE_SYNTH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before srs_sine_synth_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to srs_sine_synth_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help srs_sine_synth

% Last Modified by GUIDE v2.5 18-Jul-2019 14:32:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @srs_sine_synth_OpeningFcn, ...
                   'gui_OutputFcn',  @srs_sine_synth_OutputFcn, ...
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


% --- Executes just before srs_sine_synth is made visible.
function srs_sine_synth_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to srs_sine_synth (see VARARGIN)

% Choose default command line output for srs_sine_synth
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes srs_sine_synth wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = srs_sine_synth_OutputFcn(hObject, eventdata, handles) 
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

delete(srs_sine_synth)


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * ');
disp('  ');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=1;

Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS1=strtrim(get(handles.edit_srs_name,'String'));
    THS=evalin('base',FS1);
catch
    warndlg('SRS array does not exist','Warning');
    return;
end

tpi=2*pi;

iunit=get(handles.listbox_units,'Value');

fr=THS(:,1);
r=THS(:,2);



num=length(fr);
nm1=num-1;

fmin=fr(1,1);
fmax=fr(end,1);


Q=str2num(get(handles.edit_Q,'String'));

if(Q==0)
    warndlg('Q must be > 0');
    return;
end


damp=1/(2*Q);

T=str2num(get(handles.edit_duration,'String'));

sr=str2num(get(handles.edit_sr,'String'));
dt=1/sr;

if(sr<10*fmax)
    warndlg('Sample rate is too low');
end

direction=get(handles.listbox_direction,'Value');

nt=ceil(T/dt);

%%%%%

f1=fmin;
f2=fmax;

%%%%%

f11=log10(f1);
f22=log10(f2);
spectral=logspace(f11,f22,nt); 

%%%%%

N=log(f2/f1)/log(2);

R=N/(T-2*dt);
den=R*log(2);

%%%

t=zeros(3*nt,1);
a=zeros(3*nt,1);
amp=ones(3*nt,1);

%%%

n=zeros(nm1,1);
for j=1:nm1
    x1=fr(j);
    x2=fr(j+1);
    y1=r(j);
    y2=r(j+1);
    n(j)=log(y2/y1)/log(x2/x1);
end    

for i=1:nt
    
    for j=1:nm1
        if(spectral(i)<fr(1))
            amp(i+nt-1)=r(1);
            break;
        end        
        if(spectral(i)==fr(j))
            amp(i+nt-1)=r(j);
            break;
        end
        if(spectral(i)==fr(j+1))
            amp(i+nt-1)=r(j+1);
            break;
        end   
        if(spectral(i)>fr(end))
            amp(i+nt-1)=r(end);
            break;
        end        
        if(spectral(i)>fr(j) && spectral(i)<fr(j+1))
            amp(i+nt-1)=r(j)*(spectral(i)/fr(j))^n(j);
        end
    end
    
end

for i=1:3*nt
    t(i)=(i-1)*dt;
end

    
for i=nt:(2*nt+2)
    ttt=t(i)-t(nt);
    arg=tpi*f1*(2^(R*ttt)-1)/den;
    a(i)=sin(arg);
    
    if(t(i)>0.9999)
        out1=sprintf(' t=%8.6g  a=%8.6g ',t(i),a(i));
        disp(out1);
    end
    
end    
         
if(direction==2)
    a=flipud(a);
    amp=flipud(amp);    
end
    
% a=a.*(amp/Q);

minf=0.5*fr(1);
maxf=fr(1);

for i=1:0
    out1=sprintf('\n compensation %d',i);
    disp(out1);
    [a,v,d]=compensation_avd(a,dt,minf,maxf);

end

v=dt*cumtrapz(a);
d=dt*cumtrapz(v);


a=fix_size(a);
v=fix_size(v);
d=fix_size(d);

%%%%%

% srs

ioct=3;

[fn,srs_spec]=SRS_specification_interpolation(fr,r,ioct);

[a1,a2,b1,b2,b3,~,~,~,~,~]=srs_coefficients(fn,damp,dt);  

num=length(fn);

a_pos=zeros(num,1);
a_neg=zeros(num,1);

for i=1:num
    
    ML=nt+round((1/fn(i))/dt);
    ys=zeros(ML,1);
    ys(1:3*nt)=a;
    
    [~,a_pos(i),a_neg(i)]=arbit_engine(a1(i),a2(i),b1(i),b2(i),b3(i),ys);
end

x_label='Natural Frequency (Hz)';
y_label='Peak Accel (G)';
t_string=sprintf('SRS Q=%d',Q);

leg1='Spec';
leg2='Synth Pos';
leg3='Synth Neg';

fn=fix_size(fn);
srs_spec=fix_size(srs_spec);

ppp1=[fn srs_spec];
ppp2=[fn a_pos];
ppp3=[fn a_neg];

md=5;

[fig_num,h2]=plot_loglog_function_md_three_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,leg1,leg2,leg3,fn(1),fn(end),md);
%
% iterate
% correct disp & velox
%

output_name='synth';
assignin('base', output_name, [t a]);

acceleration=[t a];
    velocity=[t v];
displacement=[t d];


if(iunit==1)
        velocity(:,2)=386*velocity(:,2);
    displacement(:,2)=386*displacement(:,2);
else
        velocity(:,2)=9.81*100*velocity(:,2);
    displacement(:,2)=9.81*1000*displacement(:,2);    
end

%%%%%

[fig_num]=...
  plot_avd_time_histories_subplots_alt(acceleration,velocity,displacement,iunit,fig_num);

%%%%% figure(fig_num);
%%%%% fig_num=fig_num+1;

%%%%% plot(t,a);
%%%%% grid on;
%%%%% xlabel('Time (sec)');
%%%%% ylabel('Accel (G)');

%%%%%



function edit_srs_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_srs_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_srs_name as text
%        str2double(get(hObject,'String')) returns contents of edit_srs_name as a double


% --- Executes during object creation, after setting all properties.
function edit_srs_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_srs_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Q_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q as text
%        str2double(get(hObject,'String')) returns contents of edit_Q as a double


% --- Executes during object creation, after setting all properties.
function edit_Q_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_sr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sr as text
%        str2double(get(hObject,'String')) returns contents of edit_sr as a double


% --- Executes during object creation, after setting all properties.
function edit_sr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units


% --- Executes during object creation, after setting all properties.
function listbox_units_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_duration_Callback(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_duration as text
%        str2double(get(hObject,'String')) returns contents of edit_duration as a double


% --- Executes during object creation, after setting all properties.
function edit_duration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_direction.
function listbox_direction_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_direction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_direction contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_direction


% --- Executes during object creation, after setting all properties.
function listbox_direction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_direction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_ntap.
function listbox_ntap_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_ntap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_ntap contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_ntap


% --- Executes during object creation, after setting all properties.
function listbox_ntap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_ntap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

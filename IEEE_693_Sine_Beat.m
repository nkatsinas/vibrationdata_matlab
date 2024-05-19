function varargout = IEEE_693_Sine_Beat(varargin)
% IEEE_693_SINE_BEAT MATLAB code for IEEE_693_Sine_Beat.fig
%      IEEE_693_SINE_BEAT, by itself, creates a new IEEE_693_SINE_BEAT or raises the existing
%      singleton*.
%
%      H = IEEE_693_SINE_BEAT returns the handle to a new IEEE_693_SINE_BEAT or the handle to
%      the existing singleton*.
%
%      IEEE_693_SINE_BEAT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IEEE_693_SINE_BEAT.M with the given input arguments.
%
%      IEEE_693_SINE_BEAT('Property','Value',...) creates a new IEEE_693_SINE_BEAT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before IEEE_693_Sine_Beat_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to IEEE_693_Sine_Beat_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help IEEE_693_Sine_Beat

% Last Modified by GUIDE v2.5 10-Jul-2015 09:26:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @IEEE_693_Sine_Beat_OpeningFcn, ...
                   'gui_OutputFcn',  @IEEE_693_Sine_Beat_OutputFcn, ...
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


% --- Executes just before IEEE_693_Sine_Beat is made visible.
function IEEE_693_Sine_Beat_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to IEEE_693_Sine_Beat (see VARARGIN)

% Choose default command line output for IEEE_693_Sine_Beat
handles.output = hObject;

set(handles.listbox_level,'Value',1);
listbox_level_Callback(hObject, eventdata, handles);



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes IEEE_693_Sine_Beat wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = IEEE_693_Sine_Beat_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iunit=get(handles.listbox_units,'Value');

n=get(handles.listbox_level,'Value');

if(n==1) % High PL
    A=0.6;
end
if(n==2) % High
    A=0.5;
end
if(n==3) % Moderate PL
    A=0.3;
end 
if(n==4) % Moderate
    A=0.25;
end    
if(n==5) % other
    A=str2num(get(handles.edit_accel,'String'));
end


 f=str2num(get(handles.edit_frequency,'String'));
nc=str2num(get(handles.edit_cycles,'String'));
 p=str2num(get(handles.edit_pause,'String'));
nb=str2num(get(handles.edit_beats,'String'));
preshock=str2num(get(handles.edit_preshock,'String'));

sr=128*f;
dt=1/sr;

T=1/f;

Tnc=nc*T;
TncP=Tnc+p;

fm=1/(2*Tnc);

rho=f/fm;


nt=ceil(TncP/dt);

k=ceil(preshock/dt);

nnn=k+nb*nt;

t=zeros(nnn,1);
a=zeros(nnn,1);

for i=1:nnn
    t(i)=(i-1)*dt;
end

om1=2*pi*f;
om2=om1/rho;

k=ceil(preshock/dt);

for i=1:nb
    for j=1:nt
        tl=(j-1)*dt;
        if(tl<=Tnc)
            a(k)=sin(om1*tl)*sin(om2*tl);
        end
        k=k+1;
    end
end

a=a*A;


t=fix_size(t);
ha=fix_size(a);
va=0.8*ha;

[hv]=integrate_function(ha,dt);
[hd]=integrate_function(hv,dt);

[vv]=integrate_function(va,dt);
[vd]=integrate_function(vv,dt);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(iunit==1)
    hv=hv*386;
    hd=hd*386;
    vv=vv*386;
    vd=vd*386;    
    ay='Accel (G)';
    vy='Vel (in/sec)';
    dy='Disp (in)';
end
if(iunit==2)
    hv=hv*9.81*100;
    hd=hd*9.81*1000;    
    vv=vv*9.81*100;
    vd=vd*9.81*1000;
    ay='Accel (G)';
    vy='Vel (cm/sec)';
    dy='Disp (mm)';
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1);

subplot(3,1,1);
plot(t,ha);
ylabel(ay);
grid on;
out1=sprintf('IEEE std 693 Sine Beat  Horizontal  freq=%g Hz',f);
title(out1);
yLimits = get(gca,'YLim');
ya=max(abs(yLimits));
ylim([-ya,ya]);
 
subplot(3,1,2);
plot(t,hv);
ylabel(vy);
grid on;
yLimits = get(gca,'YLim');
yv=max(abs(yLimits));
ylim([-yv,yv]);
 
subplot(3,1,3);
plot(t,hd);
ylabel(dy);
xlabel('Time(sec)');
grid on;
yLimits = get(gca,'YLim');
yd=max(abs(yLimits));
ylim([-yd,yd]);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(2);

subplot(3,1,1);
plot(t,va);
ylabel(ay);
grid on;
out1=sprintf('IEEE std 693 Sine Beat  Vertical  freq=%g Hz',f);
title(out1);
ylim([-ya,ya]);
 
subplot(3,1,2);
plot(t,vv);
ylabel(vy);
grid on;
ylim([-yv,yv]);

subplot(3,1,3);
plot(t,vd);
ylabel(dy);
xlabel('Time(sec)');
grid on;
ylim([-yd,yd]);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
out7=sprintf(' Frequency = %8.4g Hz',f);
disp(out7);
disp(' ');
disp(' Maximum Absolute Values for Horizontal Axis ');
disp('  ');

out1=sprintf(' %s %8.4g  ',ay,max(abs(ha)));
out2=sprintf(' %s %8.4g  ',vy,max(abs(hv)));
out3=sprintf(' %s %8.4g  ',dy,max(abs(hd)));

disp(out1);
disp(out2);
disp(out3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hname='sine_beat_horizontal';
vname='sine_beat_vertical';

assignin('base', hname, [t ha]);
assignin('base', vname, [t ha]);


message = sprintf('\n Output Time History Arrays: time(sec) & accel(G) \n\n  %s\n  %s',hname,vname);
uiwait(msgbox(message,'Calculation Complete'));

disp(message);

% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(IEEE_693_Sine_Beat);



function edit_pause_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pause as text
%        str2double(get(hObject,'String')) returns contents of edit_pause as a double


% --- Executes during object creation, after setting all properties.
function edit_pause_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to edit_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_frequency as text
%        str2double(get(hObject,'String')) returns contents of edit_frequency as a double


% --- Executes during object creation, after setting all properties.
function edit_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_cycles_Callback(hObject, eventdata, handles)
% hObject    handle to edit_cycles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_cycles as text
%        str2double(get(hObject,'String')) returns contents of edit_cycles as a double


% --- Executes during object creation, after setting all properties.
function edit_cycles_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_cycles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_beats_Callback(hObject, eventdata, handles)
% hObject    handle to edit_beats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_beats as text
%        str2double(get(hObject,'String')) returns contents of edit_beats as a double


% --- Executes during object creation, after setting all properties.
function edit_beats_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_beats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_level.
function listbox_level_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_level contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_level

set(handles.text_accel,'Visible','off');
set(handles.edit_accel,'Visible','off');

n=get(handles.listbox_level,'Value');

if(n==5)
    set(handles.text_accel,'Visible','on');
    set(handles.edit_accel,'Visible','on');    
end


% --- Executes during object creation, after setting all properties.
function listbox_level_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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



function edit_preshock_Callback(hObject, eventdata, handles)
% hObject    handle to edit_preshock (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_preshock as text
%        str2double(get(hObject,'String')) returns contents of edit_preshock as a double


% --- Executes during object creation, after setting all properties.
function edit_preshock_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_preshock (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

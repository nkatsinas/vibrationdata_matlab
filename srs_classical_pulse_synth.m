function varargout = srs_classical_pulse_synth(varargin)
% SRS_CLASSICAL_PULSE_SYNTH MATLAB code for srs_classical_pulse_synth.fig
%      SRS_CLASSICAL_PULSE_SYNTH, by itself, creates a new SRS_CLASSICAL_PULSE_SYNTH or raises the existing
%      singleton*.
%
%      H = SRS_CLASSICAL_PULSE_SYNTH returns the handle to a new SRS_CLASSICAL_PULSE_SYNTH or the handle to
%      the existing singleton*.
%
%      SRS_CLASSICAL_PULSE_SYNTH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SRS_CLASSICAL_PULSE_SYNTH.M with the given input arguments.
%
%      SRS_CLASSICAL_PULSE_SYNTH('Property','Value',...) creates a new SRS_CLASSICAL_PULSE_SYNTH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before srs_classical_pulse_synth_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to srs_classical_pulse_synth_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help srs_classical_pulse_synth

% Last Modified by GUIDE v2.5 26-Jun-2015 18:41:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @srs_classical_pulse_synth_OpeningFcn, ...
                   'gui_OutputFcn',  @srs_classical_pulse_synth_OutputFcn, ...
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


% --- Executes just before srs_classical_pulse_synth is made visible.
function srs_classical_pulse_synth_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to srs_classical_pulse_synth (see VARARGIN)

% Choose default command line output for srs_classical_pulse_synth
handles.output = hObject;

set(handles.uipanel_save,'Visible','on');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes srs_classical_pulse_synth wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = srs_classical_pulse_synth_OutputFcn(hObject, eventdata, handles) 
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


try
    FS=get(handles.edit_input_array,'String');
    THF=evalin('base',FS);
catch
    warndlg('Input file not found');
    return; 
end


npulse=get(handles.listbox_pulse,'Value');

Q=str2num(get(handles.edit_Q,'String'));

damp=1/(2*Q);

ff=THF(:,1);
aa=THF(:,2);

fmin=ff(1);
n=length(ff);
fmax=ff(n);

ioct=4;

[fn,spec]=SRS_specification_interpolation(ff,aa,ioct);


sr=10*fmax;
dt=1/sr;

tmax=3/fmin;

t1=1/fmin;
t2=1/fmax;

delta=t2-t1;


%
%  Initialize coefficients
%
[a1,a2,b1,b2,b3,rd_a1,rd_a2,rd_b1,rd_b2,rd_b3]=...
                                   srs_coefficients(fn,damp,dt);
%
num=length(fn);

error_max=1.0e+90;

disp('  ');
disp('Trial   error   A   dur ');

progressbar;
M=400;
for i=1:M
    
    progressbar(i/M);
    
    clear TT;
    clear a;
    clear yy;

    pulse_dur=t1+delta*rand();
   
    
    if(i>20)
        if(rand()>0.5)
            pulse_dur=pulse_dur_rec*(0.9+0.02*rand());
        end    
    end
    
    
    total_dur=pulse_dur+2/fmin;
    
    npa=round(total_dur/dt);   
       
    TT=linspace(0,npa*dt,(npa+1)); 
    np=length(TT);
    a = zeros(np,1);      
    
    amp=1;
    

    
    if(npulse==1) % half-sine 
%
        for ijk=1:np
            t=TT(ijk);
            if(t<=pulse_dur)
                a(ijk) = sin(pi*t/pulse_dur);
            else
                break;
            end
        end
    end
    
    if(npulse==2)  % rectangular
        
        for ijk=1:np
            t=TT(ijk);
            if(t<=pulse_dur)
                a(ijk) = 1;
            else
                break;
            end
        end
        
    end    
    if(npulse==3)  % terminal sawtooth

        for ijk=1:np
            t=TT(ijk);
            if(t<=pulse_dur)
                a(ijk) = t/pulse_dur;
            else
                break;
            end
        end
        
    end
    
    yy=a*amp;    

%
%  SRS engine
%
    a_pos=zeros(num,1);
    a_neg=zeros(num,1);
%
    for j=1:num
        [~,a_pos(j),a_neg(j)]=arbit_engine(a1(j),a2(j),b1(j),b2(j),b3(j),yy);
    end    
%      
    error=zeros(num,1);
    
    for j=1:num
        error(j)=20*log10(a_pos(j)/spec(j));
    end
 
    
    if(min(error)<0)
        dB=-min(error);
    else
        dB=-min(error);
    end
    
    
    
    scale=10^(dB/20);
    A=max(yy)*scale;
    yy=yy*scale;
    a_pos=a_pos*scale;
    a_neg=a_neg*scale;
   
    
    for j=1:num
        error(j)=20*log10(a_pos(j)/spec(j));
    end 
    
    err=max(abs(error));
    
    
    if(err<error_max)
        error_max=err;
        A_rec=A;
        pulse_dur_rec=pulse_dur;
        a_pos_rec=a_pos;
        a_neg_rec=a_neg;
        yyr=yy;
        TTr=TT;
        
        out1=sprintf('%d %8.4g  %8.4g  %8.4g',i,error_max,A_rec,pulse_dur_rec);
        disp(out1);
    end
    
end
pause(0.3);
progressbar(1);

disp(' ');

if(npulse==1)
     out1=sprintf('Half-Sine Pulse: %7.3g G,  %7.3g sec',A_rec,pulse_dur_rec);   
end
if(npulse==2)
     out1=sprintf('Rectangular Pulse: %7.3g G,  %7.3g sec',A_rec,pulse_dur_rec);          
end    
if(npulse==3)
     out1=sprintf('Terminal Sawtooth Pulse: %7.3g G,  %7.3g sec',A_rec,pulse_dur_rec);   
end


TTr=fix_size(TTr);
yyr=fix_size(yyr);

fig_num=1;

figure(fig_num);
fig_num=fig_num+1;

plot(TTr,yyr);
grid on;
xlabel('Time (sec)');
ylabel('Accel (G)');
title(out1);

out2=sprintf(' Amplitude = %8.4g G \n',A_rec);
out3=sprintf('  Duration = %8.4g seconds ',pulse_dur_rec);
out4=sprintf('           = %8.4g milliseconds ',pulse_dur_rec*1000);
out5=sprintf('           = %8.4g microseconds ',pulse_dur_rec*1.0e+06);

disp(out1);
disp(out2);
disp(out3);
disp(out4);
disp(out5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t_string=sprintf(' Shock Response Spectrum  Q=%g ',Q);


md=4;

x_label='Natural Frequency (Hz)';
y_label='Peak Accel (G)';

leg1='spec';
leg2='positive';
leg3='negative';

fn=fix_size(fn);
spec=fix_size(spec);
a_pos_rec=fix_size(a_pos_rec);
a_neg_rec=fix_size(a_neg_rec);

ppp1=[fn spec];
ppp2=[fn a_pos_rec];
ppp3=[fn a_neg_rec];


fmin=min(fn);
fmax=max(fn);


[fig_num,h2]=plot_loglog_function_md_three_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,leg1,leg2,leg3,fmin,fmax,md);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

msgbox('Results Written to Command Window');

accel=[TTr yyr];

setappdata(0,'accel',accel);

set(handles.uipanel_save,'Visible','on');


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(srs_classical_pulse_synth);



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


% --- Executes on selection change in listbox_pulse.
function listbox_pulse_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_pulse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_pulse contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_pulse
set(handles.uipanel_save,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_pulse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_pulse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'accel');

output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 

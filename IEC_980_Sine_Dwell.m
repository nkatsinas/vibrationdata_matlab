function varargout = IEC_980_Sine_Dwell(varargin)
% IEC_980_SINE_DWELL MATLAB code for IEC_980_Sine_Dwell.fig
%      IEC_980_SINE_DWELL, by itself, creates a new IEC_980_SINE_DWELL or raises the existing
%      singleton*.
%
%      H = IEC_980_SINE_DWELL returns the handle to a new IEC_980_SINE_DWELL or the handle to
%      the existing singleton*.
%
%      IEC_980_SINE_DWELL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IEC_980_SINE_DWELL.M with the given input arguments.
%
%      IEC_980_SINE_DWELL('Property','Value',...) creates a new IEC_980_SINE_DWELL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before IEC_980_Sine_Dwell_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to IEC_980_Sine_Dwell_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help IEC_980_Sine_Dwell

% Last Modified by GUIDE v2.5 27-Dec-2016 16:10:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @IEC_980_Sine_Dwell_OpeningFcn, ...
                   'gui_OutputFcn',  @IEC_980_Sine_Dwell_OutputFcn, ...
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


% --- Executes just before IEC_980_Sine_Dwell is made visible.
function IEC_980_Sine_Dwell_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to IEC_980_Sine_Dwell (see VARARGIN)

% Choose default command line output for IEC_980_Sine_Dwell
handles.output = hObject;

set(handles.uipanel_save,'Visible','on');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes IEC_980_Sine_Dwell wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = IEC_980_Sine_Dwell_OutputFcn(hObject, eventdata, handles) 
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

fig_num=1;

try
    FS=get(handles.edit_input_array,'String');
    THF=evalin('base',FS);
catch
    warndlg('Input file not found');
    return; 
end


Q=str2num(get(handles.edit_Q,'String'));

damp=1/(2*Q);

ff=THF(:,1);
aa=THF(:,2);

n=length(ff);
fmax=ff(n);

ioct=1;

ff(n+1)=ff(n)*2^(1/3);
aa(n+1)=aa(n);

n=length(ff);

[fn_3,spec_3]=SRS_specification_interpolation(ff,aa,ioct);

ioct=4;

[fn_24,spec_24]=SRS_specification_interpolation(ff,aa,ioct);

fn=fn_24;
spec=spec_24;

sr=10*fmax;
dt=1/sr;


%
%  Initialize coefficients
%
[a1,a2,b1,b2,b3,rd_a1,rd_a2,rd_b1,rd_b2,rd_b3]=...
                                   srs_coefficients(fn,damp,dt);
%

num_3=length(fn_3);
num_24=length(fn_24);

num=num_24;


error_max=1.0e+90;

disp('  ');
disp('Trial   error  ');


M=2;


a=zeros(num_3,1);

nhs=65;

nwave=zeros(num_3,1);
alpha=zeros(num_3,1);
beta=zeros(num_3,1);
pause=zeros(num_3,1);

wavelet_duration=0;

for i=1:num_3
    
    a(i)=spec_3(i)/Q;
    
    dur=nhs/(2*fn_3(i));
    
    wavelet_duration=wavelet_duration+dur;
    
    nwave(i)=round(dur/dt);
    
    beta(i)= (2*pi*fn_3(i));
    alpha(i)= beta(i)/nhs  ;  
    
    
    pause(i)=50/fn_3(i);  % pause
    
end




npause=round(pause/dt);

total_pause=sum(pause);
total_duration=wavelet_duration+total_pause;

numt=(round(total_duration/dt));

t=linspace(0,total_duration,(numt-1));
nt=length(t);

progressbar;

for i=1:M
    
    progressbar(i/M);
    
    ijk=1;
    
    yy=zeros(nt,1);
    
    for j=1:num_3  % wavelets
            
        for k=1:nwave(j)
   
            tt=(k-1)*dt;
%            
            at=alpha(j)*(tt);
            bt= beta(j)*(tt);
%
            aaa= sin(at)*sin(bt);

            yy(ijk)=a(j)*aaa;
            ijk=ijk+1;
            
%%            out1=sprintf(' %10.6g  %8.4g  %8.4g',t(ijk),yy(ijk),a(j));
%%            disp(out1);
            
        end
        
        ijk=ijk+npause(j);
        
        if(ijk>=nt)
            break;
        end
                   
    end
   
yyr=yy;

TTr=fix_size(t);
yyr=fix_size(yyr);

    
%
%  SRS engine
%
    a_pos=zeros(num,1);
    a_neg=zeros(num,1);
%
    for j=1:num
%
        forward=[ b1(j),  b2(j),  b3(j) ];    
        back   =[     1, -a1(j), -a2(j) ];
%    
        a_resp=filter(forward,back,yy);
%
        a_pos(j)= max(a_resp);
        a_neg(j)= abs(min(a_resp));
    end    
%      

    for j=1:num
        
        if(fn(j)>max(THF(:,1)))
            inum=j;
            break;
        end    
    end

%
    error=zeros(inum,1);
    eap=zeros(inum,1);
    ean=zeros(inum,1);    
    
    for j=1:inum  % leave
        
        eap(j)=a_pos(j)/spec(j);
        ean(j)=a_neg(j)/spec(j);
        
        e1=20*log10(abs(eap(j)));
        e2=20*log10(abs(ean(j)));
        
        error(j)=e1+e2;
        
%%        out1=sprintf(' %8.4g %8.4g %8.4g ',fn(j),eap(j),ean(j));
%%        disp(out1);
        
    end 
        
    err=max(abs(error));
    
    if(err<error_max)
        error_max=err;
        a_pos_rec=a_pos;
        a_neg_rec=a_neg;
        yyr=yy;
        
    end
    
%%     out1=sprintf(' %8.4g %8.4g ',max(eap),max(ean));
%%     disp(out1);
     
     s1=max([ max(eap) max(ean) ] );
     s2=min([ min(eap) min(ean) ] ); 
     
     scale=s2;
     
    a=a/scale;    
    
    out1=sprintf('%d %8.4g %8.4g %8.4g',i,s1,s2,scale);
    disp(out1);    
    
end

progressbar(1);

disp(' ');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(fig_num);
fig_num=fig_num+1;

plot(TTr,yyr);
grid on;
xlabel('Time (sec)');
ylabel('Accel (G)');
title('Acceleration');


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

ppp1=[THF(:,1) THF(:,2)];
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

delete(IEC_980_Sine_Dwell);



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

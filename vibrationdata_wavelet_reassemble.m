function varargout = vibrationdata_wavelet_reassemble(varargin)
% VIBRATIONDATA_WAVELET_REASSEMBLE MATLAB code for vibrationdata_wavelet_reassemble.fig
%      VIBRATIONDATA_WAVELET_REASSEMBLE, by itself, creates a new VIBRATIONDATA_WAVELET_REASSEMBLE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_WAVELET_REASSEMBLE returns the handle to a new VIBRATIONDATA_WAVELET_REASSEMBLE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_WAVELET_REASSEMBLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_WAVELET_REASSEMBLE.M with the given input arguments.
%
%      VIBRATIONDATA_WAVELET_REASSEMBLE('Property','Value',...) creates a new VIBRATIONDATA_WAVELET_REASSEMBLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_wavelet_reassemble_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_wavelet_reassemble_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_wavelet_reassemble

% Last Modified by GUIDE v2.5 14-Jan-2015 12:09:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_wavelet_reassemble_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_wavelet_reassemble_OutputFcn, ...
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


% --- Executes just before vibrationdata_wavelet_reassemble is made visible.
function vibrationdata_wavelet_reassemble_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_wavelet_reassemble (see VARARGIN)

% Choose default command line output for vibrationdata_wavelet_reassemble
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_wavelet_reassemble wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_wavelet_reassemble_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig_num=1;

try
    FS=get(handles.edit_input_array,'String');
    WT=evalin('base',FS);
catch
    warndlg('Wavelet table does not exist');
    return;    
end

sz=size(WT);

nform=get(handles.listbox_format,'Value');

if(nform==1 || nform==2)
    if(sz(2)~=5)
        warndlg('Input Table does not have five columns');
        return;
    end
end    

if(nform==3 || nform==4)
    if(sz(2)~=4)
        warndlg('Input Table does not have four columns');
        return;
    end
end   

if(nform==1)
    freq=WT(:,2);
    accel=WT(:,3);
    NHS=int8(WT(:,4));
    delay=WT(:,5);
end

if(nform==2)
    accel=WT(:,2);
    freq=WT(:,3);
    NHS=int8(WT(:,4));
    delay=WT(:,5);
end

if(nform==3)
    freq=WT(:,1);
    accel=WT(:,2);
    NHS=int8(WT(:,3));
    delay=WT(:,4);
end

if(nform==4)
    accel=WT(:,1);
    freq=WT(:,2);
    NHS=int8(WT(:,3));
    delay=WT(:,4);
end

nw=sz(1);

dur=0;

te=zeros(nw,1);

for i=1:nw
    
    te(i)=delay(i) + (double(NHS(i))/(2*freq(i)));
    
    if(te(i)>dur)
        dur=te(i);
    end
   
end



%%%%%%%%%%%%%%%%%

max_wf=max(freq);

sr=20*max_wf;
dt=1/sr;

num=1+ceil(dur/dt);

tt=zeros(num,1);
acc=zeros(num,1);
vel=zeros(num,1);
dispx=zeros(num,1);

for i=1:num
    tt(i)=(i-1)*dt;
end    

omega=2*pi*freq;

for j=1:nw
    
    om=omega(j);
    om2=om^2;

    for i=1:num
        
        if(tt(i)>=delay(j) && tt(i)<=te(j))
            
            tx=tt(i)-delay(j);
            
            arg=om*tx;   
            
            
            dnhs=double(NHS(j));
 
            alpha=om/dnhs; 
            beta=om;   
            
            apb=alpha+beta;
            amb=alpha-beta;
            
            apbtx=apb*tx;
            ambtx=amb*tx;
            
            tapb=2*apb;
            tamb=2*amb;
            
            tapb2=2*apb^2;
            tamb2=2*amb^2;            
            
         
              acc(i)=  acc(i)+accel(j)*sin(arg)*sin(arg/dnhs);
              
              vel(i)=  vel(i)+accel(j)*(  -(sin(apbtx)/tapb) + (sin(ambtx)/tamb) );
              
            dispx(i)=dispx(i)+accel(j)*(  ((cos(apbtx)-1)/tapb2) - ((cos(ambtx)-1)/tamb2) );
            
        end    
        if(tt(i)>te(j))
            break;
        end
    
    end

end

%%%%%%%%%%%%%%%%

iunit=get(handles.listbox_units,'Value');

if(iunit==1)
    vel=vel*386;
    dispx=dispx*386;
end
if(iunit==2)
    vel=vel*9.81;
    dispx=dispx*1000;
end
if(iunit==3)
    dispx=dispx*1000;
end

%%%%%%%%%%%%%%%%

acceleration=[tt acc];
velocity=[tt vel];
displacement=[tt dispx];

%%%%%%%%%%%%%%%%%

ffmin=str2num(get(handles.edit_ffmin,'String'));
ffmax=str2num(get(handles.edit_ffmax,'String'));

Q=10;
damp=1/(2*Q);

octave=(2.^(1./12.));

i=1;


rf(1)=ffmin;

while(1)
    i=i+1;
    rf(i)=rf(i-1)*octave;
    
    if(rf(i)>=ffmax || i>500)
        break;
    end
end



[a1,a2,b1,b2,b3,~,~,~,~,~]=srs_coefficients(rf,damp,dt);

nfreq=length(rf);

xmax=zeros(nfreq,1);
xmin=zeros(nfreq,1);
xabs=zeros(nfreq,1);

yy=acc;

for j=1:nfreq
       
        clear resp;
        clear forward;
        clear back;
       
        forward=[ b1(j),  b2(j),  b3(j) ];    
        back   =[     1, -a1(j), -a2(j) ];    
%    
        resp=filter(forward,back,yy);
%
        xmax(j)= abs(max(resp));
        xmin(j)= abs(min(resp));
        
        aaa=[xmax(j) xmin(j)];
        
        xabs(j)=max(aaa);

end



%%%%%%%%%%%%%%%%

setappdata(0,'displacement',displacement); 
setappdata(0,'velocity',velocity); 
setappdata(0,'acceleration',acceleration); 

%%%% setappdata(0,'shock_response_spectrum',shock_response_spectrum); 

%%%%%%%%%%%%%%%%

figure(fig_num)
fig_num=fig_num+1;
plot(acceleration(:,1),acceleration(:,2));
title('Wavelet Series Acceleration');
 
if(iunit<=2)
    ylabel('Accel(G)');
else
    ylabel('Accel(m/sec^2)');    
end    
 
xlabel('Time(sec)');
grid on;

%%%%%

figure(fig_num)
fig_num=fig_num+1;
plot(velocity(:,1),velocity(:,2));
title('Wavelet Series Velocity');
if(iunit==1)
        ylabel('Velocity(in/sec)');
else
        ylabel('Velocity(m/sec)'); 
end
xlabel('Time(sec)');
grid on;

%%%%%

figure(fig_num)
fig_num=fig_num+1;
plot(displacement(:,1),displacement(:,2));
title('Wavelet Series Displacement');
if(iunit==1)
        ylabel('Disp(inch)');
else
        ylabel('Disp(mm)');
end
xlabel('Time(sec)');
grid on;
%

%%%%%%%%%%%%%%%%

if(iunit<=2)
    y_lab='Accel(G)';
else
    y_lab='Accel(m/sec^2)';    
end  

t_string='Shock Response Spectrum Q=10';

[fig_num]=srs_plot_function(fig_num,rf,xmax,xmin,t_string,y_lab,ffmin,ffmax);

%%%%%%%%%%%%%%%%

set(handles.uipanel_save,'Visible','on');

% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_save,'value');

if(n==1)
    data=getappdata(0,'acceleration');
end
if(n==2)
    data=getappdata(0,'velocity');
end
if(n==3)
    data=getappdata(0,'displacement');
end
if(n==4)
    data=getappdata(0,'shock_response_spectrum');
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



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
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



function edit_ffmin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ffmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ffmin as text
%        str2double(get(hObject,'String')) returns contents of edit_ffmin as a double


% --- Executes during object creation, after setting all properties.
function edit_ffmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ffmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ffmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ffmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ffmax as text
%        str2double(get(hObject,'String')) returns contents of edit_ffmax as a double


% --- Executes during object creation, after setting all properties.
function edit_ffmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ffmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_format.
function listbox_format_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_format contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_format


% --- Executes during object creation, after setting all properties.
function listbox_format_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function varargout = sine_sweep_transmissibility(varargin)
% SINE_SWEEP_TRANSMISSIBILITY MATLAB code for sine_sweep_transmissibility.fig
%      SINE_SWEEP_TRANSMISSIBILITY, by itself, creates a new SINE_SWEEP_TRANSMISSIBILITY or raises the existing
%      singleton*.
%
%      H = SINE_SWEEP_TRANSMISSIBILITY returns the handle to a new SINE_SWEEP_TRANSMISSIBILITY or the handle to
%      the existing singleton*.
%
%      SINE_SWEEP_TRANSMISSIBILITY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SINE_SWEEP_TRANSMISSIBILITY.M with the given input arguments.
%
%      SINE_SWEEP_TRANSMISSIBILITY('Property','Value',...) creates a new SINE_SWEEP_TRANSMISSIBILITY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sine_sweep_transmissibility_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sine_sweep_transmissibility_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sine_sweep_transmissibility

% Last Modified by GUIDE v2.5 04-Nov-2016 15:58:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sine_sweep_transmissibility_OpeningFcn, ...
                   'gui_OutputFcn',  @sine_sweep_transmissibility_OutputFcn, ...
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


% --- Executes just before sine_sweep_transmissibility is made visible.
function sine_sweep_transmissibility_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sine_sweep_transmissibility (see VARARGIN)

% Choose default command line output for sine_sweep_transmissibility
handles.output = hObject;



set(handles.listbox_format,'Value',1);
set(handles.listbox_method,'Value',1);

set(handles.pushbutton_calculate,'Enable','off');

set(handles.text_IAN_2,'Visible','off');
set(handles.edit_input_array_2,'Visible','off');
set(handles.edit_input_array_2,'String','');

set(handles.text_IAN_1,'Visible','on');
set(handles.edit_input_array_1,'Visible','on');
set(handles.text_IAN_1,'String','Input Array Name');

set(handles.uipanel_save,'visible','off');

try
    close 1
end
try
    close 2
end
try
    close 3
end
try
    close 4
end
try
    close 5
end
try
    close 6
end
try
    close 7
end
try
    close 8
end
try
    close 9
end
try
    close 10
end
try
    close 11
end
try
    close 12
end



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sine_sweep_transmissibility wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sine_sweep_transmissibility_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_input_array_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method
mn_common(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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
mn_common(hObject, eventdata, handles);

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



function edit_input_array_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_read_data.
function pushbutton_read_data_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_read_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
 
    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end   


YS=get(handles.edit_ylabel,'String');

n=get(handles.listbox_format,'Value');
m=get(handles.listbox_method,'Value');

if(m==1)
%
   FS=get(handles.edit_input_array_1,'String');
   THM_1=evalin('base',FS); 
%
   if(n==1)
      t1=THM_1(:,1);
      t2=t1;      
       a=THM_1(:,2);
       b=THM_1(:,3);
   else
%     
       FS=get(handles.edit_input_array_2,'String');
       THM_2=evalin('base',FS);
%     
       t1=THM_1(:,1);
       t2=THM_2(:,1);
       a=THM_1(:,2);
       b=THM_2(:,2);       
   end
end

if(m==2)
%     
   THM_1=getappdata(0,'THM_1');
%   
   if(n==1)     
     t1=THM_1(:,1);
     t2=t1;
     a=THM_1(:,2);
     b=THM_1(:,3);
   else
%
     THM_2=getappdata(0,'THM_2');
%
       t1=THM_1(:,1);
        a=THM_1(:,2);
       t2=THM_2(:,1);
        b=THM_2(:,2);    
   end
end


%%


figure(1);
plot(t1,a);
grid on;
xlabel('Time(sec)');
ylabel(YS);
title('Input Signal');

figure(2);
plot(t2,b);
grid on;
xlabel('Time(sec)');
ylabel(YS);
title('Response Signal');


figure(3);
plot(t1,a,t2,b);
grid on;
xlabel('Time(sec)');
ylabel(YS);
legend('Input','Response');
title('Sine Sweep Time Histories');

%%%

if(m==1)
   num=length(t1);
   dt=(t1(num)-t1(1))/(num-1);
else
   num1=length(t1);
   dt1=(t1(num1)-t1(1))/(num1-1);   
%   
   num2=length(t2);
   dt2=(t2(num2)-t2(1))/(num2-1);  
%
%  Truncate if necessary
%
    if(num1<num2)
        num2=num1;
    end
    if(num2<num1)
        num1=num2;
    end
    num=num1;
%
    pe=abs((dt1-dt2)/dt1);
%
    dt=(dt1+dt2)/2;
%
    if(pe>0.01)
        out1=sprintf('Warning: dt1=%8.4g  dt2=%8.4g ',dt1,dt2);
        msgbox(out1,'Warning','warn');
    end 
%
end
%
THM_C=[t1(1:num) a(1:num) b(1:num)];

setappdata(0,'THM_C',THM_C);
      
set(handles.pushbutton_calculate,'Enable','on');




% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(sine_sweep_transmissibility);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


try
    close 4
end
try
    close 5
end

tpi=2*pi;

fig_num=4;

ncalc=get(handles.listbox_calculate,'Value');

ylab=get(handles.edit_ylabel,'String');

THM=getappdata(0,'THM_C');

t=THM(:,1);
a=THM(:,2);
b=THM(:,3);

num=length(t);

%
%   positive slope zero crossing times for input
%

k=1;
for i=2:num
    if( a(i) > a(i-1) && a(i) > 0 && a(i-1) <=0)
        tindex(k)=i;
        L=a(i)-a(i-1);
        c1=a(i)/L;
        c2=1-c1;
        tz(k)=c1*t(i-1)+c2*t(i);
        k=k+1;
    end
end

nt=k-1;   % number of positive slope zero crossings

step=round(str2num(get(handles.edit_step,'String')));   % with sliding window

m=1;
for i=(step+1):nt
    m=m+1;
end
m=m-2;  % leave
 
aa=zeros(m,1);
bb=zeros(m,1);
trans=zeros(m,1);
f=zeros(m,1);
phase=zeros(m,1);
    
progressbar;

disp(' ref 3 ');

m=1;
for i=(step+1):nt
    
    progressbar(i/nt);
    
    kk=tindex(i);
    jj=tindex(i-step);
    T=(tz(i)-tz(i-step))/step;
    f(m)=1/T;
    aa(m)=std(a(jj:kk));
    bb(m)=std(b(jj:kk));
    trans(m)=bb(m)/aa(m);
    
    if(ncalc==2)
        
        omega=tpi*f(m);
    
        [~,~,~,~,~,x3a,~]=sine_lsf_function(a(jj:kk),t(jj:kk),omega);
        [~,~,~,~,~,x3b,~]=sine_lsf_function(b(jj:kk),t(jj:kk),omega);
        
        
        phase(m)=x3a-x3b;
        
        if(phase(m)<0.)
            phase(m)=phase(m)+tpi;
        end
    
    end    
    
    m=m+1;
end

pause(0.2);
progressbar(1);

phase=(180/pi)*phase;

disp(' ref 4 ');

figure(fig_num);
fig_num=fig_num+1;

plot(f,trans);
title('Sine Sweep Transmissibility');
xlabel('Frequency (Hz)');

k = strfind(ylab, 'G');

if( k>=1 )
    ylabel('Trans (G/G)');
else
    ylabel('Trans');
end    
grid on;

xl = xlim;
fmin=xl(1);
fmax=xl(2);



trans=[f trans];
setappdata(0,'trans',trans);

disp(' ref 5 ');

if(ncalc==2)
    
    trans_phase=[trans phase];
    
    phase=[f phase];
    
    setappdata(0,'phase',phase);
    setappdata(0,'trans_phase',trans_phase);
    
    t_string='Sine Sweep Magnitude & Phase';
    
    ff=f;
    FRF_p=phase(:,2);
    FRF_m=trans(:,2);
    ylab='Accel (G)';
    md=4;
    
    [fig_num]=...
    plot_magnitude_phase_function_linear(fig_num,t_string,fmin,fmax,ff,FRF_p,FRF_m,ylab,md);
    
end

[fmax,amax]=find_max(trans);

disp(' ');
disp('* * * * * * * * * ');
disp(' ');

out1=sprintf('\n  Maximum Transmissibility: (%8.4g Hz, %8.4g) \n',amax,fmax);
disp(out1);


msgbox('Calculation complete');

set(handles.uipanel_save,'visible','on');


function edit_ylabel_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ylabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ylabel as text
%        str2double(get(hObject,'String')) returns contents of edit_ylabel as a double


% --- Executes during object creation, after setting all properties.
function edit_ylabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ylabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function mn_common(hObject, eventdata, handles)

set(handles.pushbutton_calculate,'Enable','off');

set(handles.text_IAN_1,'Visible','off');
set(handles.text_IAN_2,'Visible','off');
set(handles.edit_input_array_1,'Visible','off');
set(handles.edit_input_array_2,'Visible','off');
set(handles.edit_input_array_1,'String','');
set(handles.edit_input_array_2,'String','');


n=get(handles.listbox_format,'Value');
m=get(handles.listbox_method,'Value');

if(n==1 && m==1)
    set(handles.text_IAN_1,'Visible','on');
    set(handles.edit_input_array_1,'Visible','on');
    set(handles.edit_text_IAN_1,'String','Input Array Name');
end
if(n==2 && m==1)
    set(handles.text_IAN_1,'Visible','on');
    set(handles.text_IAN_2,'Visible','on');
    set(handles.edit_input_array_1,'Visible','on');
    set(handles.edit_input_array_2,'Visible','on');
    set(handles.text_IAN_1,'String','Input Array Name');
    set(handles.text_IAN_2,'String','Response Array Name');    
end
if(m==2)
%
   if(n==1)
%
      [filename, pathname] = uigetfile('*.*','Select the time history file.');
      filename = fullfile(pathname, filename);
      fid = fopen(filename,'r');
%
      THM_1 = fscanf(fid,'%g %g %g',[3 inf]);
      THM_1=THM_1';
      setappdata(0,'THM_1',THM_1);   
      sz=size(THM_1);
      if(sz(2)~=3)
         errordlg('Input array does not have three columns.','File Error');      
      end
   else
%
      [filename, pathname] = uigetfile('*.*','Select the first time history file.');
      filename = fullfile(pathname, filename);
      fid_1 = fopen(filename,'r');
%
      THM_1 = fscanf(fid_1,'%g %g',[2 inf]);
      THM_1=THM_1';
      setappdata(0,'THM_1',THM_1);
      sz=size(THM_1);
      if(sz(2)~=2)
         errordlg('Input array does not have two columns.','File Error');          
      end      
 %
      [filename, pathname] = uigetfile('*.*','Select the second time history file.');
      filename = fullfile(pathname, filename);
      fid_2 = fopen(filename,'r');
%
      THM_2 = fscanf(fid_2,'%g %g',[2 inf]);
      THM_2=THM_2';
      setappdata(0,'THM_2',THM_2);
      sz=size(THM_2);
      if(sz(2)~=2)
         errordlg('Input array does not have two columns.','File Error');          
      end   
 %
   end
%
end


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_calculate,'Value');

if(n==1)
    data=getappdata(0,'trans');
else
    data=getappdata(0,'trans_phase');    
end
    
output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

if(n==1)
    h = msgbox('Transmissibility Save Complete.');
else
    h = msgbox('Transmissibility & Phase Save Complete.');
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


% --- Executes on selection change in listbox_calculate.
function listbox_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_calculate contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_calculate


% --- Executes during object creation, after setting all properties.
function listbox_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_step_Callback(hObject, eventdata, handles)
% hObject    handle to edit_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_step as text
%        str2double(get(hObject,'String')) returns contents of edit_step as a double


% --- Executes during object creation, after setting all properties.
function edit_step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

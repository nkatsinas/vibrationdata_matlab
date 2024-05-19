function varargout = waterfall_SRS(varargin)
% WATERFALL_SRS MATLAB code for waterfall_SRS.fig
%      WATERFALL_SRS, by itself, creates a new WATERFALL_SRS or raises the existing
%      singleton*.
%
%      H = WATERFALL_SRS returns the handle to a new WATERFALL_SRS or the handle to
%      the existing singleton*.
%
%      WATERFALL_SRS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WATERFALL_SRS.M with the given input arguments.
%
%      WATERFALL_SRS('Property','Value',...) creates a new WATERFALL_SRS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before waterfall_SRS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to waterfall_SRS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help waterfall_SRS

% Last Modified by GUIDE v2.5 30-Mar-2017 20:51:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @waterfall_SRS_OpeningFcn, ...
                   'gui_OutputFcn',  @waterfall_SRS_OutputFcn, ...
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


% --- Executes just before waterfall_SRS is made visible.
function waterfall_SRS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to waterfall_SRS (see VARARGIN)

% Choose default command line output for waterfall_SRS
handles.output = hObject;

%% %%   set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes waterfall_SRS wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = waterfall_SRS_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method

%% %%   set(handles.uipanel_save,'Visible','off');

n=get(hObject,'Value');

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');

set(handles.edit_input_array,'String',' ');

if(n==1)
   set(handles.edit_input_array,'enable','on') 
else
    
   set(handles.text_input_array_name,'Visible','off');
   set(handles.edit_input_array,'Visible','off');

   set(handles.edit_input_array,'enable','off')
   
   [filename, pathname] = uigetfile('*.*');
   filename = fullfile(pathname, filename);
   fid = fopen(filename,'r');
   THM = fscanf(fid,'%g %g',[2 inf]);
   THM=THM';
    
   setappdata(0,'THM',THM);
end

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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

k=get(handles.listbox_method,'Value');

p=get(handles.listbox_overlap,'Value');

po=(p-1)*0.1;


if(k==1)
  FS=get(handles.edit_input_array,'String');
  THM=evalin('base',FS);   
else
  THM=getappdata(0,'THM');
end

seg=str2num(get(handles.edit_segment_duration,'String'));

if(isempty(seg))
   warndlg('Enter Segment Duration'); 
   return; 
end


tstart=str2num(get(handles.edit_tstart,'String'));

if(isempty(tstart))
   warndlg('Enter Start Time'); 
   return; 
end


tend=str2num(get(handles.edit_tend,'String'));

if(isempty(tend))
   warndlg('Enter End Time'); 
   return; 
end



fstart=str2num(get(handles.edit_fstart,'String'));

if(isempty(fstart))
   warndlg('Enter Start Frequency'); 
   return; 
end


fend=str2num(get(handles.edit_fend,'String'));

if(isempty(fend))
   warndlg('Enter End Frequency'); 
   return; 
end


Q=str2num(get(handles.edit_Q,'String'));

if(isempty(Q))
   warndlg('Enter Q'); 
   return; 
end

damp=1/(2*Q);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

aaa=THM(:,2);
ttt=THM(:,1);

nn = size(aaa);
n = nn(1);

j=1;
for i=1:n
   if(tstart>ttt(i))
      j=i;
      break;
   end   
end

amp=aaa(j:n);
tim=ttt(j:n);

nn = size(amp);
n = nn(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mu=mean(amp);
sd=std(amp);
mx=max(amp);
mi=min(amp);
rms=sqrt(sd^2+mu^2);

disp(' ')
disp(' time stats ')
disp(' ')
tmx=max(tim);
tmi=min(tim);

dt=(tmx-tmi)/n;
sr=1./dt;
out4 = sprintf(' SR  = %8.4g samples/sec    dt = %8.4g sec            ',sr,dt);
out5 = sprintf('\n number of samples = %d  ',n);

disp(out4)
disp(out5)
disp(' ')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fspace=get(handles.listbox_spacing,'Value');

fn(1)=fstart;

if(fstart<0.1)
    fn(1)=1;
end

fmax=sr/8;

num=1;

if(fspace==1)

    oct=2^(1/12);

    while(1)
    
        num=num+1;
  
        fn(num)=fn(num-1)*oct;
  
        if(fn(num)>fmax)
            break;
        end
    
    end

end
if(fspace==2)

    oct=2^(1/24);

    while(1)
    
        num=num+1;
  
        fn(num)=fn(num-1)*oct;
  
        if(fn(num)>fmax)
            break;
        end
    
    end

end
if(fspace==2)

    oct=2^(1/24);

    while(1)
    
        num=num+1;
  
        fn(num)=fn(num-1)*oct;
  
        if(fn(num)>fmax)
            break;
        end
    
    end

end

if(fspace==3)
    
    oct=2^(1/48);
    
    while(1)
    
        num=num+1;
  
        fn(num)=fn(num-1)*oct;
  
        if(fn(num)>fmax)
            break;
        end
    
    end
end    
if(fspace==4)
    
    while(1)
    
        num=num+1;
  
        fn(num)=fn(num-1)+1.0;
  
        if(fn(num)>fmax)
            break;
        end
    
    end
end  
if(fspace==5)
    
    while(1)
    
        num=num+1;
  
        fn(num)=fn(num-1)+0.5;
  
        if(fn(num)>fmax)
            break;
        end
    
    end
end    

num_fn=num;
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f=fn;

[a1,a2,b1,b2,b3,rd_b1,rd_b2,rd_b3,rv_b1,rv_b2,rv_b3,ra_b1,ra_b2,ra_b3]=...
                                      srs_coefficients_base(f,damp,dt);  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


ns=fix(sr*seg);
%
out1=sprintf(' ns=%d ',ns);
disp(out1);

step=floor(ns*(1-po));


i=1;
j1=1;
j2=1+ns;

while(1)

    if((j2)>n)
        break;
    end
    
    j1=j1+step;
    j2=j2+step;
    
    i=i+1;
    
    if(i>500000)
        break;
    end    
    
end 

nnn=i;


disp(' ');
out1=sprintf('\n nnn=%d  step=%d\n',nnn,step);
disp(out1);


if(nnn==0)
    warndlg('nnn=0');
    return;
end
if(step==0)
    warndlg('step=0');
    return;
end
if(nnn>500000)
    warndlg('nnn>500000');
    return;
end


%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
tpi=2*pi;

store_p=zeros(nnn,num_fn);

time_a=zeros(nnn,1);

%
j1=1;
j2=1+ns;

progressbar;

for i=1:nnn
    
    progressbar(i/nnn);
   
    if(j2>n)
        break;
    end
%
    clear x;
   
    time_a(i)=mean(tim(j1:j2));
    
    x=amp(j1:j2);
    
    nx=length(x);
      
    if(isempty(x))
        break;
    end

%%%%     

   asrs=zeros(num_fn,1);

   for j=1:num_fn
       
       omegan=tpi*fn(j);
       domegan=damp*omegan;
       omegad=omegan*sqrt(1-damp^2);
%
%   Relative Displacement Response   
%
        rd_forward=[ rd_b1(j),  rd_b2(j),  rd_b3(j) ];    
        rd_back   =[     1, -a1(j), -a2(j) ];     
%    
        rd=filter(rd_forward,rd_back,x);
        rd_last=rd(nx);
%
%   Relative Velocity Response   
%
        rv_forward=[ rv_b1(j),  rv_b2(j),  rv_b3(j) ];    
        rv_back   =[     1, -a1(j), -a2(j) ];     
%    
        rv=filter(rv_forward,rv_back,x);
        rv_last=rv(nx);        

%
%   Relative Acceleration   
%
        ra_forward=[ ra_b1(j),  ra_b2(j),  ra_b3(j) ];    
        ra_back   =[     1, -a1(j), -a2(j) ];     
%    
        ra=filter(ra_forward,ra_back,x);         
        
        rd_free=zeros(ns,1);
        rv_free=zeros(ns,1);
        
        d0=rd_last;
        v0=rv_last;  
        c=(v0+domegan*d0)/omegad;        
        
%%        out1=sprintf('fn=%8.4g  do=%8.4g  vo=%8.4g ',fn(j),d0,v0);
%%        disp(out1);
        
        
        for k=1:nx
            
            ttt=(k-1)*dt;
            
            t1=-domegan*ttt;
            t2=  omegad*ttt;
%
            rd_free(k)=exp(t1).*( d0*cos(t2) + c*sin(t2));
            rv_free(k)=-domegan*rd_free(k) + omegad*exp(t1).*( -d0*sin(t2) + c*cos(t2));            
            
        end
        
        free_accel= -(2.*domegan)*rv_free -(omegan^2)*rd_free;
        
        ra=ra+free_accel;
        
        aa=ra+x;
        
        asrs(j)=max( [ max(aa) abs(min(aa)) ] );
        
   end
   
   store_p(i,:)=asrs;

   
%%%%
    j1=j1+step;
    j2=j2+step;
% 
end

pause(0.3);
progressbar(1);


%
fig_num=1;
figure(fig_num);
fig_num=fig_num+1;

plot(tim,amp)
xlabel('Time (sec)');
ylabel('Accel (G)');
grid on;
title('Time History');

%

freq_p=fn;


figure(2);
h2=figure(fig_num);
fig_num=fig_num+1;





waterfall(freq_p,time_a,store_p);  
set(gcf,'renderer','OpenGL' );
colormap(hsv(1));
hXLabel=xlabel(' Natural Frequency (Hz)');
hYLabel=ylabel(' Time (sec)'); 
hZLabel=zlabel(' Peak Accel (G)'); 
sss=sprintf('Waterfall SRS Q=%g',Q);
hTitle=title(sss);
view([-15 70]);   
% Adjust font
set(gca, 'FontName', 'Helvetica')
set([hTitle, hXLabel, hYLabel, hZLabel], 'FontName', 'AvantGarde')
set([hXLabel, hYLabel, hZLabel], 'FontSize', 11)
set(hTitle, 'FontSize', 12, 'FontWeight' , 'bold')
set(gca,'xlim',[fstart fend])


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    close fig_num hidden
end 
figure(fig_num);
fig_num=fig_num+1;
colormap(hsv(128));
surf(freq_p,time_a,store_p,'edgecolor','none')
colormap(jet); axis tight;
view(0,90);
set(gca,'xlim',[fstart fend])
ylabel('Time (sec)'); 
xlabel('Natural Frequency (Hz)');
sss=sprintf('Spectrogram  SRS Q=%g',Q);
title(sss);
%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%% set(handles.uipanel_save,'Visible','on');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(waterfall_SRS)


function edit_segment_duration_Callback(hObject, eventdata, handles)
% hObject    handle to edit_segment_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_segment_duration as text
%        str2double(get(hObject,'String')) returns contents of edit_segment_duration as a double


% --- Executes during object creation, after setting all properties.
function edit_segment_duration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_segment_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_yaxis_label_Callback(hObject, eventdata, handles)
% hObject    handle to edit_yaxis_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_yaxis_label as text
%        str2double(get(hObject,'String')) returns contents of edit_yaxis_label as a double


% --- Executes during object creation, after setting all properties.
function edit_yaxis_label_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_yaxis_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_overlap.
function listbox_overlap_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_overlap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_overlap contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_overlap
%%   set(handles.uipanel_save,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_overlap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_overlap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_segment_duration and none of its controls.
function edit_segment_duration_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_segment_duration (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
%%   set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
%%   set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_yaxis_label and none of its controls.
function edit_yaxis_label_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_yaxis_label (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
%%   set(handles.uipanel_save,'Visible','off');


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_function,'Value');
n

if(n==1)
    data=getappdata(0,'peak');    
end
if(n==2)
    data=getappdata(0,'RMS');    
end
if(n==3)
    data=getappdata(0,'stddev');    
end
if(n==4)
    data=getappdata(0,'mean');    
end
if(n==5)
    data=getappdata(0,'frequency');    
end


output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 




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


% --- Executes on selection change in listbox_function.
function listbox_function_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_function (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_function contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_function


% --- Executes during object creation, after setting all properties.
function listbox_function_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_function (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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


% --- Executes on selection change in listbox_spacing.
function listbox_spacing_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_spacing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_spacing contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_spacing


% --- Executes during object creation, after setting all properties.
function listbox_spacing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_spacing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_tstart_Callback(hObject, eventdata, handles)
% hObject    handle to edit_tstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_tstart as text
%        str2double(get(hObject,'String')) returns contents of edit_tstart as a double


% --- Executes during object creation, after setting all properties.
function edit_tstart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_tstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_tend_Callback(hObject, eventdata, handles)
% hObject    handle to edit_tend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_tend as text
%        str2double(get(hObject,'String')) returns contents of edit_tend as a double


% --- Executes during object creation, after setting all properties.
function edit_tend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_tend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

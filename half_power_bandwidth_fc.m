function varargout = half_power_bandwidth_fc(varargin)
% HALF_POWER_BANDWIDTH_FC MATLAB code for half_power_bandwidth_fc.fig
%      HALF_POWER_BANDWIDTH_FC, by itself, creates a new HALF_POWER_BANDWIDTH_FC or raises the existing
%      singleton*.
%
%      H = HALF_POWER_BANDWIDTH_FC returns the handle to a new HALF_POWER_BANDWIDTH_FC or the handle to
%      the existing singleton*.
%
%      HALF_POWER_BANDWIDTH_FC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HALF_POWER_BANDWIDTH_FC.M with the given input arguments.
%
%      HALF_POWER_BANDWIDTH_FC('Property','Value',...) creates a new HALF_POWER_BANDWIDTH_FC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before half_power_bandwidth_fc_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to half_power_bandwidth_fc_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help half_power_bandwidth_fc

% Last Modified by GUIDE v2.5 22-Jul-2013 08:40:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @half_power_bandwidth_fc_OpeningFcn, ...
                   'gui_OutputFcn',  @half_power_bandwidth_fc_OutputFcn, ...
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


% --- Executes just before half_power_bandwidth_fc is made visible.
function half_power_bandwidth_fc_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to half_power_bandwidth_fc (see VARARGIN)

% Choose default command line output for half_power_bandwidth_fc
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes half_power_bandwidth_fc wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = half_power_bandwidth_fc_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function clear_results(hObject, eventdata, handles)

set(handles.edit_fn,'String',' ');
set(handles.edit_damping_ratio,'String',' ');
set(handles.edit_Q,'String',' ');

set(handles.edit_fn,'Enable','off');
set(handles.edit_damping_ratio,'Enable','off');
set(handles.edit_Q,'Enable','off');



% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iresp=get(handles.listbox_response,'Value');

m=get(handles.listbox_method,'Value');

if(m==1)
   FS=get(handles.edit_input_array,'String');
   THF=evalin('base',FS); 
else
   THF=getappdata(0,'THF');    
end 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sz=size(THF);

if(sz(2)==2)
    f=THF(:,1);
    frf_r=real(THF(:,2));
    frf_i=imag(THF(:,2));    
end
if(sz(2)==3)
    f=THF(:,1);
    frf_r=THF(:,2);
    frf_i=THF(:,3);     
end

n=length(f);

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(iresp==1)
%
   tlabel='Acceleration';
   yl='Accel/Force';
%    
   MFRF_R=@(omega,rho,damp)(real(-omega^2/((1-rho^2)+(1i)*(2*damp*rho)))); 
   MFRF_I=@(omega,rho,damp)(imag(-omega^2/((1-rho^2)+(1i)*(2*damp*rho)))); 
%      
end
%
if(iresp==2)
%
   tlabel='Velocity';
   yl='Velocity/Force';   
   
%    
   MFRF_R=@(omega,rho,damp)(real((1i)*omega/((1-rho^2)+(1i)*(2*damp*rho))));
   MFRF_I=@(omega,rho,damp)(imag((1i)*omega/((1-rho^2)+(1i)*(2*damp*rho))));   
%        
end
%
if(iresp==3)
%
   tlabel='Displacement';
   yl='Disp/Force';   
%
   MFRF_R=@(omega,rho,damp)(real(1/((1-rho^2)+(1i)*(2*damp*rho))));    
   MFRF_I=@(omega,rho,damp)(imag(1/((1-rho^2)+(1i)*(2*damp*rho)))); 
%      
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
sfmin=get(handles.edit_fmin,'String');
sfmax=get(handles.edit_fmax,'String');

fstart=str2num(sfmin); 
fend=str2num(sfmax);

df=fend-fstart;

if isempty(sfmin)
    string=sprintf('%7.3g',df);
    set(handles.edit_fmin,'String',string); 
    sfmin=get(handles.edit_fmin,'String');    
end

if isempty(sfmax)
    sr=1/dt;
    nyf=sr/2;    
    string=sprintf('%7.3g',max(freq));
    set(handles.edit_fmax,'String',string);
    sfmax=get(handles.edit_fmax,'String');    
end

fstart=str2num(sfmin);  % again
fend=str2num(sfmax);

df=fend-fstart;

%
%
if(fstart<min(f))
    fstart=min(f);
end
if(fend>max(f))
    fend=max(f);
end
%

nt=str2num(get(handles.edit_number_trials,'String'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
for i=1:n
    if(f(i)>=fstart)
        i1=i;
        break;
    end
end
%
for i=1:n
    if(f(i)>fend)
        i2=i-1;
        break;
    end
end
%
maxa=0;
%
for i=i1:i2
    if( sqrt(frf_r(i)^2+frf_i(i)^2 )>maxa)
        maxa=sqrt(frf_r(i)^2+frf_i(i)^2 );
        maxf=f(i);
    end
end
%
tpi=2*pi;
%
df=fend-fstart;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
error_max=1.0e+90;
%
omega=tpi*f;
%
Ar=0;
Axr=0;
fnr=0;
dampr=0;
fstart
fend
df
maxf
%
disp(' ');
disp('  i     A     fn     damp ');
for i=1:nt
%    
    if(i<5 || rand()<0.8)
%        
        A=(0.6+0.8*rand());
        if(rand()<0.3)
            A=-A;
        end
%        
        if(rand()<0.5)
            damp=0.5*(rand())^2;
        else
            damp=0.1*(rand());           
        end
%        
        if(rand()<0.5)
            fn=fstart+df*rand();
        else
            fn=maxf;
        end    
%
    else
        if(rand()<0.4)
              fn=fnr*(0.995+0.01*rand());  
          damp=dampr*(0.99+0.02*rand());       
                A=Ar*(0.995+0.01*rand());
        else
            if(rand()<0.5)
                   fn=fnr*(0.995+0.01*rand());
            else
               damp=dampr*(0.995+0.01*rand());                  
            end
        end
    end
%
    if(fn<fstart || fn>fend)
        fn=maxf;
    end
%
    if(A<0.2 || A>5)
        A=maxa*(0.8+0.4*rand());
    end
%
    if(damp>0.5)
        damp=0.5*(rand())^2;        
    end
%
    error=0;
%
    omegan=tpi*fn;
%
    c_r=zeros(i2,1);
    c_i=zeros(i2,1);
%
    for j=i1:i2
        omega=tpi*f(j);
        rho=omega/omegan;
        c_r(j)=MFRF_R(omega,rho,damp);
        c_i(j)=MFRF_I(omega,rho,damp);       
    end
%    
    AX=A*maxa/max([max(abs(c_r)) max(abs(c_i))]);
    c_r=AX*c_r;
    c_i=AX*c_i;
%
    for j=i1:i2
        bbb=abs((frf_r(j)-c_r(j)))+abs((frf_i(j)-c_i(j)));
        error=error+bbb;
    end
%
    if(error<error_max)
%        
        error_max=error;
             dampr=damp;
              fnr=fn;
               Ar=A;
              Axr=AX;
              cr=c_r;
              ci=c_i;
%
        out1=sprintf(' %d  %8.4g  %8.4g  %8.4g',i,A,fn,damp);
        disp(out1);
%
        k=1;
%
        nv=i2-i1+1;
        fr=zeros(nv,1);
        ar=zeros(nv,1);
        ai=zeros(nv,1);
%
        for j=i1:i2
%        
            fr(k)=f(j);
            ar(k)=cr(j);
            ai(k)=ci(j);
            k=k+1;
%
        end
%
        fig_num=2;
        figure(fig_num);
        subplot(2,1,1);
        plot(f(i1:i2),frf_r(i1:i2),fr,ar);
        grid on;
        legend('Measured Data','Curve-fit');
        xlabel('Frequency (Hz)');
        ylabel(yl);
        out1=sprintf('%s Real Frequency Response Function',tlabel);
        title(out1);
%
        subplot(2,1,2);
        plot(f(i1:i2),frf_i(i1:i2),fr,ai);
        grid on;
        legend('Measured Data','Curve-fit');
        xlabel('Frequency (Hz)');
        ylabel(yl);
        out1=sprintf('%s Imaginary Frequency Response Function',tlabel);
        title(out1); 
%
    end
%
end
%
Qr=1/(2*dampr);
%
disp(' ');
disp('         Results ');
disp(' ');
out1=sprintf('            fn =%8.4g Hz \n damping ratio = %8.4g \n             Q =%8.4g \n',fnr,dampr,Qr);
disp(out1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
set(handles.edit_fn,'Enable','on');
set(handles.edit_damping_ratio,'Enable','on');
set(handles.edit_Q,'Enable','on');

s1=sprintf('%7.3g',fnr);
s2=sprintf('%7.3g',dampr);
s3=sprintf('%7.3g',Qr);

set(handles.edit_fn,'String',s1);
set(handles.edit_damping_ratio,'String',s2);
set(handles.edit_Q,'String',s3);



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(half_power_bandwidth_fc);


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method
clear_results(hObject, eventdata, handles);

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
   
   tline = fgetl(fid);
   frewind(fid);
   
   sz=size(tline);
   
   if(sz(2)==2)
      THF = fscanf(fid,'%g %g',[2 inf]);
      THF=THF';
   end
   if(sz(3)==3)
      THF = fscanf(fid,'%g %g %g',[3 inf]);
      THF=THF';
   end  
 
   setappdata(0,'THF',THF);
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


% --- Executes on button press in pushbutton_plot_input_function.
function pushbutton_plot_input_function_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot_input_function (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iresp=get(handles.listbox_response,'Value');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(iresp==1)
%
   tlabel='Acceleration';
   yl='Accel/Force';
%          
end
%
if(iresp==2)
%
   tlabel='Velocity';
   yl='Velocity/Force';   
%           
end
%
if(iresp==3)
%
   tlabel='Displacement';
   yl='Disp/Force';   
%      
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%

k=get(handles.listbox_method,'Value');

if(k==1)
  FS=get(handles.edit_input_array,'String');
  THF=evalin('base',FS);   
else
  THF=getappdata(0,'THF');
end

sz=size(THF);

if(sz(2)==2)
    f=THF(:,1);
    frf_r=real(THF(:,2));
    frf_i=imag(THF(:,2));    
end
if(sz(2)==3)
    f=THF(:,1);
    frf_r=THF(:,2);
    frf_i=THF(:,3);     
end

figure(1);
plot(f,frf_r,f,frf_i);
grid on;
xlabel('Frequency (Hz)');
%
out1=sprintf('%s Frequency Response Function',tlabel);
legend('real','imaginary');
ylabel(yl);
title(out1)

set(handles.pushbutton_calculate,'Enable','on');
%



function edit_fn_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fn as text
%        str2double(get(hObject,'String')) returns contents of edit_fn as a double


% --- Executes during object creation, after setting all properties.
function edit_fn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_damping_ratio_Callback(hObject, eventdata, handles)
% hObject    handle to edit_damping_ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_damping_ratio as text
%        str2double(get(hObject,'String')) returns contents of edit_damping_ratio as a double


% --- Executes during object creation, after setting all properties.
function edit_damping_ratio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_damping_ratio (see GCBO)
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



function edit_number_trials_Callback(hObject, eventdata, handles)
% hObject    handle to edit_number_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_number_trials as text
%        str2double(get(hObject,'String')) returns contents of edit_number_trials as a double


% --- Executes during object creation, after setting all properties.
function edit_number_trials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_number_trials (see GCBO)
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


% --- Executes on selection change in listbox_response.
function listbox_response_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_response (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_response contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_response
clear_results(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_response_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_response (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_number_trials and none of its controls.
function edit_number_trials_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_number_trials (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_fmin and none of its controls.
function edit_fmin_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_fmax and none of its controls.
function edit_fmax_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);

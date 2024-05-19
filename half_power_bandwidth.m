function varargout = half_power_bandwidth(varargin)
% HALF_POWER_BANDWIDTH MATLAB code for half_power_bandwidth.fig
%      HALF_POWER_BANDWIDTH, by itself, creates a new HALF_POWER_BANDWIDTH or raises the existing
%      singleton*.
%
%      H = HALF_POWER_BANDWIDTH returns the handle to a new HALF_POWER_BANDWIDTH or the handle to
%      the existing singleton*.
%
%      HALF_POWER_BANDWIDTH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HALF_POWER_BANDWIDTH.M with the given input arguments.
%
%      HALF_POWER_BANDWIDTH('Property','Value',...) creates a new HALF_POWER_BANDWIDTH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before half_power_bandwidth_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to half_power_bandwidth_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help half_power_bandwidth

% Last Modified by GUIDE v2.5 25-Aug-2021 09:34:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @half_power_bandwidth_OpeningFcn, ...
                   'gui_OutputFcn',  @half_power_bandwidth_OutputFcn, ...
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


% --- Executes just before half_power_bandwidth is made visible.
function half_power_bandwidth_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to half_power_bandwidth (see VARARGIN)

% Choose default command line output for half_power_bandwidth
handles.output = hObject;

set(handles.listbox_method,'Value',1);
set(handles.listbox_excitation,'Value',1);
set(handles.listbox_response,'Value',1);
set(handles.listbox_amplitude_dimension,'Value',1);
set(handles.listbox_xlim,'Value',1);

set(handles.pushbutton_calculate,'Enable','off');

clear_results(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes half_power_bandwidth wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function clear_results(hObject, eventdata, handles)

set(handles.edit_fn,'String',' ');
set(handles.edit_damping_ratio,'String',' ');
set(handles.edit_Q,'String',' ');

set(handles.edit_fn,'Enable','off');
set(handles.edit_damping_ratio,'Enable','off');
set(handles.edit_Q,'Enable','off');




% --- Outputs from this function are returned to the command line.
function varargout = half_power_bandwidth_OutputFcn(hObject, eventdata, handles) 
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





clear_results(hObject, eventdata, handles);

fig_num=2;

iex=get(handles.listbox_excitation,'Value');
iresp=get(handles.listbox_response,'Value');
irat=get(handles.listbox_amplitude_dimension,'Value');

m=get(handles.listbox_method,'Value');

if(m==1)
%
   FS=get(handles.edit_input_array,'String');
   THF=evalin('base',FS); 
else
    THF=getappdata(0,'THF');    
end    

f=double(THF(:,1));        
a=double(THF(:,2));

n=length(f);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(iresp==1)
%%  disp('  1= acceleration ');
%%  disp('  2= acceleration^2 ');
  if(irat==1)
      tlabel='Acceleration';
%    
      if(iex==1)
         MFRF=@(omega,rho,damp)(sqrt((1+(2*damp*rho)^2)/((1-rho^2)^2+(2*damp*rho)^2)));      
      else
         MFRF=@(omega,rho,damp)(sqrt(omega^2/((1-rho^2)^2+(2*damp*rho)^2)));             
      end
%      
  else
      tlabel='Acceleration^2';
%    
      if(iex==1)
         MFRF=@(omega,rho,damp)((1+(2*damp*rho)^2)/((1-rho^2)^2+(2*damp*rho)^2));        
      else
         MFRF=@(omega,rho,damp)((omega^2/((1-rho^2)^2+(2*damp*rho)^2)));          
      end
%       
  end
end
%
if(iresp==2)
%%  disp('  1= velocity ');
%%  disp('  2= velocity^2 ');
  
  if(irat==1)
      tlabel='Velocity';
%    
      if(iex==1)
         MFRF=@(omega,rho,damp)(sqrt(((1+(2*damp*rho)^2)/omega)/((1-rho^2)^2+(2*damp*rho)^2)));       
      else
         MFRF=@(omega,rho,damp)(sqrt(omega/((1-rho^2)^2+(2*damp*rho)^2)));              
      end
%      
  else
      tlabel='Velocity^2';
%    
      if(iex==1)
         MFRF=@(omega,rho,damp)(((1+(2*damp*rho)^2)/omega)/((1-rho^2)^2+(2*damp*rho)^2));       
      else
         MFRF=@(omega,rho,damp)((omega/((1-rho^2)^2+(2*damp*rho)^2)));          
      end
%       
  end   
end
%
if(iresp==3)
%%  disp('  1= displacement ');
%%  disp('  2= displacement^2 ');
  
  if(irat==1)
      tlabel='Displacement';
%    
      if(iex==1)
         MFRF=@(omega,rho,damp)(sqrt(((1+(2*damp*rho)^2)/omega^2)/((1-rho^2)^2+(2*damp*rho)^2)));        
      else
         MFRF=@(omega,rho,damp)(sqrt(1/((1-rho^2)^2+(2*damp*rho)^2)));            
      end
%      
  else
      tlabel='Displacement^2';
%    
      if(iex==1)
         MFRF=@(omega,rho,damp)(((1+(2*damp*rho)^2)/omega^2)/((1-rho^2)^2+(2*damp*rho)^2));        
      else
         MFRF=@(omega,rho,damp)((1/((1-rho^2)^2+(2*damp*rho)^2)));            
      end
%       
  end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
sfmin=get(handles.edit_fmin,'String');
sfmax=get(handles.edit_fmax,'String');

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

fstart=str2num(sfmin);
fend=str2num(sfmax);

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

i2=length(f);

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
    if(a(i)>maxa)
        maxa=a(i);
        maxf=f(i);
    end
end
%
tpi=2*pi;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
error_max=1.0e+90;
%
Ar=0;
fnr=0;
dampr=0;

tol=str2num(get(handles.edit_tol,'String'));

tol=tol/100;

flow=maxf*(1-tol);
fup =maxf*(1+tol);

%
disp(' ');
disp('  i      A       fn       damp      Q');
for i=1:nt
%    
    if(i<5 || rand()<0.6)
        A=(0.99+0.02*rand());
        damp=0.5*rand()^1.5;
        fn=(fup-flow)*rand()+flow;
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
    if(fn<flow || fn>fup)
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
    c=zeros(i2,1);
    for j=i1:i2
        omega=tpi*f(j);
        rho=omega/omegan;
        c(j)=MFRF(omega,rho,damp);
    end
%    
    AX=A*maxa/max(c);
    c=AX*c;
%

%    aaa=zeros(i2,1);
%    aaa(i1:i2)=a(i1:i2);
    
%    ccc=zeros(i2,1);
%    ccc(i1:i2)=c(i1:i2);    

%    [~,ii]=max(aaa);   
%    [~,jj]=max(ccc);    
    
    for j=i1:i2
        bbb=abs(log10(a(j)/c(j)));
        error=error+bbb;
    end
    
%    nerr=abs(log2(f(ii)/f(jj)));
  
    
%
    if(error<error_max)
%        
        error_max=error;
             dampr=damp;
              fnr=fn;
               Ar=A;
              cr=c;
              Q=1/(2*damp);
%
        out1=sprintf(' %d  %7.3g  %7.3g  %7.3g  %7.3g',i,A,fn,damp,Q);
        disp(out1);
%
        k=1;
%
        for j=i1:i2
%        
            fr(k)=f(j);
            ar(k)=cr(j);
            k=k+1;
%
        end
%
        Qr=1/(2*dampr);
%
        figure(fig_num);
        plot(f(i1:i2),a(i1:i2),fr,ar);
        grid on;
        legend('Measured Data','Curve-fit');
        xlabel('Frequency (Hz)');
        out1=sprintf('%s Response Function  fn=%7.4g Hz  Q=%6.3g',tlabel,fnr,Qr);
        title(out1);
%
    end
%
end
%
disp(' ');
disp('         Results ');
disp(' ');
out1=sprintf('            fn =%7.3g Hz \n damping ratio = %7.3g \n             Q =%7.3g \n',fnr,dampr,Qr);
disp(out1);
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

msgbox('Double-check Amplitude or Amplitude^2 Dimension');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
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
   THF = fscanf(fid,'%g %g',[2 inf]);
   THF=THF';
    
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


% --- Executes on selection change in listbox_excitation.
function listbox_excitation_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_excitation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_excitation contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_excitation
clear_results(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_excitation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_excitation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(half_power_bandwidth);


% --- Executes on selection change in listbox_amplitude_dimension.
function listbox_amplitude_dimension_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_amplitude_dimension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_amplitude_dimension contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_amplitude_dimension
clear_results(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_amplitude_dimension_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_amplitude_dimension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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


% --- Executes on button press in pushbutton_plot_input_function.
function pushbutton_plot_input_function_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot_input_function (see GCBO)
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


disp(' plot input ');

n=get(handles.listbox_xlim,'Value');


if(n==2)
    f1=str2num(get(handles.edit_minf,'String'));
    f2=str2num(get(handles.edit_maxf,'String'));
end

iex=get(handles.listbox_excitation,'Value');
iresp=get(handles.listbox_response,'Value');
irat=get(handles.listbox_amplitude_dimension,'Value');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(iresp==1)
%
  if(irat==1)
      tlabel='Acceleration';
%      
  else
      tlabel='Acceleration^2';
%       
  end
end
%
if(iresp==2)
  if(irat==1)
      tlabel='Velocity';
%
  else
      tlabel='Velocity^2';
%       
  end   
end
%
if(iresp==3)

  if(irat==1)
      tlabel='Displacement';
%      
  else
      tlabel='Displacement^2';
  end    
%    
end


%%%

k=get(handles.listbox_method,'Value');

 
if(k==1)
  try
    FS=get(handles.edit_input_array,'String');
    THF=evalin('base',FS);
  catch
      warndlg('Input array not found ');
      return;
  end
else
  THF=getappdata(0,'THF');
end


f=THF(:,1);
a=THF(:,2);


set(handles.pushbutton_calculate,'Enable','on');

fig_num=1;
figure(fig_num);
plot(f,a);
grid on;
xlabel('Frequency (Hz)');
if(n==2)
    xlim([f1 f2]);
end    
%
out1=sprintf('%s Response Function',tlabel);
title(out1);
%




% --- Executes on selection change in listbox_xlim.
function listbox_xlim_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_xlim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_xlim contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_xlim

n=get(handles.listbox_xlim,'Value');

if(n==1)
    set(handles.edit_minf,'String','');
    set(handles.edit_maxf,'String','');   
    set(handles.edit_minf,'Enable','off');
    set(handles.edit_maxf,'Enable','off');    
else
    set(handles.edit_minf,'Enable','on');
    set(handles.edit_maxf,'Enable','on');    
end



% --- Executes during object creation, after setting all properties.
function listbox_xlim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_xlim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_minf_Callback(hObject, eventdata, handles)
% hObject    handle to edit_minf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_minf as text
%        str2double(get(hObject,'String')) returns contents of edit_minf as a double


% --- Executes during object creation, after setting all properties.
function edit_minf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_minf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_maxf_Callback(hObject, eventdata, handles)
% hObject    handle to edit_maxf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_maxf as text
%        str2double(get(hObject,'String')) returns contents of edit_maxf as a double


% --- Executes during object creation, after setting all properties.
function edit_maxf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_maxf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_tol_Callback(hObject, eventdata, handles)
% hObject    handle to edit_tol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_tol as text
%        str2double(get(hObject,'String')) returns contents of edit_tol as a double


% --- Executes during object creation, after setting all properties.
function edit_tol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_tol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

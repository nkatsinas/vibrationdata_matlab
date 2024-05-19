function varargout = VRS_sine_on_random(varargin)
% VRS_SINE_ON_RANDOM MATLAB code for VRS_sine_on_random.fig
%      VRS_SINE_ON_RANDOM, by itself, creates a new VRS_SINE_ON_RANDOM or raises the existing
%      singleton*.
%
%      H = VRS_SINE_ON_RANDOM returns the handle to a new VRS_SINE_ON_RANDOM or the handle to
%      the existing singleton*.
%
%      VRS_SINE_ON_RANDOM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VRS_SINE_ON_RANDOM.M with the given input arguments.
%
%      VRS_SINE_ON_RANDOM('Property','Value',...) creates a new VRS_SINE_ON_RANDOM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VRS_sine_on_random_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VRS_sine_on_random_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VRS_sine_on_random

% Last Modified by GUIDE v2.5 12-Mar-2021 09:53:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VRS_sine_on_random_OpeningFcn, ...
                   'gui_OutputFcn',  @VRS_sine_on_random_OutputFcn, ...
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


% --- Executes just before VRS_sine_on_random is made visible.
function VRS_sine_on_random_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VRS_sine_on_random (see VARARGIN)

% Choose default command line output for VRS_sine_on_random
handles.output = hObject;

set(handles.pushbutton_calculate,'Enable','off');

set(handles.listbox_number,'Value',1);

for i = 1:1
   for j=1:2
      data_s{i,j} = '';     
   end 
   data_s{i,3} = '0';   
end
set(handles.uitable_data,'Data',data_s); 

set(handles.listbox_vdc,'Value',1);

listbox_amplitude_type_Callback(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes VRS_sine_on_random wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VRS_sine_on_random_OutputFcn(hObject, eventdata, handles) 
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
delelte(VRS_sine_on_random)


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    try
        iunit=evalin('base','iunit');   
    catch
        iunit=1;
    end

    THM=getappdata(0,'THM');

%%%%

    m=get(handles.listbox_number,'Value');
    
    N=m;
    
    A=char(get(handles.uitable_data,'Data'));
    
    B=str2num(A);
    
    freq=B(1:N);
    peak=B((N+1):(2*N)); 
    phase=B((2*N+1):(3*N)); 
    
    phase=phase*pi/180;
  
%   
    omega=2.*pi*freq;
%    
    TT=THM(:,1);
    np=length(TT);
   
    a = zeros(1,np);  
%    
    for i=1:N
        for j=1:np
            a(j)=a(j)+peak(i)*sin(omega(i)*TT(j)-phase(i));
        end    
    end  

%%%%    

   kvn=1;
   fstart=1;
   
   dt=(TT(np)-TT(1))/(np-1);
   
%%%%

    TT=fix_size(TT);
    a=fix_size(a);
    
    a=a+THM(:,2);
   
    nc=get(handles.listbox_vdc,'Value');
    
    amp_type=get(handles.listbox_amplitude_type,'Value'); 
    
    if(nc==1 && amp_type==1)
        fper1=0.1/100;
        [a,velox,dispx]=velox_correction_alt(a,dt,kvn,fstart,iunit,fper1);
        
    end    
    
    a=fix_size(a);    
    
%%%%

    disp(' ');
    out1=sprintf('     max=%8.4g ',max(a));
    out2=sprintf('     min=%8.4g ',min(a));    
    out3=sprintf(' std dev=%8.4g ',std(a));    

    disp(out1);
    disp(out2);    
    disp(out3);

      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
fig_num=1;

psd_TH=a;

if(iunit==1)
   aa=a*386;
else
   aa=a*9.81; 
end    

[psd_velox]=integrate_function(aa,dt);
[psd_dispx]=integrate_function(psd_velox,dt);

if(iunit==2)
    psd_velox=psd_velox*100;
    psd_dispx=psd_dispx*1000;
end

unit='G';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      
%

if(amp_type==1)

    figure(fig_num);
    fig_num=fig_num+1;
    plot(TT,psd_TH);
    xlabel('Time (sec)');
    out1=sprintf('Sine-on-Random Acceleration  %7.3g %s rms',std(psd_TH),unit);
    title(out1);
    out_dim_unit=sprintf('Accel (%s)',unit);
    ylabel(out_dim_unit);
    grid on;


    figure(fig_num);
    fig_num=fig_num+1;
    plot(TT,psd_velox);

    if(iunit==1)
        unit='in/sec';
    else
        unit='cm/sec';    
    end

    xlabel('Time (sec)');
    out1=sprintf('Sine-on-Random Velocity  %7.3g %s rms',std(psd_velox),unit);
    title(out1);
    out_dim_unit=sprintf('Velocity (%s)',unit);
    ylabel(out_dim_unit);
    grid on;



    figure(fig_num);
    fig_num=fig_num+1;
    plot(TT,psd_dispx);

    if(iunit==1)
        unit='in';
    else
        unit='mm';    
    end

    xlabel('Time (sec)');
    out1=sprintf('Sine-on-Random Displacement  %7.3g %s rms',std(psd_dispx),unit);
    title(out1);
    out_dim_unit=sprintf('Disp (%s)',unit);
    ylabel(out_dim_unit);
    grid on;
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

else
    figure(fig_num);
    fig_num=fig_num+1;
    plot(TT,psd_TH);
    xlabel('Time (sec)');
    out1=sprintf('Combined Signal  %7.3g rms',std(psd_TH));
    title(out1);
    ylabel('Amplitude');
    grid on;
end


figure(fig_num);
fig_num=fig_num+1;
nbars=31;
xx=max(abs(a));
x=linspace(-xx,xx,nbars);       
hist(a,x)
ylabel('Counts');
title('Histogram');

if(amp_type==1)
    xlabel('Accel');
else
    xlabel('Amplitude');    
end    
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    
    
    

    signal=[TT a];
    setappdata(0,'signal',signal);

    set(handles.pushbutton_save,'Enable','on');      
    
    
    
% --- Executes on button press in pushbutton_read.
function pushbutton_read_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_read (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% disp('ref 1')
try
      FS=get(handles.edit_input_array,'String');
      THM=evalin('base',FS);
%      disp('ref 2')
catch
      warndlg('Unable to read input file','Warning');
      return;
end    

% disp('ref 3')
setappdata(0,'THM',THM);
% disp('ref 4')
set(handles.pushbutton_calculate,'Enable','on');
% disp('ref 5')

msgbox('Data read');

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


% --- Executes on selection change in listbox_number.
function listbox_number_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_number contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_number

n=get(hObject,'Value');

for i = 1:n
   for j=1:2
      data_s{i,j} = '';     
   end  
   data_s{i,3} = '0';   
end
set(handles.uitable_data,'Data',data_s);       




% --- Executes during object creation, after setting all properties.
function listbox_number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=getappdata(0,'signal');

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


% --- Executes on selection change in listbox_vdc.
function listbox_vdc_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_vdc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_vdc contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_vdc


% --- Executes during object creation, after setting all properties.
function listbox_vdc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_vdc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_amplitude_type.
function listbox_amplitude_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_amplitude_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_amplitude_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_amplitude_type

n=get(handles.listbox_amplitude_type,'Value');

if(n==1)
    set(handles.text_vdc,'Visible','on');
    set(handles.listbox_vdc,'Visible','on');    
else
    set(handles.text_vdc,'Visible','off');
    set(handles.listbox_vdc,'Visible','off');       
end


% --- Executes during object creation, after setting all properties.
function listbox_amplitude_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_amplitude_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

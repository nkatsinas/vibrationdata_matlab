function varargout = CFC_filter(varargin)
% CFC_FILTER MATLAB code for CFC_filter.fig
%      CFC_FILTER, by itself, creates a new CFC_FILTER or raises the existing
%      singleton*.
%
%      H = CFC_FILTER returns the handle to a new CFC_FILTER or the handle to
%      the existing singleton*.
%
%      CFC_FILTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CFC_FILTER.M with the given input arguments.
%
%      CFC_FILTER('Property','Value',...) creates a new CFC_FILTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CFC_filter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CFC_filter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CFC_filter

% Last Modified by GUIDE v2.5 14-Dec-2020 16:34:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CFC_filter_OpeningFcn, ...
                   'gui_OutputFcn',  @CFC_filter_OutputFcn, ...
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


% --- Executes just before CFC_filter is made visible.
function CFC_filter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CFC_filter (see VARARGIN)

% Choose default command line output for CFC_filter
handles.output = hObject;

set(handles.edit_results,'Enable','off');

set(handles.listbox_method,'Value',1);
set(handles.listbox_pass_type,'Value',1);

set(handles.pushbutton_save,'Enable','off');
set(handles.edit_output_array,'Enable','off');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CFC_filter wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CFC_filter_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filtered_data=getappdata(0,'filtered_data');
  
output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, filtered_data);

msgbox('Save Complete'); 



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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


set(handles.edit_results,'Enable','on');

YS=get(handles.edit_ylabel,'String');

k=get(handles.listbox_method,'Value');
 
if(k==1)
  FS=get(handles.edit_input_array,'String');
  THM=evalin('base',FS);   
else
  THM=getappdata(0,'THM');
end


y=double(THM(:,2));

rms_input=sqrt(mean(y)^2+std(y)^2);

n=length(y);

dur=THM(n,1)-THM(1,1);

dt=dur/(n-1);

sr=1/dt;

m=get(handles.listbox_pass_type,'Value');

if(m==1)
    cfc=60;
    sr_min=600;
    sstt='CFC 60';
end
if(m==2)
    cfc=180;
    sr_min=1800; 
    sstt='CFC 300';    
end
if(m==3)
    cfc=600;
    sr_min=6000;
    sstt='CFC 600';    
end
if(m==4)
    cfc=1000;
    sr_min=10000;
    sstt='CFC 1000';    
end

if(sr<sr_min)
    out1=sprintf(' SR=%8.4g Hz,  %s Minimum SR=%8.4g ',sr,sstt,sr_min);
    warndlg(out1);
    return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

T=dt;
omega_d=2*pi*cfc*2.0775;
arg=(omega_d*T/2);
omega_a=sin(arg)/cos(arg);

den= 1 +sqrt(2)*omega_a + omega_a^2;

a0=omega_a^2/den;
a1=2*a0;
a2=a0;

b1=  -2*(omega_a^2-1)/den;
b2=  (-1 +sqrt(2)*omega_a - omega_a^2)/den;


forward=[ a0 a1 a2 ];
back   =[  1 -b1 -b2 ];

y=filter(forward,back,y);

y = flipud( y );

y=filter(forward,back,y);

y = flipud( y );


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

y=fix_size(y);

filtered_data=[THM(:,1) y];

rms_output=sqrt(mean(y)^2+std(y)^2);

figure(1);
plot(THM(:,1),THM(:,2));
title('Input Time History');
xlabel(' Time(sec) ');
ylabel(YS);
grid on;

figure(2);
plot(filtered_data(:,1),filtered_data(:,2));

out1=sprintf('%s Low Pass Filter',sstt);
title(out1);

xlabel(' Time(sec) ')
ylabel(YS)
grid on;
    
setappdata(0,'filtered_data',filtered_data);    
    
set(handles.pushbutton_save,'Enable','on');    
set(handles.edit_output_array,'Enable','on'); 

s1=sprintf(' Input');
s2=sprintf('\n %8.4g RMS',rms_input);
s3=sprintf('\n\n Filtered Data');
s4=sprintf('\n %8.4g RMS',rms_output);

string=strcat(s1,s2,s3,s4);

set(handles.edit_results,'String',string);


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(CFC_filter)


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n=get(hObject,'Value');

set(handles.edit_results,'Enable','off');

set(handles.pushbutton_save,'Enable','off');
set(handles.edit_input_array,'String',' ');

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');

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


% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method


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



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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


% --- Executes on selection change in listbox_pass_type.
function listbox_pass_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_pass_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_pass_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_pass_type

n=get(hObject,'Value');

set(handles.edit_results,'Enable','off');

set(handles.edit_freq2,'Visible','Off');
set(handles.Enter_Freq2,'Visible','Off'); 


set(handles.text_Lower,'Visible','Off'); 
set(handles.text_Upper,'Visible','Off'); 


if(n==3 || n==4)
    set(handles.edit_freq2,'Visible','On');
    set(handles.Enter_Freq2,'Visible','On'); 
    
    set(handles.text_Lower,'Visible','On'); 
    set(handles.text_Upper,'Visible','On');   
end

% --- Executes during object creation, after setting all properties.
function listbox_pass_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_pass_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_refiltering.
function listbox_refiltering_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_refiltering (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_refiltering contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_refiltering
set(handles.edit_results,'Enable','off');

% --- Executes during object creation, after setting all properties.
function listbox_refiltering_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_refiltering (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_freq1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_freq1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_freq1 as text
%        str2double(get(hObject,'String')) returns contents of edit_freq1 as a double


% --- Executes during object creation, after setting all properties.
function edit_freq1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_freq1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_freq2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_freq2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_freq2 as text
%        str2double(get(hObject,'String')) returns contents of edit_freq2 as a double


% --- Executes during object creation, after setting all properties.
function edit_freq2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_freq2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_f1_label_Callback(hObject, eventdata, handles)
% hObject    handle to edit_f1_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_f1_label as text
%        str2double(get(hObject,'String')) returns contents of edit_f1_label as a double


% --- Executes during object creation, after setting all properties.
function edit_f1_label_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_f1_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_f2_label_Callback(hObject, eventdata, handles)
% hObject    handle to edit_f2_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_f2_label as text
%        str2double(get(hObject,'String')) returns contents of edit_f2_label as a double


% --- Executes during object creation, after setting all properties.
function edit_f2_label_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_f2_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_results_Callback(hObject, eventdata, handles)
% hObject    handle to edit_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_results as text
%        str2double(get(hObject,'String')) returns contents of edit_results as a double


% --- Executes during object creation, after setting all properties.
function edit_results_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_transfer.
function pushbutton_transfer_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_transfer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%    iorder = 1  for 4th order
%           = 2  for 6th order

iorder=get(handles.listbox_order,'Value');

if(iorder==1)
   order_label='4th order'; 
   L_order=4;
else
   order_label='6th order';
   L_order=6;
end


ire=get(handles.listbox_refiltering,'Value');
typ=get(handles.listbox_pass_type,'Value');


%
if(typ==1) % lowpass
    
    value = get(handles.edit_freq1, 'String');
    
    if isempty(value)
        msgbox('Enter lowpass frequency');
        return;
    else   
        lpf=str2num(value);
        fc=lpf;        
    end    
end
if(typ==2) % highpass
    
    value=get(handles.edit_freq1,'String');
    
    if isempty(value)
        msgbox('Enter highpass frequency');        
        return;
    else    
        hpf=str2num(value);
        fc=hpf;        
    end      
end
%
if(typ==3) % bandpass
    value1=get(handles.edit_freq1,'String');
    
    if isempty(value1)
        msgbox('Enter highpass frequency');        
        return;
    else    
        hpf=str2num(value1);
        fc=hpf;        
    end  
%
    value2 = get(handles.edit_freq2, 'String');
    
    if isempty(value2)
        msgbox('Enter lowpass frequency');        
        return;
    else    
        lpf=str2num(value2);
        fc=lpf;        
    end   
end
%
if(typ==4) % bandstop
    value1=get(handles.edit_freq1,'String');
    
    if isempty(value1)
        msgbox('Enter low frequency');        
        return;
    else    
        lpf=str2num(value1);
        fc=lpf;
    end  
%
    value2 = get(handles.edit_freq2, 'String');
    
    if isempty(value2)
        msgbox('Enter high frequency');        
        return;
    else    
        hpf=str2num(value2);        
    end   
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
L=L_order;
LL=2*L;

%
%  The following coefficiences are for "Reference Only."
%  They are not used directly in the transfer function calculation.
%
sr=zeros(LL,1);
si=zeros(LL,1);
%
for k=1:LL  
    arg  = (2*k+L-1)*pi/LL;
    sr(k)= cos(arg);
    si(k)= sin(arg);
end
sc=complex(sr,si)';
%
nn=5000;
df=fc/100;
%
H=zeros(nn,1);
fH=zeros(nn,1);
%
for i=1:nn
    ff=i*df;
    s=complex(0,(ff/fc));
%
    if(typ==2) % highpass
        s=1/s;
    end
%
    H1=s^2-2*cos(7*pi/12)*s+1;
    H2=s^2-2*cos(9*pi/12)*s+1;
    H3=s^2-2*cos(11*pi/12)*s+1;    
    A=H1*H2*H3;
%    
    A=1/A;
    H(i)=A;
    fH(i)=ff;
%
    if(ire==1)  % refiltering 
        H(i)=H(i)*conj(H(i));
    end
%
end
%
if(typ==3 || typ==4)  % bandpass or bandstop
    G1=H;
    clear H;
    fc=hpf;
%
    G2=zeros(nn,1);
%
    for i=1:nn 
        ff=i*df;       
        s=complex(0,(ff/fc));
        s=1/s;
%        
        H1=s^2-2*cos(7*pi/12)*s+1;
        H2=s^2-2*cos(9*pi/12)*s+1;
        H3=s^2-2*cos(11*pi/12)*s+1;    
        A=H1*H2*H3;
%    
        A=1/A;
        H(i)=A;
        if(ire==1)  % refiltering 
            H(i)=H(i)*conj(H(i));
        end
        G2(i)=H(i);
        
        if(typ==3)   % bandpass
            H(i)=G2(i)'*G1(i);
        else         % bandstop
            H(i)=G2(i)+G1(i);           
        end
    end
end    
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% fH=fH*fc*tpi;
%
%
if(ire==1)
    if(typ==1)
        out1=sprintf(' Butterworth Lowpass Filter %s Refiltering fc=%g Hz ',order_label,lpf);
    end
    if(typ==2)
        out1=sprintf(' Butterworth Highpass Filter %s Refiltering fc=%g Hz ',order_label,hpf);
    end
    if(typ==3)
        out1=sprintf(' Butterworth Bandpass Filter %s Refiltering %g to %g Hz ',order_label,hpf,lpf);
    end
    if(typ==4)
        out1=sprintf(' Butterworth Bandstop Filter %s Refiltering %g to %g Hz ',order_label,lpf,hpf);
    end    
else
    if(typ==1)
        out1=sprintf(' Butterworth Lowpass Filter %s fc=%g Hz ',order_label,lpf);
    end
    if(typ==2)
        out1=sprintf(' Butterworth Highpass Filter %s fc=%g Hz ',order_label,hpf);
    end
    if(typ==3)
        out1=sprintf(' Butterworth Bandpass Filter %s %g to %g Hz ',order_label,hpf,lpf);
    end    
    if(typ==4)
        out1=sprintf(' Butterworth Bandstop Filter %s %g to %g Hz ',order_label,lpf,hpf);
    end       
end
%
if(typ<3)
    xmax=10^(ceil(0.01+log10(fc)));
    xmin=10^(floor(-0.01+log10(fc)));
else
    xmax=10^(ceil(0.01+log10(lpf)));
    xmin=10^(floor(-0.01+log10(hpf)));    
end
%
%
%  Phase
%
figure(3);
subplot(3,1,1);

theta=angle(H)*180/pi;

plot(fH,theta);
ylim([-180,180]);
xlim([ xmin xmax ]);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
                    'YScale','lin','ytick',[-180,-90,0,90,180]);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin');
ylabel(' Phase(deg) ');
xlabel(' Frequency (Hz) ');
title(out1);
grid on;
%
%  Magnitude
%
subplot(3,1,[2 3]);
plot(fH,abs(H));
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');
grid on;
xlabel(' Frequency (Hz) ');
ylabel(' Magnitude ');
ymax=1;
ymin=ymax/100;
ylim([ ymin ymax ]);
xlim([ xmin xmax ]);
%
figure(4);
plot(fH,real(H),fH,imag(H));
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin');
ylabel(' Amplitude ');
xlabel(' Frequency (Hz) ');
title(out1);
legend ('real','imaginary');  
grid on;


% --- Executes on selection change in listbox_order.
function listbox_order_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_order contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_order


% --- Executes during object creation, after setting all properties.
function listbox_order_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

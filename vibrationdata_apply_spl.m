function varargout = vibrationdata_apply_spl(varargin)
% VIBRATIONDATA_APPLY_SPL MATLAB code for vibrationdata_apply_spl.fig
%      VIBRATIONDATA_APPLY_SPL, by itself, creates a new VIBRATIONDATA_APPLY_SPL or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_APPLY_SPL returns the handle to a new VIBRATIONDATA_APPLY_SPL or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_APPLY_SPL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_APPLY_SPL.M with the given input arguments.
%
%      VIBRATIONDATA_APPLY_SPL('Property','Value',...) creates a new VIBRATIONDATA_APPLY_SPL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_apply_spl_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_apply_spl_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_apply_spl

% Last Modified by GUIDE v2.5 27-Dec-2014 16:50:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_apply_spl_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_apply_spl_OutputFcn, ...
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


% --- Executes just before vibrationdata_apply_spl is made visible.
function vibrationdata_apply_spl_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_apply_spl (see VARARGIN)

% Choose default command line output for vibrationdata_apply_spl
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_apply_spl wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_apply_spl_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_apply_spl);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig_num=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try  
         FS=get(handles.edit_spl,'String');
         applied_spl=evalin('base',FS);  
catch
         return
         warndlg('SPL Array does not exist.  Try again.')
end

try  
         FS=get(handles.edit_trans,'String');
         trans=evalin('base',FS);  
catch
         return
         warndlg('Input Array does not exist.  Try again.')
end

n=get(handles.listbox_trans_type,'Value');

sz=size(trans);

if(n==1 || n==3)  % convert trans to power trans
    
    for i=1:sz(1)
        trans(:,2)=trans(:,2)^2;
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

iu=get(handles.listbox_units,'Value');

if(iu==1)
    reference = 2.9e-09;
else
    reference = 20.e-06;
end
%

delta=1;

fc=applied_spl(:,1);
spl=applied_spl(:,2);
%

ms=0.;
sum=0.;
%
m=length(spl);
%
for i=1:m
%
    rms = (10.^(spl(i)/10));
	sum=sum+rms;
end
%
oadb=10.*log10(sum);

%
rms=0.;
%   
num=length(fc);
psd=zeros(num,1);
%
%
for i=1:num    
%   
    if( spl(i) >= 1.0e-50)
%       
        pressure_rms=reference*(10.^(spl(i)/20.) );
%
        df=fc(i)*delta;
%
        if( df > 0. )   
            psd(i)=(pressure_rms^2.)/df;
            rms=rms+psd(i)*df;
        end
    end
end
%
applied_pressure_psd=[fc psd];
%
rms=sqrt(rms);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

out1=sprintf('\n  Overall Level = %8.4g dB \n',oadb);
disp(out1)
disp('  ');
disp(' zero dB Reference = 20 micro Pascal ');
disp('  ');
%
figure(fig_num);
fig_num=fig_num+1;
%
plot(applied_spl(:,1),applied_spl(:,2));
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','lin')
grid on;
out1=sprintf(' One-Third Octave Sound Pressure Level  OASPL = %8.4g dB ',oadb);
title(out1)
xlabel(' Center Frequency (Hz) ');
ylabel(' SPL (dB) ');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

df=1;

xone= fc;
yone= psd;

xtwo= trans(:,1);
ytwo= trans(:,2);

Q1 = real_mult_intlin(xone,yone,df);
Q2 = real_mult_intlin(xtwo,ytwo,df);      

f1=Q1(:,1);
a1=Q1(:,2);

f2=Q2(:,1);
a2=Q2(:,2);
%

%
df2=df/2;
%
ijk=1;
for i=1:length(f1)
    for j=1:length(f2)
        if(abs(f1(i)-f2(j))<df2)
            ab(ijk)=a1(i)*a2(j);
            ff(ijk)=(f1(i)+f2(j))/2.;
           
            ijk=ijk+1;
            
            break;
        end
    end
end    

ff=fix_size(ff);
ab=fix_size(ab);

response_psd=[ff ab];

ms=0;
rms=0;

for i=1:length(ff)
    ms=ms+ab(i);
end

rms=sqrt(ms*df);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_fmax,'String'));

xlab='Frequency (Hz)';
ylab=get(handles.edit_ylabel,'String');



t1=get(handles.edit_title,'String');


if(iu==1)  % English
    
    if(n<=2)
        una='inch';
    else
        una='psi';       
    end
    
else       % metric
    
    if(n<=2)
        una='m';    
    else
        una='Pa';        
    end
    
end



t_string=sprintf('%s  %6.3g %s rms overall',t1,rms,una);


[fig_num]=plot_PSD_function(fig_num,xlab,ylab,t_string,response_psd,fmin,fmax);

setappdata(0,'response_psd',response_psd);

set(handles.uipanel_save,'Visible','on');



function edit_spl_Callback(hObject, eventdata, handles)
% hObject    handle to edit_spl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_spl as text
%        str2double(get(hObject,'String')) returns contents of edit_spl as a double


% --- Executes during object creation, after setting all properties.
function edit_spl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_spl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_trans_Callback(hObject, eventdata, handles)
% hObject    handle to edit_trans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_trans as text
%        str2double(get(hObject,'String')) returns contents of edit_trans as a double


% --- Executes during object creation, after setting all properties.
function edit_trans_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_trans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_trans_type.
function listbox_trans_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_trans_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_trans_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_trans_type


% --- Executes during object creation, after setting all properties.
function listbox_trans_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_trans_type (see GCBO)
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



function edit_title_Callback(hObject, eventdata, handles)
% hObject    handle to edit_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_title as text
%        str2double(get(hObject,'String')) returns contents of edit_title as a double


% --- Executes during object creation, after setting all properties.
function edit_title_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_sav.
function pushbutton_sav_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_sav (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


data=getappdata(0,'response_psd');

output_name=get(handles.edit_output_array_name,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete');


function edit_output_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
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

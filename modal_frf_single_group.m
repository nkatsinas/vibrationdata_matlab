function varargout = modal_frf_single_group(varargin)
% MODAL_FRF_SINGLE_GROUP MATLAB code for modal_frf_single_group.fig
%      MODAL_FRF_SINGLE_GROUP, by itself, creates a new MODAL_FRF_SINGLE_GROUP or raises the existing
%      singleton*.
%
%      H = MODAL_FRF_SINGLE_GROUP returns the handle to a new MODAL_FRF_SINGLE_GROUP or the handle to
%      the existing singleton*.
%
%      MODAL_FRF_SINGLE_GROUP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MODAL_FRF_SINGLE_GROUP.M with the given input arguments.
%
%      MODAL_FRF_SINGLE_GROUP('Property','Value',...) creates a new MODAL_FRF_SINGLE_GROUP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before modal_frf_single_group_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to modal_frf_single_group_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help modal_frf_single_group

% Last Modified by GUIDE v2.5 15-Nov-2016 15:13:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @modal_frf_single_group_OpeningFcn, ...
                   'gui_OutputFcn',  @modal_frf_single_group_OutputFcn, ...
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


% --- Executes just before modal_frf_single_group is made visible.
function modal_frf_single_group_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to modal_frf_single_group (see VARARGIN)

% Choose default command line output for modal_frf_single_group
handles.output = hObject;

set(handles.listbox_unit,'Value',1);
set(handles.listbox_mean_removal,'Value',2);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes modal_frf_single_group wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = modal_frf_single_group_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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


% --- Executes on selection change in listbox_mean_removal.
function listbox_mean_removal_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_mean_removal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_mean_removal contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_mean_removal


% --- Executes during object creation, after setting all properties.
function listbox_mean_removal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_mean_removal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type


% --- Executes during object creation, after setting all properties.
function listbox_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ylabel_input_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ylabel_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ylabel_input as text
%        str2double(get(hObject,'String')) returns contents of edit_ylabel_input as a double


% --- Executes during object creation, after setting all properties.
function edit_ylabel_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ylabel_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_force_unit.
function listbox_force_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_force_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_force_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_force_unit


% --- Executes during object creation, after setting all properties.
function listbox_force_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_force_unit (see GCBO)
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

fig_num=1;

try
  FS=get(handles.edit_input_array,'String');
  THM=evalin('base',FS);   
  ssn=FS;
catch
  warndlg('Input array not found ');  
  return;  
end    

sz=size(THM);

if(sz(2)<3)
   warndlg('Input array must have at least 3 columns.'); 
   return; 
end

nt=sz(1);
nac=sz(2)-2;

t=THM(:,1);

force=THM(:,2);

nen=3+nac-1;

accel=THM(:,3:nen);

sza=size(accel);

if(sza(2)==0)
    warndlg('Acceleration column error');
    return;
end

radio1 = get(handles.radiobutton1, 'Value');
radio2 = get(handles.radiobutton2, 'Value');
radio3 = get(handles.radiobutton3, 'Value');
radio4 = get(handles.radiobutton4, 'Value');

pp=get(handles.listbox_mean_removal,'Value');

if(pp==1)
    force=force-mean(force);
    
    for i=1:nac
        accel(:,i)=accel(:,i)-mean(accel(:,i));
    end    
end    

iu=get(handles.listbox_unit,'Value');


if(radio1==0 && radio2==0 && radio3==0 && radio4==0)
    warndlg('Select at least one output');
    return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

num=nt;
dt=(t(num)-t(1))/(num-1);
dur=num*dt;
df=1/(num*dt);
sr=1/dt;
nyf=sr/2;
nhalf=floor(num/2);

disp(' ');
disp(' * * * * * * * ');
out1=sprintf('\n dt=%8.4g sec  df=%8.3g Hz  ',dt,df);
disp(out1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sfmin=get(handles.edit_fmin,'String');
sfmax=get(handles.edit_fmax,'String');


if isempty(sfmin)
    string=sprintf('%8.4g',df);
    set(handles.edit_fmin,'String',string); 
    sfmin=get(handles.edit_fmin,'String');    
end

if isempty(sfmax)  
    string=sprintf('%8.4g',nyf);
    set(handles.edit_fmax,'String',string);
    sfmax=get(handles.edit_fmax,'String');    
end

fmin=str2num(sfmin);
fmax=str2num(sfmax);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[zforce,zzforce,force_real,force_imag,~,~,~]=fourier_core(num,nhalf,df,force);
force_complex=complex(force_real,force_imag);
force_complex=fix_size(force_complex);

tpi=2*pi;

disp('  ');
disp(' Output Arrays ');

for i=1:nac
    
    B=accel(:,i);
    
    [zB,zzB,B_real,B_imag,ms,freq,ff]=fourier_core(num,nhalf,df,B);
    
    ff=real(ff);
    ff=fix_size(ff);
    B_real=fix_size(B_real);
    B_imag=fix_size(B_imag);
%
    B_complex=complex(B_real,B_imag);    
%
    FRF=B_complex./force_complex;
    FRF=fix_size(FRF);
%  
    FRF_mag=abs(FRF);
%   
    FRF_phase=(180/pi)*atan2(imag(FRF),real(FRF));    
%
    FRF_m=FRF_mag(1:nhalf);
    FRF_p=FRF_phase(1:nhalf);
    FRF_mp=[ff FRF_m FRF_p];
    
%    
    FRF_r=real(FRF(1:nhalf));   
    FRF_i=imag(FRF(1:nhalf));
    
    FRF_acc= [ff (FRF_r+1i*FRF_i)];
     
    
    FRF_mob=zeros(nhalf,2);
    FRF_rec=zeros(nhalf,2);    
    
    for j=1:nhalf
        
        omega=tpi*ff(j);
        
        FRF_mob(j,:)=[ff(j)  (FRF_acc(j,2)/(1i*omega)) ];
        FRF_rec(j,:)=[ff(j)  (FRF_acc(j,2)/(-omega^2)) ];
        
    end    
    
    ffb=ff;
    ffb(1)=[];
    
    FRF_mob(1,:)=[];    
    FRF_rec(1,:)=[];  
    
%    
    if(iu==1)
        FRF_mob(:,2)=FRF_mob(:,2)*386;
        FRF_rec(:,2)=FRF_rec(:,2)*386;
    else
        FRF_mob(:,2)=FRF_mob(:,2)*9.81;
        FRF_rec(:,2)=FRF_rec(:,2)*9.81*1000;      
    end

    snum=sprintf('_%d',i);
    sss=strcat(ssn,snum);   
    
    md=5;
    sssp=strrep(sss,'_',' ');
    xlabel2='Frequency (Hz)';
    ylabel1='Real';
    ylabel2='Imag';
        
    if(radio1==1) % accelerance freq mag phase
        data=FRF_mp;
        output_array=strcat(sss,'_Hmp');
        assignin('base', output_array, data);
        disp(output_array);
        t_string=sprintf(' Accelerance %s ',sssp);
        if(iu==1)
            ylab='Magnitude (G/lbf)';
        else
            ylab='Magnitude (G/N)';            
        end
        [fig_num]=...
        plot_magnitude_phase_function_linlog(fig_num,t_string,fmin,fmax,ff,FRF_p,FRF_m,ylab,md);
    end
    
    if(radio2==1) % accelerance freq complex
        data=FRF_acc;
        output_array=strcat(sss,'_Hacc');
        assignin('base', output_array, data); 
        disp(output_array);  
        t_string1=sprintf(' Accelerance %s ',sssp);
        data1=[ff real(FRF_acc(:,2))];
        data2=[ff imag(FRF_acc(:,2))];
        [fig_num]=...
        subplots_two_linlin_f(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,fmin,fmax);  
    end
    
    if(radio3==1) % mobility freq complex
        data=FRF_mob;
        output_array=strcat(sss,'_Hmob');
        assignin('base', output_array, data);
        disp(output_array);        
        t_string1=sprintf(' Mobility %s ',sssp);
        data1=[ffb real(FRF_mob(:,2))];
        data2=[ffb imag(FRF_mob(:,2))];
        [fig_num]=...
        subplots_two_linlin_f(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,fmin,fmax);         
    end
    
    if(radio4==1) % receptance freq complex
        data=FRF_rec;
        output_array=strcat(sss,'_Hrec');
        assignin('base', output_array, data);
        disp(output_array);       
        t_string1=sprintf(' Receptance %s ',sssp);
        data1=[ffb real(FRF_rec(:,2))];
        data2=[ffb imag(FRF_rec(:,2))];
                  
        [fig_num]=subplots_two_linlin_f(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,fmin,fmax);                                    
                                            
    end    
    
%
end
disp(' ');
msgbox('Output array names written to Command Window');



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(modal_frf_single_group);


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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_save,'Value');

if(n==1)
    data=getappdata(0,'FRF_m_store');
end
if(n==2)
    data=getappdata(0,'FRF_mp_store');
end
if(n==3)
   data=getappdata(0,'FRF_complex_store'); 
end


output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete.'); 



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


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4



function edit_extension_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_extension_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_extension_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_extension_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_extension_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_extension_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_extension_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_extension_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_extension_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_extension_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_extension_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_extension_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_extension_3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_extension_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_extension_3 as text
%        str2double(get(hObject,'String')) returns contents of edit_extension_3 as a double


% --- Executes during object creation, after setting all properties.
function edit_extension_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_extension_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_extension_4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_extension_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_extension_4 as text
%        str2double(get(hObject,'String')) returns contents of edit_extension_4 as a double


% --- Executes during object creation, after setting all properties.
function edit_extension_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_extension_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit


% --- Executes during object creation, after setting all properties.
function listbox_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

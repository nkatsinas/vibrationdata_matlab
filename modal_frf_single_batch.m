function varargout = modal_frf_single_batch(varargin)
% MODAL_FRF_SINGLE_BATCH MATLAB code for modal_frf_single_batch.fig
%      MODAL_FRF_SINGLE_BATCH, by itself, creates a new MODAL_FRF_SINGLE_BATCH or raises the existing
%      singleton*.
%
%      H = MODAL_FRF_SINGLE_BATCH returns the handle to a new MODAL_FRF_SINGLE_BATCH or the handle to
%      the existing singleton*.
%
%      MODAL_FRF_SINGLE_BATCH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MODAL_FRF_SINGLE_BATCH.M with the given input arguments.
%
%      MODAL_FRF_SINGLE_BATCH('Property','Value',...) creates a new MODAL_FRF_SINGLE_BATCH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before modal_frf_single_batch_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to modal_frf_single_batch_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help modal_frf_single_batch

% Last Modified by GUIDE v2.5 15-Nov-2016 12:05:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @modal_frf_single_batch_OpeningFcn, ...
                   'gui_OutputFcn',  @modal_frf_single_batch_OutputFcn, ...
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


% --- Executes just before modal_frf_single_batch is made visible.
function modal_frf_single_batch_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to modal_frf_single_batch (see VARARGIN)

% Choose default command line output for modal_frf_single_batch
handles.output = hObject;

set(handles.listbox_type,'Value',1);
set(handles.listbox_force_unit,'Value',1);
set(handles.listbox_mean_removal,'Value',2);
set(handles.listbox_save,'Value',1);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes modal_frf_single_batch wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = modal_frf_single_batch_OutputFcn(hObject, eventdata, handles) 
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
    sarray=evalin('base',FS);
catch
    warndlg('Input string array not found.');
    return; 
end  

if(iscell(sarray)==0)
    warndlg('Input must be array of strings (class=cell)');  
    return;
end

kv=length(sarray);

ext_1=get(handles.edit_extension_1,'String');
ext_2=get(handles.edit_extension_2,'String');
ext_3=get(handles.edit_extension_3,'String');
ext_4=get(handles.edit_extension_4,'String');

radio1Value = get(handles.radiobutton1, 'Value');
radio2Value = get(handles.radiobutton2, 'Value');
radio3Value = get(handles.radiobutton3, 'Value');
radio4Value = get(handles.radiobutton4, 'Value');

pp=get(handles.listbox_mean_removal,'Value');


ifu=get(handles.listbox_force_unit,'Value');

if(ifu==1)
  YF='Force (lbf)';
  FU='lbf';
else
  YF='Force (N)';
  FU='N';
end

YS=get(handles.edit_ylabel_input,'String');
m=get(handles.listbox_type,'Value');

if(radio1Value==1)
end

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

for i=1:kv
    
    THM=evalin('base',char(sarray(i,:)));    

    t=THM(:,1);
    a=THM(:,2);
    b=THM(:,3);

    if(pp==1)
        a=a-mean(a);
        b=b-mean(b);
    end    

    A=a;
    B=b;

    num=length(t);
    dt=(t(num)-t(1))/(num-1);
    
    dur=num*dt;

    n=num;

    df=1/(n*dt);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%

    nhalf=floor(n/2);
%
    [zA,zzA,A_real,A_imag,~,~,~]     =fourier_core(n,nhalf,df,A);
    [zB,zzB,B_real,B_imag,ms,freq,ff]=fourier_core(n,nhalf,df,B);
%
    A_complex=complex(A_real,A_imag);
    B_complex=complex(B_real,B_imag);    
%
    FRF=B_complex./A_complex;
%  
    FRF_mag=abs(FRF);
%   
    FRF_phase=(180/pi)*atan2(imag(FRF),real(FRF));    
%
    FRF_m=FRF_mag(1:nhalf);
    FRF_p=FRF_phase(1:nhalf);
    
    FRF_r=real(FRF(1:nhalf));   
    FRF_i=imag(FRF(1:nhalf));    
%

    t_string=sprintf('Frequency Response Function ');

%%%
%%%

    tmp = abs(ff-fmin);
    [c,idx1] = min(tmp);     
    
    if(ff(idx1)<1.0e-80)
        idx1=idx1+1;
        fmin=ff(idx1);
    end    

    tmp = abs(ff-fmax);
    [c,idx2] = min(tmp); 

%%%
%%%

    figure(fig_num);
    fig_num=fig_num+1;
%
    subplot(3,1,1);
    plot(ff,FRF_p);
    title(t_string);
    grid on;
    ylabel('Phase (deg)');
    axis([fmin,fmax,-180,180]);
%%    fmin
%%    fmax
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin','ytick',[-180,-90,0,90,180]);
%
    subplot(3,1,[2 3]);
    plot(ff,FRF_m);
    grid on;
    xlabel('Frequency(Hz)');
    ylabel(out2);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
%
    ymax=10^(ceil(log10(max(FRF_m(idx1:idx2)))));
    ymin=10^(floor(log10(min(FRF_m(idx1:idx2)))));
%
    if(ymin<ymax/10000)
        ymin=ymax/10000;
    end
%
    axis([fmin,fmax,ymin,ymax]);
    
%%    fmin
%%    fmax
%
    ff=fix_size(ff);
    FRF_m=fix_size(FRF_m);
    FRF_p=fix_size(FRF_p);
    FRF_r=fix_size(FRF_r);
    FRF_i=fix_size(FRF_i);    
%
    [xmax,qfmax]=find_max([ff(idx1:idx2) FRF_m(idx1:idx2)]);
%
    out5 = sprintf('\n Peak occurs at %10.5g Hz ',qfmax);
    disp(out5)
%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%

FRF_m_store=[ff FRF_m];
setappdata(0,'FRF_m_store',FRF_m_store);

try

    FRF_mp_store=[ff FRF_m FRF_p];
    setappdata(0,'FRF_mp_store',FRF_mp_store);

end

try
    
    nnn=min([ length(ff)  length(FRF_r)  length(FRF_i)]);

    FRF_complex_store=[ff(1:nnn) FRF_r(1:nnn)+(1i)*FRF_i(1:nnn)];
    setappdata(0,'FRF_complex_store',FRF_complex_store);
catch
    warndlg('FRF_complex_store error');
end    
    
set(handles.pushbutton_save,'Enable','on');



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(modal_frf_single_batch);


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

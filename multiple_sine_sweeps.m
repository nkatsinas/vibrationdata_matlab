function varargout = multiple_sine_sweeps(varargin)
% MULTIPLE_SINE_SWEEPS MATLAB code for multiple_sine_sweeps.fig
%      MULTIPLE_SINE_SWEEPS, by itself, creates a new MULTIPLE_SINE_SWEEPS or raises the existing
%      singleton*.
%
%      H = MULTIPLE_SINE_SWEEPS returns the handle to a new MULTIPLE_SINE_SWEEPS or the handle to
%      the existing singleton*.
%
%      MULTIPLE_SINE_SWEEPS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MULTIPLE_SINE_SWEEPS.M with the given input arguments.
%
%      MULTIPLE_SINE_SWEEPS('Property','Value',...) creates a new MULTIPLE_SINE_SWEEPS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before multiple_sine_sweeps_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to multiple_sine_sweeps_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help multiple_sine_sweeps

% Last Modified by GUIDE v2.5 14-Aug-2020 13:55:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @multiple_sine_sweeps_OpeningFcn, ...
                   'gui_OutputFcn',  @multiple_sine_sweeps_OutputFcn, ...
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


% --- Executes just before multiple_sine_sweeps is made visible.
function multiple_sine_sweeps_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to multiple_sine_sweeps (see VARARGIN)

% Choose default command line output for multiple_sine_sweeps
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

listbox_num_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes multiple_sine_sweeps wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = multiple_sine_sweeps_OutputFcn(hObject, eventdata, handles) 
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

N=get(handles.listbox_num,'Value');
ntype=get(handles.listbox_type,'Value');
T=str2double(get(handles.edit_duration,'String'));
SR=str2double(get(handles.edit_SR,'String'));


dur=T;
dt=1/SR;

NT=round(T/dt);
ntimes=NT;

THM=zeros(NT,2);

TT=linspace(0,ntimes*dt,ntimes); 
THM(:,1)=TT;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data=get(handles.uitable_data,'Data');
A=char(data);
   
fstart=zeros(N,1);
fend=zeros(N,1);
amp=zeros(N,1);

try
    k=1;
    
    for i=1:N
        a=A(k,:); k=k+1;
        fstart(i,1) = str2double(strtrim(a));
    end    
    
    for i=1:N
        a=A(k,:); k=k+1;
        fend(i,1) = str2double(strtrim(a));
    end   
       
    for i=1:N
        a=A(k,:); k=k+1;
        amp(i,1) = str2double(strtrim(a));
    end   
    
catch
    warndlg('Input Arrays read failed');
    return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tpi=2*pi;


for ijk=1:N

    f1=fstart(ijk);
    f2=fend(ijk);
    
    oct=log(f2/f1)/log(2);

    if(ntype==1)  % linear
        rate=(f2-f1)/dur;
    else          % log
        rate=oct/dur;
    end
   
     arg = zeros(1,ntimes);
    freq = zeros(1,ntimes);    
    
    if(ntype==1)  % linear
    %
    % 0.5 factor is necessary to obtain correct number of cycles for linear case.
    %
    %			fspectral= (     rate*t ) + f1;
        fmax=0.5*(f2-f1)+f1;
        freq=linspace(f1,fmax,nt);     
    %
    else  % log
    %  
    %			fspectral = f1*pow(2.,rate*t);
    %
        for i=1:ntimes
            arg(i)=-1.+2^(rate*TT(i));
        end   
    end    
    
    freq=fix_size(freq);
    TT=fix_size(TT);

    if(ntype==1) % linear
        arg=tpi*freq.*TT(1:nt);
    else  %log
        arg=tpi*f1*arg/(rate*log(2));  
    end    
    

    
    aa=amp(ijk)*sin(arg);
    
    aa=fix_size(aa);
    
    THM(:,2)=THM(:,2)+aa;
    
end

figure(1);
plot(THM(:,1),THM(:,2));
ylabel('Accel (G)');
xlabel('Time (sec)');
grid on;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setappdata(0,'THM',THM);

set(handles.uipanel_save,'Visible','on');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(multiple_sine_sweeps);


% --- Executes on button press in pushbutton_save_file.
function pushbutton_save_file_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    save_array_name=get(handles.edit_save_array_name,'String');
    MMS.save_array_name=save_array_name; 
catch 
    warndlg('Enter save array name');
    return;
end
 
if(isempty(save_array_name))
    warndlg('Enter save array name');
    return;    
end
 
 
try
    num=get(handles.listbox_num,'Value');
    MMS.num=num; 
catch    
end

try
    ntype=get(handles.listbox_type,'Value');
    MMS.ntype=ntype; 
catch    
end

try
    T=get(handles.edit_duration,'String');
    MMS.T=T; 
catch    
end

try
    SR=get(handles.edit_SR,'String');
    MMS.SR=SR; 
catch    
end
 
try
    data=get(handles.uitable_data,'data');
    MMS.data=data; 
catch    
end 
 
% % %
 
%%% structnames = fieldnames(MMS, '-full'); % fields in the struct
  
% % %
 
%%%   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
%%%    elk=sprintf('%s%s',writepname,writefname);
 
    
name=save_array_name;
 
name=strrep(name,'.mat','');
name=strrep(name,'_model','');    
name=sprintf('%s_model.mat',name);
 
try
    save(name, 'MMS'); 
catch
    warndlg('Save error');
    return;
end
 
out1=sprintf('Save Complete: %s',name);
disp(out1);
msgbox(out1);





% --- Executes on button press in pushbutton_load_plot.
function pushbutton_load_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


[filename, pathname] = uigetfile('*.mat', 'Select plot save file');

NAME = [pathname,filename];

struct=load(NAME);
structnames = fieldnames(struct, '-full'); % fields in the struct

k=length(structnames);

for i=1:k
    namevar=strcat('struct.',structnames{i});
    value=eval(namevar);
    assignin('base',structnames{i},value);
end

% struct

try

   MMS=evalin('base','MMS');

catch
   warndlg(' evalin failed ');
   setappdata(0,'eflag',1);   
   return;
end

%%%%%%%%%%%%

try
    num=MMS.num;    
    set(handles.listbox_num,'Value',num); 
catch    
end

try
    ntype=MMS.ntype;     
    set(handles.listbox_type,'Value',ntype);
catch    
end

try
    T=MMS.T;     
    set(handles.edit_duration,'String',T);
catch    
end

try
    SR=MMS.SR;     
    set(handles.edit_SR,'String',SR);
catch    
end
 
try
    data=MMS.data;     
    set(handles.uitable_data,'data',data);
catch    
end 



listbox_num_Callback(hObject, eventdata, handles);


% --- Executes on selection change in listbox_num.
function listbox_num_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num


Nrows=get(handles.listbox_num,'Value');
Ncolumns=3;
 
A=get(handles.uitable_data,'Data');
 
sz=size(A);
Arows=sz(1);
 
for i=1:Nrows
    for j=1:Ncolumns
        data_s{i,j}='';
    end    
end    
 
if(~isempty(A))
    
    M=min([ Arows Nrows ]);
    
    for i=1:M
        for j=1:Ncolumns
            data_s{i,j}=A{i,j};
        end    
    end   
 
end
 
set(handles.uitable_data,'Data',data_s);




% --- Executes during object creation, after setting all properties.
function listbox_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_reset.
function pushbutton_reset_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_save,'Visible','off');


Nrows=get(handles.listbox_num,'Value');
 
Ncolumns=3;
 
for i=1:Nrows
    for j=1:Ncolumns
        data_s{i,j}='';
    end    
end  


set(handles.uitable_data,'Data',data_s);



% --- Executes on button press in pushbutton_delete.
function pushbutton_delete_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_save,'Visible','off');

Nrows=get(handles.listbox_num,'Value');
 
Ncolumns=3;
 
A=get(handles.uitable_data,'Data');
 
sz=size(A);
Arows=sz(1);
 
for i=1:Nrows
    for j=1:Ncolumns
        data_s{i,j}='';
    end    
end    
 
if(~isempty(A))
    
    M=min([ Arows Nrows ]);
    
    for i=1:M
        for j=1:Ncolumns
            data_s{i,j}='';
            try
                data_s{i,j}=A{i,j};
            catch
            end
            
        end    
    end   
 
end
 
nd=get(handles.listbox_delete_array,'Value');
 
if(nd<=Nrows)
    
    temp=data_s;
    clear data_s;
    
    
    
    for i=1:(nd-1)
        for j=1:Ncolumns
            try
                data_s{i,j}=temp{i,j};
            catch
            end
            
        end    
    end  
    
    for i=(nd+1):Nrows
        for j=1:Ncolumns
            try
                data_s{i-1,j}=temp{i,j};
            catch
            end
            
        end    
    end      
    
    Nrows=Nrows-1;
    set(handles.listbox_num,'Value',Nrows);    
end
 
set(handles.uitable_data,'Data',data_s);
 


% --- Executes on selection change in listbox_delete_array.
function listbox_delete_array_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_delete_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_delete_array contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_delete_array


% --- Executes during object creation, after setting all properties.
function listbox_delete_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_delete_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_duration_Callback(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_duration as text
%        str2double(get(hObject,'String')) returns contents of edit_duration as a double


% --- Executes during object creation, after setting all properties.
function edit_duration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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
set(handles.uipanel_save,'Visible','off');

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



function edit_SR_Callback(hObject, eventdata, handles)
% hObject    handle to edit_SR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_SR as text
%        str2double(get(hObject,'String')) returns contents of edit_SR as a double


% --- Executes during object creation, after setting all properties.
function edit_SR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_SR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'THM');
output_name=get(handles.edit_output_array_name,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 



% --- Executes on key press with focus on edit_duration and none of its controls.
function edit_duration_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_SR and none of its controls.
function edit_SR_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_SR (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on uitable_data and none of its controls.
function uitable_data_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to uitable_data (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');



function edit_save_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_save_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_save_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_save_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_save_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_save_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function varargout = psd_max_interp2(varargin)
% PSD_MAX_INTERP2 MATLAB code for psd_max_interp2.fig
%      PSD_MAX_INTERP2, by itself, creates a new PSD_MAX_INTERP2 or raises the existing
%      singleton*.
%
%      H = PSD_MAX_INTERP2 returns the handle to a new PSD_MAX_INTERP2 or the handle to
%      the existing singleton*.
%
%      PSD_MAX_INTERP2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PSD_MAX_INTERP2.M with the given input arguments.
%
%      PSD_MAX_INTERP2('Property','Value',...) creates a new PSD_MAX_INTERP2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before psd_max_interp2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to psd_max_interp2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help psd_max_interp2

% Last Modified by GUIDE v2.5 16-Dec-2019 11:11:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @psd_max_interp2_OpeningFcn, ...
                   'gui_OutputFcn',  @psd_max_interp2_OutputFcn, ...
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


% --- Executes just before psd_max_interp2 is made visible.
function psd_max_interp2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to psd_max_interp2 (see VARARGIN)

% Choose default command line output for psd_max_interp2
handles.output = hObject;

listbox_num_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes psd_max_interp2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = psd_max_interp2_OutputFcn(hObject, eventdata, handles) 
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

delete(psd_max_interp);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

setappdata(0,'fig_num',1);


Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');

fig_num=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%

fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_fmax,'String'));

N=48;


[new_freq,omega,np]=frequencies_octave_spaced(fmin,fmax,N);


%%%

get_table_data(hObject, eventdata, handles);

array_name=getappdata(0,'array_name'); 
      aleg=getappdata(0,'aleg');

num=get(handles.listbox_num,'Value');

THM(:,1)=new_freq;

psd_sum=zeros(np,1);
grms=zeros(np,1);

for i=1:num
    try
        FS=array_name{i};
        aq=evalin('base',FS);  
    catch
        warndlg('Input array not found ');
        return; 
    end      
    
    f=aq(:,1);
    a=aq(:,2);
   
    [~,grms(i)] = calculate_PSD_slopes(f,a);
    
    leg{i+1}=sprintf('%s  %6.3g GRMS',aleg{i},grms(i));
    
    try
        [fi,ai] = interpolate_PSD_arbitary_frequency(f,a,new_freq);
    catch
        i
        f
        a
    end
        
    for j=1:np
        
        [~,k]=min(abs(fi-new_freq(j)));
        
        THM(j,i+2)=ai(k);
        
    end
    
end

psd_mean=zeros(np,1);
psd_max=zeros(np,1);

size(THM)

for i=1:np
    psd_mean(i)=mean(THM(i,3:end));    
     psd_max(i)=max(THM(i,3:end));
end    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

THM(:,2)=psd_mean;

[~,agrms] = calculate_PSD_slopes(new_freq,psd_mean);

leg{1}=sprintf('Mean  %6.3g GRMS',agrms);


t_string=get(handles.edit_title,'String');



x_label='Frequency (Hz)';
y_label='Accel (G^2/Hz)';
md=6;


[fig_num,h2]=plot_loglog_function_md_seven_h2(fig_num,x_label,...
               y_label,t_string,THM,leg,fmin,fmax,md);

output_name_mean=t_string;          
           
output_name_mean=strrep(output_name_mean,'   ','_');
output_name_mean=strrep(output_name_mean,'  ','_');
output_name_mean=strrep(output_name_mean,' ','_');
output_name_mean=sprintf('%s_mean',output_name_mean);

out1=sprintf('Output array:  %s',output_name_mean);
disp(out1);

assignin('base', output_name_mean, [THM(:,1) THM(:,2)] );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

THM(:,2)=psd_max;

[~,agrms] = calculate_PSD_slopes(new_freq,psd_max);

leg{1}=sprintf('Max  %6.3g GRMS',agrms);


t_string=get(handles.edit_title,'String');




x_label='Frequency (Hz)';
y_label='Accel (G^2/Hz)';
md=6;


[fig_num,h2]=plot_loglog_function_md_seven_h2(fig_num,x_label,...
               y_label,t_string,THM,leg,fmin,fmax,md);

output_name_max=t_string;          
           
output_name_max=strrep(output_name_max,'   ','_');
output_name_max=strrep(output_name_max,'  ','_');
output_name_max=strrep(output_name_max,' ','_');
output_name_max=sprintf('%s_max',output_name_max);

out1=sprintf('Output array:  %s',output_name_max);
disp(out1);

assignin('base', output_name_max, [THM(:,1) THM(:,2)] );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on selection change in listbox_num.
function listbox_num_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num

Ncolumns=2;


%%%%
 
Nrows=get(handles.listbox_num,'Value');
 
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
 
cn={'PSD Name','Legend'};
set(handles.uitable_data,'Data',data_s,'ColumnName',cn);





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

Nrows=get(handles.listbox_num,'Value');
 
Ncolumns=2;
 
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


% --- Executes on selection change in listbox_delete.
function listbox_delete_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_delete contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_delete
Nrows=get(handles.listbox_num,'Value');

Ncolumns=2;
 
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

nd=get(handles.listbox_delete,'Value');

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

cn={'PSD Name','Legend'};
set(handles.uitable_data,'Data',data_s,'ColumnName',cn);


% --- Executes during object creation, after setting all properties.
function listbox_delete_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function get_table_data(hObject, eventdata, handles)

try
    data=get(handles.uitable_data,'Data');
    A=char(data);
    setappdata(0,'data',data);
    
    
    N=get(handles.listbox_num,'Value');

    k=1;

    
    for i=1:N
        array_name{i}=A(k,:); k=k+1;
        array_name{i} = strtrim(array_name{i});
        data_s{i,1}=array_name{i};
    end 
    
    for i=1:N
        aleg{i}=A(k,:); k=k+1;
        aleg{i} = strtrim(aleg{i});
        data_s{i,2}=aleg{i};       
    end 
    
    try
        set(handles.uitable_data,'Data',data_s);
    catch
        warndlg('Put back failed');
    end
    
catch
    warndlg('Input Arrays read failed');
    return;
end

setappdata(0,'array_name',array_name); 
setappdata(0,'aleg',aleg);



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


% --- Executes on button press in pushbutton_save_model.
function pushbutton_save_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    A=get(handles.uitable_data,'Data');
    PSDmax.A=A;   
catch
end

try
    num=get(handles.listbox_num,'Value');
    PSDmax.num=num;   
catch
end

try
    title=get(handles.edit_title,'String');
    PSDmax.title=title;   
catch
end

try
    fmin=get(handles.edit_fmin,'String');
    PSDmax.fmin=fmin;   
catch
end

try
    fmax=get(handles.edit_fmax,'String');
    PSDmax.fmax=fmax;   
catch
end



% % %
 
structnames = fieldnames(PSDmax, '-full'); % fields in the struct
   
[writefname, writepname] = uiputfile('*.mat','Save data as');
 
writepfname = fullfile(writepname, writefname);
    
pattern = '.mat';
replacement = '';
sname=regexprep(writefname,pattern,replacement);
   
elk=sprintf('%s%s',writepname,writefname);

    try
 
        save(elk, 'PSDmax'); 
 
    catch
        warndlg('Save error');
        return;
    end
 

msgbox('Save Complete');

%%%%%%%%%%%%%%%%%%%%


% --- Executes on button press in pushbutton_load_model.
function pushbutton_load_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_model (see GCBO)
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
 
   PSDmax=evalin('base','PSDmax');
 
catch
   warndlg(' evalin failed ');
   return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


try
    A=PSDmax.A;    
    set(handles.uitable_data,'Data',A);
catch
end

try
    num=PSDmax.num;     
    set(handles.listbox_num,'Value',num);
catch
end

try
    title=PSDmax.title;    
    set(handles.edit_title,'String',title);
catch
end

try
    fmin=PSDmax.fmin;      
    set(handles.edit_fmin,'String',fmin);
catch
end

try
    fmax=PSDmax.fmax;       
    set(handles.edit_fmax,'String',fmax);
catch
end

listbox_num_Callback(hObject, eventdata, handles);

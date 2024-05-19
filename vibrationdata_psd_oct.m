function varargout = vibrationdata_psd_oct(varargin)
% VIBRATIONDATA_PSD_OCT MATLAB code for vibrationdata_psd_oct.fig
%      VIBRATIONDATA_PSD_OCT, by itself, creates a new VIBRATIONDATA_PSD_OCT or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_PSD_OCT returns the handle to a new VIBRATIONDATA_PSD_OCT or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_PSD_OCT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_PSD_OCT.M with the given input arguments.
%
%      VIBRATIONDATA_PSD_OCT('Property','Value',...) creates a new VIBRATIONDATA_PSD_OCT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_psd_oct_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_psd_oct_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_psd_oct

% Last Modified by GUIDE v2.5 02-Nov-2020 13:53:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_psd_oct_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_psd_oct_OutputFcn, ...
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


% --- Executes just before vibrationdata_psd_oct is made visible.
function vibrationdata_psd_oct_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_psd_oct (see VARARGIN)

% Choose default command line output for vibrationdata_psd_oct
handles.output = hObject;

listbox_output_format_Callback(hObject, eventdata, handles);

set(handles.listbox_octave_format,'Value',1);

set(handles.listbox_method,'Value',1);
set(handles.listbox_type,'Value',1);

set(handles.pushbutton_calculate,'Enable','off');

set(handles.edit_output_array,'Enable','off');
set(handles.pushbutton_save,'Enable','off')


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_psd_oct wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_psd_oct_OutputFcn(hObject, eventdata, handles) 
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

data=getappdata(0,'PSD');

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


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method

set(handles.pushbutton_calculate,'Enable','off');

n=get(hObject,'Value');

set(handles.edit_output_array,'Enable','off');

set(handles.pushbutton_save,'Enable','off');

set(handles.edit_input_array,'String',' ');

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');

if(n==1)
   set(handles.edit_input_array,'enable','on') 
else
   set(handles.edit_input_array,'enable','off')
   set(handles.text_input_array_name,'Visible','off');
   set(handles.edit_input_array,'Visible','off');   
   
   [filename, pathname] = uigetfile('*.*');
   filename = fullfile(pathname, filename);
   fid = fopen(filename,'r');
   THM = fscanf(fid,'%g %g',[2 inf]);
   THM=THM';
    
   setappdata(0,'THM',THM);
   
   set(handles.pushbutton_calculate,'Enable','on');
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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig_num=1;

oform=get(handles.listbox_output_format,'Value');
iform=get(handles.listbox_input_format,'Value');

set(handles.edit_output_array,'Enable','on');
set(handles.pushbutton_save,'Enable','on')

k=get(handles.listbox_method,'Value');

YS=get(handles.edit_ylabel_input,'String');

 
if(k==1)
  FS=get(handles.edit_input_array,'String');
  THM=evalin('base',FS);   
else
  THM=getappdata(0,'THM');
end

if(THM(:,1)<1.0e-20)
    THM(1,:)=[];
end

THM=sortrows(THM,1);

sminf=get(handles.edit_fmin,'String');
smaxf=get(handles.edit_fmax,'String');

if isempty(sminf)
    string=sprintf('%8.4g',THM(1,1));
    set(handles.edit_fmin,'String',string);
end

if isempty(smaxf)
    string=sprintf('%8.4g',THM(end,1));    
    set(handles.edit_fmax,'String',string);
end


fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_fmax,'String'));

f=THM(:,1);
amp=THM(:,2);

fstart=f(1);
fend=f(end);

[~,ii]=min(abs(f-fmin));
[~,jj]=min(abs(f-fmax));

f=f(ii:jj,1);
amp=amp(ii:jj,1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(oform==1)
    
    df=str2double(get(handles.edit_df,'String'));
    
    new_freq(1)=fstart;
    
    k=2;
    while(1)
        new_freq(k)=new_freq(k-1)+df;
        
        if(new_freq(k)>=fend)
            break;
        end
        
        k=k+1;
    end
    
    [fi,ai] = interpolate_PSD_arbitrary_frequency_f(f,amp,new_freq);
    
    [~,rms] = calculate_PSD_slopes(fi,ai);
%
    power_spectral_density=[fi ai];      
   
    ff=fi;
    ossum=ai;
    
else

    ioct=get(handles.listbox_octave_format,'Value');
    [fl,fc,fu,imax]=octaves_alt(ioct);
    
    df=0.05;

    if(iform==1)

        n=floor((fend-fstart)/df);
%
        upper=(n*df)+fstart;

        x=THM(ii:jj,1);
        y=THM(ii:jj,2);
    
        f = linspace(fstart,upper,n+1); 
        amp = interp1(x,y,f);
    
    else
    
        s=0;
    
        a=THM(:,2);
    
        [fi,ai] = interpolate_PSD(f,a,s,df);
        amp=ai;
        f=fi;
    end
    
    [ff,ossum,power_spectral_density,rms]=psd_oct_conversion(f,amp,fl,fc,fu);    
    
%
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp(' Format:  %9.5g '); 
disp(' ');

nbb=length(ff);

for i=1:nbb
    out1=sprintf(' %9.5g \t %9.5g ',ff(i),ossum(i));
    disp(out1); 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
m=get(handles.listbox_type,'Value');
%
t_string=sprintf('Power Spectral Density %6.3g %sRMS Overall ',YS,rms);

k = strfind(YS,'/');

if(m==1)
    out2=sprintf('Accel (%s^2/Hz)',YS);
    if( k>=1)
      out2=sprintf('Accel ((%s)^2/Hz)',YS);        
    end
end
if(m==2)
    out2=sprintf('Vel ((%s)^2/Hz)',YS);
    if( k>=1)
      out2=sprintf('Vel ((%s)^2/Hz)',YS);        
    end    
end
if(m==3)
    out2=sprintf('Disp (%s^2/Hz)',YS);
end
if(m==4)
    out2=sprintf('Force (%s^2/Hz)',YS);
end
if(m==5)
    out2=sprintf('Pressure (%s^2/Hz)',YS);
    if( k>=1)
      out2=sprintf('Pressure ((%s)^2/Hz)',YS);        
    end     
end
if(m==6)
    out2=sprintf('(%s^2/Hz)',YS);
end

xlab='Frequency (Hz)';
ylab=out2;



 t_string=...
    sprintf(' Power Spectral Density  Overall Level = %6.3g %sRMS ',rms,YS); 
    [fig_num,h]=plot_PSD_function(fig_num,xlab,ylab,t_string,power_spectral_density,fmin,fmax);

setappdata(0,'PSD',power_spectral_density);

%%%%

% THM
% power_spectral_density   rms


q=diff(THM(:,1));

ratio=(max(q)-min(q))/min(q);

if( ratio > 0.05 )
    [~,THM_rms] = calculate_PSD_slopes(THM(:,1),THM(:,2));
else
    THM_rms=sqrt(sum(THM(:,2))*mean(q));    
end

md=6;
x_label=xlab;
y_label=ylab;
ppp1=power_spectral_density;
ppp2=THM;

t_string='Power Spectral Density';
leg1=sprintf('%6.3g %sRMS',rms,YS);
leg2=sprintf('%6.3g %sRMS',THM_rms,YS);

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);

%%%%


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(vibrationdata_psd_oct);


% --- Executes on selection change in listbox_octave_format.
function listbox_octave_format_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_octave_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_octave_format contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_octave_format


% --- Executes during object creation, after setting all properties.
function listbox_octave_format_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_octave_format (see GCBO)
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

set(handles.pushbutton_calculate,'Enable','on');


% --- Executes on selection change in listbox_input_format.
function listbox_input_format_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_input_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_input_format contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_input_format


% --- Executes during object creation, after setting all properties.
function listbox_input_format_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_input_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_output_format.
function listbox_output_format_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output_format contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output_format

n=get(handles.listbox_output_format,'Value');

set(handles.text_df,'Visible','off');
set(handles.edit_df,'Visible','off');
set(handles.text_oct,'Visible','off');
set(handles.listbox_octave_format,'Visible','off');

if(n==1)
    set(handles.text_df,'Visible','on');
    set(handles.edit_df,'Visible','on');
else
    set(handles.text_oct,'Visible','on');
    set(handles.listbox_octave_format,'Visible','on');    
end


% --- Executes during object creation, after setting all properties.
function listbox_output_format_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_df_Callback(hObject, eventdata, handles)
% hObject    handle to edit_df (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_df as text
%        str2double(get(hObject,'String')) returns contents of edit_df as a double


% --- Executes during object creation, after setting all properties.
function edit_df_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_df (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

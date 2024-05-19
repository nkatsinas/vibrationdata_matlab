function varargout = vibrationdata_cpsd_ensemble(varargin)
% VIBRATIONDATA_CPSD_ENSEMBLE MATLAB code for vibrationdata_cpsd_ensemble.fig
%      VIBRATIONDATA_CPSD_ENSEMBLE, by itself, creates a new VIBRATIONDATA_CPSD_ENSEMBLE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_CPSD_ENSEMBLE returns the handle to a new VIBRATIONDATA_CPSD_ENSEMBLE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_CPSD_ENSEMBLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_CPSD_ENSEMBLE.M with the given input arguments.
%
%      VIBRATIONDATA_CPSD_ENSEMBLE('Property','Value',...) creates a new VIBRATIONDATA_CPSD_ENSEMBLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_cpsd_ensemble_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_cpsd_ensemble_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_cpsd_ensemble

% Last Modified by GUIDE v2.5 23-Aug-2021 13:45:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_cpsd_ensemble_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_cpsd_ensemble_OutputFcn, ...
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


% --- Executes just before vibrationdata_cpsd_ensemble is made visible.
function vibrationdata_cpsd_ensemble_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_cpsd_ensemble (see VARARGIN)

% Choose default command line output for vibrationdata_cpsd_ensemble
handles.output = hObject;

listbox_time_Callback(hObject, eventdata, handles);

set(handles.listbox_type,'Value',1);
set(handles.listbox_window,'Value',2);

set(handles.edit_ylabel_input,'String','G');

set(handles.pushbutton_calculate,'Enable','off');

set(handles.listbox_numrows,'Enable','off');
set(handles.listbox_numrows,'Visible','off');
set(handles.text_select_option,'Visible','off');

set(handles.uitable_advise,'Visible','off');

set(handles.pushbutton_save,'Enable','off');

set(handles.pushbutton_view_options,'Enable','on');

set(handles.edit_fmax,'String','');
set(handles.edit_fmin,'String','');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_cpsd_ensemble wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_cpsd_ensemble_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


disp(' ');
disp(' * * * * * * * ');
disp(' ');

try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end  

fig_num=1;

sfmin=get(handles.edit_fmin,'String');
sfmax=get(handles.edit_fmax,'String');


if isempty(sfmin)
    string=sprintf('%8.4g',df);
    set(handles.edit_fmin,'String',string); 
    sfmin=get(handles.edit_fmin,'String');    
end

if isempty(sfmax)
    sr=1/dt;
    nyf=sr/2;    
    string=sprintf('%8.4g',nyf);
    set(handles.edit_fmax,'String',string);
    sfmax=get(handles.edit_fmax,'String');    
end

fmin=str2num(sfmin);
fmax=str2num(sfmax);

pfmin=fmin;
pfmax=fmax;


t=getappdata(0,'t');
a=getappdata(0,'a');
b=getappdata(0,'b');


data1=[ t a ];
data2=[ t b ];

YS=get(handles.edit_ylabel_input,'String');
m=get(handles.listbox_type,'Value');

xlabel2='Time(sec)';

ylabel1=sprintf('(%s)',YS);
ylabel2=sprintf('(%s)',YS);

if(m==1)
    ylabel1=sprintf('Accel (%s)',YS);
    ylabel2=sprintf('Accel (%s)',YS);    
end
if(m==2)
    ylabel1=sprintf('Vel (%s)',YS);
    ylabel2=sprintf('Vel (%s)',YS);    
end
if(m==3)
    ylabel1=sprintf('Disp (%s)',YS);
    ylabel2=sprintf('Disp (%s)',YS);    
end
if(m==4)
    ylabel1=sprintf('Force (%s)',YS);
    ylabel2=sprintf('Force (%s)',YS);    
end
if(m==5)
    ylabel1=sprintf('Pressure (%s)',YS);
    ylabel2=sprintf('Pressure (%s)',YS);    
end

t_string1='First Signal';
t_string2='Second Signal';

[fig_num]=subplots_two_linlin_two_titles(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2);

A=a;
B=b;

%%

k = strfind(YS,'/');

if(m==1)
    yout=sprintf('Accel (%s^2/Hz)',YS);
    if( k>=1)
      yout=sprintf('Accel ((%s)^2/Hz)',YS);        
    end
end
if(m==2)
    yout=sprintf('Vel ((%s)^2/Hz)',YS);
    if( k>=1)
      yout=sprintf('Vel ((%s)^2/Hz)',YS);        
    end    
end
if(m==3)
    yout=sprintf('Disp (%s^2/Hz)',YS);
end
if(m==4)
    yout=sprintf('Force (%s^2/Hz)',YS);
end
if(m==5)
    yout=sprintf('Pressure (%s^2/Hz)',YS);
    if( k>=1)
      yout=sprintf('Pressure ((%s)^2/Hz)',YS);        
    end     
end
if(m==6)
    yout=sprintf('(%s^2/Hz)',YS);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dt=getappdata(0,'dt');

nv=get(handles.listbox_numrows,'Value');
num_seg=getappdata(0,'num_seg');
samples_seg=getappdata(0,'samples_seg');

NW=num_seg(nv);

mmm=samples_seg(nv);

mH=floor(((mmm/2)-1));

%
df=1/(mmm*dt);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mr_choice=get(handles.listbox_mean_removal,'Value');

h_choice =get(handles.listbox_window,'Value');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[freq,COH,CPSD,PSD_A,PSD_B,~,~,~,~,~,~,~,~,~,~]=...
                        CPSD_function(A,B,NW,mmm,mH,mr_choice,h_choice,df);

CPSD_mag=abs(CPSD);
CPSD_phase=(180/pi)*atan2(imag(CPSD),real(CPSD));
ff=fix_size(freq);


fz=length(ff);
CPSD_phase=CPSD_phase(1:fz);
CPSD_mag=CPSD_mag(1:fz);

[~,rms] = calculate_PSD_slopes_fmin_fmax(ff,CPSD_mag,pfmin,pfmax);
[~,rms1] = calculate_PSD_slopes_fmin_fmax(ff,PSD_A,pfmin,pfmax);
[~,rms2] = calculate_PSD_slopes_fmin_fmax(ff,PSD_B,pfmin,pfmax);    
%   
     
%
fprintf('\n CPSD Overall RMS = %10.3g \n',rms);
fprintf(' CPSD Three Sigma = %10.3g \n\n',3*rms);
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


md=6;

xlab='Frequency (Hz)';
ylab=yout;

ff=fix_size(ff);

LF=length(ff);

t_string=sprintf(' PSD  Signal 1  %6.3g %sRMS Overall ',rms1,YS); 
power_spectral_density=[ff PSD_A(1:LF)];
[fig_num]=plot_loglog_function_md(fig_num,xlab,ylab,t_string,power_spectral_density,pfmin,pfmax,md);

t_string=sprintf(' PSD  Signal 2  %6.3g %sRMS Overall ',rms2,YS); 
power_spectral_density=[ff PSD_B(1:LF)];
[fig_num]=plot_loglog_function_md(fig_num,xlab,ylab,t_string,power_spectral_density,pfmin,pfmax,md);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   if(m==1)
        t_string=sprintf('Cross Power Spectral Density %6.3g %sRMS Overall ',rms,YS);
   else 
        t_string=sprintf('Cross Power Spectral Density %6.3g %s rms Overall ',rms,YS);       
   end
   
   [fig_num]=plot_CPSD(fig_num,t_string,ff,CPSD_mag,CPSD_phase,COH,pfmin,pfmax,yout);  
%
   [~,fmax]=find_max([ff CPSD_mag]);
%
   fprintf('\n Peak occurs at %10.5g Hz \n',fmax);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

R = corrcoef(A,B);
rho=R(1,2);

fprintf('\n Pearson correlation coefficent = %8.4g \n\n',rho);

cpsd=[ff CPSD_mag CPSD_phase];
setappdata(0,'Cross_PSD',cpsd);

set(handles.pushbutton_save,'Enable','on');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_cpsd_ensemble);


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


% --- Executes on selection change in listbox_window.
function listbox_window_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_window contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_window


% --- Executes during object creation, after setting all properties.
function listbox_window_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_view_options.
function pushbutton_view_options_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view_options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.listbox_numrows,'Visible','on');
set(handles.listbox_numrows,'Enable','on');
set(handles.text_select_option,'Visible','on');

set(handles.uitable_advise,'Visible','on');
set(handles.uitable_advise,'Enable','on');

THM=getappdata(0,'THM_C');

ntime=get(handles.listbox_time,'Value');

if(ntime==1)
    t=THM(:,1);
    a=THM(:,2);
    b=THM(:,3);
    
    istart=1;
    iend=length(t);
else    
    tstart=str2num(get(handles.edit_start_time,'String'));
      tend=str2num(get(handles.edit_end_time,'String'));   
      
     [~,istart]=min(abs(tstart-THM(:,1)));      
       [~,iend]=min(abs(tend-THM(:,1)));      
             
    t=THM(istart:iend,1);
    a=THM(istart:iend,2);
    b=THM(istart:iend,3);       
end

setappdata(0,'t',t);
setappdata(0,'a',a);
setappdata(0,'b',b);


fprintf('\n Number of   Samples per   Time per        df              \n');
fprintf(' Segments     Segment      Segment(sec)   (Hz)     dof     \n');
%

tim=THM(:,1);

n=length(tim);

dur=tim(end)-tim(1);

dt=mean(diff(tim));

nj=floor(log2(n));

njt=min([12 nj]);

    num_seg=zeros(njt,1);
   time_seg=zeros(njt,1);
samples_seg=zeros(njt,1);
       data=zeros(njt,5);

for i=1:njt
    num_seg(i)=2^(i-1);
    time_seg(i)=dur/num_seg(i);
    samples_seg(i)=floor(n/num_seg(i));
    ddf=1/time_seg(i);
    fprintf(' \t  %d  \t  %d  \t   %6.3f  \t  %6.3f \t %d \n',num_seg(i),samples_seg(i),time_seg(i),ddf,2*num_seg(i));   
    data(i,:)=[num_seg(i),samples_seg(i),time_seg(i),ddf,2*num_seg(i)];
    handles.number(i)=i;
end    

cn={' No. of Segments ',' Samples/Segments ',' Time/Segment (sec) ',' df (Hz) ',' dof '};

set(handles.uitable_advise,'Data',data,'ColumnWidth','auto','ColumnName',cn);

set(handles.listbox_numrows,'String',handles.number);

set(handles.listbox_numrows,'Enable','on','Visible','on');

%%%%%%%%%

setappdata(0,'n1',istart);
setappdata(0,'n2',iend);
setappdata(0,'dt',dt);
setappdata(0,'num_seg',num_seg);
setappdata(0,'samples_seg',samples_seg);

set(handles.pushbutton_calculate,'Enable','on');


cn={'No. of Segments ','Samples/Segments','Time/Segment (sec)','df (Hz)','dof'};

set(handles.uitable_advise,'Data',data,'ColumnWidth','auto','ColumnName',cn);

setappdata(0,'advise_data',data);

%%%%%%%%


% --- Executes on selection change in listbox_numrows.
function listbox_numrows_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_numrows (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_numrows contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_numrows


% --- Executes during object creation, after setting all properties.
function listbox_numrows_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_numrows (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


cpsd=getappdata(0,'Cross_PSD');

output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, cpsd);

h = msgbox('Save Complete.  Format: freq, magnitude, phase'); 


% --- Executes on button press in pushbutton_view_options.
function pushbutton_view_processing_options_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view_options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit_start_time_Callback(hObject, eventdata, handles)
% hObject    handle to edit_start_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_start_time as text
%        str2double(get(hObject,'String')) returns contents of edit_start_time as a double


% --- Executes during object creation, after setting all properties.
function edit_start_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_start_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit_end_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_end_time as text
%        str2double(get(hObject,'String')) returns contents of edit_end_time as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_end_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_end_time_Callback(hObject, eventdata, handles)
% hObject    handle to edit_end_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_end_time as text
%        str2double(get(hObject,'String')) returns contents of edit_end_time as a double


% --- Executes during object creation, after setting all properties.
function edit_end_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_end_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_time.
function listbox_time_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_time contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_time
n=get(handles.listbox_time,'Value');

if(n==1)
    set(handles.edit_start_time,'Visible','off');
    set(handles.edit_end_time,'Visible','off');    
    set(handles.text_start_time,'Visible','off');
    set(handles.text_end_time,'Visible','off');       
else
    set(handles.edit_start_time,'Visible','on');
    set(handles.edit_end_time,'Visible','on');    
    set(handles.text_start_time,'Visible','on');
    set(handles.text_end_time,'Visible','on');           
end


% --- Executes during object creation, after setting all properties.
function listbox_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

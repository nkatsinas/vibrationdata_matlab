function varargout = vibrationdata_fourier_transform(varargin)
% VIBRATIONDATA_FOURIER_TRANSFORM MATLAB code for vibrationdata_fourier_transform.fig
%      VIBRATIONDATA_FOURIER_TRANSFORM, by itself, creates a new VIBRATIONDATA_FOURIER_TRANSFORM or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_FOURIER_TRANSFORM returns the handle to a new VIBRATIONDATA_FOURIER_TRANSFORM or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_FOURIER_TRANSFORM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_FOURIER_TRANSFORM.M with the given input arguments.
%
%      VIBRATIONDATA_FOURIER_TRANSFORM('Property','Value',...) creates a new VIBRATIONDATA_FOURIER_TRANSFORM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_fourier_transform_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_fourier_transform_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_fourier_transform

% Last Modified by GUIDE v2.5 29-May-2019 08:39:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_fourier_transform_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_fourier_transform_OutputFcn, ...
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


% --- Executes just before vibrationdata_fourier_transform is made visible.
function vibrationdata_fourier_transform_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_fourier_transform (see VARARGIN)

% Choose default command line output for vibrationdata_fourier_transform
handles.output = hObject;

set(handles.listbox_output,'Value',1);
set(handles.listbox_method,'Value',1);
set(handles.listbox_mean_removal,'Value',1);
set(handles.listbox_window,'Value',1);
set(handles.edit_output_filename,'Enable','off');
set(handles.listbox_output,'Enable','off');
set(handles.pushbutton_save,'Enable','off');

set(handles.listbox_destination,'Value',1);
listbox_destination_Callback(hObject, eventdata, handles);

listbox_time_Callback(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_fourier_transform wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_fourier_transform_OutputFcn(hObject, eventdata, handles) 
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


mdest=get(handles.listbox_destination,'Value');

n=get(handles.listbox_output,'Value');

if(n==1)
    data=getappdata(0,'magnitude_FT');
end  
if(n==2)
    data=getappdata(0,'magnitude_phase_FT');
end 
if(n==3)
    if(mdest==1)  % Matlab workspace
        data=getappdata(0,'complex_FT_2c');
    else          % Excel
        data=getappdata(0,'complex_FT_3c');        
    end
end 
if(n==4)
    data=getappdata(0,'Gxx');
end 


if(mdest==1)
    output_name=get(handles.edit_output_filename,'String');
    assignin('base', output_name,data);
end
if(mdest==2)
    
    [writefname, writepname] = uiputfile('*.xls','Save model as Excel file')
    writepfname = fullfile(writepname, writefname);
    
    c=[num2cell(data)]; % 1 element/cell
    xlswrite(writepfname,c);

end
    
h = msgbox('Export Complete.  Press Return. '); 




function edit_output_filename_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_filename as text
%        str2double(get(hObject,'String')) returns contents of edit_output_filename as a double


% --- Executes during object creation, after setting all properties.
function edit_output_filename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_output.
function listbox_output_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output


% --- Executes during object creation, after setting all properties.
function listbox_output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output (see GCBO)
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


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method
n=get(hObject,'Value');

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');

set(handles.edit_output_filename,'Enable','off');
set(handles.listbox_output,'Enable','off');

set(handles.pushbutton_save,'Enable','off');

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
   THM = fscanf(fid,'%g %g',[2 inf]);
   THM=THM';
    
   setappdata(0,'THM',THM);
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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%

Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
 
if(NFigures>5)
    NFigures=5;
end
 
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end
 
%%%%%%


set(handles.edit_output_filename,'Enable','on');
set(handles.listbox_output,'Enable','on');
set(handles.pushbutton_save,'Enable','on');

yname=get(handles.edit_ylabel,'String');

k=get(handles.listbox_method,'Value');
 
iflag=1;

if(k==1)
     try  
         FS=get(handles.edit_input_array,'String');
         THM=evalin('base',FS);  
         iflag=1;
     catch
         iflag=0; 
         warndlg('Input Array does not exist.  Try again.')
     end
else
  THM=getappdata(0,'THM');
end

if(iflag==0)
    return;
end   


ntime=get(handles.listbox_time,'Value');

if(ntime==2)
    tstart=str2num(get(handles.edit_start_time,'String'));
      tend=str2num(get(handles.edit_end_time,'String'));   
      
     [~,istart]=min(abs(tstart-THM(:,1)));      
       [~,iend]=min(abs(tend-THM(:,1)));      
       
    THM=THM(istart:iend,:);      
       
end

tend=THM(end,1);

tdif=diff(THM(:,1));

min_dt=min(tdif);
max_dt=max(tdif);

ratio=abs((max_dt-min_dt)/max_dt);

if(ratio>0.05)
    fprintf('\n\n min_dt=%8.4g  max_dt=%8.4g \n\n',min_dt,max_dt);
    warndlg('Time step must be constant');
    return;
end



amp=double(THM(:,2));

n=length(amp);

n=2*floor(n/2);
ttt=THM(1:n);
amp=amp(1:n);
ampa=amp;

dur=THM(n,1)-THM(1,1);
dt=dur/(n-1);
sr=1/dt;

df=1/(n*dt);

out1=sprintf('\n n=%d  dt=%8.4g  \n',n,dt);
disp(out1);

mr_choice=get(handles.listbox_mean_removal,'Value');

hw_choice=get(handles.listbox_window,'Value');


[amp]=mean_removal_Hanning(amp,mr_choice,hw_choice);


amp=fix_size(amp);

nhalf=floor(n/2);

[z,zz,f_real,f_imag,ms,freq,ff]=fourier_core(n,nhalf,df,amp);

phase=atan2(f_imag,f_real);


phase=fix_size(phase);

phase = phase*180/pi;

magnitude_FT=[ff zz];
magnitude_phase_FT=[ff zz phase(1:length(ff))];
complex_FT=[freq f_real f_imag];



%    
% [~,fmax]=find_max(magnitude_FT);

max_zz=0;
k=1;
for i=1:length(zz)
    if(zz(i)>max_zz)
        max_zz=zz(i);
        k=i;
    end
end

fmaxp=ff(k);

stt=get(handles.edit_max_freq,'String');

if  isempty(stt)
    sr;
    max_freq=sr/2;
    smf=sprintf('%8.4g',max_freq);
    set(handles.edit_max_freq,'String',smf);
else
    max_freq=str2num(stt);    
end

tend=tend+dt;

fmin=0;
fmax=max_freq;

fig_num=1;

if(hw_choice==1)
    figure(fig_num);
    fig_num=fig_num+1;
    plot(ttt,ampa);
    title('Time History');
    ylabel(yname);
    xlabel('Time (sec)');
    xlim([ttt(1) tend]);
    grid on;
else
    figure(fig_num);
    fig_num=fig_num+1;    
    subplot(2,1,1);   
    
    plot(THM(:,1),THM(:,2));
    title('Time History');
    ylabel(yname);
    xlabel('Time (sec)');
    xlim([ttt(1) tend]);
    grid on;
    
    subplot(2,1,2); 
    
    plot(ttt,amp);
    title('Time History with Hanning Window');
    ylabel(yname);
    xlabel('Time (sec)');
    xlim([ttt(1) tend]); 
    grid on;    
end

figure(fig_num);
fig_num=fig_num+1;
plot(ff,zz);
out1=sprintf('Fourier Transform Magnitude  Max Peak at %8.4g Hz',fmaxp);
title(out1);
ylabel(yname);
xlabel('Frequency (Hz)');
xlim([0 max_freq]);
grid on;

p=length(ff);


figure(fig_num);
fig_num=fig_num+1;
%
subplot(3,1,1);
plot(freq(1:p),phase(1:p));
out1=sprintf('Fourier Transform Magnitude & Phase  Max Peak at %8.4g Hz',fmaxp);
title(out1);
FRF_p=phase(1:p);
grid on;
ylabel('Phase (deg)');
axis([fmin,fmax,-180,180]);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin',...
                    'YScale','lin','ytick',[-180,-90,0,90,180]);
%
if(max(FRF_p)<=0.)
%
    axis([fmin,fmax,-180,0]);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin',...
                    'YScale','lin','ytick',[-180,-90,0]);
end  
%
if(min(FRF_p)>=-90. && max(FRF_p)<90.)
%
    axis([fmin,fmax,-90,90]);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin',...
                    'YScale','lin','ytick',[-90,0,90]);
end 
%
if(min(FRF_p)>=0.)
%
    axis([fmin,fmax,0,180]);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin',...
                    'YScale','lin','ytick',[0,90,180]);
end 
%
subplot(3,1,[2 3]);
plot(ff,zz);
xlim([fmin fmax])
grid on;
xlabel('Frequency(Hz)');
ylabel('Magnitude');
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin',...
         'YScale','lin');


setappdata(0,'magnitude_FT',magnitude_FT); 
setappdata(0,'magnitude_phase_FT',magnitude_phase_FT); 

complex_FT_2c=[ complex_FT(:,1)  (complex_FT(:,2)+(1i)*complex_FT(:,3))];

setappdata(0,'complex_FT_3c',complex_FT); 
setappdata(0,'complex_FT_2c',complex_FT_2c); 

%%%%%%%%%%

num=length(ff);

Gxx=zeros(num,1);

Gxx(1)=abs(complex_FT_2c(1,2));     

for i=2:num
     X=complex_FT_2c(i,2);     
	Gxx(i)=transpose(X)*X;
end

Gxx=[ff abs(Gxx)];

setappdata(0,'Gxx',Gxx);

%%%%%%%%%%


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_fourier_transform)

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



function edit_max_freq_Callback(hObject, eventdata, handles)
% hObject    handle to edit_max_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_max_freq as text
%        str2double(get(hObject,'String')) returns contents of edit_max_freq as a double


% --- Executes during object creation, after setting all properties.
function edit_max_freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_max_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_filename as text
%        str2double(get(hObject,'String')) returns contents of edit_output_filename as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_output.
function listbox10_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output


% --- Executes during object creation, after setting all properties.
function listbox10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_destination.
function listbox_destination_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_destination (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_destination contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_destination

n=get(handles.listbox_destination,'Value');

if(n==1)
    set(handles.text_array_name,'Visible','on');
    set(handles.edit_output_filename,'Visible','on');
else
    set(handles.text_array_name,'Visible','off');
    set(handles.edit_output_filename,'Visible','off');    
end


% --- Executes during object creation, after setting all properties.
function listbox_destination_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_destination (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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

function varargout = vibrationdata_statistics(varargin)
% VIBRATIONDATA_STATISTICS MATLAB code for vibrationdata_statistics.fig
%      VIBRATIONDATA_STATISTICS, by itself, creates a new VIBRATIONDATA_STATISTICS or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_STATISTICS returns the handle to a new VIBRATIONDATA_STATISTICS or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_STATISTICS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_STATISTICS.M with the given input arguments.
%
%      VIBRATIONDATA_STATISTICS('Property','Value',...) creates a new VIBRATIONDATA_STATISTICS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_statistics_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_statistics_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_statistics

% Last Modified by GUIDE v2.5 11-Oct-2018 18:24:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_statistics_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_statistics_OutputFcn, ...
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


% --- Executes just before vibrationdata_statistics is made visible.
function vibrationdata_statistics_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_statistics (see VARARGIN)

% Choose default command line output for vibrationdata_statistics
handles.output = hObject;


set(handles.listbox_method,'Value',1);

set(handles.edit_results,'Enable','off');

set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_statistics wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_statistics_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method
n=get(hObject,'Value');

set(handles.edit_input_array,'Visible','on');
set(handles.text_input_array_name,'Visible','on');

if(n==1)
   set(handles.edit_input_array,'enable','on') 
else
    
   set(handles.edit_input_array,'Visible','off');
   set(handles.text_input_array_name,'Visible','off'); 
   
   set(handles.edit_input_array,'enable','off')
   
   try
   
       [filename, pathname] = uigetfile('*.*');
       filename = fullfile(pathname, filename);
       fid = fopen(filename,'r');
       THM = fscanf(fid,'%g %g',[2 inf]);
       THM=THM';
    
       setappdata(0,'THM',THM);
       
       size(THM)
       
   catch
       warndlg('Read unsuccessful');
       return;
   end
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

k=get(handles.listbox_method,'Value');

clear_all_figures(vibrationdata_statistics);

set(handles.uipanel_save,'Visible','on');

set(handles.edit_results,'Enable','on');

t_string=get(handles.edit_title,'String');
tstring=t_string;

YS=get(handles.edit_ylabel,'String');


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


amp=double(THM(:,2));
tim=double(THM(:,1));
t=tim;
n = length(amp);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    duration=tim(n)-tim(1);
    dt=duration/(n-1);
    difft=diff(t);
    dtmin=min(difft);
    dtmax=max(difft);
%

    outa = sprintf('\n start  = %8.4g sec  ',t(1));
    outb = sprintf('\n end    = %8.4g sec  ',t(n));

    out4 = sprintf('\n dtmin  = %8.4g sec  ',dtmin);
    out5 = sprintf('\n dt     = %8.4g sec  ',dt);
    out6 = sprintf('\n dtmax  = %8.4g sec  ',dtmax);

%
    out7 = sprintf('\n srmin  = %8.4g samples/sec  ',1/dtmax);
    out8 = sprintf('\n sr     = %8.4g samples/sec  ',1/dt);
    out9 = sprintf('\n srmax  = %8.4g samples/sec  ',1/dtmin);

string1=sprintf(' %d samples ',n);

string_tss=sprintf('\n\n Time Limits ');

big_string=strcat(string1,string_tss);    
big_string=strcat(big_string,outa); 
big_string=strcat(big_string,outb); 

string_ts=sprintf('\n\n Time Step ');

big_string=strcat(big_string,string_ts);    
big_string=strcat(big_string,out4); 
big_string=strcat(big_string,out5); 
big_string=strcat(big_string,out6);

string_sr=sprintf('\n\n Sample Rate ');
big_string=strcat(big_string,string_sr); 
big_string=strcat(big_string,out7); 
big_string=strcat(big_string,out8); 
big_string=strcat(big_string,out9);

disp(big_string);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
disp(' ');
disp(' Calculating skewness & kurtosis ');


[mu,sd,rms,sk,kt]=kurtosis_stats(amp);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' Calculating Zero & Peak crossings ');

[pszcr,peak_rate,tpa,pa]=zero_crossing_function_alt(tim,amp,duration);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
string_amp=sprintf('\n\n Amplitude Stats ');
string2=sprintf('\n      mean = %8.4g ',mu);
string3=sprintf('\n   std dev = %8.4g ',sd);
string4=sprintf('\n       RMS = %8.4g ',rms);
string5=sprintf('\n  skewness = %8.4g ',sk);
string6=sprintf('\n  kurtosis = %8.4g ',kt);



big_string=strcat(big_string,string_amp);
big_string=strcat(big_string,string2);
big_string=strcat(big_string,string3);
big_string=strcat(big_string,string4);
big_string=strcat(big_string,string5);
big_string=strcat(big_string,string6);


    mx=max(amp);
    mi=min(amp);

    amax=abs(mx);
    amin=abs(mi);
    if(amax<amin)
        amax=amin;
    end
    crest=amax/rms;
    
string7=sprintf('\n\n      Maximum = %8.4g ',mx);
string8=sprintf('\n      Minimum = %8.4g ',mi);
string9=sprintf('\n Crest Factor = %8.4g ',crest);    
   

big_string=strcat(big_string,string7);
big_string=strcat(big_string,string8);
big_string=strcat(big_string,string9);

[rf]=Rice_frequency(amp,dt);

%
    string_rf=sprintf('\n\n Rice Characteristic Frequency = %8.4g Hz ',rf);

    string_zc=sprintf('\n Positive Slope Zero Cross Rate = %8.4g Hz ',pszcr);  
    string_pr=sprintf('\n Peak Rate = %8.4g Hz ',peak_rate);    

disp(string_rf);
disp(string_zc);
disp(string_pr);
    
big_string=strcat(big_string,string_rf);    
big_string=strcat(big_string,string_zc); 
big_string=strcat(big_string,string_pr);  
    
set(handles.edit_results,'String',big_string);




fig_num=1;

figure(fig_num);
fig_num=fig_num+1;
plot(THM(:,1),THM(:,2));
title('Time History');
xlabel(' Time(sec) ')
ylabel(YS)
grid on;

figure(fig_num);
fig_num=fig_num+1;
nbars=str2num(get(handles.edit_bars,'String'));
xx=max(abs(THM(:,2)));
x=linspace(-xx,xx,nbars);       
hist(THM(:,2),x)
ylabel('Counts');
title('Histogram');
xlabel(YS);
% qq=get(gca,'xlim');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x_label='Time (sec)';
y_label=YS;

nbars=str2num(get(handles.edit_bars,'String'));

[fig_num]=plot_time_history_histogram(fig_num,THM,t_string,x_label,y_label,nbars);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[nnn,xout]=hist(THM(:,2),nbars);
c_elements = cumsum(nnn);
figure(fig_num);
fig_num=fig_num+1;
bar(xout,c_elements);
title(' Cumulative Histogram ');
ylabel(' Counts ');
xlabel(YS);
grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(fig_num);
fig_num=fig_num+1;
xx=max(abs(pa));
nbar=floor(nbars/2);
x=linspace(0,xx,nbar);       
hist(pa,x)
ylabel(' Counts');
xlabel(YS);   
title('Absolute Peak Value Distribution'); 


[i1,i2]=hist(THM(:,2),x);
[p1,p2]=hist(pa,x);

i1=fix_size(i1);
i2=fix_size(i2);

p1=fix_size(p1);
p2=fix_size(p2);

ii=[i1 i2];
pp=[p1 p2];

setappdata(0,'ii',ii);
setappdata(0,'pp',pp);
setappdata(0,'pa',pa);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nv=get(handles.listbox_peak,'Value');


if(nv==1)

    THM=[tpa pa];

    t_string='Local Peak Absolute Values';
    x_label='Time(sec)';
    y_label=YS;
    grid on;

    nbars=31;

    [fig_num]=plot_time_history_histogram_peak(fig_num,THM,t_string,x_label,y_label,nbars);

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try

    [envp,envn]=time_history_envelope(THM(:,1),THM(:,2),dt,pszcr);

    figure(fig_num);
    fig_num=fig_num+1;
    plot(THM(:,1),THM(:,2),THM(:,1),envp,THM(:,1),envn);
    legend('Time History','Max Envelope','Min Envelope');
    title(tstring);
    xlabel('Time (sec)');
    ylabel(YS);
    grid on;

catch
end



disp(' ');
disp('plotting complete');
disp(' ');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_statistics);

% --- Executes on slider movement.
function slider_Callback(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
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



function edit_bars_Callback(hObject, eventdata, handles)
% hObject    handle to edit_bars (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_bars as text
%        str2double(get(hObject,'String')) returns contents of edit_bars as a double


% --- Executes during object creation, after setting all properties.
function edit_bars_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_bars (see GCBO)
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
    data=getappdata(0,'ii');
end    
if(n==2)
    data=getappdata(0,'pp');
end  
if(n==3)
    data=getappdata(0,'pa');
end  

output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 


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


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



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


% --- Executes on selection change in listbox_peak.
function listbox_peak_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_peak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_peak contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_peak


% --- Executes during object creation, after setting all properties.
function listbox_peak_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_peak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

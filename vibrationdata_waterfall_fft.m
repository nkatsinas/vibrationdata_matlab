function varargout = vibrationdata_waterfall_fft(varargin)
% VIBRATIONDATA_WATERFALL_FFT MATLAB code for vibrationdata_waterfall_fft.fig
%      VIBRATIONDATA_WATERFALL_FFT, by itself, creates a new VIBRATIONDATA_WATERFALL_FFT or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_WATERFALL_FFT returns the handle to a new VIBRATIONDATA_WATERFALL_FFT or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_WATERFALL_FFT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_WATERFALL_FFT.M with the given input arguments.
%
%      VIBRATIONDATA_WATERFALL_FFT('Property','Value',...) creates a new VIBRATIONDATA_WATERFALL_FFT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_waterfall_fft_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_waterfall_fft_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_waterfall_fft

% Last Modified by GUIDE v2.5 19-Apr-2022 14:36:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_waterfall_fft_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_waterfall_fft_OutputFcn, ...
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


% --- Executes just before vibrationdata_waterfall_fft is made visible.
function vibrationdata_waterfall_fft_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_waterfall_fft (see VARARGIN)

% Choose default command line output for vibrationdata_waterfall_fft
handles.output = hObject;

set(handles.listbox_color_choice,'Value',2);

listbox_magnitude_Callback(hObject, eventdata, handles);

set(handles.pushbutton_calculate,'Enable','off');
set(handles.pushbutton_view_options,'Enable','off');
set(handles.listbox_numrows,'Enable','off');
set(handles.listbox_numrows,'Visible','off');
set(handles.text_select_option,'Visible','off');

set(handles.uitable_advise,'Visible','off');

set(handles.listbox_method,'Value',1);
set(handles.listbox_overlap,'Value',1);
set(handles.edit_tmin,'String','');
set(handles.edit_tmax,'String','');
set(handles.edit_fmin,'String','');
set(handles.edit_fmax,'String','');

set(handles.listbox_psave,'Value',2);
set(handles.listbox_save_array,'Value',2);

set(handles.radiobutton1,'Value',1);
set(handles.radiobutton2,'Value',1);


listbox_method_Callback(hObject, eventdata, handles);

set(handles.pushbutton_calculate,'Enable','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_waterfall_fft wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_waterfall_fft_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_view_options.
function pushbutton_view_options_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view_options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


set(handles.pushbutton_calculate,'Enable','on');
set(handles.uitable_advise,'Visible','on');
set(handles.listbox_numrows,'Visible','on');
set(handles.text_select_option,'Visible','on');

set(handles.listbox_numrows,'String',' ');

k=get(handles.listbox_method,'Value');



if(k==1)
  try  
    FS=get(handles.edit_input_array,'String');
    THM=evalin('base',FS); 
    setappdata(0,'THM',THM);
  catch
    warndlg('Input data file unavailable');
    return;  
  end
else
  THM=getappdata(0,'THM');
end


%%%%%%%%%%%%

YS=get(handles.edit_ylabel,'String');

try
    close 1 hidden
catch
end 

figure(1);
plot(THM(:,1),THM(:,2));  
title('Input Time History');
xlabel(' Time(sec) ');
ylabel(YS);
grid on;


%%%%%%%%%%%%

t=THM(:,1);

n=length(t);


sts=get(handles.edit_tmin,'String');    
ste=get(handles.edit_tmax,'String'); 

if isempty(sts)
    string=sprintf('%8.4g',t(1));
    set(handles.edit_tmin,'String',string);
    ts=t(1);    
else
    ts=str2num(sts);
end

if isempty(ste)
    string=sprintf('%8.4g',t(n));
    set(handles.edit_tmax,'String',string);
    te=t(n);
else
    te=str2num(ste); 
end


tmx=t(n);
tmi=t(1);

if(ts>tmx)
    ts=tmx;
end
if(te<tmi)
    ts=tmi;
end

clear n1;
clear n2;
clear nf1;
clear nf2;


[~,n1]=min(abs(ts-THM(:,1)));
[~,n2]=min(abs(te-THM(:,1)));

THM=THM(n1:n2,:);

[THM,iflag]=time_check_with_linear_interpolation(THM);
%
if(iflag==999)
    return;
end

setappdata(0,'THM',THM);
setappdata(0,'iflag',iflag);

dt=mean(diff(THM(:,1)));

n=length(THM(:,1));

dur=THM(end,1)-THM(1,1);

fprintf('\n  n=%d  n1=%d  n2=%d  \n\n',n,n1,n2);

%%%%%%%%%

disp(' ');
fprintf(' Number of   Samples per   Time per    df \n');
fprintf('  Segments     Segment      Segment       \n');
%

nj=floor(log2(n));

njt=min([10 nj]);

    num_seg=zeros(njt,1);
   time_seg=zeros(njt,1);
samples_seg=zeros(njt,1);
       data=zeros(njt,4);

for i=1:njt
    num_seg(i)=2^(i-1);
    time_seg(i)=dur/num_seg(i);
    samples_seg(i)=floor(n/num_seg(i));
    ddf=1/time_seg(i);
    fprintf(' \t  %d  \t  %d  \t   %6.3f  \t  %6.3f \n',num_seg(i),samples_seg(i),time_seg(i),ddf);   
    data(i,:)=[num_seg(i),samples_seg(i),time_seg(i),ddf];
    handles.number(i)=i;
end    

cn={' No. of Segments ',' Samples/Segments ',' Time/Segment (sec) ',' df (Hz) '};

set(handles.uitable_advise,'Data',data,'ColumnWidth','auto','ColumnName',cn);

[~,nn]=min(abs(40-num_seg));

set(handles.listbox_numrows,'String',handles.number);

set(handles.listbox_numrows,'Value',nn,'Enable','on','Visible','on');

%%%%%%%%%

setappdata(0,'n1',n1);
setappdata(0,'n2',n2);
setappdata(0,'dt',dt);
setappdata(0,'num_seg',num_seg);
setappdata(0,'samples_seg',samples_seg);

set(handles.pushbutton_calculate,'Enable','on');

msgbox('Go to Calculate pushbutton');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_waterfall_fft);

% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% setdiff( findall(0, 'type', 'figure'), vibrationdata_waterfall_fft )

% clear_all_figures(vibrationdata_waterfall_fft);

try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end    

YS=get(handles.edit_ylabel,'String');
io=get(handles.listbox_overlap,'Value');

window=get(handles.listbox_window,'Value');

THM=getappdata(0,'THM');
iflag=getappdata(0,'iflag');

if(iflag==999)
    return;
end


figure(1);
plot(THM(:,1),THM(:,2));
title('Input Time History');
xlabel(' Time(sec) ');
ylabel(YS);
grid on;


samples_seg=getappdata(0,'samples_seg');

amp=THM(:,2);
tim=THM(:,1);

reference=1;

imag=get(handles.listbox_magnitude,'Value');

if(imag==3)
   reference=str2num(get(handles.edit_reference,'String')); 
end


dt=getappdata(0,'dt');

nv=get(handles.listbox_numrows,'Value');
num_seg=getappdata(0,'num_seg');

NW=num_seg(nv);

mmm=samples_seg(nv);

%
df=1/(mmm*dt);

%%%%

sminf=get(handles.edit_fmin,'String');
smaxf=get(handles.edit_fmax,'String');

if isempty(sminf)
    string=sprintf('%8.4g',df);
    set(handles.edit_fmin,'String',string);
end

if isempty(smaxf)
    sr=1/dt;
    nyf=sr/2;    
    string=sprintf('%8.4g',(nyf-df));
    set(handles.edit_fmax,'String',string);
end

minf=str2num(get(handles.edit_fmin,'String'));
maxf=str2num(get(handles.edit_fmax,'String'));

ff1=1.e-06;

if(minf<ff1)
    minf=ff1;
end

%%%%

tmi=tim(1);

fprintf('* mmm=%d   \n',mmm);
fprintf('* dt=%g   \n',dt);
fprintf('* mmm*dt=%g   \n',mmm*dt);


[mk,freq,time_a,dt,NW]=...
              waterfall_FFT_time_freq_set(mmm,NW,dt,df,maxf,tmi,io);

[store,store_p,freq_p,max_a,max_f]=...
              waterfall_FFT_core_window(NW,mmm,mk,freq,amp,minf,io,window,imag,reference);
%

freq_p=fix_size(freq_p);


if(minf<=ff1)
    minf=0;
end

fig_num=2;

i1=get(handles.radiobutton1,'Value');

if(i1==1)

    try
        close fig_num hidden
    catch    
    end     
    
    h2=figure(fig_num);
    fig_num=fig_num+1;
    
    set(gcf,'renderer','OpenGL' );
    
% surf(freq_p,time_a,store_p,'FaceColor','white','EdgeColor','interp','MeshStyle','row')
  
    waterfall(freq_p,time_a,store_p);

    color_choice=get(handles.listbox_color_choice,'Value');
    
    if(color_choice ==1)
        colormap(hsv(128));
    end  
    if(color_choice ==2)
        colormap(hsv(1));
    end    
    if(color_choice ==3)
        colormap(gray);
    end
    
    hXLabel=xlabel(' Frequency (Hz)');
    hYLabel=ylabel(' Time (sec)'); 

    if(imag<3)
        hZLabel=zlabel(' Magnitude');
    else
        hZLabel=zlabel(' Magnitude (dB)');    
    end
    
    hTitle=title('Waterfall FFT');
    view([-15 70]);   
% Adjust font
    fz=get(handles.listbox_fz,'Value');
    fz=fz+11;
    set(gca, 'FontName', 'Helvetica')
    set([hTitle, hXLabel, hYLabel, hZLabel], 'FontName', 'AvantGarde')
    set([hXLabel, hYLabel, hZLabel], 'FontSize', fz)
    set(hTitle, 'FontSize', fz, 'FontWeight' , 'bold')
    set(gca,'xlim',[minf maxf])
    set(gca,'Fontsize',fz);   
end

i2=get(handles.radiobutton2,'Value');

if(i2==1)
    
    try
        close fig_num hidden
    catch    
    end     

    figure(fig_num);
    fig_num=fig_num+1;
    colormap(hsv(128));
    surf(freq_p,time_a,store_p,'edgecolor','none')
    colormap(jet); axis tight;
    view(0,90);
    set(gca,'xlim',[minf maxf])
    ylabel('Time (sec)'); 
    xlabel('Frequency (Hz)');
    title('Spectrogram');

end

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

i3=get(handles.radiobutton3,'Value');

if(i3==1)

    try
        close fig_num hidden
    catch       
    end     
    
    ncl=round(str2num(get(handles.edit_contour_levels,'String')));

    figure(fig_num);
    fig_num=fig_num+1;
    contour(freq_p,time_a,store_p,ncl);
    ylabel('Time (sec)'); xlabel('Frequency (Hz)'); 
    title('Contour Plot, Magnitude (dB)');
    grid on;
    colorbar;

end

i4=get(handles.radiobutton4,'Value');

if(i4==1)
    
    [u,s,v] = svd(store_p');
    
    s1=1;
    s2=2;
    
    if mean(u(:,s1)) < 0
        u(:,s1) = (-1)*u(:,s1);
        v(:,s1) = (-1)*v(:,s1);
    end
   
    x_label='Frequency (Hz)';
    t_string='Left Singular Vector Column 1 Normalized Magnitude';
    y_label='Magnitude';
    fmin=minf;
    fmax=maxf;
    ppp=[freq_p s(s1,s1)*u(:,s1)];
    
    [fig_num,h2]=...
    plot_loglin_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);

    figure(fig_num);
    fig_num=fig_num+1;
    plot(time_a,v(:,s1)/max(abs(v(:,s1))),'r'); grid on; grid minor;
    xlabel('Time (sec)');
    title('Right Singular Vector Column 1 Normalized Magnitude');
    ylabel('Magnitude');
    ylim([-1 1]);    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ')   
disp(' Peak Values ');
disp(' Time(sec)  Freq(Hz)  Amplitude ');
for ij=1:NW
    out4 = sprintf(' \t  %6.3f  \t  %6.3f  \t  %6.3f',time_a(ij),max_f(ij),max_a(ij));
    disp(out4) 
end

ps=get(handles.listbox_psave,'Value');

out1=sprintf('\n ps=%d ',ps);
disp(out1);

if(ps==1)        
        disp(' ');
        disp(' Plot file:');
        disp(' ');
    
        pname='waterfall_FFT_plot';
        
        out1=sprintf('   %s.png',pname);
        disp(out1);
    
        print(h2,pname,'-dpng','-r600');
end

ss=get(handles.listbox_save_array,'Value');

if(ss==1)

    k=1;
    for i=1:length(time_a)
        for j=1:length(freq_p)
            wdata(k,1)=[time_a(i)];
            wdata(k,2)=[freq_p(j)];
            wdata(k,3)=[store_p(i,j)];
            k=k+1;
        end
    end

    disp(' ');
    disp(' Data save in Workspace as:  waterfall_array');
    assignin('base', 'waterfall_array', wdata);

end


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellnum_seg(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method
set(handles.pushbutton_calculate,'Enable','off');
set(handles.pushbutton_view_options,'Enable','off');
set(handles.listbox_numrows,'Enable','off');
set(handles.listbox_numrows,'Visible','off');
set(handles.text_select_option,'Visible','off');
set(handles.uitable_advise,'Visible','off');

n=get(handles.listbox_method,'Value');

set(handles.pushbutton_view_options,'Enable','on');


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
   
    close 1 hidden
    figure(1);
    plot(THM(:,1),THM(:,2));
    title('Input Time History');
    xlabel(' Time(sec) ');
    grid on;   
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


% --- Executes on selection change in listbox_numrows.
function listbox_numrows_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_numrows (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellnum_seg(get(hObject,'String')) returns listbox_numrows contents as cell array
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



function edit_tmin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_tmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_tmin as text
%        str2double(get(hObject,'String')) returns contents of edit_tmin as a double


% --- Executes during object creation, after setting all properties.
function edit_tmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_tmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_tmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_tmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_tmax as text
%        str2double(get(hObject,'String')) returns contents of edit_tmax as a double


% --- Executes during object creation, after setting all properties.
function edit_tmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_tmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_overlap.
function listbox_overlap_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_overlap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellnum_seg(get(hObject,'String')) returns listbox_overlap contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_overlap


% --- Executes during object creation, after setting all properties.
function listbox_overlap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_overlap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_overlap.
function listbox4_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_overlap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellnum_seg(get(hObject,'String')) returns listbox_overlap contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_overlap


% --- Executes during object creation, after setting all properties.
function listbox4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_overlap (see GCBO)
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


% --- Executes when entered data in editable cell(s) in uitable_advise.
function uitable_advise_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable_advise (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on edit_tmin and none of its controls.
function edit_tmin_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_tmin (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_calculate,'Enable','off');


% --- Executes on key press with focus on edit_tmax and none of its controls.
function edit_tmax_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_tmax (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_calculate,'Enable','off');


% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_view_options,'Enable','on');
set(handles.pushbutton_calculate,'Enable','off');


% --- Executes on selection change in listbox_psave.
function listbox_psave_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_psave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellnum_seg(get(hObject,'String')) returns listbox_psave contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_psave


% --- Executes during object creation, after setting all properties.
function listbox_psave_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_psave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_save_array.
function listbox_save_array_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_save_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellnum_seg(get(hObject,'String')) returns listbox_save_array contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_save_array


% --- Executes during object creation, after setting all properties.
function listbox_save_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_save_array (see GCBO)
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

% Hints: contents = cellnum_seg(get(hObject,'String')) returns listbox_window contents as cell array
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


% --- Executes on selection change in listbox_magnitude.
function listbox_magnitude_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_magnitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellnum_seg(get(hObject,'String')) returns listbox_magnitude contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_magnitude

n=get(handles.listbox_magnitude,'Value');

set(handles.text_reference,'Visible','off');
set(handles.edit_reference,'Visible','off');

if(n==3)
    
    set(handles.text_reference,'Visible','on');
    set(handles.edit_reference,'Visible','on');
    
end


% --- Executes during object creation, after setting all properties.
function listbox_magnitude_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_magnitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_reference_Callback(hObject, eventdata, handles)
% hObject    handle to edit_reference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_reference as text
%        str2double(get(hObject,'String')) returns contents of edit_reference as a double


% --- Executes during object creation, after setting all properties.
function edit_reference_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_reference (see GCBO)
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



function edit_contour_levels_Callback(hObject, eventdata, handles)
% hObject    handle to edit_contour_levels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_contour_levels as text
%        str2double(get(hObject,'String')) returns contents of edit_contour_levels as a double


% --- Executes during object creation, after setting all properties.
function edit_contour_levels_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_contour_levels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_color_choice.
function listbox_color_choice_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_color_choice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellnum_seg(get(hObject,'String')) returns listbox_color_choice contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_color_choice


% --- Executes during object creation, after setting all properties.
function listbox_color_choice_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_color_choice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_fz.
function listbox_fz_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_fz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellnum_seg(get(hObject,'String')) returns listbox_fz contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_fz


% --- Executes during object creation, after setting all properties.
function listbox_fz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_fz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton_view_options_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_view_options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4

function varargout = vibrationdata_ISO_2631(varargin)
% VIBRATIONDATA_ISO_2631 MATLAB code for vibrationdata_ISO_2631.fig
%      VIBRATIONDATA_ISO_2631, by itself, creates a new VIBRATIONDATA_ISO_2631 or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_ISO_2631 returns the handle to a new VIBRATIONDATA_ISO_2631 or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_ISO_2631('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_ISO_2631.M with the given input arguments.
%
%      VIBRATIONDATA_ISO_2631('Property','Value',...) creates a new VIBRATIONDATA_ISO_2631 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_ISO_2631_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_ISO_2631_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_ISO_2631

% Last Modified by GUIDE v2.5 16-Mar-2016 10:29:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_ISO_2631_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_ISO_2631_OutputFcn, ...
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


% --- Executes just before vibrationdata_ISO_2631 is made visible.
function vibrationdata_ISO_2631_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_ISO_2631 (see VARARGIN)

% Choose default command line output for vibrationdata_ISO_2631
handles.output = hObject;

listbox_segments_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_ISO_2631 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_ISO_2631_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_ISO_2631);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS=get(handles.edit_input_array_name,'String');
    THM=evalin('base',FS); 
catch
    warndlg('Input array not found');
    return;
end
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ig=get(handles.listbox_segments,'Value');

iu=get(handles.listbox_unit,'Value');

imr=get(handles.listbox_mean,'Value');


tstart=str2num(get(handles.edit_tstart,'String'));
tend=str2num(get(handles.edit_tend,'String'));

if(tend<=tstart)
    msgbox('start & end time error ');
    return;    
end    


iweight=get(handles.listbox_weight,'Value');

jfirst=1;
jlast=max(size(THM));
for i=1:max(size(THM))
    if(THM(i,1)<tstart)
        jfirst=i;
    end
    if(THM(i,1)>tend)
        jlast=i-1;
        break;
    end
end
%

if(jlast<=jfirst)
    msgbox('jlast, jfirst error ');
    return;    
end    

tim=double(THM(jfirst:jlast,1));
amp=double(THM(jfirst:jlast,2));

n=length(tim);

if(n<=1)
   msgbox('Time column length error ');
   return; 
end    

dur=(tim(n)-tim(1));

dt=dur/(n-1);
sr=1/dt;

if(iu==1)
    amp=amp*9.81;
end

if(imr==1)
    amp=amp-mean(amp);
end
%
[fwl,fw,fwu,wk,wd,wf,wc,we,wj,wb,wm,www]=weight_factors_alt(iweight);
%
aw=zeros(length(amp),1);
%
iband=3;  % bandpass filtering
iphase=1; % refiltering for phase correction

nbands=length(www);

rms=zeros(nbands,1);


progressbar;
for i=1:nbands
%
    progressbar(i/nbands);
%
    fh=fwl(i);  % highpass filter frequency
    fl=fwu(i);  % lowpass filter frequency
%
    if(fh>(1/dur) && fl<(sr/5) && www(i)>3.5e-05)
        
         hpf=0.6*fh;
        
        [y]=mean_filter_highpass(amp,sr,hpf);
        
        fper=0.01;
        [yy]=vibrationdata_half_cosine_fade(y,fper);      

        
        [yyy,~,~,rms(i)]=...
                Butterworth_filter_function_alt(yy,dt,iband,fl,fh,iphase);
%
        aw=aw+yyy*www(i);
        
%%        figure(i+100);
%%        plot(tim,yyy);
%%        tstring=sprintf(' fl=%g  fh=%8.4g Hz ',fl,fh);
%%        title(tstring);
        
        
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  VDV is calculated over the whole signal regardless of whether 
%      the data is divided into segments
%

pause(0.5);
progressbar(1);

n=length(aw);
%
AW=std(aw);
MTW=AW;
%
VDV=0;
for i=1:n
    VDV=VDV+aw(i)^4;
end
VDV=(VDV*dt)^0.25;
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp('* * * * * * * * * *');
disp(' ');


    if(iweight==1)
        tstring='Wk Weighted Time History';
    end
    if(iweight==2)
        tstring='Wd Weighted Time History';
    end
    if(iweight==3)
        tstring='Wf Weighted Time History';
    end    
    if(iweight==4)
        tstring='Wc Weighted Time History';
    end
    if(iweight==5)
        tstring='We Weighted Time History';
    end
    if(iweight==6)
        tstring='Wj Weighted Time History';
    end    
    if(iweight==7)
        tstring='Wb Weighted Time History';
    end
    if(iweight==8)
        tstring='Wm Weighted Time History';
    end    
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   


if(ig==1)  % segments

    disp(' ');
    disp('  Time         aw            aw    ');
    disp(' (sec)     (m/sec^2) RMS   (GRMS) ');
    
    seg=str2num(get(handles.edit_segment_duration,'String'));
    p=get(handles.listbox_overlap,'Value');

    po=(p-1)*0.1;
    
    ns=fix(sr*seg); 
%
    step=floor(ns*(1-po));
    
    i=1;
    j1=1;
    j2=1+ns;

    
    while(1)

        if((j2)>n)
            break;
        end
    
        j1=j1+step;
        j2=j2+step;
    
        i=i+1;
    
        if(i>500000)
            break;
        end    
    
    end 

    nnn=i;
    
%%    disp(' ');
%%    out1=sprintf('\n nnn=%d  step=%d\n',nnn,step);
%%    disp(out1);

    if(nnn==0)
        warndlg('nnn=0');
        return;
    end
    if(step==0)
        warndlg('step=0');
        return;
    end
    if(nnn>500000)
        warndlg('nnn>500000');
        return;
    end

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    as=zeros(nnn,1);
    tt=zeros(nnn,1);
%
    j1=1;
    j2=1+ns;
    
    ijk=1;

    for i=1:nnn
        if(j2>length(tim))
            break;
        end
%
        clear x;
        x=aw(j1:j2);
      
        if(isempty(x))
            break;
        end
        
        tt(i)=(tim(j1)+tim(j2))/2.;     
        as(i)=std(x);
        
        out1=sprintf('%8.2f   %8.2f     %8.3f',tt(i),as(i),as(i)/9.81);
        disp(out1);
        
        ttt(ijk)=tt(i);
        aas(ijk)=as(i);
         
        
        if(as(i)>MTW)
            MTW=as(i);
        end
%
        j1=j1+step;
        j2=j2+step;
% 
        ijk=ijk+1;
    end    
    

    if(ig==1)
        tstring=sprintf(' %s \n %g sec segments, %g%% overlap  ',tstring,seg,100*po);
    end
    
    ttt=fix_size(ttt);
    aas=fix_size(aas);
    
    figure(1);
    plot(THM(:,1),THM(:,2));
    title('Input Time History');
    if(iu==1)
        ylabel('Accel (GRMS)');         
    else
        ylabel('Accel (m/sec^2) RMS');        
    end
    xlabel('Time (sec)');
    grid on;
    
    figure(2);
    plot(ttt,aas);
    ylabel('Accel (m/sec^2) RMS');
    xlabel('Time (sec)');
    grid on;
    title(tstring);
    yabs=max(abs(get(gca,'ylim')));
    [ymax,yTT,ytt,iflag]=ytick_linear_one_sided(yabs);
    if(iflag==1)
        ylim([0,ymax]);    
        set(gca,'ytick',ytt);
        set(gca,'YTickLabel',yTT);  
        set(gca,'MinorGridLineStyle',':','GridLineStyle',':',...
                                     'XminorTick','off','YminorTick','on'); 
    end
        
    figure(3);
    plot(ttt,aas/9.81);
    ylabel('Accel (GRMS)');
    xlabel('Time (sec)');
    grid on;
    title(tstring);   
    yabs=max(abs(get(gca,'ylim')));    
    [ymax,yTT,ytt,iflag]=ytick_linear_one_sided(yabs);
    if(iflag==1)
        ylim([0,ymax]);    
        set(gca,'ytick',ytt);
        set(gca,'YTickLabel',yTT);        
        set(gca,'MinorGridLineStyle',':','GridLineStyle',':',...
                                     'XminorTick','off','YminorTick','on');         
    end   
    
else
    
    figure(2);
    plot(tim,aw);
    ylabel('Accel (m/sec^2) RMS');
    xlabel('Time (sec)');
    grid on;
    title(tstring);     
end

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
out1=sprintf('\n Composite Weighted Level  AW = %8.4g (m/sec^2)RMS ',AW);
disp(out1);
%
out1=sprintf('\n Maximum Transient Vibration MTW = %8.4g (m/sec^2)RMS ',MTW);
disp(out1);
%
out1=sprintf('\n Fourth Power Vibration Dose VDV = %8.4g (m/sec^(1.75)) \n',VDV);
disp(out1);
%
out1=sprintf('\n                          MTW/AW = %8.4g\n',MTW/AW);
disp(out1);

if(ig==1)
    
    name1='accel_mpss_rms';
    name2='accel_grms';
       
    assignin('base', name1, [ttt aas]);    
    assignin('base', name2, [ttt aas/9.81]);     

    name1=sprintf('   %s',name1);
    name2=sprintf('   %s',name2);
    
    disp(' ');
    disp(' Output Arrays - time & amplitude RMS ');
    disp(' ');
    disp(name1);
    disp(name2);    
    
%%%%%%%%%

    aw=fix_size(aw);

    name1='aw_accel_mpss';
    name2='aw_accel_g';
       
    assignin('base', name1, [tim aw]);    
    assignin('base', name2, [tim aw/9.81]);     

    name1=sprintf('   %s',name1);
    name2=sprintf('   %s',name2);
    
    disp(' ');
    disp(' Output Arrays - time & accel ');
    disp(' ');
    disp(name1);
    disp(name2); 

end    

msgbox('Results written to Command Window');



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



function edit_input_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_mean.
function listbox_mean_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_mean contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_mean


% --- Executes during object creation, after setting all properties.
function listbox_mean_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_tstart_Callback(hObject, eventdata, handles)
% hObject    handle to edit_tstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_tstart as text
%        str2double(get(hObject,'String')) returns contents of edit_tstart as a double


% --- Executes during object creation, after setting all properties.
function edit_tstart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_tstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_tend_Callback(hObject, eventdata, handles)
% hObject    handle to edit_tend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_tend as text
%        str2double(get(hObject,'String')) returns contents of edit_tend as a double


% --- Executes during object creation, after setting all properties.
function edit_tend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_tend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_weight.
function listbox_weight_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_weight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_weight contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_weight


% --- Executes during object creation, after setting all properties.
function listbox_weight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_weight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_segments.
function listbox_segments_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_segments (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_segments contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_segments

n=get(handles.listbox_segments,'Value');

set(handles.edit_segment_duration,'Visible','on');
set(handles.listbox_overlap,'Visible','on');
set(handles.text_segment,'Visible','on');
set(handles.text_precent_overlap,'Visible','on');

if(n==2)
    set(handles.edit_segment_duration,'Visible','off');
    set(handles.listbox_overlap,'Visible','off');
    set(handles.text_segment,'Visible','off');
    set(handles.text_precent_overlap,'Visible','off');    
end



% --- Executes during object creation, after setting all properties.
function listbox_segments_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_segments (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_segment_duration_Callback(hObject, eventdata, handles)
% hObject    handle to edit_segment_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_segment_duration as text
%        str2double(get(hObject,'String')) returns contents of edit_segment_duration as a double


% --- Executes during object creation, after setting all properties.
function edit_segment_duration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_segment_duration (see GCBO)
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

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_overlap contents as cell array
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

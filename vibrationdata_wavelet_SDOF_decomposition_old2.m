function varargout = vibrationdata_wavelet_SDOF_decomposition_old2(varargin)
% VIBRATIONDATA_WAVELET_SDOF_DECOMPOSITION_OLD2 MATLAB code for vibrationdata_wavelet_SDOF_decomposition_old2.fig
%      VIBRATIONDATA_WAVELET_SDOF_DECOMPOSITION_OLD2, by itself, creates a new VIBRATIONDATA_WAVELET_SDOF_DECOMPOSITION_OLD2 or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_WAVELET_SDOF_DECOMPOSITION_OLD2 returns the handle to a new VIBRATIONDATA_WAVELET_SDOF_DECOMPOSITION_OLD2 or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_WAVELET_SDOF_DECOMPOSITION_OLD2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_WAVELET_SDOF_DECOMPOSITION_OLD2.M with the given input arguments.
%
%      VIBRATIONDATA_WAVELET_SDOF_DECOMPOSITION_OLD2('Property','Value',...) creates a new VIBRATIONDATA_WAVELET_SDOF_DECOMPOSITION_OLD2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_wavelet_SDOF_decomposition_old2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_wavelet_SDOF_decomposition_old2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_wavelet_SDOF_decomposition_old2

% Last Modified by GUIDE v2.5 14-May-2018 14:11:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_wavelet_SDOF_decomposition_old2_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_wavelet_SDOF_decomposition_old2_OutputFcn, ...
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


% --- Executes just before vibrationdata_wavelet_SDOF_decomposition_old2 is made visible.
function vibrationdata_wavelet_SDOF_decomposition_old2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_wavelet_SDOF_decomposition_old2 (see VARARGIN)

% Choose default command line output for vibrationdata_wavelet_SDOF_decomposition_old2
handles.output = hObject;

clear(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_wavelet_SDOF_decomposition_old2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_wavelet_SDOF_decomposition_old2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function clear(hObject, eventdata, handles)

set(handles.edit_start,'Enable','off');
set(handles.edit_end,'Enable','off');

set(handles.edit_start,'String','');
set(handles.edit_end,'String','');



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_wavelet_SDOF_decomposition)


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig_num=2;

try  
    NVE=get(handles.edit_nve,'String');
    fc=evalin('base',NVE);   
catch
    warndlg('Input Frequency Array does not exist.  Try again.')
    return;
end


ts=str2num(get(handles.edit_start,'String'));
te=str2num(get(handles.edit_end,'String'));

    out1=sprintf(' ts=%8.4g  te=%8.4g  ',ts,te);
    disp(out1);

if(ts>te)

    warndlg('Start time > end time');
    return;
end



THM=getappdata(0,'THM');


[TT,x,dt,~]=extract_function(THM,ts,te);

num=str2num(get(handles.edit_ntrials,'String'));


TTone=TT(1);

TT=TT-TTone;

TIT=getappdata(0,'TIT');
YS=getappdata(0,'YS');


n=length(TT);

dur=TT(n)-TT(1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t=TT;
input_accel=x;

nf=length(fc);

error_max=1.0e+90;                                  
                                 
peak=max(abs(input_accel));


fn=zeros(nf,1);
damp=zeros(nf,1);

nbase=str2num(get(handles.edit_nbase,'String'));

amp=zeros(nbase,1);
nhs=zeros(nbase,1);
freq=zeros(nbase,1);
delay=zeros(nbase,1);

amp_r=zeros(nbase,1);
nhs_r=zeros(nbase,1);
freq_r=zeros(nbase,1);
delay_r=zeros(nbase,1);


kflag=0;

out1=sprintf('\n num=%d  peak=%8.4g \n',num,peak);
disp(out1);

df=1/dur;
dff=2.0*df;


progressbar;

for i=1:num
    
    progressbar(i/num);
    
%%%%

    for j=1:nf

        fn(j)=2*df*rand()+(fc(j)-df);

        damp(j)=0.10*rand();
        if(damp(j)<0.001)
            damp(j)=0.001;
        end
        
    end    

%%%%

    % synthesize base
    
    for j=1:nbase
    
        amp(j)=peak*(-0.5+1.0*rand())/200;
        nhs(j)=2*ceil(38*rand())-1;
        if(nhs(j)<3)
            nhs(j)=3;
        end
        delay(j)=(dur*0.5)*(rand())^1.5;
    
        if(i==1)
            amp(j)=0;
        end
    
        iq=round(nf*rand());
        
        if(iq==0)
            iq=1;
        end
        
        freq(j)=fc(iq)*0.95+0.1*rand();
    end
    
    
    
    if(kflag==1 && rand()>0.65)

        for j=1:nf
            damp(j)=damp_r(j)*(0.95+0.1*rand());
            fn(j)=fn_r(j)*(0.995+0.01*rand());
        end
        
        for j=1:nbase
            freq(j)=freq_r(j)*(0.998+0.004*rand());
            amp(j)=amp_r(j)*(0.998+0.004*rand());
            
            
            nhs(j)=nhs_r(j);
            rr=rand();
            if(rr>0.8 && rr<=0.9)
                nhs(j)=nhs(j)-2;
            end
            if(rr>0.9)
               nhs(j)=nhs(j)+2;
            end
            
            
            delay(j)=delay_r(j)*(0.995+0.01*rand());
        end
        
    end
    
    
    
    for j=1:nf
        if(fn(j)<(fc(j)-dff))
            fn(j)=fc(j)-dff;
        end
        if(fn(j)>(fc(j)+dff))
            fn(j)=fc(j)+dff;
        end    
    end
    
    
    if(rand()>0.95)
        amp=amp_r;
        freq=freq_r;
        nhs=nhs_r;
        delay=delay_r; 
    end
    
    for j=1:nbase
        if(rand()>0.98)
            amp(j)=amp(j)*0.5;
        end
    end
    
    for j=1:nbase
        if(rand()>0.98)
            amp(j)=amp_r(j);
            freq(j)=freq_r(j);
            nhs(j)=nhs_r(j);    
            delay(j)=delay_r(j);             
        end
    end
    
    base=zeros(n,1);
    for j=1:nbase
        
        if(nhs(j)<3)
            nhs(j)=3;
        end
        
        if(abs(amp(j))>1.0e-04)
            [b]=generate_time_history_wavelet_table(freq(j),amp(j),nhs(j),delay(j),t);
            base=base+b;
        end
    end
    
    y_resp=zeros(n,1);
    for j=1:nf
        [yy]=arbit_function_accel(fn(j),damp(j),dt,base);
        y_resp=y_resp+yy;
    end
    
    
%    figure(2*i-1);
%    plot(t,y_resp)
%    xlabel('Time (sec)');
    
    error=std(input_accel-y_resp);
        
    if(error<error_max)
        error_max=error;
        
        out1=sprintf('\n %d  %11.7g   ',i,error_max);
        disp(out1);
        
%%        for j=1:nbase
%%            out1=sprintf('       %8.4g  %8.4g  %8.4g  %8.4g  ',freq(j),amp(j),nhs(j),delay(j));
%%            disp(out1);
%%        end


        base_r=base;
        y_resp_r=y_resp;
        damp_r=damp;
        fn_r=fn;
        amp_r=amp;
        freq_r=freq;
        nhs_r=nhs;
        delay_r=delay;  
        
        
        rr=[fn_r damp_r];
        
        rr=sortrows(rr,1);
        
        fn_r=rr(:,1);
        damp_r=rr(:,2);


        for j=1:nf
            out1=sprintf('             %8.4g  %8.4g',fn(j),damp(j));
            disp(out1);
        end

        
        if(i>1)
            kflag=1;
        end
    end
    
%%%%

end    

progressbar(1);


t=t+TTone;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


disp(' ');
disp(' Wavelet Table for Synthesized Base Input');
disp('   freq(Hz)    Amp       NHS    Delay(sec) ');


for j=1:nbase
    out1=sprintf(' %8.4g  %8.4g  %8.4g  %8.4g  ',freq_r(j),amp_r(j),nhs_r(j),delay_r(j));
    disp(out1);
end



disp(' ');
disp(' Synthesized Response ');
disp('   freq(Hz)   Damp ');

for j=1:nf
    out1=sprintf(' %8.4g  %8.4g',fn_r(j),damp_r(j));
    disp(out1);
end

setappdata(0,'wavelet_table',[ freq amp_r nhs_r delay_r ]);
setappdata(0,'fn_damping_table',[fn_r damp_r]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t=fix_size(t);
base_r=fix_size(base_r);
y_resp_r=fix_size(y_resp_r);


xlabel2='Time (sec)';
data1=[t base_r];
data2=[t y_resp_r];

setappdata(0,'synth_input',data1);
setappdata(0,'synth_response',data2);

ylabel1=YS;
ylabel2=YS;

t_string1=sprintf('%s Synthesized Base Input',TIT);
t_string2=sprintf('Synthesized Response');

[fig_num]=subplots_two_linlin_two_titles(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2);

%%%

figure(fig_num)
fig_num=fig_num+1;
plot(t,y_resp_r,t,input_accel);
legend('Synthsized Response','Measured');
title(TIT);
xlabel('Time (sec)');
ylabel(YS);
grid on;

%%%

figure(fig_num)
plot(t,y_resp_r,THM(:,1),THM(:,2));
legend('Synthsized Response','Measured');
title(TIT);
xlabel('Time (sec)');
ylabel(YS);
grid on;




set(handles.uipanel_save,'Visible','on');











function edit_start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_start as text
%        str2double(get(hObject,'String')) returns contents of edit_start as a double


% --- Executes during object creation, after setting all properties.
function edit_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_end_Callback(hObject, eventdata, handles)
% hObject    handle to edit_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_end as text
%        str2double(get(hObject,'String')) returns contents of edit_end as a double


% --- Executes during object creation, after setting all properties.
function edit_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_end (see GCBO)
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


% --- Executes on button press in pushbutton_plot_input.
function pushbutton_plot_input_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


try  
    FS=get(handles.edit_input_array,'String');
    THM=evalin('base',FS);   
catch
    warndlg('Input Array does not exist.  Try again.')
    return;
end

t1=THM(1,1);
THM(:,1)=THM(:,1)-t1;

setappdata(0,'THM',THM);

YS=get(handles.edit_ylabel_input,'String');
TIT=get(handles.edit_title,'String');
TIT=strrep(TIT,'_',' ');

figure(1);
plot(THM(:,1),THM(:,2));
ylabel(YS);
xlabel('Time (sec)');
title(TIT);
grid on;

set(handles.edit_start,'Enable','on');
set(handles.edit_end,'Enable','on');
setappdata(0,'TIT',TIT);
setappdata(0,'YS',YS);


% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

clear(hObject, eventdata, handles);
set(handles.uipanel_save,'Visible','off');


function edit_ntrials_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ntrials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ntrials as text
%        str2double(get(hObject,'String')) returns contents of edit_ntrials as a double


% --- Executes during object creation, after setting all properties.
function edit_ntrials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ntrials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_nf.
function listbox_nf_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_nf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_nf contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_nf




% --- Executes during object creation, after setting all properties.
function listbox_nf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_nf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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



function edit_nve_Callback(hObject, eventdata, handles)
% hObject    handle to edit_nve (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_nve as text
%        str2double(get(hObject,'String')) returns contents of edit_nve as a double


% --- Executes during object creation, after setting all properties.
function edit_nve_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_nve (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_nbase_Callback(hObject, eventdata, handles)
% hObject    handle to edit_nbase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_nbase as text
%        str2double(get(hObject,'String')) returns contents of edit_nbase as a double


% --- Executes during object creation, after setting all properties.
function edit_nbase_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_nbase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_nve and none of its controls.
function edit_nve_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_nve (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_nbase and none of its controls.
function edit_nbase_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_nbase (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_ntrials and none of its controls.
function edit_ntrials_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_ntrials (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_end and none of its controls.
function edit_end_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_end (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_start and none of its controls.
function edit_start_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_start (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');



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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_save,'Value');

if(n==1)
    data=getappdata(0,'synth_input');
end
if(n==2)
    data=getappdata(0,'synth_response');    
end
if(n==3)
    data=getappdata(0,'wavelet_table');
end
if(n==4)
    data=getappdata(0,'fn_damping_table');
end

output_name=get(handles.edit_output_array_name,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 

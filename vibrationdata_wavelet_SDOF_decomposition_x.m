function varargout = vibrationdata_wavelet_SDOF_decomposition_x(varargin)
% VIBRATIONDATA_WAVELET_SDOF_DECOMPOSITION_X MATLAB code for vibrationdata_wavelet_SDOF_decomposition_x.fig
%      VIBRATIONDATA_WAVELET_SDOF_DECOMPOSITION_X, by itself, creates a new VIBRATIONDATA_WAVELET_SDOF_DECOMPOSITION_X or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_WAVELET_SDOF_DECOMPOSITION_X returns the handle to a new VIBRATIONDATA_WAVELET_SDOF_DECOMPOSITION_X or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_WAVELET_SDOF_DECOMPOSITION_X('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_WAVELET_SDOF_DECOMPOSITION_X.M with the given input arguments.
%
%      VIBRATIONDATA_WAVELET_SDOF_DECOMPOSITION_X('Property','Value',...) creates a new VIBRATIONDATA_WAVELET_SDOF_DECOMPOSITION_X or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_wavelet_SDOF_decomposition_x_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_wavelet_SDOF_decomposition_x_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_wavelet_SDOF_decomposition_x

% Last Modified by GUIDE v2.5 21-May-2018 15:14:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_wavelet_SDOF_decomposition_x_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_wavelet_SDOF_decomposition_x_OutputFcn, ...
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


% --- Executes just before vibrationdata_wavelet_SDOF_decomposition_x is made visible.
function vibrationdata_wavelet_SDOF_decomposition_x_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_wavelet_SDOF_decomposition_x (see VARARGIN)

% Choose default command line output for vibrationdata_wavelet_SDOF_decomposition_x
handles.output = hObject;

clear(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_wavelet_SDOF_decomposition_x wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_wavelet_SDOF_decomposition_x_OutputFcn(hObject, eventdata, handles) 
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


damp_max=str2num(get(handles.edit_damp_max,'String'));
damp_min=str2num(get(handles.edit_damp_min,'String'));


ts=str2num(get(handles.edit_start,'String'));
te=str2num(get(handles.edit_end,'String'));


if(isempty(ts))
    warndlg(' Enter start time');
    return;
end
if(isempty(te))
    warndlg(' Enter end time');
    return;
end


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

df=1/max(TT);


TIT=getappdata(0,'TIT');
YS=getappdata(0,'YS');


n=length(TT);

dur=TT(n)-TT(1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t=TT;
input_accel=x;

nf=length(fc);

dfq=zeros(nf,1);

for i=1:nf
    dfq(i)=max([1.5*df 0.01*fc(i)]);
end

error_max_rr=1.0e+90;
                                                                   
peak=max(abs(input_accel));


fn=zeros(nf,1);
damp=zeros(nf,1);

fn_r=zeros(nf,1);
damp_r=zeros(nf,1);

nbase=str2num(get(handles.edit_nbase,'String'));



out1=sprintf('\n num=%d  peak=%8.4g \n',num,peak);
disp(out1);

nout=str2num(get(handles.edit_nout,'String'));

nut=ceil(num/(nout*nbase));


jv=1;

progressbar;

amp_rr=zeros(nbase,1);
nhs_rr=zeros(nbase,1);
freq_rr=zeros(nbase,1);
delay_rr=zeros(nbase,1);

fns=zeros(nf,nout);
damps=zeros(nf,nout);


nQ=nout*nbase*nut;

for ikv=1:nout
    
    base_r=zeros(n,1);
    y_resp_r=zeros(n,1);

    amp=zeros(nbase,1);
    nhs=zeros(nbase,1);
    freq=zeros(nbase,1);
    delay=zeros(nbase,1);

    amp_r=zeros(nbase,1);
    nhs_r=zeros(nbase,1);
    freq_r=zeros(nbase,1);
    delay_r=zeros(nbase,1);


    kflag=0;

    error_max=1.0e+90;

    for ix=1:nbase
    
        nbase=ix;

        for i=1:nut
    
            progressbar(jv/nQ);
            jv=jv+1;   
    
%%%%
            [fn,damp]=vw_fn_damp(nf,dfq,fc,damp_max,damp_min,fn,damp);
        
            [amp,freq,nhs,delay]=vw_parameters(i,nf,nbase,peak,dur,fc,amp,freq,nhs,delay);

    
            if(kflag==1 && rand()>0.65)
                [freq,amp,nhs,delay,fn,damp]=vw_converge1(freq,amp,nhs,delay,freq_r,amp_r,nhs_r,delay_r,fn,damp,fn_r,damp_r,nf,nbase);
            end
    
            if(rand()>0.8)
                [freq,amp,nhs,delay]=vw_converge2(freq,amp,nhs,delay,freq_r,amp_r,nhs_r,delay_r,fc,dur,ix,nf);
            end

            [fn,nhs,freq,damp]=vw_final_check(nf,nbase,fn,nhs,freq,damp,fc,dfq,damp_min,damp_max);
    
            [base,y_resp]=vw_numerical_engine(n,nbase,nf,fn,damp,amp,freq,nhs,delay,t,dt);
        
            [error_max,kflag,base_r,y_resp_r,damp_r,fn_r,amp_r,freq_r,nhs_r,delay_r]=...
              vw_scale_and_error(input_accel,error_max,error_max_rr,ikv,ix,i,base,...
                                   y_resp,damp,fn,amp,freq,nhs,delay,nf,...
                               base_r,y_resp_r,damp_r,fn_r,amp_r,freq_r,...
                                                      nhs_r,delay_r,kflag);    
        end
    end


    if(ikv==1 || error_max<error_max_rr)
    
       y_resp_rr=y_resp_r;
       base_rr=base_r;
   
       error_max_rr=error_max;
   
       damp_rr=damp_r;
       fn_rr=fn_r;
       amp_rr=amp_r;
       freq_rr=freq_r;
       nhs_rr=nhs_r;
       delay_rr=delay_r;
   
    end

    fns(:,ikv)=fn_r;
    damps(:,ikv)=damp_r;

end


progressbar(1);

t=t+TTone;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for j=nbase:-1:1
    if(abs(amp_rr(j))<1.0e-20)
        freq_rr(j)=[];
        amp_rr(j)=[];
        nhs_rr(j)=[];
        delay_rr(j)=[];
    end
end

nbase=length(freq_rr);


disp(' ');
disp(' Best case:  Wavelet Table for Synthesized Base Input');
disp('   freq(Hz)    Amp     NHS    Delay(sec) ');


for j=1:nbase
    out1=sprintf(' %8.4g  %8.4g    %d   %8.4g  ',freq_rr(j),amp_rr(j),nhs_rr(j),delay_rr(j));
    disp(out1);
end



disp(' ');
disp(' Best case:  Synthesized Response ');
disp('   freq(Hz)   Damp ');

for j=1:nf
    out1=sprintf(' %8.4g  %8.4g',fn_rr(j),damp_rr(j));
    disp(out1);
end


disp(' ');
out1=sprintf(' Average of %d cases ',nout);
disp(out1);
disp('   freq(Hz)   Damp ');

for j=1:nf
    out1=sprintf(' %8.4g  %8.4g',mean(fns(j,:)),mean(damps(j,:)));
    disp(out1);
end


disp(' ');
out1=sprintf(' Ranges of %d cases ',nout);
disp(out1);
disp('      freq(Hz)              damp ');
disp('    min    max            min     max ');

for j=1:nf
    out1=sprintf('%7.4g to %7.4g     %7.3g to %7.3g',min(fns(j,:)),max(fns(j,:)),min(damps(j,:)),max(damps(j,:)));
    disp(out1);
end


setappdata(0,'wavelet_table',[ freq_rr amp_rr nhs_rr delay_rr ]);
setappdata(0,'fn_damping_table',[fn_rr damp_rr]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t=fix_size(t);
base_r=fix_size(base_rr);
y_resp_r=fix_size(y_resp_rr);


xlabel2='Time (sec)';
data1=[t base_rr];
data2=[t y_resp_rr];

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
plot(t,y_resp_rr,t,input_accel);
legend('Synthesized Response','Measured');
title(TIT);
xlabel('Time (sec)');
ylabel(YS);
grid on;

%%%

figure(fig_num)
plot(t,y_resp_rr,THM(:,1),THM(:,2));
legend('Synthesized Response','Measured');
title(TIT);
xlabel('Time (sec)');
ylabel(YS);
grid on;
xlim([THM(1,1) te]);

set(handles.uipanel_save,'Visible','on');

msgbox('Calculation complete');



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



function edit_damp_max_Callback(hObject, eventdata, handles)
% hObject    handle to edit_damp_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_damp_max as text
%        str2double(get(hObject,'String')) returns contents of edit_damp_max as a double


% --- Executes during object creation, after setting all properties.
function edit_damp_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_damp_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_damp_min_Callback(hObject, eventdata, handles)
% hObject    handle to edit_damp_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_damp_min as text
%        str2double(get(hObject,'String')) returns contents of edit_damp_min as a double


% --- Executes during object creation, after setting all properties.
function edit_damp_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_damp_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function[base,y_resp]=vw_numerical_engine(n,nbase,nf,fn,damp,amp,freq,nhs,delay,t,dt)
        
        base=zeros(n,1);
        for j=1:nbase
                
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

        
function[fn,nhs,freq,damp]=vw_final_check(nf,nbase,fn,nhs,freq,damp,fc,dfq,damp_min,damp_max)


        for j=1:nf
            if(fn(j)<(fc(j)-dfq(j)))
                fn(j)=fc(j)-dfq(j);
            end
            if(fn(j)>(fc(j)+dfq(j)))
                fn(j)=fc(j)+dfq(j);
            end
            if(damp(j)>damp_max || damp(j)<damp_min)
                damp(j)=(damp_max-damp_min)*rand()+damp_min;
            end    
        end
        
        minf=min(fc);
        maxf=max(fc);
        
        flow=0.5*minf;
        
        for j=1:nbase
            if(nhs(j)<3)
                nhs(j)=3;
            end
            
            if(freq(j)<flow)
                freq(j)=(maxf-minf)*rand()+minf;
            end
        end
        

        
function[error_max,kflag,base_r,y_resp_r,damp_r,fn_r,amp_r,freq_r,nhs_r,delay_r]=...
        vw_error_test(error,error_max,error_max_rr,ikv,ix,i,kv,scale,base,y_resp,damp,fn,amp,freq,nhs,delay,nf,...
                    base_r,y_resp_r,damp_r,fn_r,amp_r,freq_r,nhs_r,delay_r,kflag)
    
        
            if(error<error_max)
                error_max=error;
                
                if(error<error_max_rr)
                    error_max_rr=error;
                end
        
                out1=sprintf('\n ikv=%d ix=%d i=%d kv=%d sc=%7.3g %11.7g %11.7g ',ikv,ix,i,kv,scale,error_max,error_max_rr);
                disp(out1);

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
  
            
function[fn,damp]=vw_fn_damp(nf,dfq,fc,damp_max,damp_min,fn,damp)

        for j=1:nf
            fn(j)=2*dfq(j)*rand()+(fc(j)-dfq(j));
            damp(j)=(damp_max-damp_min)*rand()+damp_min;
        end              

        
function[amp,freq,nhs,delay]=vw_parameters(i,nf,nbase,peak,dur,fc,amp,freq,nhs,delay)
    
        for j=1:nbase
    
            amp(j)=peak*(-0.5+1.0*rand())/(20*nbase);

            nhs(j)=2*ceil(38*rand())-1;
        
            if(rand()>0.97)
                nhs(j)=3;
            end
         
            delay(j)=(dur*0.9)*(rand())^1.2;
    
            if(i==1)
                amp(j)=0;
            end
    
            iq=round(nf*rand());
        
            if(iq==0)
                iq=1;
            end
        
            if(rand()>0.8)
                freq(j)=fc(iq)*(0.95+0.1*rand());
            else
                freq(j)=fc(iq)*(0.5+1.0*rand());
            end
        end      


function[freq,amp,nhs,delay]=vw_converge2(freq,amp,nhs,delay,freq_r,amp_r,nhs_r,delay_r,fc,dur,ix,nf)

 
            kj=ix-1;
            for jq=1:kj
                amp(jq)=amp_r(jq)*(0.995+0.01*rand());
                freq(jq)=freq_r(jq)*(0.995+0.01*rand());
                nhs(jq)=nhs_r(jq);
                delay(jq)=delay_r(jq)*(0.995+0.01*rand());
            end
            freq(ix)=1.5*fc(nf)*rand();
            nhs(ix)=2*ceil(38*rand())-1;
            delay(ix)=(dur*0.5)*(rand())^1.5;   
            amp(ix)=0.5*max(abs(amp_r))*(-0.5+1.0*rand());

        

function[freq,amp,nhs,delay,fn,damp]=vw_converge1(freq,amp,nhs,delay,freq_r,amp_r,nhs_r,delay_r,fn,damp,fn_r,damp_r,nf,nbase)

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
            

            
function[error_max,kflag,base_r,y_resp_r,damp_r,fn_r,amp_r,freq_r,nhs_r,delay_r]=...
              vw_scale_and_error(input_accel,error_max,error_max_rr,ikv,ix,i,base,...
                                   y_resp,damp,fn,amp,freq,nhs,delay,nf,...
                               base_r,y_resp_r,damp_r,fn_r,amp_r,freq_r,...
                                                      nhs_r,delay_r,kflag)
        
     
        Z=ones(length(input_accel),2);                                          
                                                  
        Y=input_accel;                                          
        Z(:,2)=y_resp;
     
        
        V=pinv(Z'*Z)*(Z'*Y);
       
%        a=V(1);
        b=V(2);
 
        scale=b;
        
        amp=amp*scale;
        y_resp=y_resp*scale;
        
        error=std(input_accel-y_resp);

       if(error<error_max)
                error_max=error;
                
                if(error<error_max_rr)
                    error_max_rr=error;
                end
        
                out1=sprintf('\n ikv=%d ix=%d i=%d  sc=%7.3g %11.7g %11.7g ',ikv,ix,i,scale,error_max,error_max_rr);
                disp(out1);

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
            
            
function edit_nout_Callback(hObject, eventdata, handles)
% hObject    handle to edit_nout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_nout as text
%        str2double(get(hObject,'String')) returns contents of edit_nout as a double


% --- Executes during object creation, after setting all properties.
function edit_nout_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_nout (see GCBO)
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


% --- Executes on button press in pushbutton_eq1.
function pushbutton_eq1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

     A = imread('wavelet_equation.jpg');
     figure(998) 
     imshow(A,'border','tight','InitialMagnification',100) 


% --- Executes on button press in pushbutton_eq2.
function pushbutton_eq2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

     A = imread('Smallwood_DRFR.jpg');
     figure(999) 
     imshow(A,'border','tight','InitialMagnification',100) 

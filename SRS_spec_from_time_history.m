function varargout = SRS_spec_from_time_history(varargin)
% SRS_SPEC_FROM_TIME_HISTORY MATLAB code for SRS_spec_from_time_history.fig
%      SRS_SPEC_FROM_TIME_HISTORY, by itself, creates a new SRS_SPEC_FROM_TIME_HISTORY or raises the existing
%      singleton*.
%
%      H = SRS_SPEC_FROM_TIME_HISTORY returns the handle to a new SRS_SPEC_FROM_TIME_HISTORY or the handle to
%      the existing singleton*.
%
%      SRS_SPEC_FROM_TIME_HISTORY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SRS_SPEC_FROM_TIME_HISTORY.M with the given input arguments.
%
%      SRS_SPEC_FROM_TIME_HISTORY('Property','Value',...) creates a new SRS_SPEC_FROM_TIME_HISTORY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SRS_spec_from_time_history_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SRS_spec_from_time_history_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SRS_spec_from_time_history

% Last Modified by GUIDE v2.5 26-Jan-2018 13:58:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SRS_spec_from_time_history_OpeningFcn, ...
                   'gui_OutputFcn',  @SRS_spec_from_time_history_OutputFcn, ...
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


% --- Executes just before SRS_spec_from_time_history is made visible.
function SRS_spec_from_time_history_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SRS_spec_from_time_history (see VARARGIN)

% Choose default command line output for SRS_spec_from_time_history
handles.output = hObject;

setappdata(0,'nastran_srs',0);

set(handles.listbox_units,'Value',1);
set(handles.listbox_method,'Value',1);
set(handles.edit_Q1,'String','10');



set(handles.edit_Q1,'String','10');

listbox_num_Q_Callback(hObject, eventdata, handles);

set(handles.pushbutton_calculate,'Enable','on');
set(handles.pushbutton_export,'Enable','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SRS_spec_from_time_history wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SRS_spec_from_time_history_OutputFcn(hObject, eventdata, handles) 
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

tic;

clear_all_figures(SRS_spec_from_time_history);

iunit=get(handles.listbox_units,'Value');


%%  h = msgbox('Intermediate Results are written in Command Window');

k=get(handles.listbox_method,'Value');

if(k==1)
  FS=get(handles.edit_input_array,'String');
  THM=evalin('base',FS);   
else
  THM=getappdata(0,'THM');
end

nQ=get(handles.listbox_num_Q,'Value');

new_Q=zeros(nQ,1);
new_damp=zeros(nQ,1);

for i=1:nQ
    
    if(i==1)
        new_Q(i)=str2num(get(handles.edit_Q1,'String'));
    end
    if(i==2)
        new_Q(i)=str2num(get(handles.edit_Q2,'String'));
    end
    if(i==3)
        new_Q(i)=str2num(get(handles.edit_Q3,'String'));
    end    
    
    if(isempty(new_Q(i)))
        warndlg(' Enter New Q ');
        return;
    end 
    
    new_damp(i) = (1/(2*new_Q(i)));
    
end

%%%%

t=THM(:,1);
yy=THM(:,2);
%
tmx=max(t);
tmi=min(t);
n = length(t);
dt=(tmx-tmi)/(n-1);
sr=1/dt;
%
disp(' ')
disp(' Time Step ');
dtmin=min(diff(t));
dtmax=max(diff(t));
%
out4 = sprintf(' dtmin  = %8.4g sec  ',dtmin);
out5 = sprintf(' dt     = %8.4g sec  ',dt);
out6 = sprintf(' dtmax  = %8.4g sec  ',dtmax);
disp(out4)
disp(out5)
disp(out6)
%
disp(' ')
disp(' Sample Rate ');
out4 = sprintf(' srmin  = %8.4g samples/sec  ',1/dtmax);
out5 = sprintf(' sr     = %8.4g samples/sec  ',1/dt);
out6 = sprintf(' srmax  = %8.4g samples/sec  \n',1/dtmin);
disp(out4)
disp(out5)
disp(out6)
%

if(((dtmax-dtmin)/dt)>0.01)
    disp(' ')
    disp(' Warning:  time step is not constant.  Continue calculation? 1=yes 2=no ')
    ncontinue=input(' ');
    
    if(ncontinue==2)
        return;
    end
end

%%%%

dt=1/sr; 

fstart=str2num(get(handles.edit_fstart,'String'));
fend  =str2num(get(handles.edit_fend,'String'));


fmax=sr/8;

num=1;

fn(1)=fstart;

fspace=1;

if(fspace==1)

    oct=2^(1/12);

    while(1)
    
        num=num+1;
  
        fn(num)=fn(num-1)*oct;
  
        if(fn(num)>fmax || fn(num)>=fend)
            break;
        end
    
    end

end

if(fn(num)>fend)
    fn(num)=fend;
end


fmin=fstart;
fmax=fend;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=1;

if(iunit<=2)
    y_lab='Accel(G)';
else
    y_lab='Accel(m/sec^2)';    
end  

figure(fig_num);
plot(t,yy);
title('Acceleration Base Input');
grid on;
ylabel(y_lab);
xlabel('Time (sec)');
fig_num=fig_num+1;


disp(' ');
disp(' ');

NT=8000;

md=6;

x_label='Natural Frequency (Hz)';
y_label=y_lab;


srs_type=get(handles.listbox_type,'Value');
format=get(handles.listbox_format,'Value');

NL=length(fn);


for ijk=1:nQ

    [new_srs_pn]=srs_function(yy,dt,new_damp(ijk),fn);

    a_pos=new_srs_pn(:,2);
    a_neg=new_srs_pn(:,3);

    a_abs=zeros(NL,1);
    a_abs(:,1)=fn;

    for i=1:NL
        a_abs(i)=max([ a_pos(i) a_neg(i)]); 
    end      
    
    if(srs_type==1)
        [rec_new_spec]=srs_average_envelope(fn,a_abs,NT,format);
    else
        [rec_new_spec]=srs_maximum_envelope(fn,a_abs,NT,format);
    end
    
   
    if(ijk==1)
        rec_new_spec_1=rec_new_spec;
    end
    if(ijk==2)
        rec_new_spec_2=rec_new_spec;
    end
    if(ijk==3)
        rec_new_spec_3=rec_new_spec;
    end    

 % t_string = sprintf(' Shock Response Spectrum Q=%g ',new_Q1);  

% [fig_num]=srs_plot_function(fig_num,fn,a_pos,a_neg,t_string,y_lab,fmin,fmax);   
    
    fn=fix_size(fn);
    a_pos=fix_size(a_pos);
    a_neg=fix_size(a_neg);
    
    ppp1=rec_new_spec;
    ppp2=[ fn a_pos ];
    ppp3=[ fn a_neg ];

    leg1='Spec';
    leg2='Positive';
    leg3='Negative';
    
        
    t_string=sprintf('Shock Response Spectra  Q=%g',new_Q(ijk));

    [fig_num]=plot_loglog_function_md_three(fig_num,x_label,...
                y_label,t_string,ppp1,ppp2,ppp3,leg1,leg2,leg3,fmin,fmax,md);

end

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%  format = 1:  ramp & plateau
%           2:  three coordinates arbitrary
%           3:  four coordinates arbitrary

if(format<=2)
    nsrs=3;
else
    nsrs=4;
end



disp(' ');
disp('Output arrays: ');
disp(' ');


sss=sprintf('%g',new_Q(1));
sss = strrep(sss,'.','p');
output_S1=sprintf('srs_spec_new_Q%s',sss);
assignin('base', output_S1, rec_new_spec_1);
disp(output_S1);

 
if(nQ>=2)
    sss=sprintf('%g',new_Q(2));
    sss = strrep(sss,'.','p');    
    output_S2=sprintf('srs_spec_new_Q%s',sss);
    assignin('base', output_S2, rec_new_spec_2); 
    disp(output_S2);
end 
 
if(nQ>=3)
    sss=sprintf('%g',new_Q(3));
    sss = strrep(sss,'.','p');    
    output_S3=sprintf('srs_spec_new_Q%s',sss);
    assignin('base', output_S3, rec_new_spec_3); 
    disp(output_S3);
end 

%%%%
    
out1=sprintf('\n New SRS Specification Q=%g ',new_Q(1));
disp(out1);
disp('     fn(Hz)   Accel(G)');
disp(' ');

for i=1:nsrs
    out1=sprintf(' %9.5g  %9.5g',rec_new_spec_1(i,1),rec_new_spec_1(i,2));
    disp(out1);  
end    

if(nQ>=2)
    
    out1=sprintf('\n New SRS Specification Q=%g ',new_Q(2));
    disp(out1);
    disp('     fn(Hz)   Accel(G)');
    disp(' ');

    for i=1:nsrs
        out1=sprintf(' %9.5g  %9.5g',rec_new_spec_2(i,1),rec_new_spec_2(i,2));
        disp(out1);  
    end        
    
end   
if(nQ>=3)
    
    out1=sprintf('\n New SRS Specification Q=%g ',new_Q(3));
    disp(out1);
    disp('     fn(Hz)   Accel(G)');
    disp(' ');

    for i=1:nsrs
        out1=sprintf(' %9.5g  %9.5g',rec_new_spec_3(i,1),rec_new_spec_3(i,2));
        disp(out1);  
    end        
    
end 


%%%%%%%%%%%%%%

disp(' ');


md=5;

if(nQ==1)
    
    t_string=sprintf('Shock Response Spectrum  Q=%g',new_Q(1));

    ppp=rec_new_spec_1;
    
   [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);    
 
end
if(nQ==2)
    
    t_string=sprintf('Shock Response Spectrum');   
    
    leg2=sprintf('Q=%g',new_Q(1));
    leg1=sprintf('Q=%g',new_Q(2));

    ppp2=rec_new_spec_1;
    ppp1=rec_new_spec_2; 
    
    [fig_num,~]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md); 
end
if(nQ==3)
    
    t_string=sprintf('Shock Response Spectrum');  
    
    leg3=sprintf('Q=%g',new_Q(1));        
    leg2=sprintf('Q=%g',new_Q(2));
    leg1=sprintf('Q=%g',new_Q(3));

    ppp3=rec_new_spec_1;
    ppp2=rec_new_spec_2;
    ppp1=rec_new_spec_3;
    
    [fig_num,~]=plot_loglog_function_md_three_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,leg1,leg2,leg3,fmin,fmax,md);     
end

set(handles.pushbutton_export,'Enable','on');


toc


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(SRS_spec_from_time_history);


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units


% --- Executes during object creation, after setting all properties.
function listbox_units_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Q1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q1 as text
%        str2double(get(hObject,'String')) returns contents of edit_Q1 as a double


% --- Executes during object creation, after setting all properties.
function edit_Q1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q1 (see GCBO)
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


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method

set(handles.text_input_array_name,'Enable','on');
set(handles.edit_input_array,'Enable','on');

n=get(hObject,'Value');

if(n==1)
   set(handles.pushbutton_read_data,'Enable','off');     
    
   set(handles.edit_input_array,'enable','on') 
else
   set(handles.pushbutton_read_data,'Enable','off');
   
   set(handles.edit_input_array,'enable','off')
   
   set(handles.text_input_array_name,'Enable','off');
   set(handles.edit_input_array,'Enable','off');   
   
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


% --- Executes on button press in pushbutton_read_data.
function pushbutton_read_data_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_read_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



activate_sample_rate(hObject, eventdata, handles);




function activate_sample_rate(hObject, eventdata, handles)
%
















function edit_trials_Callback(hObject, eventdata, handles)
% hObject    handle to edit_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_trials as text
%        str2double(get(hObject,'String')) returns contents of edit_trials as a double


% --- Executes during object creation, after setting all properties.
function edit_trials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_sample_rate_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sample_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sample_rate as text
%        str2double(get(hObject,'String')) returns contents of edit_sample_rate as a double


% --- Executes during object creation, after setting all properties.
function edit_sample_rate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sample_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_condition_Callback(hObject, eventdata, handles)
% hObject    handle to edit_condition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_condition as text
%        str2double(get(hObject,'String')) returns contents of edit_condition as a double


% --- Executes during object creation, after setting all properties.
function edit_condition_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_condition (see GCBO)
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

n=get(handles.listbox_output_array,'value');

if(n==1)
    data=getappdata(0,'acceleration');
end
if(n==2)
    data=getappdata(0,'velocity');
end
if(n==3)
    data=getappdata(0,'displacement');
end
if(n==4)
    data=getappdata(0,'shock_response_spectrum');
end
if(n==5)
    data=getappdata(0,'wavelet_table');
end


output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 





% --- Executes on selection change in listbox_output_array.
function listbox_output_array_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output_array contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output_array


% --- Executes during object creation, after setting all properties.
function listbox_output_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output_array (see GCBO)
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



function edit_trials_per_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to edit_trials_per_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_trials_per_frequency as text
%        str2double(get(hObject,'String')) returns contents of edit_trials_per_frequency as a double


% --- Executes during object creation, after setting all properties.
function edit_trials_per_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_trials_per_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_number_of_frequencies_Callback(hObject, eventdata, handles)
% hObject    handle to edit_number_of_frequencies (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_number_of_frequencies as text
%        str2double(get(hObject,'String')) returns contents of edit_number_of_frequencies as a double


% --- Executes during object creation, after setting all properties.
function edit_number_of_frequencies_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_number_of_frequencies (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_condition and none of its controls.
function edit_condition_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_condition (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in pushbutton_export.
function pushbutton_export_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

setappdata(0,'nastran_srs',1);

handles.s=export_junction;
set(handles.s,'Enable','on');




function edit_Q2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q2 as text
%        str2double(get(hObject,'String')) returns contents of edit_Q2 as a double


% --- Executes during object creation, after setting all properties.
function edit_Q2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q2 (see GCBO)
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
set(handles.pushbutton_export,'Enable','off');

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


% --- Executes on selection change in listbox_format.
function listbox_format_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_format contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_format
set(handles.pushbutton_export,'Enable','off');

% --- Executes during object creation, after setting all properties.
function listbox_format_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Q3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q3 as text
%        str2double(get(hObject,'String')) returns contents of edit_Q3 as a double


% --- Executes during object creation, after setting all properties.
function edit_Q3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_num_Q.
function listbox_num_Q_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num_Q contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num_Q

set(handles.pushbutton_export,'Enable','off');

n=get(handles.listbox_num_Q,'Value');


set(handles.text_Q2,'Enable','off');    
set(handles.edit_Q2,'Enable','off'); 
set(handles.text_Q3,'Enable','off');    
set(handles.edit_Q3,'Enable','off'); 

if(n>=2)
    set(handles.text_Q2,'Enable','on');    
    set(handles.edit_Q2,'Enable','on');
end
if(n==3)  
    set(handles.text_Q3,'Enable','on');    
    set(handles.edit_Q3,'Enable','on');     
end


% --- Executes during object creation, after setting all properties.
function listbox_num_Q_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_num_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_format.
function listbox8_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_format contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_format


% --- Executes during object creation, after setting all properties.
function listbox8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_trials and none of its controls.
function edit_trials_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_trials (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_export,'Enable','off');



function edit_fstart_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fstart as text
%        str2double(get(hObject,'String')) returns contents of edit_fstart as a double


% --- Executes during object creation, after setting all properties.
function edit_fstart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fend_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fend as text
%        str2double(get(hObject,'String')) returns contents of edit_fend as a double


% --- Executes during object creation, after setting all properties.
function edit_fend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

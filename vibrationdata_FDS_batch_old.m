function varargout = vibrationdata_FDS_batch_old(varargin)
% VIBRATIONDATA_FDS_BATCH_OLD MATLAB code for vibrationdata_FDS_batch_old.fig
%      VIBRATIONDATA_FDS_BATCH_OLD, by itself, creates a new VIBRATIONDATA_FDS_BATCH_OLD or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_FDS_BATCH_OLD returns the handle to a new VIBRATIONDATA_FDS_BATCH_OLD or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_FDS_BATCH_OLD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_FDS_BATCH_OLD.M with the given input arguments.
%
%      VIBRATIONDATA_FDS_BATCH_OLD('Property','Value',...) creates a new VIBRATIONDATA_FDS_BATCH_OLD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_FDS_batch_old_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_FDS_batch_old_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_FDS_batch_old

% Last Modified by GUIDE v2.5 30-May-2017 12:57:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_FDS_batch_old_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_FDS_batch_old_OutputFcn, ...
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


% --- Executes just before vibrationdata_FDS_batch_old is made visible.
function vibrationdata_FDS_batch_old_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_FDS_batch_old (see VARARGIN)

% Choose default command line output for vibrationdata_FDS_batch_old
handles.output = hObject;

set(handles.listbox_psave,'Value',1);

set(handles.edit_Q,'String','10');


%%%%    listbox_plots_Callback(hObject, eventdata, handles)

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_FDS_batch_old wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_FDS_batch_old_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on selection change in listbox_metric.
function listbox_metric_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_metric (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_metric contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_metric


% --- Executes during object creation, after setting all properties.
function listbox_metric_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_metric (see GCBO)
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

disp('  ');
disp(' * * * * * ');
disp('  ');
 

nfont=10;
 
dchoice=1.;
 
try
    FS=get(handles.edit_input_array,'String');
    sarray=evalin('base',FS);
catch
    warndlg('Input string array not found.');
    return; 
end    
 
if(iscell(sarray)==0)
    warndlg('Input must be array of strings (class=cell)');  
    return;
end
 

num_eng=get(handles.listbox_engine,'Value');
 
np=get(handles.listbox_plots,'Value'); 
 
if(np==1)
 
    psave=get(handles.listbox_psave,'Value');    
    nfont=str2num(get(handles.edit_font_size,'String'));    
 
end    
 
kv=length(sarray);


%%%
 
ioct=get(handles.listbox_interpolation,'Value');
 
if(ioct==1)
    oct=1/3;
end
if(ioct==2)
    oct=1/6;
end
if(ioct==3)
    oct=1/12;
end
if(ioct==4)
    oct=1/24;
end

%%%
 
fstart=str2num(get(handles.edit_start_frequency,'String'));
  fend=str2num(get(handles.edit_plot_fmax,'String'));
 
%%%
 
fn(1)=fstart;
%
j=1;
while(1)
    fn(j+1)=fn(1)*(2. ^ (j*oct));
    
    if(fn(j+1)>fend)
        break;
    end
    
    j=j+1;
end

fn=fn(1:j);
%
fn=fix_size(fn);
%
nfn=length(fn);
 

iu=get(handles.listbox_unit,'Value');
 
Q=str2num(get(handles.edit_Q,'String'));
bex=str2num(get(handles.edit_b,'String'));

if(isempty(Q))
   warndlg('Enter Q'); 
   return; 
end

if(isempty(bex))
   warndlg('Enter fatigue exponent'); 
   return; 
end

sbex=sprintf('%g',bex);
sbex=strrep(sbex, '.', 'p'); 
ext=sprintf('_Q%g_b%s',Q,sbex);

total_damage_string=sprintf('total_damage%s',ext);
  
damp=1/(2*Q);
 
im=get(handles.listbox_metric,'Value');

damage=zeros(nfn,kv);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
disp(' ');
disp(' Calculating.  May be slow... ');
disp(' ');

progressbar;
 
for i=1:kv
    
    out1=sprintf(' i=%d kv=%d  ',i,kv);
    disp(out1);
    
    progressbar(i/kv);
    
    THM=evalin('base',char(sarray(i,:)));
    
    output_array{i}=strcat(char(sarray(i,:)),ext);
    
    t=double(THM(:,1));
    y=double(THM(:,2));
    
    n=length(y);
 
    dur=THM(n,1)-THM(1,1);
 
    dt=dur/(n-1);
    sr=1/dt;
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
 
     for j=1:nfn       
         
        if(im==1)
            [y_resp]=arbit_function_accel(fn(j),damp,dt,y);   
        else
            [y_resp]=arbit_function_rd(fn(j),damp,dt,y);
        end
%
        if(im==2) % pseudo velocity (approx)
%         
            [y_resp]=differentiate_function(y_resp,dt);
%
            if(iu==1)
                y_resp=y_resp*386;
            else
                y_resp=y_resp*9.81*1000;
            end
%
        end
%
        if(im==3) % relative displacement
            if(iu==1)
                y_resp=y_resp*386;
            else
                y_resp=y_resp*9.81*1000;
            end
        end
%
        if(num_eng==1)
%
            [range_cycles]=vibrationdata_rainflow_function_basic_np(y_resp);
            D=0;
            sz=size(range_cycles);
            for iv=1:sz(1)
                D=D+range_cycles(iv,2)*( 0.5*range_cycles(iv,1) )^bex;
            end  
%
        else

%            
            [L,C,AverageAmp,MaxAmp,AverageMean,MinValley,MaxPeak,D]=...
                                      rainflow_fds_mex(y_resp,dchoice,bex);              
%
        end    
%
        damage(j,i)=D;
        
        out1=sprintf(' fn=%8.4g  D=%8.4g',fn(j),D);
        disp(out1);
        
 
     end
end     

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 
fig_num=1;  % leave here

for i=1:kv      

     sdata=[fn damage(:,i)];
    
     
     assignin('base', output_array{i}, sdata);
     out2=sprintf('%s',output_array{i});
     ss{i}=out2; 
    
     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
     
   if(np==1)  
       
        sx=char(sarray(i,:));
        
        if(im==1)
           
            t_string=sprintf(' Acceleration FDS Q=%g b=%g \n %s',Q,bex,sx);
 
            if(iu==1 || iu==2)
                y_label=sprintf('Relative Damage (G^{%g}',bex);
            else
                y_label=sprintf('Relative Damage (m/sec^2)^{%g}',bex);   
            end
            
        end
        if(im==2)
            
            t_string=sprintf(' Pseudo Velocity FDS Q=%g b=%g \n %s',Q,bex,sx);
            if(iu==1)
                y_label=sprintf('Relative Damage (in/sec)^{%g}',bex);
            else
                y_label=sprintf('Relative Damage (m/sec)^{%g}',bex);
            end
                
        end 
        if(im==3)
            
            t_string=sprintf(' Relative Displacement FDS Q=%g b=%g \n %s',Q,bex,sx);
            if(iu==1)
                y_label=sprintf('Relative Damage (in^{%g})',bex);
            else
                y_label=sprintf('Relative Damage (mm^{%g})',bex);    
            end
            
        end 
        
        x_label='Natural Frequency (Hz)';
        ppp=sdata;
        fmin=fstart;
        fmax=fend;
        
        [fig_num,h2]=plot_loglog_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);
        pause(1);
        
        set(gca,'Fontsize',nfont);
%        set(h2, 'Position', [20 20 550 450]);
        
        if(psave>1)
            
            pname=output_array{i};
       
            if(psave==2)
                print(h2,pname,'-dmeta','-r300');
                out1=sprintf('%s.emf',pname');
            end  
            if(psave==3)
                print(h2,pname,'-dpng','-r300');
                out1=sprintf('%s.png',pname');           
            end
            image_file{i}=out1;            
              
        end             
               
    end         
     
end
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
if(np==1)
 
    if(psave>1)
        disp(' ');
        disp(' External Plot Names ');
        disp(' ');
        
        for i=1:kv
            out1=sprintf(' %s',image_file{i});
            disp(out1);
        end        
    end
        
end
 
pause(0.3);
progressbar(1);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

total_damage=zeros(nfn,1);

for i=1:nfn
   
    total_damage(i)=sum(damage(i,:));
    
end


if(im==1)
            t_string=sprintf('Total Acceleration FDS Q=%g b=%g',Q,bex);
end
if(im==2)
            t_string=sprintf('Total Pseudo Velocity FDS Q=%g b=%g',Q,bex);
end 
if(im==3)
            t_string=sprintf('Total Relative Displacement FDS Q=%g b=%g',Q,bex);
end 

ppp=[fn total_damage];

[fig_num,h2]=plot_loglog_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);

sdata=ppp;


assignin('base', total_damage_string, sdata);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
disp('  ');
disp('  Output Arrays ');
disp('  ');
 
for i=1:kv
   out1=sprintf(' %s',output_array{i});
   disp(out1);    
end
 
output_name='fds_array';
    
assignin('base', output_name, ss');
 
disp(' ');
disp('Output array names stored in string array:');
disp('fds_array');

disp(' ');
disp(' Total damage array: ');
out1=sprintf('  %s \n',total_damage_string);
disp(out1);

msgbox('Calculation complete.  See Command Window');



% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_FDS_batch)

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



function edit_start_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to edit_start_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_start_frequency as text
%        str2double(get(hObject,'String')) returns contents of edit_start_frequency as a double


% --- Executes during object creation, after setting all properties.
function edit_start_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_start_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Q_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q as text
%        str2double(get(hObject,'String')) returns contents of edit_Q as a double


% --- Executes during object creation, after setting all properties.
function edit_Q_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_plot_fmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_plot_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_plot_fmax as text
%        str2double(get(hObject,'String')) returns contents of edit_plot_fmax as a double


% --- Executes during object creation, after setting all properties.
function edit_plot_fmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_plot_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_Q and none of its controls.
function edit_Q_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_start_frequency and none of its controls.
function edit_start_frequency_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_start_frequency (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_plot_fmax and none of its controls.
function edit_plot_fmax_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_plot_fmax (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on listbox_unit and none of its controls.
function listbox_unit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in listbox_psave.
function listbox_psave_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_psave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_psave contents as cell array
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


% --- Executes on selection change in listbox_frequency_spacing.
function listbox_frequency_spacing_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_frequency_spacing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_frequency_spacing contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_frequency_spacing


% --- Executes during object creation, after setting all properties.
function listbox_frequency_spacing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_frequency_spacing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_residual.
function listbox_residual_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_residual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_residual contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_residual


% --- Executes during object creation, after setting all properties.
function listbox_residual_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_residual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_extension_Callback(hObject, eventdata, handles)
% hObject    handle to edit_extension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_extension as text
%        str2double(get(hObject,'String')) returns contents of edit_extension as a double


% --- Executes during object creation, after setting all properties.
function edit_extension_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_extension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_plots.
function listbox_plots_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_plots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_plots contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_plots

np=get(handles.listbox_plots,'Value');

if(np==1)

    set(handles.listbox_psave,'Visible','on');
    set(handles.text_export,'Visible','on');    
    
    set(handles.text_font_size,'Visible','on');
    set(handles.edit_font_size,'Visible','on');
   
else
    
    set(handles.listbox_psave,'Visible','off');
    set(handles.text_export,'Visible','off');
    
    set(handles.text_font_size,'Visible','off');
    set(handles.edit_font_size,'Visible','off');
end    


% --- Executes during object creation, after setting all properties.
function listbox_plots_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_plots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_font_size_Callback(hObject, eventdata, handles)
% hObject    handle to edit_font_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_font_size as text
%        str2double(get(hObject,'String')) returns contents of edit_font_size as a double


% --- Executes during object creation, after setting all properties.
function edit_font_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_font_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_b_Callback(hObject, eventdata, handles)
% hObject    handle to edit_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_b as text
%        str2double(get(hObject,'String')) returns contents of edit_b as a double


% --- Executes during object creation, after setting all properties.
function edit_b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_engine.
function listbox_engine_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_engine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_engine contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_engine


% --- Executes during object creation, after setting all properties.
function listbox_engine_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_engine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_interpolation.
function listbox_interpolation_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_interpolation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_interpolation contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_interpolation


% --- Executes during object creation, after setting all properties.
function listbox_interpolation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_interpolation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

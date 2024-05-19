function varargout = vibrationdata_srs_batch(varargin)
% VIBRATIONDATA_SRS_BATCH MATLAB code for vibrationdata_srs_batch.fig
%      VIBRATIONDATA_SRS_BATCH, by itself, creates a new VIBRATIONDATA_SRS_BATCH or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_SRS_BATCH returns the handle to a new VIBRATIONDATA_SRS_BATCH or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_SRS_BATCH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_SRS_BATCH.M with the given input arguments.
%
%      VIBRATIONDATA_SRS_BATCH('Property','Value',...) creates a new VIBRATIONDATA_SRS_BATCH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_srs_batch_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_srs_batch_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_srs_batch

% Last Modified by GUIDE v2.5 30-Aug-2016 10:36:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_srs_batch_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_srs_batch_OutputFcn, ...
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


% --- Executes just before vibrationdata_srs_batch is made visible.
function vibrationdata_srs_batch_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_srs_batch (see VARARGIN)

% Choose default command line output for vibrationdata_srs_batch
handles.output = hObject;

set(handles.listbox_psave,'Value',2);

set(handles.edit_Q,'String','10');


set(handles.listbox_frequency_spacing,'Value',1);

listbox_plots_Callback(hObject, eventdata, handles)

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_srs_batch wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_srs_batch_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on selection change in listbox_output_type.
function listbox_output_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output_type


% --- Executes during object creation, after setting all properties.
function listbox_output_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output_type (see GCBO)
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

fig_num=1;
nfont=10;

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

sarray

np=get(handles.listbox_plots,'Value'); 

if(np==1)

    psave=get(handles.listbox_psave,'Value');    
    nfont=str2num(get(handles.edit_font_size,'String'));    

end    
 
kv=length(sarray);
ext=get(handles.edit_extension,'String');

%%%

res=get(handles.listbox_residual,'Value');
fspace=get(handles.listbox_frequency_spacing,'Value');
iu=get(handles.listbox_unit,'Value');

Q=str2num(get(handles.edit_Q,'String'));

fstart=str2num(get(handles.edit_start_frequency,'String'));
  fend=str2num(get(handles.edit_plot_fmax,'String'));
  
fmin=fstart;
  
damp=1/(2*Q);

nformat=get(handles.listbox_output_type,'Value');


for i=1:kv
    
    out1=sprintf(' array %d of %d',i,kv);
    disp(out1);
    
    THM=evalin('base',char(sarray(i,:)));
    
    output_array{i}=strcat(char(sarray(i,:)),ext);
    
    t=double(THM(:,1));
    y=double(THM(:,2));

    yy=y;

    n=length(y);             % leave here because may vary per time history
    dur=THM(n,1)-THM(1,1);
    dt=dur/(n-1);
    sr=1/dt;
    fmax=sr/5;
    [fn,num]=srs_fn(fspace,fstart,fend,fmax);

    [a1,a2,b1,b2,b3,rd_a1,rd_a2,rd_b1,rd_b2,rd_b3]=...
                                   srs_coefficients(fn,damp,dt);

    NL=length(yy);
    
    a_pos=zeros(num,1);
    a_neg=zeros(num,1);   
    
    pv_pos=zeros(num,1);
    pv_neg=zeros(num,1); 
    
    rd_pos=zeros(num,1);
    rd_neg=zeros(num,1);     

    for j=1:num

        if(res==1)
            ML=NL+round((1/fn(j))/dt);
            ys=zeros(ML,1);
            ys(1:NL)=yy;
        else
            ys=yy;
        end
%
        forward=[ b1(j),  b2(j),  b3(j) ];    
        back   =[     1, -a1(j), -a2(j) ];
%    
        a_resp=filter(forward,back,ys);
%
        a_pos(j)= max(a_resp);
        a_neg(j)= min(a_resp);
%
        rd_forward=[ rd_b1(j),  rd_b2(j),  rd_b3(j) ];    
        rd_back   =[     1, -rd_a1(j), -rd_a2(j) ];      
%    
        rd_resp=filter(rd_forward,rd_back,ys);
%
        if(iu==1)
            rd_resp=rd_resp*386;
        end
        if(iu==2)
            rd_resp=rd_resp*9.81*1000;        
        end
%
        rd_pos(j)= max(rd_resp);
        rd_neg(j)= min(rd_resp);
%
        omegan=2*pi*fn(j);
%
        pv_pos(j)=omegan*rd_pos(j);
        pv_neg(j)=omegan*rd_neg(j);
%
    end
%
    a_neg=abs(a_neg);
    pv_neg=abs(pv_neg);
    rd_neg=abs(rd_neg);
%
    if(iu==2)
        pv_pos=pv_pos/1000;
        pv_neg=pv_neg/1000;
    end

    fn=fix_size(fn);
    a_pos=fix_size(a_pos);
    a_neg=fix_size(a_neg);
    pv_pos=fix_size(pv_pos);
    pv_neg=fix_size(pv_neg);
    rd_pos=fix_size(rd_pos);
    rd_neg=fix_size(rd_neg);
%
    accel_data=[fn a_pos a_neg];
    p_vel_data=[fn pv_pos pv_neg];
    rel_disp_data=[fn rd_pos rd_neg];
    
       accel_data_abs(:,1)=fn;
       p_vel_data_abs(:,1)=fn;
    rel_disp_data_abs(:,1)=fn;
    
    
     a_abs=zeros(num,1);
    pv_abs=zeros(num,1);
    rd_abs=zeros(num,1);
    
    for j=1:num
        
           a_abs(j)=max([ a_pos(j)  a_neg(j)]);
           accel_data_abs(j,2)= a_abs(j);
           
           pv_abs(j)=max([pv_pos(j) pv_neg(j)]);
           p_vel_data_abs(j,2)=pv_abs(j);
        
           rd_abs(j)=max([rd_pos(j) rd_neg(j)]);
           rel_disp_data_abs(j,2)= rd_abs(j);
 
    end
        
    if(nformat==1)
        sdata=accel_data;
    end
    if(nformat==2)
        sdata=p_vel_data;
    end
    if(nformat==3)
        sdata=rel_disp_data;
    end    
    if(nformat==4)
        sdata=accel_data_abs;
    end
    if(nformat==5)
        sdata=p_vel_data_abs;
    end
    if(nformat==6)
        sdata=rel_disp_data_abs;
    end       
    
    assignin('base', output_array{i}, sdata);
    out2=sprintf('%s',output_array{i});
    ss{i}=out2; 
    
%%%

    if(np==1)
        
        [newStr]=plot_title_fix_alt(output_array{i});        
      
        if(nformat==1 || nformat==4)
           
            t_string=sprintf(' Acceleration SRS Q=%g \n %s',Q,newStr);
 
            if(iu==1 || iu==2)
                y_lab='Peak Accel (G)';
            else
                y_lab='Peak Accel (m/sec^2)';    
            end
            
            if(nformat==1)
                [fig_num,h2]=srs_plot_function_h(fig_num,fn,a_pos,a_neg,t_string,y_lab,fmin,fmax);
            else
                [fig_num,h2]=srs_plot_abs_function_h(fig_num,fn,a_abs,t_string,y_lab,fmin,fmax); 
            end
                
        end
        if(nformat==2 || nformat==5)
            
            t_string=sprintf(' Pseudo Velocity SRS Q=%g \n %s',Q,newStr);
            if(iu==1)
                y_lab='Peak Vel (in/sec)';
            else
                y_lab='Peak Vel (m/sec)';    
            end
            
            if(nformat==2)            
                [fig_num,h2]=srs_plot_function_h(fig_num,fn,pv_pos,pv_neg,t_string,y_lab,fmin,fmax);
            else
                [fig_num,h2]=srs_plot_abs_function_h(fig_num,fn,pv_abs,t_string,y_lab,fmin,fmax);                
            end
                
        end 
        if(nformat==3 || nformat==6)
            
            t_string=sprintf(' Relative Displacement SRS Q=%g \n %s',Q,newStr);
            if(iu==1)
                y_lab='Peak Rel Disp (in)';
            else
                y_lab='Peak Rel Disp (mm)';    
            end
            
            if(nformat==3)                  
                [fig_num,h2]=srs_plot_function_h(fig_num,fn,rd_pos,rd_neg,t_string,y_lab,fmin,fmax);
            else                   
                [fig_num,h2]=srs_plot_abs_function_h(fig_num,fn,rd_abs,t_string,y_lab,fmin,fmax);               
            end                
 
        end         
        
        set(gca,'Fontsize',nfont);
        set(h2, 'Position', [20 20 550 450]);
        
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('  ');
disp('  Output Arrays ');
disp('  ');

for i=1:kv
   out1=sprintf(' %s',output_array{i});
   disp(out1);    
end

output_name='srs_array';
    
assignin('base', output_name, ss');

disp(' ');
disp('Output array names stored in string array:');
disp(' srs_array');

msgbox('Calculation complete.  See Command Window');



% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_srs_batch)

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

function varargout = multiaxis_fatigue_damage_Basquin(varargin)
% MULTIAXIS_FATIGUE_DAMAGE_BASQUIN MATLAB code for multiaxis_fatigue_damage_Basquin.fig
%      MULTIAXIS_FATIGUE_DAMAGE_BASQUIN, by itself, creates a new MULTIAXIS_FATIGUE_DAMAGE_BASQUIN or raises the existing
%      singleton*.
%
%      H = MULTIAXIS_FATIGUE_DAMAGE_BASQUIN returns the handle to a new MULTIAXIS_FATIGUE_DAMAGE_BASQUIN or the handle to
%      the existing singleton*.
%
%      MULTIAXIS_FATIGUE_DAMAGE_BASQUIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MULTIAXIS_FATIGUE_DAMAGE_BASQUIN.M with the given input arguments.
%
%      MULTIAXIS_FATIGUE_DAMAGE_BASQUIN('Property','Value',...) creates a new MULTIAXIS_FATIGUE_DAMAGE_BASQUIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before multiaxis_fatigue_damage_Basquin_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to multiaxis_fatigue_damage_Basquin_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help multiaxis_fatigue_damage_Basquin

% Last Modified by GUIDE v2.5 08-Mar-2016 13:35:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @multiaxis_fatigue_damage_Basquin_OpeningFcn, ...
                   'gui_OutputFcn',  @multiaxis_fatigue_damage_Basquin_OutputFcn, ...
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


% --- Executes just before multiaxis_fatigue_damage_Basquin is made visible.
function multiaxis_fatigue_damage_Basquin_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to multiaxis_fatigue_damage_Basquin (see VARARGIN)

% Choose default command line output for multiaxis_fatigue_damage_Basquin
handles.output = hObject;


listbox_stress_format_Callback(hObject, eventdata, handles);
change_material_or_stress(hObject, eventdata, handles);
radiobutton_hypersphere_Callback(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes multiaxis_fatigue_damage_Basquin wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = multiaxis_fatigue_damage_Basquin_OutputFcn(hObject, eventdata, handles) 
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

delete(multiaxis_fatigue_damage_Basquin);



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


% --- Executes on button press in pushbutton_save_table.
function pushbutton_save_table_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_table (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

BIG=getappdata(0,'BIG');
columnname=getappdata(0,'columnname');

FileName = uiputfile;

% csvwrite(FileName,columnname);

fid = fopen(FileName,'wt');
fprintf(fid, '%s,',columnname{:});
fprintf(fid, '\n');
fclose(fid);

dlmwrite (FileName, BIG, '-append');

h = msgbox('Save Complete'); 





% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


n=get(handles.listbox_output_type,'Value');

if(n==1)
    data=getappdata(0,'amp_cycles_r'); 
end
if(n==2)
    data=getappdata(0,'range_cycles_r');  
end
if(n==3)
    data=getappdata(0,'combined');  
end


output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 



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


% --- Executes on selection change in listbox_numerical_engine.
function listbox_numerical_engine_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_numerical_engine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_numerical_engine contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_numerical_engine


% --- Executes during object creation, after setting all properties.
function listbox_numerical_engine_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_numerical_engine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Calculate.
function Calculate_Callback(hObject, eventdata, handles)
% hObject    handle to Calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


disp(' ');
disp(' * * * * * * * * * * * * * * * * ');
disp(' ');
disp(' Reading input data');
disp(' ');



value_signed_max_abs_principal = get(handles.radiobutton_signed_max_abs_principal, 'Value');
value_signed_von_Mises = get(handles.radiobutton_signed_von_Mises, 'Value');
value_signed_Tresca = get(handles.radiobutton_signed_Tresca, 'Value');
value_hypersphere = get(handles.radiobutton_hypersphere, 'Value');

vs=value_signed_max_abs_principal+value_signed_von_Mises+value_signed_Tresca+value_hypersphere;

if(vs==0)
   warndlg('Select Stress Method, One or More'); 
   return; 
end



n_stress_format=get(handles.listbox_stress_format,'Value');

iu=get(handles.listbox_iu,'Value');  % need to apply units

scf=str2num(get(handles.edit_scf,'String'));

num_eng=get(handles.listbox_numerical_engine,'Value');

b=str2num(get(handles.edit_m,'String'));
A=str2num(get(handles.edit_A,'String'));

thu=get(handles.edit_input_array,'String');

if isempty(thu)
    warndlg('Time history does not exist');
    return;
else
    THM=evalin('base',thu);    
end

sz=size(THM);

ncols=sz(2);


if(n_stress_format==1 && ncols~=4)
   warndlg(' Input data must have four columns'); 
   return; 
end
if(n_stress_format==2 && ncols~=7)
   warndlg(' Input data must have four columns'); 
   return;
end

t=THM(:,1);
tau=t(sz(1))-t(1);

% do not need unit conversion

if(n_stress_format==1)
    sx=THM(:,2);
    sy=THM(:,3);
    txy=THM(:,4);
end
if(n_stress_format==2)
    sx=THM(:,2);
    sy=THM(:,3);
    sz=THM(:,4);  
    txy=THM(:,5);
    txz=THM(:,6);
    tyz=THM(:,7);    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  convert to principal stress
%

if(n_stress_format==1)
    
     sx=sx*scf;
     sy=sy*scf;
     
    txy=txy*scf;    
    
    normal_stress_array=[sx sy txy ];

    [pstress]=stress_tensor_2D(sx,sy,txy);

end
if(n_stress_format==2)
    
     sx=sx*scf;
     sy=sy*scf;
     sz=sz*scf;
     
    txy=txy*scf;      
    txz=txz*scf;    
    tyz=tyz*scf;
    
     normal_stress_array=[sx sy sz txy txz tyz ];
    
    [pstress]=stress_tensor_3D(sx,sy,sz,txy,txz,tyz);
    
end


ss=getappdata(0,'A_label');




if(num_eng==2)
    disp(' ');
    disp(' Calculating... ');
    disp(' ');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  convert to equivalent uniaxial
%

if(value_signed_max_abs_principal==1)
    
    [smap]=signed_max_abs_principal(pstress);
    yc=smap;
    
    [range_cycles]=rainflow_function_choice(yc,num_eng);
    
    [D_map]=Basquin_damage_th(A,b,range_cycles);
    
    output_name1a='signed_max_abs_principal_uniaxial';
    output_name1b='unsigned_max_abs_principal_uniaxial';
    assignin('base',output_name1a,[t yc]);
    assignin('base',output_name1b,[t abs(yc)]);
end


%%%%%%%%

if(value_signed_von_Mises==1 || value_hypersphere==1)
    
    [svm]=signed_von_Mises(pstress);
    yc=svm;    

    [range_cycles]=rainflow_function_choice(yc,num_eng);

    [D_vm]=Basquin_damage_th(A,b,range_cycles);

    output_name2a='signed_von_Mises_uniaxial';
    output_name2b='unsigned_von_Mises_uniaxial';    
    assignin('base',output_name2a,[t yc]);    
    assignin('base',output_name2b,[t abs(yc)]);     
end

%%%%%%%%

if(value_signed_Tresca==1 || value_hypersphere==1)
    
    [str]=signed_Tresca(pstress);
    yc=str;      
    
    [range_cycles]=rainflow_function_choice(yc,num_eng);    
    
    [D_tr]=Basquin_damage_th(A,b,range_cycles); 
    
    output_name3a='signed_Tresca_uniaxial';
    output_name3b='unsigned_Tresca_uniaxial';    
    assignin('base',output_name3a,[t yc]);  
    assignin('base',output_name3b,[t abs(yc)]);     
end

%%%%%%%%

if(value_hypersphere==1)
    
    NT=str2num(get(handles.edit_NT,'String'));
    
    [hyper,cr,D_hyp]=hypersphere(normal_stress_array,num_eng,A,b,NT);
    
    yc=hyper;
    
    scale1=std(svm)/std(hyper);
    scale2=std(str)/std(hyper);
    
    D_hyp_vm=D_hyp*scale1^b;
    D_hyp_tr=D_hyp*scale2^b;    
    
    output_name4='hypersphere';
    assignin('base',output_name4,[t yc]);  
    
    output_name5='hypersphere_scaled_with_vonMises';
    assignin('base',output_name5,[t yc*scale1]);
    
    output_name6='hypersphere_scaled_with_Tresca';
    assignin('base',output_name6,[t yc*scale2]);    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mlab=getappdata(0,'mlab');


out1=sprintf('\n Material: %s ',mlab);
disp(out1);

disp(' ');
out1=sprintf(' Fatigue exponent m = %g ',b);
disp(out1);
out2=sprintf(' Fatigue strength coefficient A = %g %s',A,ss);
disp(out2);

disp(' ');
disp('      Fatigue Damage   ');
disp(' ');

%  convert to equivalent uniaxial
%

if(value_signed_max_abs_principal==1)
    
    out1=sprintf(' Signed Maximum Absolute =  %8.4g',D_map); 
    disp(out1);
    
end


%%%%%%%%

if(value_signed_von_Mises==1)
    
    out1=sprintf('        Signed von Mises =  %8.4g',D_vm);        
    disp(out1);
    
end

%%%%%%%%

if(value_signed_Tresca==1)

    out1=sprintf('           Signed Tresca =  %8.4g',D_tr);     
    disp(out1);    
    
end

%%%%%%%%

if(value_hypersphere==1)
    
    out1=sprintf('            Hypersphere1 =  %8.4g',D_hyp  );     
    disp(out1);       
    out1=sprintf('            Hypersphere2 =  %8.4g',D_hyp_vm);     
    disp(out1);         
    out1=sprintf('            Hypersphere3 =  %8.4g',D_hyp_tr);    
    disp(out1);         
    
end

%%%%%%%%

disp(' ');
disp('      Fatigue Damage Rate per sec   ');
disp(' ');

%  convert to equivalent uniaxial
%

if(value_signed_max_abs_principal==1)
    
    out1=sprintf(' Signed Maximum Absolute =  %8.4g ',D_map/tau); 
    disp(out1);
    
end


%%%%%%%%

if(value_signed_von_Mises==1)
    
    out1=sprintf('        Signed von Mises =  %8.4g',D_vm/tau);        
    disp(out1);
    
end

%%%%%%%%

if(value_signed_Tresca==1)

    out1=sprintf('           Signed Tresca =  %8.4g',D_tr/tau);     
    disp(out1);    
    
end

%%%%%%%%

if(value_hypersphere==1)
    
    out1=sprintf('            Hypersphere1 =  %8.4g',D_hyp/tau  );     
    disp(out1);       
    out1=sprintf('            Hypersphere2 =  %8.4g',D_hyp_vm/tau);     
    disp(out1);         
    out1=sprintf('            Hypersphere3 =  %8.4g',D_hyp_tr/tau);    
    disp(out1);     
    
    
    
    disp(' ');
    
    if(n_stress_format==1)
        disp(' Hypersphere coefficients: c1,c2,c3');       
        out2=sprintf(' %7.3f %7.3f %7.3f',cr(1),cr(2),cr(3));
    end   
    if(n_stress_format==2)
        disp(' Hypersphere coefficients: c1,c2,c3,c4,c5,c6');         
        out2=sprintf(' %7.3f %7.3f %7.3f %7.3f %7.3f %7.3f',cr(1),cr(2),cr(3),cr(4),cr(5),cr(6));    
    end    
    
    disp(out2);       
    
end

if(value_hypersphere==1)
    disp(' ');
    disp(' Hypersphere1 is the direct hypersphere result.');
    disp(' Hypersphere2 is the hypersphere result scaled by the signed von Mises rms stress.');
    disp(' Hypersphere3 is the hypersphere result scaled by the signed Tresca rms stress.');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('  ');
disp('  Output Time Histories ');
disp('  ');

if(value_signed_max_abs_principal==1)
     
    disp(output_name1a);
    disp(output_name1b);    
end


%%%%%%%%

if(value_signed_von_Mises==1)
    
    disp(output_name2a);
    disp(output_name2b);    
end

%%%%%%%%

if(value_signed_Tresca==1)

    disp(output_name3a);
    disp(output_name3b);   
end

%%%%%%%%

if(value_hypersphere==1)
    
    disp(output_name4);
    disp(output_name5);
    disp(output_name6);    
    
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



function edit_NT_Callback(hObject, eventdata, handles)
% hObject    handle to edit_NT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_NT as text
%        str2double(get(hObject,'String')) returns contents of edit_NT as a double


% --- Executes during object creation, after setting all properties.
function edit_NT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_NT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function Calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in radiobutton_signed_max_abs_principal.
function radiobutton_signed_max_abs_principal_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_signed_max_abs_principal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_signed_max_abs_principal


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over radiobutton_signed_max_abs_principal.
function radiobutton_signed_max_abs_principal_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to radiobutton_signed_max_abs_principal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox_sn_curve_type.
function listbox_sn_curve_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_sn_curve_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_sn_curve_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_sn_curve_type


% --- Executes during object creation, after setting all properties.
function listbox_sn_curve_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_sn_curve_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_stress_format.
function listbox_stress_format_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_stress_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_stress_format contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_stress_format

n=get(handles.listbox_stress_format,'Value');

if(n==1)
    ss='The input array must have four columns:';
    tt='time, sx, sy, txy';
end
if(n==2)
    ss='The input array must have seven columns:';
    tt='time, sx, sy, sz, txy, txz, tyz';
end

set(handles.text_columns,'String',ss);
set(handles.text_column_labels,'String',tt);


% --- Executes during object creation, after setting all properties.
function listbox_stress_format_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_stress_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function change_material_or_stress(hObject, eventdata, handles)

n=get(handles.listbox_iu,'Value');
n_mat=get(handles.listbox_material,'Value');

[mlab,m,A,ss,ms,As]=Basquin_coefficients(n,n_mat);
 
set(handles.text_unit,'String',ss);
set(handles.edit_m,'String',ms);
set(handles.edit_A,'String',As);
 

 
set(handles.text_unit,'String',ss);
 
set(handles.edit_m,'String',ms);
set(handles.edit_A,'String',As);

setappdata(0,'mlab',mlab);
setappdata(0,'A_label',ss);





% --- Executes on selection change in listbox_iu.
function listbox_iu_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_iu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_iu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_iu
change_material_or_stress(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_iu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_iu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_material.
function listbox_material_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_material

change_material_or_stress(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_m_Callback(hObject, eventdata, handles)
% hObject    handle to edit_m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_m as text
%        str2double(get(hObject,'String')) returns contents of edit_m as a double


% --- Executes during object creation, after setting all properties.
function edit_m_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_A_Callback(hObject, eventdata, handles)
% hObject    handle to edit_A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_A as text
%        str2double(get(hObject,'String')) returns contents of edit_A as a double


% --- Executes during object creation, after setting all properties.
function edit_A_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_scf_Callback(hObject, eventdata, handles)
% hObject    handle to edit_scf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_scf as text
%        str2double(get(hObject,'String')) returns contents of edit_scf as a double


% --- Executes during object creation, after setting all properties.
function edit_scf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_scf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton_hypersphere.
function radiobutton_hypersphere_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_hypersphere (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_hypersphere

n = get(handles.radiobutton_hypersphere, 'Value');

set(handles.edit_NT,'Visible','off');
set(handles.text_trials,'Visible','off'); 

if(n==1)
    set(handles.edit_NT,'Visible','on');
    set(handles.text_trials,'Visible','on');    
end

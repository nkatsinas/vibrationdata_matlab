function varargout = Franken_method_multiple(varargin)
% FRANKEN_METHOD_MULTIPLE MATLAB code for Franken_method_multiple.fig
%      FRANKEN_METHOD_MULTIPLE, by itself, creates a new FRANKEN_METHOD_MULTIPLE or raises the existing
%      singleton*.
%
%      H = FRANKEN_METHOD_MULTIPLE returns the handle to a new FRANKEN_METHOD_MULTIPLE or the handle to
%      the existing singleton*.
%
%      FRANKEN_METHOD_MULTIPLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FRANKEN_METHOD_MULTIPLE.M with the given input arguments.
%
%      FRANKEN_METHOD_MULTIPLE('Property','Value',...) creates a new FRANKEN_METHOD_MULTIPLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Franken_method_multiple_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Franken_method_multiple_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Franken_method_multiple

% Last Modified by GUIDE v2.5 01-Jul-2019 16:12:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Franken_method_multiple_OpeningFcn, ...
                   'gui_OutputFcn',  @Franken_method_multiple_OutputFcn, ...
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


% --- Executes just before Franken_method_multiple is made visible.
function Franken_method_multiple_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Franken_method_multiple (see VARARGIN)

% Choose default command line output for Franken_method_multiple
handles.output = hObject;

change_materials_units(hObject, eventdata, handles);
listbox_add_mass_Callback(hObject, eventdata, handles);

listbox_num_curves_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Franken_method_multiple wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function clear_output(hObject, eventdata, handles)
%



% --- Outputs from this function are returned to the command line.
function varargout = Franken_method_multiple_OutputFcn(hObject, eventdata, handles) 
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

delete(Franken_method_multiple);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * * * * * * * * * * * * * * * * * * ');
disp(' ');

Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end

fig_num=1;

field=get(handles.listbox_field,'Value');

iu=get(handles.listbox_units,'Value');

N=get(handles.listbox_num,'Value');

get_table_data(hObject, eventdata, handles);

A_legend=char(get(handles.uitable_legend,'Data'));
szA=size(A_legend);

shell_name=getappdata(0,'shell_name');
SPL_name=getappdata(0,'SPL_name');
fring=getappdata(0,'fring');
diam=getappdata(0,'diam');
smd=getappdata(0,'smd');
PSD_name=getappdata(0,'PSD_name');

nam=get(handles.listbox_add_mass,'Value');


 W=str2num(get(handles.edit_W,'String'));
Wc=str2num(get(handles.edit_Wc,'String'));


grms=zeros(N,1);
grmsb=zeros(N,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n_type=1;  % one-third octave
 

disp(' ');
disp(' Overall Cylindrical Shell Levels ');
disp(' ');


for i=1:N
    
    out1=sprintf('\n Shell=%d   %s ',i,SPL_name{i});
    disp(out1);
    
    try
        THM=evalin('base',SPL_name{i});
    catch
        out1=sprintf('Input SPL not found: %s',SPL_name{i});
        warndlg(out1);
        return;
    end

    sz=size(THM);
    ncols=sz(2)-1;
    
    if(ncols~=szA(1))
        out1=sprintf('Number of SPL Curves=%d  Fix legend',ncols);
        warndlg(out1);
        return;
    end
  
    f=THM(:,1);
        
    [stationdiam_ft,W_lbm_per_ft2,rf]=Franken_parameters(iu,diam(i),fring(i),smd(i));
    
    Wa=zeros(sz(1),sz(2));
    
    Wa(:,1)=f;

    fmin=f(1);
    fmax=max(f);   
    

    if(field==1)
        oalabel='oaspl';
    else
        oalabel='oafpl';        
    end
    
    for j=1:ncols
        
        dB=THM(:,j+1);
        
        [psd,grms(j),grmsb(j)]=Franken_function_alt_grms_add_mass(stationdiam_ft,W_lbm_per_ft2,rf,f,dB,nam,W,Wc); 
%
        Wa(:,(j+1))=psd;

        out1=sprintf('%d.  %s %9.4g GRMS',j,shell_name{i},grmsb(j));          
        disp(out1);
        
        leg_psd{j}=sprintf('%s  %7.3g GRMS',A_legend(j,:),grmsb(j));
        
        [oadb]=oaspl_function(dB);
        leg_spl{j}=sprintf('%s  %s %7.4g dB',A_legend(j,:),oalabel,oadb);
      
    end
    
    assignin('base', PSD_name{i}, Wa);   
    
    
    % plot spls
    
    SPL_n= strrep(SPL_name{i},'_',' ');
    leg=leg_spl;
    
    if(field==1)
        
        t_string=sprintf(' Sound Pressure Level  %s  \n Zero dB Ref = 20 micro Pa',SPL_n);
    
        if(ncols==1)       
            n_type=1;
            [fig_num]=spl_plot_nd(fig_num,n_type,f,THM(:,2));
        else
            [fig_num]=spl_plot_all(fig_num,t_string,THM,leg);
        end   
    
    else
        
        t_string=sprintf(' Fluctuating Pressure Level  %s  \n Zero dB Ref = 20 micro Pa',SPL_n);
        
        if(ncols==1)       
            n_type=1;
            [fig_num]=fpl_plot_nd(fig_num,n_type,f,THM(:,2));
        else
            [fig_num]=fpl_plot_all(fig_num,t_string,THM,leg);
        end           
        
    end
    
    
    % plot psds
    x_label='Frequency (Hz)';
    y_label='Accel (G^2/Hz)';
    shell_n= strrep(shell_name{i},'_',' ');
    
    leg=leg_psd;
    ppp=Wa;
    
    PSD_new=Wa;
    
    
    sz=size(PSD_new);
 
    PSD_max=zeros(sz(1),2);
    PSD_max(:,1)=PSD_new(:,1);
 
    for ijk=1:sz(1)
        PSD_max(ijk,2)=max(PSD_new(ijk,2:sz(2)));
    end

    
    if(ncols==1)
        md=6;
        t_string=sprintf('Power Spectral Density  Franken  %s \n Overall Level %7.3g GRMS',shell_n,grms(j));
        [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);
    else
        t_string=sprintf('Power Spectral Density  Franken  %s',shell_n);
        [fig_num]=plot_loglog_multiple_function(fig_num,x_label,y_label,t_string,ppp,leg,fmin,fmax);
    end
%
    if(ncols>=2)
        
        f=PSD_max(:,1);
        a=PSD_max(:,2);
        [~,grms] = calculate_PSD_slopes(f,a);
    
        x_label='Frequency (Hz)';
        y_label='Accel (G^2/Hz)';
    
        t_string=sprintf('PSD Franken Maximum Envelope %s  %7.3g GRMS',shell_n,grms);
    
        md=6;
    
        ppp=PSD_max;
    
        [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);    
    
        PSD_name_max{i}=sprintf('%s_max',PSD_name{i});
        
        assignin('base', PSD_name_max{i}, PSD_max); 
        
    end    

%
end    

%

disp(' ');
disp(' Output PSD Arrays ');

for i=1:N
   out1=sprintf('  %s ',PSD_name{i});
   disp(out1);
end

disp(' ');

if(ncols>2)
   for i=1:N
       out1=sprintf('  %s ',PSD_name_max{i});
       disp(out1);
   end 
end

disp(' ');

msgbox('Calculation Complete');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



    
function[stationdiam_ft,W_lbm_per_ft2,rf]=Franken_parameters(iu,diam,fring,smd)

    stationdiam=diam;
    
    if(iu==1)
        stationdiam=stationdiam/12.;  % convert inches to feet
    else
        stationdiam=stationdiam*3.28;  % convert meters to feet    
    end
    stationdiam_ft=stationdiam;
    
    rf=fring;
    W=smd;

    if(iu==2)   
        W=W*0.2048;  % convert from kg/m^2 to lbm/ft^2
    end
    W_lbm_per_ft2=W;    
    


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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'Wa');

output_name=get(handles.edit_output_array_name,'String');
assignin('base', output_name, data);


output_filename1=sprintf('%s.txt',output_name);

save(output_filename1,'data','-ASCII')

out1=sprintf('\n Data also written to text file:  %s \n',output_filename1);
disp(out1);


h = msgbox('Save Complete'); 


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units
change_materials_units(hObject, eventdata, handles);



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


% --- Executes on selection change in listbox_material.
function listbox_material_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_material
change_materials_units(hObject, eventdata, handles);


function change_materials_units(hObject, eventdata, handles)
%

iu=get(handles.listbox_units,'Value');

Nrows=get(handles.listbox_num,'Value');
Ncolumns=6;

if(iu==1)
    cn={'Shell Name','One-Third Octave SPL','Ring Freq (Hz)','Diameter (in)','Density (lbm/ft^2)','Output PSD Name'};
else
    cn={'Shell Name','Ring Freq (Hz)','Diameter (m)','Density (kg/m^2)','Output PSD Name'};  
end    

%%%%%%%%


A=get(handles.uitable_data,'Data');
 
sz=size(A);
Arows=sz(1);
 
for i=1:Nrows
    for j=1:Ncolumns
        data_s{i,j}='';
    end    
end    
 
if(~isempty(A))
    
    M=min([ Arows Nrows ]);
    
    for i=1:M
        for j=1:Ncolumns
            data_s{i,j}=A{i,j};
        end    
    end   
 
end
 
set(handles.uitable_data,'Data',data_s,'ColumnName',cn);

%%%%%%%%





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



function edit_E_Callback(hObject, eventdata, handles)
% hObject    handle to edit_E (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_E as text
%        str2double(get(hObject,'String')) returns contents of edit_E as a double


% --- Executes during object creation, after setting all properties.
function edit_E_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_E (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_W_Callback(hObject, eventdata, handles)
% hObject    handle to edit_W (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_W as text
%        str2double(get(hObject,'String')) returns contents of edit_W as a double


% --- Executes during object creation, after setting all properties.
function edit_W_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_W (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_diameter_Callback(hObject, eventdata, handles)
% hObject    handle to edit_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_diameter as text
%        str2double(get(hObject,'String')) returns contents of edit_diameter as a double


% --- Executes during object creation, after setting all properties.
function edit_diameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thickness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thickness as text
%        str2double(get(hObject,'String')) returns contents of edit_thickness as a double


% --- Executes during object creation, after setting all properties.
function edit_thickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ring_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ring_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ring_frequency as text
%        str2double(get(hObject,'String')) returns contents of edit_ring_frequency as a double


% --- Executes during object creation, after setting all properties.
function edit_ring_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ring_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_input_array_name and none of its controls.
function edit_input_array_name_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_E and none of its controls.
function edit_E_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_E (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_W and none of its controls.
function edit_W_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_W (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_diameter and none of its controls.
function edit_diameter_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_diameter (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_thickness and none of its controls.
function edit_thickness_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on selection change in listbox_smd.
function listbox_smd_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_smd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_smd contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_smd



% --- Executes during object creation, after setting all properties.
function listbox_smd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_smd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function get_table_data(hObject, eventdata, handles)

A=char(get(handles.uitable_data,'Data'));

N=get(handles.listbox_num,'Value');

fring=zeros(N,1);
diam=zeros(N,1);
smd=zeros(N,1);

k=1;

for i=1:N
    shell_name{i}=A(k,:); k=k+1;
    shell_name{i} = strtrim(shell_name{i});
end

for i=1:N
    SPL_name{i}=A(k,:); k=k+1;
    SPL_name{i} = strtrim(SPL_name{i});
end

for i=1:N
    fring(i)=str2double(A(k,:)); k=k+1;
end

for i=1:N
    diam(i)=str2double(A(k,:)); k=k+1;
end

for i=1:N
    smd(i)=str2double(A(k,:)); k=k+1;
end

for i=1:N
    PSD_name{i}=A(k,:); k=k+1;
    PSD_name{i} = strtrim(PSD_name{i});
end



setappdata(0,'shell_name',shell_name);
setappdata(0,'SPL_name',SPL_name);
setappdata(0,'fring',fring);
setappdata(0,'diam',diam);
setappdata(0,'smd',smd);
setappdata(0,'PSD_name',PSD_name);



% --- Executes on button press in pushbutton_save_model.
function pushbutton_save_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iu=get(handles.listbox_units,'Value');
Franken_multiple.iu=iu;

num=get(handles.listbox_num,'Value');
Franken_multiple.num=num;

get_table_data(hObject, eventdata, handles);

shell_name=getappdata(0,'shell_name');
SPL_name=getappdata(0,'SPL_name');
fring=getappdata(0,'fring');
diam=getappdata(0,'diam');
smd=getappdata(0,'smd');
PSD_name=getappdata(0,'PSD_name');


Franken_multiple.shell_name=shell_name;
Franken_multiple.SPL_name=SPL_name;
Franken_multiple.fring=fring;
Franken_multiple.diam=diam;
Franken_multiple.smd=smd;
Franken_multiple.PSD_name=PSD_name;

num_curves=get(handles.listbox_num_curves,'Value');
Franken_multiple.num_curves=num_curves;

A_legend=get(handles.uitable_legend,'Data');
Franken_multiple.A_legend=A_legend;

field=get(handles.listbox_field,'Value');
Franken_multiple.field=field;


N=num;

for i=1:N
    try
        
        if(i==1)
            THM1=evalin('base',SPL_name{i});
            Franken_multiple.THM1=THM1;
        end
        if(i==2)
            THM2=evalin('base',SPL_name{i});
            Franken_multiple.THM2=THM2;
        end        
        if(i==3)
            THM3=evalin('base',SPL_name{i});
            Franken_multiple.THM3=THM3;
        end
        if(i==4)
            THM4=evalin('base',SPL_name{i});
            Franken_multiple.THM4=THM4;
        end                
        
    catch
    end
end


 
 W=str2num(get(handles.edit_W,'String'));
Wc=str2num(get(handles.edit_Wc,'String'));
 add_mass=get(handles.listbox_add_mass,'Value');

 
Franken_multiple.W=W;
Franken_multiple.Wc=Wc;
Franken_multiple.add_mass=add_mass;



% % %
 
structnames = fieldnames(Franken_multiple, '-full'); % fields in the struct
  
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);
 
    try
 
        save(elk, 'Franken_multiple'); 
 
    catch
        warndlg('Save error');
        return;
    end
 
%%% SSS=load(elk)
 
%%%%%%%%%%
%%%%%%%%%%
 
% Construct a questdlg with four options
choice = questdlg('Save Complete.  Reset Workspace?', ...
    'Options', ...
    'Yes','No','No');
% Handle response
switch choice
    case 'Yes'
%%        disp([choice ' Reseting'])
%%        pushbutton_reset_Callback(hObject, eventdata, handles)
        appdata = get(0,'ApplicationData');
        fnsx = fieldnames(appdata);
        for ii = 1:numel(fnsx)
            rmappdata(0,fnsx{ii});
        end
end  



% --- Executes on button press in pushbutton_load_model.
function pushbutton_load_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ref 1');
 
[filename, pathname] = uigetfile('*.mat');
 
NAME = [pathname,filename];
 
struct=load(NAME);
structnames = fieldnames(struct, '-full'); % fields in the struct
 
disp(' ref 2');
 
k=length(structnames);
 
for i=1:k
    namevar=strcat('struct.',structnames{i});
    value=eval(namevar);
    assignin('base',structnames{i},value);
end
 
disp(' ref 3');
 
structnames
 
 
% struct
 
try
    Franken_multiple=evalin('base','Franken_multiple');
catch
    warndlg(' evalin failed ');
    return;
end
 
Franken_multiple
 
try
    iu=Franken_multiple.iu;    
    set(handles.listbox_units,'Value',iu);
catch
end
 
try
    num=Franken_multiple.num;    
    set(handles.listbox_num,'Value',num);
catch
end


try
    shell_name=Franken_multiple.shell_name;
catch
end

try
    SPL_name=Franken_multiple.SPL_name;
catch
end

try
    fring=Franken_multiple.fring;
catch
end

try
    diam=Franken_multiple.diam;  
catch
end

try
    smd=Franken_multiple.smd;
catch
end

try
    PSD_name=Franken_multiple.PSD_name;   
catch
end

try
    field=Franken_multiple.field;
    set(handles.listbox_field,'Value',field);
catch
end    


%%%%%%%%%%%%%%%%%%%%%%%

change_materials_units(hObject, eventdata, handles);

try    
    
    N=num;
    
    for i = 1:N

        data_s{i,1}=strtrim(shell_name{i});
        data_s{i,2}=strtrim(SPL_name{i});
        
        data_s{i,3}=sprintf('%g',fring(i));
        data_s{i,4}=sprintf('%g',diam(i));
        data_s{i,5}=sprintf('%g',smd(i));
        
        data_s{i,6}=PSD_name{i};
    end
    
catch    
    
    disp('data_s unsuccessful');
end  



try
    THM1=Franken_multiple.THM1;
    assignin('base',SPL_name{1},THM1); 
catch
end
try
    THM2=Franken_multiple.THM2;
    assignin('base',SPL_name{2},THM2); 
catch
end
try
    THM3=Franken_multiple.THM3;
    assignin('base',SPL_name{3},THM3); 
catch
end
try
    THM4=Franken_multiple.THM4;
    assignin('base',SPL_name{4},THM4); 
catch
end


try
    W=Franken_multiple.W;
    sss=sprintf('%g',W);
    set(handles.edit_W,'String',sss);
catch
end    

try
    Wc=Franken_multiple.Wc; 
    sss=sprintf('%g',Wc);
    set(handles.edit_Wc,'String',sss);
catch
end

try
    add_mass=Franken_multiple.add_mass;
    set(handles.listbox_add_mass,'Value',add_mass);
catch
end

listbox_add_mass_Callback(hObject, eventdata, handles)   
 


try
    set(handles.uitable_data,'Data',data_s);     
catch
    disp('set unsuccessful')
end    
    

try
    num_curves=Franken_multiple.num_curves;    
    set(handles.listbox_num_curves,'Value',num_curves);
    listbox_num_curves_Callback(hObject, eventdata, handles)
    
    try
        A_legend=Franken_multiple.A_legend;        
        set(handles.uitable_legend,'Data',A_legend);
    catch
        warndlg('Set Legend Failed');
    end
    
catch
end



 


% --- Executes on selection change in listbox_num.
function listbox_num_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num

change_materials_units(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit_Wc_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Wc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Wc as text
%        str2double(get(hObject,'String')) returns contents of edit_Wc as a double


% --- Executes during object creation, after setting all properties.
function edit_Wc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Wc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_add_mass.
function listbox_add_mass_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_add_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_add_mass contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_add_mass

n=get(handles.listbox_add_mass,'Value');

set(handles.text_W,'Visible','off');
set(handles.edit_W,'Visible','off');
set(handles.text_Wc,'Visible','off');
set(handles.edit_Wc,'Visible','off');
set(handles.text_ame,'Visible','off');

set(handles.listbox_add_mass,'Visible','on');

if(n==2 || n==3)

    set(handles.text_W,'Visible','on');
    set(handles.edit_W,'Visible','on');
    set(handles.text_Wc,'Visible','on');
    set(handles.edit_Wc,'Visible','on');    
    set(handles.text_ame,'Visible','on');

end



% --- Executes during object creation, after setting all properties.
function listbox_add_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_add_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_num_curves.
function listbox_num_curves_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num_curves (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num_curves contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num_curves

Nrows=get(handles.listbox_num_curves,'Value');

Ncolumns=1;
headers1={'Legend Title'};

set(handles.uitable_legend,'Data',cell(Nrows,Ncolumns),'ColumnName',headers1);



% --- Executes during object creation, after setting all properties.
function listbox_num_curves_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_num_curves (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_field.
function listbox_field_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_field (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_field contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_field


% --- Executes during object creation, after setting all properties.
function listbox_field_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_field (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1

function varargout = batch_vibrationdata_rainflow_Miners_Basquin(varargin)
% BATCH_VIBRATIONDATA_RAINFLOW_MINERS_BASQUIN MATLAB code for batch_vibrationdata_rainflow_Miners_Basquin.fig
%      BATCH_VIBRATIONDATA_RAINFLOW_MINERS_BASQUIN, by itself, creates a new BATCH_VIBRATIONDATA_RAINFLOW_MINERS_BASQUIN or raises the existing
%      singleton*.
%
%      H = BATCH_VIBRATIONDATA_RAINFLOW_MINERS_BASQUIN returns the handle to a new BATCH_VIBRATIONDATA_RAINFLOW_MINERS_BASQUIN or the handle to
%      the existing singleton*.
%
%      BATCH_VIBRATIONDATA_RAINFLOW_MINERS_BASQUIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BATCH_VIBRATIONDATA_RAINFLOW_MINERS_BASQUIN.M with the given input arguments.
%
%      BATCH_VIBRATIONDATA_RAINFLOW_MINERS_BASQUIN('Property','Value',...) creates a new BATCH_VIBRATIONDATA_RAINFLOW_MINERS_BASQUIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before batch_vibrationdata_rainflow_Miners_Basquin_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to batch_vibrationdata_rainflow_Miners_Basquin_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help batch_vibrationdata_rainflow_Miners_Basquin

% Last Modified by GUIDE v2.5 12-Jun-2018 12:06:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @batch_vibrationdata_rainflow_Miners_Basquin_OpeningFcn, ...
                   'gui_OutputFcn',  @batch_vibrationdata_rainflow_Miners_Basquin_OutputFcn, ...
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


% --- Executes just before batch_vibrationdata_rainflow_Miners_Basquin is made visible.
function batch_vibrationdata_rainflow_Miners_Basquin_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to batch_vibrationdata_rainflow_Miners_Basquin (see VARARGIN)

% Choose default command line output for batch_vibrationdata_rainflow_Miners_Basquin
handles.output = hObject;

listbox_ac_Callback(hObject, eventdata, handles);

listbox_mean_Callback(hObject, eventdata, handles)
listbox_material_Callback(hObject, eventdata, handles);


%% options_off(hObject,eventdata,handles);

%% set(handles.uipanel_miners,'Visible','off');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes batch_vibrationdata_rainflow_Miners_Basquin wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function options_off(hObject,eventdata,handles)

%% set(handles.edit_damage_result,'String',' ');

%% set(handles.text_EFT,'Enable','off');
%% set(handles.edit_exponent,'Enable','off');
%% set(handles.pushbutton_calculate_damage,'Enable','off');
%% set(handles.text_DR,'Enable','off');
%% set(handles.edit_damage_result,'Enable','off');

%% set(handles.edit_output_array,'Enable','off');
%% set(handles.pushbutton_save_table,'Enable','off');

%% set(handles.pushbutton_miners,'Enable','off');

%% set(handles.text_valid,'Enable','off');


% --- Outputs from this function are returned to the command line.
function varargout = batch_vibrationdata_rainflow_Miners_Basquin_OutputFcn(hObject, eventdata, handles) 
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

disp(' ');
disp(' * * * * * * * * * * * * ');
disp(' ');

iu=get(handles.listbox_unit,'Value');

mx=str2num(get(handles.edit_m,'String'));
A=str2num(get(handles.edit_A,'String'));

nac=get(handles.listbox_ac,'Value');

if(nac==1)
    nformat=get(handles.listbox_format,'Value');
end


scf=str2num(get(handles.edit_scf,'String'));

if(isempty(scf))
    warndlg('Enter scf');
    return;
end  

num_eng=get(handles.listbox_numerical_engine,'Value');



nnn=get(handles.listbox_unit,'Value');

if(nnn==1)
    YY='psi';
    ylab='Stress (psi)';
end
if(nnn==2)
    YY='ksi';    
    ylab='Stress (ksi)';
end
if(nnn==3)
    YY='MPa';    
    ylab='Stress (MPa)';
end

out1=sprintf(' Unit:  %s ',ylab);
disp(out1);


mlab=getappdata(0,'mlab');

out1=sprintf('\n Material: %s ',mlab);
disp(out1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
out1=sprintf(' Fatigue exponent m = %g ',mx);
disp(out1);
out2=sprintf(' Fatigue strength coefficient A = %g ',A);
disp(out2);

%% out3=sprintf('\n Duration tau = %g sec ',tau);
%% disp(out3);

out1=sprintf('\n Stress Concentration Factor =%g',scf);
disp(out1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

aux_stress=1;

mc=get(handles.listbox_mean,'Value');

if(mc>=2)  
    aux_stress=str2num(get(handles.edit_stress_aux,'String'));
end


disp(' ');
disp(' -------  Amplitude Results -------  ');
disp(' ');

   if(mc==1) % None
       disp(' No mean correction ');
   end
   if(mc==2) % Gerber Ultimate Stress 
        disp(' Gerber mean correction ');
   end
   if(mc==3) % Goodman Ultimate Stress 
        disp(' Goodman mean correction ');      
   end
   if(mc==4) % Morrow True Fracture
        disp(' Morrow mean correction ');         
   end
   if(mc==5) % Soderberg Yield Stress
        disp(' Soderberg mean correction ');           
   end
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
 
 
kv=length(sarray);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
damage=zeros(kv,1);
 
progressbar;

for ijk=1:kv
 
    progressbar(ijk/kv);
 
    ss=char(sarray(ijk,:));
    
    THM=evalin('base',ss);
 
    THM=fix_size(THM);
 
    sz=size(THM);
 
    if(sz(2)==1)
        y=THM(:,1);
    else    
        y=THM(:,2);
    end

    if(num_eng==1)
        [range_cycles,amean,amax,amin,BIG]=vibrationdata_rainflow_mean_max_min_function_np(y);     
        amp_cycles=[range_cycles(:,1)/2 range_cycles(:,2)];
        amean=fix_size(amean);
        amp_mean_cycles=[range_cycles(:,1)/2 amean range_cycles(:,2)];
            
    else
    
        dchoice=-1.; % needs to be double
%
        exponent=1;
% 
        [L,C,AverageAmp,MaxAmp,MinMean,AverageMean,MaxMean,MinValley,MaxPeak,D,ac1,ac2,amean,cL]...
                                         =rainflow_mean_mex(y,dchoice,exponent);
%
        sz=size(ac1);
        if(sz(2)>sz(1))
            ac1=ac1';
            ac2=ac2';
        end
%
        ncL=int64(cL);
%
        amp_cycles=[ ac1(1:ncL) ac2(1:ncL) ];
    
        amean=amean(1:ncL);
    
        amean=fix_size(amean);
%
        amp_mean_cycles=[ ac1(1:ncL) amean(1:ncL) ac2(1:ncL) ];
        range_cycles=[2*amp_cycles(:,1) amp_cycles(:,2)];
%
    end
    
    s=amp_mean_cycles(:,1);
    mean_stress=amp_mean_cycles(:,2);
    n=amp_mean_cycles(:,3);
    
    [D]=rainflow_stress_damage(s,mean_stress,n,scf,mc,mx,A,aux_stress);
    
    damage(ijk)=D;
    ssq{ijk}=ss;
    
    if(nac==1)
        % export file
        
        if(nformat==1)
            ac_data=amp_cycles;
            sx='amp_cycles';
        end
        if(nformat==2)
            ac_data=amp_mean_cycles;
            sx='amp_mean_cycles';
        end
        if(nformat==3)
            ac_data=range_cycles;
            sx='range_cycles';
        end
        if(nformat==4)
            ac_data=range_cycles_max_min;
            sx='range_cycles_max_min';
        end   
        
        ssf{ijk}=sprintf('%s_%s',ss,sx);
        
        assignin('base', ssf{ijk}, ac_data);
        
    end    

end

pause(0.3);
progressbar(1);


if(nac==1)
    
    disp(' ');
    disp(' Output Arrays:');
    
    for i=1:kv
        out1=sprintf('  %s',ssf{i});
        disp(out1);
    end
end    


for i=1:kv
    data_s{i,1} = ssq{i}; 
    data_s{i,2} = sprintf('%9.4g',damage(i)); 
end

ssq=ssq';

Array=ssq;
Damage=damage;

disp(' ');
disp('  Palmgren-Miner Damage  ');
 
T = table(Array,Damage);

T

eoa=get(handles.edit_eoa,'String');

    assignin('base', eoa, data_s);

%%%

    hFig = figure(100);

    columnname =   {'    Array    ','Damage'};
    columnformat = {'numeric', 'numeric'};
    columneditable = [false false];   
    columnwidth={ 140 140 };

    xwidth=300;
    ywidth=500;
    set(gcf,'PaperPositionMode','auto')
    set(hFig, 'Position', [0 0 xwidth ywidth])
    table1 = uitable;

%
    table1 = uitable('Units','normalized','Position',...
            [0 0 1 1], 'Data', data_s,... 
            'ColumnName', columnname,...
            'ColumnFormat', columnformat,...
            'ColumnEditable', columneditable,...
            'ColumnWidth', columnwidth,...
            'RowName',[]);  

    table1.FontSize = 9;

    disp(' ');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

msgbox('Calculation Complete');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function[D]=rainflow_stress_damage(s,mean_stress,n,scf,mc,mx,A,aux_stress)

    if(min(s)<0)
        errordlg('Minimum Stress < 0 '); 
        return; 
    end
 
    if(min(n)<0)
        errordlg('Minimum Cycle < 0 '); 
        return; 
    end
    
    m=length(s);
 
    D=0;
 
    zp=m;
 
    ssa=0;
    ssr=0;
 
    s=s*scf;
    mean_stress=mean_stress*scf;
    
    CC=zeros(m,1);
    ratio=zeros(m,1);
 
    iflag=0;    

    for i=1:m
%
        Se=s(i);
   
        if(mc>1)
            ratio(i)=abs(mean_stress(i))/aux_stress;
        end
%
%%%%%%%%%%%%%%%%%%%%%%%%%
%
        C=1;
%
        if(mc==2) % Gerber Ultimate Stress 
            C=1-(ratio(i)^2);
        end
        if(mc==3) % Goodman Ultimate Stress 
            C=1- ratio(i);  
        end
        if(mc==4) % Morrow True Fracture
            C=1- ratio(i);     
        end
        if(mc==5) % Soderberg Yield Stress
            C=1-ratio(i);   
        end
   
        if(abs(C)>1)
            iflag=1;
            C=1;
        end
%
        Se=Se/C;
%
%%%%%%%%%%%%%%%%%%%%%%%%%
%
 
        CC(i)=C;
  
        D=D+n(i)*Se^mx;
    
        ssa=ssa+Se^mx;      
        ssr=ssr+(2*Se)^mx;    
    
%    
    end
 
    if(iflag==1)
        warndlg(' Mean stress exceeds limit stress ');
        return;
    end

    D=D/A;
  
%%    ssa=ssa/m;
%%    ssr=ssr/m;
%%    rzp=zp/tau;




function change_unit(hObject, eventdata, handles) 
%
%% set(handles.edit_damage,'Enable','off','Visible','off');
%
n=get(handles.listbox_unit,'Value');
n_mat=get(handles.listbox_material,'Value');

[mlab,m,A,ss,ms,As]=Basquin_coefficients(n,n_mat);
 
set(handles.text_unit,'String',ss);
set(handles.edit_m,'String',ms);
set(handles.edit_A,'String',As);
 
setappdata(0,'mlab',mlab);
setappdata(0,'A_label',ss); 
 
set(handles.text_unit,'String',ss);
 
set(handles.edit_m,'String',ms);
set(handles.edit_A,'String',As);


m=get(handles.listbox_mean,'Value');

if(n==1)
%    set(handles.text_mean_stress,'String','Mean Stress (psi)');
    if(m>=2 && m<=3)
        set(handles.text_aux_stress,'String','Ultimate Stress Limit (psi)');
    end
    if(m==4)
        set(handles.text_aux_stress,'String','True Fracture Stress (psi)');    
    end
    if(m==5)
        set(handles.text_aux_stress,'String','Yield Stress Limits (psi)');      
    end
end
if(n==2)
%    set(handles.text_mean_stress,'String','Mean Stress (ksi)');
    if(m>=2 && m<=3)
        set(handles.text_aux_stress,'String','Ultimate Stress Limit (ksi)');
    end
    if(m==4)
        set(handles.text_aux_stress,'String','True Fracture Stress (ksi)');    
    end
    if(m==5)
        set(handles.text_aux_stress,'String','Yield Stress Limits (ksi)');      
    end
end    
if(n==3)
%    set(handles.text_mean_stress,'String','Mean Stress (MPa)');
    if(m>=2 && m<=3)
        set(handles.text_aux_stress,'String','Ultimate Stress Limit (MPa)');
    end
    if(m==4)
        set(handles.text_aux_stress,'String','True Fracture Stress (MPa)');    
    end
    if(m==5)
        set(handles.text_aux_stress,'String','Yield Stress Limits (MPa)');      
    end
end    

% --- Executes on button press in pushbutton_results.
function pushbutton_results_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(batch_vibrationdata_rainflow_Miners_Basquin);

% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_output_type,'Value');

if(n==1)
    data=getappdata(0,'amp_cycles'); 
end
if(n==2)
    data=getappdata(0,'amp_mean_cycles');     
end
if(n==3)
    data=getappdata(0,'range_cycles');  
end

output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

%% set(handles.uipanel_miners,'Visible','on');

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
n=get(hObject,'Value');

options_off(hObject,eventdata,handles);

set(handles.edit_input_array,'String',' ');

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');


if(n==1)
   set(handles.edit_input_array,'enable','on') 
else
    
   set(handles.text_input_array_name,'Visible','off');
   set(handles.edit_input_array,'Visible','off');    
   set(handles.edit_input_array,'enable','off')
   
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




function edit_table_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_table_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_table_name as text
%        str2double(get(hObject,'String')) returns contents of edit_table_name as a double


% --- Executes during object creation, after setting all properties.
function edit_table_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_table_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_exponent_Callback(hObject, eventdata, handles)
% hObject    handle to edit_exponent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_exponent as text
%        str2double(get(hObject,'String')) returns contents of edit_exponent as a double


% --- Executes during object creation, after setting all properties.
function edit_exponent_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_exponent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_calculate_damage.
function pushbutton_calculate_damage_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate_damage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

b=str2num(get(handles.edit_exponent,'String'));

range_cycles=getappdata(0,'range_cycles');  

D=0;

sz=size(range_cycles);

for i=1:sz(1)
    D=D+range_cycles(i,2)*( 0.5*range_cycles(i,1) )^b;
end    

string=sprintf('%8.4g',D);

set(handles.edit_damage_result,'String',string);


function edit_damage_result_Callback(hObject, eventdata, handles)
% hObject    handle to edit_damage_result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_damage_result as text
%        str2double(get(hObject,'String')) returns contents of edit_damage_result as a double


% --- Executes during object creation, after setting all properties.
function edit_damage_result_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_damage_result (see GCBO)
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
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

options_off(hObject,eventdata,handles);


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


% --- Executes on selection change in listbox_display_table.
function listbox_display_table_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_display_table (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_display_table contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_display_table


% --- Executes during object creation, after setting all properties.
function listbox_display_table_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_display_table (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_display_figures.
function listbox_display_figures_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_display_figures (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_display_figures contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_display_figures


% --- Executes during object creation, after setting all properties.
function listbox_display_figures_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_display_figures (see GCBO)
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


% --- Executes on button press in pushbutton_miners.
function pushbutton_miners_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_miners (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=vibrationdata_miners;    
 
set(handles.s,'Visible','on'); 



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



function edit_B_Callback(hObject, eventdata, handles)
% hObject    handle to edit_B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_B as text
%        str2double(get(hObject,'String')) returns contents of edit_B as a double


% --- Executes during object creation, after setting all properties.
function edit_B_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_C_Callback(hObject, eventdata, handles)
% hObject    handle to edit_C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_C as text
%        str2double(get(hObject,'String')) returns contents of edit_C as a double


% --- Executes during object creation, after setting all properties.
function edit_C_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_P_Callback(hObject, eventdata, handles)
% hObject    handle to edit_P (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_P as text
%        str2double(get(hObject,'String')) returns contents of edit_P as a double


% --- Executes during object creation, after setting all properties.
function edit_P_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_P (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit
change_unit(hObject, eventdata, handles); 

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


% --- Executes on button press in pushbutton_eq.
function pushbutton_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

A = imread('nasgro_coefficients.jpg');
figure(555);
imshow(A,'border','tight','InitialMagnification',100);


% --- Executes on selection change in listbox_material.
function listbox_material_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_material

change_unit(hObject, eventdata, handles); 


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


% --- Executes on selection change in listbox_material.
function listbox10_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_material


% --- Executes during object creation, after setting all properties.
function listbox10_CreateFcn(hObject, eventdata, handles)
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



function edit28_Callback(hObject, eventdata, handles)
% hObject    handle to edit_A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_A as text
%        str2double(get(hObject,'String')) returns contents of edit_A as a double


% --- Executes during object creation, after setting all properties.
function edit28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_stress_aux_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stress_aux (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stress_aux as text
%        str2double(get(hObject,'String')) returns contents of edit_stress_aux as a double


% --- Executes during object creation, after setting all properties.
function edit_stress_aux_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stress_aux (see GCBO)
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


% --- Executes on selection change in listbox_mean.
function listbox_mean_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_mean contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_mean
n=get(handles.listbox_mean,'Value');

if(n==1)
%    set(handles.edit_mean_stress,'Visible','off');
%    set(handles.text_mean_stress,'Visible','off');
    set(handles.edit_stress_aux,'Visible','off');
    set(handles.text_aux_stress,'Visible','off');    
else
%    set(handles.edit_mean_stress,'Visible','on');
%    set(handles.text_mean_stress,'Visible','on');
    set(handles.edit_stress_aux,'Visible','on');
    set(handles.text_aux_stress,'Visible','on');     
end

iu=get(handles.listbox_unit,'Value');

if(n==2) % Gerber
    if(iu==1)
            set(handles.text_aux_stress,'String','Ultimate Stress Limit (psi)'); 
    end
    if(iu==2)
            set(handles.text_aux_stress,'String','Ultimate Stress Limit (ksi)'); 
    end
    if(iu==3)
            set(handles.text_aux_stress,'String','Ultimate Stress Limit (MPa)'); 
    end    
end
if(n==3) % Goodman
    if(iu==1)
            set(handles.text_aux_stress,'String','Ultimate Stress Limit (psi)');   
    end
    if(iu==2)
            set(handles.text_aux_stress,'String','Ultimate Stress Limit (ksi)');   
    end
    if(iu==3)
            set(handles.text_aux_stress,'String','Ultimate Stress Limit (MPa)');   
    end    
   
end
if(n==4) % Morrow
    if(iu==1)
            set(handles.text_aux_stress,'String','True Fracture Stress (psi)');   
    end
    if(iu==2)
            set(handles.text_aux_stress,'String','True Fracture Stress (ksi)');   
    end
    if(iu==3)
            set(handles.text_aux_stress,'String','True Fracture Stress (MPa)');   
    end    
  
end
if(n==5) % Soderberg
    if(iu==1)
            set(handles.text_aux_stress,'String','Yield Stress Limit (psi)');   
    end
    if(iu==2)
            set(handles.text_aux_stress,'String','Yield Stress Limit (ksi)');   
    end
    if(iu==3)
            set(handles.text_aux_stress,'String','Yield Stress Limit (MPa)');   
    end      
end


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



function edit_tstring_Callback(hObject, eventdata, handles)
% hObject    handle to edit_tstring (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_tstring as text
%        str2double(get(hObject,'String')) returns contents of edit_tstring as a double


% --- Executes during object creation, after setting all properties.
function edit_tstring_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_tstring (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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


% --- Executes on selection change in listbox_ac.
function listbox_ac_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_ac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_ac contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_ac

n=get(handles.listbox_ac,'Value');

set(handles.text_format,'Visible','off');
set(handles.listbox_format,'Visible','off');

if(n==1)
    set(handles.text_format,'Visible','on');
    set(handles.listbox_format,'Visible','on');
end


% --- Executes during object creation, after setting all properties.
function listbox_ac_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_ac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_eoa_Callback(hObject, eventdata, handles)
% hObject    handle to edit_eoa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_eoa as text
%        str2double(get(hObject,'String')) returns contents of edit_eoa as a double


% --- Executes during object creation, after setting all properties.
function edit_eoa_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_eoa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function varargout = batch_vibrationdata_rainflow(varargin)
% BATCH_VIBRATIONDATA_RAINFLOW MATLAB code for batch_vibrationdata_rainflow.fig
%      BATCH_VIBRATIONDATA_RAINFLOW, by itself, creates a new BATCH_VIBRATIONDATA_RAINFLOW or raises the existing
%      singleton*.
%
%      H = BATCH_VIBRATIONDATA_RAINFLOW returns the handle to a new BATCH_VIBRATIONDATA_RAINFLOW or the handle to
%      the existing singleton*.
%
%      BATCH_VIBRATIONDATA_RAINFLOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BATCH_VIBRATIONDATA_RAINFLOW.M with the given input arguments.
%
%      BATCH_VIBRATIONDATA_RAINFLOW('Property','Value',...) creates a new BATCH_VIBRATIONDATA_RAINFLOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before batch_vibrationdata_rainflow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to batch_vibrationdata_rainflow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help batch_vibrationdata_rainflow

% Last Modified by GUIDE v2.5 12-Jun-2018 10:37:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @batch_vibrationdata_rainflow_OpeningFcn, ...
                   'gui_OutputFcn',  @batch_vibrationdata_rainflow_OutputFcn, ...
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


% --- Executes just before batch_vibrationdata_rainflow is made visible.
function batch_vibrationdata_rainflow_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to batch_vibrationdata_rainflow (see VARARGIN)

% Choose default command line output for batch_vibrationdata_rainflow
handles.output = hObject;

listbox_ac_Callback(hObject, eventdata, handles);

listbox_damage_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes batch_vibrationdata_rainflow wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function options_off(hObject,eventdata,handles)




% --- Outputs from this function are returned to the command line.
function varargout = batch_vibrationdata_rainflow_OutputFcn(hObject, eventdata, handles) 
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

nac=get(handles.listbox_ac,'Value');
ndam=get(handles.listbox_damage,'Value');


if(nac==2 && ndam==2)
    warndlg('Nothing to do');
    return;
end

if(nac==1)
    nformat=get(handles.listbox_format,'Value');
end

if(ndam==1)
    nexp=str2num(get(handles.edit_exponent,'String'));
    eoa=get(handles.edit_eoa,'String');

    out1=sprintf(' fatigue exponent b = %g',nexp);
    disp(out1);

end

num_eng=get(handles.listbox_numerical_engine,'Value');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
        [range_cycles,amean,amax,amin,BIG]=vibrationdata_rainflow_mean_max_min_function_np(THM);   
   
        amp_cycles=[range_cycles(:,1)/2 range_cycles(:,2)];
        amean=fix_size(amean);
        amp_mean_cycles=[range_cycles(:,1)/2 amean range_cycles(:,2)];
 
        amax=fix_size(amax);
        amin=fix_size(amin);
    
        range_cycles_max_min=[range_cycles(:,1) range_cycles(:,2) amax amin ];

    else
%   
        dchoice=-1.; % needs to be double
%
        exponent=1;
% 
        [L,C,AverageAmp,MaxAmp,MinMean,AverageMean,MaxMean,MinValley,MaxPeak,D,ac1,ac2,amean,amax,amin,cL]...
                                         =rainflow_mean_max_min_mex(y,dchoice,exponent);
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
        amean=fix_size(amean);
        amin=fix_size(amin);
        amax=fix_size(amax);    
%      
        amp_mean_cycles=[ ac1(1:ncL) amean(1:ncL) ac2(1:ncL) ];
        range_cycles=[2*amp_cycles(:,1) amp_cycles(:,2)];
        range_cycles_max_min=[2*amp_cycles(:,1) amp_cycles(:,2) amax(1:ncL) amin(1:ncL) ];    
%

%       setappdata(0,'amp_cycles',amp_cycles); 
%       setappdata(0,'amp_mean_cycles',amp_mean_cycles); 
%       setappdata(0,'range_cycles',range_cycles);
%       setappdata(0,'range_cycles_max_min',range_cycles_max_min);  
%       setappdata(0,'BIG',BIG); 

    end


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

    if(ndam==1)
        b=nexp;
        D=0;

        sz=size(range_cycles);

        for i=1:sz(1)
            D=D+range_cycles(i,2)*( 0.5*range_cycles(i,1) )^b;
        end
    
        damage(ijk)=D;
        ssq{ijk}=ss;

    end

end

pause(0.3);
progressbar(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nac==1)
    
    disp(' ');
    disp(' Output Arrays:');
    
    for i=1:kv
        out1=sprintf('  %s',ssf{i});
        disp(out1);
    end
end    

if(ndam==1)

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

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' '); 
disp(' Calculation complete. ');
disp(' '); 


% --- Executes on button press in pushbutton_results.
function pushbutton_results_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(batch_vibrationdata_rainflow);

% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_format,'Value');

if(n==1)
    data=getappdata(0,'amp_cycles'); 
end
if(n==2)
    data=getappdata(0,'amp_mean_cycles');     
end
if(n==3)
    data=getappdata(0,'range_cycles');  
end
if(n==4)
    data=getappdata(0,'range_cycles_max_min');  
end

output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

set(handles.uipanel_miners,'Visible','on');

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


% --- Executes on selection change in listbox_damage.
function listbox_damage_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_damage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_damage contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_damage

n=get(handles.listbox_damage,'Value');

set(handles.text_EFT,'Visible','off');
set(handles.edit_exponent,'Visible','off');

set(handles.text_eoa,'Visible','off');
set(handles.edit_eoa,'Visible','off');


if(n==1)
    set(handles.text_EFT,'Visible','on');
    set(handles.edit_exponent,'Visible','on');

    set(handles.text_eoa,'Visible','on');
    set(handles.edit_eoa,'Visible','on');
end



% --- Executes during object creation, after setting all properties.
function listbox_damage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_damage (see GCBO)
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

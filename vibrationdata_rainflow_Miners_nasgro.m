function varargout = vibrationdata_rainflow_Miners_nasgro(varargin)
% VIBRATIONDATA_RAINFLOW_MINERS_NASGRO MATLAB code for vibrationdata_rainflow_Miners_nasgro.fig
%      VIBRATIONDATA_RAINFLOW_MINERS_NASGRO, by itself, creates a new VIBRATIONDATA_RAINFLOW_MINERS_NASGRO or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_RAINFLOW_MINERS_NASGRO returns the handle to a new VIBRATIONDATA_RAINFLOW_MINERS_NASGRO or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_RAINFLOW_MINERS_NASGRO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_RAINFLOW_MINERS_NASGRO.M with the given input arguments.
%
%      VIBRATIONDATA_RAINFLOW_MINERS_NASGRO('Property','Value',...) creates a new VIBRATIONDATA_RAINFLOW_MINERS_NASGRO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_rainflow_Miners_nasgro_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_rainflow_Miners_nasgro_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_rainflow_Miners_nasgro

% Last Modified by GUIDE v2.5 06-Aug-2021 16:18:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_rainflow_Miners_nasgro_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_rainflow_Miners_nasgro_OutputFcn, ...
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


% --- Executes just before vibrationdata_rainflow_Miners_nasgro is made visible.
function vibrationdata_rainflow_Miners_nasgro_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_rainflow_Miners_nasgro (see VARARGIN)

% Choose default command line output for vibrationdata_rainflow_Miners_nasgro
handles.output = hObject;

listbox_unit_Callback(hObject, eventdata, handles);

set(handles.listbox_method,'Value',1);

listbox_material_Callback(hObject, eventdata, handles);


options_off(hObject,eventdata,handles);

%% set(handles.uipanel_miners,'Visible','off');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_rainflow_Miners_nasgro wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function options_off(hObject,eventdata,handles)

%% set(handles.edit_damage_result,'String',' ');

%% set(handles.text_EFT,'Enable','off');
%% set(handles.edit_exponent,'Enable','off');
%% set(handles.pushbutton_calculate_damage,'Enable','off');
%% set(handles.text_DR,'Enable','off');
%% set(handles.edit_damage_result,'Enable','off');
set(handles.pushbutton_save,'Enable','off');
set(handles.edit_output_array,'Enable','off');
set(handles.pushbutton_save_table,'Enable','off');

%% set(handles.pushbutton_miners,'Enable','off');

%% set(handles.text_valid,'Enable','off');


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_rainflow_Miners_nasgro_OutputFcn(hObject, eventdata, handles) 
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


try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end 


change(hObject, eventdata, handles);

USL=str2double(get(handles.edit_USL,'String'));

tscale=str2num(get(handles.edit_tscale,'String'));

ndt=get(handles.listbox_display_table,'Value');

num_eng=get(handles.listbox_numerical_engine,'Value');

scf=str2num(get(handles.edit_scf,'String'));

k=get(handles.listbox_method,'Value');

try

    if(k==1)
        FS=get(handles.edit_input_array,'String');
        THM=evalin('base',FS);   
    else
        THM=getappdata(0,'THM');
    end

catch
    
    warndlg('Input array not found');
    return;
    
end



THM=fix_size(THM);


sz=size(THM);

if(sz(2)==1)
    y=THM(:,1);
else    
    y=THM(:,2);
end

y=y*scf;

iu=get(handles.listbox_unit,'Value');

Pa_per_psi = 6894.;

yo=max(abs(y));

if(iu==1) % psi
   USL=USL/1000;
   y=y/1000;
   YS='Stress (psi)';
   fprintf('\n Maximum absolute stress = %8.4g psi \n\n',yo);
end
if(iu==2) % ksi    
   YS='Stress (ksi)';
   fprintf('\n Maximum absolute stress = %8.4g ksi \n\n',yo);   
end
if(iu==3) % Pa
   USL=USL/Pa_per_psi; 
   y=y/Pa_per_psi; 
   YS='Stress (Pa)';
   fprintf('\n Maximum absolute stress = %8.4g Pa \n\n',yo);
end
if(iu==4) % MPa
   USL=USL*1.0e+06/Pa_per_psi;
   y=y*1.0e+06/Pa_per_psi;    
   YS='Stress (MPa)';
   fprintf('\n Maximum absolute stress = %8.4g MPa \n\n',yo);   
end

if(max(abs(y))>0.85*USL)
    
    warndlg('Warning:  Maximum stress > 0.85 * Ultimate Stress Limit ');
    return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ndf=get(handles.listbox_display_figures,'Value');

[amp_cycles,amp_mean_cycles,range_cycles_max_min,range_cycles,BIG]=...
                                                 rainflow_numerical_engine(y,YS,ndf,num_eng,THM);
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(ndt==1)
%
    figure(3)
    hFig = figure(3);
    xwidth=900;
    ywidth=400;
    set(gcf,'PaperPositionMode','auto')
    set(hFig, 'Position', [0 0 xwidth ywidth])
    table1 = uitable;
    set(table1,'ColumnWidth',{27})

    dat =  BIG(:,1:10);
    columnname =   {'Lower Range','Upper Range','Cycles','Ave Amp',...
       'Max Amp','Min Mean','Ave Mean','Max Mean','Min Valley','Max Peak' };
    columnformat = {'numeric', 'numeric','numeric','numeric','numeric',...
       'numeric','numeric','numeric','numeric','numeric'};
    columneditable = [false false false false false false false false false false];   

    sz=size(BIG);
%
    for i = 1:sz(1)
        for j=1:sz(2)
            if(j==3)
                tempStr = sprintf('%10.1f', dat(i,j));                
            else
                tempStr = sprintf('%7.3g', dat(i,j));
            end    
            data_s{i,j} = tempStr;     
        end  
    end
%
    table1 = uitable('Units','normalized','Position',...
            [0 0 1 1], 'Data', data_s,... 
            'ColumnName', columnname,...
            'ColumnFormat', columnformat,...
            'ColumnEditable', columneditable,...
            'RowName',[]);
%
    setappdata(0,'columnname',columnname); 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setappdata(0,'amp_cycles',amp_cycles); 
setappdata(0,'amp_mean_cycles',amp_mean_cycles); 
setappdata(0,'range_cycles',range_cycles);  
setappdata(0,'BIG',BIG); 


set(handles.pushbutton_save,'Enable','on');
set(handles.edit_output_array,'Enable','on');
set(handles.pushbutton_save_table,'Enable','on');


%% set(handles.text_EFT,'Enable','on');
%% set(handles.edit_exponent,'Enable','on');
%% set(handles.pushbutton_calculate_damage,'Enable','on');
%% set(handles.text_DR,'Enable','on');
%% set(handles.edit_damage_result,'Enable','on');

%% set(handles.pushbutton_miners,'Enable','on');
%% set(handles.text_valid,'Enable','on');


assignin('base', 'range_cycles', range_cycles);

sz=size(range_cycles);

if(sz(1)<=14)
    
   range_cycles=sortrows(range_cycles,1);
   range_cycles=flipud(range_cycles);

   disp(' ');
   disp('     Range  Cycles ');
    
   for i=1:sz(1) 
        out1=sprintf(' %8.4g   %g',range_cycles(i,1),range_cycles(i,2));
        disp(out1);
   end
   
end

A=str2num(get(handles.edit_A,'String'));
B=str2num(get(handles.edit_B,'String'));
C=str2num(get(handles.edit_C,'String'));
P=str2num(get(handles.edit_P,'String'));

if(B<0)
    warndlg(' B coefficient should be > 0 '); 
    return;
end

[damage]=rainflow_stress_damage_nasgro(amp_mean_cycles,A,B,C,P);


disp(' ');
disp(' * * * * ');

sz=size(THM);
nt=sz(1);

if(sz(2)==1)
    tau=1;
else
    tau=THM(nt,1)-THM(1,1);    
end

mlab=getappdata(0,'mlab');
 
out1=sprintf('\n Material: %s ',mlab);
disp(out1);

out1=sprintf('\n A=%g  B=%g  C=%g  P=%g ',A,B,C,P);
disp(out1);

sz=size(THM);

if(sz(2)==2)
    out1=sprintf('\n Input Duration=%8.4g sec   Scaled Duration=%8.4g sec',tau,tau*tscale);
    disp(out1);
end


out1=sprintf('\n Overall Stress Amplitude with stress scale factor =%8.4g ksi 1\x3c3 ',std(y));
disp(out1);
out1=sprintf('\n Maximum Rainflow Stress Amplitude with scale factor =%8.4g ksi ',max( amp_mean_cycles(:,1) ));
disp(out1);

out1=sprintf('\n Number of Rainflow Cycles=%8.4g \n',sum(amp_mean_cycles(:,3)));
disp(out1);

out1=sprintf('\n For stress scale factor=%g & duration scale factor=%g',scf,tscale);
disp(out1);

out1=sprintf('\n Cumulative Damage=%8.4g ',damage*tscale);
disp(out1);

sz=size(THM);

if(sz(2)==2)
    out1=sprintf('\n Cumulative Damage Rate=%8.4g damage/sec\n',damage/tau);
    disp(out1);
end

msgbox('Results written to command window.'); 


% --- Executes on button press in pushbutton_results.
function pushbutton_results_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_rainflow_Miners_nasgro);

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

n=get(handles.listbox_unit,'Value');

change(hObject, eventdata, handles);





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


change(hObject, eventdata, handles);


function change(hObject, eventdata, handles)


n=get(handles.listbox_material,'Value');

% 1. Aluminum 6061-T6
% 2. Aluminum 7050-T7451
% 3. Aluminum 7075-T6
% 4. Inconel 718
% 5. Stainless Steel Custom 450 (H1050)
% 6. Stainless Steel 15-5PH, 1025 

[mlab,As,Bs,Cs,Ps]=SN_coefficients(n);

set(handles.edit_A,'String',As);
set(handles.edit_B,'String',Bs);
set(handles.edit_C,'String',Cs);
set(handles.edit_P,'String',Ps);

setappdata(0,'mlab',mlab);

m=get(handles.listbox_unit,'Value');

if(m==1)
    sss='Ultimate Stress Limit (psi)';
end
if(m==2)
    sss='Ultimate Stress Limit (ksi)';
end
if(m==3)
    sss='Ultimate Stress Limit (Pa)';
end
if(m==4)
    sss='Ultimate Stress Limit (MPa)';
end

set(handles.text_USL,'String',sss);


set(handles.edit_USL,'string','');


if(n==1) % Aluminum 6061-T6
    USL=42000;
end
if(n==2) % Aluminum 7050-T7451
    USL=76000;
end
if(n==3) % Aluminum 7075-T6
    USL=74000;
end
if(n==4)  % Inconel 718
    USL=199000;
end
if(n==5)  % Stainless Steel Custom 450 (H1050)
    USL=160000;
end
if(n==6) % Stainless Steel 15-5PH, 1025 
    USL=155000;
end



if(m==2) % ksi
    USL=USL/1000;
end
if(m==3) % Pa
    USL=USL*6891.2;
end
if(m==4) % MPa
    USL=USL*6891.2/1.0e+06;
end

if(n<=6)
    ss=sprintf('%g',USL);
    set(handles.edit_USL,'string',ss); 
end


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



function edit_USL_Callback(hObject, eventdata, handles)
% hObject    handle to edit_USL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_USL as text
%        str2double(get(hObject,'String')) returns contents of edit_USL as a double


% --- Executes during object creation, after setting all properties.
function edit_USL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_USL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_tscale_Callback(hObject, eventdata, handles)
% hObject    handle to edit_tscale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_tscale as text
%        str2double(get(hObject,'String')) returns contents of edit_tscale as a double


% --- Executes during object creation, after setting all properties.
function edit_tscale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_tscale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function varargout = vibrationdata_rainflow(varargin)
% VIBRATIONDATA_RAINFLOW MATLAB code for vibrationdata_rainflow.fig
%      VIBRATIONDATA_RAINFLOW, by itself, creates a new VIBRATIONDATA_RAINFLOW or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_RAINFLOW returns the handle to a new VIBRATIONDATA_RAINFLOW or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_RAINFLOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_RAINFLOW.M with the given input arguments.
%
%      VIBRATIONDATA_RAINFLOW('Property','Value',...) creates a new VIBRATIONDATA_RAINFLOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_rainflow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_rainflow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_rainflow

% Last Modified by GUIDE v2.5 01-Aug-2014 09:00:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_rainflow_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_rainflow_OutputFcn, ...
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


% --- Executes just before vibrationdata_rainflow is made visible.
function vibrationdata_rainflow_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_rainflow (see VARARGIN)

% Choose default command line output for vibrationdata_rainflow
handles.output = hObject;

set(handles.listbox_method,'Value',1);


options_off(hObject,eventdata,handles);

set(handles.uipanel_miners,'Visible','off');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_rainflow wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function options_off(hObject,eventdata,handles)

set(handles.edit_damage_result,'String',' ');

set(handles.text_EFT,'Enable','off');
set(handles.edit_exponent,'Enable','off');
set(handles.pushbutton_calculate_damage,'Enable','off');
set(handles.text_DR,'Enable','off');
set(handles.edit_damage_result,'Enable','off');
set(handles.pushbutton_save,'Enable','off');
set(handles.edit_output_array,'Enable','off');
set(handles.pushbutton_save_table,'Enable','off');

set(handles.pushbutton_miners,'Enable','off');

set(handles.text_valid,'Enable','off');


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_rainflow_OutputFcn(hObject, eventdata, handles) 
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


tic;

ndt=get(handles.listbox_display_table,'Value');

num_eng=get(handles.listbox_numerical_engine,'Value');

k=get(handles.listbox_method,'Value');
 
if(k==1)
  FS=strtrim(get(handles.edit_input_array,'String'));
  THM=evalin('base',FS);   
else
  THM=getappdata(0,'THM');
end

THM=fix_size(THM);

disp(' ref 2 ');
sz=size(THM);

if(sz(2)==1)
    y=THM(:,1);
else    
    y=THM(:,2);
end


YS=get(handles.edit_ylabel,'String');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ndf=get(handles.listbox_display_figures,'Value');

[amp_cycles,amp_mean_cycles,range_cycles_max_min,range_cycles,BIG]=...
                                                 rainflow_numerical_engine(y,YS,ndf,num_eng,THM);   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if(ndt==1)
%
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
                tempStr = sprintf('%8.5g', dat(i,j));
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
%

out1=sprintf('Lower Range \t Upper Range \t Cycles \t Ave Amp \t Max Amp \t Min Mean \t Ave Mean \t Max Mean \t Min Valley \t Max Peak');
disp(out1);

    for i = 1:sz(1)
        tempStr = sprintf('%8.5g \t %8.5g \t %10.1f \t %8.5g \t %8.5g \t %8.5g \t %8.5g \t %8.5g \t %8.5g \t %8.5g ',dat(i,1),dat(i,2),dat(i,3),dat(i,4),dat(i,5),dat(i,6),dat(i,7),dat(i,8),dat(i,9),dat(i,10));                
        disp(tempStr);     
    end


end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setappdata(0,'amp_cycles',amp_cycles); 
setappdata(0,'amp_mean_cycles',amp_mean_cycles); 
setappdata(0,'range_cycles',range_cycles);
setappdata(0,'range_cycles_max_min',range_cycles_max_min);  
setappdata(0,'BIG',BIG); 


set(handles.pushbutton_save,'Enable','on');
set(handles.edit_output_array,'Enable','on');
set(handles.pushbutton_save_table,'Enable','on');


set(handles.text_EFT,'Enable','on');
set(handles.edit_exponent,'Enable','on');
set(handles.pushbutton_calculate_damage,'Enable','on');
set(handles.text_DR,'Enable','on');
set(handles.edit_damage_result,'Enable','on');

set(handles.pushbutton_miners,'Enable','on');
set(handles.text_valid,'Enable','on');



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

%%%%

sz=size(range_cycles_max_min);

if(sz(1)<=100)
    
    Range=range_cycles_max_min(:,1);
    Cycles=range_cycles_max_min(:,2);
    Y1=range_cycles_max_min(:,3);
    Y2=range_cycles_max_min(:,4);
    
    Mean=zeros(sz(1),1);
    
    for i=1:sz(1)
        Mean(i)=mean([ Y1(i) Y2(i)]);
    end
        
    T = table(Range,Cycles,Y1,Y2,Mean)

end
disp(' ');
toc

disp(' '); 
disp(' Calculation complete. ');
disp(' '); 


% --- Executes on button press in pushbutton_results.
function pushbutton_results_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_rainflow);

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

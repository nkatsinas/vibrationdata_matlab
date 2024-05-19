function varargout = vibrationdata_statistics_batch(varargin)
% VIBRATIONDATA_STATISTICS_BATCH MATLAB code for vibrationdata_statistics_batch.fig
%      VIBRATIONDATA_STATISTICS_BATCH, by itself, creates a new VIBRATIONDATA_STATISTICS_BATCH or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_STATISTICS_BATCH returns the handle to a new VIBRATIONDATA_STATISTICS_BATCH or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_STATISTICS_BATCH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_STATISTICS_BATCH.M with the given input arguments.
%
%      VIBRATIONDATA_STATISTICS_BATCH('Property','Value',...) creates a new VIBRATIONDATA_STATISTICS_BATCH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_statistics_batch_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_statistics_batch_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_statistics_batch

% Last Modified by GUIDE v2.5 11-Aug-2016 18:17:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_statistics_batch_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_statistics_batch_OutputFcn, ...
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


% --- Executes just before vibrationdata_statistics_batch is made visible.
function vibrationdata_statistics_batch_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_statistics_batch (see VARARGIN)

% Choose default command line output for vibrationdata_statistics_batch
handles.output = hObject;





% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_statistics_batch wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_statistics_batch_OutputFcn(hObject, eventdata, handles) 
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

disp('  ');
disp(' * * * * * ');
disp('  ');

dat=zeros(kv,7);

for i=1:kv
    
    THM=evalin('base',char(sarray(i,:)));
    output_array=char(sarray(i,:));
    
    t=double(THM(:,1));
    y=double(THM(:,2));
    n=length(y);
    amp=y;

    mu=mean(amp);
    sd=std(amp);
    rms=sqrt(sd^2+mu^2);

    mx=max(amp);
    mi=min(amp);
 
    amax=abs(mx);
    amin=abs(mi);
    if(amax<amin)
        amax=amin;
    end
    crest=amax/sd;
    
    dat(i,:)=[mu sd rms mx mi amax crest];
end
    
   
%
%
for i = 1:kv
    for j=1:8
            if(j==1)
                
                Str = char(sarray(i,:));

                padded_string = sprintf('   %s',Str);
                tempStr=padded_string;
                
            else
                tempStr = sprintf('%15.4g', dat(i,j-1));
                
            end    
            data_s{i,j} = tempStr; 
    end    
end
%

figure(3)
hFig = figure(3);
xwidth=900;
ywidth=500;
set(gcf,'PaperPositionMode','auto')
set(hFig, 'Position', [0 0 xwidth ywidth])
table1 = uitable;
set(table1,'ColumnWidth',{27})

columnname =   {'Name','Mean','Std Dev','RMS',...
       'Max','Min','Max Abs','Crest' };

columnformat = {'char', 'numeric','numeric','numeric','numeric',...
       'numeric','numeric','numeric'};
  
columneditable = [true true true true true true true true ];

%
    table1 = uitable('Units','normalized','Position',...
            [0 0 1 1], 'Data', data_s,... 
            'ColumnName', columnname,...
            'ColumnFormat', columnformat,...
            'ColumnEditable', columneditable,...
            'RowName',[]);  
  
[M,I] = max(dat(:,2));
disp(' Array with highest Std Dev ');
out1=sprintf(' %s  %8.4g',char(sarray(I,:)),M);
disp(out1);        
        
[M,I] = max(dat(:,3));
disp(' ');
disp(' Array with highest RMS ');
out1=sprintf(' %s  %8.4g',char(sarray(I,:)),M);
disp(out1);

[M,I] = max(dat(:,6));
disp(' ');
disp(' Array with highest absolute peak ');
out1=sprintf(' %s  %8.4g',char(sarray(I,:)),M);
disp(out1);
disp(' ');


n=get(handles.listbox_write,'Value');

if(n==1)

    try

      [writefname, writepname] = uiputfile('*','Save data as');
	  writepfname = fullfile(writepname, writefname);
	  fid = fopen(writepfname,'w');        
        
    catch
        warndlg('Unable to open output file');
        return; 
    end
    
    fprintf(fid,'Name, Mean, Std Dev, RMS, Max, Min, Max Abs, Crest \n');
    
    for i=1:kv
        fprintf(fid,'%s, %8.4g, %8.4g, %8.4g, %8.4g, %8.4g, %8.4g, %8.4g  \n',...
            char(sarray(i,:)),dat(i,1),dat(i,2),dat(i,3),dat(i,4),dat(i,5),dat(i,6),dat(i,7));
    end  

    fclose(fid);

end

msgbox(' Output data written to Command Window');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(vibrationdata_statistics_batch);


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

new_data=getappdata(0,'segment');
  
output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, new_data);

h = msgbox('Save Complete') 



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


% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over edit_input_array.
function edit_input_array_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox_write.
function listbox_write_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_write (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_write contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_write


% --- Executes during object creation, after setting all properties.
function listbox_write_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_write (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

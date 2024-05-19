function varargout = vibrationdata_extract_segment_multiple_cursor(varargin)
% VIBRATIONDATA_EXTRACT_SEGMENT_MULTIPLE_CURSOR MATLAB code for vibrationdata_extract_segment_multiple_cursor.fig
%      VIBRATIONDATA_EXTRACT_SEGMENT_MULTIPLE_CURSOR, by itself, creates a new VIBRATIONDATA_EXTRACT_SEGMENT_MULTIPLE_CURSOR or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_EXTRACT_SEGMENT_MULTIPLE_CURSOR returns the handle to a new VIBRATIONDATA_EXTRACT_SEGMENT_MULTIPLE_CURSOR or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_EXTRACT_SEGMENT_MULTIPLE_CURSOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_EXTRACT_SEGMENT_MULTIPLE_CURSOR.M with the given input arguments.
%
%      VIBRATIONDATA_EXTRACT_SEGMENT_MULTIPLE_CURSOR('Property','Value',...) creates a new VIBRATIONDATA_EXTRACT_SEGMENT_MULTIPLE_CURSOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_extract_segment_multiple_cursor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_extract_segment_multiple_cursor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_extract_segment_multiple_cursor

% Last Modified by GUIDE v2.5 30-Apr-2021 17:00:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_extract_segment_multiple_cursor_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_extract_segment_multiple_cursor_OutputFcn, ...
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


% --- Executes just before vibrationdata_extract_segment_multiple_cursor is made visible.
function vibrationdata_extract_segment_multiple_cursor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_extract_segment_multiple_cursor (see VARARGIN)

% Choose default command line output for vibrationdata_extract_segment_multiple_cursor
handles.output = hObject;

set(handles.uipanel_segment_times,'Visible','off');

listbox_plots_Callback(hObject, eventdata, handles);

listbox_num_Callback(hObject, eventdata, handles);



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_extract_segment_multiple_cursor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_extract_segment_multiple_cursor_OutputFcn(hObject, eventdata, handles) 
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


setappdata(0,'fig_num',1);


Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nfont=10;


np=get(handles.listbox_plots,'Value'); 

if(np==1)

    psave=get(handles.listbox_psave,'Value');    
    nfont=str2num(get(handles.edit_font_size,'String'));    

end    

YS_input=get(handles.edit_ylabel_input,'String');


ext=get(handles.edit_extension,'String');

ts=str2num(get(handles.edit_start,'String'));
te=str2num(get(handles.edit_end,'String'));

if(ts>te)
    warndlg('Start Time > End Time');
    return;
end


disp('  ');
disp(' * * * * * ');
disp('  ');


try
    data=get(handles.uitable_data,'Data');
    A=char(data);
    setappdata(0,'data',data);
        
    N=get(handles.listbox_num,'Value');

    k=1;

    for i=1:N
        array_name{i}=A(k,:); k=k+1;
        array_name{i} = strtrim(array_name{i});
    end 
    
    for i=1:N
        leg{i}=A(k,:); k=k+1;
        leg{i} = strtrim(leg{i});
    end 
    
catch
    warndlg('Input Arrays read failed');
    return;
end

 
kv=N;

for i=1:kv
    
    THM=evalin('base',array_name{i});
    
    output_array{i}=strcat(array_name{i},ext);
    
    t=double(THM(:,1));
    y=double(THM(:,2));

%
    [~,n1]=min(abs(ts-THM(:,1)));
    [~,n2]=min(abs(te-THM(:,1)));
%
    if(n1>n2)
        n2=n1;
    end
%
    x=y(n1:n2)';
    TT=t(n1:n2)';
%

    x=fix_size(x);
    TT=fix_size(TT);

    segment=[TT x];
    
    assignin('base', output_array{i}, segment);
    
    
    out2=sprintf('%s',output_array{i});
    ss{i}=out2;        
    
    if(np==1)
        h2=figure(i);
        plot(TT,x);
        
       
   %     [newStr]=plot_title_fix_alt(leg{i});
        
        newStr=strrep(leg{i},'_',' ');
        
        out1=sprintf('%s Time History Segment ',newStr);
        
        title(out1);        
        xlabel(' Time(sec) ')
        ylabel(YS_input)
        grid on;
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

ss=ss';
length(ss);

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

disp('  ');
disp('  Output Arrays ');
disp('  ');

for i=1:kv
   out1=sprintf(' %s',output_array{i});
   disp(out1);    
end

output_name='extract_array';
    
assignin('base', output_name, ss);

setappdata(0,'output_array',output_array);


disp(' ');
disp('Output array names stored in string array:');
disp(' extract_array');


msgbox('Calculation complete.  See Command Window');



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(vibrationdata_extract_segment_multiple_cursor);


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
    set(handles.text_psd_export,'Visible','on');    
    
    set(handles.text_font_size,'Visible','on');
    set(handles.edit_font_size,'Visible','on');
   
else
    
    set(handles.listbox_psave,'Visible','off');
    set(handles.text_psd_export,'Visible','off');
    
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


% --- Executes on button press in pushbutton_save_model.
function pushbutton_save_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


try
    data=get(handles.uitable_data,'Data'); 
    ExtractMult.data=data;      
catch
end

try
    num=get(handles.listbox_num,'Value'); 
    ExtractMult.num=num;      
catch
end

try
    num=get(handles.listbox_num,'Value'); 
    ExtractMult.num=num;      
catch
end

try
    tend=get(handles.edit_end,'String'); 
    ExtractMult.tend=tend;      
catch
end

try
    tstart=get(handles.edit_start,'String'); 
    ExtractMult.tstart=tstart;      
catch
end

try
    ext=get(handles.edit_extension,'String'); 
    ExtractMult.ext=ext;      
catch
end

try
    ylab=get(handles.edit_ylabel_input,'String'); 
    ExtractMult.ylab=ylab;      
catch
end

try
    font=get(handles.edit_font_size,'String'); 
    ExtractMult.font=font;      
catch
end

try
    plots=get(handles.listbox_plots,'Value'); 
    ExtractMult.plots=plots;      
catch
end

try
    psave=get(handles.listbox_psave,'Value'); 
    ExtractMult.psave=psave;      
catch
end



% % %
 
structnames = fieldnames(ExtractMult, '-full'); % fields in the struct
  
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);

    
    try
 
        save(elk, 'ExtractMult'); 
 
    catch
        warndlg('Save error');
        return;
    end
 
%%% SSS=load(elk)
 
%%%%%%%%%%
%%%%%%%%%%
 
msgbox('Save Complete');


% --- Executes on button press in pushbutton_load.
function pushbutton_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


[filename, pathname] = uigetfile('*.mat', 'Select plot save file');

NAME = [pathname,filename];

struct=load(NAME);
structnames = fieldnames(struct, '-full'); % fields in the struct

k=length(structnames);

for i=1:k
    namevar=strcat('struct.',structnames{i});
    value=eval(namevar);
    assignin('base',structnames{i},value);
end

% struct

try

   ExtractMult=evalin('base','ExtractMult');

catch
   warndlg(' evalin failed ');
   return;
end

%%%%%%%%%%%%


try
    num=ExtractMult.num;      
    set(handles.listbox_num,'Value',num);     
catch
end

listbox_num_Callback(hObject, eventdata, handles);


try
    data=ExtractMult.data;
    set(handles.uitable_data,'Data',data);     
catch
end



try
    tend=ExtractMult.tend;       
    set(handles.edit_end,'String',tend); 
catch
end

try
    tstart=ExtractMult.tstart;    
    set(handles.edit_start,'String',tstart);       
catch
end

try
    ext=ExtractMult.ext;     
    set(handles.edit_extension,'String',ext);      
catch
end

try
    ylab=ExtractMult.ylab;    
    set(handles.edit_ylabel_input,'String',ylab);       
catch
end

try
    font=ExtractMult.font;      
    set(handles.edit_font_size,'String',font);     
catch
end

try
    plots=ExtractMult.plots;    
    set(handles.listbox_plots,'Value',plots);       
catch
end

try
    psave=ExtractMult.psave;     
    set(handles.listbox_psave,'Value',psave);      
catch
end




% --- Executes on selection change in listbox_num.
function listbox_num_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num

cn={'Input Array Name','Legend'};

%%%%
 
Nrows=get(handles.listbox_num,'Value');
Ncolumns=2;
 
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

set(handles.listbox_cursor, 'String', '');

for i=1:Nrows
    string_th{i}=sprintf('%d',i);      
end

set(handles.listbox_cursor,'String',string_th)  




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


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Nrows=get(handles.listbox_num,'Value');
 
Ncolumns=2;
 
for i=1:Nrows
    for j=1:Ncolumns
        data_s{i,j}='';
    end    
end  


set(handles.uitable_data,'Data',data_s);


% --- Executes on button press in pushbutton_delete.
function pushbutton_delete_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Nrows=get(handles.listbox_num,'Value');
 
Ncolumns=2;
 
data_s=get(handles.uitable_data,'Data');

nd=get(handles.listbox_delete,'Value');
 

if(nd<=Nrows)
    
    temp=data_s;
    clear data_s;
    
    
    
    for i=1:(nd-1)
        for j=1:Ncolumns
            try
                data_s{i,j}=temp{i,j};
            catch
            end
            
        end    
    end  
    
    for i=(nd+1):Nrows
        for j=1:Ncolumns
            try
                data_s{i-1,j}=temp{i,j};
            catch
            end
            
        end    
    end      
    
    Nrows=Nrows-1;
    set(handles.listbox_num,'Value',Nrows);    
end
 
set(handles.uitable_data,'Data',data_s);
 
set(handles.listbox_num,'Value',Nrows);



% --- Executes on selection change in listbox_delete.
function listbox_delete_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_delete contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_delete


% --- Executes during object creation, after setting all properties.
function listbox_delete_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_spl_batch.
function pushbutton_spl_batch_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_spl_batch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in pushbutton_read.
function pushbutton_read_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_read (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('  ');
disp(' * * * * * ');
disp('  ');


try
    data=get(handles.uitable_data,'Data');
    A=char(data);
    setappdata(0,'data',data);
        
    N=get(handles.listbox_num,'Value');

    k=1;

    for i=1:N
        array_name{i}=A(k,:); k=k+1;
        array_name{i} = strtrim(array_name{i});
    end 
    
    for i=1:N
        leg{i}=A(k,:); k=k+1;
        leg{i} = strtrim(leg{i});
    end 
    
catch
    warndlg('Input Arrays read failed');
    return;
end
 
ijk=get(handles.listbox_cursor,'Value');

THM=evalin('base',array_name{ijk});
LL=leg{ijk};
% array_name{ijk};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


cmap(1,:)=[0.8 0 0];        % red
cmap(end+1,:)=[0 0 0];          % black
cmap(end+1,:)=[0.6 0.3 0];      % brown
cmap(end+1,:)=[0 0.5 0.5];      % teal
cmap(end+1,:)=[1 0.5 0];        % orange
cmap(end+1,:)=[0.5 0.5 0];      % olive
cmap(end+1,:)=[0.13 0.55 0.13]; % forest green  
cmap(end+1,:)=[0.5 0 0];        % maroon
cmap(end+1,:)=[0.5 0.5 0.5 ];  % grey
cmap(end+1,:)=[1. 0.4 0.4];    % pink-orange
cmap(end+1,:)=[0.5 0.5 1];     % lavender
cmap(end+1,:)=[0.05 0.7 1.];   % light blue
cmap(end+1,:)=[0  0.8 0.4 ];   % green
cmap(end+1,:)=[1 0.84 0];      % gold
cmap(end+1,:)=[0 0.8 0.8];     % turquoise   
cmap(end+1,:)=[0 0 0.8];        % dark blue


try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end

%%% msgbox('Select start and end limits using cursor, one point at a time.  Press space bar after each entry');
%%% waitforbuttonpress;

data=get(handles.uitable_data,'Data');

nsegments=1;
n=ijk;

ts=zeros(nsegments,1);
te=zeros(nsegments,1);

yf=THM(:,2);
yLimitsf=max(abs(yf*1.1));
[yhf]=yaxis_limits_linear(yLimitsf,yf);


ty=[-1000 1000];
nvk=0;

while(1)
    
    nvk=nvk+1;
    
    if(nvk>nsegments)
        break;
    end     
    
    
    h=figure(1);

    plot(THM(:,1),THM(:,2),'Color','b');
    ylim([-yhf,yhf]);
    zoom on;
    ZoomHandle = zoom(h);
    set(ZoomHandle,'Motion','horizontal'); 

    if(nvk>=2)
            hold on;
            for iq=1:nvk-1
                tx=[ts(iq) ts(iq)];
                plot(tx,ty,'--','Color',cmap(iq,:));
                tx=[te(iq) te(iq)];
                plot(tx,ty,'--','Color',cmap(iq,:)); 
            end
            hold off;
    end
    ylim([-yhf,yhf]);

    title('Use Zoom to select segment time limits.  Press spacebar to continue');
    grid on;
    ylim([-yhf,yhf]);
        
    
    if(nvk>=2)
            hold on;
            for iq=1:nvk-1
                tx=[ts(iq) ts(iq)];
                plot(tx,ty,'--','Color',cmap(iq,:));
                tx=[te(iq) te(iq)];
                plot(tx,ty,'--','Color',cmap(iq,:)); 
            end
            hold off;
    end    
    
    grid on;
    xlabel('Time (sec)');
    sy=get(handles.edit_ylabel_input,'String');
    ylabel(sy);      
    zoom on;
    ZoomHandle = zoom(h);
%%    set(ZoomHandle,'Motion','horizontal');        
    
%%%%%%%
    
    iflag=4;
    
    
    k=0;
    while ~k
        try
            k=waitforbuttonpress;
        catch
            break;
        end
        try
            if ~strcmp(get(h,'currentcharacter'),' ')
                k=0;
            end
        catch
        end
    end
    
    xl = xlim;
    
    ts(nvk)=xl(1);
    te(nvk)=xl(2);
    
    jkflag=1;
    
    try
        answer = questdlg('Choice:','Check Segment','Accept','Redo','Exit','Accept');
 
        switch answer
            case 'Accept'
                iflag=0;
                jkflag=0;
            case 'Redo'
                iflag=1;
                jkflag=0;
            case 'Exit'
                iflag=1;
                
        end    
    catch 
    end 
    
    if(jkflag==1)
        break;
    end
     
    if(iflag==1)
        nvk=nvk-1;
    end    
    if(iflag==2)
        break;
    end
    
%    set(handles.uitable_data,'Data',data);
        
end    

if(jkflag==1)
    return;
end

try

    h=figure(100);

    plot(THM(:,1),THM(:,2));

    hold on
    for ijk=1:length(ts)
        tx=[ts(ijk) ts(ijk)];
        plot(tx,ty,'--','Color',cmap(ijk,:));
        tx=[te(ijk) te(ijk)];
        plot(tx,ty,'--','Color',cmap(ijk,:));        
    end    
    hold off

    grid on;
    ylabel(sy);
    xlabel('Time (sec)');
    y=THM(:,2);
    yLimits=max(y);
    [yh]=yaxis_limits_linear(yLimits,y);
    ylim([-yh,yh]);

%%%%%%%

catch
    warndlg(' end plot failed');
    return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

s1=sprintf('%8.4g',ts(1));
s2=sprintf('%8.4g',te(1));

set(handles.edit_start,'String',s1);
set(handles.edit_end,'String',s2);

set(handles.uipanel_segment_times,'Visible','on');


% --- Executes on selection change in listbox_cursor.
function listbox_cursor_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_cursor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_cursor contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_cursor

pushbutton_read_Callback(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_cursor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_cursor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

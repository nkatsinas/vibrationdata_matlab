function varargout = vibrationdata_preprocess_multiple(varargin)
% VIBRATIONDATA_PREPROCESS_MULTIPLE MATLAB code for vibrationdata_preprocess_multiple.fig
%      VIBRATIONDATA_PREPROCESS_MULTIPLE, by itself, creates a new VIBRATIONDATA_PREPROCESS_MULTIPLE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_PREPROCESS_MULTIPLE returns the handle to a new VIBRATIONDATA_PREPROCESS_MULTIPLE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_PREPROCESS_MULTIPLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_PREPROCESS_MULTIPLE.M with the given input arguments.
%
%      VIBRATIONDATA_PREPROCESS_MULTIPLE('Property','Value',...) creates a new VIBRATIONDATA_PREPROCESS_MULTIPLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_preprocess_multiple_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_preprocess_multiple_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_preprocess_multiple

% Last Modified by GUIDE v2.5 22-May-2020 11:37:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_preprocess_multiple_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_preprocess_multiple_OutputFcn, ...
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


% --- Executes just before vibrationdata_preprocess_multiple is made visible.
function vibrationdata_preprocess_multiple_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_preprocess_multiple (see VARARGIN)

% Choose default command line output for vibrationdata_preprocess_multiple
handles.output = hObject;

listbox_plots_Callback(hObject, eventdata, handles);

listbox_num_Callback(hObject, eventdata, handles);
listbox_steps_Callback(hObject, eventdata, handles);
uitable_steps_CellEditCallback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_preprocess_multiple wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_preprocess_multiple_OutputFcn(hObject, eventdata, handles) 
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
  

YS_input=get(handles.edit_ylabel_input,'String');


ext=get(handles.edit_extension,'String');


disp('  ');
disp(' * * * * * ');
disp('  ');


try
    data=get(handles.uitable_data,'Data');
    A=char(data);
    setappdata(0,'data',data);
        
    N=get(handles.listbox_num,'Value');
    Narrays=N;

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

%%%%%%%%%%%%%

try
    data=get(handles.uitable_steps,'Data');
    A=char(data);
        
    N=get(handles.listbox_steps,'Value');
    num_steps=N;
    
    ts=zeros(N,1);
    te=zeros(N,1);
    sr=zeros(N,1);
    freq=zeros(N,1);
    scale=zeros(N,1);
    
    k=1;

    for i=1:N
        a=strtrim(A(k,:)); k=k+1;
        step{i}=a;    
    end     
    
catch
    warndlg('Read operation failed');
    return;
end
    
try
    for i=1:N
        a=strtrim(A(k,:)); k=k+1;
        try
            ts(i)=str2double(a);
        catch
        end
    end 
    
catch
    warndlg('Read start time failed');
    return; 
end
try
    for i=1:N
        a=strtrim(A(k,:)); k=k+1;
        try
            te(i)=str2double(a);
        catch
        end
    end 
catch
    warndlg('Read end time failed');
    return;     
end
try
    for i=1:N
        a=strtrim(A(k,:)); k=k+1;
        try
            freq(i)=str2double(a);
        catch
        end
    end     
catch
    warndlg('Read filter frequency failed');
    return;     
end    
try
    for i=1:N
        a=strtrim(A(k,:)); k=k+1;
        try
            sr(i)=str2double(a);
        catch
        end
    end 
catch
    warndlg('Read sr failed');
    return;     
end 
try
    for i=1:N
        a=strtrim(A(k,:)); k=k+1;
        try
            scale(i)=str2double(a);
        catch
        end
    end 
catch
    warndlg('Read scale failed');
    return;     
end     

 
%%%%%%%%%%%%%

kv=Narrays;

for i=1:kv
    
    THM=evalin('base',array_name{i});    
    output_array{i}=strcat(array_name{i},ext);
   
    
    t=double(THM(:,1));
    y=double(THM(:,2));
    
    for j=1:num_steps
        
        ca=step{j};
   
        if(contains(ca,'Extract Segment'))
            [~,n1]=min(abs(ts(j)-t));
            [~,n2]=min(abs(te(j)-t));
            
            if(n1>n2)
                n2=n1;
            end
%
            y=y(n1:n2);
            t=t(n1:n2);
 
            t=fix_size(t);
            y=fix_size(y);            
        end
        if(contains(ca,'Bessel High'))
            n=length(t);
            dur=t(end)-t(1);
            dt=dur/(n-1);
            y=fix_size(y);
            [yy]=bessel_filter_core(freq(j),dt,y);
            yy=fix_size(yy);
            y=y-yy;
        end        
        if(contains(ca,'Bessel Low'))
            n=length(t);
            dur=t(end)-t(1);
            dt=dur/(n-1);
            [y]=bessel_filter_core(freq(j),dt,y); 
        end
        if(contains(ca,'Spline'))
            n=length(t);
            dt=1/sr(j);
            np=round((t(n)-t(1))/dt);
            np=np+1;
            xx=linspace(t(1),t(n),np); 
            yy = spline(t,y,xx);
            t=xx;
            y=yy;
        end
        if(contains(ca,'Time Scale'))        
            t=t*scale(j);
        end
        if(contains(ca,'Mean'))
            [~,n1]=min(abs(ts(j)-t));
            [~,n2]=min(abs(te(j)-t));
            
            if(n1>n2)
                n2=n1;
            end
%
            y=y-mean(y(n1:n2));

        end       
    end
    
    t=fix_size(t);
    y=fix_size(y);

    segment=[t y];
    
    assignin('base', output_array{i}, segment);        
           
%
        h2=figure(i);
        plot(t,y);
        
   %     [newStr]=plot_title_fix_alt(leg{i});
        
        newStr=strrep(leg{i},'_',' ');
        
        out1=sprintf('%s Time History',newStr);
        
        title(out1);        
        xlabel(' Time(sec) ')
        ylabel(YS_input)
        grid on;
        set(gca,'Fontsize',nfont);
        set(h2, 'Position', [20 20 550 450]);          


end

disp('  ');
disp('  Output Arrays ');
disp('  ');

for i=1:kv
   out1=sprintf(' %s',output_array{i});
   disp(out1);    
end


msgbox('Calculation complete.  See Command Window');



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(vibrationdata_preprocess_multiple);


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
    steps=get(handles.uitable_steps,'Data'); 
    ExtractMult.steps=steps;      
catch
end

try
    steps_num=get(handles.listbox_steps,'Value'); 
    ExtractMult.steps_num=steps_num;      
catch
end


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


try
    steps=ExtractMult.steps;       
    set(handles.uitable_steps,'Data',steps); 
catch
end

try
    steps_num=ExtractMult.steps_num;      
    set(handles.listbox_steps,'Value',steps_num); 
catch
end

listbox_steps_Callback(hObject, eventdata, handles);



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

output_array=getappdata(0,'output_array');


try
    num=get(handles.listbox_num,'value');
    SPLbatch.num=num;       
catch
end


try
    for i=1:num
        output_array{i};
        data{i,1}=output_array{i};
        sss=strrep(output_array{i},'_th',' ');  
        data{i,2}=sss;   
    end
    SPLbatch.data=data;       
catch
    warndlg('SPLbatch.data   failed');
    return;
end

SPLbatch.data
SPLbatch.num

save SPLbatch_ext.mat SPLbatch

disp(' ');
disp('Array saved as:  SPLbatch_ext.mat ');
disp(' ');


% --- Executes on selection change in listbox_steps.
function listbox_steps_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_steps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_steps contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_steps

%%%%
 
Nrows=get(handles.listbox_steps,'Value');
Ncolumns=6;
 
A=get(handles.uitable_steps,'Data');
 
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
 
set(handles.uitable_steps,'Data',data_s);


% --- Executes during object creation, after setting all properties.
function listbox_steps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_steps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when entered data in editable cell(s) in uitable_steps.
function uitable_steps_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable_steps (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)

A=get(handles.uitable_steps,'Data');

Ncolumns=6;
Nrows=get(handles.listbox_steps,'Value');

disp(' ref 1');
Nrows

k=1;
for i=1:Nrows
    channela{i}=A{k}; k=k+1;
end
for i=1:Nrows
    channelb{i}=A{k}; k=k+1;
end
for i=1:Nrows
    channelc{i}=A{k}; k=k+1;
end
for i=1:Nrows
    channeld{i}=A{k}; k=k+1;
end
for i=1:Nrows
    channele{i}=A{k}; k=k+1;
end
for i=1:Nrows
    channelf{i}=A{k}; k=k+1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:Nrows
    for j=1:Ncolumns
        data_s{i,j}=A{i,j};
    end
end

for i=1:Nrows
    ca=channela{i};
    cb=channelb{i};
    cc=channelc{i};
    cd=channeld{i};
    ce=channele{i};
    cf=channelf{i};
    
    if(contains(ca,'Extract Segment') || contains(ca,'Mean'))
            data_s{i,4}='n/a';
            data_s{i,5}='n/a';
            data_s{i,6}='n/a';            
            
            if(contains(cb,'n/a'))
                data_s{i,2}='';
            end
            if(contains(cc,'n/a'))
                data_s{i,3}='';
            end
    end  
    if(contains(ca,'Bessel'))
            data_s{i,2}='n/a';
            data_s{i,3}='n/a';
            data_s{i,5}='n/a';            
            data_s{i,6}='n/a';  
             
            if(contains(cd,'n/a'))
                data_s{i,4}='';
            end
    end  
    if(contains(ca,'Spline'))
            data_s{i,2}='n/a';
            data_s{i,3}='n/a';
            data_s{i,4}='n/a';            
            data_s{i,6}='n/a';  
             
            if(contains(ce,'n/a'))
                data_s{i,5}='';
            end
    end      
    if(contains(ca,'Time Scale'))
            data_s{i,2}='n/a';
            data_s{i,3}='n/a';
            data_s{i,4}='n/a';            
            data_s{i,5}='n/a';  
             
            if(contains(cf,'n/a'))
                data_s{i,6}='';
            end
    end          
    
    
end


set(handles.uitable_steps,'Data',data_s);


% --- Executes when selected cell(s) is changed in uitable_steps.
function uitable_steps_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to uitable_steps (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)

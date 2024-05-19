function varargout = vibrationdata_envelope_fds_alt(varargin)
% VIBRATIONDATA_ENVELOPE_FDS_ALT MATLAB code for vibrationdata_envelope_fds_alt.fig
%      VIBRATIONDATA_ENVELOPE_FDS_ALT, by itself, creates a new VIBRATIONDATA_ENVELOPE_FDS_ALT or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_ENVELOPE_FDS_ALT returns the handle to a new VIBRATIONDATA_ENVELOPE_FDS_ALT or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_ENVELOPE_FDS_ALT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_ENVELOPE_FDS_ALT.M with the given input arguments.
%
%      VIBRATIONDATA_ENVELOPE_FDS_ALT('Property','Value',...) creates a new VIBRATIONDATA_ENVELOPE_FDS_ALT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_envelope_fds_alt_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_envelope_fds_alt_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_envelope_fds_alt

% Last Modified by GUIDE v2.5 17-Dec-2019 12:48:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_envelope_fds_alt_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_envelope_fds_alt_OutputFcn, ...
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


% --- Executes just before vibrationdata_envelope_fds_alt is made visible.
function vibrationdata_envelope_fds_alt_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_envelope_fds_alt (see VARARGIN)

% Choose default command line output for vibrationdata_envelope_fds_alt
handles.output = hObject;

set(handles.listbox_octave,'Value',4);

listbox_input_type_Callback(hObject, eventdata, handles);
listbox_goal_Callback(hObject, eventdata, handles);

%%%%%%%%%


set(handles.listbox_num,'Value',4);
Nrows=get(handles.listbox_num,'Value');
Ncolumns=3;
 
A=get(handles.uitable_data,'Data');
 
sz=size(A);
Arows=sz(1);
 
for i=1:Nrows
    for j=1:Ncolumns
        data_s{i,j}='';
    end    
end

data_s{1,2}='10';
data_s{2,2}='10';
data_s{3,2}='30';
data_s{4,2}='30';
 
data_s{1,3}='4';
data_s{2,3}='8';
data_s{3,3}='4';
data_s{4,3}='8';

 
set(handles.uitable_data,'Data',data_s);



% set(handles.listbox_num_eng,'Value',2);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_envelope_fds_alt wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_envelope_fds_alt_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_envelope_fds_alt);


function get_table(hObject, eventdata, handles)
%

   jflag=0;
   setappdata(0,'jflag',jflag);

   AA=get(handles.uitable_data,'Data');
   
   A=char(AA);

    N=get(handles.listbox_num,'Value');

    Q=zeros(N,1);
    bex=zeros(N,1);

    k=1;

    for i=1:N
        FDS_name{i}=A(k,:); k=k+1;
        FDS_name{i} = strtrim(FDS_name{i});
    end

    for i=1:N
        Q(i)=str2double(strtrim(A(k,:))); k=k+1;
    end

    for i=1:N
        bex(i)=str2double(strtrim(A(k,:))); k=k+1;
    end
    
    for i=1:N
        data_s{i,1}=FDS_name{i};
        data_s{i,2}=sprintf('%g',Q(i));
        data_s{i,3}=sprintf('%g',bex(i));      
    end
    
    set(handles.uitable_data,'Data',data_s);

% fds_ref
% fds_ref=zeros(n_dam,n_bex,n_ref);

num=N;

for i=1:num

    try
        FS=FDS_name{i};
        aq=evalin('base',FS);  
    catch
        out1=sprintf('FDS array not found: %d %s',i,FS);
        warndlg(out1);
        jflag=1;
        setappdata(0,'jflag',jflag);        
        return; 
    end
    
    if(isempty(aq))
        warndlg('FDS array is empty');
        jflag=1;
        setappdata(0,'jflag',jflag);       
        return;
    end
    
    if(i==1)
        fn=aq(:,1);
        n_ref=length(fn);
        fds_ref=zeros(n_ref,num);
    end
    
    if(length(aq(:,2))~=n_ref)
        warndlg('FDS length error');
        return;
    end
    
    try
       for k=1:n_ref
            fds_ref(k,i)=aq(k,2);
       end
    catch
        warndlg('FDS array error');
        jflag=1;
        setappdata(0,'jflag',jflag);        
        return;         
    end
    
end   

setappdata(0,'fn',fn);
setappdata(0,'N',N);
setappdata(0,'A',A);
setappdata(0,'AA',AA);
setappdata(0,'Q',Q);
setappdata(0,'bex',bex);
setappdata(0,'FDS_name',FDS_name);
setappdata(0,'n_ref',n_ref);    
setappdata(0,'fds_ref',fds_ref);



% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end

%%%

dawnrochel@yahoo.com 

function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
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

n=get(handles.listbox_method,'Value');


set(handles.edit_input_array,'String',' ');

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');

if(n==1)
   set(handles.edit_input_array,'enable','on') 
else
   set(handles.edit_input_array,'enable','off')
   set(handles.text_input_array_name,'Visible','off');
   set(handles.edit_input_array,'Visible','off');
   
   [filename, pathname] = uigetfile('*.*');
   filename = fullfile(pathname, filename);

   [THM]=read_ascii_or_csv(filename);
   setappdata(0,'THM',THM);
   
   msgbox('Input data read complete');

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



function edit_fmin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmin as text
%        str2double(get(hObject,'String')) returns contents of edit_fmin as a double


% --- Executes during object creation, after setting all properties.
function edit_fmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmax as text
%        str2double(get(hObject,'String')) returns contents of edit_fmax as a double


% --- Executes during object creation, after setting all properties.
function edit_fmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in listbox_input_type.
function listbox_input_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_input_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_input_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_input_type

% n=get(handles.listbox_input_type,'Value');

% n=1;

% if(n==1)
%   set(handles.uipanel_numerical_engine,'Visible','on'); 
% else
%   set(handles.uipanel_numerical_engine,'Visible','off'); 
% end


% --- Executes during object creation, after setting all properties.
function listbox_input_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_input_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





function edit_T_out_Callback(hObject, eventdata, handles)
% hObject    handle to edit_T_out (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_T_out as text
%        str2double(get(hObject,'String')) returns contents of edit_T_out as a double


% --- Executes during object creation, after setting all properties.
function edit_T_out_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_T_out (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_ndc.
function listbox_ndc_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_ndc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_ndc contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_ndc

% n=get(handles.listbox_ndc,'Value');

n=1;

set(handles.text_Q2,'Visible','off'); 
set(handles.edit_Q2,'Visible','off');  
set(handles.text_Q3,'Visible','off'); 
set(handles.edit_Q3,'Visible','off');    

if(n>=2)
   set(handles.text_Q2,'Visible','on'); 
   set(handles.edit_Q2,'Visible','on');     
end
if(n>=3)
   set(handles.text_Q3,'Visible','on'); 
   set(handles.edit_Q3,'Visible','on');     
end


% --- Executes during object creation, after setting all properties.
function listbox_ndc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_ndc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_nfec.
function listbox_nfec_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_nfec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_nfec contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_nfec

% n=get(handles.listbox_nfec,'Value');

n=1;

if(n==1)
   set(handles.text_b2,'Visible','off'); 
   set(handles.edit_b2,'Visible','off');    
else
   set(handles.text_b2,'Visible','on'); 
   set(handles.edit_b2,'Visible','on');     
end



% --- Executes during object creation, after setting all properties.
function listbox_nfec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_nfec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Q1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q1 as text
%        str2double(get(hObject,'String')) returns contents of edit_Q1 as a double


% --- Executes during object creation, after setting all properties.
function edit_Q1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Q2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q2 as text
%        str2double(get(hObject,'String')) returns contents of edit_Q2 as a double


% --- Executes during object creation, after setting all properties.
function edit_Q2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_b1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_b1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_b1 as text
%        str2double(get(hObject,'String')) returns contents of edit_b1 as a double


% --- Executes during object creation, after setting all properties.
function edit_b1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_b1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_b2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_b2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_b2 as text
%        str2double(get(hObject,'String')) returns contents of edit_b2 as a double


% --- Executes during object creation, after setting all properties.
function edit_b2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_b2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ntrials_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ntrials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ntrials as text
%        str2double(get(hObject,'String')) returns contents of edit_ntrials as a double


% --- Executes during object creation, after setting all properties.
function edit_ntrials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ntrials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_nbreak.
function listbox_nbreak_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_nbreak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_nbreak contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_nbreak


% --- Executes during object creation, after setting all properties.
function listbox_nbreak_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_nbreak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_num_eng.
function listbox_num_eng_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num_eng (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num_eng contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num_eng


% --- Executes during object creation, after setting all properties.
function listbox_num_eng_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_num_eng (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on selection change in listbox_metric.
function listbox_metric_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_metric (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_metric contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_metric


% --- Executes during object creation, after setting all properties.
function listbox_metric_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_metric (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function uipanel1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in listbox_save.
function listbox_save_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_save contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_save




% --- Executes during object creation, after setting all properties.
function listbox_save_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dscale_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dscale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dscale as text
%        str2double(get(hObject,'String')) returns contents of edit_dscale as a double


% --- Executes during object creation, after setting all properties.
function edit_dscale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dscale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Q3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q3 as text
%        str2double(get(hObject,'String')) returns contents of edit_Q3 as a double


% --- Executes during object creation, after setting all properties.
function edit_Q3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_goal.
function listbox_goal_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_goal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_goal contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_goal

n=get(handles.listbox_metric,'Value');


if(n<=2)
    string_th{1}=sprintf('acceleration');
    string_th{2}=sprintf('acceleration & velocity');
    string_th{3}=sprintf('acceleration, velocity, displacement');
    string_th{4}=sprintf('displacement');
    string_th{5}=sprintf('velocity & displacement');
else
    string_th{1}=sprintf('pressure');    
    set(handles.listbox_goal,'Value',1); 
end

set(handles.listbox_goal,'String',string_th);  

% --- Executes during object creation, after setting all properties.
function listbox_goal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_goal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_num.
function listbox_num_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num



Nrows=get(handles.listbox_num,'Value');
Ncolumns=3;
 
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
 
set(handles.uitable_data,'Data',data_s);



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


% --- Executes on button press in pushbutton_save_model.
function pushbutton_save_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    get_table(hObject, eventdata, handles);
catch
    warndlg('get_table error');
    return;
end
    
try
    listbox_num=get(handles.listbox_num,'Value');
    FDSEnvAlt.listbox_num=listbox_num;
    num=listbox_num;
catch
end

try
    listbox_unit=get(handles.listbox_unit,'Value');
    FDSEnvAlt.listbox_unit=listbox_unit;
catch
end

try
    listbox_metric=get(handles.listbox_metric,'Value');
    FDSEnvAlt.listbox_metric=listbox_metric;
catch
end

try
    listbox_nbreak=get(handles.listbox_nbreak,'Value');
    FDSEnvAlt.listbox_nbreak=listbox_nbreak;
catch
end

try
    listbox_goal=get(handles.listbox_goal,'Value');
    FDSEnvAlt.listbox_goal=listbox_goal;
catch
end

try
    T=get(handles.edit_T_out,'String');
    FDSEnvAlt.T=T;
catch
end

try
    ntrials=get(handles.edit_ntrials,'String');
    FDSEnvAlt.ntrials=ntrials;
catch
end

try
    output_array=get(handles.edit_output_array,'String');
    FDSEnvAlt.output_array=output_array;    
catch
end

get_table(hObject, eventdata, handles)

jflag=getappdata(0,'jflag');
if(jflag==1)
    return;
end
 

fn=getappdata(0,'fn');
N=getappdata(0,'N');
A=getappdata(0,'A');
AA=getappdata(0,'AA');
Q=getappdata(0,'Q');
bex=getappdata(0,'bex');
FDS_name=getappdata(0,'FDS_name');
n_ref=getappdata(0,'n_ref');    
fds_ref=getappdata(0,'fds_ref');


try
    FDSEnvAlt.fn=fn;
catch
end
try
    FDSEnvAlt.N=N;
catch
end
try
    FDSEnvAlt.A=A;
catch
end
try
    FDSEnvAlt.AA=AA;
catch
end
try
    FDSEnvAlt.Q=Q;
catch
end
try
    FDSEnvAlt.bex=bex;
catch
end
try
    FDSEnvAlt.FDS_name=FDS_name;
catch
end
try
    FDSEnvAlt.n_ref=n_ref;
catch
end
try
    FDSEnvAlt.fds_ref=fds_ref;
catch
end


try
    array_name=getappdata(0,'FDS_name');
    
    if(num>=1)
        THM1=evalin('base',array_name{1});
        FDSEnvAlt.THM1=THM1;
        FDSEnvAlt.FS1=array_name{1};
    end
    if(num>=2)
        THM2=evalin('base',array_name{2});
        FDSEnvAlt.THM2=THM2;
        FDSEnvAlt.FS2=array_name{2};        
    end
    if(num>=3)
        THM3=evalin('base',array_name{3});
        FDSEnvAlt.THM3=THM3;
        FDSEnvAlt.FS3=array_name{3};           
    end  
    if(num>=4)
        THM4=evalin('base',array_name{4});
        FDSEnvAlt.THM4=THM4;
        FDSEnvAlt.FS4=array_name{4};
    end
    if(num>=5)
        THM5=evalin('base',array_name{5});
        FDSEnvAlt.THM5=THM5;
        FDSEnvAlt.FS5=array_name{5};        
    end
    if(num>=6)
        THM6=evalin('base',array_name{6});
        FDSEnvAlt.THM6=THM6;
        FDSEnvAlt.FS6=array_name{6};           
    end       
catch
    warndlg('Save error');
    return;
end 


% % %
 
structnames = fieldnames(FDSEnvAlt, '-full'); % fields in the struct
  
% % %
 
 %%%  [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
%%    elk=sprintf('%s%s',writepname,writefname);

    
 %%   try
 
 %%       save(elk, 'FDSEnvAlt'); 
 
%%    catch
 %%       warndlg('Save error');
 %%       return;
 %%   end
 
%%% SSS=load(elk)
 
%%%%%%%%%%
%%%%%%%%%%
 


%%

try
   name=get(handles.edit_save_name,'String');
   FDSEnvAlt.name=name;   
catch
   warndlg('Enter model output name');
   return;
end

if(isempty(name))
   warndlg('Enter model output name');
   return;    
end

    name=strrep(name,'.mat','');
    name=strrep(name,'_model',''); 
    name2=sprintf('%s_model',name);
    name=sprintf('%s_model.mat',name);


    try
        save(name, 'FDSEnvAlt'); 
    catch
        warndlg('Save error');
        return;
    end
 
%%%@@@@@

    disp('**ref b1**');
    
  
    
    try
        filename = 'vibrationdata_envelope_fds_alt_load_list.txt';
        THM=importdata(filename);
        sz=size(THM);
        nrows=sz(1);
        
 %       out1=sprintf('nrows=%d',nrows);
 %       disp(out1);
                
 %        THM
        

    catch
         THM=[];
         disp('no read 1');       
    end
    
    try
        fileID = fopen('backup_vibrationdata_envelope_fds_alt_load_list.txt','w');
        for row = 1:nrows
            fprintf(fileID,'%s\n',char(THM{row,:}));
        end
        fclose(fileID);
        
     
        fileID = fopen('backup2_vibrationdata_envelope_fds_alt_load_list.txt','w');
        for row = 1:nrows
            fprintf(fileID,'%s\n',THM{row,:});
        end
        fclose(fileID);       
    catch
        disp(' backup failed');
    end
    
    disp('**ref b2**');
    
   try 
        [THM,nrows]=THM_save(THM,name2);
   catch
   end
   
   try
        fileID = fopen(filename,'w');

        for row = 1:nrows
            fprintf(fileID,'%s\n',char(THM{row,:}));
        end
        fclose(fileID);
   catch
   end
%%%@@@@@
    
    
out1=sprintf('Save Complete: %s',name);
msgbox(out1);

%%%%%%%%%%%%%%%%%%%%




% --- Executes on button press in pushbutton_load_model.
function pushbutton_load_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    [filename, pathname] = uigetfile('*.mat');

    setappdata(0,'filename',filename);
    setappdata(0,'pathname',pathname);
 
    load_core(hObject, eventdata, handles)
catch
end


function load_core(hObject, eventdata, handles)

disp('*** ref 1 ***');

filename=strtrim(getappdata(0,'filename'));
% pathname=getappdata(0,'pathname')

try
%    NAME = [pathname,filename];
    NAME=filename;
    struct=load(NAME);
catch    
    NAME
    warndlg('load failed');
    return;
end

try
structnames = fieldnames(struct, '-full'); % fields in the struct

k=length(structnames);

for i=1:k
    namevar=strcat('struct.',structnames{i});
    value=eval(namevar);
    assignin('base',structnames{i},value);
end

% struct

try

   FDSEnvAlt=evalin('base','FDSEnvAlt');

catch
   warndlg(' evalin failed ');
   return;
end

% FDSEnvAlt

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    listbox_num=FDSEnvAlt.listbox_num;    
    set(handles.listbox_num,'Value',listbox_num);
    listbox_num_Callback(hObject, eventdata, handles);
catch
end

try
    listbox_unit=FDSEnvAlt.listbox_unit;    
    set(handles.listbox_unit,'Value',listbox_unit);
catch
end

try
    listbox_metric=FDSEnvAlt.listbox_metric;     
    set(handles.listbox_metric,'Value',listbox_metric);    
catch
end

try
    listbox_nbreak=FDSEnvAlt.listbox_nbreak;    
    set(handles.listbox_nbreak,'Value',listbox_nbreak);
catch
end

try
    listbox_goal=FDSEnvAlt.listbox_goal;    
    set(handles.listbox_goal,'Value',listbox_goal);
catch
end


try
    output_array=FDSEnvAlt.output_array;      
    set(handles.edit_output_array,'String',output_array);  
catch
end

try
    T=FDSEnvAlt.T;    
    set(handles.edit_T_out,'String',T);
catch
end

try
    ntrials=FDSEnvAlt.ntrials;    
    set(handles.edit_ntrials,'String',ntrials);
catch
end

cn={'FDS Array Name','Q','b'};
AA=FDSEnvAlt.AA;

try
    AA=FDSEnvAlt.AA;    
    set(handles.uitable_data,'Data',AA,'ColumnName',cn);
catch
    warndlg('no AA data');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FDS_name=FDSEnvAlt.FDS_name;  
catch
end

try
    fds_ref=FDSEnvAlt.fds_ref;   
catch
end


try
    
    for i=1:num
    
        try 
            assignin('base', FDS_name{i},[fn  fds_ref(:,i)]); 
        catch
        end      
   
    end
    
catch    
end


try
   name=FDSEnvAlt.name;    
   set(handles.edit_save_name,'String',name);      
catch
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS1=strtrim(FDSEnvAlt.FS1);
 
    iflag=0;
    
    try
        temp=evalin('base',FS1);
        ss=sprintf('Replace %s with Previously Saved Array',FS1);
        answer = questdlg(ss,'Array Overwrite','Yes','No','No');
 
        switch answer
            case 'Yes'
                iflag=0;
            case 'No'
                iflag=1;
        end    
    catch 
    end
    
    if(iflag==0)
        try
            THM1=FDSEnvAlt.THM1;
            assignin('base',FS1,THM1); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS2=strtrim(FDSEnvAlt.FS2);
 
    iflag=0;
    
    try
        temp=evalin('base',FS2);
        ss=sprintf('Replace %s with Previously Saved Array',FS2);
        answer = questdlg(ss,'Array Overwrite','Yes','No','No');
 
        switch answer
            case 'Yes'
                iflag=0;
            case 'No'
                iflag=1;
        end    
    catch 
    end
    
    if(iflag==0)
        try
            THM2=FDSEnvAlt.THM2;
            assignin('base',FS2,THM2); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


try
    FS3=strtrim(FDSEnvAlt.FS3);
 
    iflag=0;
    
    try
        temp=evalin('base',FS3);
        ss=sprintf('Replace %s with Previously Saved Array',FS3);
        answer = questdlg(ss,'Array Overwrite','Yes','No','No');
 
        switch answer
            case 'Yes'
                iflag=0;
            case 'No'
                iflag=1;
        end    
    catch 
    end
    
    if(iflag==0)
        try
            THM3=FDSEnvAlt.THM3;
            assignin('base',FS3,THM3); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS4=strtrim(FDSEnvAlt.FS4);
 
    iflag=0;
    
    try
        temp=evalin('base',FS4);
        ss=sprintf('Replace %s with Previously Saved Array',FS4);
        answer = questdlg(ss,'Array Overwrite','Yes','No','No');
 
        switch answer
            case 'Yes'
                iflag=0;
            case 'No'
                iflag=1;
        end    
    catch 
    end
    
    if(iflag==0)
        try
            THM4=FDSEnvAlt.THM4;
            assignin('base',FS4,THM4); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS5=strtrim(FDSEnvAlt.FS5);
 
    iflag=0;
    
    try
        temp=evalin('base',FS5);
        ss=sprintf('Replace %s with Previously Saved Array',FS5);
        answer = questdlg(ss,'Array Overwrite','Yes','No','No');
 
        switch answer
            case 'Yes'
                iflag=0;
            case 'No'
                iflag=1;
        end    
    catch 
    end
    
    if(iflag==0)
        try
            THM5=FDSEnvAlt.THM5;
            assignin('base',FS5,THM5); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS6=strtrim(FDSEnvAlt.FS6);
 
    iflag=0;
    
    try
        temp=evalin('base',FS6);
        ss=sprintf('Replace %s with Previously Saved Array',FS6);
        answer = questdlg(ss,'Array Overwrite','Yes','No','No');
 
        switch answer
            case 'Yes'
                iflag=0;
            case 'No'
                iflag=1;
        end    
    catch 
    end
    
    if(iflag==0)
        try
            THM6=FDSEnvAlt.THM6;
            assignin('base',FS6,THM6); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

try
    
    AA=get(handles.uitable_data,'Data');
   
    A=char(AA);

    N=get(handles.listbox_num,'Value');

    Q=zeros(N,1);
    bex=zeros(N,1);

    k=1;

    for i=1:N
        FDS_name{i}=A(k,:); k=k+1;
        FDS_name{i} = strtrim(FDS_name{i});
    end

    for i=1:N
        Q(i)=str2double(strtrim(A(k,:))); k=k+1;
    end

    for i=1:N
        bex(i)=str2double(strtrim(A(k,:))); k=k+1;
    end
    
    for i=1:N
        data_s{i,1}=FDS_name{i};
        data_s{i,2}=sprintf('%g',Q(i));
        data_s{i,3}=sprintf('%g',bex(i));      
    end
    
    set(handles.uitable_data,'Data',data_s);
catch
end


 listbox_goal_Callback(hObject, eventdata, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

catch
    warndlg('Load Failed');
end    


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Nrows=get(handles.listbox_num,'Value');
 
Ncolumns=3;
 
for i=1:Nrows
    for j=1:Ncolumns
        data_s{i,j}='';
    end    
end  


set(handles.uitable_data,'Data',data_s);



function edit_save_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_save_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_save_name as text
%        str2double(get(hObject,'String')) returns contents of edit_save_name as a double


% --- Executes during object creation, after setting all properties.
function edit_save_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_save_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit_slope_Callback(hObject, eventdata, handles)
% hObject    handle to edit_slope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_slope as text
%        str2double(get(hObject,'String')) returns contents of edit_slope as a double


% --- Executes during object creation, after setting all properties.
function edit_slope_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_slope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_load_model_list.
function pushbutton_load_model_list_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_model_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

vibrationdata_envelope_fds_alt_load;

uiwait()

uiresume(vibrationdata_envelope_fds_alt_load)

delete(vibrationdata_envelope_fds_alt_load);
    
Lflag=getappdata(0,'Lflag');


if(Lflag==0)
    
    load_core(hObject, eventdata, handles);

    delete(vibrationdata_envelope_fds_alt_load);

else
    delete(vibrationdata_envelope_fds_alt_load);    
end


% --- Executes on selection change in listbox_octave.
function listbox_octave_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_octave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_octave contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_octave


% --- Executes during object creation, after setting all properties.
function listbox_octave_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_octave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

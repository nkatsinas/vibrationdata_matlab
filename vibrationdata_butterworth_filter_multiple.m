function varargout = vibrationdata_butterworth_filter_multiple(varargin)
% VIBRATIONDATA_BUTTERWORTH_FILTER_MULTIPLE MATLAB code for vibrationdata_butterworth_filter_multiple.fig
%      VIBRATIONDATA_BUTTERWORTH_FILTER_MULTIPLE, by itself, creates a new VIBRATIONDATA_BUTTERWORTH_FILTER_MULTIPLE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_BUTTERWORTH_FILTER_MULTIPLE returns the handle to a new VIBRATIONDATA_BUTTERWORTH_FILTER_MULTIPLE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_BUTTERWORTH_FILTER_MULTIPLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_BUTTERWORTH_FILTER_MULTIPLE.M with the given input arguments.
%
%      VIBRATIONDATA_BUTTERWORTH_FILTER_MULTIPLE('Property','Value',...) creates a new VIBRATIONDATA_BUTTERWORTH_FILTER_MULTIPLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_butterworth_filter_multiple_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_butterworth_filter_multiple_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_butterworth_filter_multiple

% Last Modified by GUIDE v2.5 29-May-2019 11:12:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_butterworth_filter_multiple_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_butterworth_filter_multiple_OutputFcn, ...
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


% --- Executes just before vibrationdata_butterworth_filter_multiple is made visible.
function vibrationdata_butterworth_filter_multiple_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_butterworth_filter_multiple (see VARARGIN)

% Choose default command line output for vibrationdata_butterworth_filter_multiple
handles.output = hObject;


listbox_num_Callback(hObject, eventdata, handles);

listbox_plots_Callback(hObject, eventdata, handles);

listbox_ntype_Callback(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_butterworth_filter_multiple wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_butterworth_filter_multiple_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filtered_data=getappdata(0,'filtered_data');
  
output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, filtered_data);

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


function get_table_data(hObject, eventdata, handles)


try
    data=get(handles.uitable_data,'Data');
    A=char(data);
    setappdata(0,'data',data);
    
    
    N=get(handles.listbox_num,'Value');

    k=1;

    for i=1:N
        array_name{i}=A(k,:); k=k+1;
        array_name{i} = strtrim(array_name{i});
        data_s{i,1}=array_name{i};
    end 
    for i=1:N
        leg{i}=A(k,:); k=k+1;
        leg{i}=strrep(leg{i},'_th','');
        leg{i} = strtrim(leg{i});
        data_s{i,2}=leg{i};       
    end     
    
    try
        set(handles.uitable_data,'Data',data_s);
    catch
        warndlg('Put back failed');
    end

catch
    warndlg('Input Arrays read failed');
    return;
end

setappdata(0,'array_name',array_name); 
setappdata(0,'leg',leg); 


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end



disp('  ');
disp(' * * * * * ');
disp('  ');

fig_num=1;

nfont=10;  % leave here


get_table_data(hObject, eventdata, handles);

array_name=getappdata(0,'array_name'); 
leg=getappdata(0,'leg');

num=get(handles.listbox_num,'Value');

kv=num;

np=get(handles.listbox_plots,'Value');
ext=get(handles.edit_extension,'String');

YS=get(handles.edit_ylabel,'String');


ntype=get(handles.listbox_ntype,'Value');

iphase=get(handles.listbox_refiltering,'Value');

iband=get(handles.listbox_ntype,'Value');
    
    
if(iband<=2)
    filter_freq=str2num(get(handles.edit_freq1,'String'));
end
if(iband==3)
    freq1=str2num(get(handles.edit_freq1,'String'));
    freq2=str2num(get(handles.edit_freq2,'String')); 
    filter_freq=sort([freq1; freq2]);
end

if(isempty(filter_freq))
    warndlg('Enter filter frequency');
    return;
end

%%

dat=zeros(kv,3);

xlabel2='Time (sec)';
ylabel1=YS;
ylabel2=YS;


if(np==1)
    psave=get(handles.listbox_psave,'Value');    
    nfont=str2num(get(handles.edit_font_size,'String'));    
end



for i=1:kv
    
    try
            FS=array_name{i};
            THM=evalin('base',FS);  
    catch
            warndlg('Input array not found ');
            return; 
    end    
    
 
    output_array{i}=array_name{i};
    
    y=double(THM(:,2));

    rms_input=sqrt(mean(y)^2+std(y)^2);

    n=length(y);

    dur=THM(n,1)-THM(1,1);

    dt=dur/(n-1);
    

    [y]=VDG_Butterworth_filter_function(y,iband,iphase,dt,filter_freq);
 
    y=fix_size(y);
 
    filtered_data=[THM(:,1) y];
    
 %%   
    
    dat(i,1)=std(y);
    dat(i,2)=sqrt(mean(y)^2+std(y)^2);
    dat(i,3)=max(abs(y));
    
    sss=sprintf('%s%s',output_array{i},ext);
    
    assignin('base', sss, filtered_data);
    
    out2=sprintf('%s',sss);
    ss{i}=out2;
    
    
%%
    if(np==1)
               
%       [newStr]=plot_title_fix_alt(output_array{i});
    
       leg{i}=strrep(leg{i},'_',' ');

       t_string1=sprintf(' %s  Time History',leg{i}); 
    
       fc1=filter_freq;
       
       if(ntype==1)
            t_string2=sprintf(' %s  Butterworth LP Filtered %g Hz',leg{i},fc1); 
       end     
       if(ntype==2)
            t_string2=sprintf(' %s  Butterworth HP Filtered %g Hz',leg{i},fc1);        
       end
       if(ntype==3)
            flow=filter_freq(1);
             fup=filter_freq(2);
            t_string2=sprintf(' %s  Butterworth BP Filtered %g to %g Hz',leg{i},flow,fup);        
       end       
       
      
       data1=THM;
       data2=filtered_data;
       
       [fig_num]=subplots_two_linlin_two_titles_scale_same(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2);
  
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

%%  
end


%
for i = 1:kv
    for j=1:4
            if(j==1)
                
                Str = ss{i};

                padded_string = sprintf('   %s',Str);
                tempStr=padded_string;
                
            else
                tempStr = sprintf('%15.4g', dat(i,j-1));
                
            end    
            data_s{i,j} = tempStr; 
    end    
end
%

%%%

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

disp(' ');
disp(' Output Array Names ');
disp(' ');

for i=1:kv
   out1=sprintf(' %s',ss{i});
   disp(out1);
end

disp(' ');

setappdata(0,'ss',ss);

ss=ss';
length(ss);

output_name='filtered_array';
    
assignin('base', output_name, ss);

disp(' ');
disp('Output array names stored in string array:');
disp(' filtered_array');

msgbox('Calculation complete.  See Command Window');






% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_butterworth_filter_multiple)


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n=get(hObject,'Value');


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


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_pass_type.
function listbox_pass_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_pass_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_pass_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_pass_type

n=get(hObject,'Value');


set(handles.edit_freq2,'Visible','Off');
set(handles.text_Enter_Freq2,'Visible','Off'); 


set(handles.text_Lower,'Visible','Off'); 
set(handles.text_Upper,'Visible','Off'); 


if(n==3)
    set(handles.edit_freq2,'Visible','On');
    set(handles.text_Enter_Freq2,'Visible','On'); 
    
    set(handles.text_Lower,'Visible','On'); 
    set(handles.text_Upper,'Visible','On');   
end

% --- Executes during object creation, after setting all properties.
function listbox_pass_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_pass_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_refiltering.
function listbox_refiltering_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_refiltering (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_refiltering contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_refiltering


% --- Executes during object creation, after setting all properties.
function listbox_refiltering_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_refiltering (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_freq_Callback(hObject, eventdata, handles)
% hObject    handle to edit_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_freq as text
%        str2double(get(hObject,'String')) returns contents of edit_freq as a double


% --- Executes during object creation, after setting all properties.
function edit_freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_freq2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_freq2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_freq2 as text
%        str2double(get(hObject,'String')) returns contents of edit_freq2 as a double


% --- Executes during object creation, after setting all properties.
function edit_freq2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_freq2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_f1_label_Callback(hObject, eventdata, handles)
% hObject    handle to edit_f1_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_f1_label as text
%        str2double(get(hObject,'String')) returns contents of edit_f1_label as a double


% --- Executes during object creation, after setting all properties.
function edit_f1_label_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_f1_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_f2_label_Callback(hObject, eventdata, handles)
% hObject    handle to edit_f2_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_f2_label as text
%        str2double(get(hObject,'String')) returns contents of edit_f2_label as a double


% --- Executes during object creation, after setting all properties.
function edit_f2_label_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_f2_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_results_Callback(hObject, eventdata, handles)
% hObject    handle to edit_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_results as text
%        str2double(get(hObject,'String')) returns contents of edit_results as a double


% --- Executes during object creation, after setting all properties.
function edit_results_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_transfer.
function pushbutton_transfer_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_transfer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


ntype=get(handles.listbox_ntype,'Value');

ire=get(handles.listbox_refiltering,'Value');

%
if(ntype==1) % lowpass
    
    value = get(handles.edit_freq1, 'String');
    
    if isempty(value)
        msgbox('Enter lowpass frequency');
        return;
    else   
        lpf=str2num(value);
        fc=lpf;        
    end    
end
if(ntype==2) % highpass
    
    value=get(handles.edit_freq1,'String');
    
    if isempty(value)
        msgbox('Enter highpass frequency');        
        return;
    else    
        hpf=str2num(value);
        fc=hpf;        
    end      
end
%
if(ntype==3) % bandpass
    value1=get(handles.edit_freq1,'String');
    
    if isempty(value1)
        msgbox('Enter highpass frequency');        
        return;
    else    
        hpf=str2num(value1);
        fc=hpf;        
    end  
%
    value2 = get(handles.edit_freq2, 'String');
    
    if isempty(value2)
        msgbox('Enter lowpass frequency');        
        return;
    else    
        lpf=str2num(value2);
        fc=lpf;        
    end   
end
%
%
L=6;
LL=2*L;

%
%  The following coefficiences are for "Reference Only."
%  They are not used directly in the transfer function calculation.
%
for k=1:LL  
    arg  = (2*k+L-1)*pi/LL;
    sr(k)= cos(arg);
    si(k)= sin(arg);
end
sc=complex(sr,si)';
%
nn=5000;
df=fc/100;
%
H=zeros(nn,1);
fH=zeros(nn,1);
%
for i=1:nn
    ff=i*df;
    s=complex(0,(ff/fc));
%
    if(ntype==2) % highpass
        s=1/s;
    end
%
    H1=s^2-2*cos(7*pi/12)*s+1;
    H2=s^2-2*cos(9*pi/12)*s+1;
    H3=s^2-2*cos(11*pi/12)*s+1;    
    A=H1*H2*H3;
%    
    A=1/A;
    H(i)=A;
    fH(i)=ff;
%
    if(ire==1)  % refiltering 
        H(i)=H(i)*conj(H(i));
    end
%
end
%
if(ntype==3)  % bandpass
    G1=H;
    clear H;
    fc=hpf;
%    
    for i=1:nn 
        ff=i*df;       
        s=complex(0,(ff/fc));
        s=1/s;
%        
        H1=s^2-2*cos(7*pi/12)*s+1;
        H2=s^2-2*cos(9*pi/12)*s+1;
        H3=s^2-2*cos(11*pi/12)*s+1;    
        A=H1*H2*H3;
%    
        A=1/A;
        H(i)=A;
        if(ire==1)  % refiltering 
            H(i)=H(i)*conj(H(i));
        end
        G2(i)=H(i);
        H(i)=G2(i)'*G1(i);     
    end
end    
%
% fH=fH*fc*tpi;
%
%
if(ire==1)
    if(ntype==1)
        out1=sprintf(' Butterworth Lowpass Filter 6th order Refiltering fc=%g Hz ',lpf);
    end
    if(ntype==2)
        out1=sprintf(' Butterworth Highpass Filter 6th order Refiltering fc=%g Hz ',hpf);
    end
    if(ntype==3)
        out1=sprintf(' Butterworth Bandpass Filter 6th order Refiltering %g to %g Hz ',hpf,lpf);
    end
else
    if(ntype==1)
        out1=sprintf(' Butterworth Lowpass Filter 6th order fc=%g Hz ',lpf);
    end
    if(ntype==2)
        out1=sprintf(' Butterworth Highpass Filter 6th order fc=%g Hz ',hpf);
    end
    if(ntype==3)
        out1=sprintf(' Butterworth Bandpass Filter 6th order %g to %g Hz ',hpf,lpf);
    end    
end
%
if(ntype<3)
    xmax=10^(ceil(0.01+log10(fc)));
    xmin=10^(floor(-0.01+log10(fc)));
else
    xmax=10^(ceil(0.01+log10(lpf)));
    xmin=10^(floor(-0.01+log10(hpf)));    
end
%
%
%  Phase
%
figure(3);
subplot(3,1,1);

theta=angle(H)*180/pi;

plot(fH,theta);
ylim([-180,180]);
xlim([ xmin xmax ]);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
                    'YScale','lin','ytick',[-180,-90,0,90,180]);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin')
ylabel(' Phase(deg) ');
title(out1);
grid on;
%
%  Magnitude
%
subplot(3,1,[2 3]);
plot(fH,abs(H));
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');
grid on;
xlabel(' Frequency (Hz) ');
ylabel(' Magnitude ');
ymax=1;
ymin=ymax/100;
ylim([ ymin ymax ]);
xlim([ xmin xmax ]);
%
figure(4);
plot(fH,real(H),fH,imag(H));
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','lin')
ylabel(' Amplitude ');
xlabel(' Frequency (Hz) ');
title(out1);
legend ('real','imaginary');  
grid on;




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


% --- Executes on selection change in listbox_num.
function listbox_num_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num

%%%%

cn={'Time History Array Name','Legend'};

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


% --- Executes on selection change in listbox_ntype.
function listbox_ntype_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_ntype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_ntype contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_ntype


n=get(handles.listbox_ntype,'Value');

if(n<=2)
    set(handles.text_Enter_Freq1,'String','Frequency (Hz)');
    set(handles.text_Enter_Freq2,'Visible','off');
    set(handles.edit_freq2,'Visible','off');
else
    set(handles.text_Enter_Freq1,'String','Lower Freq (Hz)');    
    set(handles.text_Enter_Freq2,'Visible','on');
    set(handles.edit_freq2,'Visible','on');    
end





% --- Executes during object creation, after setting all properties.
function listbox_ntype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_ntype (see GCBO)
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
    num=get(handles.listbox_num,'Value'); 
    ButterworthFilter.num=num;      
catch
end

try
    psave=get(handles.listbox_psave,'Value');  
    ButterworthFilter.psave=psave;      
catch
end

try
    ntype=get(handles.listbox_ntype,'Value'); 
    ButterworthFilter.ntype=ntype;      
catch
end


try
    plots=get(handles.listbox_plots,'Value'); 
    ButterworthFilter.plots=plots;      
catch
end


try
    A=get(handles.uitable_data,'Data'); 
    ButterworthFilter.array_name=A;      
catch
end

%%

try
    fc1=get(handles.edit_freq1,'String'); 
    ButterworthFilter.fc1=fc1;      
catch
end

try
    fc2=get(handles.edit_freq2,'String'); 
    ButterworthFilter.fc2=fc2;      
catch
end

%%

try
    extension=get(handles.edit_extension,'String'); 
    ButterworthFilter.extension=extension;      
catch
end


try
    font_size=get(handles.edit_font_size,'String'); 
    ButterworthFilter.font_size=font_size;      
catch
end

try
    ylabel=get(handles.edit_ylabel,'String'); 
    ButterworthFilter.ylabel=ylabel;      
catch
end



% % %
 
structnames = fieldnames(ButterworthFilter, '-full'); % fields in the struct
  
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);

    try
 
        save(elk, 'ButterworthFilter'); 
 
    catch
        warndlg('Save error');
        return;
    end
 
%%% SSS=load(elk)
 
%%%%%%%%%%
%%%%%%%%%%
 
msgbox('Save Complete');


% --- Executes on button press in pushbutton_load_model.
function pushbutton_load_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_model (see GCBO)
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

   ButterworthFilter=evalin('base','ButterworthFilter');

catch
   warndlg(' evalin failed ');
   return;
end

%%%%%%%%%%%%

try
    num=ButterworthFilter.num;     
    set(handles.listbox_num,'Value',num); 
catch
end

listbox_num_Callback(hObject, eventdata, handles)

try
    num=get(handles.listbox_num,'Value'); 
    ButterworthFilter.num=num;      
catch
end
 
try
    psave=ButterworthFilter.psave;     
    set(handles.listbox_psave,'Value',psave);       
catch
end
 
try
    ntype=ButterworthFilter.ntype;     
    set(handles.listbox_ntype,'Value',ntype);      
catch
end
 
 
try
    plots=ButterworthFilter.plots;     
    set(handles.listbox_plots,'Value',plots);      
catch
end
 
 
try
    A=ButterworthFilter.array_name;     
    set(handles.uitable_data,'Data',A);      
catch
end
 
%%

try  % leave for legacy
    fc=ButterworthFilter.fc;     
    set(handles.edit_freq,'String',fc); 
catch
end

try
    fc1=ButterworthFilter.fc1;    
    set(handles.edit_freq1,'String',fc1);       
catch
end

try
    fc2=ButterworthFilter.fc2;          
    set(handles.edit_freq2,'String',fc2); 
catch
end

%%

 
try
    extension=ButterworthFilter.extension;    
    set(handles.edit_extension,'String',extension);       
catch
end
 
 
try
    font_size=ButterworthFilter.font_size;    
    set(handles.edit_font_size,'String',font_size);       
catch
end
 
try
    ylabel=ButterworthFilter.ylabel;     
    set(handles.edit_ylabel,'String',ylabel);      
catch
end

listbox_ntype_Callback(hObject, eventdata, handles);


% --- Executes on button press in pushbutton_srs_multiple.
function pushbutton_srs_multiple_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_srs_multiple (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    num=get(handles.listbox_num,'Value'); 
    NSreadtemp.num=num;      

    ss=getappdata(0,'ss');
    A=get(handles.uitable_data,'Data');

    ext=get(handles.edit_extension,'string');

    for i=1:num
        A{i,1}=ss{i};
    end
 
    NSreadtemp.A=A;  
    
    save NSread.mat NSreadtemp

    msgbox('Names saved in:  NSreadtemp.mat ');
    
catch
    disp(' save failed')
end


handles.s=vibrationdata_srs_multiple;
set(handles.s,'Visible','on');


% --- Executes during object creation, after setting all properties.
function pushbutton_transfer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_transfer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
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
            data_s{i,j}='';
            try
                data_s{i,j}=A{i,j};
            catch
            end
            
        end    
    end   
 
end
 
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



function edit_freq1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_freq1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_freq1 as text
%        str2double(get(hObject,'String')) returns contents of edit_freq1 as a double


% --- Executes during object creation, after setting all properties.
function edit_freq1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_freq1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_refiltering.
function listbox12_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_refiltering (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_refiltering contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_refiltering


% --- Executes during object creation, after setting all properties.
function listbox12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_refiltering (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

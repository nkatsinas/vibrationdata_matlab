function varargout = vibrationdata_read_data(varargin)
% VIBRATIONDATA_READ_DATA MATLAB code for vibrationdata_read_data.fig
%      VIBRATIONDATA_READ_DATA, by itself, creates a new VIBRATIONDATA_READ_DATA or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_READ_DATA returns the handle to a new VIBRATIONDATA_READ_DATA or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_READ_DATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_READ_DATA.M with the given input arguments.
%
%      VIBRATIONDATA_READ_DATA('Property','Value',...) creates a new VIBRATIONDATA_READ_DATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_read_data_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_read_data_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_read_data

% Last Modified by GUIDE v2.5 20-Jan-2015 13:06:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_read_data_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_read_data_OutputFcn, ...
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


% --- Executes just before vibrationdata_read_data is made visible.
function vibrationdata_read_data_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_read_data (see VARARGIN)

% Choose default command line output for vibrationdata_read_data
handles.output = hObject;



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_read_data wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function read_data(hObject, eventdata, handles)
clear THM;
clear THF;
%
[filename, pathname] = uigetfile('*.*');
filename = fullfile(pathname, filename); 
fid = fopen(filename,'r');
%
j=1;
%
for i=1:20000000
%
    clear THF;
    THF = fgets(fid);
    if(THF==-1)
         if(max(size(THF))==1)
             break;
         end
    end
%
     clear aaa;
     aaa = sscanf(THF,'%g');
     aaa=aaa';
%%
    iflag=1;
%    
    k = findstr(THF,'0');   
    if(k>=1)
      iflag=2;
    else
      k = findstr(THF,'1');
      if(k>=1)
        iflag=2;
      else
        k = findstr(THF,'2');
        if(k>=1)
          iflag=2;
        else
          k = findstr(THF,'3');
          if(k>=1)
            iflag=2;
          else
            k = findstr(THF,'4');
            if(k>=1)
              iflag=2;
            else
              k = findstr(THF,'5');
              if(k>=1)
                iflag=2;
              else
                k = findstr(THF,'6');
                if(k>=1)
                  iflag=2;
                else
                  k = findstr(THF,'7');
                  if(k>=1)
                    iflag=2;
                  else
                    k = findstr(THF,'8');
                    if(k>=1)
                      iflag=2;
                    else
                      k = findstr(THF,'9');
                      if(k>=1)
                        iflag=2;
                      end                               
                    end                        
                  end                     
                end                    
              end                 
            end    
          end              
        end             
      end     
    end            
%%
    if(iflag==2)
        THM(j,:)=aaa;
        j=j+1;
    end
%
end
%
setappdata(0,'THM',THM);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_read_data_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_enter.
function pushbutton_enter_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_enter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

THM=getappdata(0,'THM');

new_name=get(handles.edit_array_name,'String');

sz=size(THM);
disp(' ');
out1=sprintf(' size:  %d x %d  ',sz(1),sz(2));
disp(out1);

%
assignin('base', new_name, THM);
h = msgbox('Import Complete'); 


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_read_data);


% --- Executes on button press in pushbutton_select_input.
function pushbutton_select_input_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_select_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=vibrationdata_read_ascii_text;    
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_Load.
function pushbutton_Load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile('*.mat');
 
NAME = [pathname,filename];
struct=load(NAME);
structnames = fieldnames(struct, '-full'); % fields in the struct

k=length(structnames);

for i=1:k
    namevar=strcat('struct.',structnames{i});
    value=eval(namevar);
    assignin('base',structnames{i},value);
end


% --- Executes on button press in pushbutton_SIF_mat.
function pushbutton_SIF_mat_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_SIF_mat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_library.
function pushbutton_library_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_library (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_library,'Value');

if(n==1)
    load('navmat_spec.psd');
    msgbox('Array Name: navmat_spec    units: freq(Hz) & G^2/Hz');
    
    output_name='navmat_spec';
    assignin('base', output_name, navmat_spec);
    disp(output_name);
end
if(n==2)
    load('mil_std_1540b.psd');         
    msgbox('Array Name: mil_std_1540b    units: freq(Hz) & G^2/Hz');
    
    output_name='mil_std_1540b';
    assignin('base', output_name, mil_std_1540b);    
    disp(output_name);    
end
if(n==3)
   
    handles.s= vibrationdata_aircraft_fuselage_psd;                  
    set(handles.s,'Visible','on')
        
end
if(n==4)
    load('HALT_psd.txt');
    msgbox('Array Name: HALT_psd    units: freq(Hz) & G^2/Hz');
    
    output_name='HALT_psd';
    assignin('base', output_name, HALT_psd);  
    disp(output_name);
end







% --- Executes on selection change in listbox_library.
function listbox_library_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_library (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_library contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_library


% --- Executes during object creation, after setting all properties.
function listbox_library_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_library (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_time_history.
function pushbutton_time_history_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_time_history (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_library_th,'Value');


if(n==1)
    load('srs2000G_accel.txt');         
    msgbox('Array Name: srs2000G_accel    units: time(sec) & accel(G)');
    
    output_name='srs2000G_accel';
    assignin('base', output_name, srs2000G_accel);    
end
if(n==2)
    load('srs1000G_accel.txt');   
    msgbox('Array Name: srs1000G_accel    units: time(sec) & accel(G)');
    
    output_name='srs1000G_accel';
    assignin('base', output_name, srs1000G_accel);  
    
end
if(n==3)
    load('elcentro_NS.dat');   
    msgbox('Array Name:  elcentro_NS    units: time(sec) & accel(G)');
    
    output_name='elcentro_NS';
    assignin('base', output_name, elcentro_NS);  
    
end
if(n==4)
    load('rv_separation.dat');   
    msgbox('Array Name:  rv_separation    units: time(sec) & accel(G)');
    
    output_name='rv_separation';
    assignin('base', output_name, rv_separation);  
    
end
if(n==5)
    load('flight_accel_data.txt');   
    msgbox('Array Name:  flight_accel_data    units: time(sec) & accel(G)');
    
    output_name='flight_accel_data';
    assignin('base', output_name, flight_accel_data);  
    
end
if(n==6)
    load('solid_motor.dat');   
    msgbox('Array Name:  solid_motor    units: time(sec) & accel(G)');
    
    output_name='solid_motor';
    assignin('base', output_name, solid_motor);  
    
end
if(n==7)
    load('channel.txt');   
    msgbox('Array Name:  channel    units: time(sec) & accel(G)');
    
    output_name='channel';
    assignin('base', output_name, channel);     
end    
if(n==8)
    load('drop.txt');   
    msgbox('Array Name:  drop    units: time(sec) & accel(G)');
    
    output_name='drop';
    assignin('base', output_name, drop);      
end    
if(n==9)
    load('srb_iea.txt');   
    msgbox('Array Name:  srb_iea   units: time(sec) & accel(G)');
    
    output_name='srb_iea';
    assignin('base', output_name, srb_iea);      
end    
if(n==10)
    load('ASTM_test.txt');   
    msgbox('Array Name:  ASTM_test   units: time(sec) & stress');
    
    output_name='ASTM_test';
    assignin('base', output_name, ASTM_test);      
end    

disp(' ');
disp('Array name: ');
disp(' ');
disp(output_name);


% --- Executes on selection change in listbox_library_th.
function listbox_library_th_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_library_th (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_library_th contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_library_th


% --- Executes during object creation, after setting all properties.
function listbox_library_th_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_library_th (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_psd.
function pushbutton_psd_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_psd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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


% --- Executes on button press in pushbutton_srs.
function pushbutton_srs_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_srs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_library_srs,'Value');

fig_num=1000;

if(n==1)
    load('crash_srs.txt');
    
    output_name='crash_srs';
    assignin('base', output_name, crash_srs );
    
    fn=crash_srs(:,1);
    accel=crash_srs(:,2);
    y_lab='Accel (G)';
    fmin=10;
    fmax=2000;
    t_string='SRS Crash Hazard Q=10';
%
    [~]=abs_srs_plot_function(fig_num,fn,accel,t_string,y_lab,fmin,fmax);
    
     msgbox('Array Name: crash_srs    units: fn(Hz) & peak accel(G)');   
    
end
if(n==2)
    
    load('vafb_1p.txt');  
        
    output_name='vafb_1p';
    assignin('base', output_name, vafb_1p ); 
    
    
    fn=vafb_1p(:,1);
    accel=vafb_1p(:,2);
    y_lab='Accel (G)';
    fmin=0.1;
    fmax=100;
    t_string='SRS VAFB  1% damping';    
    [~]=abs_srs_plot_function(fig_num,fn,accel,t_string,y_lab,fmin,fmax);    
    
    msgbox('Array Name: vafb_1p    units: fn(Hz) & peak accel(G)');    
    
end
if(n==3)
    
    load('Harris_2p.txt');  
        
    output_name='Harris_2p';
    assignin('base', output_name, Harris_2p );    
    
    fn=Harris_2p(:,1);
    accel=Harris_2p(:,2);
    y_lab='Accel (G)';
    fmin=0.1;
    fmax=100;
    t_string='SRS Harris  2% damping';    
    [~]=abs_srs_plot_function(fig_num,fn,accel,t_string,y_lab,fmin,fmax);      
    
    msgbox('Array Name: Harris_2p    units: fn(Hz) & peak accel(G)');    
    
end
if(n==4)
    
    handles.s=IEEE_RSS;    
    set(handles.s,'Visible','on');
    
end


% --- Executes on selection change in listbox_library_srs.
function listbox_library_srs_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_library_srs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_library_srs contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_library_srs


% --- Executes during object creation, after setting all properties.
function listbox_library_srs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_library_srs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_spl.
function pushbutton_spl_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_spl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig_num=1000;

n=get(handles.listbox_library_spl,'Value');
 
if(n==1)
    load('mil_std_1540c_spl.txt');
    output_name='m1540_spl';
    assignin('base', output_name, mil_std_1540c_spl );      

    n_type=1;
    
      f=mil_std_1540c_spl(:,1);
     dB=mil_std_1540c_spl(:,2);
    
    [~]=spl_plot(fig_num,n_type,f,dB);
    
    out1='Array Name: m1540_spl    units: f(Hz) & SPL(dB) ref: 20 micro Pa';
    
    msgbox(out1);
    
    disp(out1);
    
end



% --- Executes on selection change in listbox_library_spl.
function listbox_library_spl_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_library_spl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_library_spl contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_library_spl


% --- Executes during object creation, after setting all properties.
function listbox_library_spl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_library_spl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_acoustic_th.
function listbox_acoustic_th_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_acoustic_th (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_acoustic_th contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_acoustic_th


% --- Executes during object creation, after setting all properties.
function listbox_acoustic_th_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_acoustic_th (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_read_acth.
function pushbutton_read_acth_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_read_acth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_acoustic_th,'Value');

if(n==1)
    load('tuning_fork.txt');   
    msgbox('Array Name:  tuning_fork   units: time(sec) & unscaled sound pressure');
    
    output_name='tuning_fork';
    assignin('base', output_name, tuning_fork);      
end    
if(n==2)
    load('transformer.txt');   
    msgbox('Array Name:  transformer   units: time(sec) & unscaled sound pressure');
    
    output_name='transformer';
    assignin('base', output_name, transformer);      
end   
if(n==3)
    load('Q400.mat');   
    msgbox('Array Name:  Q400   units: time(sec) & unscaled sound pressure');
       
    output_name='Q400';
    assignin('base', output_name, Q400);  
    
end   


% --- Executes on selection change in listbox6.
function listbox6_Callback(hObject, eventdata, handles)
% hObject    handle to listbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox6


% --- Executes during object creation, after setting all properties.
function listbox6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

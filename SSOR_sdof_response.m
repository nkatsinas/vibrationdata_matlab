function varargout = SSOR_sdof_response(varargin)
% SSOR_SDOF_RESPONSE MATLAB code for SSOR_sdof_response.fig
%      SSOR_SDOF_RESPONSE, by itself, creates a new SSOR_SDOF_RESPONSE or raises the existing
%      singleton*.
%
%      H = SSOR_SDOF_RESPONSE returns the handle to a new SSOR_SDOF_RESPONSE or the handle to
%      the existing singleton*.
%
%      SSOR_SDOF_RESPONSE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SSOR_SDOF_RESPONSE.M with the given input arguments.
%
%      SSOR_SDOF_RESPONSE('Property','Value',...) creates a new SSOR_SDOF_RESPONSE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SSOR_sdof_response_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SSOR_sdof_response_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SSOR_sdof_response

% Last Modified by GUIDE v2.5 16-Nov-2020 11:19:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SSOR_sdof_response_OpeningFcn, ...
                   'gui_OutputFcn',  @SSOR_sdof_response_OutputFcn, ...
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


% --- Executes just before SSOR_sdof_response is made visible.
function SSOR_sdof_response_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SSOR_sdof_response (see VARARGIN)

% Choose default command line output for SSOR_sdof_response
handles.output = hObject;

listbox_num_Callback(hObject, eventdata, handles);

set(handles.uipanel_save,'Visible','off');
set(handles.uipanel_results,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SSOR_sdof_response wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SSOR_sdof_response_OutputFcn(hObject, eventdata, handles) 
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

delete(SSOR_sdof_response);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


disp('  ');
disp(' * * * * * * * * * * ');
disp('  ');


fig_num=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS=get(handles.edit_input_array_name,'String');
    psd=evalin('base',FS);     
catch
    warndlg('Input PSD does not exist.');
    return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N=get(handles.listbox_num,'Value');

ntype=get(handles.listbox_type,'Value');

if(ntype==1)
    rate='lin';
else
    rate='log';
end


dur=str2double(get(handles.edit_duration,'String'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data=get(handles.uitable_data,'Data');
A=char(data);
   
fstart=zeros(N,1);
fend=zeros(N,1);
amp=zeros(N,1);

try
    k=1;
    
    for i=1:N
        a=A(k,:); k=k+1;
        fstart(i,1) = str2double(strtrim(a));
    end    
    
    for i=1:N
        a=A(k,:); k=k+1;
        fend(i,1) = str2double(strtrim(a));
    end   
       
    for i=1:N
        a=A(k,:); k=k+1;
        amp(i,1) = str2double(strtrim(a));
    end   
    
catch
    warndlg('Input Arrays read failed');
    return;
end

sine_sweep=[fstart fend amp];

[total_synth,velox,dispx,fig_num]=SSOR_synth_function_alt(psd,sine_sweep,fig_num,dur,rate);



setappdata(0,'THM',total_synth);

set(handles.uipanel_save,'Visible','on');
set(handles.uipanel_results,'Visible','on');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

yy=total_synth(:,2);
num=length(yy);
dt=(total_synth(end,1)-total_synth(1,1))/(num-1);

THM(:,1)=total_synth(:,1);
t=THM(:,1);

fn=str2num(get(handles.edit_fn,'String'));
Q=str2num(get(handles.edit_Q,'String'));
damp=1/(2*Q);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
%  Initialize coefficients
%
[a1,a2,b1,b2,b3,rd_a1,rd_a2,rd_b1,rd_b2,rd_b3]=...
                                   srs_coefficients(fn,damp,dt);
%
%
%  SRS engine
%

a_pos=zeros(1,1);
a_neg=zeros(1,1);
rd_pos=zeros(1,1);
rd_neg=zeros(1,1);

iu=1;

for j=1:1
%
    disp(' ')
    disp(' Calculating absolute acceleration');
%
    [a_resp,a_pos(j),a_neg(j)]=arbit_engine(a1(j),a2(j),b1(j),b2(j),b3(j),yy);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    disp(' ')
    disp(' Calculating relative displacement');
%
    [rd_resp,rd_pos(j),rd_neg(j)]=arbit_engine(rd_a1(j),rd_a2(j),rd_b1(j),rd_b2(j),rd_b3(j),yy);
    
    if(iu==1)
        scale=386;
    end
    if(iu==2)
        scale=9.81*1000;        
    end
    if(iu==3)
        scale=1000;        
    end    
%
    rd_resp=rd_resp*scale;
    rd_pos(j)=rd_pos(j)*scale;
    rd_neg(j)=rd_neg(j)*scale;
    
end
%

iu=1;

[big_string]=...
    sdof_response_stats(a_resp,rd_resp,dur,t,dt,iu,rd_pos,rd_neg,a_pos,a_neg);

set(handles.edit_results,'String',big_string);

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
t=fix_size(t);
a_resp=fix_size(a_resp);

data1=total_synth;
data2=[t  a_resp];
setappdata(0,'accel_response',[t a_resp]);
setappdata(0,'rd_response',[t rd_resp]);

xlabel2='Time(sec)';

if(iu==1 || iu==2)
    ylabel1='Accel (G)';
    ylabel2='Accel (G)'; 
    yyL='G rms';
else
    ylabel1='Accel (m/sec^2)';
    ylabel2='Accel (m/sec^2)'; 
    yyL='(m/sec)^2 rms';  
end

t_string1=('Base Input');
t_string2=sprintf('Acceleration Response (fn=%g Hz, Q=%g)  %7.3g %s',fn,Q,std(a_resp),yyL);
art=t_string2;

[fig_num]=...
    subplots_two_linlin_two_titles_scale_same(fig_num,xlabel2,...
                          ylabel1,ylabel2,data1,data2,t_string1,t_string2);

                      
figure(fig_num);
fig_num=fig_num+1;
plot(t,rd_resp);
grid on;
xlabel('Time (sec)');
ylabel('Rel Disp (in)');
yyL='inch rms';
t_string3=sprintf('Relative Displacement (fn=%g Hz, Q=%g)  %7.3g %s',fn,Q,std(rd_resp),yyL);
rdrt=t_string3;
title(t_string3);
yabs=max(abs(rd_resp));
[ymax,yTT,ytt,iflag]=ytick_linear_double_sided(yabs);
if(iflag==1)
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

iunit=iu;

a=total_synth(:,2);
amp=a;

unit='G';
aat=sprintf('Base Input Acceleration Time History  %7.3g %s rms',std(amp),unit);
ay=sprintf('Acceleration (%s)',unit);

if(iunit==1)
    unit='in/sec';
else
    unit='cm/sec';    
end
vvt=sprintf('Base Input Velocity Time History %7.3g %s rms',std(velox),unit);
vy=sprintf('Velocity (%s)',unit);

if(iunit==1)
    unit='in';
else
    unit='mm';    
end
ddt=sprintf('Base Input Displacement Time History  %7.3g %s rms',std(dispx),unit);
dy=sprintf('Displacement (%s)',unit);
drdry=sprintf('Rel Disp (%s)',unit);

tt=t;
v=velox;
d=dispx;
rdr=rd_resp;
ar=a_resp;

[fig_num,hp]=...
    plot_avd_time_histories_subplots_altp_titles_responses(fig_num,tt,a,v,d,ay,vy,dy,aat,vvt,ddt,ar,rdr,art,rdrt,drdry);



function edit_T_Callback(hObject, eventdata, handles)
% hObject    handle to edit_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_T as text
%        str2double(get(hObject,'String')) returns contents of edit_T as a double


% --- Executes during object creation, after setting all properties.
function edit_T_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_duration_Callback(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_duration as text
%        str2double(get(hObject,'String')) returns contents of edit_duration as a double


% --- Executes during object creation, after setting all properties.
function edit_duration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_input_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_name as a double
% set(handles.uipanel_results,'Visible','off');

% --- Executes during object creation, after setting all properties.
function edit_input_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
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


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');
set(handles.edit_results,'Visible','off');

Nrows=get(handles.listbox_num,'Value');
 
Ncolumns=3;
 
for i=1:Nrows
    for j=1:Ncolumns
        data_s{i,j}='';
    end    
end  


set(handles.uitable_data,'Data',data_s);




% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox_delete_array.
function listbox_delete_array_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_delete_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_delete_array contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_delete_array


% --- Executes during object creation, after setting all properties.
function listbox_delete_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_delete_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type
set(handles.edit_results,'Visible','off');
set(handles.uipanel_save,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_output_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_response,'Value');

if(n==1)
    data=getappdata(0,'THM');
end
if(n==2)
    data=getappdata(0,'accel_response');    
end
if(n==3)
    data=getappdata(0,'rd_response');
end

output_name=get(handles.edit_output_array_name,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 


% --- Executes on button press in pushbutton_save_model.
function pushbutton_save_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


try
    data=get(handles.uitable_data,'Data');
    SSOR.data=data;
catch
end
try
    num=get(handles.listbox_num,'Value');
    SSOR.num=num;
catch
end
try
    type=get(handles.listbox_type,'Value');
    SSOR.type=type;
catch
end
try
    duration=get(handles.edit_duration,'String');
    SSOR.duration=duration;
catch
end
try
    name=strtrim(get(handles.edit_input_array_name,'String'));
    SSOR.name=name;
catch
end

try    
    psd=evalin('base',name);
    SSOR.psd=psd;     
catch
end

try
    fn=get(handles.edit_fn,'String');
    SSOR.fn=fn;
catch
end

try
    Q=get(handles.edit_Q,'String');
    SSOR.Q=Q;
catch
end


% % %
 
structnames = fieldnames(SSOR, '-full'); % fields in the struct
  
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);

    
    try
 
        save(elk, 'SSOR'); 
 
    catch
        warndlg('Save error');
        return;
    end
 
%%% SSS=load(elk)
 
%%%%%%%%%%
%%%%%%%%%%
try 
    msgbox('Save Complete');
catch
end



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

   SSOR=evalin('base','SSOR');

catch
   warndlg(' evalin failed ');
   return;
end

%%%%%%%%%%%%


try
    fn=SSOR.fn;    
    set(handles.edit_fn,'String',fn);
catch
end

try
    Q=SSOR.Q;    
    set(handles.edit_Q,'String',Q);
catch
end


try
    data=SSOR.data; 
    set(handles.uitable_data,'Data',data);
catch
end
try
    num=SSOR.num;    
    set(handles.listbox_num,'Value',num);
catch
end
try
    type=SSOR.type;    
    set(handles.listbox_type,'Value',type);
catch
end
try
    duration=SSOR.duration; 
    set(handles.edit_duration,'String',duration);
catch
end
try
    name=SSOR.name;    
    set(handles.edit_input_array_name,'String',name);
catch
end

listbox_num_Callback(hObject, eventdata, handles);


try

    iflag=0;
    
    try
        temp=evalin('base',name);
        ss=sprintf('Replace %s with Previously Saved Array',name);
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
            psd=SSOR.psd;
            assignin('base',name,psd); 
        catch
        end
    end
    
catch    
end




% --- Executes during object creation, after setting all properties.
function pushbutton_save_model_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



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



function edit_fn_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fn as text
%        str2double(get(hObject,'String')) returns contents of edit_fn as a double


% --- Executes during object creation, after setting all properties.
function edit_fn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Q_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q as text
%        str2double(get(hObject,'String')) returns contents of edit_Q as a double


% --- Executes during object creation, after setting all properties.
function edit_Q_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_fn and none of its controls.
function edit_fn_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');
set(handles.uipanel_save,'Visible','off');

% --- Executes on key press with focus on edit_Q and none of its controls.
function edit_Q_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');
set(handles.uipanel_save,'Visible','off');

% --- Executes on selection change in listbox_response.
function listbox_response_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_response (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_response contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_response


% --- Executes during object creation, after setting all properties.
function listbox_response_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_response (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_duration and none of its controls.
function edit_duration_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_results,'Visible','off');
set(handles.uipanel_save,'Visible','off');

% --- Executes on key press with focus on edit_input_array_name and none of its controls.
function edit_input_array_name_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_results,'Visible','off');
set(handles.uipanel_save,'Visible','off');

% --- Executes on key press with focus on uitable_data and none of its controls.
function uitable_data_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to uitable_data (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');
set(handles.uipanel_save,'Visible','off');

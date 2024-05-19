function varargout = vibrationdata_fds(varargin)
% VIBRATIONDATA_FDS MATLAB code for vibrationdata_fds.fig
%      VIBRATIONDATA_FDS, by itself, creates a new VIBRATIONDATA_FDS or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_FDS returns the handle to a new VIBRATIONDATA_FDS or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_FDS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_FDS.M with the given input arguments.
%
%      VIBRATIONDATA_FDS('Property','Value',...) creates a new VIBRATIONDATA_FDS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_fds_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_fds_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_fds

% Last Modified by GUIDE v2.5 16-May-2021 20:26:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_fds_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_fds_OutputFcn, ...
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


% --- Executes just before vibrationdata_fds is made visible.
function vibrationdata_fds_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_fds (see VARARGIN)

% Choose default command line output for vibrationdata_fds
handles.output = hObject;

set(handles.edit_Q,'String','10');

set(handles.listbox_method,'Value',1);
set(handles.listbox_engine,'Value',2);

set(handles.pushbutton_save,'Enable','off');
set(handles.edit_output_array_fds,'Enable','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_fds wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_fds_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_fds);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig_num=1;

tscale=str2num(get(handles.edit_scale,'String'));

ioct=get(handles.listbox_interpolation,'Value');

if(ioct==1)
    oct=1/3;
end
if(ioct==2)
    oct=1/6;
end
if(ioct==3)
    oct=1/12;
end
if(ioct==4)
    oct=1/24;
end

iu=get(handles.listbox_unit,'Value');

k=get(handles.listbox_method,'Value');

iflag=1;
 
if(k==1)
     try  
         FS=get(handles.edit_input_array,'String');
         THM=evalin('base',FS);  
         iflag=1;
     catch
         iflag=0; 
         warndlg('Input Array does not exist.  Try again.')
     end
else
  THM=getappdata(0,'THM');
end
 
if(iflag==0)
    return;
end 


y=double(THM(:,2));
yy=y;


n=length(y);

dur=THM(n,1)-THM(1,1);

dt=dur/(n-1);
sr=1/dt;

im=get(handles.listbox_metric,'Value');

num_eng=get(handles.listbox_engine,'Value');

Q=str2num(get(handles.edit_Q,'String'));

bex=str2num(get(handles.edit_bex,'String'));

dchoice=1.;

fstart=str2num(get(handles.edit_start_frequency,'String'));
fend=str2num(get(handles.edit_plot_fmax,'String'));

damp=1/(2*Q);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fn(1)=fstart;

fmax=sr/8;

if fn(1)>sr/30.
    fn(1)=sr/30.;
end
%
j=1;
while(1)
    if (fn(j) > sr/8. || fn(j)>fend)
        break
    end
    fn(j+1)=fn(1)*(2. ^ (j*oct));
    j=j+1;
end
%
fn=fn';
%
n=length(fn);
%
damage=zeros(n,1);
%
pos=zeros(n,1);
neg=zeros(n,1);
abs_srs=zeros(n,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
progressbar;
%
for i=1:n
    rm(i)=i;
end    
%
for ik=1:n
%
        if(ik>1)
            k=ceil(length(rm)*rand()); 
            i=rm(k);
        else
            i=1;
        end    
        rm(k)=[];
%
        progressbar(ik/n);
%
        if(im==1)
            [y_resp]=arbit_function_accel(fn(i),damp,dt,y);   
        else
            [y_resp]=arbit_function_rd(fn(i),damp,dt,y);
        end
%
        if(im==2) % pseudo velocity (approx)
%         
            [y_resp]=differentiate_function(y_resp,dt);
%
            if(iu==1)
                y_resp=y_resp*386;
            else
                y_resp=y_resp*9.81;
            end
%
        end
%
        if(im==3) % relative displacement
            if(iu==1)
                y_resp=y_resp*386;
            else
                y_resp=y_resp*9.81*1000;
            end
        end
%

        D=0;

        if(num_eng==1)
%
            if(license('test','Signal_Toolbox')==0 ||  verLessThan('matlab','9.3'))
%               disp('1');
                [range_cycles]=vibrationdata_rainflow_function_basic(y_resp);
   
            else
%               disp('2');
                try
                    [c,~,~,~,~] = rainflow(y_resp);
                catch
                    warndlg('fds_engine: rainflow failed');
                    return;
                end
                
                clear range_cycles; 
                range_cycles(:,1)=c(:,2);
                range_cycles(:,2)=c(:,1);                
                
            end

            sz=size(range_cycles);
            for iv=1:sz(1)
                D=D+range_cycles(iv,2)*( 0.5*range_cycles(iv,1) )^bex;
            end             
%
        else
%            
            [ac1,ac2,nkv]=rainflow_basic_dyn_mex(y_resp);
            
            for iv=1:nkv
                D=D+ac2(iv)*(ac1(iv))^bex;
            end             
%
        end    
%
%%        out1=sprintf(' %d %8.4g %8.4g \n',i,fn(i),D);
%%        disp(out1);
        damage(i)=D*tscale;
        pos(i)=max(y_resp);
        neg(i)=abs(min(y_resp));
        
        abs_srs(i)=max([ pos(i) neg(i) ]);
%
end

pause(0.3)
progressbar(1);

fn=fix_size(fn);
pos=fix_size(pos);
neg=fix_size(neg);
abs_srs=fix_size(abs_srs);
damage=fix_size(damage);

%


srs=[fn abs_srs];
setappdata(0,'srs',srs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
figure(fig_num);
fig_num=fig_num+1;
plot(fn,pos,fn,neg);
out1=sprintf('Shock Response Spectrum  Q=%g',Q);
title(out1);
legend ('positive','negative');
xlabel('Natural Frequency (Hz)');
%
if(im==1)
    ylabel('Peak Accel (G)');
end    
%
if(im==2)
    if(iu==1)
        ylabel('Peak Pseudo Velocity (in/sec)');
    else
        ylabel('Peak Pseudo Velocity (m/sec)');
    end
end
%
if(im==3)
    if(iu==1)
        ylabel('Peak Rel Disp (in)');
    else
        ylabel('Peak Rel Disp (mm)');
    end
end
%
maxY=max([max(pos) max(neg)]);
minY=min([min(pos) min(neg)]);
%
ymax=10^(ceil(log10(maxY)));
ymin=10^(floor(log10(minY)));

ylim([ymin ymax]);    


[xtt,xTT,iflag]=xtick_label(fstart,fend);
if(iflag==1)
    xlim([min(xtt) max(xtt)]);
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
end       


grid on;
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fds=[fn damage];
setappdata(0,'fds',fds);

%
if(im==1)
    out1=sprintf('Acceleration Fatigue Damage Spectrum Q=%g b=%g',Q,bex);
    if(iu<=2)
        ylab=sprintf('Damage Index log10(G^{ %g })',bex);
    else
        ylab=sprintf('Damage Index log10(G^{ %g })',bex);        
    end
end
%
if(im==2)
    if(iu==1)
        out1=sprintf('Pseudo Velocity Fatigue Damage Spectrum Q=%g b=%g',Q,bex);
        ylab=sprintf('Damage Index log10(ips^{ %g })',bex);
    else
        out1=sprintf('Pseudo Velocity Fatigue Damage Spectrum Q=%g b=%g',Q,bex);
        ylab=sprintf('Damage Index log10((m/sec)^{ %g })',bex);        
    end  
%
end
%
if(im==3)
    if(iu==1)
        out1=sprintf('Relative Disp Fatigue Damage Spectrum Q=%g b=%g',Q,bex);
        ylab=sprintf('Damage Index log10(inch^{ %g })',bex);        
    else
        out1=sprintf('Relative Disp Fatigue Damage Spectrum Q=%g b=%g',Q,bex);
        ylab=sprintf('Damage Index log10(mm^{ %g })',bex);        
    end    
end

t_string=out1;
%

fmin=fstart;
fmax=fend;
xlab='Natural Frequency (Hz)';

[fig_num]=multiple_fds_plot_1x1_alt2(fig_num,bex,fn,damage,t_string,fmin,fmax,ylab);

%
set(handles.pushbutton_save,'Enable','on');
set(handles.edit_output_array_fds,'Enable','on');


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

set(handles.pushbutton_save,'Enable','off');
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



function edit_start_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to edit_start_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_start_frequency as text
%        str2double(get(hObject,'String')) returns contents of edit_start_frequency as a double


% --- Executes during object creation, after setting all properties.
function edit_start_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_start_frequency (see GCBO)
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



function edit_plot_fmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_plot_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_plot_fmax as text
%        str2double(get(hObject,'String')) returns contents of edit_plot_fmax as a double


% --- Executes during object creation, after setting all properties.
function edit_plot_fmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_plot_fmax (see GCBO)
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

n=get(handles.listbox_save,'Value');

if(n==1)
    data=getappdata(0,'fds');
else
    data=getappdata(0,'srs');    
end

output_name=get(handles.edit_output_array_fds,'String');
assignin('base', output_name, data);
 
h = msgbox('Save Complete'); 


function edit_output_array_fds_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array_fds (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array_fds as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array_fds as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_fds_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array_fds (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_bex_Callback(hObject, eventdata, handles)
% hObject    handle to edit_bex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_bex as text
%        str2double(get(hObject,'String')) returns contents of edit_bex as a double


% --- Executes during object creation, after setting all properties.
function edit_bex_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_bex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_engine.
function listbox_engine_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_engine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_engine contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_engine


% --- Executes during object creation, after setting all properties.
function listbox_engine_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_engine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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


% --- Executes on selection change in listbox_interpolation.
function listbox_interpolation_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_interpolation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_interpolation contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_interpolation


% --- Executes during object creation, after setting all properties.
function listbox_interpolation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_interpolation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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



function edit_scale_Callback(hObject, eventdata, handles)
% hObject    handle to edit_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_scale as text
%        str2double(get(hObject,'String')) returns contents of edit_scale as a double


% --- Executes during object creation, after setting all properties.
function edit_scale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_scale (see GCBO)
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

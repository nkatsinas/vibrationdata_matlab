function varargout = vibrationdata_integrate_double(varargin)
% VIBRATIONDATA_INTEGRATE_DOUBLE MATLAB code for vibrationdata_integrate_double.fig
%      VIBRATIONDATA_INTEGRATE_DOUBLE, by itself, creates a new VIBRATIONDATA_INTEGRATE_DOUBLE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_INTEGRATE_DOUBLE returns the handle to a new VIBRATIONDATA_INTEGRATE_DOUBLE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_INTEGRATE_DOUBLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_INTEGRATE_DOUBLE.M with the given input arguments.
%
%      VIBRATIONDATA_INTEGRATE_DOUBLE('Property','Value',...) creates a new VIBRATIONDATA_INTEGRATE_DOUBLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_integrate_double_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_integrate_double_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_integrate_double

% Last Modified by GUIDE v2.5 22-Apr-2015 15:03:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_integrate_double_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_integrate_double_OutputFcn, ...
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


% --- Executes just before vibrationdata_integrate_double is made visible.
function vibrationdata_integrate_double_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_integrate_double (see VARARGIN)

% Choose default command line output for vibrationdata_integrate_double
handles.output = hObject;

set(handles.listbox_method,'Value',1);
listbox_integration_1_Callback(hObject, eventdata, handles)


set(handles.edit_input_array_name,'Visible','on');
set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array_name,'Enable','on');
set(handles.text_input_array_name,'Enable','on');


set(handles.listbox_integration_1,'Value',1);
set(handles.listbox_integration_2,'Value',1);
set(handles.listbox_integration_3,'Value',1);

set(handles.uipanel_save,'Visible','off');

set(handles.listbox_psave,'Value',2);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_integrate_double wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_integrate_double_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_integrate_double);


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units
set(handles.uipanel_save,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_units_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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

disp(' ');
disp(' * * * * * ');
disp(' ');


iunit=get(handles.listbox_units,'Value');
setappdata(0,'iunit',iunit);

k=get(handles.listbox_method,'Value');

 
if(k==1)
  FS=get(handles.edit_input_array_name,'String');
  THM=evalin('base',FS);   
else
  THM=getappdata(0,'THM');
end

tt=THM(:,1);

y=double(THM(:,2));

num=length(y);

dur=THM(num,1)-THM(1,1);

dt=dur/(num-1);


%%%

I1=get(handles.listbox_integration_1,'Value');
I2=get(handles.listbox_integration_2,'Value');
I3=get(handles.listbox_integration_3,'Value');

%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Integration 1

if(I1==2)
    y=y-mean(y);
end
if(I1==3)
    y=detrend(y);    
end
if(I1==4)
    n = 2;
    p = polyfit(tt,y,n);
    y= y - (  p(1)*tt.^2 + p(2)*tt + p(3));        
end
if(I1==5)
    fc=str2num(get(handles.edit_fc,'String'));
    y=detrend(y);      
    [y]=Butterworth_filter_highpass_function(y,fc,dt);    
end



ntap=get(handles.listbox_taper_a,'Value');

if(ntap>1)
    if(ntap==2)
        npe=0.5;
    end
    if(ntap==3)
        npe=1;
    end
    if(ntap==4)
        npe=2;
    end
    if(ntap==5)
        npe=3;
    end
    if(ntap==6)
        npe=4;
    end    
    if(ntap==7)
        npe=5;
    end
    if(ntap==8)
        npe=6;
    end
    if(ntap==9)
        npe=7;
    end
    if(ntap==10)
        npe=8;
    end
    if(ntap==11)
        npe=9;
    end    
    if(ntap==12)
        npe=10;
    end    
%
    [y]=half_cosine_fade_perc(y,npe);

end

out1=sprintf('\n dt=%8.4g sec   ntap=%d ',dt,ntap);
disp(out1);


a=y;
v=dt*cumtrapz(a);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% In Between

if(I2==2)
    v=v-mean(v);    
end    
if(I2==3)
    v=detrend(v);        
end 
if(I2==4)
    n = 2;
    p = polyfit(tt,v,n);
    v= v - (  p(1)*tt.^2 + p(2)*tt + p(3));
end 
if(I2==5)
    n = 3;
    p = polyfit(tt,v,n);
    v= v - (  p(1)*tt.^3 + p(2)*tt.^2 + p(3)*tt + p(4));
end


ntap=get(handles.listbox_taper_v,'Value');

if(ntap>1)
    if(ntap==2)
        npe=0.5;
    end
    if(ntap==3)
        npe=1;
    end
    if(ntap==4)
        npe=2;
    end
    if(ntap==5)
        npe=3;
    end
    if(ntap==6)
        npe=4;
    end    
    if(ntap==7)
        npe=5;
    end
    if(ntap==8)
        npe=6;
    end
    if(ntap==9)
        npe=7;
    end
    if(ntap==10)
        npe=8;
    end
    if(ntap==11)
        npe=9;
    end    
    if(ntap==12)
        npe=10;
    end    
%
    [v]=half_cosine_fade_perc(v,npe);

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Integration 2

d=zeros(num,1);

d=dt*cumtrapz(v);

d=fix_size(d);

if(I3==2)
    d=d-mean(d);    
end    
if(I3==3)
    d=detrend(d);        
end 
if(I3==4)
    n = 2;
    p = polyfit(tt,d,n);
    d= d - (  p(1)*tt.^2 + p(2)*tt + p(3));
end 
if(I3==5)
    n = 3;
    p = polyfit(tt,d,n);
    d= d - (  p(1)*tt.^3 + p(2)*tt.^2 + p(3)*tt + p(4));
end

ntap=get(handles.listbox_taper_d,'Value');

if(ntap>1)
    if(ntap==2)
        npe=0.5;
    end
    if(ntap==3)
        npe=1;
    end
    if(ntap==4)
        npe=2;
    end
    if(ntap==5)
        npe=3;
    end
    if(ntap==6)
        npe=4;
    end    
    if(ntap==7)
        npe=5;
    end
    if(ntap==8)
        npe=6;
    end
    if(ntap==9)
        npe=7;
    end
    if(ntap==10)
        npe=8;
    end
    if(ntap==11)
        npe=9;
    end    
    if(ntap==12)
        npe=10;
    end    
%
    [d]=half_cosine_fade_perc(d,npe);
%
end    
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a=fix_size(a);
v=fix_size(v);
d=fix_size(d);

if(iunit==1)
    v=v*386;
    d=d*386;
    ay='Accel (G)';
    vy='Vel (in/sec)';
    dy='Disp (in)';
end
if(iunit==2)
    v=v*9.81*100;
    d=d*9.81*1000;
    ay='Accel (G)';
    vy='Vel (cm/sec)';
    dy='Disp (mm)';
end
if(iunit==3)
    v=v*100;
    d=d*1000;
    ay='Accel (m/sec^2)';
    vy='Vel (cm/sec)';
    dy='Disp (mm)';
end

try
   fig_num=getappdata(0,'fig_num');
catch 
   fig_num=1;
end


if( length(fig_num)==0)
    fig_num=1;
end

[fig_num,hp]=plot_avd_time_histories_subplots_altp(fig_num,tt,a,v,d,ay,vy,dy);

%%%

psave=get(handles.listbox_psave,'Value');


if(psave==1)
    
    pname='integrated_data';
    
    
    set(gca,'Fontsize',12);
    print(hp,pname,'-dpng','-r300');
    
    out1=sprintf('\n Plot File:  %s.png',pname);
    disp(out1);
    
    msgbox('Plot file exported to hard drive: integrated_data.png');
   
end


%%%

set(handles.uipanel_save,'Visible','on');

aa=[tt a];
vv=[tt v];
dd=[tt d];

setappdata(0,'acceleration',aa);
setappdata(0,'velocity',vv);
setappdata(0,'displacement',dd);
setappdata(0,'dt',dt);
setappdata(0,'ay',ay);
setappdata(0,'vy',vy);
setappdata(0,'dy',dy);

disp(' ');
        disp('                 max     min     std ')

out1=sprintf(' acceleration: %8.4g %8.4g %8.4g ',max(a),min(a),std(a));
out2=sprintf('     velocity: %8.4g %8.4g %8.4g ',max(v),min(v),std(v));
out3=sprintf(' displacement: %8.4g %8.4g %8.4g  ',max(d),min(d),std(d));

disp(out1);
disp(out2);
disp(out3);

setappdata(0,'fig_num',fig_num);


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method

set(handles.uipanel_save,'Visible','off');

n=get(handles.listbox_method,'Value');

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array_name,'Visible','on');

if(n==1)
   set(handles.edit_input_array_name,'enable','on') 
else
    
   set(handles.text_input_array_name,'Visible','off');
   set(handles.edit_input_array_name,'Visible','off');

   set(handles.edit_input_array_name,'enable','off')
   
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



function edit_input_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_name as a double


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


% --- Executes on selection change in listbox_integration_1.
function listbox_integration_1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_integration_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_integration_1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_integration_1

set(handles.uipanel_save,'Visible','off');

n=get(handles.listbox_integration_1,'Value');

if(n==5)
    set(handles.edit_fc,'Visible','on');
    set(handles.text_fc,'Visible','on');    
else
    set(handles.edit_fc,'Visible','off');
    set(handles.text_fc,'Visible','off');      
end



% --- Executes during object creation, after setting all properties.
function listbox_integration_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_integration_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_integration_2.
function listbox_integration_2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_integration_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_integration_2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_integration_2

set(handles.uipanel_save,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_integration_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_integration_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_integration_3.
function listbox_integration_3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_integration_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_integration_3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_integration_3

set(handles.uipanel_save,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_integration_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_integration_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fc_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fc as text
%        str2double(get(hObject,'String')) returns contents of edit_fc as a double


% --- Executes during object creation, after setting all properties.
function edit_fc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_input_array_name and none of its controls.
function edit_input_array_name_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_fc and none of its controls.
function edit_fc_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_fc (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on selection change in listbox_output.
function listbox_output_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output


% --- Executes during object creation, after setting all properties.
function listbox_output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output (see GCBO)
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

n=get(handles.listbox_output,'Value');

if(n==1)
    data=getappdata(0,'acceleration');
end
if(n==2)
    data=getappdata(0,'velocity');
end
if(n==3)
    data=getappdata(0,'displacement');
end

output_name=get(handles.edit_output_array_name,'String');

assignin('base', output_name, data);

h = msgbox('Save Complete'); 

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


% --- Executes on selection change in listbox_taper_d.
function listbox_taper_d_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_taper_d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_taper_d contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_taper_d


% --- Executes during object creation, after setting all properties.
function listbox_taper_d_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_taper_d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_taper_v.
function listbox_taper_v_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_taper_v (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_taper_v contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_taper_v


% --- Executes during object creation, after setting all properties.
function listbox_taper_v_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_taper_v (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_taper.
function listbox_taper_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_taper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_taper contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_taper


% --- Executes during object creation, after setting all properties.
function listbox_taper_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_taper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_differentiate.
function pushbutton_differentiate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_differentiate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=vibrationdata_differentiate_displacement;    

set(handles.s,'Visible','on'); 


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


% --- Executes on selection change in listbox_taper_a.
function listbox_taper_a_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_taper_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_taper_a contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_taper_a


% --- Executes during object creation, after setting all properties.
function listbox_taper_a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_taper_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

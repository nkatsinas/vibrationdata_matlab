function varargout = vibrationdata_relative_displacement(varargin)
% VIBRATIONDATA_RELATIVE_DISPLACEMENT MATLAB code for vibrationdata_relative_displacement.fig
%      VIBRATIONDATA_RELATIVE_DISPLACEMENT, by itself, creates a new VIBRATIONDATA_RELATIVE_DISPLACEMENT or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_RELATIVE_DISPLACEMENT returns the handle to a new VIBRATIONDATA_RELATIVE_DISPLACEMENT or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_RELATIVE_DISPLACEMENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_RELATIVE_DISPLACEMENT.M with the given input arguments.
%
%      VIBRATIONDATA_RELATIVE_DISPLACEMENT('Property','Value',...) creates a new VIBRATIONDATA_RELATIVE_DISPLACEMENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_relative_displacement_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_relative_displacement_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_relative_displacement

% Last Modified by GUIDE v2.5 17-Feb-2016 09:09:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_relative_displacement_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_relative_displacement_OutputFcn, ...
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


% --- Executes just before vibrationdata_relative_displacement is made visible.
function vibrationdata_relative_displacement_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_relative_displacement (see VARARGIN)

% Choose default command line output for vibrationdata_relative_displacement
handles.output = hObject;

mn_common(hObject, eventdata, handles);

listbox_integration_1_Callback(hObject, eventdata, handles);

set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_relative_displacement wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_relative_displacement_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_relative_displacement);


function mn_common(hObject, eventdata, handles)

set(handles.text_IAN_1,'Visible','off');
set(handles.text_IAN_2,'Visible','off');
set(handles.edit_input_array_1,'Visible','off');
set(handles.edit_input_array_2,'Visible','off');
set(handles.edit_input_array_1,'String','');
set(handles.edit_input_array_2,'String','');


n=get(handles.listbox_format,'Value');

if(n==1)
    set(handles.text_IAN_1,'Visible','on');
    set(handles.edit_input_array_1,'Visible','on');
    set(handles.text_IAN_1,'String','Input Common Array Name');
end
if(n==2)
    set(handles.text_IAN_1,'Visible','on');
    set(handles.text_IAN_2,'Visible','on');
    set(handles.edit_input_array_1,'Visible','on');
    set(handles.edit_input_array_2,'Visible','on');
    set(handles.text_IAN_1,'String','Input First Array Name');
    set(handles.text_IAN_2,'String','Input Second Array Name');    
end




% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

I1=get(handles.listbox_integration_1,'Value');
I2=get(handles.listbox_integration_2,'Value');
I3=get(handles.listbox_integration_3,'Value');


n=get(handles.listbox_format,'Value');
iu=get(handles.listbox_unit,'Value');
iorder=get(handles.listbox_order,'Value');

FS=strtrim(get(handles.edit_input_array_1,'String'));
THM_1=evalin('base',FS); 
THM_1=fix_size(THM_1);

%
if(n==1)
    
      t1=THM_1(:,1);
      t2=t1;      
      a=THM_1(:,2);
      b=THM_1(:,3);
      
else
%     
      FS=strtrim(get(handles.edit_input_array_2,'String'));
      THM_2=evalin('base',FS);
      THM_2=fix_size(THM_2);      
%     
      t1=THM_1(:,1);
      t2=THM_2(:,1);
      a=THM_1(:,2);
      b=THM_2(:,2);       
end


if(n==1)
   num=length(t1);
   dt=(t1(num)-t1(1))/(num-1);
else
   num1=length(t1);
   dt1=(t1(num1)-t1(1))/(num1-1);   
%   
   num2=length(t2);
   dt2=(t2(num2)-t2(1))/(num2-1);  
%
   dt=(dt1+dt2)/2;
%
    if( abs(t1(1)-t2(1))>1.0e-05)

        out1=sprintf('Starting Time Difference: t1(1)=%8.4g  t2(1)=%8.4g ',t1(1),t2(1));
        warndlg(out1,'Warning');
        return;        
    end
%
    if(num1~=num2)
        num=min([num1 num2]);
        a=a(1:num);
        b=b(1:num);
        t1=t1(1:num);
        t2=t2(1:num);
        warndlg('Number of Samples is Different','Warning');
    end
%
    pe=abs((dt1-dt2)/dt1);
%
    if(pe>0.01)
        out1=sprintf('Sample Rate Difference: dt1=%8.4g  dt2=%8.4g ',dt1,dt2);
        warndlg(out1,'Warning');
        return;
    end 
%
end
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(iorder==1)
    ra=a-b;
else
    ra=b-a;
end


% Integration 1

if(I1==2)
    fc=str2num(get(handles.edit_fc,'String'));
    ra=detrend(ra);      
    [ra]=Butterworth_filter_highpass_function(ra,fc,dt);    
end

rv=dt*cumtrapz(ra);

if(I2==2)
    rv=rv-mean(rv);    
end    
if(I2==3)
    rv=detrend(rv);        
end 

rd=dt*cumtrapz(rv);

if(I3==2)
    rd=rd-mean(rd);    
end    
if(I3==3)
    rd=detrend(rd);        
end 



if(iu==1)
    rd=rd*386;
end
if(iu==2)
    rd=rd*9.81*1000;
end
if(iu==3)
    rd=rd*1000;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

if(iu<=2)
    accel_label='Accel (G)';
else
    accel_label='Accel (m/sec^2)';    
end 

if(iu<=1)
    rel_disp_label='Rel Disp (in)';
else
    rel_disp_label='Rel Disp (mm)'; 
end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=1;
figure(fig_num);
fig_num=fig_num+1;

if(max(abs(a))>max(abs(b)))

        subplot(2,1,1);
        plot(t1,a);
        grid on;
        ylabel(accel_label);
        title('Acceleration  top=first  bottom=second');
        yLimits = get(gca,'YLim');
        ya=max(abs(yLimits));
        ylim([-ya ya]);
%
        subplot(2,1,2);
        plot(t2,b);
        grid on;
        xlabel('Time (sec)');
        ylabel(accel_label);
        ylim([-ya ya]);    
else
    
        subplot(2,1,2);
        plot(t2,b);
        grid on;
        xlabel('Time (sec)');
        ylabel(accel_label);
        yLimits = get(gca,'YLim');
        ya=max(abs(yLimits));        
        ylim([-ya ya]);        
        
        subplot(2,1,1);
        plot(t1,a);
        grid on;
        ylabel(accel_label);
        title('Acceleration  top=first  bottom=second');
        ylim([-ya ya]);
%
 
end    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(fig_num);
fig_num=fig_num+1;

plot(t1,rd);
grid on;
xlabel('Time (sec)');
ylabel(rel_disp_label);
title('Relative Displacement');
yLimits = get(gca,'YLim');        
ya=max(abs(yLimits));
ylim([-ya ya]);


rel_disp=[ t1 rd ];
setappdata(0,'rel_disp',rel_disp);


amp=rd;
%
n=max(size(rd));
mu=mean(amp);
sd=std(amp);
mx=max(amp);
mi=min(amp);
rms=sqrt(sd^2+mu^2);
%
disp(' ');
disp(' Relative Displacement Statistics ');
disp(' ');
%
out0 = sprintf(' number of points = %d ',n);
out1 = sprintf(' mean = %8.4g    std = %8.4g    rms = %8.4g ',mu,sd,rms);
out2a = sprintf(' max  = %9.4g              ',mx);
out2b = sprintf(' min  = %9.4g            \n',mi);
disp(out0);
disp(out1);
disp(out2a);
disp(out2b);
%

set(handles.uipanel_save,'Visible','on');




% --- Executes on selection change in listbox_format.
function listbox_format_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_format contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_format

mn_common(hObject, eventdata, handles);
set(handles.uipanel_save,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_format_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_format (see GCBO)
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
set(handles.uipanel_save,'Visible','off');

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



function edit_input_array_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_input_array_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_order.
function listbox_order_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_order contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_order
set(handles.uipanel_save,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_order_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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

if(n==2)
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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'rel_disp');


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


% --- Executes on key press with focus on edit_input_array_1 and none of its controls.
function edit_input_array_1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_input_array_2 and none of its controls.
function edit_input_array_2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_2 (see GCBO)
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


% --- Executes on selection change in listbox_integration_2.
function listbox_integration_2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_integration_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_integration_2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_integration_2


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

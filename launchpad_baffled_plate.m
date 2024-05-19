function varargout = launchpad_baffled_plate(varargin)
% LAUNCHPAD_BAFFLED_PLATE MATLAB code for launchpad_baffled_plate.fig
%      LAUNCHPAD_BAFFLED_PLATE, by itself, creates a new LAUNCHPAD_BAFFLED_PLATE or raises the existing
%      singleton*.
%
%      H = LAUNCHPAD_BAFFLED_PLATE returns the handle to a new LAUNCHPAD_BAFFLED_PLATE or the handle to
%      the existing singleton*.
%
%      LAUNCHPAD_BAFFLED_PLATE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LAUNCHPAD_BAFFLED_PLATE.M with the given input arguments.
%
%      LAUNCHPAD_BAFFLED_PLATE('Property','Value',...) creates a new LAUNCHPAD_BAFFLED_PLATE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before launchpad_baffled_plate_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to launchpad_baffled_plate_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help launchpad_baffled_plate

% Last Modified by GUIDE v2.5 06-Jul-2021 14:33:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @launchpad_baffled_plate_OpeningFcn, ...
                   'gui_OutputFcn',  @launchpad_baffled_plate_OutputFcn, ...
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


% --- Executes just before launchpad_baffled_plate is made visible.
function launchpad_baffled_plate_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to launchpad_baffled_plate (see VARARGIN)

% Choose default command line output for launchpad_baffled_plate
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

listbox_mass_method_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes launchpad_baffled_plate wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = launchpad_baffled_plate_OutputFcn(hObject, eventdata, handles) 
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

disp(' ');
disp(' * * * * * * * *');
disp(' ');

fig_num=1;

try
   FS=strtrim(get(handles.edit_input_array,'String'));
   THM=evalin('base',FS); 
catch
   warndlg('input array not found');
   return;
end


f=THM(:,1);
dB=THM(:,2);

tstring='Launchpad';
n_type=1;


[fig_num]=spl_plot_title(fig_num,n_type,f,dB,tstring);

idamp=get(handles.listbox_damp,'Value');

if(idamp==1)

 ref=[   0.1000    0.4700
    0.2200    0.9600
    1.0000   19.6500
    7.8000   20.4500
  100.0000    1.6000];

else
    
  ref=[  0.1000    0.3300
    0.3000    1.0000
    1.0000   10.0000
    5.3000   10.0000
   51.2000    1.0000
  100.0000    0.5100];

end  


m=get(handles.listbox_mass_method,'Value');

area=str2num(get(handles.edit_area,'String'));

if(m==1)
    w_panel=str2num(get(handles.edit_w_panel,'String'));
    w_equip=str2num(get(handles.edit_w_equip,'String'));
    w=(w_panel+w_equip)/area;
else
    w=str2num(get(handles.edit_smd,'String'));    
end
    
fn=str2num(get(handles.edit_fn,'String'));


n=length(THM(:,1));
m=length(ref(:,1));

fratio=THM(:,1)/fn;

y=zeros(n,1);

for i=1:n
    
    x=fratio(i);
    
    
    if(x<=ref(1,1))
        y(i)=ref(1,2);
    end
    if(x>=ref(m,1))
        y(i)=ref(m,2);
    end    
    
    if(x>ref(1,1) && x<ref(m,1))
    
        for j=1:m-1
        
            if(x==ref(j,1))
                y(i)=ref(j,2);
                break;
            end
            if(x>ref(j,1) && x<ref(j+1,1))
                
                x1=ref(j,1);
                x2=ref(j+1,1);
                y1=ref(j,2);
                y2=ref(j+1,2);
                s=log10(y2/y1)/log10(x2/x1);
                y(i)=y1*(x/x1)^s;
                break;
            end
        end
    
    end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ic=get(handles.listbox_configuration,'Value');

if(ic==2)
    
    cref=[    0.0200    0.06
    0.0337    0.10
    0.0590    0.18
    0.1004    0.31
    0.1343    0.41
    0.1688    0.53
    0.1965    0.62
    0.2452    0.75
    0.3052    0.87
    0.3450    0.91
    0.3872    0.96
    0.4283    1.00
    0.5279    1.00
    0.6322    1.00
    0.7886    1.00
    1.0    1.00];

    m=length(cref(:,1));

    S=sqrt(area);
    
    c=13500;
    
    correction=zeros(n,1);
    
    for i=1:n
       
        lambda=c/THM(i,1);
        x=S/lambda;

        if(x<=cref(1,1))
            correction(i)=cref(1,2);
        end
        if(x>=cref(m,1))
            correction(i)=cref(m,2);
        end    
    
        if(x>cref(1,1) && x<cref(m,1))
    
            for j=1:m-1
        
                if(x==cref(j,1))
                    correction(i)=cref(j,2);
                    break;
                end
                if(x>cref(j,1) && x<cref(j+1,1))
                
                    x1=cref(j,1);
                    x2=cref(j+1,1);
                    y1=cref(j,2);
                    y2=cref(j+1,2);
                    ss=log10(y2/y1)/log10(x2/x1);
                    correction(i)=y1*(x/x1)^ss;
                    break;
                end
            end
    
        end        
        
%        out1=sprintf(' %8.3g %8.3g %8.3g %8.3g ',THM(i,1),lambda,x,correction(i));
%        disp(out1);
        
        
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fmax=str2num(get(handles.edit_fmax,'String'));

M=y;

apsd=zeros(n,2);
apsd(:,1)=THM(:,1);

qq=2^(1/6)-1/(2^(1/6));

ms=0;

zref=2.9e-09;

if(ic==1)
    outa=sprintf('    Freq  \t   SPL \t    press    \t  (f/fo)\t MA\t  accel \t accel PSD'  );
    outb=sprintf('    (Hz)  \t   (dB)\t   (psi rms) \t        \t   \t  (GRMS) \t (G^2/Hz) '); 
else
    outa=sprintf('    Freq  \t   SPL \t correction \t  correct press  \t  (f/fo)\t MA\t  accel \t accel PSD'  );
    outb=sprintf('    (Hz)  \t   (dB)\t  factor    \t    (psi rms)    \t        \t   \t  (GRMS) \t (G^2/Hz) ');     
end
    
disp(outa);
disp(outb);

for i=1:n 
    
   ppsi=zref*10^(THM(i,2)/20); 
    
   if(ic==2)
       ppsi=ppsi*correction(i);
   end   
   
   A=ppsi*M(i)/w;
   ms=ms+A^2;
   
   df=qq*THM(i,1);
   
   apsd(i,2)=A^2/df;
   
   if(ic==1)
      out1=sprintf(' %7.4g\t %7.1f\t %7.3g\t %6.3g\t %6.2f\t %7.3f\t %7.4g',apsd(i,1),THM(i,2),ppsi,apsd(i,1)/fn,M(i),A,apsd(i,2));
      disp(out1);
   else
      out1=sprintf(' %7.4g\t %7.1f\t %7.3g\t %7.3g\t %6.3g\t %6.2f\t %7.3f\t %7.4g',apsd(i,1),THM(i,2),correction(i),ppsi,apsd(i,1)/fn,M(i),A,apsd(i,2));
      disp(out1);       
   end
   
   if(apsd(i,1)>=fmax)
       apsd(i+1:n,:)=[];
       break;
   end
   
end

rms=sqrt(ms);

ppp=apsd;
[~,rms] = calculate_PSD_slopes_alt(ppp);


md=6;
x_label='Frequency (Hz)';
y_label='Accel (G^2/Hz)';

fmin=THM(1,1);
% fmax=THM(n,1);

t_string=sprintf('Power Spectral Density  %7.3g GRMS Overall',rms);

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);


setappdata(0,'apsd',apsd);

set(handles.uipanel_save,'Visible','on');

disp(' ');



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(launchpad_baffled_plate);


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


% --- Executes on selection change in listbox_damp.
function listbox_damp_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_damp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_damp contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_damp
set(handles.uipanel_save,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_damp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_damp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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



function edit_area_Callback(hObject, eventdata, handles)
% hObject    handle to edit_area (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_area as text
%        str2double(get(hObject,'String')) returns contents of edit_area as a double


% --- Executes during object creation, after setting all properties.
function edit_area_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_area (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_w_equip_Callback(hObject, eventdata, handles)
% hObject    handle to edit_w_equip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_w_equip as text
%        str2double(get(hObject,'String')) returns contents of edit_w_equip as a double


% --- Executes during object creation, after setting all properties.
function edit_w_equip_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_w_equip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_w_panel_Callback(hObject, eventdata, handles)
% hObject    handle to edit_w_panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_w_panel as text
%        str2double(get(hObject,'String')) returns contents of edit_w_panel as a double


% --- Executes during object creation, after setting all properties.
function edit_w_panel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_w_panel (see GCBO)
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

data=getappdata(0,'apsd');

output_name=get(handles.edit_output_array_name,'String');
assignin('base', output_name,data);

msgbox('Save Complete');

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


% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_fn and none of its controls.
function edit_fn_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_area and none of its controls.
function edit_area_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_area (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_w_panel and none of its controls.
function edit_w_panel_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_w_panel (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_w_equip and none of its controls.
function edit_w_equip_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_w_equip (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');



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


% --- Executes on selection change in listbox_configuration.
function listbox_configuration_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_configuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_configuration contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_configuration


% --- Executes during object creation, after setting all properties.
function listbox_configuration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_configuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_mass_method.
function listbox_mass_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_mass_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_mass_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_mass_method

m=get(handles.listbox_mass_method,'Value');

set(handles.edit_w_panel,'Visible','on');
set(handles.edit_w_equip,'Visible','on');
set(handles.edit_area,'Visible','on');
set(handles.text_area,'Visible','on');
set(handles.text_w_panel,'Visible','on');
set(handles.text_w_equip,'Visible','on');

set(handles.text_smd,'Visible','on');
set(handles.edit_smd,'Visible','on');

if(m==1)
    set(handles.text_smd,'Visible','off');
    set(handles.edit_smd,'Visible','off');
else
    set(handles.edit_w_panel,'Visible','off');
    set(handles.edit_w_equip,'Visible','off');
    set(handles.text_w_panel,'Visible','off');
    set(handles.text_w_equip,'Visible','off');    
end


% --- Executes during object creation, after setting all properties.
function listbox_mass_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_mass_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_smd_Callback(hObject, eventdata, handles)
% hObject    handle to edit_smd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_smd as text
%        str2double(get(hObject,'String')) returns contents of edit_smd as a double


% --- Executes during object creation, after setting all properties.
function edit_smd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_smd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function varargout = point_bridge_two_structures_multi(varargin)
% POINT_BRIDGE_TWO_STRUCTURES_MULTI MATLAB code for point_bridge_two_structures_multi.fig
%      POINT_BRIDGE_TWO_STRUCTURES_MULTI, by itself, creates a new POINT_BRIDGE_TWO_STRUCTURES_MULTI or raises the existing
%      singleton*.
%
%      H = POINT_BRIDGE_TWO_STRUCTURES_MULTI returns the handle to a new POINT_BRIDGE_TWO_STRUCTURES_MULTI or the handle to
%      the existing singleton*.
%
%      POINT_BRIDGE_TWO_STRUCTURES_MULTI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in POINT_BRIDGE_TWO_STRUCTURES_MULTI.M with the given input arguments.
%
%      POINT_BRIDGE_TWO_STRUCTURES_MULTI('Property','Value',...) creates a new POINT_BRIDGE_TWO_STRUCTURES_MULTI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before point_bridge_two_structures_multi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to point_bridge_two_structures_multi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help point_bridge_two_structures_multi

% Last Modified by GUIDE v2.5 30-Dec-2015 12:27:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @point_bridge_two_structures_multi_OpeningFcn, ...
                   'gui_OutputFcn',  @point_bridge_two_structures_multi_OutputFcn, ...
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


% --- Executes just before point_bridge_two_structures_multi is made visible.
function point_bridge_two_structures_multi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to point_bridge_two_structures_multi (see VARARGIN)

% Choose default command line output for point_bridge_two_structures_multi
handles.output = hObject;

listbox_units_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes point_bridge_two_structures_multi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = point_bridge_two_structures_multi_OutputFcn(hObject, eventdata, handles) 
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
delete(point_bridge_two_structures_multi);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tpi=2*pi;

try
    FS=get(handles.edit_input_array,'String');
    THM=evalin('base',FS);  

catch  
    warndlg('Input Array does not exist.  Try again.')
    return;
end

sz=size(THM);

if(sz(2)~=5)
   warndlg('Input array must have 5 columns');  
   return; 
end

iu=get(handles.listbox_units,'Value');
 
 f=THM(:,1);
 
Z1=THM(:,2);
Z2=THM(:,3);

n1=THM(:,4);
n2=THM(:,5);

fl=length(f);
omega=tpi*f;      
    

clf_12=zeros(fl,1);
clf_21=zeros(fl,1);   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:fl

    n_rad_1=n1(i)/tpi;
    n_rad_2=n2(i)/tpi;

    A1=2/(pi*omega(i)*n_rad_1);
    A2=2/(pi*omega(i)*n_rad_2);

    B=real(Z1(i))*real(Z2(i))/(  (abs(Z1(i)+Z2(i)))^2  );

    clf_12(i)=A1*B;
    clf_21(i)=A2*B;

end

    f=fix_size(f);
        
   
    x_label='Frequency (Hz)';
   
    
    fmin=min(f);
    fmax=max(f);
    
    clf_12=[f clf_12];
    clf_21=[f clf_21];        
    
    fig_num=1;
    md=3;
    
     t_string='Real Mechanical Impedance';
     if(iu==1)
        y_label='Z (lbf-sec/in)';
     else
        y_label='Z (N-sec/m)';         
     end
     leg1='subsystem 1';
     leg2='subsystem 2';
     ppp1=[f real(Z1)];
     ppp2=[f real(Z2)];
    
   [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);     
    
    
     t_string='Modal Density';
     y_label='Modal Density (modes/Hz)';
     leg1='subsystem 1';
     leg2='subsystem 2';
     ppp1=[f n1];
     ppp2=[f n2];
    
   [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);    
    
    
    t_string='Point Bridge, Two Structures, Coupling Loss Factors';
    y_label='Coupling Loss Factor';
    ppp1=clf_12;
    ppp2=clf_21;
    
    leg1='clf 12';
    leg2='clf 21';
    
   [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);
    
    
                    
    disp('  ');
    disp('  Freq(Hz)   clf_12    clf_21   ');
    disp('                                ');
                 
    for i=1:fl
        out1=sprintf(' %6.0f    %8.4g  %8.4g ',f(i),clf_12(i,2),clf_21(i,2));
        disp(out1);
    end
         
    disp(' ');
    disp(' Coupling Loss Factor Arrays: clf_12, clf_21');
    
    
    assignin('base','clf_12',clf_12); 
    assignin('base','clf_21',clf_21);       
    
msgbox('Results written to Command Window');





% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units


iu=get(handles.listbox_units,'Value');

if(iu==1)
   set(handles.text_Z1,'String','2. Subsystem 1  Impedance (lbf-sec/in)'); 
   set(handles.text_Z2,'String','3. Subsystem 2  Impedance (lbf-sec/in)');    
else
   set(handles.text_Z1,'String','2. Subsystem 1  Impedance (N-sec/m)'); 
   set(handles.text_Z2,'String','3. Subsystem 2  Impedance (N-sec/m)');    
end




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



function edit_Z1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Z1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Z1 as text
%        str2double(get(hObject,'String')) returns contents of edit_Z1 as a double


% --- Executes during object creation, after setting all properties.
function edit_Z1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Z1 (see GCBO)
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



function edit_n1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_n1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_n1 as text
%        str2double(get(hObject,'String')) returns contents of edit_n1 as a double


% --- Executes during object creation, after setting all properties.
function edit_n1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_n1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_n2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_n2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_n2 as text
%        str2double(get(hObject,'String')) returns contents of edit_n2 as a double


% --- Executes during object creation, after setting all properties.
function edit_n2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_n2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_clf_12_Callback(hObject, eventdata, handles)
% hObject    handle to edit_clf_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_clf_12 as text
%        str2double(get(hObject,'String')) returns contents of edit_clf_12 as a double


% --- Executes during object creation, after setting all properties.
function edit_clf_12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_clf_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_clf_21_Callback(hObject, eventdata, handles)
% hObject    handle to edit_clf_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_clf_21 as text
%        str2double(get(hObject,'String')) returns contents of edit_clf_21 as a double


% --- Executes during object creation, after setting all properties.
function edit_clf_21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_clf_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_freq and none of its controls.
function edit_freq_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_freq (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on key press with focus on edit_Z1 and none of its controls.
function edit_Z1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Z1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_n1 and none of its controls.
function edit_n1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_n1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_n2 and none of its controls.
function edit_n2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_n2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in pushbutton_eq.
function pushbutton_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

A = imread('point_bridge_clf.jpg');
figure(999) 
imshow(A,'border','tight','InitialMagnification',100) 


% --- Executes on selection change in listbox_band.
function listbox_band_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_band (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_band contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_band


% --- Executes during object creation, after setting all properties.
function listbox_band_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_band (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function varargout = clf_line_joint_plates_multi(varargin)
% CLF_LINE_JOINT_PLATES_MULTI MATLAB code for clf_line_joint_plates_multi.fig
%      CLF_LINE_JOINT_PLATES_MULTI, by itself, creates a new CLF_LINE_JOINT_PLATES_MULTI or raises the existing
%      singleton*.
%
%      H = CLF_LINE_JOINT_PLATES_MULTI returns the handle to a new CLF_LINE_JOINT_PLATES_MULTI or the handle to
%      the existing singleton*.
%
%      CLF_LINE_JOINT_PLATES_MULTI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CLF_LINE_JOINT_PLATES_MULTI.M with the given input arguments.
%
%      CLF_LINE_JOINT_PLATES_MULTI('Property','Value',...) creates a new CLF_LINE_JOINT_PLATES_MULTI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before clf_line_joint_plates_multi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to clf_line_joint_plates_multi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help clf_line_joint_plates_multi

% Last Modified by GUIDE v2.5 14-Nov-2017 15:41:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @clf_line_joint_plates_multi_OpeningFcn, ...
                   'gui_OutputFcn',  @clf_line_joint_plates_multi_OutputFcn, ...
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


% --- Executes just before clf_line_joint_plates_multi is made visible.
function clf_line_joint_plates_multi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to clf_line_joint_plates_multi (see VARARGIN)

% Choose default command line output for clf_line_joint_plates_multi
handles.output = hObject;

change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes clf_line_joint_plates_multi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = clf_line_joint_plates_multi_OutputFcn(hObject, eventdata, handles) 
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

delete(clf_line_joint_plates_multi);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


disp(' ');
disp(' * * * * ');
disp(' ');

tpi=2*pi;

iu=get(handles.listbox_units,'Value');


[~,fc,~,NL,fmin,fmax]=SEA_one_third_octave_frequencies_max_min();

nfc=length(fc);
f=fc;


  
E=str2num(get(handles.edit_em,'String'));
rho=str2num(get(handles.edit_md,'String'));
mu=str2num(get(handles.edit_mu,'String'));      


A1=str2num(get(handles.edit_area_1,'String'));
A2=str2num(get(handles.edit_area_2,'String'));     

h1=str2num(get(handles.edit_thickness_1,'String'));
h2=str2num(get(handles.edit_thickness_2,'String'));  


if(iu==1)
    rho=rho/386; 
else
    h1=h1/1000;
    h2=h2/1000;    
    [E]=GPa_to_Pa(E);
end

Lc=str2num(get(handles.edit_length,'String'));


%%%%%%%%%%%%%%%%%%%%%%%%

clf12=zeros(nfc,1);
clf21=zeros(nfc,1);


for i=1:nfc
    
    omega=tpi*f(i);

    [clf12(i),clf21(i),~,~]=line_joint_plates(E,rho,mu,h1,h2,A1,A2,omega,Lc);

end

clf_12=[f clf12];
clf_21=[f clf21];  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

fig_num=1;
x_label='Frequency (Hz)';
y_label='CLF';
t_string='Coupling Loss Factor between Two Plates with a Line Junction';

ppp1=clf_12;
ppp2=clf_21;
leg1='clf 12';
leg2='clf 21';


md=5;

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md)
%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('  ');
disp('  Freq(Hz)   clf_12    clf_21   ');
disp('                                ');
                 
for i=1:nfc
    out1=sprintf(' %6.0f  %8.4g  %8.4g ',f(i),clf12(i),clf21(i));
    disp(out1);
end
         
disp(' ');
disp(' Coupling Loss Factor Arrays: clf_12, clf_21');
        
assignin('base','clf_12',clf_12); 
assignin('base','clf_21',clf_21);  
       
    
msgbox('Results written to Command Window');




% --- Executes on button press in pushbutton_eq.
function pushbutton_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


A = imread('clf_line_joint_plates.jpg');
figure(999)  

imshow(A,'border','tight','InitialMagnification',100)  


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units
change(hObject, eventdata, handles);


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



function change(hObject, eventdata, handles)
%



iu=get(handles.listbox_units,'Value');
imat=get(handles.listbox_material,'Value');

if(iu==1)  % English
    set(handles.text_em,'String','Elastic Modulus (psi)');
    set(handles.text_md,'String','Mass Density (lbm/in^3)');   
    set(handles.text_length,'String','Line Length (in)');  
    set(handles.text_area_1,'String','Area (in^2)');  
    set(handles.text_area_2,'String','Area (in^2)');  
    set(handles.text_thickness_1,'String','Thickness (in)');  
    set(handles.text_thickness_2,'String','Thickness (in)');  
else
    set(handles.text_em,'String','Elastic Modulus (GPa)');
    set(handles.text_md,'String','Mass Density (kg/m^3)');     
    set(handles.text_length,'String','Line Length (m)');   
    set(handles.text_area_1,'String','Area (m^2)');  
    set(handles.text_area_2,'String','Area (m^2)');  
    set(handles.text_thickness_1,'String','Thickness (mm)');  
    set(handles.text_thickness_2,'String','Thickness (mm)');    
end


%%%%

[elastic_modulus,mass_density,poisson]=six_materials(iu,imat);
 
%%%%
 
 
if(imat<=6)
        ss1=sprintf('%8.4g',elastic_modulus);
        ss2=sprintf('%8.4g',mass_density);
        ss3=sprintf('%8.4g',poisson);
else
        ss1=' ';
        ss2=' ';
        ss3=' ';        
end
 
set(handles.edit_em,'String',ss1);
set(handles.edit_md,'String',ss2); 
set(handles.edit_mu,'String',ss3);



% --- Executes on selection change in listbox_material.
function listbox_material_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_material
change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_em_Callback(hObject, eventdata, handles)
% hObject    handle to edit_em (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_em as text
%        str2double(get(hObject,'String')) returns contents of edit_em as a double


% --- Executes during object creation, after setting all properties.
function edit_em_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_em (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_md_Callback(hObject, eventdata, handles)
% hObject    handle to edit_md (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_md as text
%        str2double(get(hObject,'String')) returns contents of edit_md as a double


% --- Executes during object creation, after setting all properties.
function edit_md_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_md (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mu_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mu as text
%        str2double(get(hObject,'String')) returns contents of edit_mu as a double


% --- Executes during object creation, after setting all properties.
function edit_mu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_length_Callback(hObject, eventdata, handles)
% hObject    handle to edit_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_length as text
%        str2double(get(hObject,'String')) returns contents of edit_length as a double


% --- Executes during object creation, after setting all properties.
function edit_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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



function edit_area_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_area_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_area_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_area_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_area_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_area_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thickness_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thickness_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thickness_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_thickness_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_thickness_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thickness_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_area_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_area_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_area_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_area_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_area_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_area_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thickness_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thickness_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thickness_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_thickness_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_thickness_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thickness_2 (see GCBO)
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



% --- Executes on key press with focus on edit_mu and none of its controls.
function edit_mu_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_mu (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_em and none of its controls.
function edit_em_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_em (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_md and none of its controls.
function edit_md_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_md (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_length and none of its controls.
function edit_length_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_length (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_area_1 and none of its controls.
function edit_area_1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_area_1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_thickness_1 and none of its controls.
function edit_thickness_1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_thickness_1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_area_2 and none of its controls.
function edit_area_2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_area_2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_thickness_2 and none of its controls.
function edit_thickness_2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_thickness_2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)




function edit_clf12_Callback(hObject, eventdata, handles)
% hObject    handle to edit_clf12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_clf12 as text
%        str2double(get(hObject,'String')) returns contents of edit_clf12 as a double


% --- Executes during object creation, after setting all properties.
function edit_clf12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_clf12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_clf21_Callback(hObject, eventdata, handles)
% hObject    handle to edit_clf21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_clf21 as text
%        str2double(get(hObject,'String')) returns contents of edit_clf21 as a double


% --- Executes during object creation, after setting all properties.
function edit_clf21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_clf21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

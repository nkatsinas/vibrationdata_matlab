function varargout = unstiffened_cylinder_modal_density(varargin)
% UNSTIFFENED_CYLINDER_MODAL_DENSITY MATLAB code for unstiffened_cylinder_modal_density.fig
%      UNSTIFFENED_CYLINDER_MODAL_DENSITY, by itself, creates a new UNSTIFFENED_CYLINDER_MODAL_DENSITY or raises the existing
%      singleton*.
%
%      H = UNSTIFFENED_CYLINDER_MODAL_DENSITY returns the handle to a new UNSTIFFENED_CYLINDER_MODAL_DENSITY or the handle to
%      the existing singleton*.
%
%      UNSTIFFENED_CYLINDER_MODAL_DENSITY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNSTIFFENED_CYLINDER_MODAL_DENSITY.M with the given input arguments.
%
%      UNSTIFFENED_CYLINDER_MODAL_DENSITY('Property','Value',...) creates a new UNSTIFFENED_CYLINDER_MODAL_DENSITY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before unstiffened_cylinder_modal_density_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to unstiffened_cylinder_modal_density_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help unstiffened_cylinder_modal_density

% Last Modified by GUIDE v2.5 29-May-2022 19:07:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @unstiffened_cylinder_modal_density_OpeningFcn, ...
                   'gui_OutputFcn',  @unstiffened_cylinder_modal_density_OutputFcn, ...
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


% --- Executes just before unstiffened_cylinder_modal_density is made visible.
function unstiffened_cylinder_modal_density_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to unstiffened_cylinder_modal_density (see VARARGIN)

% Choose default command line output for unstiffened_cylinder_modal_density
handles.output = hObject;

change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes unstiffened_cylinder_modal_density wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = unstiffened_cylinder_modal_density_OutputFcn(hObject, eventdata, handles) 
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

delete(unstiffened_cylinder_modal_density);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


tpi=2*pi;


iu=get(handles.listbox_units,'Value');

imat=get(handles.listbox_material,'Value');


em=str2num(get(handles.edit_em,'String'));
md=str2num(get(handles.edit_md,'String'));


SL = get(handles.edit_L, 'String');
if isempty(SL)
  warndlg('Enter Length');  
  return;
else
    L=str2num(SL);  
end

Sdiam = get(handles.edit_diameter, 'String');
if isempty(Sdiam)
  warndlg('Enter Diameter');  
  return;
else
    d=str2num(Sdiam);  
end


Sthick = get(handles.edit_thickness, 'String');
if isempty(Sthick)
  warndlg('Enter Thickness');  
  return;
else
    t=str2num(Sthick);  
end


if(iu==1)
    md=md/386;    
    su='in/sec';
else
    [em]=GPa_to_Pa(em);
    t=t/1000;
    su='m/sec';
end

[fr,CL]=ring_frequency_I(em,md,d);

[~,fc,~,NL,fmin,fmax]=SEA_one_third_octave_frequencies_max_min();

f=fc;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

mph=zeros(NL,1);

for i=1:NL
    
    [mph(i)] = cylinder_mdens(f(i),fr,L,t);
    
end        

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp('* * * *');

disp(' ');
disp(' Unstiffened Cylindrical Shell');

out1=sprintf('\n Speed of Sound = %8.4g %s',CL,su);
disp(out1);

out1=sprintf('\n Ring Frequency = %8.4g Hz',fr);
disp(out1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    f=fix_size(f);
    mph=fix_size(mph);    
    
    figure(1);
    plot(f,mph);
    title('Unstiffened Cylinder Modal Density');
   
    xlabel('Frequency (Hz)');
    ylabel('Modal Density (modes/Hz)');
    
    [xtt,xTT,iflag]=xtick_label(fmin,fmax);

    if(iflag==1)
        set(gca,'xtick',xtt);
        set(gca,'XTickLabel',xTT);
    end    
    
    ymin=10^(floor(log10(min(mph))));
    ymax=10^(ceil(log10(max(mph))));
   
    xlim([20,20000]);
    ylim([ ymin,ymax]);
    
    set(gca,'XGrid','on','GridLineStyle',':');
    set(gca,'YGrid','on','GridLineStyle',':');    
    
    set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');   
                 
                 
    disp(' ');
    disp('  One-third Octave ');
    disp('  ');
    disp('  Center  Modal ');
    disp('  Freq    Density ');
    disp('  (Hz)    (modes/Hz) ');
                 
    for i=1:length(f)
        out1=sprintf(' %6.0f  %8.4g',f(i),mph(i));
        disp(out1);
    end
    
    modal_density=[f mph];
    
    disp(' ');
    disp(' Modal density array saved to:  modal_density ');
    assignin('base', 'modal_density', modal_density); 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');

msgbox('Results written to Command Window');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




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


% --- Executes on selection change in listbox_structure.
function listbox_structure_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_structure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_structure contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_structure

change(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_structure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_structure (see GCBO)
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

%%%

set(handles.text_material,'Visible','on');
set(handles.listbox_material,'Visible','on');

set(handles.text_em,'Visible','on');
set(handles.text_md,'Visible','on');
set(handles.text_mu,'Visible','on');

set(handles.edit_em,'Visible','on');
set(handles.edit_md,'Visible','on');
set(handles.edit_mu,'Visible','on');


set(handles.edit_thickness,'Visible','on'); 
set(handles.text_thickness,'Visible','on'); 

set(handles.text_L,'Visible','on');
set(handles.edit_L,'Visible','on');   


if(iu==1)  % English
    set(handles.text_L,'String','Length (in)');   
    set(handles.text_diameter,'String','Diameter (in)');    
    set(handles.text_thickness,'String','Thickness (in)');     
    set(handles.text_em,'String','Elastic Modulus (psi)');
    set(handles.text_md,'String','Mass Density (lbm/in^3)');     
else
    set(handles.text_L,'String','Length (m)');   
    set(handles.text_diameter,'String','Diameter (m)');       
    set(handles.text_thickness,'String','Thickness (mm)');    
    set(handles.text_em,'String','Elastic Modulus (GPa)');
    set(handles.text_md,'String','Mass Density (kg/m^3)');      
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

%%%



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



function edit_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_L as text
%        str2double(get(hObject,'String')) returns contents of edit_L as a double


% --- Executes during object creation, after setting all properties.
function edit_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_speed_Callback(hObject, eventdata, handles)
% hObject    handle to edit_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_speed as text
%        str2double(get(hObject,'String')) returns contents of edit_speed as a double


% --- Executes during object creation, after setting all properties.
function edit_speed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit_thickness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thickness as text
%        str2double(get(hObject,'String')) returns contents of edit_thickness as a double


% --- Executes during object creation, after setting all properties.
function edit_thickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_H_Callback(hObject, eventdata, handles)
% hObject    handle to edit_H (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_H as text
%        str2double(get(hObject,'String')) returns contents of edit_H as a double


% --- Executes during object creation, after setting all properties.
function edit_H_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_H (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_diameter_Callback(hObject, eventdata, handles)
% hObject    handle to edit_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_diameter as text
%        str2double(get(hObject,'String')) returns contents of edit_diameter as a double


% --- Executes during object creation, after setting all properties.
function edit_diameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_eq.
function pushbutton_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

A = imread('Cylinder_md.jpg');
    figure(998) 
    imshow(A,'border','tight','InitialMagnification',100)


% --- Executes on button press in pushbutton_wave.
function pushbutton_wave_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_wave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cylinder_fn_a;

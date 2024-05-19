function varargout = power_input_from_force_panel_beam_stiffened(varargin)
% POWER_INPUT_FROM_FORCE_PANEL_BEAM_STIFFENED MATLAB code for power_input_from_force_panel_beam_stiffened.fig
%      POWER_INPUT_FROM_FORCE_PANEL_BEAM_STIFFENED, by itself, creates a new POWER_INPUT_FROM_FORCE_PANEL_BEAM_STIFFENED or raises the existing
%      singleton*.
%
%      H = POWER_INPUT_FROM_FORCE_PANEL_BEAM_STIFFENED returns the handle to a new POWER_INPUT_FROM_FORCE_PANEL_BEAM_STIFFENED or the handle to
%      the existing singleton*.
%
%      POWER_INPUT_FROM_FORCE_PANEL_BEAM_STIFFENED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in POWER_INPUT_FROM_FORCE_PANEL_BEAM_STIFFENED.M with the given input arguments.
%
%      POWER_INPUT_FROM_FORCE_PANEL_BEAM_STIFFENED('Property','Value',...) creates a new POWER_INPUT_FROM_FORCE_PANEL_BEAM_STIFFENED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before power_input_from_force_panel_beam_stiffened_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to power_input_from_force_panel_beam_stiffened_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help power_input_from_force_panel_beam_stiffened

% Last Modified by GUIDE v2.5 15-Dec-2015 11:27:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @power_input_from_force_panel_beam_stiffened_OpeningFcn, ...
                   'gui_OutputFcn',  @power_input_from_force_panel_beam_stiffened_OutputFcn, ...
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


% --- Executes just before power_input_from_force_panel_beam_stiffened is made visible.
function power_input_from_force_panel_beam_stiffened_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to power_input_from_force_panel_beam_stiffened (see VARARGIN)

% Choose default command line output for power_input_from_force_panel_beam_stiffened
handles.output = hObject;

change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes power_input_from_force_panel_beam_stiffened wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = power_input_from_force_panel_beam_stiffened_OutputFcn(hObject, eventdata, handles) 
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

delete(power_input_from_force_panel_beam_stiffened);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tpi=2*pi;

iu=get(handles.listbox_units,'Value');

disp(' ');
disp(' * * * ');
disp('  ');
disp(' Panel with Beam Stiffeners '); 
disp('  ');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

em=str2num(get(handles.edit_em,'String'));
md=str2num(get(handles.edit_md,'String'));
mu=str2num(get(handles.edit_mu,'String'));
F=str2num(get(handles.edit_F,'String'));
freq=str2num(get(handles.edit_freq,'String'));


panel_thick=str2num(get(handles.edit_panel_thick,'String'));
panel_length=str2num(get(handles.edit_panel_length,'String'));
panel_width=str2num(get(handles.edit_panel_width,'String'));



if(iu==1)
    md=md/386;
else
    [em]=GPa_to_Pa(em);   
    panel_thick=panel_thick/1000;
end

A=panel_length*panel_width;
H=panel_thick;

Cp=sqrt(em/(md*(1-mu^2)));

panel_md= sqrt(3)*A/(Cp*H); 

M_panel=A*H*md;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  beam

nc=get(handles.listbox_cross,'Value');

em_beam=str2num(get(handles.edit_beam_em,'String'));
md_beam=str2num(get(handles.edit_beam_md,'String'));
L_beam=str2num(get(handles.edit_beam_length,'String'));

if(iu==1)
    md_beam=md_beam/386;
else
    em_beam=em_beam*1.0e+09;   
end


if(nc==1)  % rectangular cross section
 
    W_beam=str2num(get(handles.edit_beam_width,'String'));
    H_beam=str2num(get(handles.edit_beam_height,'String'));    
    
    if(iu==2)
        W_beam=W_beam/1000;
        H_beam=H_beam/1000;
    end
        
    A_beam=W_beam*H_beam;
    MOI_beam=(1/12)*W_beam*H_beam^3;   
    
else  % other cross section
    
    A_beam=str2num(get(handles.edit_cs_area,'String'));
    MOI_beam=str2num(get(handles.edit_MOI,'String'));   
 
   if(iu==2)  
      A_beam=A_beam/1000^2;
      MOI_beam=MOI_beam/1000^4;
   end
end

freq=str2num(get(handles.edit_freq,'String'));

M_beam=md_beam*A_beam*L_beam;

 
[beam_md,cbeam]=...
       sea_beam_modal_density(MOI_beam,A_beam,em_beam,md_beam,freq,L_beam);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tmd=panel_md+beam_md;

YR=tmd/(4*(M_panel+M_beam));  % add beam

P=F^2*YR;

out1=sprintf(' Panel modal density = %8.4g (modes/Hz)',panel_md);
out2=sprintf(' Beam  modal density = %8.4g (modes/Hz)',beam_md);
out3=sprintf(' Total modal density = %8.4g (modes/Hz)',tmd);

disp(out1);
disp(out2);
disp(out3);
disp(' ');

if(iu==1)
    out1=sprintf(' Real Mobility = %8.4g (in/sec)/lbf',YR);
    out2=sprintf(' Power Flow = %8.4g in-lbf/sec',P);
    out3=sprintf('            = %8.4g ft-lbf/sec',P/12);    
else
    out1=sprintf(' Real Mobility = %8.4g (m/sec)/N',YR);    
    out2=sprintf(' Power Flow = %8.4g W',P);    
end    
    
disp(out1);
disp(' ');
disp(out2);

if(iu==1)
    disp(out3);
end

disp(' ');

msgbox('Results written to command window');



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

function change(hObject, eventdata, handles)
%
iu=get(handles.listbox_units,'Value');

imat=get(handles.listbox_material,'Value');

if(iu==1)  % English   
    
    set(handles.text_em,'String','Elastic Modulus (psi)');
    set(handles.text_md,'String','Mass Density (lbm/in^3)'); 
    set(handles.text_F,'String','Driving Point Force (lbf rms)'); 
    
    set(handles.text_panel_thick,'String','Panel Thickness (in)');
    set(handles.text_panel_length,'String','Panel Length (in)');
    set(handles.text_panel_width,'String','Panel Width (in)');
    
    set(handles.text_beam_em,'String','Elastic Modulus (psi)');
    set(handles.text_beam_md,'String','Mass Density (lbm/in^3)'); 
    set(handles.text_beam_length,'String','Total Beam Length (in)');
    set(handles.text_beam_width,'String','Beam Width (in)');
    set(handles.text_beam_height,'String','Beam Height (in)');
    set(handles.text_cs_area,'String','Cross Section Area (in^2)');
    set(handles.text_MOI,'String','Moment of Inertia (in^4)');
    
else
    
    set(handles.text_em,'String','Elastic Modulus (GPa)');
    set(handles.text_md,'String','Mass Density (kg/m^3)');          
    set(handles.text_F,'String','Driving Point Force (N rms)');
    
    set(handles.text_panel_thick,'String','Panel Thickness (mm)');
    set(handles.text_panel_length,'String','Panel Length (m)');
    set(handles.text_panel_width,'String','Panel Width (m)');    
    
    set(handles.text_beam_em,'String','Elastic Modulus (GPa)');
    set(handles.text_beam_md,'String','Mass Density (kg/m^3)'); 
    set(handles.text_beam_length,'String','Total Beam Length (m)');
    set(handles.text_beam_width,'String','Beam Width (mm)');
    set(handles.text_beam_height,'String','Beam Height (mm)');
    set(handles.text_cs_area,'String','Cross Section Area (mm^2)');
    set(handles.text_MOI,'String','Moment of Inertia (mm^4)');    
    
    
end

%%%%%%%%%%%%%%   

    if(iu==1)  % English
        if(imat==1) % aluminum
            elastic_modulus=1e+007;
            mass_density=0.1;  
        end  
        if(imat==2)  % steel
            elastic_modulus=3e+007;
            mass_density= 0.28;         
        end
        if(imat==3)  % copper
            elastic_modulus=1.6e+007;
            mass_density=  0.322;
        end
        if(imat==4)  % G10
            elastic_modulus=2.7e+006;
            mass_density=  0.065;
        end
    else                 % metric
        if(imat==1)  % aluminum
            elastic_modulus=70;
            mass_density=  2700;
        end
        if(imat==2)  % steel
            elastic_modulus=205;
            mass_density=  7700;        
        end
        if(imat==3)   % copper
            elastic_modulus=110;
            mass_density=  8900;
        end
        if(imat==4)  % G10
            elastic_modulus=18.6;
            mass_density=  1800;
        end
    end
        
%%%%%%%%%%%%%%    
    
    if(imat==1) % aluminum
        poisson=0.33;  
    end  
    if(imat==2)  % steel
        poisson= 0.30;         
    end
    if(imat==3)  % copper
        poisson=  0.33;
    end
    if(imat==4)  % G10
        poisson=  0.12;
    end    
    
%%%%%%%%%%%%%%

    if(imat<5)
        ss1=sprintf('%8.4g',elastic_modulus);
        ss2=sprintf('%8.4g',mass_density);
        ss3=sprintf('%8.4g',poisson);  
 
        set(handles.edit_em,'String',ss1);
        set(handles.edit_md,'String',ss2);    
        set(handles.edit_mu,'String',ss3); 
        
    end

%%%%%%%%%%%%%%    

    if(imat==5)
        set(handles.edit_em,'String',' ');
        set(handles.edit_md,'String',' ');  
        set(handles.edit_mu,'String',' ');         
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%             
%    
% beam    
%    
imat_beam=get(handles.listbox_beam_material,'Value');    
    
    if(iu==1)  % English
        if(imat_beam==1) % aluminum
            elastic_modulus=1e+007;
            mass_density=0.1;  
        end  
        if(imat_beam==2)  % steel
            elastic_modulus=3e+007;
            mass_density= 0.28;         
        end
        if(imat_beam==3)  % copper
            elastic_modulus=1.6e+007;
            mass_density=  0.322;
        end
        if(imat_beam==4)  % G10
            elastic_modulus=2.7e+006;
            mass_density=  0.065;
        end
    else                 % metric
        if(imat_beam==1)  % aluminum
            elastic_modulus=70;
            mass_density=  2700;
        end
        if(imat_beam==2)  % steel
            elastic_modulus=205;
            mass_density=  7700;        
        end
        if(imat_beam==3)   % copper
            elastic_modulus=110;
            mass_density=  8900;
        end
        if(imat_beam==4)  % G10
            elastic_modulus=18.6;
            mass_density=  1800;
        end
    end
        
    if(imat<5)
        ss1=sprintf('%8.4g',elastic_modulus);
        ss2=sprintf('%8.4g',mass_density);
  
 
        set(handles.edit_beam_em,'String',ss1);
        set(handles.edit_beam_md,'String',ss2);    
        
    end
 
%%%%%%%%%%%%%%    
 
    if(imat_beam==5)
        set(handles.edit_beam_em,'String',' ');
        set(handles.edit_beam_md,'String',' ');          
    end

    nc=get(handles.listbox_cross,'Value');
    
    set(handles.edit_beam_width,'Visible','off');
    set(handles.edit_beam_height,'Visible','off');
    set(handles.text_beam_width,'Visible','off');
    set(handles.text_beam_height,'Visible','off');    
    
    set(handles.edit_cs_area,'Visible','off');
    set(handles.edit_MOI,'Visible','off');
    set(handles.text_cs_area,'Visible','off');
    set(handles.text_MOI,'Visible','off');   
    
    if(nc==1)
        set(handles.edit_beam_width,'Visible','on');
        set(handles.edit_beam_height,'Visible','on');
        set(handles.text_beam_width,'Visible','on');
        set(handles.text_beam_height,'Visible','on');         
    else
        set(handles.edit_cs_area,'Visible','on');
        set(handles.edit_MOI,'Visible','on');
        set(handles.text_cs_area,'Visible','on');
        set(handles.text_MOI,'Visible','on');        
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
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



function edit_F_Callback(hObject, eventdata, handles)
% hObject    handle to edit_F (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_F as text
%        str2double(get(hObject,'String')) returns contents of edit_F as a double


% --- Executes during object creation, after setting all properties.
function edit_F_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_F (see GCBO)
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


% --- Executes on selection change in listbox_cross.
function listbox_cross_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_cross (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_cross contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_cross
change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_cross_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_cross (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_width_Callback(hObject, eventdata, handles)
% hObject    handle to edit_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_width as text
%        str2double(get(hObject,'String')) returns contents of edit_width as a double


% --- Executes during object creation, after setting all properties.
function edit_width_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_width (see GCBO)
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



function edit_r1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_r1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_r1 as text
%        str2double(get(hObject,'String')) returns contents of edit_r1 as a double


% --- Executes during object creation, after setting all properties.
function edit_r1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_r1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_r2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_r2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_r2 as text
%        str2double(get(hObject,'String')) returns contents of edit_r2 as a double


% --- Executes during object creation, after setting all properties.
function edit_r2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_r2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_I_Callback(hObject, eventdata, handles)
% hObject    handle to edit_I (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_I as text
%        str2double(get(hObject,'String')) returns contents of edit_I as a double


% --- Executes during object creation, after setting all properties.
function edit_I_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_I (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_mass as a double


% --- Executes during object creation, after setting all properties.
function edit_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mdens_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mdens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mdens as text
%        str2double(get(hObject,'String')) returns contents of edit_mdens as a double


% --- Executes during object creation, after setting all properties.
function edit_mdens_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mdens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_panel_thick_Callback(hObject, eventdata, handles)
% hObject    handle to edit_panel_thick (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_panel_thick as text
%        str2double(get(hObject,'String')) returns contents of edit_panel_thick as a double


% --- Executes during object creation, after setting all properties.
function edit_panel_thick_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_panel_thick (see GCBO)
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


% --- Executes on selection change in listbox_beam_material.
function listbox_beam_material_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_beam_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_beam_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_beam_material
change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_beam_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_beam_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_beam_em_Callback(hObject, eventdata, handles)
% hObject    handle to edit_beam_em (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_beam_em as text
%        str2double(get(hObject,'String')) returns contents of edit_beam_em as a double


% --- Executes during object creation, after setting all properties.
function edit_beam_em_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_beam_em (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_beam_md_Callback(hObject, eventdata, handles)
% hObject    handle to edit_beam_md (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_beam_md as text
%        str2double(get(hObject,'String')) returns contents of edit_beam_md as a double


% --- Executes during object creation, after setting all properties.
function edit_beam_md_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_beam_md (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_cross.
function listbox6_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_cross (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_cross contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_cross


% --- Executes during object creation, after setting all properties.
function listbox6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_cross (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_beam_width_Callback(hObject, eventdata, handles)
% hObject    handle to edit_beam_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_beam_width as text
%        str2double(get(hObject,'String')) returns contents of edit_beam_width as a double


% --- Executes during object creation, after setting all properties.
function edit_beam_width_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_beam_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_beam_height_Callback(hObject, eventdata, handles)
% hObject    handle to edit_beam_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_beam_height as text
%        str2double(get(hObject,'String')) returns contents of edit_beam_height as a double


% --- Executes during object creation, after setting all properties.
function edit_beam_height_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_beam_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_cs_area_Callback(hObject, eventdata, handles)
% hObject    handle to edit_cs_area (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_cs_area as text
%        str2double(get(hObject,'String')) returns contents of edit_cs_area as a double


% --- Executes during object creation, after setting all properties.
function edit_cs_area_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_cs_area (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_MOI_Callback(hObject, eventdata, handles)
% hObject    handle to edit_MOI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_MOI as text
%        str2double(get(hObject,'String')) returns contents of edit_MOI as a double


% --- Executes during object creation, after setting all properties.
function edit_MOI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_MOI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_beam_length_Callback(hObject, eventdata, handles)
% hObject    handle to edit_beam_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_beam_length as text
%        str2double(get(hObject,'String')) returns contents of edit_beam_length as a double


% --- Executes during object creation, after setting all properties.
function edit_beam_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_beam_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_panel_length_Callback(hObject, eventdata, handles)
% hObject    handle to edit_panel_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_panel_length as text
%        str2double(get(hObject,'String')) returns contents of edit_panel_length as a double


% --- Executes during object creation, after setting all properties.
function edit_panel_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_panel_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_panel_width_Callback(hObject, eventdata, handles)
% hObject    handle to edit_panel_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_panel_width as text
%        str2double(get(hObject,'String')) returns contents of edit_panel_width as a double


% --- Executes during object creation, after setting all properties.
function edit_panel_width_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_panel_width (see GCBO)
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

    A = imread('panel_beam_stiffened_power.jpg');
    figure(999) 
    imshow(A,'border','tight','InitialMagnification',100) 

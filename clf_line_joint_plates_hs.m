function varargout = clf_line_joint_plates_hs(varargin)
% CLF_LINE_JOINT_PLATES_HS MATLAB code for clf_line_joint_plates_hs.fig
%      CLF_LINE_JOINT_PLATES_HS, by itself, creates a new CLF_LINE_JOINT_PLATES_HS or raises the existing
%      singleton*.
%
%      H = CLF_LINE_JOINT_PLATES_HS returns the handle to a new CLF_LINE_JOINT_PLATES_HS or the handle to
%      the existing singleton*.
%
%      CLF_LINE_JOINT_PLATES_HS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CLF_LINE_JOINT_PLATES_HS.M with the given input arguments.
%
%      CLF_LINE_JOINT_PLATES_HS('Property','Value',...) creates a new CLF_LINE_JOINT_PLATES_HS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before clf_line_joint_plates_hs_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to clf_line_joint_plates_hs_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help clf_line_joint_plates_hs

% Last Modified by GUIDE v2.5 14-Nov-2017 17:02:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @clf_line_joint_plates_hs_OpeningFcn, ...
                   'gui_OutputFcn',  @clf_line_joint_plates_hs_OutputFcn, ...
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


% --- Executes just before clf_line_joint_plates_hs is made visible.
function clf_line_joint_plates_hs_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to clf_line_joint_plates_hs (see VARARGIN)

% Choose default command line output for clf_line_joint_plates_hs
handles.output = hObject;

change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes clf_line_joint_plates_hs wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = clf_line_joint_plates_hs_OutputFcn(hObject, eventdata, handles) 
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

delete(clf_line_joint_plates_hs);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tpi=2*pi;

disp(' ');
disp(' * * * ');
disp('  ');

 % honeycomb sandwich   

iu=get(handles.listbox_units,'Value');

setappdata(0,'iu',iu);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

G=str2num(get(handles.edit_core_G,'String'));

em=str2num(get(handles.edit_em,'String'));
md=str2num(get(handles.edit_md,'String'));
mu=str2num(get(handles.edit_mu,'String')); 

c=str2num(get(handles.edit_c,'String')); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(iu==1)
    md=md/386;
    c=c*12;
    su='in/sec';
else    
    [em]=GPa_to_Pa(em);
    [G]=GPa_to_Pa(G);
    su='m/sec';
end
    
A1=str2num(get(handles.edit_area_1,'String'));
A2=str2num(get(handles.edit_area_2,'String'));

Lc=str2num(get(handles.edit_length,'String'));    


    md_core=str2num(get(handles.edit_md_core,'String')); 
    
    hc=str2num(get(handles.edit_h,'String'));
    
    tf=str2num(get(handles.edit_fct,'String'));
    
    if(iu==1)
        md_core=md_core/386;
    else
        hc=hc/1000;
        tf=tf/1000;
    end
    
    h=hc;
    
    [fcr,rho,D,N,~,kflag]=cylinder_sandwich_fcr(md,md_core,tf,h,em,mu,G,c);
    
    [f1,f2]=shear_frequencies(em,G,mu,tf,hc,md,md_core);
    
    if(kflag==1)
        
        msgbox('Critical frequency does not exist for this case.');
        return;
    end
         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [~,fc,~,NL,fmin,fmax]=SEA_one_third_octave_frequencies_max_min(); 

fc=str2num(get(handles.edit_freq,'String'));


v=mu;
E=em;
[B,~,~,mpa]=honeycomb_sandwich_properties(E,G,v,tf,hc,md,md_core);
[Bf]=flexural_rigidity(E,tf,v);


omega=tpi*fc;

[clf12,clf21,cg]=sandwich_panel_line(omega,B,Bf,G,mpa,hc,Lc,A1,A2);


disp(' ');
if(iu==1)
    out1=sprintf(' Group speed  cg= %8.4g in/sec',cg);
else
    out1=sprintf(' Group speed  cg= %8.4g m/sec',cg);    
end
disp(out1);

disp(' ');
out1=sprintf(' Critical Frequency  fcr= %8.4g Hz',fcr);
disp(out1);

disp(' ');
out1=sprintf(' Shear Transition Frequencies \n  f1= %8.4g Hz   f2=%8.4g',f1,f2);
disp(out1);

disp(' ');
disp(' Coupling Loss Factors ');
disp(' ');
out1=sprintf('  clf 12 = %8.3g',clf12);
out2=sprintf('  clf 21 = %8.3g',clf21);

disp(out1);
disp(out2);

s1=sprintf('%8.3g',clf12);
s2=sprintf('%8.3g',clf21);


set(handles.edit_clf12,'String',s1);
set(handles.edit_clf21,'String',s2);

set(handles.uipanel_results,'Visible','on');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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


function change(hObject, eventdata, handles)
%

set(handles.uipanel_results,'Visible','off');

iu=get(handles.listbox_units,'Value');

imat=get(handles.listbox_material,'Value');

ng=get(handles.listbox_gas,'Value');

%%%


set(handles.text_material,'String','Select Material');


% honeycomb sandwich

    set(handles.text_material,'String','Select Face Sheet Material');
    
    set(handles.text_h,'Visible','on');
    set(handles.edit_h,'Visible','on');
    set(handles.text_fct,'Visible','on');
    set(handles.edit_fct,'Visible','on');
    set(handles.text_md_core,'Visible','on');
    set(handles.edit_md_core,'Visible','on');    

    
    if(iu==1)
        
        set(handles.text_area_1,'String','Panel 1 Area (in^2)');
        set(handles.text_area_2,'String','Panel 2 Area (in^2)');
        
        set(handles.text_length,'String','Junction Length (in)');
        set(handles.text_em,'String','Face Sheet Elastic Modulus (psi)');
        set(handles.text_md,'String','Face Sheet Mass Density (lbm/in^3)');        
     
        set(handles.text_gas_c,'String','Gas Speed of Sound (ft/sec)'); 
    
        set(handles.text_core_G,'String','Shear Modulus (psi)');         
        set(handles.text_h,'String','Core Thickness (in)');
        set(handles.text_fct,'String','Individual Face Sheet Thickness (in)');
        set(handles.text_md_core,'String','Core Mass Density (lbm/in^3)');
        
    else
        
        set(handles.text_area_1,'String','Panel 1 Area (m^2)');
        set(handles.text_area_2,'String','Panel 2 Area (m^2)');        
        
        set(handles.text_length,'String','Junction Length (m)');        
        set(handles.text_em,'String','Face Sheet Elastic Modulus (GPa)');
        set(handles.text_md,'String','Face Sheet Mass Density (kg/m^3)');       

        set(handles.text_gas_c,'String','Gas Speed of Sound (m/sec)');
    
        set(handles.text_core_G,'String','Shear Modulus (GPa)');       
        set(handles.text_h,'String','Core Thickness (mm)');
        set(handles.text_fct,'String','Individual Face Sheet Thickness (mm)');
        set(handles.text_md_core,'String','Core Mass Density (kg/m^3)');
     
    end
         
if(iu==1)  % English   
    
    if(ng==1)
        set(handles.edit_c,'String','1125');
     
    else
        set(handles.edit_c,'String',' ');   
        
    end
    
else
    
    if(ng==1)
        set(handles.edit_c,'String','343');  
      
    else
        set(handles.edit_c,'String',' ');      
        
    end          
       
end

%%%%%%%%%%%%%% 

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



function edit_Ix_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Ix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Ix as text
%        str2double(get(hObject,'String')) returns contents of edit_Ix as a double


% --- Executes during object creation, after setting all properties.
function edit_Ix_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Ix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Iy_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Iy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Iy as text
%        str2double(get(hObject,'String')) returns contents of edit_Iy as a double


% --- Executes during object creation, after setting all properties.
function edit_Iy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Iy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function intermediate_print(hObject, eventdata, handles)
%
    iu=getappdata(0,'iu');
    ns=getappdata(0,'ns');
    nc=getappdata(0,'nc');
    imat=getappdata(0,'imat');

    if(imat==1)
        disp('Aluminum');
    end    
    if(imat==2)
        disp('Steel');
    end    
    if(imat==3)
        disp('Copper');
    end    
    if(imat==4)
        disp('G10');
    end    
    if(imat==5)
        disp('Other Material');
    end        
    
    



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


% --- Executes on selection change in listbox_material_2.
function listbox_material_2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_material_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_material_2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_material_2


% --- Executes during object creation, after setting all properties.
function listbox_material_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_material_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_em_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_em_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_em_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_em_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_em_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_em_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_md_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_md_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_md_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_md_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_md_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_md_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thick_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thick_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thick_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_thick_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_thick_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thick_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thick_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thick (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thick as text
%        str2double(get(hObject,'String')) returns contents of edit_thick as a double


% --- Executes during object creation, after setting all properties.
function edit_thick_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thick (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mu_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mu_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mu_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_mu_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_mu_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mu_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end










% --- Executes on selection change in listbox_structure.
function listbox8_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_structure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_structure contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_structure


% --- Executes during object creation, after setting all properties.
function listbox8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_structure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_c_Callback(hObject, eventdata, handles)
% hObject    handle to edit_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_c as text
%        str2double(get(hObject,'String')) returns contents of edit_c as a double


% --- Executes during object creation, after setting all properties.
function edit_c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fcr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fcr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fcr as text
%        str2double(get(hObject,'String')) returns contents of edit_fcr as a double


% --- Executes during object creation, after setting all properties.
function edit_fcr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fcr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_c and none of its controls.
function edit_c_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_c (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');


% --- Executes on key press with focus on edit_em and none of its controls.
function edit_em_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_em (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');


% --- Executes on key press with focus on edit_md and none of its controls.
function edit_md_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_md (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');


% --- Executes on key press with focus on edit_mu and none of its controls.
function edit_mu_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_mu (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_results,'Visible','off');


function edit_h_Callback(hObject, eventdata, handles)
% hObject    handle to edit_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_h as text
%        str2double(get(hObject,'String')) returns contents of edit_h as a double


% --- Executes during object creation, after setting all properties.
function edit_h_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fct_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fct as text
%        str2double(get(hObject,'String')) returns contents of edit_fct as a double


% --- Executes during object creation, after setting all properties.
function edit_fct_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_md_core_Callback(hObject, eventdata, handles)
% hObject    handle to edit_md_core (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_md_core as text
%        str2double(get(hObject,'String')) returns contents of edit_md_core as a double


% --- Executes during object creation, after setting all properties.
function edit_md_core_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_md_core (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_W_Callback(hObject, eventdata, handles)
% hObject    handle to edit_W (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_W as text
%        str2double(get(hObject,'String')) returns contents of edit_W as a double


% --- Executes during object creation, after setting all properties.
function edit_W_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_W (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_gas.
function listbox_gas_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_gas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_gas contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_gas
change(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_gas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_gas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_gas_md_Callback(hObject, eventdata, handles)
% hObject    handle to edit_gas_md (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_gas_md as text
%        str2double(get(hObject,'String')) returns contents of edit_gas_md as a double


% --- Executes during object creation, after setting all properties.
function edit_gas_md_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gas_md (see GCBO)
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

     A = imread('re_honeycomb_sandwich_panel.jpg');
     figure(999) 
     imshow(A,'border','tight','InitialMagnification',100) 



function edit_core_G_Callback(hObject, eventdata, handles)
% hObject    handle to edit_core_G (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_core_G as text
%        str2double(get(hObject,'String')) returns contents of edit_core_G as a double


% --- Executes during object creation, after setting all properties.
function edit_core_G_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_core_G (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_ws.
function pushbutton_ws_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ws (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    A = imread('wavespeed_sandwich.jpg');
    figure(998) 
    imshow(A,'border','tight','InitialMagnification',100)



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


% --- Executes on button press in pushbutton_clf_eq.
function pushbutton_clf_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_clf_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

A = imread('clf_line_joint_plates.jpg');
figure(999)  

imshow(A,'border','tight','InitialMagnification',100)  



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


% --- Executes on key press with focus on edit_freq and none of its controls.
function edit_freq_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_freq (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');


% --- Executes on key press with focus on edit_length and none of its controls.
function edit_length_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_length (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');


% --- Executes on key press with focus on edit_area_1 and none of its controls.
function edit_area_1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_area_1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');


% --- Executes on key press with focus on edit_fct and none of its controls.
function edit_fct_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_fct (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');


% --- Executes on key press with focus on edit_area_2 and none of its controls.
function edit_area_2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_area_2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');


% --- Executes on key press with focus on edit_h and none of its controls.
function edit_h_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_h (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');


% --- Executes on key press with focus on edit_core_G and none of its controls.
function edit_core_G_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_core_G (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');


% --- Executes on key press with focus on edit_md_core and none of its controls.
function edit_md_core_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_md_core (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');

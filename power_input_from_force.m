function varargout = power_input_from_force(varargin)
% POWER_INPUT_FROM_FORCE MATLAB code for power_input_from_force.fig
%      POWER_INPUT_FROM_FORCE, by itself, creates a new POWER_INPUT_FROM_FORCE or raises the existing
%      singleton*.
%
%      H = POWER_INPUT_FROM_FORCE returns the handle to a new POWER_INPUT_FROM_FORCE or the handle to
%      the existing singleton*.
%
%      POWER_INPUT_FROM_FORCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in POWER_INPUT_FROM_FORCE.M with the given input arguments.
%
%      POWER_INPUT_FROM_FORCE('Property','Value',...) creates a new POWER_INPUT_FROM_FORCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before power_input_from_force_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to power_input_from_force_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help power_input_from_force

% Last Modified by GUIDE v2.5 11-Dec-2015 11:13:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @power_input_from_force_OpeningFcn, ...
                   'gui_OutputFcn',  @power_input_from_force_OutputFcn, ...
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


% --- Executes just before power_input_from_force is made visible.
function power_input_from_force_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to power_input_from_force (see VARARGIN)

% Choose default command line output for power_input_from_force
handles.output = hObject;

change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes power_input_from_force wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = power_input_from_force_OutputFcn(hObject, eventdata, handles) 
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

delete(power_input_from_force);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tpi=2*pi;

iu=get(handles.listbox_units,'Value');
ns=get(handles.listbox_structure,'Value');

disp(' ');
disp(' * * * ');
disp('  ');
disp(' Reference:  Beranek & Ver Book ');
disp('  ');
if(ns==1) 
    disp(' Beam, Compression, Semi-infinite');
end
if(ns==2) 
    disp(' Beam, Compression, Infinite');
end
if(ns==3) 
    disp(' Beam, Bending, Semi-infinite');
end
if(ns==4)
    disp(' Beam, Bending, Infinite');
end
if(ns==5) 
    disp(' Plate, In Plane');
end    
if(ns==6) 
    disp(' Plate, Bending, Semi-infinite');
end
if(ns==7) 
    disp(' Plate, Bending, Infinite');
end
if(ns==8) 
    disp(' Plate, Beam-Stiffened, Bending, Infinite '); 
end


setappdata(0,'iu',iu);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

em=str2num(get(handles.edit_em,'String'));
md=str2num(get(handles.edit_md,'String'));
mu=str2num(get(handles.edit_mu,'String'));
F=str2num(get(handles.edit_F,'String'));


if(iu==1)
    md=md/386;
else
    [em]=GPa_to_Pa(em);    
end

if(ns<=4) % Beam

    freq=str2num(get(handles.edit_freq,'String'));    
    
    nc=get(handles.listbox_cross,'Value'); 
    
    if(nc==1)  % rectangular
        
        H=str2num(get(handles.edit_H,'String'));
        W=str2num(get(handles.edit_width,'String'));
        
        if(iu==2)
           H=H/1000;
           W=W/1000;
        end
        
        I=(1/12)*W*H^3;
        A=W*H;

        
    end
 
    if(nc==2)  % pipe
        
        r1=str2num(get(handles.edit_r1,'String'));
        r2=str2num(get(handles.edit_r2,'String'));
        
        if(r1<r2)
            temp=r1;
            r1=r2;
            r2=temp;
        end
        
        if(iu==2)
           r1=r1/1000;
           r2=r2/1000;
        end
        
        I=(pi/4)*(r1^4-r2^4);
        A=pi*(r1^2-r2^2);

    end    
    
    if(nc==3)  % solid cylinder
        
        r1=str2num(get(handles.edit_r1,'String'));
        
        if(iu==2)
           r1=r1/1000;
           r2=r2/1000;
        end
        
        I=(pi/4)*(r1^4);
        A=pi*(r1^2);

    end     
    
    if(nc==4)  % other
        
        I=0;
        
        if(ns==3 || ns==4)
            I=str2num(get(handles.edit_I,'String'));
        end    
            
        A=str2num(get(handles.edit_area,'String'));
        
        if(iu==2)
           I=I/1000^4;
           A=A/1000^2;
        end
        
    end           
      
    S=A;
  
end

if(ns<=2) % Beam, Longitudinal
    
   CL=sqrt(em/md);
   lambda_s=(1/freq)*sqrt( em/( 2*(1+mu)*md ));
   
   LL=(lambda_s/4)^2;
   
   disp(' ');
   disp(' Range of Validity ');
   disp(' ');
   
   if(iu==1)
       out1=sprintf(' Cross-section area < %8.4g in^2 ',LL);
       out2=sprintf(' Longitudinal Wave Speed = %8.4g in/sec',CL);      
   else
       out1=sprintf(' Cross-section area < %8.4g mm^2 ',LL*1000^2);
       out2=sprintf(' Longitudinal Wave Speed = %8.4g m/sec',CL);          
   end
   
   disp(out1);
   disp(' ');
   disp(out2);
   disp(' ');   
   
   if(ns==1) % Beam, Compression, Semi-infinite
        Z=md*CL*S;
   end
   if(ns==2) % Beam, Compression, Infinite
        Z=2*md*CL*S;
   end   
      
end

if(ns==3 || ns==4)
    
    omega=tpi*freq;
       
    num=em*I*omega^2;
    den=md*S;
    
    CB=( num/den )^(1/4); 
    
    disp(' ');
    if(iu==1)
       out1=sprintf(' Bending Phase Speed = %8.4g in/sec ',CB); 
    else
       out1=sprintf(' Bending Phase Speed = %8.4g m/sec ',CB);
    end    
    disp(out1);
    disp(' ');
   

    if(ns==3) % Beam, Bending, Semi-infinite
        Z=(1/2)*(1+1i)*md*CB*S;
    end
    if(ns==4) % Beam, Bending, Infinite
        Z= 2*(1+1i)*md*CB*S;        
    end
      
end



if(ns==5) % Plate, In Plane
    warndlg('Not available. Will be added later.');
    return;
end    

if(ns==6 || ns==7)
    
    H=str2num(get(handles.edit_H,'String'));
    
    if(iu==2)
        H=H/1000;
    end
    
    Bp=em*H^3/( 12*(1-mu^2) );
    term=sqrt(Bp*md*H);

    if(ns==6) % Plate, Bending, Semi-infinite
        Z=3.5*term;
    end
    if(ns==7) % Plate, Bending, Infinite
        Z=8*term;
    end

end

if(ns==8) % Plate, Beam-Stiffened, Bending, Infinite 

end

if(ns==9)
    
    M=str2num(get(handles.edit_mass,'String'));
    mdens=str2num(get(handles.edit_mdens,'String'));
    
    if(iu==1)
        M=M/386;               
    end
    
    Y=mdens*(1+1i)/(4*M);
    Z=1/Y;
end


Y=1/Z;

YR=real(Y);

P=0.5*F^2*real(Y);

if(iu==1)
    out1=sprintf(' Real Mobility = %8.4g (in/sec)/lbf',YR);
    out2=sprintf(' Power Flow = %8.4g ft-lbf/sec',P);
else
    out1=sprintf(' Real Mobility = %8.4g (m/sec)/N',YR);    
    out2=sprintf(' Power Flow = %8.4g W',P);    
end    
    
disp(out1);
disp(' ');
disp(out2);
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
ns=get(handles.listbox_structure,'Value');

%%%
    set(handles.text_cross,'Visible','off');
    set(handles.listbox_cross,'Visible','off');
    set(handles.text_area,'Visible','off');
    set(handles.edit_area,'Visible','off');
    set(handles.text_area,'Visible','off');
    set(handles.edit_area,'Visible','off');
    set(handles.text_cross,'Visible','off');
    set(handles.listbox_cross,'Visible','off');
    set(handles.text_width,'Visible','off');
    set(handles.edit_width,'Visible','off');
    set(handles.text_H,'Visible','off');
    set(handles.edit_H,'Visible','off');
    set(handles.text_r1,'Visible','off');
    set(handles.edit_r1,'Visible','off');
    set(handles.text_r2,'Visible','off');
    set(handles.edit_r2,'Visible','off');
    set(handles.text_area,'Visible','off');
    set(handles.edit_area,'Visible','off');
    set(handles.text_I,'Visible','off');
    set(handles.edit_I,'Visible','off');
    set(handles.text_freq,'Visible','off');
    set(handles.edit_freq,'Visible','off');

    set(handles.text_mass,'Visible','off');
    set(handles.edit_mass,'Visible','off');
    set(handles.text_mdens,'Visible','off');
    set(handles.edit_mdens,'Visible','off');    
    
    if(ns<=8)
        set(handles.text_mat,'Visible','on');
        set(handles.listbox_material,'Visible','on');
        set(handles.text_em,'Visible','on');
        set(handles.edit_em,'Visible','on');
        set(handles.text_md,'Visible','on');
        set(handles.edit_md,'Visible','on');
        set(handles.text_mu,'Visible','on');
        set(handles.edit_mu,'Visible','on');
    else
        set(handles.text_mat,'Visible','off');
        set(handles.listbox_material,'Visible','off');
        set(handles.text_em,'Visible','off');
        set(handles.edit_em,'Visible','off');
        set(handles.text_md,'Visible','off');
        set(handles.edit_md,'Visible','off');
        set(handles.text_mu,'Visible','off');
        set(handles.edit_mu,'Visible','off');        
    end    
    
    
%%%
     
if(iu==1)  % English   
    
    set(handles.text_em,'String','Elastic Modulus (psi)');
    set(handles.text_md,'String','Mass Density (lbm/in^3)'); 
    set(handles.text_F,'String','Driving Point Force (lbf rms)'); 
else
    
    set(handles.text_em,'String','Elastic Modulus (GPa)');
    set(handles.text_md,'String','Mass Density (kg/m^3)');          
    set(handles.text_F,'String','Driving Point Force (N rms)');        
end

if(ns<=4) % Beams
    
    set(handles.text_freq,'Visible','on');
    set(handles.edit_freq,'Visible','on');
    
    set(handles.text_cross,'Visible','on');
    set(handles.listbox_cross,'Visible','on');    
    
    nc=get(handles.listbox_cross,'Value');    
    
    if(nc==1) % rectangular
        
        set(handles.text_width,'Visible','on');
        set(handles.text_H,'Visible','on'); 
        set(handles.edit_width,'Visible','on');
        set(handles.edit_H,'Visible','on');         
        
        if(iu==1)  % English     
            set(handles.text_width,'String','Width (in)');
            set(handles.text_H,'String','Thickness (in)');    
            set(handles.text_area,'String','Cross Section Area (in^2)');
            set(handles.text_I,'String','Area Moment Inertia (in^4)');
   
        else
            set(handles.text_width,'String','Width (mm)'); 
            set(handles.text_H,'String','Thickness (mm)');    
            set(handles.text_area,'String','Cross Section Area (mm^2)');
            set(handles.text_I,'String','Area Moment Inertia (mm^4)');         
        end
    end

    if(nc==2)  % pipe
        set(handles.text_r1,'Visible','on');
        set(handles.text_r2,'Visible','on');
        set(handles.edit_r1,'Visible','on');
        set(handles.edit_r2,'Visible','on');
        
        if(iu==1)
            set(handles.text_r1,'String','Outer Radius (in)');
            set(handles.text_r2,'String','Inner Radius (in)');
        else
            set(handles.text_r1,'String','Outer Radius (mm)');
            set(handles.text_r2,'String','Inner Radius (mm)');           
        end
        
    end  
    
    if(nc==3)  % solid cylinder
        set(handles.text_r1,'Visible','on');
        set(handles.edit_r1,'Visible','on');
        
        if(iu==1)
            set(handles.text_r1,'String','Radius (in)');            
        else
            set(handles.text_r1,'String','Radius (mm)');             
        end
        
    end    
    
    if(nc==4) % other  
 
        set(handles.text_area,'Visible','on');
        set(handles.edit_area,'Visible','on');
        
        if(ns==3 || ns==4)
            set(handles.text_I,'Visible','on');
            set(handles.edit_I,'Visible','on');       
        end
            
        if(iu==1)  % English     
            set(handles.text_area,'String','Cross Section Area (in^2)');
            set(handles.text_I,'String','Area Moment Inertia (in^4)');
   
        else
            set(handles.text_area,'String','Cross Section Area (mm^2)');
            set(handles.text_I,'String','Area Moment Inertia (mm^4)');         
        end   
    end
    
    
end    

if(ns>=5 && ns<=7) % plates
    
    set(handles.text_H,'Visible','on'); 
    set(handles.edit_H,'Visible','on');
    
    if(iu==1)
        set(handles.text_H,'String','Thickness (in)');         
    else
        set(handles.text_H,'String','Thickness (mm)');         
    end
    
end

if(ns==8) % Plate, Beam-stiffened
    
    set(handles.text_H,'Visible','on'); 
    set(handles.edit_H,'Visible','on');
    set(handles.text_width,'Visible','on'); 
    set(handles.edit_width,'Visible','on');
    set(handles.edit_L,'Visible','on');
    set(handles.text_L,'Visible','on');
    
    set(handles.text_freq,'Visible','on');
    set(handles.edit_freq,'Visible','on');     
    
    
    if(iu==1)
        set(handles.text_L,'String','Total Beam Length (in)');
        set(handles.text_H,'String','Beam Height (in)');
        set(handles.text_width,'String','Beam Width (in)');         
    else
        set(handles.text_L,'String','Total Beam Length (m)');        
        set(handles.text_H,'String','Beam Height (mm)');
        set(handles.text_width,'String','Beam Width (mm)');         
    end
    
end

if(ns==9)
    set(handles.text_mass,'Visible','on');
    set(handles.edit_mass,'Visible','on');
    set(handles.text_mdens,'Visible','on');
    set(handles.edit_mdens,'Visible','on');
    
    if(iu==1)
        set(handles.text_mass,'String','Mass (lbm)');        
    else
        set(handles.text_mass,'String','Mass (kg)');        
    end
    
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



function edit_plate_h_Callback(hObject, eventdata, handles)
% hObject    handle to edit_plate_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_plate_h as text
%        str2double(get(hObject,'String')) returns contents of edit_plate_h as a double


% --- Executes during object creation, after setting all properties.
function edit_plate_h_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_plate_h (see GCBO)
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

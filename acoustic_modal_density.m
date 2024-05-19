function varargout = acoustic_modal_density(varargin)
% ACOUSTIC_MODAL_DENSITY MATLAB code for acoustic_modal_density.fig
%      ACOUSTIC_MODAL_DENSITY, by itself, creates a new ACOUSTIC_MODAL_DENSITY or raises the existing
%      singleton*.
%
%      H = ACOUSTIC_MODAL_DENSITY returns the handle to a new ACOUSTIC_MODAL_DENSITY or the handle to
%      the existing singleton*.
%
%      ACOUSTIC_MODAL_DENSITY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ACOUSTIC_MODAL_DENSITY.M with the given input arguments.
%
%      ACOUSTIC_MODAL_DENSITY('Property','Value',...) creates a new ACOUSTIC_MODAL_DENSITY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before acoustic_modal_density_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to acoustic_modal_density_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help acoustic_modal_density

% Last Modified by GUIDE v2.5 16-Dec-2015 09:56:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @acoustic_modal_density_OpeningFcn, ...
                   'gui_OutputFcn',  @acoustic_modal_density_OutputFcn, ...
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


% --- Executes just before acoustic_modal_density is made visible.
function acoustic_modal_density_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to acoustic_modal_density (see VARARGIN)

% Choose default command line output for acoustic_modal_density
handles.output = hObject;

change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes acoustic_modal_density wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = acoustic_modal_density_OutputFcn(hObject, eventdata, handles) 
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

delete(acoustic_modal_density);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp('****')

tpi=2*pi;

in_per_meters=39.37;

fmin=20;
fmax=20000;

iu=get(handles.listbox_units,'Value');
ns=get(handles.listbox_structure,'Value');
imed=get(handles.listbox_medium,'Value');

if(iu==1)
    su='in/sec';
end
if(iu==2)
    su='ft/sec';
end
if(iu==3)
    su='m/sec';
end



if(imed==1)  % air

        Tc=str2num(get(handles.edit_temp,'String'));
        Tk=Tc+273.15;
        
        ratio=1.402;
        M=28.97;
        
        R=8314.3;  % J/(kgmole K)
        c=sqrt(ratio*R*Tk/M);
        
        if(iu==1)
            c=c*in_per_meters;
        end
        if(iu==2)
            c=c*in_per_meters/12;
        end        
        
else
        c=str2num(get(handles.edit_speed,'String'));         
end    



disp(' ');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(ns==1) % Acoustic Cavity 1D
    
    disp(' Acoustic Cavity Pipe 1D ');
    
    L=str2num(get(handles.edit_L,'String'));
    
    modal_density=L/(pi*c);
    mph=modal_density*tpi;
    
      
    out1=sprintf('\n Modal Density = %8.4g (modes/rad)',modal_density);
    out2=sprintf('               = %8.4g (modes/Hz)',mph);
    
    disp(out1);
    disp(out2);    
    
end

if(ns>=2)
    
    [~,fc,~,~,fmin,fmax]=SEA_one_third_octave_frequencies_max_min();
    f=fc;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(ns==2) % Acoustic Cavity 2D
    
    disp(' Acoustic Cavity Rectangular 2D ');

    L=str2num(get(handles.edit_L,'String'));    
    W=str2num(get(handles.edit_width,'String'));
   
    A=L*W;
    P=2*(L*W);
    
    for i=1:length(f)
       
        mph(i)=(tpi*f(i)*A/c^2)+(P/c);
                
    end

    stitle='Acoustic Cavity Rectangular 2D  Modal Density'; 
    
%
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(ns==3) % Acoustic Cavity 3D
    
    disp('Acoustic Cavity Rectangular Prism');

    L=str2num(get(handles.edit_L,'String'));    
    W=str2num(get(handles.edit_width,'String')); 
    H=str2num(get(handles.edit_H,'String'));     
    
    V=L*W*H;
    A=2*(L*W+L*H+W*H);
    P=4*(L+W+H); 
    
    D1=4*pi*V/c^3;
    D2=pi*A/(2*c^2);
    D3=P/(8*c);
    
    dd=@(f)(D1*f^2+D2*f+D3);
    
    for i=1:length(f)
        
        mph(i)=dd(f(i));
        
    end
    
    stitle='Acoustic Cavity Rectangular Prism  Modal Density';    
        
%
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(ns>=4 && ns<=6)
    dd=@(D,f)(4*pi*D*f^2);
end    

if(ns==4) % Cylinder
    
    disp(' Acoustic Cavity Cylinder 3D ');

    H=str2num(get(handles.edit_H,'String'));    
    r=str2num(get(handles.edit_radius,'String'));  
    
    V=pi*r^2*H;
    
    D=V/c^3;   
    
   
    for i=1:length(f)
        
        mph(i)=dd(D,f(i));  
        
    end
    
    stitle='Acoustic Cylinder 3D  Modal Density';    
    
%
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(ns==5) % Sphere
    
    disp(' Acoustic Cavity Sphere ');
    
    r=str2num(get(handles.edit_radius,'String'));  
    
    V=(4/3)*pi*r^3;
    
    D=V/c^3;   
    
      
    for i=1:length(f)
        
        [mph(i)]=acoustic_volume_mdens(D,f(i));  
        
    end
    
    stitle='Acoustic Sphere  Modal Density';

%
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(ns==6) % Volume
    
    disp(' Acoustic Volume ');
    
    V=str2num(get(handles.edit_volume,'String'));  
    
    D=V/c^3;   
    
    for i=1:length(f)
        
        [mph(i)]=acoustic_volume_mdens(D,f(i));  
              
    end
    
    stitle='Acoustic Volume  Modal Density';

%
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(ns>=2)

    f=fix_size(f);
    mph=fix_size(mph); 
    
    fig_num=1;
    
    x_label='Frequency (Hz)';
    y_label='Modal Density (modes/Hz)';
    t_string=stitle;
    ppp=[f mph];
    md=7;
    
    [fig_num]=plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);
                 
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
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(ns>=3)
    if(iu==1)
        out1=sprintf('\n Volume = %8.4g in^3',V);
    end
    if(iu==2)
        out1=sprintf('\n Volume = %8.4g ft^3',V);
    end    
    if(iu==3)
        out1=sprintf('\n Volume = %8.4g m^3',V);        
    end
    disp(out1);    
end    

out10=sprintf('\n Speed of Sound in Gas = %8.4g %s',c,su);
disp(out10);

if(iu==1)
    out10=sprintf('                       = %8.4g ft/sec',c/12);
    disp(out10);    
end



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


% --- Executes on selection change in listbox_medium.
function listbox_medium_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_medium (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_medium contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_medium

n=get(handles.listbox_medium,'Value');

if(n==1)
    set(handles.edit_temp,'Visible','on');
    set(handles.text_temp,'Visible','on');
    
    set(handles.edit_speed,'Visible','off');
    set(handles.text_speed,'Visible','off');
    
else
    set(handles.edit_temp,'Visible','off');
    set(handles.text_temp,'Visible','off');
    
    set(handles.edit_speed,'Visible','on');
    set(handles.text_speed,'Visible','on');
    
end    


% --- Executes during object creation, after setting all properties.
function listbox_medium_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_medium (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_temp_Callback(hObject, eventdata, handles)
% hObject    handle to edit_temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_temp as text
%        str2double(get(hObject,'String')) returns contents of edit_temp as a double


% --- Executes during object creation, after setting all properties.
function edit_temp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_temp (see GCBO)
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



function edit_radius_Callback(hObject, eventdata, handles)
% hObject    handle to edit_radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_radius as text
%        str2double(get(hObject,'String')) returns contents of edit_radius as a double


% --- Executes during object creation, after setting all properties.
function edit_radius_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_radius (see GCBO)
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
ns=get(handles.listbox_structure,'Value');

%%%



set(handles.edit_width,'Visible','off'); 
set(handles.text_width,'Visible','off'); 

set(handles.edit_H,'Visible','off'); 
set(handles.text_H,'Visible','off'); 

set(handles.edit_radius,'Visible','off'); 
set(handles.text_radius,'Visible','off'); 

set(handles.text_speed,'Visible','off');
set(handles.edit_speed,'Visible','off');

set(handles.listbox_medium,'Visible','off');
set(handles.text_medium,'Visible','off');

set(handles.edit_temp,'Visible','off');
set(handles.text_temp,'Visible','off');

set(handles.text_L,'Visible','off');
set(handles.edit_L,'Visible','off');  

set(handles.edit_volume,'Visible','off'); 
set(handles.text_volume,'Visible','off'); 

    
if(iu==1)
    set(handles.text_speed,'String','Sound Speed (in/sec)');    
end
if(iu==2)
    set(handles.text_speed,'String','Sound Speed (ft/sec)');    
end
if(iu==3)
    set(handles.text_speed,'String','Sound Speed (m/sec)');        
end
    
set(handles.listbox_medium,'Visible','on');
set(handles.text_medium,'Visible','on');    
    
listbox_medium_Callback(hObject, eventdata, handles);
    


          
if(iu==1)  % English
    set(handles.text_L,'String','Length (in)');        
    set(handles.text_width,'String','Width (in)');   
    set(handles.text_H,'String','Height (in)');      
    set(handles.text_radius,'String','Radius (in)');     
    set(handles.text_volume,'String','Volume (in^3)');      
end
if(iu==2)  % English
    set(handles.text_L,'String','Length (ft)');        
    set(handles.text_width,'String','Width (ft)');   
    set(handles.text_H,'String','Height (ft)');      
    set(handles.text_radius,'String','Radius (ft)');     
    set(handles.text_volume,'String','Volume (ft^3)');      
end
if(iu==3)
    set(handles.text_L,'String','Length (m)');  
    set(handles.text_width,'String','Width (m)');
    set(handles.text_H,'String','Height (m)');
    set(handles.text_radius,'String','Radius (m)');
    set(handles.text_volume,'String','Volume (m^3)');      
end

if(ns<=3)
    set(handles.text_L,'Visible','on');
    set(handles.edit_L,'Visible','on');     
end

if(ns==2 || ns==3)
   set(handles.edit_width,'Visible','on'); 
   set(handles.text_width,'Visible','on');
end

if(ns==3 || ns==4)
    set(handles.edit_H,'Visible','on'); 
    set(handles.text_H,'Visible','on');    
end

if(ns==4 || ns==5)
    set(handles.edit_radius,'Visible','on'); 
    set(handles.text_radius,'Visible','on');    
end

if(ns==6)
    set(handles.edit_volume,'Visible','on'); 
    set(handles.text_volume,'Visible','on');    
end

%%%



function edit_volume_Callback(hObject, eventdata, handles)
% hObject    handle to edit_volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_volume as text
%        str2double(get(hObject,'String')) returns contents of edit_volume as a double


% --- Executes during object creation, after setting all properties.
function edit_volume_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_volume (see GCBO)
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

ns=get(handles.listbox_structure,'Value');

if(ns==1)
    A = imread('1D_Pipe_md.jpg');
    figure(994) 
    imshow(A,'border','tight','InitialMagnification',100)
end
if(ns==2)
    A = imread('2D_Rectangle_md.jpg');
    figure(995) 
    imshow(A,'border','tight','InitialMagnification',100)
end
if(ns==3)
    A = imread('3D_Rectangular Prism_md.jpg');
    figure(996) 
    imshow(A,'border','tight','InitialMagnification',100)
end
if(ns==4)
    A = imread('3D_Cylinder_md.jpg');
    figure(997) 
    imshow(A,'border','tight','InitialMagnification',100)
end
if(ns==5)
    A = imread('3D_Sphere_md.jpg');
    figure(998) 
    imshow(A,'border','tight','InitialMagnification',100)
end
if(ns==6)
    A = imread('3D_Other_md.jpg');
    figure(999) 
    imshow(A,'border','tight','InitialMagnification',100)
end

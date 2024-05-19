function varargout = column_buckling(varargin)
% COLUMN_BUCKLING MATLAB code for column_buckling.fig
%      COLUMN_BUCKLING, by itself, creates a new COLUMN_BUCKLING or raises the existing
%      singleton*.
%
%      H = COLUMN_BUCKLING returns the handle to a new COLUMN_BUCKLING or the handle to
%      the existing singleton*.
%
%      COLUMN_BUCKLING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COLUMN_BUCKLING.M with the given input arguments.
%
%      COLUMN_BUCKLING('Property','Value',...) creates a new COLUMN_BUCKLING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before column_buckling_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to column_buckling_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help column_buckling

% Last Modified by GUIDE v2.5 05-Jul-2018 17:44:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @column_buckling_OpeningFcn, ...
                   'gui_OutputFcn',  @column_buckling_OutputFcn, ...
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


% --- Executes just before column_buckling is made visible.
function column_buckling_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to column_buckling (see VARARGIN)

% Choose default command line output for column_buckling
handles.output = hObject;

change(hObject, eventdata, handles);

set(handles.uipanel_result,'Visible','off');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes column_buckling wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = column_buckling_OutputFcn(hObject, eventdata, handles) 
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

delete(column_buckling);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * ');
disp(' ');

n=get(handles.listbox_bc,'Value');

K=[1.0; 0.5; sqrt(2)/2; 2.0];


iu=get(handles.listbox_units,'Value');
nc=get(handles.listbox_cross,'Value');
imat=get(handles.listbox_material,'Value');

L=str2num(get(handles.edit_L,'String')); 

em=str2num(get(handles.edit_em,'String'));
    
em_orig=em;

if(iu==2)
    [em]=GPa_to_Pa(em);
end
    
%%%
    
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
        
        I=str2num(get(handles.edit_I,'String'));
        A=str2num(get(handles.edit_area,'String'));
        
        if(iu==2)
           I=I/1000^4;
           A=A/1000^2;
        end
        
    end       
       
    
%%%%%%%%%%

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
        disp('Titanium');
    end         
    if(imat==6)
        disp('Graphite/Epoxy');
    end     
    if(imat==7)
        disp('Other Material');
    end        
    
    
    if(iu==1)
        out1=sprintf('                 Length = %g in',L);
        out2=sprintf('     Cross Section Area = %8.4g in^2',A);  
        out3=sprintf(' Area Moment of Inertia = %8.4g in^4',I);        
    else
        out1=sprintf('                 Length = %g m',L);
        out2=sprintf('     Cross Section Area = %8.4g m^2',A);  
        out3=sprintf(' Area Moment of Inertia = %8.4g m^4',I);
    end
    disp(out1);
    disp(out2);    
    disp(out3);   
    
    
disp(' ');    
if(n==1)
    disp('Both ends pinned (hinged)');
end
if(n==2)
    disp('Both ends fixed');
end
if(n==3)
    disp('One end fixed and the other end pinned');
end
if(n==4)
    disp('One end fixed and the other end free to move laterally');
end


%%%%%%%%%%

num=pi^2*em*I;
den=(K(n)*L)^2;

F = num/den;

if(iu==1)
    out5=sprintf('\n Elastic Modulus = %8.4g lbf/in^2',em_orig);
    out1=sprintf('\n Critical Load = %8.4g lbf \n',F);
    ss=sprintf('%8.4g lbf',F);
else
    out5=sprintf('\n Elastic Modulus = %8.4g GPa',em_orig);    
    out1=sprintf('\n Critical Load = %8.4g N \n',F); 
    ss=sprintf('%8.4g N',N);
end

disp(out5);
disp(out1);

set(handles.uipanel_result,'Visible','on');

set(handles.edit_critical_load,'String',ss);


% --- Executes on button press in pushbutton_equation.
function pushbutton_equation_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_equation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

     A = imread('column_buckling.jpg');
     figure(999) 
     imshow(A,'border','tight','InitialMagnification',100) 


% --- Executes on selection change in listbox_material.
function listbox_material_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_material

change(hObject, eventdata, handles);
set(handles.uipanel_result,'Visible','off');


function change(hObject, eventdata, handles)
%
iu=get(handles.listbox_units,'Value');

imat=get(handles.listbox_material,'Value');


[elastic_modulus,mass_density,poisson]=six_materials(iu,imat);
 
%%%%
  
if(imat<=6)
        ss1=sprintf('%8.4g',elastic_modulus);
else
        ss1=' ';     
end
 
set(handles.edit_em,'String',ss1);


%%%%%%%%%%%%%%


nc=get(handles.listbox_cross,'Value');

%%%



set(handles.text_r1,'Visible','off');
set(handles.text_r2,'Visible','off');
set(handles.edit_r1,'Visible','off');
set(handles.edit_r2,'Visible','off');



set(handles.edit_width,'Visible','off'); 
set(handles.text_width,'Visible','off'); 

set(handles.edit_H,'Visible','off'); 
set(handles.text_H,'Visible','off'); 

set(handles.text_area,'Visible','off');
set(handles.edit_area,'Visible','off');
set(handles.text_I,'Visible','off');
set(handles.edit_I,'Visible','off');


set(handles.text_L,'Visible','on');
set(handles.edit_L,'Visible','on');   
        

if(iu==1)  % English
    set(handles.text_L,'String','Length (in)');        
    set(handles.text_width,'String','Width (in)');
    set(handles.text_H,'String','Thickness (in)');    
    set(handles.text_area,'String','Cross Section Area (in^2)');
    set(handles.text_I,'String','Area Moment Inertia (in^4)');
else
    set(handles.text_L,'String','Length (m)');  
    set(handles.text_width,'String','Width (mm)'); 
    set(handles.text_H,'String','Thickness (mm)');    
    set(handles.text_area,'String','Cross Section Area (mm^2)');
    set(handles.text_I,'String','Area Moment Inertia (mm^4)');    
    set(handles.text_em,'String','Elastic Modulus (GPa)');    
end

    
if(nc==1)  % rectangular
        set(handles.edit_width,'Visible','on'); 
        set(handles.text_width,'Visible','on');
        set(handles.edit_H,'Visible','on'); 
        set(handles.text_H,'Visible','on');
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
        set(handles.text_I,'Visible','on');
        set(handles.edit_I,'Visible','on');        
end













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


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units

change(hObject, eventdata, handles);
set(handles.uipanel_result,'Visible','off');

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


% --- Executes on selection change in listbox_cross.
function listbox_cross_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_cross (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_cross contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_cross

change(hObject, eventdata, handles);
set(handles.uipanel_result,'Visible','off');

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


% --- Executes on selection change in listbox_bc.
function listbox_bc_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_bc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_bc contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_bc
set(handles.uipanel_result,'Visible','off');



% --- Executes during object creation, after setting all properties.
function listbox_bc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_bc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_critical_load_Callback(hObject, eventdata, handles)
% hObject    handle to edit_critical_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_critical_load as text
%        str2double(get(hObject,'String')) returns contents of edit_critical_load as a double


% --- Executes during object creation, after setting all properties.
function edit_critical_load_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_critical_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_em and none of its controls.
function edit_em_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_em (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_result,'Visible','off');


% --- Executes on key press with focus on edit_L and none of its controls.
function edit_L_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_L (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_result,'Visible','off');


% --- Executes on key press with focus on edit_width and none of its controls.
function edit_width_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_width (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_result,'Visible','off');


% --- Executes on key press with focus on edit_H and none of its controls.
function edit_H_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_H (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_result,'Visible','off');


% --- Executes on key press with focus on edit_area and none of its controls.
function edit_area_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_area (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_result,'Visible','off');


% --- Executes on key press with focus on edit_I and none of its controls.
function edit_I_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_I (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_result,'Visible','off');


% --- Executes on key press with focus on edit_r1 and none of its controls.
function edit_r1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_r1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_result,'Visible','off');


% --- Executes on key press with focus on edit_r2 and none of its controls.
function edit_r2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_r2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_result,'Visible','off');

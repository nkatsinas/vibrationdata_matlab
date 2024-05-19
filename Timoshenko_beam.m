function varargout = Timoshenko_beam(varargin)
% TIMOSHENKO_BEAM MATLAB code for Timoshenko_beam.fig
%      TIMOSHENKO_BEAM, by itself, creates a new TIMOSHENKO_BEAM or raises the existing
%      singleton*.
%
%      H = TIMOSHENKO_BEAM returns the handle to a new TIMOSHENKO_BEAM or the handle to
%      the existing singleton*.
%
%      TIMOSHENKO_BEAM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TIMOSHENKO_BEAM.M with the given input arguments.
%
%      TIMOSHENKO_BEAM('Property','Value',...) creates a new TIMOSHENKO_BEAM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Timoshenko_beam_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Timoshenko_beam_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Timoshenko_beam

% Last Modified by GUIDE v2.5 07-Oct-2014 15:09:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Timoshenko_beam_OpeningFcn, ...
                   'gui_OutputFcn',  @Timoshenko_beam_OutputFcn, ...
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


% --- Executes just before Timoshenko_beam is made visible.
function Timoshenko_beam_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Timoshenko_beam (see VARARGIN)

% Choose default command line output for Timoshenko_beam
handles.output = hObject;

unitslistbox_Callback(hObject, eventdata, handles);

handles.thick=0;
handles.width=0;

handles.diameter=0;
handles.wall_thick=0;

handles.MOI=0;
handles.area=0;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Timoshenko_beam wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Timoshenko_beam_OutputFcn(hObject, eventdata, handles) 
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

handles.unit=get(handles.unitslistbox,'Value');

E=str2num(get(handles.elasticmoduluseditbox,'String'));
rho=str2num(get(handles.massdensityeditbox,'String'));

BC=get(handles.BClistbox,'Value');

L=str2num(get(handles.lengtheditbox,'String'));


thick=handles.thick;
width=handles.width;
diameter=handles.diameter;
wall_thick=handles.wall_thick;
    

if(handles.unit==1) % English
    rho=rho/386;
end
if(handles.unit==2) % metric
    [E]=GPa_to_Pa(E);
    thick=thick/1000;
    width=width/1000;
    diameter=diameter/1000;
    wall_thick=wall_thick/1000;
end


if(handles.cross_section==1) % rectangular
        [area,MOI,~]=beam_rectangular_geometry(width,thick); 
        k=2/3;
end
if(handles.cross_section==2) % pipe
        [area,MOI,~]=pipe_geometry_wall(diameter,wall_thick);
        k=3/4;      
end
if(handles.cross_section==3) % solid cylinder
        [area,MOI,~]=cylinder_geometry(diameter); 
        k=3/4;       
end
if(handles.cross_section==4) % other
        area=handles.area;
        MOI=handles.MOI; 
        k=3/4;
end


mu=0.3;

G=E/(2*(1+mu));
   
%%%

I=MOI;
A=area;

a2=E*I/(rho*A);
r2=I/A;
r4=r2^2;
r=sqrt(r2);

EKG=E/(k*G);
EKG_term=1+EKG;

%%%

%%%
    
if(BC==1)  % ss at each end
    
    fn=zeros(3,1);
    
    for n=1:3
        npL=n*pi/L;
        npL2=npL^2;
        npL4=npL^4;
%
        A=(1+r2*(EKG_term)*npL2)^2;
        B=4*r2*(rho*a2/(k*G))*npL4;
%
        if(A>=B)
        else
            disp(' Warning: A<B ');
        end
%
        R=sqrt(A-B);
%
        om2=(1+r2*(1 + EKG)*npL2) - R;
        om2=k*G*om2/(2*r2*rho);
%
        omega=sqrt(om2);
        fn(n)=omega/(2*pi);
    end
%
    disp(' ');
    disp(' Natural Frequencies ');
    disp(' ');
%
    for n=1:3
        out1=sprintf(' f%d = %9.5g Hz ',n,fn(n));
        disp(out1);
    end
    
    fn_string=sprintf('%8.4g \n%8.4g \n%8.4g \n%8.4g ',fn(1),fn(2),fn(3));    
%
    set(handles.Answer,'String',fn_string);
    set(handles.uipanel_fn,'Visible','on');    
%
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(BC==2)  % fixed-free
    disp(' ');
    disp(' Southwell-Dunkerley Approximation (bending & shear only)');
    disp(' ');
%
    fb=sqrt(a2);
    fb=3.5156*fb/(2*pi*L^2);
    fs=sqrt(k*G/rho)/(4*L);
%
    A=(1/fb^2)+(1/fs^2);
    fn=sqrt(1/A);
%    
    out1=sprintf(' fb= %8.4g Hz  bending \n fs= %8.4g Hz  shear \n fn= %8.4g Hz  combined',fb,fs,fn);
    disp(out1);
    disp(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    fstart=fn*0.6;
    df=0.5;
%
    LLL=round((fn-fstart)/0.5);
%
    disp(' Bruch-Mitchell Method (bending, shear & rotary inertia)');
    disp(' ');
% 
    A=area;
%
    r2=I/(A*L^2);
    s2=E*I/(k*A*G*L^2);
    b2_initial=rho*A*L^4/(E*I);
%
    M=0;     % no end mass
    khat=0;
%
    term_initial=0.5*M*khat^2/(rho*A*L^3);
    MT_initial=M/(rho*A*L^2);
%
    Mbar=0;
    sigma2=0;
%
    clear ddd;
    clear ap;
    clear ff;
%
    progressbar
    LIMIT=100000;
    
    iflag=0;
    
    for i=1:LIMIT
        progressbar(i/LIMIT)
        fn=(i-1)*df+fstart;
        omega=2*pi*fn;
        om2=omega^2;
        b2=b2_initial*om2;
        b=sqrt(b2);
        bsr2=b2*s2*r2;
        term=term_initial*b2;
%
        clear alpha2;
        clear beta2;
%
        sqterm = sqrt((r2-s2)^2+(4/b^2));
%
        alpha2= -(r2+s2) + sqterm;
        beta2=   (r2+s2) + sqterm;
%
        alpha2= alpha2*0.5;
         beta2=  beta2*0.5;       
%
        ap(i)=alpha2;
        ff(i)=fn;
%
        if( alpha2 > 1.0e-20) 
%
        alpha=sqrt(alpha2);
        beta=sqrt(beta2);
%
        bs2=b2*s2;
        MT=MT_initial*bs2;
%
        balpha=b*alpha;
        bbeta =b*beta;
%
        H1= (1-bs2*(alpha2+r2))*L/balpha;
        H2= (1-bs2*(alpha2+r2))*L/balpha;
        H3=-(1+bs2*(beta2-r2))*L/bbeta;
        H4= (1+bs2*(beta2-r2))*L/bbeta;
%
        ba=b*alpha;
        bb=b*beta;
%     
        coshba =cosh(ba);  
        sinhba =sinh(ba);
        cosbb  =cos(bb);  
        sinbb  =sin(bb);   
%
        MC=Mbar*b2;
        MCC=0.5*Mbar*sigma2*b2;
%        
        alphaC=(alpha2+s2)/alpha;
        betaC =(beta2-s2)/beta;  
%
        R1= (b/alpha)*sinhba + MC*coshba;
        R2= (b/alpha)*coshba + MC*sinhba;
        R3=  (b/beta)*sinbb  + MC*cosbb;
        R4= -(b/beta)*cosbb  + MC*sinbb;
%
        R1P= alphaC*( ba*coshba - MCC*sinhba);
        R2P= alphaC*( ba*sinhba - MCC*coshba);
        R3P= -betaC*( bb*cosbb  - MCC*sinbb);
        R4P=  betaC*(-bb*sinbb  - MCC*cosbb);
%
        M=zeros(4,4);
        M(1,1)=1;
        M(1,3)=1;
        M(2,2)=alphaC;
        M(2,4)=betaC;        
%
        M(3,1)= R1;
        M(3,2)= R2;
        M(3,3)= R3;
        M(3,4)= R4;
%        
        M(4,1)= R1P;
        M(4,2)= R2P;
        M(4,3)= R3P;
        M(4,4)= R4P;
%
        num=det(M);
        ddd(i)=abs(num);
%
        if(i>=2 &&  abs(real(num)) > abs(imag(num)))
            if(num*num_before<=0)
                iflag=1;
                out1=sprintf(' fn=%8.4g Hz',fn);
                disp(out1);
                break;
            end
        end 
%
        num_before=num;
%
    end
    end
    progressbar(1);

    disp(' ');
    
    msgbox('Results written to Command Window');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(Timoshenko_beam);



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


% --- Executes on selection change in BClistbox.
function BClistbox_Callback(hObject, eventdata, handles)
% hObject    handle to BClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns BClistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from BClistbox
set(handles.uipanel_fn,'Visible','off');

% --- Executes during object creation, after setting all properties.
function BClistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in materiallistbox.
function materiallistbox_Callback(hObject, eventdata, handles)
% hObject    handle to materiallistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns materiallistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from materiallistbox


% --- Executes during object creation, after setting all properties.
function materiallistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to materiallistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function elasticmoduluseditbox_Callback(hObject, eventdata, handles)
% hObject    handle to elasticmoduluseditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of elasticmoduluseditbox as text
%        str2double(get(hObject,'String')) returns contents of elasticmoduluseditbox as a double
string=get(hObject,'String');
handles.elastic_modulus=str2num(string);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function elasticmoduluseditbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to elasticmoduluseditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function massdensityeditbox_Callback(hObject, eventdata, handles)
% hObject    handle to massdensityeditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of massdensityeditbox as text
%        str2double(get(hObject,'String')) returns contents of massdensityeditbox as a double
string=get(hObject,'String');
handles.mass_density=str2num(string);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function massdensityeditbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to massdensityeditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lengtheditbox_Callback(hObject, eventdata, handles)
% hObject    handle to lengtheditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lengtheditbox as text
%        str2double(get(hObject,'String')) returns contents of lengtheditbox as a double
string=get(hObject,'String');

handles.length=str2num(string);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function lengtheditbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lengtheditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in crosssectionlistbox.
function crosssectionlistbox_Callback(hObject, eventdata, handles)
% hObject    handle to crosssectionlistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns crosssectionlistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from crosssectionlistbox

handles.unit=get(handles.unitslistbox,'Value');
handles.cross_section=get(handles.crosssectionlistbox,'Value');
guidata(hObject, handles);

set(handles.uipanel_fn,'Visible','off');
geometry_change(hObject, eventdata, handles)





function material_change(hObject, eventdata, handles)


handles.material=get(handles.listbox_material,'Value');

if(handles.unit==1)  % English
    if(handles.material==1) % aluminum
        handles.elastic_modulus=1e+007;
        handles.mass_density=0.1;  
    end  
    if(handles.material==2)  % steel
        handles.elastic_modulus=3e+007;
        handles.mass_density= 0.28;         
    end
    if(handles.material==3)  % copper
        handles.elastic_modulus=1.6e+007;
        handles.mass_density=  0.322;
    end
    if(handles.material==4)  % G10
        handles.elastic_modulus=2.7e+006;
        handles.mass_density=  0.065;
    end
    if(handles.material==5)  % PVC
        handles.elastic_modulus=3.5e+005;
        handles.mass_density=  0.052;
    end
else                 % metric
    if(handles.material==1)  % aluminum
        handles.elastic_modulus=70;
        handles.mass_density=  2700;
    end
    if(handles.material==2)  % steel
        handles.elastic_modulus=205;
        handles.mass_density=  7700;        
    end
    if(handles.material==3)   % copper
        handles.elastic_modulus=110;
        handles.mass_density=  8900;
    end
    if(handles.material==4)  % G10
        handles.elastic_modulus=18.6;
        handles.mass_density=  1800;
    end
    if(handles.material==5)  % PVC
        handles.elastic_modulus=24.1;
        handles.mass_density=  1440;
    end
end

if(handles.material<6)
    ss1=sprintf('%8.4g',handles.elastic_modulus);
    ss2=sprintf('%8.4g',handles.mass_density);

    set(handles.elasticmoduluseditbox,'String',ss1);
    set(handles.massdensityeditbox,'String',ss2);    
end

guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function crosssectionlistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to crosssectionlistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function crosssectioneditbox1_Callback(hObject, eventdata, handles)
% hObject    handle to crosssectioneditbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of crosssectioneditbox1 as text
%        str2double(get(hObject,'String')) returns contents of crosssectioneditbox1 as a double
handles.thick=0;
handles.diameter=0;
handles.area=0;

string=get(hObject,'String');

handles.cross_section=get(handles.crosssectionlistbox,'Value');

if(handles.cross_section==1) % rectangular
    handles.thick=str2num(string);
end
if(handles.cross_section==2) % pipe
    handles.diameter=str2num(string);   
end
if(handles.cross_section==3) % solid cylinder
    handles.diameter=str2num(string);    
end
if(handles.cross_section==4) % other
    handles.area=str2num(string);     
end


guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function crosssectioneditbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to crosssectioneditbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function crosssectioneditbox2_Callback(hObject, eventdata, handles)
% hObject    handle to crosssectioneditbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of crosssectioneditbox2 as text
%        str2double(get(hObject,'String')) returns contents of crosssectioneditbox2 as a double
string=get(hObject,'String');

handles.cross_section=get(handles.crosssectionlistbox,'Value');

if(handles.cross_section==1) % rectangular
    handles.width=str2num(string);
end
if(handles.cross_section==2) % pipe
    handles.wall_thick=str2num(string);   
end
if(handles.cross_section==3) % solid cylinder
    % nothing to do    
end
if(handles.cross_section==4) % other
    handles.MOI=str2num(string);     
end

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function crosssectioneditbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to crosssectioneditbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in unitslistbox.
function unitslistbox_Callback(hObject, eventdata, handles)
% hObject    handle to unitslistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns unitslistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from unitslistbox

set(handles.uipanel_fn,'Visible','off');

handles.unit=get(handles.unitslistbox,'Value');

guidata(hObject, handles);

material_change(hObject, eventdata, handles);
geometry_change(hObject, eventdata, handles);


if(handles.unit==1)
    set(handles.lengthlabel,'String','inch');
    set(handles.elasticmoduluslabel,'String','Elastic Modulus (lbf/in^2)');
    set(handles.massdensitylabel,'String','Mass Density (lbm/in^3)');
else
    set(handles.lengthlabel,'String','meter');
    set(handles.elasticmoduluslabel,'String','Elastic Modulus (GPa)'); 
    set(handles.massdensitylabel,'String','Mass Density (kg/m^3)');    
end

guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function unitslistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to unitslistbox (see GCBO)
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

handles.unit=get(handles.unitslistbox,'Value');
handles.material=get(handles.listbox_material,'Value');

set(handles.uipanel_fn,'Visible','off');
 
material_change(hObject, eventdata, handles);
 
guidata(hObject, handles);



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


% --- Executes on key press with focus on lengtheditbox and none of its controls.
function lengtheditbox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to lengtheditbox (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_fn,'Visible','off');


% --- Executes on key press with focus on crosssectioneditbox1 and none of its controls.
function crosssectioneditbox1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to crosssectioneditbox1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_fn,'Visible','off');


% --- Executes on key press with focus on crosssectioneditbox2 and none of its controls.
function crosssectioneditbox2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to crosssectioneditbox2 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_fn,'Visible','off');


% --- Executes on key press with focus on elasticmoduluseditbox and none of its controls.
function elasticmoduluseditbox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to elasticmoduluseditbox (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_fn,'Visible','off');


% --- Executes on key press with focus on massdensityeditbox and none of its controls.
function massdensityeditbox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to massdensityeditbox (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_fn,'Visible','off');



function Answer_Callback(hObject, eventdata, handles)
% hObject    handle to Answer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Answer as text
%        str2double(get(hObject,'String')) returns contents of Answer as a double


% --- Executes during object creation, after setting all properties.
function Answer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Answer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function geometry_change(hObject, eventdata, handles)        

handles.unit=get(handles.unitslistbox,'Value');
handles.cross_section=get(handles.crosssectionlistbox,'Value');

set(handles.crosssectioneditbox2,'Enable','on');

if(handles.unit==1)
    if(handles.cross_section==1) % rectangular
        set(handles.crosssectionlabel1,'String','Thickness (in)');
        set(handles.crosssectionlabel2','String','Width (in)');
    end
    if(handles.cross_section==2) % pipe 
        set(handles.crosssectionlabel1,'String','Outer Diameter (in)');
        set(handles.crosssectionlabel2,'String','Wall Thickness (in)');    
    end
    if(handles.cross_section==3) % solid cylinder
        set(handles.crosssectionlabel1,'String','Diameter (in)');
        set(handles.crosssectionlabel2,'String',''); 
        set(handles.crosssectioneditbox2,'Enable','off');
    end
    if(handles.cross_section==4) % other
        set(handles.crosssectionlabel1,'String','Area (in^2)');
        set(handles.crosssectionlabel2,'String','Area Moment of Inertia(in^4)');
    end
else
    if(handles.cross_section==1) % rectangular
        set(handles.crosssectionlabel1,'String','Thickness (mm)');
        set(handles.crosssectionlabel2','String','Width (mm)');
    end
    if(handles.cross_section==2) % pipe 
        set(handles.crosssectionlabel1,'String','Outer Diameter (mm)');
        set(handles.crosssectionlabel2,'String','Wall Thickness (mm)');    
    end
    if(handles.cross_section==3) % solid cylinder
        set(handles.crosssectionlabel1,'String','Diameter (mm)');
        set(handles.crosssectionlabel2,'String',''); 
        set(handles.crosssectioneditbox2,'Enable','off');
    end
    if(handles.cross_section==4) % other
        set(handles.crosssectionlabel1,'String','Area (mm^2)');
        set(handles.crosssectionlabel2,'String','Area Moment of Inertia(mm^4)');      
    end
end

set(handles.crosssectioneditbox1,'String',' ');
set(handles.crosssectioneditbox2,'String',' ');

handles.thick=0;
handles.width=0;

handles.diameter=0;
handles.wall_thick=0;

handles.MOI=0;
handles.area=0;

% Update handles structure
guidata(hObject, handles);

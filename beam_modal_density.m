function varargout = beam_modal_density(varargin)
% BEAM_MODAL_DENSITY MATLAB code for beam_modal_density.fig
%      BEAM_MODAL_DENSITY, by itself, creates a new BEAM_MODAL_DENSITY or raises the existing
%      singleton*.
%
%      H = BEAM_MODAL_DENSITY returns the handle to a new BEAM_MODAL_DENSITY or the handle to
%      the existing singleton*.
%
%      BEAM_MODAL_DENSITY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BEAM_MODAL_DENSITY.M with the given input arguments.
%
%      BEAM_MODAL_DENSITY('Property','Value',...) creates a new BEAM_MODAL_DENSITY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before beam_modal_density_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to beam_modal_density_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help beam_modal_density

% Last Modified by GUIDE v2.5 15-Dec-2015 15:41:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @beam_modal_density_OpeningFcn, ...
                   'gui_OutputFcn',  @beam_modal_density_OutputFcn, ...
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


% --- Executes just before beam_modal_density is made visible.
function beam_modal_density_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to beam_modal_density (see VARARGIN)

% Choose default command line output for beam_modal_density
handles.output = hObject;

change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes beam_modal_density wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = beam_modal_density_OutputFcn(hObject, eventdata, handles) 
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

delete(beam_modal_density);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp('****');
disp(' ');


tpi=2*pi;

iu=get(handles.listbox_units,'Value');
ns=get(handles.listbox_structure,'Value');
nc=get(handles.listbox_cross,'Value');
imat=get(handles.listbox_material,'Value');

L=str2num(get(handles.edit_L,'String')); 

setappdata(0,'iu',iu);
setappdata(0,'ns',ns);
setappdata(0,'nc',nc);
setappdata(0,'imat',imat);
setappdata(0,'L',L);

em=str2num(get(handles.edit_em,'String'));
md=str2num(get(handles.edit_md,'String'));
    
if(iu==1)
    md=md/386;
    su='in/sec';
else    
    [em]=GPa_to_Pa(em);
    su='m/sec';
end
    
c=sqrt(em/md);

[~,fc,~,~,fmin,fmax]=SEA_one_third_octave_frequencies_max_min();

f=fc;
f=fix_size(f);

if(ns==1)
    
    
    if(nc==1)
        stitle='Beam Bending, Rectangular'; 
    end
    if(nc==2)
        stitle='Beam Bending, Pipe';         
    end
    if(nc==3)
        stitle='Beam Bending, Solid Cylinder'; 
    end
    if(nc==4)
        stitle='Beam Bending, Other';         
    end
    disp(stitle);
    
     intermediate_print(hObject, eventdata, handles);
       
    
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
        
    fl=length(f);
    
    mph=zeros(fl,1);
    
    for i=1:fl
        [beam_md,~]=sea_beam_modal_density(I,A,em,md,f(i),L);
        mph(i)=beam_md;
    end
     
    
end    


if(ns==2)
    
    stitle='Beam Longitudinal'; 
    disp(stitle);
       
    intermediate_print(hObject, eventdata, handles);
    
end

if(ns==3)
        
    if(nc==1)
        stitle='Beam Torsional, Rectangular'; 
    end
    if(nc==2)
        stitle='Beam Torsional, Pipe';         
    end
    if(nc==3)
        stitle='Beam Torsional, Solid Cylinder'; 
    end
    if(nc==4)
        stitle='Beam Torsional, Other';         
    end
    disp(stitle); 

    intermediate_print(hObject, eventdata, handles);
    
    
    mu=str2num(get(handles.edit_mu,'String'));
    G=em/(2*(1+mu));
    
    if(nc==1) % rectangular
        
        if(nc==1)  % rectangular
            H=str2num(get(handles.edit_H,'String'));
            W=str2num(get(handles.edit_width,'String'));
        end
            
        if(iu==2)
           H=H/1000;
           W=W/1000;
        end
        
         b=W; 
         h=H;
                 
         Ip=(b*h/3)*(b^2+h^2);

         a=max([b h]);
         b=min([b h]);
         r=b/a;
         
         J=(a*b^3)*((1/3)-0.21*r*(1-((r^4)/12)));  % wikipedia torsion constant 
         c=sqrt(G*J/(md*Ip));
         
    end
    
    
    if(nc==4)  %other
        
        Ix=str2num(get(handles.edit_Ix,'String'));
        Iy=str2num(get(handles.edit_Ix,'String'));
        Ip=str2num(get(handles.edit_I,'String'));
        
        if(iu==2)
           Ix=Ix/1000^4; 
           Iy=Iy/1000^4; 
           Ip=Ip/1000^4;            
        end
        
        J=4*Ix*Iy/(Ix+Iy);
        c=sqrt(G*J/(md*Ip));
    end

    if(nc==2 || nc==3)  % pipe or cylinder
         c=sqrt(G/md); 
    end
end 

if(ns==2 || ns==3)
    
    modal_density=L/(pi*c);
    mph=modal_density*tpi;
    
    out10=sprintf('\n Phase Velocity = %8.4g %s',c,su);
    disp(out10);
      
    out1=sprintf('\n Modal Density = %8.4g (modes/rad)',modal_density);
    out2=sprintf('               = %8.4g (modes/Hz)',mph);
    
    disp(out1);
    disp(out2);  
    
    mph=mph*ones(length(f),1);
end


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
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    figure(1);
    plot(f,mph);
    stitle=sprintf('Modal Density  %s',stitle);
    title(stitle);
   
    xlabel('Frequency (Hz)');
    ylabel('Modal Density (modes/Hz)');
    
    [xtt,xTT,iflag]=xtick_label(fmin,fmax);

    if(iflag==1)
        set(gca,'xtick',xtt);
        set(gca,'XTickLabel',xTT);
    end    
   
    xlim([20,20000]);
    
    set(gca,'XGrid','on','GridLineStyle',':');
    set(gca,'YGrid','on','GridLineStyle',':');    
    
    if(ns==1)
    
        set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');   
             
    else
        
      yLimits = get(gca,'YLim');
    
      [yh]=yaxis_limits_linear(yLimits,mph);

        ylim([0,yh]);  
        
        set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
                     'YScale','lin','XminorTick','off','YminorTick','off');   
                     
    end
                 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
msgbox('Results written to Command Window');






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
iu=get(handles.listbox_units,'Value');
ns=get(handles.listbox_structure,'Value');
imat=get(handles.listbox_material,'Value');

nc=get(handles.listbox_cross,'Value');

%%%

set(handles.text_material,'Visible','on');
set(handles.listbox_material,'Visible','on');
set(handles.text_em,'Visible','on');
set(handles.edit_em,'Visible','on');
set(handles.text_md,'Visible','on');
set(handles.edit_md,'Visible','on');


set(handles.text_Ix,'Visible','off');
set(handles.edit_Ix,'Visible','off')       
set(handles.text_Iy,'Visible','off');
set(handles.edit_Iy,'Visible','off')   

set(handles.text_r1,'Visible','off');
set(handles.text_r2,'Visible','off');
set(handles.edit_r1,'Visible','off');
set(handles.edit_r2,'Visible','off');

set(handles.text_mu,'Visible','off');
set(handles.edit_mu,'Visible','off');


set(handles.text_cross,'Visible','off'); 
set(handles.listbox_cross,'Visible','off'); 

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
    set(handles.text_em,'String','Elastic Modulus (psi)');
    set(handles.text_md,'String','Mass Density (lbm/in^3)');    
else
    set(handles.text_L,'String','Length (m)');  
    set(handles.text_width,'String','Width (mm)'); 
    set(handles.text_H,'String','Thickness (mm)');    
    set(handles.text_area,'String','Cross Section Area (mm^2)');
    set(handles.text_I,'String','Area Moment Inertia (mm^4)');    
    set(handles.text_em,'String','Elastic Modulus (GPa)');
    set(handles.text_md,'String','Mass Density (kg/m^3)');      
end

if(ns==1 || ns==3)  % bending or torsion
        
    set(handles.text_cross,'Visible','on'); 
    set(handles.listbox_cross,'Visible','on');
    
    if(nc==1)  % rectangular
        set(handles.edit_width,'Visible','on'); 
        set(handles.text_width,'Visible','on');
        set(handles.edit_H,'Visible','on'); 
        set(handles.text_H,'Visible','on');
    end     
end    

if(ns==1)  % bending 
        
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
    
end

if(ns==1) % bending
    if(nc==4) % other
        set(handles.text_area,'Visible','on');
        set(handles.edit_area,'Visible','on');
        set(handles.text_I,'Visible','on');
        set(handles.edit_I,'Visible','on');        
    end
end

if(ns==3) % torsional
    set(handles.text_mu,'Visible','on');
    set(handles.edit_mu,'Visible','on');
    
    if(nc==4) % other
        set(handles.text_I,'Visible','on');
        set(handles.edit_I,'Visible','on');         
        set(handles.text_Ix,'Visible','on');
        set(handles.edit_Ix,'Visible','on')       
        set(handles.text_Iy,'Visible','on');
        set(handles.edit_Iy,'Visible','on')    
        
        if(iu==1)
            set(handles.text_I,'String','Polar Moment Inertia (in^4)');  
            set(handles.text_Ix,'String','Ix Moment Inertia (in^4)');   
            set(handles.text_Iy,'String','Iy Moment Inertia (in^4)');               
        else
            set(handles.text_I,'String','Polar Moment Inertia (mm^4)');  
            set(handles.text_Ix,'String','Ix Moment Inertia (mm^4)'); 
            set(handles.text_Iy,'String','Iy Moment Inertia (mm^4)');             
        end    
    end
    
end    


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
 
 
    if(imat<5)
        ss1=sprintf('%8.4g',elastic_modulus);
        ss2=sprintf('%8.4g',mass_density);
        ss3=sprintf('%8.4g',poisson);  
 
        set(handles.edit_em,'String',ss1);
        set(handles.edit_md,'String',ss2);  
        set(handles.edit_mu,'String',ss3);   

    end

    if(imat==5)
        set(handles.edit_em,'String',' ');
        set(handles.edit_md,'String',' ');  
    end
 

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
    L=getappdata(0,'L');

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
    
    
    if(iu==1)
        out1=sprintf(' Length=%g in',L);
    else
        out1=sprintf(' Length=%g m',L);
    end
    disp(out1);


% --- Executes on button press in pushbutton_eq.
function pushbutton_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


ns=get(handles.listbox_structure,'Value');

if(ns==1)
    A = imread('beam_bending_md.jpg');
    figure(997) 
    imshow(A,'border','tight','InitialMagnification',100)
end
if(ns==2)
    A = imread('beam_longitudinal_md.jpg');
    figure(998) 
    imshow(A,'border','tight','InitialMagnification',100) 
end
if(ns==3)
    A = imread('beam_torsional_md.jpg');
    figure(999) 
    imshow(A,'border','tight','InitialMagnification',100)  
end

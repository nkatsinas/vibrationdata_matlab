function varargout = structural_wavespeed(varargin)
% STRUCTURAL_WAVESPEED MATLAB code for structural_wavespeed.fig
%      STRUCTURAL_WAVESPEED, by itself, creates a new STRUCTURAL_WAVESPEED or raises the existing
%      singleton*.
%
%      H = STRUCTURAL_WAVESPEED returns the handle to a new STRUCTURAL_WAVESPEED or the handle to
%      the existing singleton*.
%
%      STRUCTURAL_WAVESPEED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STRUCTURAL_WAVESPEED.M with the given input arguments.
%
%      STRUCTURAL_WAVESPEED('Property','Value',...) creates a new STRUCTURAL_WAVESPEED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before structural_wavespeed_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to structural_wavespeed_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help structural_wavespeed

% Last Modified by GUIDE v2.5 18-Dec-2015 09:50:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @structural_wavespeed_OpeningFcn, ...
                   'gui_OutputFcn',  @structural_wavespeed_OutputFcn, ...
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


% --- Executes just before structural_wavespeed is made visible.
function structural_wavespeed_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to structural_wavespeed (see VARARGIN)

% Choose default command line output for structural_wavespeed
handles.output = hObject;

listbox_units_Callback(hObject, eventdata, handles);

set(handles.uipanel_results,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes structural_wavespeed wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = structural_wavespeed_OutputFcn(hObject, eventdata, handles) 
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

delete(structural_wavespeed);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end    


itype=get(handles.listbox_type,'Value');

if(itype==5)
    handles.s=honeycomb_sandwich_wavespeed;
    set(handles.s,'Visible','on');   
end

tpi=2*pi;

[~,fc,~,NL,fmin,fmax]=SEA_one_third_octave_frequencies_max_min();

disp(' '); 
disp(' * * * ');

   iu=get(handles.listbox_units,'Value');

    E=str2num(get(handles.edit_em,'String'));
   md=str2num(get(handles.edit_md,'String'));

Nfc=length(fc);
sound=ones(Nfc,1);
   
if(iu==1)
    sound=sound*1125*12;
    md=md/386;
else
    sound=sound*343;
   [E]=GPa_to_Pa(E);
end

disp(' ');

if(itype==1 || itype==3)
     CLII=sqrt(E/md);
end    
if(itype==2 || itype==4)
    mu=str2num(get(handles.edit_mu,'String'));    
    term=1-mu^2;
     CLI=sqrt(E/(md*term));
end    

if(itype==1)  % longitudinal rod
    disp(' Longitudinal, Rod ');  
    c=CLII;    
end
if(itype==2)  % longitudinal plate 
    disp(' Longitudinal, Plate ');      
    c=CLI;
end

if(itype==3 || itype==4)  % bending beam or plate
    fs=get(handles.edit_frequency,'String');  
    
    if isempty(fs)
        msgbox('Enter Frequency');
        return;
    else
        f=str2num(fs);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(itype==3)  % bending beam
    disp(' Bending, Beam ');    
    
    nc=get(handles.listbox_cross,'Value');
    
    if(nc==1 || nc==2)
        
        h=str2num(get(handles.edit_thickness,'String'));        
        
        if(iu==2)
            h=h/1000;               
        end        
        
    end
    
    if(nc==1)   % rectangular
             
        width=str2num(get(handles.edit_width,'String')); 
        
        if(iu==2)
            width=width/1000;               
        end
        
          MOI=(1/12)*width*h^3;
         area=width*h;
    end    
    
    if(nc==2 || nc==3)

        diameter=str2num(get(handles.edit_diameter,'String'));         
        
        if(iu==2)
            diameter=diameter/1000;                 
        end           
    end
    
    if(nc==2)  % pipe
        wall_thick=h;  
        [area,MOI,~]=pipe_geometry_wall(diameter,wall_thick);
    end
    
    if(nc==3)  % solid cylinder
        [area,MOI,~]=cylinder_geometry(diameter); 
    end
    
    if(nc==4)  % other
        area=str2num(get(handles.edit_area,'String'));
         MOI=str2num(get(handles.edit_MOI,'String'));     
         
         if(iu==2)
            area=area/1000^2; 
             MOI=MOI/1000^4;             
         end
    end    
    
%%    B=E*MOI;   leave as reference

    omega=tpi*f;
    
%    for the specific input frequency
    [c]=beam_bending_phase_speed(E,MOI,md,omega,area); 
    
    ff=zeros(NL,1);
    cc=zeros(NL,1);
    Clong=zeros(NL,1);
    
    for k=1:NL
       
        ff(k)=fc(k);
        omega=tpi*ff(k);
        cc(k)=beam_bending_phase_speed(E,MOI,md,omega,area);         
        Clong(k)=CLII;            
        
    end     
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(itype==4)  % bending plate
    disp(' Bending, Plate ');
    
    h=str2num(get(handles.edit_thickness,'String'));
    
    if(iu==2)
        h=h/1000;        
    end
    
    omega=tpi*f;
     
    [c]=plate_bending_phase_speed(E,md,mu,h,omega);
    
    ff=zeros(NL,1);
    cc=zeros(NL,1);
    Clong=zeros(NL,1);
    
    for k=1:NL
       
        ff(k)=fc(k);
        omega=tpi*ff(k);
        cc(k)=plate_bending_phase_speed(E,md,mu,h,omega); 
        
        Clong(k)=CLI;
        
    end         
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(itype~=5)

    if(itype==3 || itype==4)   % beam or plate bending    
        fprintf('\n Freq = %8.4g Hz \n',f);
    end
    
    disp('  ');
    disp('  Phase Speed ');
    disp('  ');
    if(iu==1)
        fprintf('   c = %9.6g in/sec \n',c);
        sss=sprintf('%9.6g in/sec',c);
        fprintf('     = %9.6g ft/sec \n',c/12);    
    else
        fprintf('   c = %9.6g m/sec \n',c);
        sss=sprintf('%9.6g m/sec',c);       
    end 

    if(itype==3 || itype==4)   % beam or plate bending
        
        lambda=c/f;
    
        if(iu==1)
            fprintf('\n Wavelength = %8.4g in \n',lambda);    
        else
            fprintf('\n Wavelength = %8.4g m \n',lambda);          
        end
        
        if(itype==4)
            [fcr]=critical_frequency_thin_plate(sound(1),h,mu,md,E);
            fprintf('\n Critical Frequency = %8.4g Hz \n',fcr);
        end        
 
    end    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if(itype==3 || itype==4)  % beam or plate bending
        
        cmap(1,:)=[0 0.1 0.4];      % dark blue
        cmap(2,:)=[0.8 0 0];        % red
        cmap(3,:)=[0 0 0];          % black
        cmap(4,:)=[0.6 0.3 0];      % brown
        cmap(5,:)=[0 0.5 0.5];      % teal
        cmap(13,:)=[0.05 0.7 1.];   % light blue
        
        hp=figure(1);

        hold on;
        plot(ff,Clong,'Color',cmap(3,:),'DisplayName','Longitudinal');
        plot(ff,2*cc,'Color',cmap(2,:),'DisplayName','Bending Group');
        plot(ff,cc,'Color',cmap(13,:),'DisplayName','Bending Phase');
        plot(ff,sound,'--','Color',cmap(5,:),'DisplayName','Ambient Airborne Sound');      
        % plot(fcr,sound(1),'o','Color',cmap(5,:),'DisplayName','Critical Frequency');
        
        legend('location','eastoutside');
        set(hp, 'Position', [0 0 700 450]);
        
        xlabel('Freq (Hz)');
        grid on;
        if(iu==1)
            ylabel('Speed (in/sec)');       
        else
            ylabel('Speed (m/sec)');         
        end
        if(itype==3)
            title('Beam Wave Speed');
        else
            title('Plate Wave Speed');       
        end
%
        [xtt,xTT,iflag]=xtick_label(fmin,fmax);

        if(iflag==1)
            set(gca,'xtick',xtt);
            set(gca,'XTickLabel',xTT);
        end
        xlim([fmin,fmax]);

        set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%   
        yymin=min(cc);
        yymax=max([ max(Clong) max(cc)  ]);
    
        yymax=4*yymax;

        ymin=10^(floor(log10(yymin)));
        ymax=10^(ceil(log10(yymax)));
        ylim([ymin ymax]);
        
        hold off;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        if(itype==4)
            
            sound_wavelength=zeros(NL,1);
            plate_wavelength=zeros(NL,1);
            
            for i=1:NL
                sound_wavelength(i)=sound(i)/ff(i);
                plate_wavelength(i)=cc(i)/ff(i);
            end
            
            fig_num=2;
            
            ppp1=[ff sound_wavelength];
            ppp2=[ff plate_wavelength];
            
            x_label='Frequency (Hz)';
            y_label='Wavelength (in)';
            md=5;
            leg1='Airborne Sound';
            leg2='Plate Bending';
            fmin=ff(1);
            fmax=ff(NL);
            t_string='Wavelength';
     
            [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);
            
        end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    end    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    set(handles.uipanel_results,'Visible','on');
    set(handles.edit_results,'String',sss);

    if(itype==3 || itype==4)
        cgroup=2*c;
        set(handles.text_v1,'String','Bending Phase Velocity');  
        set(handles.text_v2,'String','Bending Group Velocity');     
    else
        cgroup=c;   
        set(handles.text_v1,'String','Longitudinal Phase Velocity');  
        set(handles.text_v2,'String','Longitudinal Group Velocity');      
    end

    if(iu==1)
        ssg=sprintf('%9.6g in/sec',cgroup);
    else
        ssg=sprintf('%9.6g m/sec',cgroup);   
    end 

    set(handles.edit_results,'String',sss);
    set(handles.edit_group,'String',ssg);

end

% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type

set(handles.uipanel_results,'Visible','off');

itype=get(handles.listbox_type,'Value');

if(itype<=4)
    material_change(hObject, eventdata, handles);
else
    handles.s=honeycomb_sandwich_wavespeed;
    set(handles.s,'Visible','on');   
end




% --- Executes during object creation, after setting all properties.
function listbox_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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

%
iu=get(handles.listbox_units,'Value');
imat=get(handles.listbox_material,'Value');
%

if(iu==1)
   set(handles.text_em,'String','Elastic Modulus (psi)');
   set(handles.text_md,'String','Mass Density (lbm/in^3)'); 
   set(handles.text_thickness,'String','Thickness (in)');  
   set(handles.text_width,'String','Width (in)');   
   set(handles.text_diameter,'String','Diameter (in)');   
else
   set(handles.text_em,'String','Elastic Modulus (GPa)'); 
   set(handles.text_md,'String','Mass Density (kg/m^3)');
   set(handles.text_thickness,'String','Thickness (mm)');  
   set(handles.text_width,'String','Width (mm)'); 
   set(handles.text_diameter,'String','Diameter (mm)');    
end
 
material_change(hObject, eventdata, handles);


function material_change(hObject, eventdata, handles)
%

set(handles.uipanel_results,'Visible','off');

iu=get(handles.listbox_units,'Value');
imat=get(handles.listbox_material,'Value');
%
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

%%%%%%%%%%

set(handles.edit_thickness,'Visible','off');
set(handles.text_thickness,'Visible','off');
set(handles.text_width,'Visible','off');
set(handles.edit_width,'Visible','off');
set(handles.text_frequency,'Visible','off');
set(handles.edit_frequency,'Visible','off');
set(handles.text_mu,'Visible','off');
set(handles.edit_mu,'Visible','off'); 
set(handles.text_cross,'Visible','off');
set(handles.listbox_cross,'Visible','off');
set(handles.edit_diameter,'Visible','off');
set(handles.text_diameter,'Visible','off');
set(handles.text_area,'Visible','off');
set(handles.edit_area,'Visible','off');
set(handles.text_inertia,'Visible','off');
set(handles.edit_MOI,'Visible','off');


itype=get(handles.listbox_type,'Value');


if(itype==2 || itype==4 )
    set(handles.text_mu,'Visible','on');
    set(handles.edit_mu,'Visible','on');   
end

if(itype==4)
    set(handles.text_thickness,'Visible','on');
    set(handles.edit_thickness,'Visible','on');   
end

if(itype==3 || itype==4)
    set(handles.text_frequency,'Visible','on');
    set(handles.edit_frequency,'Visible','on');   
end



if(itype==3)
    set(handles.text_cross,'Visible','on');
    set(handles.listbox_cross,'Visible','on');
    
    nc=get(handles.listbox_cross,'Value');
    
    if(nc==1)
        set(handles.text_thickness,'Visible','on');
        set(handles.edit_thickness,'Visible','on');
        set(handles.text_width,'Visible','on');
        set(handles.edit_width,'Visible','on');  
        
        if(iu==1)        
            set(handles.text_thickness,'String','Thickness (in)');
        else
            set(handles.text_thickness,'String','Thickness (mm)');            
        end         
        
    end
    if(nc==2)
        set(handles.edit_diameter,'Visible','on');
        set(handles.text_diameter,'Visible','on');   
        set(handles.text_thickness,'Visible','on');
        set(handles.edit_thickness,'Visible','on');        
        
        if(iu==1)
            set(handles.text_diameter,'String','Outer Diameter (in)');
            set(handles.text_thickness,'String','Wall Thickness (in)');            
        else
            set(handles.text_diameter,'String','Outer Diameter (mm)'); 
            set(handles.text_thickness,'String','Wall Thickness (mm)');            
        end
        
    end  
    if(nc==3)
        set(handles.edit_diameter,'Visible','on');
        set(handles.text_diameter,'Visible','on');
        
        if(iu==1)        
            set(handles.text_diameter,'String','Diameter (in)');
        else
            set(handles.text_diameter,'String','Diameter (mm)');            
        end        
    end  
    if(nc==4)
        set(handles.text_area,'Visible','on');
        set(handles.edit_area,'Visible','on');
        set(handles.text_inertia,'Visible','on');
        set(handles.edit_MOI,'Visible','on');
        
        if(iu==1)        
            set(handles.text_area,'String','Area (in^2)');
            set(handles.text_inertia,'String','Inertia (in^4)');            
        else
            set(handles.text_area,'String','Area (mm^2)'); 
            set(handles.text_inertia,'String','Inertia (mm^4)');              
        end        
        
    end 
    
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


% --- Executes on selection change in listbox_material.
function listbox_material_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_material

material_change(hObject, eventdata, handles);


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



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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



function edit_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to edit_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_frequency as text
%        str2double(get(hObject,'String')) returns contents of edit_frequency as a double


% --- Executes during object creation, after setting all properties.
function edit_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_frequency (see GCBO)
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

material_change(hObject, eventdata, handles);


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



function edit_results_Callback(hObject, eventdata, handles)
% hObject    handle to edit_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_results as text
%        str2double(get(hObject,'String')) returns contents of edit_results as a double


% --- Executes during object creation, after setting all properties.
function edit_results_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_frequency and none of its controls.
function edit_frequency_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_frequency (see GCBO)
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


% --- Executes on key press with focus on edit_width and none of its controls.
function edit_width_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_width (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');


% --- Executes on key press with focus on edit_thickness and none of its controls.
function edit_thickness_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');


% --- Executes on key press with focus on edit_diameter and none of its controls.
function edit_diameter_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_diameter (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');


% --- Executes on key press with focus on edit_area and none of its controls.
function edit_area_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_area (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');


% --- Executes on key press with focus on edit_MOI and none of its controls.
function edit_MOI_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_MOI (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');



function edit_group_Callback(hObject, eventdata, handles)
% hObject    handle to edit_group (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_group as text
%        str2double(get(hObject,'String')) returns contents of edit_group as a double


% --- Executes during object creation, after setting all properties.
function edit_group_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_group (see GCBO)
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

n=get(handles.listbox_type,'Value');

if(n<=2)
    A = imread('Longitudinal_speed.jpg');
    figure(998)  
else
    A = imread('Bending_speed.jpg');
    figure(999)     
end

imshow(A,'border','tight','InitialMagnification',100);

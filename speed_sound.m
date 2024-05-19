function varargout = speed_sound(varargin)
% SPEED_SOUND MATLAB code for speed_sound.fig
%      SPEED_SOUND, by itself, creates a new SPEED_SOUND or raises the existing
%      singleton*.
%
%      H = SPEED_SOUND returns the handle to a new SPEED_SOUND or the handle to
%      the existing singleton*.
%
%      SPEED_SOUND('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPEED_SOUND.M with the given input arguments.
%
%      SPEED_SOUND('Property','Value',...) creates a new SPEED_SOUND or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before speed_sound_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to speed_sound_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help speed_sound

% Last Modified by GUIDE v2.5 20-Feb-2014 09:10:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @speed_sound_OpeningFcn, ...
                   'gui_OutputFcn',  @speed_sound_OutputFcn, ...
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


% --- Executes just before speed_sound is made visible.
function speed_sound_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to speed_sound (see VARARGIN)

% Choose default command line output for speed_sound
handles.output = hObject;

set(handles.listbox_unit,'Value',1);
set(handles.listbox_medium,'Value',1);
set(handles.listbox_item,'Value',1);
set(handles.listbox_degrees,'Value',1);
set(handles.listbox_method,'Value',1);

listbox_unit_Callback(hObject, eventdata, handles);
listbox_medium_Callback(hObject, eventdata, handles);
listbox_method_Callback(hObject, eventdata, handles);

set(handles.uipanel_enter_properties_gas_liquid,'Visible','off');
set(handles.uipanel_enter_properties_solid,'Visible','off');

clear_results(hObject, eventdata, handles);

change_select_method(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes speed_sound wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = speed_sound_OutputFcn(hObject, eventdata, handles) 
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
n_medium=get(handles.listbox_medium,'Value');

if(n_medium==1)
    gas(hObject, eventdata, handles);
end
if(n_medium==2)
    liquid(hObject, eventdata, handles);    
end
if(n_medium==3)
    solid(hObject, eventdata, handles);    
end


function gas(hObject, eventdata, handles)
%
n=get(handles.listbox_item,'Value');

n_method=get(handles.listbox_method,'Value');

n_unit=get(handles.listbox_unit,'Value');

ft_per_m=3.28084;
in_per_m=39.3701;


if(n<=5 && n_method==1 || (n==6 && n_method==3))
    T=str2num(get(handles.edit_temperature,'String'));
    
    n_temp=get(handles.listbox_degrees,'Value');
    
    if(n_temp==1)
       Tk=T; 
    end
    if(n_temp==2)
       Tk=T+273.15;
    end
    if(n_temp==3)
       Tc=(T-32)*5/9;
       Tk=Tc+273.15;
    end
    
end


R=8314.3;  % J?/(kgmole K)


if(n==1) % air
    ratio=1.402;
    M=28.97;
end
if(n==2) % oxygen
    ratio=1.40;
    M=32;
end
if(n==3) % CO2
    ratio=1.40;
    M=44;
end
if(n==4) % hydrogen
    ratio=1.41;
    M=2.016;
end
if(n==5) % steam
    ratio=1.324;
    M=18.02;
end

if(n<=5)
    if(n_method==1)
        c=sqrt(ratio*R*Tk/M);
    else
        
        pressure=str2num(get(handles.edit_pressure,'String'));
        rho=str2num(get(handles.edit_mass_density_gas_liquid,'String'));
        
        if(n_unit==1) % convert from English to metric
            pressure=pressure*6894.75729;
            rho=rho*27675;
        end
                
        c=sqrt(ratio*pressure/rho);        
    end    
end


if(n<=5)
    if(n_unit==1)
        c_ips=c*in_per_m;
        c_fps=c*ft_per_m;
        
        s1=sprintf(' %9.5g ft/sec \n\n %9.5 in/sec',c_fps,c_ips);
    else
        s1=sprintf(' %9.5g m/sec',c);        
    end   
end    

if(n==6) % other gas
    
    if(n_method>=2)
        ratio=str2num(get(handles.edit_ratio_specific_heats,'String'));
    end
    
    if(n_method<=2)
            
        modulus=str2num(get(handles.edit_bulk_modulus,'String'));
         
        mass_density=str2num(get(handles.edit_mass_density_gas_liquid,'String'));
     
        if(n_unit==1)
            mass_density=mass_density/386;
        end
    
        c=sqrt(modulus/mass_density);

        if(n_method==1) % adiabatic
        
        else            % isothermal
            c=c*sqrt(ratio); 
        end
    
    end
        

    if(n_method==3) % perfect gas temperature
        
         M=str2num(get(handles.edit_molecular_weight,'String'));
                  
         c=sqrt(ratio*R*Tk/M);
         
    end
    if(n_method==4) % perfect gas pressure
            
         pressure=str2num(get(handles.edit_pressure,'String'));
         rho=str2num(get(handles.edit_mass_density_gas_liquid,'String'));
        
         if(n_unit==1) % convert from English to metric
            pressure=pressure*6894.75729;
            rho=rho*27675;
         end
                
         c=sqrt(ratio*pressure/rho); 
    end    
    
    if(n_unit==1)
         c_ips=c*in_per_m;
         c_fps=c*ft_per_m;
       
         s1=sprintf(' %9.5g ft/sec \n\n %9.5g in/sec',c_fps,c_ips);
    else
         s1=sprintf(' %9.5g m/sec',c);        
    end    
    
end

sq='';
set(handles.edit_speed,'String',sq,'Max',5);

set(handles.edit_speed,'Visible','on');
set(handles.edit_speed,'String',s1,'Max',5);


function liquid(hObject, eventdata, handles)
%

ft_per_m=3.28084;
in_per_m=39.3701;

n=get(handles.listbox_item,'Value');
n_unit=get(handles.listbox_unit,'Value');

n_method=get(handles.listbox_method,'Value');

iflag=1;

if(n==1) % fresh water
    c=1481;
end
if(n==2) % sea water
    c=1500;
end
if(n==3) % mercury
    c=1450;
end
if(n==4) % turpentine
    c=1250;
end

if(n<=4)
    
    if(n_unit==1)
        c_fps=c*ft_per_m;
        c_ips=c*in_per_m;
        s1=sprintf(' %9.5g ft/sec \n\n %9.5 in/sec',c_fps,c_ips);
    else
        s1=sprintf(' %9.5g m/sec',c);
    end
end    

if(n==5) % other liquid
      
    modulus=str2num(get(handles.edit_bulk_modulus,'String'));
         
    mass_density=str2num(get(handles.edit_mass_density_gas_liquid,'String'));
     
    if(n_unit==1)
        mass_density=mass_density/386;
    end
   

    
    c=sqrt(modulus/mass_density);

    if(n_method==1) % adiabatic
        
    else            % isothermal
        ratio=str2num(get(handles.edit_ratio_specific_heats,'String'));

        c=c*sqrt(ratio); 
    end
    
    if(n_unit==1)
        c_ips=c;
        c_fps=c/12.;
       
        s1=sprintf(' %9.5g ft/sec \n\n %9.5g in/sec',c_fps,c_ips);
    else
        s1=sprintf(' %9.5g m/sec',c);        
    end

end

set(handles.edit_speed,'Visible','on');
set(handles.edit_speed,'String',s1,'Max',5);


function solid(hObject, eventdata, handles)
%
n=get(handles.listbox_item,'Value');
%

n_unit=get(handles.listbox_unit,'Value');

ft_per_m=3.28084;
in_per_m=39.3701;

if(n==1) % Aluminum
    bar=5100;
    bulk=6300;
    iflag=2;
end
if(n==2) % Brass
    bar=3500;
    bulk=4700;
    iflag=2;
end
if(n==3) % Copper
    bar=3700;
    bulk=5000;    
    iflag=2;    
end
if(n==4) % Cast Iron
    bar=3700;
    bulk=4350;
    iflag=2;    
end
if(n==5) % Lead
    bar=1200;
    bulk=2050;
    iflag=2;   
end
if(n==6) % Nickel
    bar=4900;
    bulk=5850;
    iflag=2;      
end
if(n==7) % Silver
    bar=2700;
    bulk=3700;
    iflag=2;      
end
if(n==8) % Steel
    bar=5050;
    bulk=6100;
    iflag=2;      
end
if(n==9) % Pyrex Glass
    bar=5200;
    bulk=5600;
    iflag=2;      
end
if(n==10) % Quartz
    bar=5450;
    bulk=5750;
    iflag=2;      
end
if(n==11) % Lucite
    bar=1800;
    bulk=2650;
    iflag=2;      
end 
if(n==12) % Concrete
    bulk=3100;
    iflag=1;      
end
if(n==13) % Ice
    bulk=3200;
    iflag=1;      
end
if(n==14) % Cork
    bulk=500;
    iflag=1;
end
if(n==15) % Oak
    bulk=4000;
    iflag=1;
end
if(n==16) % Pine
    bulk=3500;
    iflag=1;    
end
if(n==17) % Hard Rubber
    bar=1450;
    bulk=2400;
    iflag=2;       
end
if(n==18) % Soft Rubber
    bulk=1050;
    iflag=1;      
end
if(n==19) % Rho-c Rubber
    bulk=1550;
    iflag=1;      
end
if(n==20) % Other Solid
    
    E=str2num(get(handles.edit_elastic_modulus,'String'));
    
    v=str2num(get(handles.edit_poisson,'String'));
    
    rho=str2num(get(handles.edit_mass_density,'String'));
    
    if(n_unit==1)
        rho=rho/386;
    end    
    
    bar=sqrt(E/rho);
    
    G=E/(2*(1+v));
    B=E/(3*(1-2*v));
    
    num=B+(4/3)*G;
    
    bulk=sqrt(num/rho);
    
    if(n_unit==1)
        
        bar_ips=bar;
        bar_fps=bar/12;
        
        bulk_ips=bulk;        
        bulk_fps=bulk/12;
        
        s1=sprintf(' bar = %9.5g ft/sec \n bulk = %9.5g ft/sec \n\n bar = %9.5g in/sec \n bulk = %9.5g in/sec ',...
                                        bar_fps,bulk_fps,bar_ips,bulk_ips);        
    else
        s1=sprintf(' bar = %9.5g m/sec \n bulk = %9.5g m/sec ',bar,bulk);
    end    
    
    iflag=3;
    
end

if(iflag==1)
    if(n_unit==1)
        bulk_fps=bulk*ft_per_m;
        bulk_ips=bulk*in_per_m; 
        
        s1=sprintf(' bulk = %9.5g ft/sec \n bulk = %9.5g in/sec',bulk_fps,bulk_ips);          
    else
        s1=sprintf(' bulk = %9.5g m/sec ',bulk);         
    end
end
if(iflag==2)
    if(n_unit==1)
        
        bar_fps=bar*ft_per_m;
        bar_ips=bar*in_per_m;
        
        bulk_fps=bulk*ft_per_m;
        bulk_ips=bulk*in_per_m;        
        
        s1=sprintf(' bar = %9.5g ft/sec \n bulk = %9.5g ft/sec \n\n bar = %9.5g in/sec \n bulk = %9.5g in/sec ',...
                                        bar_fps,bulk_fps,bar_ips,bulk_ips);        
    else
        s1=sprintf(' bar = %9.5g m/sec \n bulk = %9.5g m/sec ',bar,bulk);
    end
end

set(handles.edit_speed,'Visible','on');
set(handles.edit_speed,'String',s1,'Max',5);


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(speed_sound);


% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit

change_select_method(hObject, eventdata, handles);
clear_results(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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

set(handles.listbox_item,'String', '');

set(handles.listbox_item,'Value',1);

if(n==1)
    set(handles.uipanel_select_item,'Title','Select Gas');
    string_gas{1}='Air';
    string_gas{2}='Oxygen';
    string_gas{3}='CO2';
    string_gas{4}='Hydrogen';
    string_gas{5}='Steam';
    string_gas{6}='Other Gas';
    set(handles.listbox_item,'String',string_gas);
end
if(n==2)
    set(handles.uipanel_select_item,'Title','Select Liquid');
    string_liquid{1}='Fresh Water';
    string_liquid{2}='Sea Water';
    string_liquid{3}='Mercury';
    string_liquid{4}='Turpentine';
    string_liquid{5}='Other Liquid';    
    set(handles.listbox_item,'String',string_liquid);    
end
if(n==3)
    set(handles.uipanel_select_item,'Title','Select Solid');
    string_solid{1}='Aluminum';
    string_solid{2}='Brass';
    string_solid{3}='Copper';
    string_solid{4}='Cast Iron';
    string_solid{5}='Lead';    
    string_solid{6}='Nickel';
    string_solid{7}='Silver';
    string_solid{8}='Steel';
    string_solid{9}='Pyrex Glass';
    string_solid{10}='Quartz';  
    string_solid{11}='Lucite';
    string_solid{12}='Concrete';
    string_solid{13}='Ice';
    string_solid{14}='Cork';
    string_solid{15}='Oak';    
    string_solid{16}='Pine';
    string_solid{17}='Hard Rubber';
    string_solid{18}='Soft Rubber';
    string_solid{19}='Rho-c Rubber';
    string_solid{20}='Other Solid';    
    set(handles.listbox_item,'String',string_solid);     
end

change_select_method(hObject, eventdata, handles);
clear_results(hObject, eventdata, handles);


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


% --- Executes on selection change in listbox_item.
function listbox_item_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_item (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_item contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_item
change_select_method(hObject, eventdata, handles);
clear_results(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_item_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_item (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method
clear_results(hObject, eventdata, handles);
change_method(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function change_select_method(hObject, eventdata, handles)
%
n_medium=get(handles.listbox_medium,'Value');

n_item=get(handles.listbox_item,'Value');

n_unit=get(handles.listbox_unit,'Value');

set(handles.uipanel_enter_properties_gas_liquid,'Visible','off');
set(handles.uipanel_enter_properties_solid,'Visible','off');
set(handles.uipanel_select_method,'Visible','off');
set(handles.listbox_method,'Visible','off');

set(handles.edit_elastic_modulus,'Visible','off');
set(handles.edit_poisson,'Visible','off');
set(handles.edit_mass_density,'Visible','off');
set(handles.text_elastic_modulus,'Visible','off');
set(handles.text_poisson,'Visible','off');
set(handles.text_mass_density,'Visible','off');



set(handles.text_bulk_modulus,'Visible','off');
set(handles.text_ratio_specific_heats,'Visible','off');
set(handles.text_mass_density_gas_liquid,'Visible','off');
set(handles.text_temperature,'Visible','off');
set(handles.text_molecular_weight,'Visible','off');
set(handles.text_pressure,'Visible','off');
set(handles.edit_bulk_modulus,'Visible','off');
set(handles.edit_ratio_specific_heats,'Visible','off');
set(handles.edit_mass_density_gas_liquid,'Visible','off');
set(handles.edit_temperature,'Visible','off');
set(handles.listbox_degrees,'Visible','off');
set(handles.edit_molecular_weight,'Visible','off');
set(handles.edit_pressure,'Visible','off');





set(handles.listbox_method,'String','');

if(n_medium==1)  % gas
    
   set(handles.uipanel_select_method,'Visible','on'); 
   set(handles.listbox_method,'Visible','on');
   set(handles.uipanel_enter_properties_gas_liquid,'Visible','on');
       
   if(n_item<=5)
       s1{1}='Perfect Gas: Temperature';
       s1{2}='Perfect Gas: Pressure';         
   else     
       s1{1}='Adiabatic Bulk Modulus';
       s1{2}='Isothermal Bulk Modulus';
       s1{3}='Perfect Gas: Temperature';
       s1{4}='Perfect Gas: Pressure';      
   end
   
   set(handles.listbox_method,'String',s1);    
   change_method(hObject, eventdata, handles);   
end

if(n_medium==2)  % liquid
   if(n_item==5)
       set(handles.uipanel_enter_properties_gas_liquid,'Visible','on');
       set(handles.uipanel_select_method,'Visible','on');
       set(handles.listbox_method,'Visible','on');
       
       s1{1}='Adiabatic Bulk Modulus';
       s1{2}='Isothermal Bulk Modulus';
       set(handles.listbox_method,'String',s1);
       
       change_method(hObject, eventdata, handles);
   end
end

if(n_medium==3)  % solid
   if(n_item==20)
       set(handles.uipanel_enter_properties_solid,'Visible','on');
    
       set(handles.edit_elastic_modulus,'Visible','on');
       set(handles.edit_poisson,'Visible','on');
       set(handles.edit_mass_density,'Visible','on');
       
       set(handles.text_elastic_modulus,'Visible','on');
       set(handles.text_poisson,'Visible','on');
       set(handles.text_mass_density,'Visible','on');
       
       if(n_unit==1)
            set(handles.text_elastic_modulus,'String','Elastic Modulus (psi)'); 
            set(handles.text_mass_density,'String','Mass Density (lbm/in^3)');  
       else
            set(handles.text_elastic_modulus,'String','Elastic Modulus (Pa)'); 
            set(handles.text_mass_density,'String','Mass Density (kg/m^3)');            
       end
   end
end

function change_method(hObject, eventdata, handles)
%

n_unit=get(handles.listbox_unit,'Value');

n_method=get(handles.listbox_method,'Value');

n_medium=get(handles.listbox_medium,'Value');

n_item=get(handles.listbox_item,'Value');

set(handles.text_temperature,'Visible','off');
set(handles.edit_temperature,'Visible','off');
set(handles.listbox_degrees,'Visible','off');
set(handles.text_pressure,'Visible','off');
set(handles.edit_pressure,'Visible','off'); 
set(handles.text_mass_density_gas_liquid,'Visible','off');
set(handles.edit_mass_density_gas_liquid,'Visible','off'); 
set(handles.edit_molecular_weight,'Visible','off'); 
set(handles.text_molecular_weight,'Visible','off');         


if(n_medium==1 && n_item<=5) % gas

    if(n_method==1)
        set(handles.text_temperature,'Visible','on');
        set(handles.edit_temperature,'Visible','on');
        set(handles.listbox_degrees,'Visible','on');        
    else
            
        set(handles.edit_mass_density_gas_liquid,'Visible','on'); 
        set(handles.text_mass_density_gas_liquid,'Visible','on');
        set(handles.text_pressure,'Visible','on');
        set(handles.edit_pressure,'Visible','on');        

        if(n_unit==1)
            set(handles.text_mass_density_gas_liquid,'String','Mass Density (lbm/in^3)');
            set(handles.text_pressure,'String','Pressure (psi)');           
        else
            set(handles.text_mass_density_gas_liquid,'String','Mass Density (kg/m^3)'); 
            set(handles.text_pressure,'String','Pressure (Pa)');              
        end
    
    end
    
end   

if(n_medium==1 && n_item==6)
        set(handles.edit_bulk_modulus,'Visible','off');
        set(handles.text_bulk_modulus,'Visible','off'); 
        set(handles.edit_mass_density_gas_liquid,'Visible','off');
        set(handles.text_mass_density_gas_liquid,'Visible','off'); 
        set(handles.edit_ratio_specific_heats,'Visible','off');
        set(handles.text_ratio_specific_heats,'Visible','off');        
end    
    

if(n_medium==1 && n_item==6 && n_method==3) % gas % other % perfect gas temperature
        set(handles.edit_temperature,'Visible','on'); 
        set(handles.text_temperature,'Visible','on');
        set(handles.listbox_degrees,'Visible','on');
        set(handles.edit_molecular_weight,'Visible','on'); 
        set(handles.text_molecular_weight,'Visible','on');      
        set(handles.edit_ratio_specific_heats,'Visible','on'); 
        set(handles.text_ratio_specific_heats,'Visible','on'); 
end    


if(n_medium==1 && n_item==6 && n_method==4) % gas % other % perfect gas pressure
    
        set(handles.edit_mass_density_gas_liquid,'Visible','on'); 
        set(handles.text_mass_density_gas_liquid,'Visible','on');    
        set(handles.text_pressure,'Visible','on');
        set(handles.edit_pressure,'Visible','on');        

        if(n_unit==1)
            set(handles.text_mass_density_gas_liquid,'String','Mass Density (lbm/in^3)');
            set(handles.text_pressure,'String','Pressure (psi)');           
        else
            set(handles.text_mass_density_gas_liquid,'String','Mass Density (kg/m^3)'); 
            set(handles.text_pressure,'String','Pressure (Pa)');              
        end
end    
    
%%%%%

if(n_medium==2 || (n_medium==1 && n_item==6 && n_method<=2))
   
    set(handles.edit_bulk_modulus,'Visible','on');
    set(handles.text_bulk_modulus,'Visible','on');
    set(handles.edit_mass_density_gas_liquid,'Visible','on'); 
    set(handles.text_mass_density_gas_liquid,'Visible','on');

    if(n_unit==1)
        set(handles.text_mass_density_gas_liquid,'String','Mass Density (lbm/in^3)');
    else
        set(handles.text_mass_density_gas_liquid,'String','Mass Density (kg/m^3)');    
    end
    
    if(n_method==1) % adiabatic
    
        if(n_unit==1)
            set(handles.text_bulk_modulus,'String','Adiabatic Bulk Modulus (psi)');
        else
            set(handles.text_bulk_modulus,'String','Adiabatic Bulk Modulus (Pa)');    
        end    
    
        set(handles.edit_ratio_specific_heats,'Visible','off');
        set(handles.text_ratio_specific_heats,'Visible','off');    
    
    else            % isothermal
    
        if(n_unit==1)
            set(handles.text_bulk_modulus,'String','Isothermal Bulk Modulus (psi)');
        else
            set(handles.text_bulk_modulus,'String','Isothermal Bulk Modulus (Pa)');    
        end    
    
        set(handles.edit_ratio_specific_heats,'Visible','on');
        set(handles.text_ratio_specific_heats,'Visible','on');
    end

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



function edit_elastic_modulus_Callback(hObject, eventdata, handles)
% hObject    handle to edit_elastic_modulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_elastic_modulus as text
%        str2double(get(hObject,'String')) returns contents of edit_elastic_modulus as a double


% --- Executes during object creation, after setting all properties.
function edit_elastic_modulus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_elastic_modulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_poisson_Callback(hObject, eventdata, handles)
% hObject    handle to edit_poisson (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_poisson as text
%        str2double(get(hObject,'String')) returns contents of edit_poisson as a double


% --- Executes during object creation, after setting all properties.
function edit_poisson_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_poisson (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mass_density_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mass_density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mass_density as text
%        str2double(get(hObject,'String')) returns contents of edit_mass_density as a double


% --- Executes during object creation, after setting all properties.
function edit_mass_density_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass_density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function clear_results(hObject, eventdata, handles)
%
set(handles.edit_speed,'String',' ');
set(handles.edit_speed,'Visible','off');


% --- Executes on key press with focus on edit_elastic_modulus and none of its controls.
function edit_elastic_modulus_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_elastic_modulus (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_poisson and none of its controls.
function edit_poisson_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_poisson (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_mass_density and none of its controls.
function edit_mass_density_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass_density (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);



function edit_bulk_modulus_Callback(hObject, eventdata, handles)
% hObject    handle to edit_bulk_modulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_bulk_modulus as text
%        str2double(get(hObject,'String')) returns contents of edit_bulk_modulus as a double


% --- Executes during object creation, after setting all properties.
function edit_bulk_modulus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_bulk_modulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ratio_specific_heats_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ratio_specific_heats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ratio_specific_heats as text
%        str2double(get(hObject,'String')) returns contents of edit_ratio_specific_heats as a double


% --- Executes during object creation, after setting all properties.
function edit_ratio_specific_heats_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ratio_specific_heats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mass_density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mass_density as text
%        str2double(get(hObject,'String')) returns contents of edit_mass_density as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass_density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_temperature_Callback(hObject, eventdata, handles)
% hObject    handle to edit_temperature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_temperature as text
%        str2double(get(hObject,'String')) returns contents of edit_temperature as a double


% --- Executes during object creation, after setting all properties.
function edit_temperature_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_temperature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_molecular_weight_Callback(hObject, eventdata, handles)
% hObject    handle to edit_molecular_weight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_molecular_weight as text
%        str2double(get(hObject,'String')) returns contents of edit_molecular_weight as a double


% --- Executes during object creation, after setting all properties.
function edit_molecular_weight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_molecular_weight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_pressure_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pressure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pressure as text
%        str2double(get(hObject,'String')) returns contents of edit_pressure as a double


% --- Executes during object creation, after setting all properties.
function edit_pressure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pressure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_bulk_modulus and none of its controls.
function edit_bulk_modulus_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_bulk_modulus (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);

% --- Executes on key press with focus on edit_pressure and none of its controls.
function edit_pressure_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_pressure (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_molecular_weight and none of its controls.
function edit_molecular_weight_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_molecular_weight (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_temperature and none of its controls.
function edit_temperature_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_temperature (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_ratio_specific_heats and none of its controls.
function edit_ratio_specific_heats_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_ratio_specific_heats (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);



function edit_mass_density_gas_liquid_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mass_density_gas_liquid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mass_density_gas_liquid as text
%        str2double(get(hObject,'String')) returns contents of edit_mass_density_gas_liquid as a double


% --- Executes during object creation, after setting all properties.
function edit_mass_density_gas_liquid_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass_density_gas_liquid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_mass_density_gas_liquid and none of its controls.
function edit_mass_density_gas_liquid_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass_density_gas_liquid (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on selection change in listbox_degrees.
function listbox_degrees_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_degrees (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_degrees contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_degrees


% --- Executes during object creation, after setting all properties.
function listbox_degrees_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_degrees (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

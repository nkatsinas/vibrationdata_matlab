function varargout = vibrationdata_unit_conversion(varargin)
% VIBRATIONDATA_UNIT_CONVERSION MATLAB code for vibrationdata_unit_conversion.fig
%      VIBRATIONDATA_UNIT_CONVERSION, by itself, creates a new VIBRATIONDATA_UNIT_CONVERSION or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_UNIT_CONVERSION returns the handle to a new VIBRATIONDATA_UNIT_CONVERSION or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_UNIT_CONVERSION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_UNIT_CONVERSION.M with the given input arguments.
%
%      VIBRATIONDATA_UNIT_CONVERSION('Property','Value',...) creates a new VIBRATIONDATA_UNIT_CONVERSION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_unit_conversion_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_unit_conversion_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_unit_conversion

% Last Modified by GUIDE v2.5 05-Aug-2016 16:52:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_unit_conversion_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_unit_conversion_OutputFcn, ...
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


% --- Executes just before vibrationdata_unit_conversion is made visible.
function vibrationdata_unit_conversion_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_unit_conversion (see VARARGIN)

% Choose default command line output for vibrationdata_unit_conversion
handles.output = hObject;


handles.meters_per_foot = 0.3048;
handles.feet_per_meter = 1./handles.meters_per_foot;
handles.meters_per_mile = 1609.3;
handles.mmeters_per_inch = 25.40;
handles.cmeters_per_inch = 2.540;
handles.meters_per_inch = 0.02540;
handles.inches_per_meter = 1./handles.meters_per_inch;
handles.feet_per_mile = 5280.;
handles.lbm_per_slug = 32.17;
handles.slug_per_lbm = 1./handles.lbm_per_slug;
handles.lbm_per_kg = 2.205;
handles.kg_per_lbm = 1./handles.lbm_per_kg;
handles.kg_per_slugs = 14.59;
handles.meterspersecond2_per_G = 9.80665;
handles.lbf_per_n = 0.2248;
handles.n_per_lbf = 1./handles.lbf_per_n;
handles.rad_per_deg = atan2(0.,-1.)/180.;
handles.deg_per_rad = 1./handles.rad_per_deg;
handles.Pa_per_psi = 6894.;

%%%    

handles.n_acceleration = 1;
handles.n_acceleration_PSD=2;
handles.n_acoustic_impedance =3;
handles.n_acoustic_pressure =4;
handles.n_acoustic_pressure_water = 5;
handles.n_angle = 6;
handles.n_area = 7;
handles.n_ami = 8;
handles.n_dc = 9;
handles.n_displacement = 10;
handles.n_energy = 11;
handles.n_energy_per_mass = 12;
handles.n_force = 13;
handles.n_frequency = 14;
handles.n_impedance = 15;
handles.n_intensity = 16;
handles.n_jerk = 17;
handles.n_kinematic_viscosity=18;
handles.n_length = 19;
handles.n_mass = 20;
handles.n_mmi = 21;
handles.n_massperlength = 22;
handles.n_massperarea = 23;
handles.n_masspervolume = 24;
handles.n_moment= 25;
handles.n_power = 26;
handles.n_power_per_area = 27;
handles.n_pressure = 28;
handles.n_speed = 29;
handles.n_stiffness_plate = 30;
handles.n_stiffness_rotational = 31;
handles.n_stiffness_translational = 32;
handles.n_temperature = 33;
handles.n_torque= 34;
handles.n_velocity=35;
handles.n_volume=36;
handles.n_wavenumber=37;
handles.n_work=38;

% Update handles structure
guidata(hObject, handles);

% leave here

set(handles.listbox_dimension,'value',1);

try
   nChoice=getappdata(0,'nChoice'); 
   if(nchoice>=1 && nChoice<=100)
        set(handles.listbox_dimension,'value',nChoice);
   end
catch
end

listbox_dimension_Callback(hObject, eventdata, handles);

% UIWAIT makes vibrationdata_unit_conversion wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_unit_conversion_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox_dimension.
function listbox_dimension_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_dimension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_dimension contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_dimension

set(handles.listbox_input_unit,'Value',1);

set(handles.edit_results,'Enable','off');
set(handles.edit_results,'String','');

nChoice=get(handles.listbox_dimension,'Value');

setappdata(0,'nChoice',nChoice);

set(handles.listbox_input_unit,'String','');

%%%%%%%%%%%%%%%%%%%

if(nChoice == handles.n_acoustic_impedance )
	 
		  string_th{1}=sprintf('Rayls (Pa sec/m)');
	      string_th{2}=sprintf('kg/(m^2 sec)');
	      string_th{3}=sprintf('lbm/(in^2 sec)');
	      string_th{4}=sprintf('slugs/(in^2 sec)');
	      string_th{5}=sprintf('slugs/(ft^2 sec)');
		  string_th{6}=sprintf('psi sec/in');

end
if(nChoice == handles.n_acoustic_pressure || nChoice == handles.n_acoustic_pressure_water )
	 
		  string_th{1}=sprintf('dB ');
	      string_th{2}=sprintf('psi rms');
	      string_th{3}=sprintf('psf rms');
	      string_th{4}=sprintf('Pa rms');
	      string_th{5}=sprintf('microPa rms');
	      string_th{6}=sprintf('microbar rms');
end
if(nChoice == handles.n_displacement || nChoice == handles.n_length )
	 
        string_th{1}=sprintf('Mils');
        string_th{2}=sprintf('inches');
        string_th{3}=sprintf('feet');
        string_th{4}=sprintf('yards');
        string_th{5}=sprintf('miles (statute)');
        string_th{6}=sprintf('nautical miles');
        string_th{7}=sprintf('microns');
        string_th{8}=sprintf('millimeters');
        string_th{9}=sprintf('centimeters');
        string_th{10}=sprintf('meters');
        string_th{11}=sprintf('kilometers');
        string_th{12}=sprintf('Astronomical Units ');
        string_th{13}=sprintf('light-years');
        string_th{14}=sprintf('parsec');
end
if(nChoice == handles.n_speed || nChoice == handles.n_velocity )
	 
          string_th{1}=sprintf('inches/sec ');
	      string_th{2}=sprintf('feet/sec');
		  string_th{3}=sprintf('miles/hour');
		  string_th{4}=sprintf('knots');
		  string_th{5}=sprintf('meters/sec');
		  string_th{6}=sprintf('km/sec');
		  string_th{7}=sprintf('km/hour');
		  string_th{8}=sprintf('c (speed of light)');
		  string_th{9}=sprintf('Mach (sea level)');
end	
if(nChoice == handles.n_acceleration )

          string_th{1}=sprintf('G ');
	      string_th{2}=sprintf('in/sec^2');
		  string_th{3}=sprintf('ft/sec^2');
		  string_th{4}=sprintf('mm/sec^2');
		  string_th{5}=sprintf('meter/sec^2');
end	
if(nChoice == handles.n_acceleration_PSD )
	 
          string_th{1}=sprintf('G^2/Hz ');
	      string_th{2}=sprintf('(m/sec^2)^2/Hz');
		  string_th{3}=sprintf('m^2/sec^3');
	      string_th{4}=sprintf('(ft/sec^2)^2/Hz');
		  string_th{5}=sprintf('ft^2/sec^3');
	      string_th{6}=sprintf('(in/sec^2)^2/Hz');
		  string_th{7}=sprintf('in^2/sec^3');
          string_th{8}=sprintf('G^2/(rad/sec) ');
	      string_th{9}=sprintf('(m/sec^2)^2/(rad/sec)');
	      string_th{10}=sprintf('(ft/sec^2)^2/(rad/sec)');
	      string_th{11}=sprintf('(in/sec^2)^2/(rad/sec)');

end
if(nChoice == handles.n_jerk )
	 
          string_th{1}=sprintf('G/s ');
	      string_th{2}=sprintf('in/sec^3');
		  string_th{3}=sprintf('ft/sec^3');
		  string_th{4}=sprintf('mm/sec^3');
		  string_th{5}=sprintf('meter/sec^3');
end
if(nChoice == handles.n_temperature )
	 
          string_th{1}=sprintf('degrees F ');
	      string_th{2}=sprintf('degrees C');
		  string_th{3}=sprintf('degrees Rankine');
		  string_th{4}=sprintf('Kelvin');
end	
if(nChoice == handles.n_mass )
	 
          string_th{1}=sprintf('pound-mass (lbm) ');
	      string_th{2}=sprintf('slugs (lbf sec^2/ft)');
		  string_th{3}=sprintf('lbf sec^2/in');
		  string_th{4}=sprintf('ounces');
		  string_th{5}=sprintf('kg');
		  string_th{6}=sprintf('grams');
		  string_th{7}=sprintf('mg');
		  string_th{8}=sprintf('grains');

end	
if(nChoice == handles.n_mmi )

          string_th{1}=sprintf('lbm ft^2 ');
	      string_th{2}=sprintf('lbm in^2');
          string_th{3}=sprintf('slugs ft^2 ');
	      string_th{4}=sprintf('slugs in^2');
	      string_th{5}=sprintf('lbf sec^2 in');
		  string_th{6}=sprintf('kg m^2');

end	
if(nChoice == handles.n_massperlength)

          string_th{1}=sprintf('kg/m ');
          string_th{2}=sprintf('lbm/in ');
          string_th{3}=sprintf('lbm/ft ');
		  string_th{4}=sprintf('lbf sec^2/in^2');

end
if(nChoice == handles.n_massperarea)

          string_th{1}=sprintf('lbm/ft^2 ');
          string_th{2}=sprintf('lbm/in^2 ');
          string_th{3}=sprintf('slugs/ft^2 ');
          string_th{4}=sprintf('slugs/in^2 ');
		  string_th{5}=sprintf('lbf sec^2/in^3');
		  string_th{6}=sprintf('kg/m^2');
end
if(nChoice == handles.n_masspervolume )
         
          string_th{1}=sprintf('lbm/ft^3 ');
          string_th{2}=sprintf('lbm/in^3 ');
          string_th{3}=sprintf('slugs/ft^3 ');
          string_th{4}=sprintf('slugs/in^3 ');
		  string_th{5}=sprintf('lbf sec^2/in^4');
		  string_th{6}=sprintf('kg/m^3');
		  string_th{7}=sprintf('g/cm^3');
		  string_th{8}=sprintf('specific gravity:H20');
end	
if(nChoice == handles.n_force )

          string_th{1}=sprintf('pounds-force (lbf) ');
          string_th{2}=sprintf('kips ');
		  string_th{3}=sprintf('Newtons');
		  string_th{4}=sprintf('dynes');
end	
if(nChoice == handles.n_impedance || nChoice == handles.n_dc)

          string_th{1}=sprintf('N sec/m ');
          string_th{2}=sprintf('N sec/cm ');
          string_th{3}=sprintf('lbf sec/in ');
		  string_th{4}=sprintf('lbf sec/ft');

end	
if(nChoice == handles.n_pressure)

          string_th{1}=sprintf('atmosphere ');
	      string_th{2}=sprintf('psi');
		  string_th{3}=sprintf('psf');
		  string_th{4}=sprintf('Pascal ');
 		  string_th{5}=sprintf('dynes/cm^2 ');
 		  string_th{6}=sprintf('bar ');
 		  string_th{7}=sprintf('millibar ');
		  string_th{8}=sprintf('mm Hg (torr)');
  		  string_th{9}=sprintf('inches Hg ');
		  string_th{10}=sprintf('inches Water');
end
if(nChoice == handles.n_frequency )

          string_th{1}=sprintf('Hertz ');
	      string_th{2}=sprintf('radians/sec');
		  string_th{3}=sprintf('rpm');
		  string_th{4}=sprintf('period (sec)');
end	
if(nChoice == handles.n_wavenumber )
	 
          string_th{1}=sprintf('radians/meter ');
	      string_th{2}=sprintf('radians/ft');
		  string_th{3}=sprintf('radians/inch');

end
if(nChoice == handles.n_energy || nChoice == handles.n_work )
	 
          string_th{1}=sprintf('Joules (N-m)');
		  string_th{2}=sprintf('ergs');
	      string_th{3}=sprintf('foot-lbf');
		  string_th{4}=sprintf('Watt-hours');
		  string_th{5}=sprintf('BTU');
	      string_th{6}=sprintf('kilocalories');
		  string_th{7}=sprintf('eV');
end	
if(nChoice == handles.n_power_per_area || nChoice == handles.n_intensity)
     
          string_th{1}=sprintf('dB [ref: 1.0e-12 W/m^2]');
		  string_th{2}=sprintf('Watts/m^2');	 
end
if(nChoice == handles.n_energy_per_mass )
          string_th{1}=sprintf('J/kg');
		  string_th{2}=sprintf('kJ/kg');
		  string_th{3}=sprintf('ft-lbf/lbm');
		  string_th{4}=sprintf('in-lbf/lbm');
end
if(nChoice == handles.n_power )
          string_th{1}=sprintf('Watts');
		  string_th{2}=sprintf('kilowatts');
	      string_th{3}=sprintf('foot-lbf/sec');
		  string_th{4}=sprintf('horsepower');
		  string_th{5}=sprintf('BTU/hour');
		  string_th{6}=sprintf('dBm (ref 1 mW)');	    
	      string_th{7}=sprintf('dB  (ref 1 pW)');
end

if(nChoice == handles.n_angle)
          string_th{1}=sprintf('degrees');
		  string_th{2}=sprintf('radians');
end
if(nChoice == handles.n_area )
          string_th{1}=sprintf('meters^2');
		  string_th{2}=sprintf('centimeters^2');
		  string_th{3}=sprintf('millimeters^2');
		  string_th{4}=sprintf('inches^2');
		  string_th{5}=sprintf('feet^2');
		  string_th{6}=sprintf('yards^2');
		  string_th{7}=sprintf('miles^2');
		  string_th{8}=sprintf('acres');
end	
if(nChoice == handles.n_kinematic_viscosity )	 
          string_th{1}=sprintf('meters^2/sec');
		  string_th{2}=sprintf('centimeters^2/sec');
		  string_th{3}=sprintf('millimeters^2/sec');
		  string_th{4}=sprintf('inches^2/sec');
		  string_th{5}=sprintf('feet^2/sec');
end
if(nChoice == handles.n_volume )
          string_th{1}=sprintf('in^3');
		  string_th{2}=sprintf('ft^3');
		  string_th{3}=sprintf('miles^3');
		  string_th{4}=sprintf('mm^3');
		  string_th{5}=sprintf('cm^3');
		  string_th{6}=sprintf('m^3');
		  string_th{7}=sprintf('km^3');
		  string_th{8}=sprintf('liters');
		  string_th{9}=sprintf('gallons');
		  string_th{10}=sprintf('quarts');
	      string_th{11}=sprintf('pints');
end
if(nChoice == handles.n_ami )
          string_th{1}=sprintf('m^4');
          string_th{2}=sprintf('cm^4');
		  string_th{3}=sprintf('mm^4');
          string_th{4}=sprintf('in^4');
          string_th{5}=sprintf('ft^4');
end
if(nChoice == handles.n_moment || nChoice == handles.n_torque)
		 string_th{1}=sprintf('N m');
		 string_th{2}=sprintf('ft lbf');
		 string_th{3}=sprintf('in lbf');
end
if(nChoice == handles.n_stiffness_plate )
		 string_th{1}=sprintf('N m');
		 string_th{2}=sprintf('lbf ft');
		 string_th{3}=sprintf('lbf in');
		 string_th{4}=sprintf('lbm in^2/sec^2');
end
if(nChoice == handles.n_stiffness_rotational)

		 string_th{1}=sprintf('N m/rad');
		 string_th{2}=sprintf('ft lbf/rad');
		 string_th{3}=sprintf('in lbf/rad');
		 string_th{4}=sprintf('N m/deg');
		 string_th{5}=sprintf('ft lbf/deg');
		 string_th{6}=sprintf('in lbf/deg');
end
if(nChoice == handles.n_stiffness_translational)
	
		  string_th{1}=sprintf('N/m');
		  string_th{2}=sprintf('N/mm');
		  string_th{3}=sprintf('lbf/ft');
		  string_th{4}=sprintf('lbf/in');
end

set(handles.listbox_input_unit,'String',string_th)   


% --- Executes during object creation, after setting all properties.
function listbox_dimension_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_dimension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_input_unit.
function listbox_input_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_input_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_input_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_input_unit

set(handles.edit_results,'Enable','off');
set(handles.edit_results,'String','');



% --- Executes during object creation, after setting all properties.
function listbox_input_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_input_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ndim=get(handles.listbox_dimension,'value');
handles.nChoiceUnits=get(handles.listbox_input_unit,'value');

svalue=get(handles.edit_value,'String');

if isempty(svalue)
    set(handles.edit_value,'String','1');
end    
    
handles.value=str2num(get(handles.edit_value,'String'));    



% Update handles structure
guidata(hObject, handles);

if(ndim == handles.n_acoustic_impedance )
    acoustic_impedance(hObject, eventdata, handles);
end
if(ndim == handles.n_acoustic_pressure )
			
				acoustics(hObject, eventdata, handles);
end
if(ndim == handles.n_acoustic_pressure_water )
			
				ref1 = 1.45e-010;
				ref2 = 1.e-06;
				acoustics(hObject, eventdata, handles);
end
if(ndim == handles.n_length || ndim == handles.n_displacement )
			
				length(hObject, eventdata, handles);
end			
if(ndim == handles.n_velocity || ndim == handles.n_speed )
			
				velox(hObject, eventdata, handles);
end
if(ndim == handles.n_acceleration )
			
				accel(hObject, eventdata, handles);
end
if(ndim == handles.n_acceleration_PSD )
			
				accel_PSD(hObject, eventdata, handles);
end
if(ndim == handles.n_ami )
			
				ami(hObject, eventdata, handles);
end
if(ndim == handles.n_temperature )
			
				temperature(hObject, eventdata, handles);
end
if(ndim == handles.n_jerk )
			
				jerk(hObject, eventdata, handles);
end
if(ndim == handles.n_kinematic_viscosity )
			
				kinematic_viscosity(hObject, eventdata, handles);
end
if(ndim == handles.n_mass )
			
				mass(hObject, eventdata, handles);
end
if(ndim == handles.n_mmi )
			
				mmi(hObject, eventdata, handles);
end
if(ndim == handles.n_massperlength )
			
				massperlength(hObject, eventdata, handles);
end
if(ndim == handles.n_massperarea )
			
				massperarea(hObject, eventdata, handles);
end
if(ndim == handles.n_masspervolume )
			
				masspervolume(hObject, eventdata, handles);
end
if(ndim == handles.n_moment || ndim == handles.n_torque)
			
				moment(hObject, eventdata, handles);
end
if(ndim == handles.n_force )
			
				force(hObject, eventdata, handles);
end
if(ndim == handles.n_pressure)
			
				pressure(hObject, eventdata, handles);
end
if( ndim == handles.n_energy_per_mass)
			
				energy_per_mass(hObject, eventdata, handles);
end
if( ndim == handles.n_power_per_area ||  ndim == handles.n_intensity)
			
				intensity(hObject, eventdata, handles);
end
if(ndim == handles.n_frequency)
			
				frequency(hObject, eventdata, handles);
end
if(ndim == handles.n_impedance || ndim == handles.n_dc )
			
				impedance(hObject, eventdata, handles);
end
if(ndim == handles.n_energy || ndim == handles.n_work)
			
				energy(hObject, eventdata, handles);
end
if(ndim == handles.n_power)
			
				power(hObject, eventdata, handles);
end
if(ndim == handles.n_angle)
			
				angle(hObject, eventdata, handles);
end
if(ndim == handles.n_area)
			
				area(hObject, eventdata, handles);
end
if(ndim == handles.n_volume)
			
				volume(hObject, eventdata, handles);
end
if(ndim == handles.n_stiffness_plate)
			
				stiffness_plate(hObject, eventdata, handles);
end
if(ndim == handles.n_stiffness_translational)
			
				stiffness_translational(hObject, eventdata, handles);
end
if(ndim == handles.n_stiffness_rotational)
			
				stiffness_rotational(hObject, eventdata, handles);
end
if(ndim == handles.n_wavenumber)
			
				wavenumber(hObject, eventdata, handles);
end

set(handles.edit_results,'Enable','on');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(vibrationdata_unit_conversion);


function edit_value_Callback(hObject, eventdata, handles)
% hObject    handle to edit_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_value as text
%        str2double(get(hObject,'String')) returns contents of edit_value as a double


% --- Executes during object creation, after setting all properties.
function edit_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_clear_value.
function pushbutton_clear_value_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_clear_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.edit_value,'String','');
set(handles.edit_results,'Enable','off');
set(handles.edit_results,'String','');

% --- Executes on selection change in edit_results.
function edit_results_Callback(hObject, eventdata, handles)
% hObject    handle to edit_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns edit_results contents as cell array
%        contents{get(hObject,'Value')} returns selected item from edit_results


% --- Executes during object creation, after setting all properties.
function edit_results_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_value and none of its controls.
function edit_value_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_value (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.edit_results,'Enable','off');
set(handles.edit_results,'String','');

function acoustic_impedance(hObject, eventdata, handles)
%      Rayls (Pa sec/m)	1
%	   kg/(m^2 sec)		2
%	   lbm/(in^2 sec)   3
%	   slugs/(in^2 sec)	4
%	   slugs/(ft^2 sec)	5
%      psi sec/in       6

     xRayls=0.;         %  1 or 2
	 xlbmpin2sec=0.;    %  3
	 xslugspin2sec=0.;  %  4
	 xslugspft2sec=0.;  %  5
	 xpsisecpin=0.;     %  6



         if( handles.nChoiceUnits == 1 || handles.nChoiceUnits == 2 )
		 
			 xRayls=handles.value;
         end
         if( handles.nChoiceUnits == 3 )
		 
			 xRayls=handles.value*handles.inches_per_meter^2*handles.kg_per_lbm;
         end
         if( handles.nChoiceUnits == 4 )
		 
			 xRayls=handles.value*handles.inches_per_meter^2*handles.kg_per_slugs;
         end
         if( handles.nChoiceUnits == 5 )
		 
			 xRayls=handles.value*handles.feet_per_meter^2*handles.kg_per_slugs;
         end
         if( handles.nChoiceUnits == 6 )
		 
			 xRayls=handles.value*Pa_per_psi*handles.inches_per_meter;
         end


		 xlbmpin2sec=xRayls/(handles.inches_per_meter^2*handles.kg_per_lbm);

		 xslugspin2sec=xRayls/(handles.inches_per_meter^2*handles.kg_per_slugs);

		 xslugspft2sec=xRayls/(handles.feet_per_meter^2*handles.kg_per_slugs);

		 xpsisecpin=xRayls/(handles.Pa_per_psi*handles.inches_per_meter);


         if( handles.nChoiceUnits == 1 || handles.nChoiceUnits == 2 )
		 
			 xRayls=handles.value;
         end
         if( handles.nChoiceUnits == 3 )
		 
			 xlbmpin2sec=handles.value;
         end
         if( handles.nChoiceUnits == 4 )
		 
			 xslugspin2sec=handles.value;
         end
         if( handles.nChoiceUnits == 5 )
		 
			 xslugspft2sec=handles.value;
         end
         if( handles.nChoiceUnits == 6 )
		 
		     xpsisecpin=handles.value;
		 end

ss=sprintf('%12.5g Rayls (Pa sec/m) \n %12.5g kg/(m^2 sec) \n\n %12.5g lbm/(in^2 sec) \n\n %12.5g slugs/(in^2 sec) \n %12.5g slugs/(ft^2 sec)\n\n  %12.5g psi sec/in',xRayls,xRayls,xlbmpin2sec,xslugspin2sec,xslugspft2sec,xpsisecpin);
set(handles.edit_results,'String',ss);       


function acoustics(hObject, eventdata, handles)

xdB=0.;          %  1
xpsirms=0.;      %  2
xpsfrms=0.;      %  3
xparms=0.;       %  4
xmicroparms=0.;  %  5
xmicrobar=0.;	 %  6

ref2 = 20.e-06;


         if( handles.nChoiceUnits == 1 )
		 
			 xdB= handles.value;

			 xparms  = ref2*10^(xdB/20.);
         end
         if( handles.nChoiceUnits == 2 )
		 
			 xpsirms= handles.value;

			 xparms=xpsirms*handles.Pa_per_psi;
         end
		 if( handles.nChoiceUnits == 3 )
		 
			 xpsfrms= handles.value;

			 xparms=xpsfrms*47.873;
         end
		 if( handles.nChoiceUnits == 4 )
		 
			 xparms= handles.value;
         end
		 if( handles.nChoiceUnits == 5 )
		 
			 xmicroparms= handles.value;
			 xparms=xmicroparms*1.0e-6;
         end
		 if( handles.nChoiceUnits == 6 )
		 
			 xmicrobar= handles.value;
			 xmicroparms=xmicrobar*1.0e+05;
			 xparms=xmicroparms/1.0e+06;
         end
		 xmicroparms=xparms*1.0e+06;
		 xpsirms=xparms/handles.Pa_per_psi;
		 xpsfrms=xpsirms*144.;
		 xdB = 20.*log10(xparms/ref2);
		 xmicrobar=xmicroparms/1.0e+05; 

		 if( handles.nChoiceUnits == 1 )
			 xdB= handles.value;
         end
         if( handles.nChoiceUnits == 2 )
			 xpsirms= handles.value;
         end
		 if( handles.nChoiceUnits == 3 )
			 xpsfrms= handles.value;
         end
		 if( handles.nChoiceUnits == 4 )
			 xparms= handles.value;
         end
		 if( handles.nChoiceUnits == 5 )
			 xmicroparms= handles.value;
		 end
		 if( handles.nChoiceUnits == 6 )
			 xmicrobar= handles.value;
         end

ss=sprintf('%12.5g dB ref 20 micro Pa \n\n %12.5g psi rms \n %12.5g psf rms \n\n %12.5g Pa rms \n %12.5g microPa rms \n\n %12.5g microbar rms',...
                        xdB,xpsirms,xpsfrms,xparms,xmicroparms,xmicrobar );         
set(handles.edit_results,'String',ss);         
         
%%%


function length(hObject, eventdata, handles)

xmils=0.;      %  1  
xinches=0.;    %  2
xfeet=0.;      %  3
xyards=0.;     %  4
xmiles=0.;     %  5
xnautical=0.;  %  6
xmicrons=0.;   %  7 
xmm=0.;        %  8
xcm=0.;        %  9
xmeters=0.;    %  10
xkm=0.;        % 11
xau=0.;        % 12
xly=0.;        % 13
xparsec=0.;    % 14


	 cmils_meters=1./39370.;
	 cinches_meters=handles.meters_per_inch;
	 cyards_meters=(handles.meters_per_foot)*3.;
	 cmiles_meters=handles.meters_per_mile;
	 cnautical_meters=1852.;
	 cmicrons_meters=1./1000000.;
	 cmm_meters=1./1000.;
	 ccm_meters=1./100.;
	 ckm_meters=1000.;
	 cau_meters=1.495980e+11;
	 cly_meters=9.460550e+15;
	 cparsec_meters=3.084e+16;


         if( handles.nChoiceUnits == 1 )
			 xmeters=handles.value*cmils_meters;
         end

         if( handles.nChoiceUnits == 2 )
			 xmeters=handles.value*cinches_meters;
         end

		 if( handles.nChoiceUnits == 3 )
			 xmeters=handles.value*handles.meters_per_foot;
         end

         if( handles.nChoiceUnits == 4 )
			 xmeters=handles.value*cyards_meters;
         end

		 if( handles.nChoiceUnits == 5 )
			 xmeters=handles.value*cmiles_meters;
         end

         if( handles.nChoiceUnits == 6 )
			 xmeters=handles.value*cnautical_meters;
         end

		 if( handles.nChoiceUnits == 7 )
			 xmeters=handles.value*cmicrons_meters;
         end

         if( handles.nChoiceUnits == 8 )
			 xmeters=handles.value*cmm_meters;
         end

		 if( handles.nChoiceUnits == 9 )
			 xmeters=handles.value*ccm_meters;
         end
		 if( handles.nChoiceUnits == 10 )
			 xmeters=handles.value;
         end
		 if( handles.nChoiceUnits == 11 )
			 xmeters=handles.value*ckm_meters;
         end
		 if( handles.nChoiceUnits == 12)
			 xmeters = 	 handles.value*cau_meters;
		 end

		 if( handles.nChoiceUnits == 13 )
			 xmeters=handles.value*cly_meters;
         end

		 if( handles.nChoiceUnits == 14)
			 xmeters = 	 handles.value*cparsec_meters;
		 end

         xmils     = xmeters/cmils_meters;
		 xinches   = xmeters/handles.meters_per_inch;
		 xfeet     = xmeters/handles.meters_per_foot; 
 	     xyards    = xmeters/cyards_meters;
		 xmiles    = xmeters/cmiles_meters;
		 xnautical = xmeters/cnautical_meters;

		 xmicrons=xmeters/cmicrons_meters;
		 xmm=xmeters/cmm_meters;
		 xcm=xmeters/ccm_meters;
		 xkm=xmeters/ckm_meters;
         xau=xmeters/cau_meters;
         xly=xmeters/cly_meters;
		 xparsec=xmeters/cparsec_meters;

         if( handles.nChoiceUnits == 1 )
			 xmils=handles.value;
         end

         if( handles.nChoiceUnits == 2 )
			 xinches=handles.value;
         end

		 if( handles.nChoiceUnits == 3 )
			 xfeet=handles.value;
         end

         if( handles.nChoiceUnits == 4 )
			 xyards=handles.value;
         end

		 if( handles.nChoiceUnits == 5 )
			 xmiles=handles.value;
			 xfeet=xmiles*feet_per_mile;
			 xyards=xfeet/3.;
			 xinches=xfeet*12.;
         end

         if( handles.nChoiceUnits == 6 )
			 xnautical=handles.value;
         end

		 if( handles.nChoiceUnits == 7 )
			 xmicrons=handles.value;
         end

         if( handles.nChoiceUnits == 8 )
			 xmm=handles.value;
         end

		 if( handles.nChoiceUnits == 9 )
			 xcm=handles.value;
         end

         if( handles.nChoiceUnits == 10 )
			 xmeters=handles.value;
         end

		 if( handles.nChoiceUnits == 11 )
			 xkm=handles.value;
         end

		 if( handles.nChoiceUnits == 12)
			 xau=handles.value;
		 end

	     if( handles.nChoiceUnits == 13 )
			 xly=handles.value;
         end

		 if( handles.nChoiceUnits == 14)
			 xparsec=handles.value;
		 end

         
ss=sprintf('%12.5g Mils \n %12.5g inches \n %12.5g feet \n %12.5g yards \n\n %12.5g miles (statute) \n %12.5g nautical miles \n\n %12.5g microns \n %12.5g mm \n %12.5g cm \n\n %12.5g meters \n %12.5g km \n\n %12.5g AU \n %12.5g light-years \n %12.5g parsec',...
			     xmils,xinches,xfeet,xyards,xmiles,xnautical,xmicrons,xmm,xcm,xmeters,xkm,xau,xly,xparsec);	

set(handles.edit_results,'String',ss); 
%

function velox(hObject, eventdata, handles)


xinchespersecond    =0.;   % 1
xfeetpersecond   =0.;      % 2
xmilesperhour    =0.;      % 3
xknots = 0.;	            % 4
xmeterspersecond = 0.;     % 5
xkmpersecond = 0.;         % 6
xkmperhour = 0.;           % 7
xc = 0.;                   % 8
xmach =0.;                 % 9

	 fm = handles.feet_per_mile/3600.;
	 fk = 6076./3600.;

         if( handles.nChoiceUnits == 1 )
			 xfeetpersecond=handles.value/12;
         end
         if( handles.nChoiceUnits == 2 )
			 xfeetpersecond=handles.value;
         end
		 if( handles.nChoiceUnits == 3 )
			 xfeetpersecond=handles.value*fm;
         end
		 if( handles.nChoiceUnits == 4 )
			 xfeetpersecond=handles.value*fk;
         end
		 if( handles.nChoiceUnits == 5 )
			 xfeetpersecond=handles.value/handles.meters_per_foot;
         end
		 if( handles.nChoiceUnits == 6 )
			 xfeetpersecond=handles.value*1000./handles.meters_per_foot;
         end
		 if( handles.nChoiceUnits == 7 )
			 xfeetpersecond=handles.value*(1000./handles.meters_per_foot)/3600.;
         end
		 if( handles.nChoiceUnits == 8 )
			 xfeetpersecond=handles.value*3.00e+08/handles.meters_per_foot;
         end
		 if( handles.nChoiceUnits == 9 )
			 xfeetpersecond=handles.value*1125.;
         end

		 xinchespersecond=xfeetpersecond*12.;
		 xmilesperhour=xfeetpersecond/fm;
		 xknots=xfeetpersecond/fk;
		 xmeterspersecond = xfeetpersecond*handles.meters_per_foot;
		 xkmpersecond=xmeterspersecond/1000.;
		 xkmperhour=xkmpersecond*3600.;
		 xc=xmeterspersecond/3.00e+08;
		 xmach=xfeetpersecond/1125.;

         if( handles.nChoiceUnits == 1 )
			 xinchespersecond=handles.value;
         end

         if( handles.nChoiceUnits == 2 )
			 xfeetpersecond=handles.value;
         end

		 if( handles.nChoiceUnits == 3 )
			 xmilesperhour=handles.value;
         end

		 if( handles.nChoiceUnits == 4 )
			 xknots=handles.value;
         end

		 if( handles.nChoiceUnits == 5 )
			 xmeterspersecond=handles.value;
         end

		 if( handles.nChoiceUnits == 6 )
			 xkmpersecond=handles.value;
         end

		 if( handles.nChoiceUnits == 7 )
			 xkmperhour=handles.value;
         end

		 if( handles.nChoiceUnits == 8 )
			 xc=handles.value;
         end

		 if( handles.nChoiceUnits == 9 )
			 xmach=handles.value;
         end

ss=sprintf('%12.5g inches/sec \n %12.5g feet/sec \n\n %12.5g miles/hour \n %12.5g knots\n\n %12.5g meter/sec \n %12.5g km/sec \n %12.5g km/hr \n\n %12.5g c (speed of light) \n\n %12.5g Mach (sea level)',...
			     xinchespersecond,xfeetpersecond,xmilesperhour,xknots,xmeterspersecond, xkmpersecond, xkmperhour, xc, xmach);	


set(handles.edit_results,'String',ss); 
%

function accel(hObject, eventdata, handles)

 xg=0.;
 xfpss=0.;
 xmpss=0.;
 xinpss=0.;
 xmmpss=0.;

 cgf = handles.lbm_per_slug;
 cgm = handles.meterspersecond2_per_G;
 cgin = cgf*12.;
 cgmm = cgm*1000.;

         if( handles.nChoiceUnits == 1 )
			 xg=handles.value;
         end

		 if( handles.nChoiceUnits == 2 )
			 xg=handles.value/cgin;
         end

		 if( handles.nChoiceUnits == 3 )
			 xg=handles.value/cgf;
         end

		 if( handles.nChoiceUnits == 4 )
			 xg=handles.value/cgmm;
         end

		 if( handles.nChoiceUnits == 5 )
			 xg=handles.value/cgm;
         end

		 xinpss=xg*cgin;
		 xfpss=xg*cgf;
		 xmmpss=xg*cgmm;
		 xmpss=xg*cgm;

         if( handles.nChoiceUnits == 2 )
			 xinpss=handles.value;
         end

		 if( handles.nChoiceUnits == 3 )
			 xfpss=handles.value;
         end
         
         if( handles.nChoiceUnits == 4 )
			 xmmpss=handles.value;
         end

		 if( handles.nChoiceUnits == 5 )
			 xmpss=handles.value;
         end

ss=sprintf('%12.5g G \n\n %12.5g in/sec^2 \n %12.5g ft/sec^2 \n\n %12.5g mm/sec^2 \n %12.5g m/sec^2',...
    xg,xinpss,xfpss,xmmpss, xmpss ); 

set(handles.edit_results,'String',ss); 
%

function accel_PSD(hObject, eventdata, handles)

% G^2/Hz                 1
% (m/sec^2)^2/Hz         2
% m^2/sec^3              3
% ft/sec^2)^2/Hz         4 
% ft^2/sec^3             5
% (in/sec^2)^2/Hz        6
% in^2/sec^3             7
% G^2/(rad/sec)          8
% (m/sec^2)^2/(rad/sec)  9
% (ft/sec^2)^2/(rad/sec) 10
% (in/sec^2)^2/(rad/sec) 11

tpi=2*pi; 

	 xg2_per_Hz=0.;
	 xm_per_sec2_per_Hz=0.;
	 xft_per_sec2_per_Hz=0.;
	 xin_per_sec2_per_Hz=0.;
	 xg2_per_rad=0.; 
	
	 xm_rad=0.;
	 xf_rad=0.;
	 xi_rad=0.;

	 C=9.81^2;
	 Cft=32.2^2;
	 Cin=386^2;

	if( handles.nChoiceUnits == 1 )
		xg2_per_Hz=handles.value;
    end
	if( handles.nChoiceUnits == 2 || handles.nChoiceUnits == 3)
		xg2_per_Hz=handles.value/C;
	end
	if( handles.nChoiceUnits == 4 || handles.nChoiceUnits == 5)
		xg2_per_Hz=handles.value/Cft;
	end
	if( handles.nChoiceUnits == 6 || handles.nChoiceUnits == 7)
		xg2_per_Hz=handles.value/Cin;
	end
	if( handles.nChoiceUnits == 8)
		xg2_per_Hz=handles.value*tpi;
	end
	if( handles.nChoiceUnits == 9)
		xg2_per_Hz=handles.value*tpi/C;
	end	
	if( handles.nChoiceUnits == 10)
		xg2_per_Hz=handles.value*tpi/Cft;
	end
	if( handles.nChoiceUnits == 11)
		xg2_per_Hz=handles.value*tpi/Cin;
	end		


	xm_per_sec2_per_Hz=xg2_per_Hz*C;
	xft_per_sec2_per_Hz=xg2_per_Hz*Cft;
	xin_per_sec2_per_Hz=xg2_per_Hz*Cin;	 
	xg2_per_rad=handles.value/tpi;

	xm_rad=xm_per_sec2_per_Hz/tpi ;
	xf_rad=xft_per_sec2_per_Hz/tpi ;
	xi_rad=xin_per_sec2_per_Hz/tpi ;

	if( handles.nChoiceUnits == 2 )
		xm_per_sec2_per_Hz=handles.value;
	end
	if( handles.nChoiceUnits == 4 )
		xft_per_sec2_per_Hz=handles.value;
	end
	if( handles.nChoiceUnits == 6 )
		xin_per_sec2_per_Hz=handles.value;
	end
	if( handles.nChoiceUnits == 8 )
		xg2_per_rad=handles.value;
	end
	if( handles.nChoiceUnits == 9 )
		xm_rad=handles.value;
	end
	if( handles.nChoiceUnits == 10 )
		xf_rad=handles.value;
	end
	if( handles.nChoiceUnits == 11 )
		xi_rad=handles.value;
    end

ss=sprintf('%12.5g G^2/Hz \n\n %12.5g (m/sec^2)^2/Hz \n %12.5g m^2/sec^3 \n\n %12.5g (ft/sec^2)^2/Hz \n %12.5g ft^2/sec^3  \n\n %12.5g (in/sec^2)^2/Hz \n %12.5g in^2/sec^3 \n\n %12.5g G^2/(rad/sec)\n\n %12.5g (m/sec^2)^2/(rad/sec)\n\n %12.5g (ft/sec^2)^2/(rad/sec)\n\n %12.5g (in/sec^2)^2/(rad/sec)',...
    xg2_per_Hz,xm_per_sec2_per_Hz,xm_per_sec2_per_Hz,xft_per_sec2_per_Hz,xft_per_sec2_per_Hz,xin_per_sec2_per_Hz,xin_per_sec2_per_Hz,xg2_per_rad,xm_rad,xf_rad,xi_rad); 

set(handles.edit_results,'String',ss); 
%

function ami(hObject, eventdata, handles)

xm4=0.;     %  1  
xcm4=0.;    %  2
xmm4=0.;    %  3
xin4=0.;    %  4
xft4=0.;    %  5	

	 c_cm4_meters4	=1./100^4;
	 c_mm4_meters4	=1./1000^4;
	 c_in4_meters4	=1./handles.inches_per_meter^4;
	 c_ft4_meters4	=handles.meters_per_foot^4;

         if( handles.nChoiceUnits == 1 )
			 xm4=handles.value;
         end
         if( handles.nChoiceUnits == 2 )
			 xm4=handles.value*c_cm4_meters4;
         end
		 if( handles.nChoiceUnits == 3 )
			 xm4=handles.value*c_mm4_meters4;
         end
         if( handles.nChoiceUnits == 4 )
			 xm4=handles.value*c_in4_meters4;
         end
		 if( handles.nChoiceUnits == 5 )
			 xm4=handles.value*c_ft4_meters4;
         end
 		         
         xcm4    = xm4/c_cm4_meters4;
		 xmm4    = xm4/c_mm4_meters4;
		 xin4    = xm4/c_in4_meters4;
 	     xft4    = xin4/12^4;


         if( handles.nChoiceUnits == 2 )
			 xcm4=handles.value;
         end

		 if( handles.nChoiceUnits == 3 )
			 xmm4=handles.value;
         end

         if( handles.nChoiceUnits == 4 )
			 xin4=handles.value;
         end
		 if( handles.nChoiceUnits == 5 )
			 xft4=handles.value;
         end

       
ss=sprintf('%12.5g meters^4 \n %12.5g cm^4 \n %12.5g mm^4 \n\n %12.5g in^4 \n %12.5g ft^4',...
                                                 xm4,xcm4,xmm4,xin4,xft4);	

set(handles.edit_results,'String',ss); 
%

function temperature(hObject, eventdata, handles)

xf=0.;          %  0
xc=0.;          %  1
xr=0.;          %  2
xk=0.;          %  3


         if( handles.nChoiceUnits == 1 )
		 
			 xf=handles.value;
			 xc=(xf-32.)*5./9.;
			 xk=xc+273.15;
			 xr= xf+459.67; 
         end
         if( handles.nChoiceUnits == 2 )
		 
			 xc=handles.value;
			 xf=xc*(9./5.)+32.;	
			 xk=xc+273.15;
			 xr= xf+459.67;
         end
		 if( handles.nChoiceUnits == 3 )
		 
			 xr=handles.value;
			 xf=xr-459.67;
			 xc=(xf-32.)*5./9.;
			 xk=xc+273.15;
         end
		 if( handles.nChoiceUnits == 4 )
		 
			 xk=handles.value;
			 xc=xk-273.15;
			 xf=xc*(9./5.)+32.;	
			 xr= xf+459.67;
         end

		 if(xr<1.0e-09)
             xr=0.;
         end
		 if(xk<1.0e-09)
             xk=0.;
         end

ss=sprintf('%12.5g deg F \n %12.5g deg C \n %12.5g deg R \n %12.5g K',xf,xc,xr,xk ); 

set(handles.edit_results,'String',ss); 
%

function jerk(hObject, eventdata, handles)

xg=0.;
xfpss=0.;
xmpss=0.;
xinpss=0.;
xmmpss=0.;

 cgf = handles.lbm_per_slug;
 cgm = handles.meterspersecond2_per_G;
 cgin = cgf*12.;
 cgmm = cgm*1000.;

         if( handles.nChoiceUnits == 1 )
			 xg=handles.value;
         end
		 if( handles.nChoiceUnits == 2 )
			 xg=handles.value/cgin;
         end
		 if( handles.nChoiceUnits == 3 )
			 xg=handles.value/cgf;
         end
		 if( handles.nChoiceUnits == 4 )
			 xg=handles.value/cgmm;
         end
		 if( handles.nChoiceUnits == 5 )
			 xg=handles.value/cgm;
         end

		 xinpss=xg*cgin;
		 xfpss=xg*cgf;
		 xmmpss=xg*cgmm;
		 xmpss=xg*cgm;

         if( handles.nChoiceUnits == 2 )
			 xinpss=handles.value;
         end

		 if( handles.nChoiceUnits == 3 )
			 xfpss=handles.value;
         end

         if( handles.nChoiceUnits == 4 )
			 xmmpss=handles.value;
         end

		 if( handles.nChoiceUnits == 5 )
			 xmpss=handles.value;
         end

		
ss=sprintf('%12.5g G/s \n\n %12.5g in/sec^3 \n %12.5g ft/sec^3 \n\n %12.5g mm/sec^3 \n %12.5g m/sec^3',...
                                           xg,xinpss,xfpss,xmmpss, xmpss ); 

set(handles.edit_results,'String',ss); 
%

function kinematic_viscosity(hObject, eventdata, handles)

xm2=0.;     %  1  
xcm2=0.;    %  2
xmm2=0.;    %  3
xin2=0.;    %  4
xft2=0.;    %  5
xyard2=0.;  %  6
xmiles2=0.; %  7 
xacre=0.;   %  8

cfeet_meters=handles.meters_per_foot;
cyards_meters=handles.meters_per_foot*3.;
cmiles_meters=handles.meters_per_mile;

	 c_cm2_meters2	=1./100.^2.;
	 c_mm2_meters2	=1./1000.^2.;
	 c_in2_meters2	=1./handles.inches_per_meter^2.;
	 c_ft2_meters2	=handles.meters_per_foot^2.;
	 c_yards2_meters2	= (handles.meters_per_foot*3.)^2;
	 c_miles2_meters2	=handles.meters_per_mile^2.;
	 c_acres_meters2	= 4047.;

         if( handles.nChoiceUnits == 1 )
			 xm2=handles.value;
         end
         if( handles.nChoiceUnits == 2 )
			 xm2=handles.value*c_cm2_meters2;
         end
		 if( handles.nChoiceUnits == 3 )
			 xm2=handles.value*c_mm2_meters2;
         end
         if( handles.nChoiceUnits == 4 )
			 xm2=handles.value*c_in2_meters2;
         end
		 if( handles.nChoiceUnits == 5 )		 
			 xm2=handles.value*c_ft2_meters2;
         end

         xcm2    = xm2/c_cm2_meters2;
		 xmm2    = xm2/c_mm2_meters2;
		 xin2    = xm2/c_in2_meters2;
 	     xft2    = xm2/c_ft2_meters2;

         if( handles.nChoiceUnits == 1 )
			 xm2=handles.value;
         end
         if( handles.nChoiceUnits == 2 )
			 xcm2=handles.value;
         end
		 if( handles.nChoiceUnits == 3 )
			 xmm2=handles.value;
         end
         if( handles.nChoiceUnits == 4 )
			 xin2=handles.value;
         end
		 if( handles.nChoiceUnits == 5 )
			 xft2=handles.value;
         end

ss=sprintf('%12.5g meters^2/sec \n %12.5g cm^2/sec \n %12.5g mm^2/sec \n\n %12.5g in^2/sec \n %12.5g ft^2/sec',...
                                                  xm2,xcm2,xmm2,xin2,xft2);	

set(handles.edit_results,'String',ss); 
%

function mass(hObject, eventdata, handles)

xlbm=0.;          %  1
xslugs=0.;        %  2
xlbfs2perin = 0.; % 3
xounces=0.;       %  4
xkg=0.;           %  5
xg=0.;            %  6
xmg=0.;           %  7
xgrains=0.;       %  8

	 conv_slug = handles.lbm_per_slug;
	 conv_ounces = 1./16.;

         if( handles.nChoiceUnits == 1 )
			 xlbm=handles.value;
         end

         if( handles.nChoiceUnits == 2 )
			 xlbm=handles.value;
			 xlbm=xlbm*conv_slug;
         end

		 if( handles.nChoiceUnits == 3 )
			 xlbm=handles.value;
			 xlbm=xlbm*conv_slug*12.;
         end

		 if( handles.nChoiceUnits == 4 )
			 xlbm=handles.value;
			 xlbm=xlbm*conv_ounces;
         end

		 if( handles.nChoiceUnits == 5 )
			 xlbm=handles.value;
			 xlbm=xlbm*handles.lbm_per_kg;
         end

		 if( handles.nChoiceUnits == 6 )
			 xlbm=handles.value;
			 xlbm=xlbm*handles.lbm_per_kg/1000.;
         end

		 if( handles.nChoiceUnits == 7 )
			 xlbm=handles.value;
			 xlbm=xlbm*handles.lbm_per_kg/(1000.^2);
         end

		 if( handles.nChoiceUnits == 8 )
			 xlbm=handles.value;
			 xlbm=xlbm*handles.lbm_per_kg*64.79891/(1000.^2);
         end

		 xslugs = xlbm/conv_slug;
		 xlbfs2perin = xslugs/12.;
		 xounces = xlbm/conv_ounces;
		 xkg    = xlbm/handles.lbm_per_kg;
		 xg     = xkg*1000.;
		 xmg    = xg*1000.;
		 xgrains = xmg/64.79891;

         if( handles.nChoiceUnits == 2 )
			 xslugs =handles.value;
         end

		 if( handles.nChoiceUnits == 3)
			 xlbfs2perin =handles.value;

         end
		 if( handles.nChoiceUnits == 4 )
			 xounces=handles.value;
         end

		 if( handles.nChoiceUnits == 5 )		 
			 xkg=handles.value;
         end

		 if( handles.nChoiceUnits == 6 )
			 xg=handles.value;
         end

		 if( handles.nChoiceUnits == 7 )
			 xmg=handles.value;
         end

		 if( handles.nChoiceUnits == 8 )
			 xgrains=handles.value;
         end

ss=sprintf(' %12.5g lbm \n %12.5g slugs (lbf sec^2/ft) \n %12.5g lbf sec^2/in \n\n %12.5g ounces \n\n %12.5g kg \n %12.5g grams \n %12.5g mg \n\n %12.5g grains	',...
    xlbm,xslugs,xlbfs2perin,xounces,xkg,xg,xmg,xgrains ); 


set(handles.edit_results,'String',ss); 
%

function mmi(hObject, eventdata, handles)

	 xlbmft2=0.;         %  1
	 xlbmin2=0.;         %  2
	 xslugsft2=0.;       %  3
	 xslugsin2=0.;       %  4
	 xlbfsec2in=0.;      %  5 
     xkgm2=0.;           %  6

	 conv_slug = handles.lbm_per_slug;

         if( handles.nChoiceUnits == 1 )
			 xlbmft2=handles.value;
         end

         if( handles.nChoiceUnits == 2 )
			 xlbmft2=handles.value;
			 xlbmft2=xlbmft2/144.;
         end

         if( handles.nChoiceUnits == 3 )
			 xlbmft2=handles.value;
			 xlbmft2=xlbmft2*conv_slug;
         end

         if( handles.nChoiceUnits == 4 )
			 xlbmft2=handles.value;
			 xlbmft2=xlbmft2*conv_slug/144.;
         end

         if( handles.nChoiceUnits == 5 )
			 xlbmft2=handles.value;
			 xlbmft2=xlbmft2*conv_slug/12.;
         end

		 if( handles.nChoiceUnits == 6 )
			 xlbmft2=handles.value;
			 xlbmft2=xlbmft2*handles.lbm_per_kg;
			 xlbmft2=xlbmft2/(handles.meters_per_foot^2.);
         end

		 xlbmin2   = xlbmft2*144.;
		 xslugsft2 = xlbmft2/conv_slug;
		 xslugsin2 = xslugsft2*144.;
		 xlbfsec2in = xlbmft2*12./conv_slug;	 
		 xkgm2    = (xlbmft2/handles.lbm_per_kg)*(handles.meters_per_foot^2.);

         if( handles.nChoiceUnits == 2 )
			 xlbmin2 =handles.value;
         end

		 if( handles.nChoiceUnits == 3)
			 xslugsft2 =handles.value;
		 end

		 if( handles.nChoiceUnits == 4 )
			 xslugsin2=handles.value;
         end

		 if( handles.nChoiceUnits == 5 )
			 xlbfsec2in=handles.value;
         end

		 if( handles.nChoiceUnits == 6 )
			 xkgm2=handles.value;
         end

ss=sprintf(' %12.5g lbm ft^2 \n %12.5g lbm in^2 \n\n %12.5g slugs ft^2 \n %12.5g slugs in^2 \n\n %12.5g lbf sec^2 in \n\n %12.5g kg m^2 \n',...
                    xlbmft2,xlbmin2,xslugsft2,xslugsin2,xlbfsec2in,xkgm2); 

set(handles.edit_results,'String',ss); 
%

function massperlength(hObject, eventdata, handles)


xkgperm=0.;         %  1
xlbmperin=0.;       %  2
xlbmperft=0.;       %  3
xlbfsec2perin2=0.;  %  4


	if( handles.nChoiceUnits == 1 )
			xkgperm=handles.value;
	end

	if( handles.nChoiceUnits == 2 )

			xkgperm=handles.value*handles.kg_per_lbm*handles.inches_per_meter;
	end

	if( handles.nChoiceUnits == 3 )

			xkgperm=handles.value*handles.kg_per_lbm*handles.feet_per_meter;
	end

	if( handles.nChoiceUnits == 4 )
			xkgperm=handles.value*handles.n_per_lbf*(handles.inches_per_meter^2);
	end


	xlbmperin=xkgperm/(handles.kg_per_lbm*handles.inches_per_meter);
	xlbmperft=xlbmperin*12.;
	xlbfsec2perin2=xkgperm/(handles.n_per_lbf*handles.inches_per_meter^2);

	if( handles.nChoiceUnits == 2 )
			 xlbmperin=handles.value;
    end
	if( handles.nChoiceUnits == 3 )
			 xlbmperft=handles.value;
    end
	if( handles.nChoiceUnits == 4 )
			 xlbfsec2perin2=handles.value;
	end

ss=sprintf(' %12.5g kg/m \n\n %12.5g lbm/in \n %12.5g lbm/ft \n\n %12.5g lbf sec^2/in^2',...
    xkgperm,xlbmperin,xlbmperft,xlbfsec2perin2); 

set(handles.edit_results,'String',ss); 
%

function massperarea(hObject, eventdata, handles)

xlbmperft2=0.;       %  1
xlbmperin2=0.;       %  2
xslugsperft2=0.;     %  3
xslugsperin2=0.;     %  4
xlbfsec2perin3 = 0.; %  5
xkgperm2=0.;         %  6

in2perft2 = 12.^2.;

         if( handles.nChoiceUnits == 1 )
			 xlbmperft2=handles.value;
         end

         if( handles.nChoiceUnits == 2 )
			 xlbmperin2=handles.value;
		     xlbmperft2=xlbmperin2*in2perft2;
         end

         if( handles.nChoiceUnits == 3 )
			  xlbmperft2=handles.value*32.2;
         end

         if( handles.nChoiceUnits == 4 )
			 xlbmperin2=handles.value*32.2;
	         xlbmperft2=xlbmperin2*in2perft2;
         end
         
		 if( handles.nChoiceUnits == 5 )
			 xlbfsec2perin3=handles.value;
             
%           lbf = slug ft/sec^2             
%           lbfsec2perin4 = (slug ft/sec^2 )sec2perin4
%           lbfsec2perin4 = (slug ft/in4)

			  in_per_ft = 12.;

			  slugftperin3 = xlbfsec2perin3;
			  lbmftperin3 = slugftperin3*handles.lbm_per_slug;
			  lbmperin2 = lbmftperin3*in_per_ft;

			 xlbmperft2=lbmperin2*in2perft2;
         end

		 if( handles.nChoiceUnits == 6 )
			 xkgperm2=handles.value;		 
			 xlbmperft2=xkgperm2*handles.lbm_per_kg*handles.meters_per_foot^2.;
         end

		 in_per_ft=12.;

		 xlbmperin2 = xlbmperft2/in2perft2;
		 xlbfsec2perin3=xlbmperft2/(in2perft2*in_per_ft*handles.lbm_per_slug);
		 xkgperm2=xlbmperft2/( handles.lbm_per_kg*handles.meters_per_foot^2.);
		 xslugsperft2=xlbmperft2/32.2;    
	     xslugsperin2=xlbmperin2/32.2; 

         if( handles.nChoiceUnits == 1 )
			 xlbmperft2=handles.value;
         end

         if( handles.nChoiceUnits == 2 )
			 xlbmperin2=handles.value;
         end

         if( handles.nChoiceUnits == 3 )
			 xslugsperft2=handles.value;
         end

         if( handles.nChoiceUnits == 4 )
			 xslugsperin2=handles.value;
         end

		 if( handles.nChoiceUnits == 5 )
			 xlbfsec2perin3=handles.value;
         end

		 if( handles.nChoiceUnits == 6 )
			 xkgperm2=handles.value;
         end

ss=sprintf(' %12.5g lbm/ft^2 \n %12.5g lbm/in^2 \n\n %12.5g slugs/ft^2 \n %12.5g slugs/in^2 \n\n %12.5g lbf sec^2/in^3 \n\n %12.5g kg/m^2 \n\n',...
     xlbmperft2,xlbmperin2,xslugsperft2,xslugsperin2,xlbfsec2perin3,xkgperm2); 

set(handles.edit_results,'String',ss); 
%

function masspervolume(hObject, eventdata, handles)

xlbmperft3=0.;       %  1
xlbmperin3=0.;       %  2
xslugsperft3=0.;     %  3
xslugsperin3=0.;     %  4
xlbfsec2perin4 = 0.; %  5
xkgperm3=0.;         %  6
xgpercm3=0.;         %  7
xsg=0.;              %  8

in3perft3 = 12^3;

         if( handles.nChoiceUnits == 1 )
			 xlbmperft3=handles.value;
         end

         if( handles.nChoiceUnits == 2 )
			 xlbmperin3=handles.value;
		     xlbmperft3=xlbmperin3*in3perft3;
         end

         if( handles.nChoiceUnits == 3 )
			  xlbmperft3=handles.value*32.2;
         end

         if( handles.nChoiceUnits == 4 )
			 xlbmperin3=handles.value*32.2;
	         xlbmperft3=xlbmperin3*in3perft3;
         end

		 if( handles.nChoiceUnits == 5 )

			 xlbfsec2perin4=handles.value;

%           lbf = slug ft/sec^2             
%           lbfsec2perin4 = (slug ft/sec^2 )sec2perin4
%           lbfsec2perin4 = (slug ft/in4)

			  in_per_ft = 12.;

			  slugftperin4 = xlbfsec2perin4;
			  lbmftperin4 = slugftperin4*handles.lbm_per_slug;
			  lbmperin3 = lbmftperin4*in_per_ft;
			 xlbmperft3=lbmperin3*in3perft3;
         end

		 if( handles.nChoiceUnits == 6 )
			 xkgperm3=handles.value;		 
			 xlbmperft3=xkgperm3*handles.lbm_per_kg*handles.meters_per_foot^3.;

         end

		 if( handles.nChoiceUnits == 7 )
			 xgpercm3=handles.value;
             xkgperm3 = (xgpercm3 /1000.)*100^3;
			 xlbmperft3=xkgperm3*handles.lbm_per_kg*handles.meters_per_foot^3;
         end

		 if( handles.nChoiceUnits == 8 )
			 xsg=handles.value;
			 xgpercm3 = xsg;
             xkgperm3 = (xgpercm3 /1000.)*100^3;
			 xlbmperft3=xkgperm3*handles.lbm_per_kg*handles.meters_per_foot^3;
         end

		  in_per_ft=12.;

		 xlbmperin3 = xlbmperft3/in3perft3;
		 xlbfsec2perin4=xlbmperft3/(in3perft3*in_per_ft*handles.lbm_per_slug);
		 xkgperm3=xlbmperft3/( handles.lbm_per_kg*handles.meters_per_foot^3 );
         xgpercm3=xkgperm3*1000./100^3;
		 xsg=xgpercm3;
		 xslugsperft3=xlbmperft3/32.2;    
	     xslugsperin3=xlbmperin3/32.2; 

         if( handles.nChoiceUnits == 1 )		 
			 xlbmperft3=handles.value;
         end
         if( handles.nChoiceUnits == 2 )
			 xlbmperin3=handles.value;
         end
         if( handles.nChoiceUnits == 3 )
			 xslugsperft3=handles.value;
         end
         if( handles.nChoiceUnits == 4 )
			 xslugsperin3=handles.value;
         end
		 if( handles.nChoiceUnits == 5 )
			 xlbfsec2perin4=handles.value;
         end
		 if( handles.nChoiceUnits == 6 )
			 xkgperm3=handles.value;
         end
		 if( handles.nChoiceUnits == 7 )
			 xgpercm3=handles.value;
             xsg = xgpercm3;
         end
		 if( handles.nChoiceUnits == 8 )
			 xsg=handles.value;
		     xgpercm3 = xsg;
         end

ss=sprintf(' %12.5g lbm/ft^3 \n %12.5g lbm/in^3 \n\n %12.5g slugs/ft^3 \n %12.5g slugs/in^3 \n\n %12.5g lbf sec^2/in^4 \n\n %12.5g kg/m^3 \n\n %12.5g g/cm^3 \n\n %12.5g specific gravity : H20',...
    xlbmperft3,xlbmperin3,xslugsperft3,xslugsperin3,xlbfsec2perin4,xkgperm3,xgpercm3,xsg ); 

set(handles.edit_results,'String',ss); 
%

function moment(hObject, eventdata, handles)

xNm = 0.;
xftlbf = 0.;
xinlbf= 0.;

    if( handles.nChoiceUnits == 1 )
	
			 xNm=handles.value;
    end
    if( handles.nChoiceUnits == 2 )
	
			 xNm=handles.value*handles.n_per_lbf*handles.meters_per_foot;
    end

    if( handles.nChoiceUnits == 3 )
	
			 xNm=handles.value*handles.n_per_lbf*handles.meters_per_inch;
    end	 

	xftlbf = xNm/(handles.n_per_lbf*handles.meters_per_foot);
    xinlbf = xNm/(handles.n_per_lbf*handles.meters_per_inch);


	if( handles.nChoiceUnits == 2 )	
			 xftlbf=handles.value;
    end

    if( handles.nChoiceUnits == 3 )
			 xinlbf=handles.value;
    end	 

 
ss=sprintf('%12.5g N m\n %12.5g ft lbf\n %12.5g in lbf\n',xNm,xftlbf,xinlbf); 

set(handles.edit_results,'String',ss); 
%

function force(hObject, eventdata, handles)

 xf=0.;
 xn=0.;
 xk=0.;
 xd=0.;

 cfn = handles.lbf_per_n;
 cfk = 1000.;
 cfd = cfn/0.10e+06;

         if( handles.nChoiceUnits == 1 )
			 xf=handles.value;
         end

		 if( handles.nChoiceUnits == 2 )
			 xf=handles.value*cfk;
         end
         
         if( handles.nChoiceUnits == 3 )
			 xf=handles.value*cfn;
         end

		 if( handles.nChoiceUnits == 4 )
			 xf=handles.value*cfd;
         end

		 xk=xf/cfk;
		 xn=xf/cfn;
		 xd=xf/cfd;

         if( handles.nChoiceUnits == 2 )
			 xk=handles.value;
         end

         if( handles.nChoiceUnits == 3 )
			 xn=handles.value;
         end

		 if( handles.nChoiceUnits == 4 )
			 xd=handles.value;
         end

ss=sprintf('%12.5g lbf \n %12.5g kips \n %12.5g N \n %12.5g dynes',xf,xk,xn,xd); 

set(handles.edit_results,'String',ss); 
%

function pressure(hObject, eventdata, handles)

xatm=0.;  % 1
xpsi=0.;  % 2
xpsf=0.;  % 3
xpa=0.;	  % 4
xdcm=0.;  % 5
xbar=0.;  % 6
xmbar=0.; % 7
xtorr=0.; % 8
xinhg=0.; % 9
xinw=0.;  % 10

 cpsi=14.70;
 cpsf=2116.;
 cpa=1.013e+05;
 cdcm=1.013e+06;
 cmbar= 1.013e+03;
 cbar=cmbar/1000.;
 ctorr=760.;
 cinhg=76./handles.cmeters_per_inch;
 cinw = 406.8;

        if( handles.nChoiceUnits == 1 )
			 xatm=handles.value;
         end

         if( handles.nChoiceUnits == 2 )		% psi
			 xatm=handles.value/cpsi;
         end

         if( handles.nChoiceUnits == 3 )		% psf
			 xatm=handles.value/cpsf;
         end
		 if( handles.nChoiceUnits == 4 )
			 xatm=handles.value/cpa;	  % pa
		 end
		 if( handles.nChoiceUnits == 5 )
			 xatm=handles.value/cdcm;	  % dcm
         end		 
		 if( handles.nChoiceUnits == 6 )
			 xatm=handles.value/cbar;   % bar
         end
		 if( handles.nChoiceUnits == 7 )
			 xatm=handles.value/cmbar;   % mbar
         end

		 if( handles.nChoiceUnits == 8 )
			 xatm=handles.value/ctorr;	  % torr
         end

  	     if( handles.nChoiceUnits == 9 )
			 xatm=handles.value/cinhg;	  % in Hg
         end

         if( handles.nChoiceUnits == 10 )
			 xatm=handles.value/cinw;	  % in Water
         end

		 xpsi  =xatm*cpsi;
 		 xpsf  =xatm*cpsf;
		 xpa   =xatm*cpa;
		 xdcm  =xatm*cdcm;
		 xmbar =xatm*cmbar;
		 xtorr =xatm*ctorr;
		 xinhg =xatm*cinhg;
		 xinw  =xatm*cinw;
		 xbar  =xmbar/1000.;
         
         if( handles.nChoiceUnits == 2 )
			 xpsi=handles.value;
         end

		 if( handles.nChoiceUnits == 3 )
			 xpsf=handles.value;
         else
			 xpsf = 144.*xpsi;
		 end

         if( handles.nChoiceUnits == 4 )
			 xpa=handles.value;
         end

		 if( handles.nChoiceUnits == 5 )
			 xdcm=handles.value;
         end

		 if( handles.nChoiceUnits == 6 )
			 xbar=handles.value;
		 end

		 if( handles.nChoiceUnits == 7 )
			 xmbar=handles.value;
		 end

		 if( handles.nChoiceUnits == 8 )
			 xtorr=handles.value;
		 end

         if( handles.nChoiceUnits == 9 )
			 xinhg=handles.value;
		 end

         if( handles.nChoiceUnits == 10 )
			 xinw=handles.value;
         end

ss=sprintf('%12.5g atm \n %12.5g psi \n %12.5g psf \n\n %12.5g Pascal \n %12.5g dynes/cm^2 \n\n %12.5g bar \n %12.5g millibar \n\n %12.5g mm Hg (torr) \n %12.5g inches Hg \n %12.5g inches Water\n\n',...
    xatm,xpsi,xpsf,xpa,xdcm,xbar,xmbar,xtorr,xinhg,xinw ); 	

set(handles.edit_results,'String',ss); 
%

function energy_per_mass(hObject, eventdata, handles)

xj_per_kg=0.;		 %  0
xkj_per_kg=0.;		 %  1
xft_lbf_per_lbm=0.;  %  2
xin_lbf_per_lbm=0.;  %  3

	
     ft_lbf_per_J =  0.7376;

         if( handles.nChoiceUnits == 1 )
			 xj_per_kg=handles.value;
         end
         if( handles.nChoiceUnits == 2 )
			 xj_per_kg=handles.value*1000.;
         end
		 if( handles.nChoiceUnits == 3 )
			 xj_per_kg=handles.value*handles.lbm_per_kg/ft_lbf_per_J;			 
         end
         if( handles.nChoiceUnits == 4 )
			 xj_per_kg=handles.value*handles.lbm_per_kg/(12*ft_lbf_per_J);
         end

        
		 xkj_per_kg=xj_per_kg/1000.;
		 xft_lbf_per_lbm=xj_per_kg*ft_lbf_per_J/handles.lbm_per_kg;
         xin_lbf_per_lbm=xft_lbf_per_lbm*12;


		 if( handles.nChoiceUnits == 2 )
			 xkj_per_kg=handles.value;
         end
		 if( handles.nChoiceUnits == 3 )
			 xft_lbf_per_lbm=handles.value;			 
         end
		 if( handles.nChoiceUnits == 4 )
			 xin_lbf_per_lbm=handles.value;
         end

	
ss=sprintf('%12.5g J/kg \n %12.5g kJ/kg \n\n %12.5g ft-lbf/lbm \n %12.5g in-lbf/lbm',...
                    xj_per_kg,xkj_per_kg,xft_lbf_per_lbm,xin_lbf_per_lbm ); 

set(handles.edit_results,'String',ss); 
%

function intensity(hObject, eventdata, handles)

xdB=0.;       % 1
xw_per_m2=0.; % 2

         if( handles.nChoiceUnits == 1 )
			 xw_per_m2=1.0e-12*10^(handles.value/10.);
         end	

		 if( handles.nChoiceUnits == 2 )
			 xw_per_m2=handles.value;	
         end 

		 xdB=10*log10(xw_per_m2/1.0e-12);		 

		 if( handles.nChoiceUnits == 1 )
			 xdB=handles.value;
         end
		 if( handles.nChoiceUnits == 2 )
			 xw_per_m2=handles.value;			 
         end

		 
ss=sprintf('%12.5g dB  ref: 1.0e-12 W/m^2 \n\n %12.5g W/m^2',xdB,xw_per_m2); 

set(handles.edit_results,'String',ss); 
%

function frequency(hObject, eventdata, handles)


xf=0.;       % 1
xrad=0.;     % 2
xrpm=0.;     % 3
xper = 0.;   % 4

	 cfrad=2*pi;
	 cfrpm=60.;

         if( handles.nChoiceUnits == 1 )
			 xf=handles.value;
         end

         if( handles.nChoiceUnits == 2 )
			 xf=handles.value/cfrad;
         end

		 if( handles.nChoiceUnits == 3 )
			 xf=handles.value/cfrpm;			 
         end

		 if( handles.nChoiceUnits == 4 )
			 xf=1./handles.value;
         end

		 xrad=xf*cfrad;
		 xrpm=xf*cfrpm;
         xper = 1./xf; 

		 if( handles.nChoiceUnits == 2 )
			 xrad=handles.value;
         end

		 if( handles.nChoiceUnits == 3 )
			 xrpm=handles.value;			 
         end

		 if( handles.nChoiceUnits == 4 )
			 xper=handles.value;			 
         end

ss=sprintf('Frequency \n\n %12.5g Hz \n %12.5g rad/sec \n %12.5g rpm \n\nPeriod \n\n %12.5g sec',...
    xf,xrad,xrpm,xper ); 

set(handles.edit_results,'String',ss); 
%

function impedance(hObject, eventdata, handles)


%		N sec/m				0
%	    lbf sec/in			1
%	    lbf sec/ft			2

xNsecpm=0.;		%  1
xNsecpcm=0.;	%  2
xlbfsecpin=0.;  %  3
xlbfsecpft=0.;	%  4


         if( handles.nChoiceUnits == 1 )
			 xNsecpm=handles.value;
         end
         if( handles.nChoiceUnits == 2 )
			 xNsecpm=handles.value*100.;
         end
         if( handles.nChoiceUnits == 3 )
			 xNsecpm=handles.value*handles.n_per_lbf/handles.meters_per_inch;
         end
         if( handles.nChoiceUnits == 4 )
			 xNsecpm=handles.value*handles.n_per_lbf/handles.meters_per_foot;
         end

		 xNsecpcm=xNsecpm/100.;
		 xlbfsecpin=(xNsecpm/handles.n_per_lbf)*handles.meters_per_inch;
		 xlbfsecpft=xlbfsecpin*12.;

         if( handles.nChoiceUnits == 2 )
			 xNsecpcm=handles.value;
         end
         if( handles.nChoiceUnits == 3 )
			 xlbfsecpin=handles.value;
         end
         if( handles.nChoiceUnits == 4 )		 
			 xlbfsecpft=handles.value;
         end


ss=sprintf('%12.5g N sec/m \n %12.5g N sec/cm \n\n %12.5g lbf sec/in \n %12.5g lbf sec/ft',...
                                   xNsecpm,xNsecpcm,xlbfsecpin,xlbfsecpft);

set(handles.edit_results,'String',ss); 
%

function energy(hObject, eventdata, handles)

xj=0.;      %  1
xerg=0.;    %  2
xftlbf=0.;  %  3
xwh=0.;     %  4
xbtu=0.;    %  5
xkcal=0.;   %  6
xev=0.;     %  7


	 cerg=1.0e+07;
	 cftlbf=0.7376;
	 cwh=2.778e-04;
	 cbtu=9.478e-04;
	 ckcal=2.388e-04;
	 cev=1./1.602e-19;


         if( handles.nChoiceUnits == 1 )
			 xj=handles.value;
         end

         if( handles.nChoiceUnits == 2 )
			 xj=handles.value/cerg;
         end

		 if( handles.nChoiceUnits == 3 )
			 xj=handles.value/cftlbf;			 
         end

         if( handles.nChoiceUnits == 4 )
			 xj=handles.value/cwh;
         end

         if( handles.nChoiceUnits == 5 )
			 xj=handles.value/cbtu;
         end

		 if( handles.nChoiceUnits == 6 )
			 xj=handles.value/ckcal;			 
         end

		 if( handles.nChoiceUnits == 7 )
			 xj=handles.value/cev;			 
         end


		 xerg=xj*cerg;
		 xftlbf=xj*cftlbf;
		 xwh=xj*cwh;
		 xbtu=xj*cbtu;
		 xkcal=xj*ckcal;
		 xev=xj*cev;

		 if( handles.nChoiceUnits == 2 )
			 xerg=handles.value;
         end

		 if( handles.nChoiceUnits == 3 )
			 xftlbf=handles.value;			 
         end

		 if( handles.nChoiceUnits == 4 )
			 xwh=handles.value;
         end

		 if( handles.nChoiceUnits == 5 )
			 xbtu=handles.value;			 
         end

         if( handles.nChoiceUnits == 6 )
			 xkcal=handles.value;			 
         end

		 if( handles.nChoiceUnits == 7 )
			 xev=handles.value;			 
         end

ss=sprintf('%12.5g Joules \n %12.5g ergs \n\n %12.5g ft-lbf \n %12.5g Watt-hours \n %12.5g BTU \n\n %12.5g kilocalories \n %12.5g eV',...
    xj,xerg,xftlbf,xwh,xbtu,xkcal,xev ); 

set(handles.edit_results,'String',ss); 
%

function power(hObject, eventdata, handles)

xw=0.;            % 1
xkw=0.;           % 2
xftlbfpersec=0.;  % 3
xhorse=0.;        % 4
xbtuperh=0.;      % 5
xdBm=0.;          % 6
xdBp=0.;          % 7

	 ckw=1./1000.;
	 cftlbfpersec=0.7376;
	 chorse=1.341e-03;
	 cbtuperh=3.412;

         if( handles.nChoiceUnits == 1 )
			 xw=handles.value;
         end

         if( handles.nChoiceUnits == 2 )
			 xw=handles.value/ckw;
         end

		 if( handles.nChoiceUnits == 3 )
			 xw=handles.value/cftlbfpersec;			 
         end

         if( handles.nChoiceUnits == 4 )
			 xw=handles.value/chorse;
         end

         if( handles.nChoiceUnits == 5 )
			 xw=handles.value/cbtuperh;
         end

         if( handles.nChoiceUnits == 6 )
			 xw=0.001*10^(handles.value/10.);
         end

         if( handles.nChoiceUnits == 7 )
			 xw=1.0e-12*10^(handles.value/10.);
         end		 


		 xkw=xw*ckw;
		 xftlbfpersec=xw*cftlbfpersec;
		 xhorse=xw*chorse;
		 xbtuperh=xw*cbtuperh;

		 xdBm=10*log10(xw/0.001);
		 xdBp=10*log10(xw/1.0e-12);		 

		 if( handles.nChoiceUnits == 2 )
			 xkw=handles.value;
         end
		 if( handles.nChoiceUnits == 3 )
			 xftlbfpersec=handles.value;			 
         end
		 if( handles.nChoiceUnits == 4 )
			 xhorse=handles.value;
         end
		 if( handles.nChoiceUnits == 5 )
			 xbtuperh=handles.value;			 
         end
    	 if( handles.nChoiceUnits == 6 )
			 xdBm=handles.value;
         end
		 if( handles.nChoiceUnits == 7 )
			 xdBp=handles.value;			 
         end

            
ss=sprintf('%12.5g Watts \n %12.5g kilowatts \n\n %12.5g ft-lbf/sec \n %12.5g Horsepower \n\n %12.5g BTU/hour \n\n %12.5g dBm \n %12.5g dB (ref: 1.0e-12 Watt) ',...
                      xw,xkw,xftlbfpersec,xhorse,xbtuperh,xdBm,xdBp); 

set(handles.edit_results,'String',ss); 
%

function angle(hObject, eventdata, handles)

xdeg=0.;    %  1
xrad=0.;    %  2

ccc = atan2(0.,-1.)/180.;

         if( handles.nChoiceUnits == 1 )
			 xdeg=handles.value;
			 xrad=handles.value*ccc;
         end

         if( handles.nChoiceUnits == 2 )
			 xdeg=handles.value/ccc;
			 xrad=handles.value;
         end

ss=sprintf('%12.5g degrees \n %12.5g radians',xdeg,xrad); 

set(handles.edit_results,'String',ss); 
%

function area(hObject, eventdata, handles)

xm2=0.;     %  1  
xcm2=0.;    %  2
xmm2=0.;    %  3
xin2=0.;    %  4
xft2=0.;    %  5
xyard2=0.;  %  6
xmiles2=0.; %  7 
xacre=0.;   %  8


	 cfeet_meters=handles.meters_per_foot;
	 cyards_meters=handles.meters_per_foot*3.;
	 cmiles_meters=handles.meters_per_mile;

	 c_cm2_meters2	=1./100.^2.;
	 c_mm2_meters2	=1./1000.^2.;
	 c_in2_meters2	=1./handles.inches_per_meter^2.;
	 c_ft2_meters2	=handles.meters_per_foot^2.;
	 c_yards2_meters2 = (handles.meters_per_foot*3.)^2;
	 c_miles2_meters2 = handles.meters_per_mile^2.;
	 c_acres_meters2  = 4047.;


         if( handles.nChoiceUnits == 1 )
			 xm2=handles.value;
         end

         if( handles.nChoiceUnits == 2 )
			 xm2=handles.value*c_cm2_meters2;
         end

		 if( handles.nChoiceUnits == 3 )
			 xm2=handles.value*c_mm2_meters2;
         end

         if( handles.nChoiceUnits == 4 )
			 xm2=handles.value*c_in2_meters2;
         end

		 if( handles.nChoiceUnits == 5 )
			 xm2=handles.value*c_ft2_meters2;
         end

         if( handles.nChoiceUnits == 6 )
			 xm2=handles.value*c_yards2_meters2;
         end

		 if( handles.nChoiceUnits == 7 )
			 xm2=handles.value*c_miles2_meters2;
         end

         if( handles.nChoiceUnits == 8 )
			 xm2=handles.value*c_acres_meters2;
         end

         xcm2    = xm2/c_cm2_meters2;
		 xmm2    = xm2/c_mm2_meters2;
		 xin2    = xm2/c_in2_meters2;
 	     xft2    = xm2/c_ft2_meters2;
		 xyard2  = xm2/c_yards2_meters2;
		 xmiles2 = xm2/c_miles2_meters2;
         xacre   = xm2/c_acres_meters2;

         if( handles.nChoiceUnits == 1 )
			 xm2=handles.value;
         end

         if( handles.nChoiceUnits == 2 )
			 xcm2=handles.value;
         end

		 if( handles.nChoiceUnits == 3 )
			 xmm2=handles.value;
         end

         if( handles.nChoiceUnits == 4 )
			 xin2=handles.value;
         end

		 if( handles.nChoiceUnits == 5 )
			 xft2=handles.value;
         end

         if( handles.nChoiceUnits == 6 )
			 xyard2=handles.value;
         end

		 if( handles.nChoiceUnits == 7 )
			 xmiles2=handles.value;
			 xacre = xmiles2*640.;
         end

         if( handles.nChoiceUnits == 8 )
			 xacre=handles.value;
			 xmiles2 = xacre/640.;
         end


ss=sprintf('%12.5g meters^2 \n %12.5g cm^2 \n %12.5g mm^2 \n\n %12.5g in^2 \n %12.5g ft^2 \n\n %12.5g yards^2 \n %12.5g miles^2 \n %12.5g acres',...
                            xm2,xcm2,xmm2,xin2,xft2,xyard2,xmiles2,xacre);	

set(handles.edit_results,'String',ss); 
%

function volume(hObject, eventdata, handles)

	 xin3=0.;     %  1  
     xft3=0.;     %  2 
     xmiles3=0.;  %  3
	 xmm3=0.;     %  4
	 xcm3=0.;     %  5 
	 xm3 =0.;     %  6
	 xkm3=0.;     %  7 
	 xliter=0.;   %  8
     xgallons=0.; %  9
	 xquarts=0.;  %  10
	 xpints=0.;   %  11


	 cft3=12^3;

	 cmiles3=(12.*handles.feet_per_mile)^3;
     cmm3=handles.mmeters_per_inch^3;
	 ccm3=handles.cmeters_per_inch^3;


	 cm3=handles.meters_per_inch^3;

	 ckm3= (handles.meters_per_inch/1000.)^3;

	 cliter=1000./ccm3;
	 cgallons=231.0;
	 cquarts=cgallons/4.;



         if( handles.nChoiceUnits == 1 )
			 xin3=handles.value;
         end

         if( handles.nChoiceUnits == 2 )
			 xin3=handles.value*cft3;
         end

		 if( handles.nChoiceUnits == 3 )
			 xin3=handles.value*cmiles3;
         end

		 if( handles.nChoiceUnits == 4 )
			 xin3=handles.value/cmm3;
         end

		 if( handles.nChoiceUnits == 5 )
			 xin3=handles.value/ccm3;
         end

		 if( handles.nChoiceUnits == 6 )
			 xin3=handles.value/cm3;
         end

		 if( handles.nChoiceUnits == 7 )
			 xin3=handles.value/ckm3;
         end
		 if( handles.nChoiceUnits == 8 )
			 xin3=handles.value*cliter;
         end
		 if( handles.nChoiceUnits == 9 )
			 xin3=handles.value*cgallons;
         end

		 if( handles.nChoiceUnits == 10 )
			 xin3=handles.value*cquarts;
         end

		 if( handles.nChoiceUnits == 11 )		 
			 xin3=handles.value*cquarts/2;
         end

		         
         xft3    = xin3/cft3;
		 xmiles3 = xin3/cmiles3;
		 xmm3    = xin3*cmm3;
		 xcm3    = xin3*ccm3;
		 xm3    =  xin3*cm3;
		 xkm3    = xin3*ckm3;
		 xliter    = xin3/cliter;
		 xgallons  = xin3/cgallons;
		 xquarts = xin3/cquarts;
	     xpints = 2*xquarts;


         if( handles.nChoiceUnits == 1 )
		 
			 xin3=handles.value;
         end
         if( handles.nChoiceUnits == 2 )
		 
			 xft3=handles.value;
         end
		 if( handles.nChoiceUnits == 3 )
		 
			 xmiles3=handles.value;
         end

		 if( handles.nChoiceUnits == 4 )
			 xmm3=handles.value;
         end

		 if( handles.nChoiceUnits == 5 )
			 xcm3=handles.value;
         end

		 if( handles.nChoiceUnits == 6 )
			 xm3=handles.value;
         end

		 if( handles.nChoiceUnits == 7 )
			 xkm3=handles.value;
         end

		 if( handles.nChoiceUnits == 8 )
			 xliter=handles.value;
         end

		 if( handles.nChoiceUnits == 9 )
			 xgallons=handles.value;
         end

		 if( handles.nChoiceUnits == 10 )
			 xquarts=handles.value;
         end

		 if( handles.nChoiceUnits == 11 )
			 xpints=handles.value;
         end

		 
ss=sprintf('%12.5g in^3 \n %12.5g ft^3 \n %12.5g miles^3 \n\n %12.5g mm^3 \n %12.5g cm^3 \n %12.5g m^3 \n %12.5g km^3 \n\n %12.5g liters \n %12.5g gallons \n %12.5g quarts \n %12.5g pints',...
			     xin3,xft3,xmiles3,xmm3,xcm3,xm3,xkm3,xliter,xgallons,xquarts,xpints);	
		
set(handles.edit_results,'String',ss); 
%

function stiffness_plate(hObject, eventdata, handles)

 xNm = 0.;
 xftlbf = 0.;
 xinlbf= 0.;
 xlbmin2_per_sec2=0.;

    if( handles.nChoiceUnits == 1 )
	
			 xNm=handles.value;
    end
    if( handles.nChoiceUnits == 2 )
	
			 xNm=handles.value*handles.n_per_lbf*handles.meters_per_foot;
    end
    if( handles.nChoiceUnits == 3 )
	
			 xNm=handles.value*handles.n_per_lbf*handles.meters_per_inch;
    end	 
    if( handles.nChoiceUnits == 4 )
	
			 xNm=handles.value*handles.n_per_lbf*handles.meters_per_inch/386.; 
    end	 

      
	xftlbf = xNm/(handles.n_per_lbf*handles.meters_per_foot);
    xinlbf = xNm/(handles.n_per_lbf*handles.meters_per_inch);


	xlbmin2_per_sec2=xinlbf*386.;

	if( handles.nChoiceUnits == 2 )
	
			 xftlbf=handles.value;
    end
    if( handles.nChoiceUnits == 3 )
	
			 xinlbf=handles.value;
    end	 
    if( handles.nChoiceUnits == 4 )
	
			 xlbmin2_per_sec2=handles.value;
    end	 

 
ss=sprintf('%12.5g N m\n %12.5g lbf ft\n %12.5g lbf in \n\n %12.5g lbm in^2/sec^2 ',...
                                      xNm,xftlbf,xinlbf,xlbmin2_per_sec2); 
                                  
set(handles.edit_results,'String',ss);                                   
%

function stiffness_translational(hObject, eventdata, handles)

xNperm=0.;       %  1
xNpermm=0.;      %  2
xlbfperft=0.;    %  3
xlbfperin=0.;    %  4

         if( handles.nChoiceUnits == 1 )
			 xNperm=handles.value;
         end
         if( handles.nChoiceUnits == 2 )
			 xNperm=handles.value*1000;
         end
         if( handles.nChoiceUnits == 3 )
			 xNperm=handles.value*handles.feet_per_meter*handles.n_per_lbf;
         end
         if( handles.nChoiceUnits == 4 )
			 xNperm=handles.value*handles.inches_per_meter*handles.n_per_lbf;		
         end

	     xNpermm=xNperm/1000.;
	     xlbfperft=xNperm/(handles.feet_per_meter*handles.n_per_lbf);
	     xlbfperin=xNperm/(handles.inches_per_meter*handles.n_per_lbf);

         if( handles.nChoiceUnits == 2 )
			 xNpermm=handles.value;
         end
         if( handles.nChoiceUnits == 3 )
			 xlbfperft=handles.value;
			 xlbfperin=xlbfperft/12.;
         end
         if( handles.nChoiceUnits == 4 )
			 xlbfperin=handles.value;
			 xlbfperft=xlbfperin*12.;
         end

ss=sprintf('%12.5g N/m \n %12.5g N/mm \n\n %12.5g lbf/ft \n %12.5g lbf/in  ',...
                                    xNperm, xNpermm, xlbfperft, xlbfperin); 

set(handles.edit_results,'String',ss); 
%

function stiffness_rotational(hObject, eventdata, handles)

    xNmperrad = 0.;
    xftlbfperrad = 0.;
    xinlbfperrad = 0.;
    xNmperdeg = 0.;
    xftlbfperdeg = 0.;
    xinlbfperdeg = 0.;

    if( handles.nChoiceUnits == 1 )
			 xNmperrad=handles.value;
    end
    if( handles.nChoiceUnits == 2 )
			 xNmperrad=handles.value*handles.n_per_lbf*handles.meters_per_foot;
    end
    if( handles.nChoiceUnits == 3 )
			 xNmperrad=handles.value*handles.n_per_lbf*handles.meters_per_inch;
    end	 
    if( handles.nChoiceUnits == 4 )
			 xNmperrad=handles.value*deg_per_rad;		
    end
	if( handles.nChoiceUnits == 5 )
			 xNmperrad=handles.value*handles.n_per_lbf*handles.meters_per_foot*handles.deg_per_rad;
    end	 
    if( handles.nChoiceUnits == 6 )
			 xNmperrad=handles.value*handles.n_per_lbf*handles.meters_per_inch*handles.deg_per_rad;	
    end

	xftlbfperrad = xNmperrad/(handles.n_per_lbf*handles.meters_per_foot);
    xinlbfperrad = xNmperrad/(handles.n_per_lbf*handles.meters_per_inch);
    xNmperdeg    = xNmperrad/(handles.deg_per_rad);
    xftlbfperdeg = xNmperrad/(handles.n_per_lbf*handles.meters_per_foot*handles.deg_per_rad);
    xinlbfperdeg = xNmperrad/(handles.n_per_lbf*handles.meters_per_inch*handles.deg_per_rad);

	if( handles.nChoiceUnits == 2 )
			 xftlbfperrad=handles.value;
    end
    if( handles.nChoiceUnits == 3 )
			 xinlbfperrad=handles.value;
    end	 
    if( handles.nChoiceUnits == 4 )
			 xNmperdeg=handles.value;	
	end
	if( handles.nChoiceUnits == 5 )
			 xftlbfperdeg=handles.value;
    end	 
    if( handles.nChoiceUnits == 6 )	
			 xinlbfperdeg=handles.value;
    end

ss=sprintf('%12.5g N m/rad\n %12.5g ft lbf/rad\n %12.5g in lbf/rad\n\n %12.5g N m/deg\n %12.5g ft lbf/deg\n %12.5g in lbf/deg',...
    xNmperrad,xftlbfperrad,xinlbfperrad,xNmperdeg,xftlbfperdeg,xinlbfperdeg); 

set(handles.edit_results,'String',ss); 

set(handles.edit_results,'String',ss); 
%

function wavenumber(hObject, eventdata, handles)

xradpermeter=0.;  % 0 
xradperft=0.;     % 1
xradperinch=0;    % 2


	if( handles.nChoiceUnits == 1 )
		xradpermeter=handles.value;
    end

    if( handles.nChoiceUnits == 2 )
		xradpermeter=handles.value*handles.feet_per_meter;
    end
    if( handles.nChoiceUnits == 3 )	
		xradpermeter=handles.value*handles.inches_per_meter;
    end

	xradperft=xradpermeter*handles.meters_per_foot; 
	xradperinch=xradperft/12.;

    if( handles.nChoiceUnits == 2 )
		xradperft=handles.value;
		xradperinch=xradperft/12.;
    end
    if( handles.nChoiceUnits == 3 )
		xradperinch=handles.value;
    end


ss=sprintf(' %12.5g rad/m \n\n %12.5g rad/ft \n %12.5g rad/inch',xradpermeter,xradperft,xradperinch);   

set(handles.edit_results,'String',ss); 
%

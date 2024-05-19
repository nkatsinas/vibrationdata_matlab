function varargout = vibrationdata_aircraft_fuselage_psd(varargin)
% VIBRATIONDATA_AIRCRAFT_FUSELAGE_PSD MATLAB code for vibrationdata_aircraft_fuselage_psd.fig
%      VIBRATIONDATA_AIRCRAFT_FUSELAGE_PSD, by itself, creates a new VIBRATIONDATA_AIRCRAFT_FUSELAGE_PSD or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_AIRCRAFT_FUSELAGE_PSD returns the handle to a new VIBRATIONDATA_AIRCRAFT_FUSELAGE_PSD or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_AIRCRAFT_FUSELAGE_PSD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_AIRCRAFT_FUSELAGE_PSD.M with the given input arguments.
%
%      VIBRATIONDATA_AIRCRAFT_FUSELAGE_PSD('Property','Value',...) creates a new VIBRATIONDATA_AIRCRAFT_FUSELAGE_PSD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_aircraft_fuselage_psd_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_aircraft_fuselage_psd_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_aircraft_fuselage_psd

% Last Modified by GUIDE v2.5 01-Nov-2014 13:25:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_aircraft_fuselage_psd_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_aircraft_fuselage_psd_OutputFcn, ...
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


% --- Executes just before vibrationdata_aircraft_fuselage_psd is made visible.
function vibrationdata_aircraft_fuselage_psd_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_aircraft_fuselage_psd (see VARARGIN)

% Choose default command line output for vibrationdata_aircraft_fuselage_psd
handles.output = hObject;

listbox_pressure_unit_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_aircraft_fuselage_psd wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_aircraft_fuselage_psd_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_aircraft_fuselage_psd);


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n_unit=get(handles.listbox_pressure_unit,'Value');

n_loc=get(handles.listbox_location,'Value');


try
    h=str2num(get(handles.edit_altitude,'String'));
    alt_orig=h;    
catch
    msgbox('Enter altitude');
    return;
end


    
try
    M=str2num(get(handles.edit_Mach,'String'));    
catch
    msgbox('Enter Mach number');
    return;    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(n_unit==1)  % psi, ft
   hkm=h*0.0003048;
else           % Pa, m  
   hkm=h/1000; 
end

if(hkm>20)
    if(n_unit==1)
        warndlg('altitude is too high, max=65000 ft');
    else
        warndlg('altitude is too high, max=20 km');        
    end
    return;
end    

at=[0	1.226;
1	1.112;
2	1.007;
3	0.9096;
4	0.8195;
5	0.7365;
6	0.66;
7	0.5898;
8	0.5254;
9	0.4666;
10	0.4129;
11	0.3641;
12	0.3104;
13	0.2652;
14	0.2266;
15	0.1936;
16	0.1654;
17	0.1413;
18	0.1207;
19	0.1032;
20	0.0881];


sz=size(at);

rho=0;

for i=1:(sz(1)-1)
    if(hkm>=at(i,1) && hkm<=at(i+1,1))
%
        c2=((hkm-at(i,1)))/( at(i+1,1)-at(i,1) );
        c1=1-c2;  
        rho=c1*at(i,2) + c2*at(i+1,2);
        break;
%        
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


mt=[0	340.2;
1	336.3;
2	332.4;
3	328.5;
4	324.5;
5	320.4;
6	316.3;
7	312.1;
8	307.9;
9	303.7;
10	299.3;
11	295;
12	295;
13	295;
14	295;
15	295;
16	295;
17	295;
18	295;
19	295;
20	295];

c=0;

for i=1:(sz(1)-1)
    if(hkm>=mt(i,1) && hkm<=mt(i+1,1))
%
        c2=((hkm-mt(i,1)))/( mt(i+1,1)-mt(i,1) );
        c1=1-c2;  
        c=c1*mt(i,2) + c2*mt(i+1,2);
        break;
%        
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

U=M*c;

q=0.5*rho*U^2;

Prms=0.006*q/(1+0.14*M^2);


M_ref=0.78;
c_ref=309.496;
rho_ref=0.55;

U_ref=M_ref*c_ref;

q_ref=0.5*rho_ref*U_ref^2;

Prms_ref=0.006*q_ref/(1+0.14*M_ref^2);

scale=(Prms/Prms_ref);

out1=sprintf(' q=%8.4g  rho=%8.4g   U=%8.4g  scale=%8.4g ',q,rho,U,scale);
disp(out1);


if(c<=1.0e-20)
    hkm
    c
    warndlg('c error');
    return;
end

if(U<=1.0e-20)
    U
    warndlg('U error');
    return;
end

if(rho<=1.0e-20)
    rho
    warndlg('rho error');
    return;
end

if(q<=1.0e-20)
    q
    warndlg('q error');
    return;
end


if(scale<=1.0e-20)
    Prms
    Prms_ref
    warndlg('Pressure error');
    return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(n_loc==1) % fwd
    psd_ref=[   10      1.77E+00;
                11.1	1.77E+00;
                12.5    1.77E+00;
                14.14	1.77E+00;
                16.0    1.77E+00;
                17.9	1.76E+00;    
                20      1.77E+00;
                22.4	1.77E+00;
                25      1.77E+00;
                28.1	1.77E+00;
                31.5	1.77E+00;
                35.5	1.77E+00;
                40      1.77E+00;
                44.7	1.77E+00;
                50      1.77E+00;
                56.1	1.77E+00;
                63      1.77E+00;
                71      1.77E+00;
                80      1.77E+00;
                89.4	1.77E+00;
                100     1.77E+00;
                111.8	1.77E+00;
                125     1.77E+00;
                141.4	1.77E+00;
                160     1.77E+00;
                178.9	1.76E+00;
                200     1.75E+00;
                223.6	1.74E+00;
                250     1.73E+00;
                280.6	1.73E+00;
                315     1.72E+00;
                355     1.71E+00;
                400     1.70E+00;
                447.2	1.69E+00;
                500     1.68E+00;
                561.3	1.66E+00;
                630     1.60E+00;
                709.9	1.55E+00;
                800     1.50E+00;
                894.4	1.45E+00;
                1000	1.36E+00;
                1118	1.26E+00;
                1250	1.17E+00;
                1414.2	1.06E+00;
                1600	9.65E-01;
                1788.9	8.81E-01;
                2000	7.88E-01;
                2236.1	6.94E-01;
                2500	6.09E-01;
                2806.2	5.35E-01;
                3150	4.70E-01;
                3549.7	4.13E-01;
                4000	3.65E-01;
                4472.1	3.20E-01;
                5000	2.78E-01];
else         % aft 
    psd_ref=[   10.00	3.77;
                11.10	3.86;
                12.50	3.97;
                14.10	4.08;
                16.00	4.19;
                17.90	4.29;
                20.00	4.39;
                22.40	4.50;
                25.00	4.60;
                28.10	4.70;
                31.50	4.81;
                35.50	4.92;
                40.00	5.02;
                44.70	5.12;
                50.00	5.22;
                56.10	5.33;        
                63      5.43E+00;
                71      5.53E+00;
                80      5.63E+00;
                89.4	5.74E+00;
                100     5.82E+00;
                111.8	5.76E+00;
                125     5.65E+00;
                141.4	5.53E+00;
                160     5.42E+00;
                178.9	5.28E+00;
                200     5.10E+00;
                223.6	4.94E+00;
                250     4.75E+00;
                280.6	4.51E+00;
                315     4.28E+00;
                355     4.05E+00;
                400     3.84E+00;
                447.2	3.58E+00;
                500     3.33E+00;
                561.3	3.09E+00;
                630     2.85E+00;
                709.9	2.54E+00;
                800     2.27E+00;
                894.4	2.04E+00;
                1000	1.83E+00;
                1118	1.65E+00;
                1250	1.47E+00;
                1414.2	1.29E+00;
                1600	1.12E+00;
                1788.9	9.66E-01;
                2000	8.34E-01;
                2236.1	7.21E-01;
                2500	6.21E-01;
                2806.2	5.38E-01;
                3150	4.66E-01;
                3549.7	3.96E-01;
                4000	3.37E-01;
                4472.1	2.88E-01;
                5000	2.46E-01];
end    


sz=size(psd_ref);

pressure_psd=zeros(sz(1),sz(2));
pressure_psd(:,1)=psd_ref(:,1);

pressure_psd(:,2)=psd_ref(:,2)*scale^2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

octbw=( (2^(1/6)) - 1/((2^(1/6)))  );

spl=zeros(sz(1),sz(2));
spl(:,1)=psd_ref(:,1);

oaspl=0;

ref=20e-06;

for i=1:sz(1);
    Pa_rms2=octbw*pressure_psd(i,1)*pressure_psd(i,2);
    Pa_rms=sqrt(Pa_rms2);
    spl(i,2)=20*log10(Pa_rms/ref);
    
    oaspl=oaspl+Pa_rms2;
end

oaspl=20*log10(sqrt(oaspl)/ref);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(n_unit==1) % convert from Pa^2/Hz to psi^2/Hz
%    
    pressure_psd(:,2)=pressure_psd(:,2)*(0.000145037738)^2;  
%
end    
    
[~,oa_rms] = calculate_PSD_slopes(pressure_psd(:,1),pressure_psd(:,2));




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1);
%
plot(pressure_psd(:,1),pressure_psd(:,2));
%
if(n_unit==1)
    if(n_loc==1)
        ts=sprintf('Pressure PSD   Overall %8.4g psi rms  \n Fwd Mach=%g Altitude=%g ft',oa_rms,M,alt_orig);        
    else
        ts=sprintf('Pressure PSD   Overall %8.4g psi rms  \n Aft Mach=%g Altitude=%g ft',oa_rms,M,alt_orig);        
    end
    ylabel('Pressure (psi^2/Hz)');
else
    if(n_loc==1)
        ts=sprintf('Pressure PSD   Overall %8.4g Pa rms  \n Fwd Mach=%g Altitude=%g m',oa_rms,M,alt_orig);        
    else
        ts=sprintf('Pressure PSD   Overall %8.4g Pa rms  \n Aft Mach=%g Altitude=%g m',oa_rms,M,alt_orig);        
    end    
    ylabel('Pressure (Pa^2/Hz)');    
end
title(ts);
%
xlabel('Frequency (Hz)');

set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');

ymax= 10^ceil(log10(max(pressure_psd(:,2))));
ymin= 10^floor(log10(min(pressure_psd(:,2))));

ylim([ymin,ymax]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(2);
%
plot(spl(:,1),spl(:,2));
ylabel('SPL (dB)');
xlabel('Center Frequency (Hz)');

set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','lin','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
%
ts=sprintf('One-Third Octave SPL \n oaspl=%6.3g dB ref 20 microPa',oaspl);
title(ts);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try

    output_name=get(handles.edit_output_array,'String');
    assignin('base', output_name, pressure_psd);
catch
    msgbox('Enter output array name');    
    return;
end    

h = msgbox('Save Complete');

function edit_output_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Mach_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Mach (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Mach as text
%        str2double(get(hObject,'String')) returns contents of edit_Mach as a double


% --- Executes during object creation, after setting all properties.
function edit_Mach_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Mach (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_altitude_Callback(hObject, eventdata, handles)
% hObject    handle to edit_altitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_altitude as text
%        str2double(get(hObject,'String')) returns contents of edit_altitude as a double


% --- Executes during object creation, after setting all properties.
function edit_altitude_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_altitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_location.
function listbox_location_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_location contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_location


% --- Executes during object creation, after setting all properties.
function listbox_location_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_pressure_unit.
function listbox_pressure_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_pressure_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_pressure_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_pressure_unit

n=get(handles.listbox_pressure_unit,'Value');

if(n==1)
    set(handles.text_altitude,'String','ft');
else
    set(handles.text_altitude,'String','m');    
end



% --- Executes during object creation, after setting all properties.
function listbox_pressure_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_pressure_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function varargout = MM_shock_distance(varargin)
% MM_SHOCK_DISTANCE MATLAB code for MM_shock_distance.fig
%      MM_SHOCK_DISTANCE, by itself, creates a new MM_SHOCK_DISTANCE or raises the existing
%      singleton*.
%
%      H = MM_SHOCK_DISTANCE returns the handle to a new MM_SHOCK_DISTANCE or the handle to
%      the existing singleton*.
%
%      MM_SHOCK_DISTANCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MM_SHOCK_DISTANCE.M with the given input arguments.
%
%      MM_SHOCK_DISTANCE('Property','Value',...) creates a new MM_SHOCK_DISTANCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MM_shock_distance_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MM_shock_distance_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MM_shock_distance

% Last Modified by GUIDE v2.5 24-Nov-2015 17:27:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MM_shock_distance_OpeningFcn, ...
                   'gui_OutputFcn',  @MM_shock_distance_OutputFcn, ...
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


% --- Executes just before MM_shock_distance is made visible.
function MM_shock_distance_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MM_shock_distance (see VARARGIN)

% Choose default command line output for MM_shock_distance
handles.output = hObject;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MM_shock_distance wait for user response (see UIRESUME)
% uiwait(handles.figure1);






% --- Outputs from this function are returned to the command line.
function varargout = MM_shock_distance_OutputFcn(hObject, eventdata, handles) 
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

delete(MM_shock_distance);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_type,'Value');

iu=get(handles.listbox_units,'Value');

x=str2num(get(handles.edit_x,'String'));

disp(' ');
disp(' * * * * ');
disp(' ');
disp(' Distance from Source ');

if(iu==1)
    out1=sprintf(' x=%8.4g in ',x);
else    
    out1=sprintf(' x=%8.4g cm ',x);    
    x=x/2.54;
end
disp(out1);

if(x<6)
   warndlg('Distance is too close to source. Minimum=6 inch');
   return; 
end  
if(x>110)
   warndlg('Distance is too far from source. Maximum=110 inch');
   return; 
end   

if(x>100)
   x=100;
end 

x2=x^2;
x3=x^3;
x4=x^4;
x5=x^5;
x6=x^6;


disp(' ');

if(n==1)  % cylindrical shell
   disp(' Cylindrical Shell '); 

    
   	q=[5.93391	101.923;
	9.72384	86.1693;
	14.9656	71.9115;
	20.3187	59.6266;
	26.4529	48.491;
	33.0337	39.1805;
	39.9511	32.4844;
	48.6548	26.2443;
	55.5736	22.3277;
	63.1641	19.4914;
	71.6474	16.6885;
	80.9136	14.4736;
	88.9524	12.9649;
	95.4284	11.918;
	102.128	11.0978;
	108.83	10.5359;
	119.664	9.93589];

    [p,S,mu] = polyfit(q(:,1),q(:,2),5);
    y = polyval(p,x,S,mu);
    
end
if(n==2)  % longeron
   disp(' Longeron or Stringer ');     

    q=[6.41215	101.187;
	13.3584	87.906;
	21.4248	73.7439;
	28.9894	64.4953;
	35.019	57.6197;
	39.8237	52.9432;
	43.5101	50.7268;
	48.4234	47.585;
	53.8543	45.2514;
	60.7293	43.9123;
	70.0738	42.6695;
	80.2381	41.648;
	89.8809	40.5101;
	100.355	39.3179;
	110.109	38.381;
	120.17	37.4624];

   
    [p,S,mu] = polyfit(q(:,1),q(:,2),6);
    y = polyval(p,x,S,mu);   
end
if(n==3)  % skin/ring frame
    disp(' Skin/Ring Frame ');     
   
	q=[5.09144	101.448;
	8.42118	81.8503;
	13.6251	61.8944;
	18.931	48.3592;
	25.3293	38.0428;
	32.168	29.5423;
	37.6752	24.9654;
	43.7337	20.6912;
	50.1144	17.6043;
	56.5972	15.4756;
	63.7393	13.4302;
	71.9795	11.4324;
	78.2407	10.1815;
	85.5971	9.0112;
	93.1737	7.92395;
	100.201	7.05845;
	110.3	6.01149;
	120.07	5.15292];
    
    
    [p,S,mu] = polyfit(q(:,1),q(:,2),6);
    y = polyval(p,x,S,mu);
end
if(n==4)  % primary truss
   disp(' Primary Truss ');    
   
    q=[	5.77905	99.9214;
	12.2137	82.6752;
	20.1817	66.2036;
	26.3111	55.8586;
	32.8475	45.9173;
	39.4871	37.9911;
	46.9435	30.6225;
	52.4588	26.0081;
	56.7502	23.2726;
	62.269	20.4191;
	67.7913	18.5077;
	72.7002	16.9962;
	78.5312	15.6063;
	84.5658	14.1445;
	90.0881	12.8204;
	100.112	10.8822];

   
    [p,S,mu] = polyfit(q(:,1),q(:,2),6);
    y = polyval(p,x,S,mu);   
end
if(n==5)  % complex airframe
   disp(' Complex Airframe ');    

   	q=[5.03518	99.9722;
	18.4084	56.169;
	31.0397	33.2554;
	42.8214	20.2123;
	51.8435	13.8225;
	62.7766	8.79528;
	72.1161	5.8211;
	80.0765	4.14047;
	88.0379	3.00343;
	93.3444	2.37243;
	103.004	1.60126];

   
    [p,S,mu] = polyfit(q(:,1),q(:,2),6);
    y = polyval(p,x,S,mu);    
end
if(n==6)  % complex equipment structure
   disp(' Complex Equipment Structure ');     
   
   q=[	5.07011	101.878;
	8.51195	88.3615;
	12.174	79.2522;
	15.8286	69.1962;
	20.4288	59.5902;
	24.4017	52.3743;
	28.5819	45.4143;
	33.1766	38.3289;
	37.6713	33.0092;
	42.4788	28.0452;
	47.1789	23.6688;
	51.8791	19.9754;
	58.2613	16.5124;
	63.276	13.8409;
	67.6615	11.7611;
	72.5745	9.99206;
	78.2165	8.20649;
	83.0221	6.92565;
	88.2459	5.76585;
	92.4279	5.03335;
	98.2791	4.10591;
	100.372	3.86211];

   
    [p,S,mu] = polyfit(q(:,1),q(:,2),6);
    y = polyval(p,x,S,mu);    
end
if(n==7)  % honeycomb
    disp(' Honeycomb ');
    
    q=[	4.89935	100.562;
	13.0992	93.393;
	19.1683	87.9216;
	24.8142	84.4237;
	32.2675	78.4181;
	38.0201	75.2965;
	46.4333	69.9255;
	54.3144	65.3725;
	60.4913	61.9463;
	66.6682	58.6997;
	74.016	54.8841;
	82.2171	51.307;
	90.3079	47.0293;
	97.3405	45.1446;
	105.011	42.7646;
	111.72	40.2536;
	120.237	36.8941];

    
    [p,S,mu] = polyfit(q(:,1),q(:,2),4);
    y = polyval(p,x,S,mu); 
end
if(n==8)  % constant velocity line
    disp('  Constant velocity line ');       
    
    q=[	6.04684	99.1182;
	9.32304	85.5445;
	14.0714	72.8733;
	19.2719	61.0125;
	24.0206	52.2005;
	29.1105	45.4406;
	34.8802	39.5551;
	40.649	33.9877;
	48.4592	29.9701;
	55.1369	26.6582;
	60.9101	24.4426;
	69.0628	22.4091;
	77.3292	20.6339;
	88.3149	18.9153;
	97.941	17.416;
	106.21	16.7456;
	115.952	15.9615;
	120.031	15.7532];

    
    [p,S,mu] = polyfit(q(:,1),q(:,2),5);
    y = polyval(p,x,S,mu);     
end



    att=y;

    disp(' ');

    out1=sprintf(' Remaining = %8.4g percent',att); 
    disp(out1);

    out1=sprintf('     Ratio = %8.4g',att/100); 
    disp(out1);

    msgbox('Remaining percent written to Command Window');




% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type











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


iu=get(handles.listbox_units,'Value');

if(iu==1)
    set(handles.text_distance_unit,'String','in');
else
    set(handles.text_distance_unit,'String','cm');      
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



function edit_x_Callback(hObject, eventdata, handles)
% hObject    handle to edit_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_x as text
%        str2double(get(hObject,'String')) returns contents of edit_x as a double


% --- Executes during object creation, after setting all properties.
function edit_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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



function edit_damping_Callback(hObject, eventdata, handles)
% hObject    handle to edit_damping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_damping as text
%        str2double(get(hObject,'String')) returns contents of edit_damping as a double


% --- Executes during object creation, after setting all properties.
function edit_damping_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_damping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_wt_Callback(hObject, eventdata, handles)
% hObject    handle to edit_wt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_wt as text
%        str2double(get(hObject,'String')) returns contents of edit_wt as a double


% --- Executes during object creation, after setting all properties.
function edit_wt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_wt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_save.
function listbox_save_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_save contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_save


% --- Executes during object creation, after setting all properties.
function listbox_save_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_output_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_save,'Value');

if(n==1)
   data=getappdata(0,'Ain');
end
if(n==2)
   data=getappdata(0,'srs_in');
end
if(n==3)
   data=getappdata(0,'Atr'); 
end
if(n==4)
   data=getappdata(0,'srs_tr'); 
end
if(n==5)
   data=getappdata(0,'new_wavelet_table');  
end

output_name=get(handles.edit_output_array_name,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 


% --- Executes on key press with focus on edit_damping and none of its controls.
function edit_damping_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_damping (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on key press with focus on edit_x and none of its controls.
function edit_x_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_x (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on key press with focus on edit_elastic_modulus and none of its controls.
function edit_elastic_modulus_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_elastic_modulus (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on key press with focus on edit_mass_density and none of its controls.
function edit_mass_density_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass_density (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on key press with focus on edit_width and none of its controls.
function edit_width_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_width (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_thickness and none of its controls.
function edit_thickness_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on key press with focus on edit_wt and none of its controls.
function edit_wt_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_wt (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

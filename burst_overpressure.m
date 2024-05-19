function varargout = burst_overpressure(varargin)
% BURST_OVERPRESSURE MATLAB code for burst_overpressure.fig
%      BURST_OVERPRESSURE, by itself, creates a new BURST_OVERPRESSURE or raises the existing
%      singleton*.
%
%      H = BURST_OVERPRESSURE returns the handle to a new BURST_OVERPRESSURE or the handle to
%      the existing singleton*.
%
%      BURST_OVERPRESSURE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BURST_OVERPRESSURE.M with the given input arguments.
%
%      BURST_OVERPRESSURE('Property','Value',...) creates a new BURST_OVERPRESSURE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before burst_overpressure_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to burst_overpressure_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help burst_overpressure

% Last Modified by GUIDE v2.5 06-Oct-2014 12:25:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @burst_overpressure_OpeningFcn, ...
                   'gui_OutputFcn',  @burst_overpressure_OutputFcn, ...
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


% --- Executes just before burst_overpressure is made visible.
function burst_overpressure_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to burst_overpressure (see VARARGIN)

% Choose default command line output for burst_overpressure
handles.output = hObject;

listbox_units_Callback(hObject, eventdata, handles);
listbox_gas_Callback(hObject, eventdata, handles);

listbox_analysis_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes burst_overpressure wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = burst_overpressure_OutputFcn(hObject, eventdata, handles) 
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

iu=get(handles.listbox_units,'Value');

i_analysis=get(handles.listbox_analysis,'Value');

vol_unit=get(handles.listbox_volume,'Value');
p_unit=get(handles.listbox_pressure,'Value');



if(i_analysis<=2)
    
    V1=str2num(get(handles.edit_volume,'String'));

end



if(i_analysis==1)
    
    k=str2num(get(handles.edit_hcr,'String'));
       
    P1=str2num(get(handles.edit_p1,'String'));
    P0=str2num(get(handles.edit_p0,'String'));
    
    if(P0>P1)
        warndlg('P0>P1');
        return;
    end   
    
    if(iu==1) % English
        
        if(vol_unit==1)  % in^3
            V1=V1/(12^3);
        else   %  ft^3
              
        end
        
        if(p_unit==1)
            P1=P1*144;
            P0=P0*144;
        end    
        
%       pressure unit is psi
        
    else % metric
        
        if(vol_unit==1)  % cm^3
              V1=V1/100^3;
        else   %  liters^3
              V1=V1*0.001;
        end      
        
        if(p_unit==3)  % bar
            
              P1=P1*100000;
              P0=P0*100000;
              
        else   % KPa
            
              P1=P1*1000;
              P0=P0*1000;
              
        end            
        
    end    
    
    
    A=P1*V1/(k-1);
    B=(P0/P1);
    C=(k-1)/k;
    
    W_brode=(P1-P0)*V1/(k-1);
    
    W_baker=A*(1-B^C);  %
    
    disp(' ');
    disp(' Compressed Gas Energy, Brode ');
    disp('  ');
    
    
    if(iu==1)
         out1=sprintf(' = %8.4g lbf-ft ',W_brode);
         out2=sprintf(' = %8.4g lbm TNT ',W_brode/1.5E+06); 
         out3=sprintf(' = %8.4g sticks of dynamite',W_brode*1.3558/1.0e+06');         
    else
         out1=sprintf(' = %8.4g J',W_brode);  
         out2=sprintf(' = %8.4g kg TNT ',W_brode/4.184E+06);   
         out3=sprintf(' = %8.4g sticks of dynamite',W_brode/1.0e+06');
    end  
    disp(out1);    
    disp(out2);  
    disp(out3);
    


    disp(' ');
    disp(' Compressed Gas Energy, Baker ');
    disp('  ');
    
    if(iu==1)
         out1=sprintf(' = %8.4g lbf-ft ',W_baker);
         out2=sprintf(' = %8.4g lbm TNT ',W_baker/1.5E+06);
         out3=sprintf(' =  %8.4g sticks of dynamite',W_baker*1.3558/1.0e+06');          
    else
         out1=sprintf(' = %8.4g J',W_baker);     
         out2=sprintf(' = %8.4g kg TNT ',W_baker/4.184E+06);    
         out3=sprintf(' =  %8.4g sticks of dynamite',W_baker/1.0e+06');         
    end  
    disp(out1);    
    disp(out2); 
    disp(out3);    
    disp(' ');
    disp(' Dynamite Reference: 1 stick is 0.19 kg, 75% nitroglycerin ');
    
end

if(i_analysis>=2)
    
    m=str2num(get(handles.edit_mass,'String'));
    
    if(iu==1) % English
        
        m=m*2.20462262;     
        
    end     
    
end


if(i_analysis==2)
    
    if(iu==1) % English
        
        if(vol_unit==1)  % in^3
            V1=V1/(12^3);
        else   %  ft^3
              
        end
       
        V1=V1*0.0283168;
        
    else % metric
        
        if(vol_unit==1)  % cm^3
              V1=V1/100^3;
        else   %  liters^3
              V1=V1*0.001;
        end      
                    
        
    end     
    
    K=22.5;
    a=0.72;
    
    p=K*(m/V1)^a;  % bar
  
    disp(' ');    
    disp(' Pressure, Weibull ');
    
    out1=sprintf(' = %8.4g bar ',p);
    
    if(iu==1)
        out2=sprintf(' = %8.4g psi ',p*14.5037738);
    else
        out2=sprintf(' = %8.4g KPa ',p*100);        
    end
    
    disp(out1);
    disp(out2);
    
end

if(i_analysis>=3)
    
    r=str2num(get(handles.edit_radius,'String'));
    
    if(iu==1) % English
    
        r=r*0.3048;
        
    end
    
    A=m^(1/3)/r;
    B=m^(2/3)/r^2;    
    C=m/r^3;      
    
    if(i_analysis==3)  % open air
        
        delta_p = 0.84*A + 2.7*B + 7.0*C;
        
    end
    if(i_analysis==4)  % ground

        delta_p = 0.95*A + 3.9*B + 13.0*C;        
        
    end
    
    disp(' ');
    disp(' Overpessure, Sadovsky ');
    
    if(iu==1)
        out1=sprintf(' %8.4g atm ',delta_p);
        out2=sprintf(' %8.4g psi ',delta_p*14.7);
    else
        out1=sprintf(' %8.4g atm ',delta_p);
        out2=sprintf(' %8.4g bar ',delta_p*1.01325);
        out3=sprintf(' %8.4g KPa ',delta_p*101.325);        
    end
    
    disp(out1);
    disp(out2);    
    
    if(iu==2)
        disp(out3);            
    end
    
    tau=1.3*(m^(1/6))*(r^(1/2))/1000;
    
    disp(' ');
    disp(' Positive Shock Phase Duration');
    out4=sprintf('  %8.4g sec',tau);
    out5=sprintf('  %8.4g msec',tau*1000);    
    disp(out4);
    disp(out5);    
    
    disp(' ');
    disp(' Velocity of Shock Front');
    
    M=sqrt(1+0.86*delta_p);
    D=340*M;
    
    if(iu==1)
        out6=sprintf(' %8.4g ft/sec ',D*3.28084);
    else
        out6=sprintf(' %8.4g m/sec ',D);
    end
    
    out7=sprintf('\n  Mach %4.2f (sea level)',M);
    
    disp(out6);
    disp(out7);
end    


msgbox('Result written to Command Window');



% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units

iu=get(handles.listbox_units,'Value');



set(handles.listbox_volume,'String',' ','Value',1);
set(handles.listbox_pressure,'String',' ','Value',1);

if(iu==1)
    ss{1}='in^3';
    ss{2}='ft^3';
    
    pp{1}='psi';
    
    set(handles.text_mass,'String','lbm');
    set(handles.text_radius,'String','ft');
else
    ss{1}='cm^3';
    ss{2}='liters';
    
    pp{1}='bar';
    pp{2}='KPa';
    
    set(handles.text_mass,'String','kg');
    set(handles.text_radius,'String','m');    
end

set(handles.listbox_volume,'String',ss);
set(handles.listbox_pressure,'String',pp);


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


% --- Executes on selection change in listbox_analysis.
function listbox_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis

n=get(handles.listbox_analysis,'Value');

set(handles.uipanel_mass,'Visible','off');   
set(handles.uipanel_pressure,'Visible','off'); 
set(handles.uipanel_radius,'Visible','off'); 
set(handles.uipanel_gas,'Visible','off');
set(handles.uipanel_volume,'Visible','off');
    
if(n==1)
    set(handles.uipanel_pressure,'Visible','on');
    set(handles.uipanel_gas,'Visible','on');
end
if(n<=2)
    set(handles.uipanel_volume,'Visible','on');    
end
if(n>=2)
    set(handles.uipanel_mass,'Visible','on');      
end
if(n>=3)
    set(handles.uipanel_radius,'Visible','on');   

end



% --- Executes during object creation, after setting all properties.
function listbox_analysis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_gas.
function listbox_gas_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_gas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_gas contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_gas

n=get(handles.listbox_gas,'Value');

if(n==1) % air
    k=1.67;
end
if(n==2) % dry air
    k=1.40;    
end
if(n==3) % hydrogen
    k=1.41;    
end
if(n==4) % nitrogen
    k=1.40;    
end
if(n==5) % steam
    k=1.32;    
end

if(n<=5)
    ss=sprintf('%g',k);
    set(handles.edit_hcr,'String',ss);
else   
    set(handles.edit_hcr,'String',' ');    
end




% --- Executes during object creation, after setting all properties.
function listbox_gas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_gas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_hcr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hcr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hcr as text
%        str2double(get(hObject,'String')) returns contents of edit_hcr as a double


% --- Executes during object creation, after setting all properties.
function edit_hcr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hcr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on selection change in listbox_volume.
function listbox_volume_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_volume contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_volume


% --- Executes during object creation, after setting all properties.
function listbox_volume_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_p1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_p1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_p1 as text
%        str2double(get(hObject,'String')) returns contents of edit_p1 as a double


% --- Executes during object creation, after setting all properties.
function edit_p1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_p1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_pressure.
function listbox_pressure_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_pressure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_pressure contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_pressure


% --- Executes during object creation, after setting all properties.
function listbox_pressure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_pressure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_p0_Callback(hObject, eventdata, handles)
% hObject    handle to edit_p0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_p0 as text
%        str2double(get(hObject,'String')) returns contents of edit_p0 as a double


% --- Executes during object creation, after setting all properties.
function edit_p0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_p0 (see GCBO)
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


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



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

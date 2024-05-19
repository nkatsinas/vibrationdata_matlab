function varargout = Franken_method(varargin)
% FRANKEN_METHOD MATLAB code for Franken_method.fig
%      FRANKEN_METHOD, by itself, creates a new FRANKEN_METHOD or raises the existing
%      singleton*.
%
%      H = FRANKEN_METHOD returns the handle to a new FRANKEN_METHOD or the handle to
%      the existing singleton*.
%
%      FRANKEN_METHOD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FRANKEN_METHOD.M with the given input arguments.
%
%      FRANKEN_METHOD('Property','Value',...) creates a new FRANKEN_METHOD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Franken_method_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Franken_method_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Franken_method

% Last Modified by GUIDE v2.5 14-Jun-2018 08:35:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Franken_method_OpeningFcn, ...
                   'gui_OutputFcn',  @Franken_method_OutputFcn, ...
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


% --- Executes just before Franken_method is made visible.
function Franken_method_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Franken_method (see VARARGIN)

% Choose default command line output for Franken_method
handles.output = hObject;

change_materials_units(hObject, eventdata, handles);
clear_output(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Franken_method wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function clear_output(hObject, eventdata, handles)
%
set(handles.uipanel_ring_frequency,'Visible','off');
set(handles.uipanel_save,'Visible','off');


% --- Outputs from this function are returned to the command line.
function varargout = Franken_method_OutputFcn(hObject, eventdata, handles) 
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

delete(Franken_method);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * * ');
disp(' ');

iu=get(handles.listbox_units,'Value');
imat=get(handles.listbox_material,'Value');


fig_num=1;

FS=strtrim(get(handles.edit_input_array_name,'String'));
THM=evalin('base',FS); 

f=THM(:,1);
spl=THM(:,2);
ilast=length(spl);

dB=spl;
%

[oadb]=oaspl_function(dB);

%
out1=sprintf('\n  Overall SPL = %8.4g dB \n',oadb);
disp(out1)


n_type=1;
f=THM(:,1);
dB=THM(:,2);

[fig_num]=spl_plot(fig_num,n_type,f,dB);
  
   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

stationdiam=str2num(get(handles.edit_diameter,'String'));

if(iu==1)
    stationdiam=stationdiam/12.;  % convert inches to feet
else
    stationdiam=stationdiam*3.28;  % convert meters to feet    
end
stationdiam_ft=stationdiam;


if(imat<=4)

%
    E=str2num(get(handles.edit_E,'String'));
    W=str2num(get(handles.edit_W,'String'));
      
%

    if(iu==1)   % English
%    
        cmat = sqrt( (386*E/W) )/12;   % ft/sec
%
    else        % metric
%    
        cmat = sqrt(E/W)*3.28084;      % m/sec -> ft/sec
%     
    end

    if(iu==1) % English
        W=W*(12.^3);      % convert from lbm/in^3 to lbm/ft^3  
    end

   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    thickness=str2num(get(handles.edit_thickness,'String'));

    
    if(isempty(thickness) || thickness<1.0e-10)
       warndlg('Enter Thickness'); 
       return; 
    end
    
    
    if(iu==1)
        thickness=thickness/12.;    % convert from inch to feet
    else
        thickness=thickness/1000;   % convert from mm to meters    
    end

    
    W=W*thickness;

    
    if(iu==1)
    % W   lbm/ft^2
    else
        W=W*0.2048;  % convert from kg/m^2 to lbm/ft^2
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    W_lbm_per_ft2=W;
    cmat_ft_per_sec=cmat;


    [psd]=Franken_function(stationdiam_ft,W_lbm_per_ft2,cmat_ft_per_sec,f,spl);

    rf=cmat/(pi*stationdiam);

end
if(imat==5)
%
    rf=str2num(get(handles.edit_E,'String'));
    W=str2num(get(handles.edit_W,'String'));
    
    if(iu==1)
        
        nsmd=get(handles.listbox_smd,'Value');
        
        if(nsmd==2)
            W=W*144;     % convert from lbm/in^2 to lbm/ft^2            
        end
        
    else
        W=W*0.2048;  % convert from kg/m^2 to lbm/ft^2
    end
    W_lbm_per_ft2=W;

    [psd]=Franken_function_alt(stationdiam_ft,W_lbm_per_ft2,rf,f,spl);    
%
end    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    ra=0.;
    rb=0.;
%
    s=zeros((ilast-1),1);
%
    for i=1:(ilast-1)
%
        s(i)=log( psd(i+1)/psd(i) )/log( f(i+1)/f(i) );
%
        if(s(i) < -1.0001 ||  s(i) > -0.9999 )
%  
            racc= ( psd(i+1) * f(i+1)- psd(i)*f(i))/( s(i)+1.);
%
        else
%
            racc= psd(i)*f(i)*log( f(i+1)/f(i));
        end
        rb=rb+racc;
% 
        if(f(i) < 2050.)
            ra=rb;
        end
    end
%
    grms=sqrt(ra);
    grmsb=sqrt(rb);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

out1=sprintf('\n Ring Frequency = %12.4g Hz ',rf);
disp(out1)

ssr=sprintf('%8.4g',rf);
set(handles.edit_ring_frequency,'String',ssr);


%
disp(' ');
disp(' Overall Skin Levels ');
%
out1=sprintf('\n\n Acceleration (up to 2000 Hz) = %12.4g GRMS ',grms );
disp(out1)
%
out1=sprintf('\n Acceleration (up to 10,000 Hz) = %12.4g GRMS\n',grmsb );
disp(out1)
%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Wa=[f psd];

fmin=f(1);


t_string = sprintf(' Acceleration Power Spectral Density  %7.3g GRMS Overall',grms);
x_label='Frequency (Hz)';
y_label='Accel (G^2/Hz)';


fmax=2000;

% [fig_num,h]=plot_PSD_function(fig_num,x_label,y_label,t_string,Wa,fmin,fmax);

ppp=Wa;
md=6;

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


t_string = sprintf(' Acceleration Power Spectral Density  %7.3g GRMS Overall',grmsb);
x_label='Frequency (Hz)';
y_label='Accel (G^2/Hz)';

fmax=10000;

% [fig_num]=plot_PSD_function(fig_num,x_label,y_label,t_string,Wa,fmin,fmax);

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setappdata(0,'Wa',Wa);

if(imat<=4)
    set(handles.uipanel_ring_frequency,'Visible','on');
end


set(handles.uipanel_save,'Visible','on');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



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

data=getappdata(0,'Wa');

output_name=get(handles.edit_output_array_name,'String');
assignin('base', output_name, data);


output_filename1=sprintf('%s.txt',output_name);

save(output_filename1,'data','-ASCII')

out1=sprintf('\n Data also written to text file:  %s \n',output_filename1);
disp(out1);


h = msgbox('Save Complete'); 


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units
change_materials_units(hObject, eventdata, handles);



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



function edit_input_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
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
change_materials_units(hObject, eventdata, handles);


function change_materials_units(hObject, eventdata, handles)
%
clear_output(hObject, eventdata, handles);

iu=get(handles.listbox_units,'Value');
imat=get(handles.listbox_material,'Value');


%%%%%%%%%%%%%%%%%%%%%%%%%%

if(imat<=4)

    set(handles.edit_thickness,'Visible','on');
    set(handles.text_thick,'Visible','on');
    
else
    
    set(handles.edit_thickness,'Visible','off');
    set(handles.text_thick,'Visible','off');
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%

if(iu==1)
    set(handles.text_EM,'String','Elastic Modulus (lbf/in^2)');
    set(handles.text_MD,'String','Mass Density (lbm/in^3)');    
    set(handles.text_DIAM,'String','Diameter (inch)');
    set(handles.text_thick,'String','Skin Thickness (inch)');      
else
    set(handles.text_EM,'String','Elastic Modulus (Pa)');
    set(handles.text_MD,'String','Mass Density (kg/m^3)');    
    set(handles.text_DIAM,'String','Diameter (m)');
    set(handles.text_thick,'String','Skin Thickness (mm)');         
end

%%%%%%%%%%%%%%%%%%%%%%%%%%

set(handles.listbox_smd,'Visible','off');

if(imat==5)
  
    set(handles.text_EM,'String','Ring Frequency (Hz)');
    
    if(iu==1)
        set(handles.text_MD,'String','Surface Mass Density');
        set(handles.listbox_smd,'Visible','on');
    else
        set(handles.text_MD,'String','Surface Mass Density (kg/m^2)');    
    end    
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%

%% set(handles.edit_W,'String',' ');
%% set(handles.edit_E,'String',' ');

%
if(imat==1)   % aluminum
    if(iu==1)
		W=0.1;   % lbm/in^3     
        E=1.0e+07; 
    else
        W=2768;  % kg/m^3
        E=6.891e+10; 
    end
end
%
if(imat==2)   % steel

    if(iu==1)
		W=0.29;  % lbm/in^3
        E=3.0e+07;
    else
        W=7850; % kg/m^3
        E=2.067e+11;
    end
end
%
%
if(imat==3)   % Graphite/Epoxy
    if(iu==1)
		W=0.058;   % lbm/in^3     
        E=1.0e+07; 
    else
        W=1605;  % kg/m^3
        E=6.891e+10; 
    end
end

try
    ssw=sprintf('%8.4g',W);
    sse=sprintf('%8.4g',E);

    set(handles.edit_W,'String',ssw);
    set(handles.edit_E,'String',sse);
catch
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



function edit_E_Callback(hObject, eventdata, handles)
% hObject    handle to edit_E (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_E as text
%        str2double(get(hObject,'String')) returns contents of edit_E as a double


% --- Executes during object creation, after setting all properties.
function edit_E_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_E (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_W_Callback(hObject, eventdata, handles)
% hObject    handle to edit_W (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_W as text
%        str2double(get(hObject,'String')) returns contents of edit_W as a double


% --- Executes during object creation, after setting all properties.
function edit_W_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_W (see GCBO)
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



function edit_ring_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ring_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ring_frequency as text
%        str2double(get(hObject,'String')) returns contents of edit_ring_frequency as a double


% --- Executes during object creation, after setting all properties.
function edit_ring_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ring_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_input_array_name and none of its controls.
function edit_input_array_name_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_output(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_E and none of its controls.
function edit_E_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_E (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_output(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_W and none of its controls.
function edit_W_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_W (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_output(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_diameter and none of its controls.
function edit_diameter_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_diameter (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_output(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_thickness and none of its controls.
function edit_thickness_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_output(hObject, eventdata, handles);


% --- Executes on selection change in listbox_smd.
function listbox_smd_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_smd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_smd contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_smd
clear_output(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_smd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_smd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save_model.
function pushbutton_save_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iu=get(handles.listbox_units,'Value');
Franken.iu=iu;

imat=get(handles.listbox_material,'Value');
Franken.imat=imat;

nsmd=get(handles.listbox_smd,'Value');
Franken.smd=nsmd;


E=str2num(get(handles.edit_E,'String'));
W=str2num(get(handles.edit_W,'String'));
diameter=str2num(get(handles.edit_diameter,'String'));
thickness=str2num(get(handles.edit_thickness,'String'));


Franken.E=E;
Franken.W=W;
Franken.diameter=diameter;
Franken.thickness=thickness;


FS=strtrim(get(handles.edit_input_array_name,'String'));
Franken.FS=FS;

try
	THM=evalin('base',FS);
	Franken.THM=THM;
catch
end



% % %
 
structnames = fieldnames(Franken, '-full'); % fields in the struct
  
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);
 
    try
 
        save(elk, 'Franken'); 
 
    catch
        warndlg('Save error');
        return;
    end
 
%%% SSS=load(elk)
 
%%%%%%%%%%
%%%%%%%%%%
 
% Construct a questdlg with four options
choice = questdlg('Save Complete.  Reset Workspace?', ...
    'Options', ...
    'Yes','No','No');
% Handle response
switch choice
    case 'Yes'
%%        disp([choice ' Reseting'])
%%        pushbutton_reset_Callback(hObject, eventdata, handles)
        appdata = get(0,'ApplicationData');
        fnsx = fieldnames(appdata);
        for ii = 1:numel(fnsx)
            rmappdata(0,fnsx{ii});
        end
end  



% --- Executes on button press in pushbutton_load_model.
function pushbutton_load_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ref 1');
 
[filename, pathname] = uigetfile('*.mat');
 
NAME = [pathname,filename];
 
struct=load(NAME);
structnames = fieldnames(struct, '-full'); % fields in the struct
 
disp(' ref 2');
 
k=length(structnames);
 
for i=1:k
    namevar=strcat('struct.',structnames{i});
    value=eval(namevar);
    assignin('base',structnames{i},value);
end
 
disp(' ref 3');
 
structnames
 
 
% struct
 
try
    Franken=evalin('base','Franken');
catch
    warndlg(' evalin failed ');
    return;
end
 
Franken
 
try
    iu=Franken.iu;    
    setappdata(0,'iu',iu);
    set(handles.listbox_units,'Value',iu);
catch
end
 
 
try
    FS=Franken.FS;    
    set(handles.edit_input_array_name,'String',FS);
    
    try
        THM=Franken.THM;    
        assignin('base',FS,THM); 
    catch
    end    
    
catch
end


try
    imat=Franken.imat;
    set(handles.listbox_material,'Value',imat);
catch
end

try
    nsmd=Franken.smd;
    set(handles.listbox_smd,'Value',nsmd);
catch
end
 
%%%%%%%%%%%%%%%%%%


try
    E=Franken.E;
    ss=sprintf('%g',E);
    set(handles.edit_E,'String',ss);    
catch
end

try
    W=Franken.W;
    ss=sprintf('%g',W);    
    set(handles.edit_W,'String',ss);    
catch
end

try
    diameter=Franken.diameter;
    ss=sprintf('%g',diameter);    
    set(handles.edit_diameter,'String',ss);    
catch
end

try
    thickness=Franken.thickness;
    ss=sprintf('%g',thickness);
    set(handles.edit_thickness,'String',ss);    
catch
end

change_materials_units(hObject, eventdata, handles);
 

function varargout = acoustic_cavity_blanket_example(varargin)
% ACOUSTIC_CAVITY_BLANKET_EXAMPLE MATLAB code for acoustic_cavity_blanket_example.fig
%      ACOUSTIC_CAVITY_BLANKET_EXAMPLE, by itself, creates a new ACOUSTIC_CAVITY_BLANKET_EXAMPLE or raises the existing
%      singleton*.
%
%      H = ACOUSTIC_CAVITY_BLANKET_EXAMPLE returns the handle to a new ACOUSTIC_CAVITY_BLANKET_EXAMPLE or the handle to
%      the existing singleton*.
%
%      ACOUSTIC_CAVITY_BLANKET_EXAMPLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ACOUSTIC_CAVITY_BLANKET_EXAMPLE.M with the given input arguments.
%
%      ACOUSTIC_CAVITY_BLANKET_EXAMPLE('Property','Value',...) creates a new ACOUSTIC_CAVITY_BLANKET_EXAMPLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before acoustic_cavity_blanket_example_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to acoustic_cavity_blanket_example_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help acoustic_cavity_blanket_example

% Last Modified by GUIDE v2.5 10-Mar-2017 17:21:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @acoustic_cavity_blanket_example_OpeningFcn, ...
                   'gui_OutputFcn',  @acoustic_cavity_blanket_example_OutputFcn, ...
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


% --- Executes just before acoustic_cavity_blanket_example is made visible.
function acoustic_cavity_blanket_example_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to acoustic_cavity_blanket_example (see VARARGIN)

% Choose default command line output for acoustic_cavity_blanket_example
handles.output = hObject;

iu=getappdata(0,'iu');


thickness=getappdata(0,'blanket_thickness');

if(isempty(thickness)==0)

    if(iu==2)

        thickness=thickness*1000;
        
    end    

    ss=sprintf('%g',thickness);
    set(handles.edit_blanket_thickness,'String',ss);
    
end 


pp=getappdata(0,'blanket_percent_coverage');
if(isempty(pp)==0)
    ss=sprintf('%g',pp);
    set(handles.edit_percent_coverage,'String',ss);
end    


bds=getappdata(0,'blanket_density_orig');
if(isempty(bds)==0)
    set(handles.edit_blanket_density,'String',bds);
end  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

iac=getappdata(0,'i_alpha_choice');
if(isempty(iac)==0)
    set(handles.listbox_iac,'Value',iac);
end  

if(iac==2)
   try
      FS=getappdata(0,'alpha_array_name');
      set(handles.edit_alpha_array,'Value',FS);       
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

iloss=getappdata(0,'i_iloss_choice');
if(isempty(iac)==0)
    set(handles.listbox_iloss,'Value',iloss);
end  

if(iloss==2)
   try
      FS=getappdata(0,'iloss_array_name');
      set(handles.edit_iloss_array,'Value',FS);       
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(iu==1) 
    ss='Blanket Mass Density (lbm/ft^3)';
    tt='Blanket Thickness (in)';
else
    ss='Blanket Mass Density (kg/m^3)';
    tt='Blanket Thickness (mm)';    
end
 

set(handles.text_blanket_density,'String',ss);
set(handles.text_thickness,'String',tt);

listbox_iac_Callback(hObject, eventdata, handles);
listbox_iloss_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes acoustic_cavity_blanket_example wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = acoustic_cavity_blanket_example_OutputFcn(hObject, eventdata, handles) 
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

delete(acoustic_cavity_blanket_example);



function edit_percent_coverage_Callback(hObject, eventdata, handles)
% hObject    handle to edit_percent_coverage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_percent_coverage as text
%        str2double(get(hObject,'String')) returns contents of edit_percent_coverage as a double


% --- Executes during object creation, after setting all properties.
function edit_percent_coverage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_percent_coverage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_blanket_density_Callback(hObject, eventdata, handles)
% hObject    handle to edit_blanket_density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_blanket_density as text
%        str2double(get(hObject,'String')) returns contents of edit_blanket_density as a double


% --- Executes during object creation, after setting all properties.
function edit_blanket_density_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_blanket_density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iu=getappdata(0,'iu');

external_SPL=getappdata(0,'external_spl_data');

if isempty(external_SPL)
   warndlg('external_SPL missing. Run fairing'); 
   return;
else
   fc=external_SPL(:,1);
end

nfc=length(fc);


blanket_density=str2num(get(handles.edit_blanket_density,'String'));

if isempty(blanket_density)
   warndlg('Enter Blanket Density'); 
   return;
end

blanket_density_orig=blanket_density;


thickness=str2num(get(handles.edit_blanket_thickness,'String'));

if isempty(thickness)
   warndlg('Enter Thickness'); 
   return;
end



if(iu==1) 

    blanket_density=blanket_density*1.4991e-06;   % lbm/ft^3 -> lbf sec^2/in^4  
    
else 
    
    thickness=thickness/1000;
    
end


blanket_mass_area=blanket_density*thickness; 

percent_coverage=str2num(get(handles.edit_percent_coverage,'String'));


iac=get(handles.listbox_iac,'Value');
setappdata(0,'i_alpha_choice',iac);

if(iac==2)
    try  
        FS=get(handles.edit_alpha_array,'String');
        THMalpha=evalin('base',FS);  
        setappdata(0,'alpha_array_name',FS);
    catch  
        warndlg('Absorption array does not exist.  Try again.')
        return;
    end

    sz=size(THMalpha);

    if(sz(2)~=2)
        warndlg('Absorption array must have 2 columns ');
        return;
    end
else
    THMalpha=0;
end

iloss=get(handles.listbox_iloss,'Value');
setappdata(0,'i_iloss_choice',iloss);

if(iloss==2)
    try  
        FS=get(handles.edit_iloss_array,'String');
        THMloss=evalin('base',FS);  
        setappdata(0,'iloss_array_name',FS);
    catch  
        warndlg('Insertion loss array does not exist.  Try again.')
        return;
    end

    sz=size(THMloss);

    if(sz(2)~=2)
        warndlg('Insertion loss array must have 2 columns ');
        return;
    end
else
    THMloss=0;
end

fig_num=777;

[fig_num,freq_iloss]=blanket_loss(THMloss,fc,nfc,fig_num,iloss);

[fig_num,freq_alpha]=blanket_alpha(THMalpha,thickness,fc,nfc,fig_num,iac);




% blanket_mass_area

setappdata(0,'blanket_mass_area',blanket_mass_area);
setappdata(0,'blanket_density_orig',blanket_density_orig);
setappdata(0,'blanket_percent_coverage',percent_coverage);
setappdata(0,'blanket_freq_alpha',freq_alpha);
setappdata(0,'blanket_insertion_loss',freq_iloss);
setappdata(0,'blanket_thickness',thickness);

msgbox('Calculation Complete');



function edit_blanket_thickness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_blanket_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_blanket_thickness as text
%        str2double(get(hObject,'String')) returns contents of edit_blanket_thickness as a double


% --- Executes during object creation, after setting all properties.
function edit_blanket_thickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_blanket_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_reference.
function pushbutton_reference_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_reference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



A = imread('acoustic_absorption_insertion.jpg');
    figure(850) 
    imshow(A,'border','tight','InitialMagnification',100); 



% --- Executes on selection change in listbox_iac.
function listbox_iac_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_iac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_iac contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_iac

n=get(handles.listbox_iac,'Value');

if(n==1)
    set(handles.text_manual_1,'Visible','off');
    set(handles.text_manual_2,'Visible','off');
    set(handles.edit_alpha_array,'Visible','off');    
else
    set(handles.text_manual_1,'Visible','on');
    set(handles.text_manual_2,'Visible','on');
    set(handles.edit_alpha_array,'Visible','on');      
end






% --- Executes during object creation, after setting all properties.
function listbox_iac_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_iac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_alpha_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_alpha_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_alpha_array as text
%        str2double(get(hObject,'String')) returns contents of edit_alpha_array as a double


% --- Executes during object creation, after setting all properties.
function edit_alpha_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_alpha_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_ac_choice.
function listbox_ac_choice_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_ac_choice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_ac_choice contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_ac_choice


% --- Executes during object creation, after setting all properties.
function listbox_ac_choice_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_ac_choice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_iloss_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_iloss_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_iloss_array as text
%        str2double(get(hObject,'String')) returns contents of edit_iloss_array as a double


% --- Executes during object creation, after setting all properties.
function edit_iloss_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_iloss_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_iloss.
function listbox_iloss_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_iloss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_iloss contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_iloss

n=get(handles.listbox_iloss,'Value');

if(n==1)
    set(handles.text_manual_3,'Visible','off');
    set(handles.text_manual_4,'Visible','off');
    set(handles.edit_iloss_array,'Visible','off');    
else
    set(handles.text_manual_3,'Visible','on');
    set(handles.text_manual_4,'Visible','on');
    set(handles.edit_iloss_array,'Visible','on');      
end



% --- Executes during object creation, after setting all properties.
function listbox_iloss_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_iloss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

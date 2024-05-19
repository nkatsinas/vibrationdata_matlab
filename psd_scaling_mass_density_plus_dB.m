function varargout = psd_scaling_mass_density_plus_dB(varargin)
% PSD_SCALING_MASS_DENSITY_PLUS_DB MATLAB code for psd_scaling_mass_density_plus_dB.fig
%      PSD_SCALING_MASS_DENSITY_PLUS_DB, by itself, creates a new PSD_SCALING_MASS_DENSITY_PLUS_DB or raises the existing
%      singleton*.
%
%      H = PSD_SCALING_MASS_DENSITY_PLUS_DB returns the handle to a new PSD_SCALING_MASS_DENSITY_PLUS_DB or the handle to
%      the existing singleton*.
%
%      PSD_SCALING_MASS_DENSITY_PLUS_DB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PSD_SCALING_MASS_DENSITY_PLUS_DB.M with the given input arguments.
%
%      PSD_SCALING_MASS_DENSITY_PLUS_DB('Property','Value',...) creates a new PSD_SCALING_MASS_DENSITY_PLUS_DB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before psd_scaling_mass_density_plus_dB_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to psd_scaling_mass_density_plus_dB_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help psd_scaling_mass_density_plus_dB

% Last Modified by GUIDE v2.5 21-Oct-2019 09:56:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @psd_scaling_mass_density_plus_dB_OpeningFcn, ...
                   'gui_OutputFcn',  @psd_scaling_mass_density_plus_dB_OutputFcn, ...
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


% --- Executes just before psd_scaling_mass_density_plus_dB is made visible.
function psd_scaling_mass_density_plus_dB_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to psd_scaling_mass_density_plus_dB (see VARARGIN)

% Choose default command line output for psd_scaling_mass_density_plus_dB
handles.output = hObject;

listbox_yplotlimits_Callback(hObject, eventdata, handles);

% set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes psd_scaling_mass_density_plus_dB wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = psd_scaling_mass_density_plus_dB_OutputFcn(hObject, eventdata, handles) 
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
delete(psd_scaling_mass_density_plus_dB);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * * * ');
disp(' ');

fig_num=1;

try  
    FS=get(handles.edit_input_array,'String');
    THM=evalin('base',FS);  
catch
    warndlg('Input Array does not exist.  Try again.')
    return;
end

ppp1=THM;

dB=str2num(get(handles.edit_dB,'String'));

    
rmass=str2num(get(handles.edit_reference_mass,'String'));
nmass=str2num(get(handles.edit_new_mass,'String'));

scale1=rmass/nmass;

scale2=10^(dB/10);
   
x_label='Frequency (Hz)';
y_label='Accel (G^2/Hz)';
   


THM(:,2)=THM(:,2)*scale1*scale2;

ppp2=THM;


fmin=THM(1,1);
fmax=max(THM(:,1));

t_string=get(handles.edit_title,'String');

md=7;


 [~,grms_in] = calculate_PSD_slopes(ppp1(:,1),ppp1(:,2));
[~,grms_out] = calculate_PSD_slopes(ppp2(:,1),ppp2(:,2));

L1=get(handles.edit_L1,'String');
L2=get(handles.edit_L2,'String');


    leg1=sprintf('%s  %6.3g GRMS',L1,grms_in);
    
    if(dB>0)
        leg2=sprintf('%s  %6.3g GRMS',L2,grms_out);
    else
        leg2= sprintf('%s  %6.3g GRMS',L2,grms_out);    
    end
    
    out1=sprintf('\n %s  %s',FS,leg2);
    disp(out1);
    



if(dB<0)

    [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);

else
    
    [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp2,ppp1,leg2,leg1,fmin,fmax,md);    
end

ny_limits=get(handles.listbox_yplotlimits,'Value');

if(ny_limits==2)  % manual log
    
    try
    
        ymin=str2num(get(handles.edit_ymin,'String'));
        ymax=str2num(get(handles.edit_ymax,'String'));
    
        ylim([ymin,ymax]);
        
    end    
end    

% set(handles.uipanel_save,'Visible','on');

setappdata(0,'ppp2',ppp2)

sz=size(ppp2);



data=ppp2;

output_name=strtrim(get(handles.edit_output_array_name,'String'));
assignin('base', output_name,data);


pushbutton_save_model_Callback(hObject, eventdata, handles);


disp(' ');
disp(' Format:  %9.5g '); 
disp(' ');

for i=1:sz(1)
    out1=sprintf(' %9.5g \t %9.5g ',ppp2(i,1),ppp2(i,2));
    disp(out1); 
end


    
iflag=getappdata(0,'iflag');

if(iflag==0)
    name=getappdata(0,'name');
    out1=sprintf('Save Complete: %s',name);
    msgbox(out1);
end





function edit_input_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dB_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dB as text
%        str2double(get(hObject,'String')) returns contents of edit_dB as a double


% --- Executes during object creation, after setting all properties.
function edit_dB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_title_Callback(hObject, eventdata, handles)
% hObject    handle to edit_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_title as text
%        str2double(get(hObject,'String')) returns contents of edit_title as a double


% --- Executes during object creation, after setting all properties.
function edit_title_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_yplotlimits.
function listbox_yplotlimits_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_yplotlimits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_yplotlimits contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_yplotlimits


try
    
    n=get(handles.listbox_yplotlimits,'Value');

    if(n==1)
        set(handles.edit_ymin,'Enable','off');
        set(handles.edit_ymax,'Enable','off');    
    else
        set(handles.edit_ymin,'Enable','on');
        set(handles.edit_ymax,'Enable','on');      
    end

catch
end


% --- Executes during object creation, after setting all properties.
function listbox_yplotlimits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_yplotlimits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ymin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ymin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ymin as text
%        str2double(get(hObject,'String')) returns contents of edit_ymin as a double


% --- Executes during object creation, after setting all properties.
function edit_ymin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ymin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ymax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ymax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ymax as text
%        str2double(get(hObject,'String')) returns contents of edit_ymax as a double


% --- Executes during object creation, after setting all properties.
function edit_ymax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ymax (see GCBO)
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

data=getappdata(0,'ppp2');

output_name=strtrim(get(handles.edit_output_array_name,'String'));
assignin('base', output_name,data);



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



function edit_reference_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_reference_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_reference_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_reference_mass as a double


% --- Executes during object creation, after setting all properties.
function edit_reference_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_reference_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_new_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_new_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_new_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_new_mass as a double


% --- Executes during object creation, after setting all properties.
function edit_new_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_new_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save_model.
function pushbutton_save_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    output_array_name=get(handles.edit_output_array_name,'String');
    psd_scaling.output_array_name=output_array_name;      
catch
end

try
    L1=get(handles.edit_L1,'String');
    psd_scaling.L1=L1;    
catch
end

try
    L2=get(handles.edit_L2,'String');
    psd_scaling.L2=L2;    
catch
end



try
    input_array=get(handles.edit_input_array,'String');
    psd_scaling.input_array=input_array;
catch
end

try
    title=get(handles.edit_title,'String');
    psd_scaling.title=title;
catch
end

try
    dB=get(handles.edit_dB,'String');
    psd_scaling.dB=dB;
catch
end

try
    reference_mass=get(handles.edit_reference_mass,'String');
    psd_scaling.reference_mass=reference_mass;
catch
end

try
    new_mass=get(handles.edit_new_mass,'String');
    psd_scaling.new_mass=new_mass;
catch
end

try
    yplotlimits=get(handles.listbox_yplotlimits,'Value');
    psd_scaling.yplotlimits=yplotlimits;
catch
end

try
    ymin=get(handles.edit_ymin,'String');
    psd_scaling.ymin=ymin;
catch
end

try
    ymax=get(handles.edit_ymax,'String');
    psd_scaling.ymax=ymax;
catch
end

try
    output_array_name=get(handles.edit_output_array_name,'String');
    psd_scaling.output_array_name=output_array_name;
catch
end


% % %
 
structnames = fieldnames(psd_scaling, '-full'); % fields in the struct
  
% % %
 
%%   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
  
%%% SSS=load(elk)


try
   name=get(handles.edit_output_array_name,'String');
   name=strrep(name,' ','');
catch
   warndlg('Enter output name');
   return;
end

if(isempty(name))
   warndlg('Enter output name');
   return;    
end

    name=strrep(name,'.mat','');
    name=strrep(name,'_scale_model','');
    name2=sprintf('%s_scale_model',name);
    name=sprintf('%s_scale_model.mat',name);
   
    
%%%

    iflag=0;
    
    try
        fid = fopen(name,'r');
        iflag=1;
        
        if(fid>0)
            out1=sprintf('%s   already exists.  Replace? ',name);
            choice = questdlg(out1,'Options','Yes','No','No');
        
% Handle response

            switch choice
                case 'Yes'                        
                    iflag=0; 
            end 
        end
        
    catch
    end
    
    if(fid==-1)
        iflag=0;
    end
    
%%%
    
    if(iflag==0)
        try
            save(name, 'psd_scaling'); 
        catch
            warndlg('Save error');
            return;
        end
    end
    setappdata(0,'iflag',iflag);
 


%%%@@@@@

%    disp('**ref b**');
    
  
    try
        filename = 'psd_scaling_mass_density_plus_dB_load_list.txt';
        THM=importdata(filename);
        
 %        THM


    catch
         THM=[];
         disp('no read 1');       
    end
    
   [THM,nrows]=THM_save(THM,name2);

%    NTHM
        
%    disp('**ref c**');
        
 
    fileID = fopen(filename,'w');

    for row = 1:nrows
        fprintf(fileID,'%s\n',char(THM{row,:}));
        char(THM{row,:});
    end
    fclose(fileID);
    
    
%%%@@@@@
    
setappdata(0,'name',name);

%%%%%%%%%%%%%%%%%%%%




% --- Executes on button press in pushbutton_load_model.
function pushbutton_load_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


[filename, pathname] = uigetfile('*.mat');

setappdata(0,'filename',filename);
setappdata(0,'pathname',pathname);
 
load_core(hObject, eventdata, handles)


function load_core(hObject, eventdata, handles)

disp(' ref 1');

filename=strtrim(getappdata(0,'filename'));
% pathname=getappdata(0,'pathname')

try
%    NAME = [pathname,filename];
    NAME=filename;
    struct=load(NAME);
catch    
    NAME
    warndlg('load failed');
    return;
end


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
    psd_scaling=evalin('base','psd_scaling');
catch
    warndlg(' evalin failed ');
    return;
end
 
psd_scaling
 
%%%%%


try
    input_array=psd_scaling.input_array;    
    set(handles.edit_input_array,'String',input_array);
catch
end

try
    title=psd_scaling.title;    
    set(handles.edit_title,'String',title);
catch
end

try
    dB=psd_scaling.dB;    
    set(handles.edit_dB,'String',dB);
catch
end

try
    reference_mass=psd_scaling.reference_mass;    
    set(handles.edit_reference_mass,'String',reference_mass);
catch
end

try
    new_mass=psd_scaling.new_mass;    
    set(handles.edit_new_mass,'String',new_mass);
catch
end

try
    yplotlimits=psd_scaling.yplotlimits;    
    set(handles.listbox_yplotlimits,'Value',yplotlimits);
catch
end

try
    ymin=psd_scaling.ymin;    
    set(handles.edit_ymin,'String',ymin);
catch
end

try
    ymax=psd_scaling.ymax;    
    set(handles.edit_ymax,'String',ymax);
catch
end



try
    output_array_name=psd_scaling.output_array_name;    
    set(handles.edit_output_array_name,'String',output_array_name);
catch
end

try
    L1=psd_scaling.L1;    
    set(handles.edit_L1,'String',L1);    
catch
end

try
    L2=psd_scaling.L2;    
    set(handles.edit_L2,'String',L2);    
catch
end

listbox_yplotlimits_Callback(hObject, eventdata, handles);



function edit_L1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_L1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_L1 as text
%        str2double(get(hObject,'String')) returns contents of edit_L1 as a double


% --- Executes during object creation, after setting all properties.
function edit_L1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_L1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_L2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_L2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_L2 as text
%        str2double(get(hObject,'String')) returns contents of edit_L2 as a double


% --- Executes during object creation, after setting all properties.
function edit_L2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_L2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
% set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_reference_mass and none of its controls.
function edit_reference_mass_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_reference_mass (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
% set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_new_mass and none of its controls.
function edit_new_mass_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_new_mass (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
% set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_dB and none of its controls.
function edit_dB_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_dB (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
% set(handles.uipanel_save,'Visible','off');



function edit_save_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_save_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_load_model_list.
function pushbutton_load_model_list_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_model_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

psd_scaling_mass_density_plus_dB_load;

uiwait()

uiresume(psd_scaling_mass_density_plus_dB_load)

delete(psd_scaling_mass_density_plus_dB_load);
    
Lflag=getappdata(0,'Lflag');


if(Lflag==0)
    
    load_core(hObject, eventdata, handles);

    delete(psd_scaling_mass_density_plus_dB_load);

else
    delete(psd_scaling_mass_density_plus_dB_load);    
end

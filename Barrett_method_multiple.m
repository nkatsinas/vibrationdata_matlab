function varargout = Barrett_method_multiple(varargin)
% BARRETT_METHOD_MULTIPLE MATLAB code for Barrett_method_multiple.fig
%      BARRETT_METHOD_MULTIPLE, by itself, creates a new BARRETT_METHOD_MULTIPLE or raises the existing
%      singleton*.
%
%      H = BARRETT_METHOD_MULTIPLE returns the handle to a new BARRETT_METHOD_MULTIPLE or the handle to
%      the existing singleton*.
%
%      BARRETT_METHOD_MULTIPLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BARRETT_METHOD_MULTIPLE.M with the given input arguments.
%
%      BARRETT_METHOD_MULTIPLE('Property','Value',...) creates a new BARRETT_METHOD_MULTIPLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Barrett_method_multiple_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Barrett_method_multiple_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Barrett_method_multiple

% Last Modified by GUIDE v2.5 07-Jul-2018 14:31:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Barrett_method_multiple_OpeningFcn, ...
                   'gui_OutputFcn',  @Barrett_method_multiple_OutputFcn, ...
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


% --- Executes just before Barrett_method_multiple is made visible.
function Barrett_method_multiple_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Barrett_method_multiple (see VARARGIN)

% Choose default command line output for Barrett_method_multiple
handles.output = hObject;


listbox_num_Callback(hObject, eventdata, handles)
listbox_diam_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Barrett_method_multiple wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Barrett_method_multiple_OutputFcn(hObject, eventdata, handles) 
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

delete(Barrett_method_multiple);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%

disp(' ');
disp(' * * * * * * * * * * * * * * * * * * * * * * ');
disp(' ');

Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end


fig_num=1;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS1=strtrim(get(handles.edit_ref_spl,'String'));
    SPL_ref=evalin('base',FS1);  
catch
    warndlg('Reference SPL array not found ');
    return; 
end

szr=size(SPL_ref);

if(szr(2)~=2)
    warndlg('Input Reference SPL array must have two columns');
    return;
end

Lr=szr(1);

npsd=get(handles.listbox_psd_type,'Value');

Mr=str2num(get(handles.edit_reference_mass,'String'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS3=strtrim(get(handles.edit_ref_psd,'String'));
    PSD_ref=evalin('base',FS3);  
catch
    warndlg('Reference PSD array not found ');
    return;       
end

ppp=PSD_ref;

[~,grms] = calculate_PSD_slopes(ppp(:,1),ppp(:,2));

t_string=sprintf('Reference Power Spectral Density  %7.3g GRMS',grms);

md=6;

fmin=ppp(1,1);
fmax=max(ppp(:,1));

x_label='Frequency (Hz)';
y_label='Accel (G^2/Hz)';

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N=get(handles.listbox_num,'Value');

get_table_data(hObject, eventdata, handles);

shell_name=getappdata(0,'shell_name');
SPL_name=getappdata(0,'SPL_name');
diam=getappdata(0,'diam');
smd=getappdata(0,'smd');
PSD_name=getappdata(0,'PSD_name');


ndiam=get(handles.listbox_diam,'Value');

nmr=get(handles.listbox_mass_type,'Value');

nam=1;  % no component mass
W=1;
Wc=0;


disp(' ');
disp(' Overall Structure Levels ');
disp(' ');
 

for i=1:N
    
    M_ratio=Mr/smd(i);
    
    out1=sprintf('\n %d  SPL_name=%s   M_ratio=%8.4g',i,SPL_name{i},M_ratio);
    disp(out1);
    
    try
        THM=evalin('base',SPL_name{i});
    catch
        warndlg('New SPL array not found ');
        return;
    end
    
    szn=size(THM);
    
    f=THM(:,1);
        
    ncols=szn(2)-1;   
    
    for j=1:ncols

            
        dB=THM(:,j+1);
        
        SPL_new=[f dB];
        
        [oadb_input(j)]=oaspl_function(dB);
        
        [fc,~,ratio2,LL]=Barrett_ratio(SPL_ref,SPL_new,Lr);
        [fl,fu,imax]=Barrett_set_limits(fc);

%%        

        if(npsd==1) % already one-third octave
            PSD_ref_one_third=PSD_ref;
            [PSD_new]=Barrett_PSD_new_alr(LL,fc,ratio2,M_ratio,nmr,nam,W,Wc,PSD_ref_one_third);
            ppp1=PSD_ref;
        end
        if(npsd==2) % narrowband, convert to one-third octave
    
            X=PSD_ref(:,1);
            X=diff(X);
            R=(max(X)-mean(X))/mean(X);
    
            if( R<0.05)
                [PSD_ref_one_third,ff,ossum]=Barrett_count(fl,fc,fu,PSD_ref,imax);
                [PSD_new]=Barrett_PSD_new(LL,fc,ff,ratio2,M_ratio,nmr,nam,ossum,W,Wc);
                ppp1=PSD_ref_one_third;
            else
                warndlg(' Frequency spacing is not narrowband '); 
                return; 
            end        
            
            
        end
        if(npsd==3) % narrowband, leave as is
            [PSD_new,ppp1]=Barrett_narrowband(PSD_ref,ratio2,M_ratio,W,Wc,nmr,nam,fc);     
        end 

%%
        try
            ppp2=PSD_new;
        catch
            warndlg('PSD_new not found');
            return;
        end  
%% 
        if(j==1)
            sz=size(ppp2);
            nrows=sz(1);
            Wa=zeros(nrows,szn(2));
        end

        Wa(:,(j+1))=ppp2(:,2);
        

    end
    
    if(ndiam==2)

            diam_refer=str2num(get(handles.edit_ref_diam,'String'));
            diam_new=diam(i);

            dratio=(diam_refer/diam_new);

            try
                ppp2(:,1)=ppp2(:,1)*dratio;
            catch
                dratio
                size(ppp2)
                warndlg('Error at dratio step');
                return;
            end
    end
        
    Wa(:,1)=ppp2(:,1);

        
    try
        assignin('base', PSD_name{i}, Wa);       
    catch
        ppp2
        warndlg('assignin error')
        return;
    end   
    
     
    for j=1:ncols
        
        dB=THM(:,j+1);
             
        [~,grms(j)] = calculate_PSD_slopes(Wa(:,1),Wa(:,j+1));
         
        out1=sprintf(' %d.  %s %9.4g GRMS   %8.4g dB',j,shell_name{i},grms(j),oadb_input(j));          
        disp(out1);

        leg_psd{j}=sprintf('%d.  %7.3g GRMS',j,grms(j));
        
        [oadb]=oaspl_function(dB);
        leg_spl{j}=sprintf('%d.  oaspl %7.4g dB',j,oadb);
      
    end
    
    fmin=Wa(1,1);
    fmax=max(Wa(:,1));  

    
    % plot spls
    
    SPL_n= strrep(SPL_name{i},'_',' ');
    t_string=sprintf(' Sound Pressure Level  %s  \n Zero dB Ref = 20 micro Pa',SPL_n);
    leg=leg_spl;
    
    if(ncols==1)       
        n_type=1;
        [fig_num]=spl_plot_nd(fig_num,n_type,f,THM(:,2));
    else
        [fig_num]=spl_plot_all(fig_num,t_string,THM,leg);
    end   
      
        
    % plot psds
    x_label='Frequency (Hz)';
    y_label='Accel (G^2/Hz)';
    shell_n= strrep(shell_name{i},'_',' ');
    
    leg=leg_psd;
    ppp=Wa;
    
    if(ncols==1)
        md=6;
        t_string=sprintf('Power Spectral Density  Barrett  %s \n Overall Level %7.3g GRMS',shell_n,grms(j));
        [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);
    else
        t_string=sprintf('Power Spectral Density  Barrett  %s',shell_n);
        [fig_num]=plot_loglog_multiple_function(fig_num,x_label,y_label,t_string,ppp,leg,fmin,fmax);
    end    
    
end    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

disp(' ');
disp(' Output PSD Arrays ');

for i=1:N
   out1=sprintf('  %s ',PSD_name{i});
   disp(out1);
end

disp(' ');

msgbox('Calculation Complete');



           



function edit_ref_spl_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ref_spl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ref_spl as text
%        str2double(get(hObject,'String')) returns contents of edit_ref_spl as a double


% --- Executes during object creation, after setting all properties.
function edit_ref_spl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ref_spl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_new_spl_Callback(hObject, eventdata, handles)
% hObject    handle to edit_new_spl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_new_spl as text
%        str2double(get(hObject,'String')) returns contents of edit_new_spl as a double


% --- Executes during object creation, after setting all properties.
function edit_new_spl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_new_spl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ref_psd_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ref_psd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ref_psd as text
%        str2double(get(hObject,'String')) returns contents of edit_ref_psd as a double


% --- Executes during object creation, after setting all properties.
function edit_ref_psd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ref_psd (see GCBO)
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


% --- Executes on button press in pushbutton_eq.
function pushbutton_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

     A = imread('Barrett_equation.jpg');
     figure(990) 
     imshow(A,'border','tight','InitialMagnification',100) 



% --- Executes on selection change in listbox_mass_type.
function listbox_mass_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_mass_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_mass_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_mass_type


% --- Executes during object creation, after setting all properties.
function listbox_mass_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_mass_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_ref_spl and none of its controls.
function edit_ref_spl_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_ref_spl (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_new_spl and none of its controls.
function edit_new_spl_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_new_spl (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_ref_psd and none of its controls.
function edit_ref_psd_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_ref_psd (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_reference_mass and none of its controls.
function edit_reference_mass_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_reference_mass (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_new_mass and none of its controls.
function edit_new_mass_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_new_mass (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)




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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


data=getappdata(0,'PSD_new');

output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 


% --- Executes on selection change in listbox_add_mass.
function listbox_add_mass_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_add_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_add_mass contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_add_mass

n=get(handles.listbox_add_mass,'Value');

set(handles.text_W,'Visible','off');
set(handles.edit_W,'Visible','off');
set(handles.text_Wc,'Visible','off');
set(handles.edit_Wc,'Visible','off');
set(handles.text_ame,'Visible','off');



if(n==2)

    set(handles.text_W,'Visible','on');
    set(handles.edit_W,'Visible','on');
    set(handles.text_Wc,'Visible','on');
    set(handles.edit_Wc,'Visible','on');    
    set(handles.text_ame,'Visible','on');

end




% --- Executes during object creation, after setting all properties.
function listbox_add_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_add_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Wc_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Wc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Wc as text
%        str2double(get(hObject,'String')) returns contents of edit_Wc as a double


% --- Executes during object creation, after setting all properties.
function edit_Wc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Wc (see GCBO)
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


% --- Executes on key press with focus on edit_W and none of its controls.
function edit_W_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_W (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_Wc and none of its controls.
function edit_Wc_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Wc (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on selection change in listbox_psd_type.
function listbox_psd_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_psd_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_psd_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_psd_type


% --- Executes during object creation, after setting all properties.
function listbox_psd_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_psd_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function[fc,ratio,ratio2,LL]=Barrett_ratio(SPL_ref,SPL_new,Lr)

k=1;

for i=1:Lr
    
        freq=SPL_ref(i,1);
        
        [~,inx] = min(abs(freq-SPL_new(:,1)));
        
        fx=SPL_new(inx,1);
        
        fg=abs(log(freq/fx)/log(2));
        
        if( fg < 1/12 )
            
        
            dB_diff=SPL_new(inx,2)-SPL_ref(i,2);
        
            fc(k)=freq;
             ratio(k)=10^(dB_diff/20);
            ratio2(k)=ratio(k)^2;
                    
%%            out1=sprintf('i=%d  fc=%8.4g  ratio=%8.4g ',i,fc(k),ratio(k));
%%            disp(out1);            
        
            k=k+1;
            
        end
    
end

LL=length(ratio);


function[fl,fu,imax]=Barrett_set_limits(fc)

%%


oex=1/6;

imax=length(fc);


%
%% disp(' ');
%% disp(' set limits... ');
%
fl=zeros(imax,1);
fu=zeros(imax,1);

for i=1:imax
    fl(i)=fc(i)/(2.^oex);
end

for i=1:(imax-1)
    fu(i)=fl(i+1);	
end

fu(imax)=fc(i)*(2.^oex);
%


function[PSD_ref_one_third,ff,ossum]=Barrett_count(fl,fc,fu,PSD_ref,imax)

%% disp(' ');
%% disp('  counts...');

ssum=zeros(imax,1);
count=zeros(imax,1);

f=PSD_ref(:,1);
amp=PSD_ref(:,2);

%% 

for k=1:length(f)

    for i=1:imax
		
        if( f(k)>= fl(i) && f(k) <= fu(i))

				ssum(i)=ssum(i)+ amp(k);
				count(i)=count(i)+1;
                
                break;
        end        
    end
end



%% disp(' ');
%% disp('  calculate output data...');

clear length; 
    
ijk=1;

f_max=max(f);

    
for i=1:(length(count))

    
    iflag=0;
        
    if( fl(i) > f_max)
        
%        out1=sprintf(' fl(i)=%8.4g  f(LL)=%8.4g',fl(i),f(LL));
%        disp(out1);
        
        break;
    end
         
    if(iflag==0)
        if(count(i)>=1)
            iflag=1;
        end
    end
    
    if( iflag==1 && ssum(i) > 1.0e-20)
		
        ossum(ijk)=ssum(i)/count(i);
        ff(ijk)=fc(i);
        ijk=ijk+1;
 
    end
    
%    out1=sprintf(' i=%d  iflag=%d  ',i,iflag);
%    disp(out1);
        
end

ff=fix_size(ff);
ossum=fix_size(ossum);

PSD_ref_one_third=[ff ossum];

%% count




function[PSD_new]=Barrett_PSD_new(LL,fc,ff,ratio2,M_ratio,nmr,nam,ossum,W,Wc)

if(nmr==1)
    R=(ratio2)*M_ratio;
else
    R=(ratio2)*M_ratio^2;    
end


PSD_new=zeros(LL,2);
PSD_new(:,1)=fc;

for i=1:LL

    [~,idx]=min(abs(fc(i)-ff));
        
    psd_r=ossum(idx);
    
    PSD_new(i,2)=R(i)*psd_r;    

end


if(nam==2)
     
    F=W/(W+Wc);
    
    PSD_new(:,2)=PSD_new(:,2)*F;    
    
end



%%%

function[PSD_new]=Barrett_PSD_new_alr(LL,fc,ratio2,M_ratio,nmr,nam,W,Wc,PSD_ref_one_third)


if(nmr==1)
    R=(ratio2)*M_ratio;
else
    R=(ratio2)*M_ratio^2;    
end


PSD_new=zeros(LL,2);
PSD_new(:,1)=fc;

ff=PSD_ref_one_third(:,1);

ff_min=ff(1);
ff_max=ff(length(ff));

for i=1:LL
    
    if(fc(i)>=ff_min && fc(i)<=ff_max)
    
        [~,idx]=min(abs(fc(i)-ff));
        
        psd_r=PSD_ref_one_third(idx,2);
    
        PSD_new(i,2)=R(i)*psd_r;    
    
    end

end

for i=LL:-1:1
 
    if(PSD_new(i,2)==0)
        PSD_new(i,:)=[];
    end
    
end


if(nam==2)
     
    F=W/(W+Wc);
    
    PSD_new(:,2)=PSD_new(:,2)*F;    
    
end

out1=sprintf('\n M_ratio=%7.3g \n',M_ratio);
disp(out1);

%%%

function[PSD_new,ppp1]=Barrett_narrowband(PSD_ref,ratio2,M_ratio,W,Wc,nmr,nam,fc)

    ppp1=PSD_ref;

    m=length(PSD_ref(:,1));
    
    PSD_new=zeros(m,1);
    
    PSD_new(:,1)=PSD_ref(:,1);
  
    
    
    if(nmr==1)
        R=(ratio2)*M_ratio;
    else
        R=(ratio2)*M_ratio^2;    
    end
    
    
    for i=1:m
       
        ff=PSD_ref(i,1);
        
        [~,idx]=min(abs(fc-ff));
    
        PSD_new(i,2)=R(idx)*PSD_ref(i,2);
        
    end


    if(nam==2)
     
        F=W/(W+Wc);
    
        PSD_new(:,2)=PSD_new(:,2)*F;    
    
    end

    out1=sprintf('\n M_ratio=%7.3g \n',M_ratio);
    disp(out1);
    
    
    


% --- Executes on button press in pushbutton_save_model.
function pushbutton_save_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


num=get(handles.listbox_num,'Value');
Barrett_multiple.num=num;

npsd=get(handles.listbox_psd_type,'Value');
Barrett_multiple.npsd=npsd;

nmr=get(handles.listbox_mass_type,'Value');
Barrett_multiple.nmr=nmr;

ndiam=get(handles.listbox_diam,'Value');
Barrett_multiple.ndiam=ndiam;

%%%

FS_ref_spl=get(handles.edit_ref_spl,'String');
Barrett_multiple.FS_ref_spl=FS_ref_spl;

FS_ref_psd=get(handles.edit_ref_psd,'String');
Barrett_multiple.FS_ref_psd=FS_ref_psd;

try
    ref_spl=evalin('base',FS_ref_spl);
    Barrett_multiple.ref_spl=ref_spl;
catch
end

try
    ref_psd=evalin('base',FS_ref_psd);
    Barrett_multiple.ref_psd=ref_psd;
catch
end
            
%%%

reference_mass=get(handles.edit_reference_mass,'String');
Barrett_multiple.reference_mass=reference_mass;

ref_diam=get(handles.edit_ref_diam,'String');
Barrett_multiple.ref_diam=ref_diam;

%%%

get_table_data(hObject, eventdata, handles);

shell_name=getappdata(0,'shell_name');
SPL_name=getappdata(0,'SPL_name');
diam=getappdata(0,'diam');
smd=getappdata(0,'smd');
PSD_name=getappdata(0,'PSD_name');


Barrett_multiple.shell_name=shell_name;
Barrett_multiple.SPL_name=SPL_name;
Barrett_multiple.diam=diam;
Barrett_multiple.smd=smd;
Barrett_multiple.PSD_name=PSD_name;


N=num;

for i=1:N
    try
        
        if(i==1)
            THM1=evalin('base',SPL_name{i});
            Barrett_multiple.THM1=THM1;
        end
        if(i==2)
            THM2=evalin('base',SPL_name{i});
            Barrett_multiple.THM2=THM2;
        end        
        if(i==3)
            THM3=evalin('base',SPL_name{i});
            Barrett_multiple.THM3=THM3;
        end
        if(i==4)
            THM4=evalin('base',SPL_name{i});
            Barrett_multiple.THM4=THM4;
        end                
        
    catch
    end
end


% % %
 
structnames = fieldnames(Barrett_multiple, '-full'); % fields in the struct
  
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);
 
    try
 
        save(elk, 'Barrett_multiple'); 
 
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



% --- Executes on button press in pushbutton_load_modal.
function pushbutton_load_modal_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_modal (see GCBO)
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
    Barrett_multiple=evalin('base','Barrett_multiple');
catch
    warndlg(' evalin failed ');
    return;
end
 
Barrett_multiple


try
    num=Barrett_multiple.num;    
    set(handles.listbox_num,'Value',num);
catch
end

listbox_num_Callback(hObject, eventdata, handles)

try
    ndiam=Barrett_multiple.ndiam;    
    set(handles.listbox_diam,'Value',ndiam);
catch
end
    
listbox_diam_Callback(hObject, eventdata, handles);

%%%

npsd=Barrett_multiple.npsd;
set(handles.listbox_psd_type,'Value',npsd);

nmr=Barrett_multiple.nmr;
set(handles.listbox_mass_type,'Value',nmr);

%%%

reference_mass=Barrett_multiple.reference_mass;
set(handles.edit_reference_mass,'String',reference_mass);

ref_diam=Barrett_multiple.ref_diam;
set(handles.edit_ref_diam,'String',ref_diam);

%%%

try
    FS_ref_spl=Barrett_multiple.FS_ref_spl;
    set(handles.edit_ref_spl,'String',FS_ref_spl);
    
    ref_spl=Barrett_multiple.ref_spl;
    assignin('base',FS_ref_spl,ref_spl); 
catch
end
   
try
    FS_ref_psd=Barrett_multiple.FS_ref_psd;
    set(handles.edit_ref_psd,'String',FS_ref_psd);
    
    ref_psd=Barrett_multiple.ref_psd;
    assignin('base',FS_ref_psd,ref_psd); 
catch
end

    
%%%

try
    shell_name=Barrett_multiple.shell_name;
catch
end

try
    SPL_name=Barrett_multiple.SPL_name;
catch
end

try
    diam=Barrett_multiple.diam;  
catch
end

try
    smd=Barrett_multiple.smd;
catch
end

try
    PSD_name=Barrett_multiple.PSD_name;   
catch
end


%%%

try    
    
    N=num;
    
    for i = 1:N
        
        data_s{i,1}=shell_name{i};
        data_s{i,2}=SPL_name{i};
        
        data_s{i,3}=sprintf('%g',diam(i));
        data_s{i,4}=sprintf('%g',smd(i));
        
        data_s{i,5}=PSD_name{i};
    end
    
catch    
    
    disp('data_s unsuccessful');
end  


try
    set(handles.uitable_data,'Data',data_s);     
catch
    disp('set unsuccessful')
end    
    

try
    THM1=Barrett_multiple.THM1;
    assignin('base',SPL_name{1},THM1); 
catch
end
try
    THM2=Barrett_multiple.THM2;
    assignin('base',SPL_name{2},THM2); 
catch
end
try
    THM3=Barrett_multiple.THM3;
    assignin('base',SPL_name{3},THM3); 
catch
end
try
    THM4=Barrett_multiple.THM4;
    assignin('base',SPL_name{4},THM4); 
catch
end




% --- Executes on selection change in listbox_diam.
function listbox_diam_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_diam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_diam contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_diam

n=get(handles.listbox_diam,'Value');


set(handles.text_ref_diam,'Visible','off');
set(handles.text_diam_unit,'Visible','off');
set(handles.edit_ref_diam,'Visible','off');


if(n==2)
    set(handles.text_ref_diam,'Visible','on');
    set(handles.text_diam_unit,'Visible','on');
    set(handles.edit_ref_diam,'Visible','on');
end




% --- Executes during object creation, after setting all properties.
function listbox_diam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_diam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_diam_refer_Callback(hObject, eventdata, handles)
% hObject    handle to edit_diam_refer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_diam_refer as text
%        str2double(get(hObject,'String')) returns contents of edit_diam_refer as a double


% --- Executes during object creation, after setting all properties.
function edit_diam_refer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_diam_refer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_diam_new_Callback(hObject, eventdata, handles)
% hObject    handle to edit_diam_new (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_diam_new as text
%        str2double(get(hObject,'String')) returns contents of edit_diam_new as a double


% --- Executes during object creation, after setting all properties.
function edit_diam_new_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_diam_new (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ref_psd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ref_psd as text
%        str2double(get(hObject,'String')) returns contents of edit_ref_psd as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ref_psd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_psd_type.
function listbox5_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_psd_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_psd_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_psd_type


% --- Executes during object creation, after setting all properties.
function listbox5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_psd_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit_reference_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_reference_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_reference_mass as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_reference_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_diam.
function listbox7_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_diam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_diam contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_diam


% --- Executes during object creation, after setting all properties.
function listbox7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_diam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ref_diam_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ref_diam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ref_diam as text
%        str2double(get(hObject,'String')) returns contents of edit_ref_diam as a double


% --- Executes during object creation, after setting all properties.
function edit_ref_diam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ref_diam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_num.
function listbox_num_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num


Nrows=get(handles.listbox_num,'Value');
Ncolumns=5;


set(handles.uitable_data,'Data',cell(Nrows,Ncolumns));


% --- Executes during object creation, after setting all properties.
function listbox_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function get_table_data(hObject, eventdata, handles)

try
    
    A=char(get(handles.uitable_data,'Data'));

    N=get(handles.listbox_num,'Value');

    diam=zeros(N,1);
    smd=zeros(N,1);

    k=1;

    for i=1:N
        shell_name{i}=A(k,:); k=k+1;
        shell_name{i} = strtrim(shell_name{i});
    end

    for i=1:N
        SPL_name{i}=A(k,:); k=k+1;
        SPL_name{i} = strtrim(SPL_name{i});
    end

    for i=1:N
        diam(i)=str2double(A(k,:)); k=k+1;
    end

    for i=1:N
        smd(i)=str2double(A(k,:)); k=k+1;
    end

    for i=1:N
        PSD_name{i}=A(k,:); k=k+1;
        PSD_name{i} = strtrim(PSD_name{i});
    end


    setappdata(0,'shell_name',shell_name);
    setappdata(0,'SPL_name',SPL_name);
    setappdata(0,'diam',diam);
    setappdata(0,'smd',smd);
    setappdata(0,'PSD_name',PSD_name);    
    
catch
    warndlg('get table failed');
    return;
end

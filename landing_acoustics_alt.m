function varargout = landing_acoustics_alt(varargin)
% LANDING_ACOUSTICS_ALT MATLAB code for landing_acoustics_alt.fig
%      LANDING_ACOUSTICS_ALT, by itself, creates a new LANDING_ACOUSTICS_ALT or raises the existing
%      singleton*.
%
%      H = LANDING_ACOUSTICS_ALT returns the handle to a new LANDING_ACOUSTICS_ALT or the handle to
%      the existing singleton*.
%
%      LANDING_ACOUSTICS_ALT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LANDING_ACOUSTICS_ALT.M with the given input arguments.
%
%      LANDING_ACOUSTICS_ALT('Property','Value',...) creates a new LANDING_ACOUSTICS_ALT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before landing_acoustics_alt_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to landing_acoustics_alt_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help landing_acoustics_alt

% Last Modified by GUIDE v2.5 24-Sep-2019 10:40:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @landing_acoustics_alt_OpeningFcn, ...
                   'gui_OutputFcn',  @landing_acoustics_alt_OutputFcn, ...
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


% --- Executes just before landing_acoustics_alt is made visible.
function landing_acoustics_alt_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to landing_acoustics_alt (see VARARGIN)

% Choose default command line output for landing_acoustics_alt
handles.output = hObject;

listbox_engine_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes landing_acoustics_alt wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = landing_acoustics_alt_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_rhoC_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rhoC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rhoC as text
%        str2double(get(hObject,'String')) returns contents of edit_rhoC as a double


% --- Executes during object creation, after setting all properties.
function edit_rhoC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rhoC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_aceff_Callback(hObject, eventdata, handles)
% hObject    handle to edit_aceff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_aceff as text
%        str2double(get(hObject,'String')) returns contents of edit_aceff as a double


% --- Executes during object creation, after setting all properties.
function edit_aceff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_aceff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_engine.
function listbox_engine_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_engine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_engine contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_engine

n=get(handles.listbox_engine,'Value');

if(n==1)
    set(handles.edit_thrust,'String','15000');
    set(handles.edit_velox,'String','12000');
    set(handles.edit_diam,'String','25.6');    
end
if(n==2)
    set(handles.edit_thrust,'String','280572');
    set(handles.edit_velox,'String','10000');
    set(handles.edit_diam,'String','76');    
end
if(n==3)
    set(handles.edit_thrust,'String','');    
    set(handles.edit_velox,'String','');  
    set(handles.edit_diam,'String','');       
end

set(handles.pushbutton_save,'Enable','off');



% --- Executes during object creation, after setting all properties.
function listbox_engine_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_engine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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



function edit_thrust_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thrust (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thrust as text
%        str2double(get(hObject,'String')) returns contents of edit_thrust as a double


% --- Executes during object creation, after setting all properties.
function edit_thrust_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thrust (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(landing_acoustics);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * * * ');
disp(' ');

fig_num=1;

n=get(handles.listbox_engine,'Value');

if(n==1)
    disp(' BE-3 Touchdown ');
end

disp(' ');
disp(' Zero dB References');
disp(' Pressure: 20 microPa   ');
disp('Intensity: 1 pico W/m^2 ');
disp('    Power: 1 pico W     ');


F=str2num(get(handles.edit_thrust,'String'));
aceff=str2num(get(handles.edit_aceff,'String'));
ufdB=str2num(get(handles.edit_dB,'String'));

V=str2num(get(handles.edit_velox,'String'));
diam=str2num(get(handles.edit_diam,'String'));

rhoC=str2num(get(handles.edit_rhoC,'String'));

r=str2num(get(handles.edit_r,'String'));


ref  = 1.0e-12;
Iref = 1.0e-12;
Aref = 20.e-06;


m_per_ft = 0.3048;
m_per_inch = 0.3048/12.;
N_per_lbf = 4.448;

F=F*N_per_lbf;
V=V*m_per_ft;
r=r*m_per_inch;
diam=diam*m_per_inch;


WOA=0.5*aceff*F*V; 


LW=120 + 10*log10(WOA);

out1=sprintf('\n overall acoustic power WOA = %12.3g Watts ',WOA);
out2=sprintf('                            = %8.4g dB ',LW);

disp(out1);
disp(out2);


U=V;
de=diam;


setappdata(0,'ref',ref);
setappdata(0,'de',de);
setappdata(0,'U',U);   
setappdata(0,'LW',LW);

landing_step5(hObject, eventdata, handles);

freq=getappdata(0,'freq');
 Lwb=getappdata(0,'Lwb'); 

%%%

ilast=length(freq);
    
spl=zeros(ilast,1);
IdB=zeros(ilast,1);

    disp(' ');
    disp(' Sound Power, Intensity & Pressure ');
    disp(' ');    
    disp('   Freq(Hz)    Lwb(dB)      I(dB)     SPL(dB)');
       
    for i=1:ilast    
        
        P=10^(Lwb(i)/10);
        
        intens=ref*P/(2*pi*r^2);
        
        IdB(i)=10*log10(intens/Iref); 
        
        
% Crocker, Handbook of Noise and Vibration Control, page 67  
% See also:  NASA SP-8072 equation (9) 
% DI= 3 dB
        
        spl(i)=Lwb(i)-20*log10(r)+10*log10(2)-11 + 3;
        
        
        if(ufdB~=0)
            Lwb(i)=Lwb(i)+ufdB;
            IdB(i)=IdB(i)+ufdB;
            spl(i)=spl(i)+ufdB;             
        end
        
        out1=sprintf(' %8.1f\t %8.1f\t %8.1f\t %8.1f',freq(i),Lwb(i),IdB(i),spl(i));
        disp(out1);         
    end

    freq=fix_size(freq);
    
    f=freq;
    dB=spl;
    
    n_type=1;

    tstring=sprintf('Landing x=%g in',r/m_per_inch);
    
    [fig_num]=spl_plot_title(fig_num,n_type,f,dB,tstring);

    [oadb]=oaspl_function(spl(1:21));
    
    out1=sprintf('\n oaspl = %8.4g dB  up to 2000 Hz ',oadb);
    disp(out1);

    spl=[freq(1:21) spl(1:21)];    
    
    setappdata(0,'spl',spl);
    

    
        t_string=sprintf('Source One-Third Octave Sound Power Level \n Overall Level = %8.4g dB  Ref: 1 pico Watts ',LW); 
        t_string=strrep(t_string,'_',' ');       
        x_label='Frequency (Hz)';
        y_label='Lw (dB)';
        ppp=[freq Lwb];
        fmin=min(freq);
        fmax=max(freq);
        [fig_num,h2]=plot_loglin_function_h2_yfree(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);    
    
    
%%%

function landing_step5(hObject, ~, handles)

ntx=1;

   ref=getappdata(0,'ref');
    de=getappdata(0,'de');
     U=getappdata(0,'U');   
    LW=getappdata(0,'LW');
   
    
       qx=evalin('base','new_nrspl');  
       qx
 
       sn=qx(:,1);
    nrspl=qx(:,2);
 
    nrspl
    num=length(nrspl);
    

	for i=1:num
		nrspl(i)=ref* 10^(0.1*nrspl(i));
	end

	freq(1)=20.;
	freq(2)=25.;
	freq(3)=31.5;
	freq(4)=40.;
	freq(5)=50.;
	freq(6)=63.;
	freq(7)=80.;
	freq(8)=100.;
	freq(9)=125.;
	freq(10)=160.;
	freq(11)=200.;
	freq(12)=250.;
	freq(13)=315.;
	freq(14)=400.;
	freq(15)=500.;
	freq(16)=630.;
	freq(17)=800.;
	freq(18)=1000.;
	freq(19)=1250.;
	freq(20)=1600.;
	freq(21)=2000.;
	freq(22)=2500.;
	freq(23)=3150.;
	freq(24)=4000.;
	freq(25)=5000.;
	freq(26)=6300.;
	freq(27)=8000.;
	freq(28)=10000.;
	ilast = length(freq);
    
    amp=zeros(ilast,1);

    for i=1:ilast
    
        strouhal = freq(i)*de/U;
 
        for j=1:num-1
            
           if(strouhal<sn(1))
            
                amp(i)=nrspl(1);
 
                break;
            end
        
            if(strouhal==sn(j))
            
                amp(i)=nrspl(i);
 
                break;
            end
            if( strouhal>sn(j) && strouhal<sn(j+1) )    
 
                slope=log10(nrspl(j+1)/nrspl(j))/log10(sn(j+1)/sn(j));
 
                az=log10(nrspl(j));
                az=az+slope*(log10(strouhal)-log10(sn(j)));
 
                amp(i)=10^az;
                break;
            end
            if(strouhal>=sn(end))
                noct=log(strouhal/sn(end))/log(2);
                ndB=-12*noct;
                rr=10^(ndB/10);
                amp(i)=nrspl(end)*rr;
                break;
            end  
            
        end
 
    end 

    
    disp(' ref a');
    
    Lwb=zeros(ilast,1);
    
	for i=1:ilast   % Lwb = Sound Power Level
	
        df = ((2^(1/6))-1/(2^(1/6)))*freq(i);

		Lwb(i)= 10*log10(amp(i)/ref) +LW -10*log10(U/de) +10*log10(df);
        

%		printspl();
    end    

    [oadb]=oaspl_function(Lwb);
    
%    out1=sprintf('\n **** overall power = %8.4g dB \n',oadb);
%    disp(out1);
 

    LW=getappdata(0,'LW');
    
    diff=LW-oadb;
    

    
    Lwb=Lwb+diff;

    
    setappdata(0,'freq',freq);
    setappdata(0,'amp',amp);
    setappdata(0,'Lwb',Lwb); 
    
set(handles.pushbutton_save,'Enable','on');    


function edit_velox_Callback(hObject, eventdata, handles)
% hObject    handle to edit_velox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_velox as text
%        str2double(get(hObject,'String')) returns contents of edit_velox as a double


% --- Executes during object creation, after setting all properties.
function edit_velox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_velox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_diam_Callback(hObject, eventdata, handles)
% hObject    handle to edit_diam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_diam as text
%        str2double(get(hObject,'String')) returns contents of edit_diam as a double


% --- Executes during object creation, after setting all properties.
function edit_diam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_diam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_r_Callback(hObject, eventdata, handles)
% hObject    handle to edit_r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_r as text
%        str2double(get(hObject,'String')) returns contents of edit_r as a double


% --- Executes during object creation, after setting all properties.
function edit_r_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_r (see GCBO)
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


data=getappdata(0,'spl');

output_name=get(handles.edit_output_name,'String');
assignin('base', output_name,data);

msgbox('Save Complete'); 
 


function edit_output_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_name as text
%        str2double(get(hObject,'String')) returns contents of edit_output_name as a double


% --- Executes during object creation, after setting all properties.
function edit_output_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_r and none of its controls.
function edit_r_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_r (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_save,'Enable','off'); 


% --- Executes on key press with focus on edit_dB and none of its controls.
function edit_dB_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_dB (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_save,'Enable','off'); 


% --- Executes on key press with focus on edit_aceff and none of its controls.
function edit_aceff_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_aceff (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_save,'Enable','off'); 


% --- Executes on key press with focus on edit_diam and none of its controls.
function edit_diam_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_diam (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_save,'Enable','off'); 


% --- Executes on key press with focus on edit_thrust and none of its controls.
function edit_thrust_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_thrust (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_save,'Enable','off'); 


% --- Executes on key press with focus on edit_velox and none of its controls.
function edit_velox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_velox (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_save,'Enable','off'); 


% --- Executes on key press with focus on edit_rhoC and none of its controls.
function edit_rhoC_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_rhoC (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_save,'Enable','off'); 


% --- Executes on button press in pushbutton_save_model.
function pushbutton_save_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    ne=get(handles.listbox_engine,'Value');
    LandingSettings.ne=ne;
catch  
end

try
    aceff=get(handles.edit_aceff,'String');
    LandingSettings.aceff=aceff;
catch  
end

try
    rhoC=get(handles.edit_rhoC,'String');
    LandingSettings.rhoC=rhoC;
catch  
end

try
    dB=get(handles.edit_dB,'String');
    LandingSettings.dB=dB;
catch  
end

try
    thrust=get(handles.edit_thrust,'String');
    LandingSettings.thrust=thrust;
catch  
end

try
    velox=get(handles.edit_velox,'String');
    LandingSettings.velox=velox;
catch  
end

try
    diam=get(handles.edit_diam,'String');
    LandingSettings.diam=diam;
catch  
end

try
    r=get(handles.edit_r,'String');
    LandingSettings.r=r;
catch  
end

try
    output_name=get(handles.edit_output_name,'String');
    LandingSettings.output_name=output_name;
catch  
end


% % %
 
structnames = fieldnames(LandingSettings, '-full'); % fields in the struct
 
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);
 
    try
 
        save(elk, 'LandingSettings'); 
 
    catch
        warndlg('Save error');
        return;
    end


% --- Executes on button press in pushbutton_load_model.
function pushbutton_load_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  disp(' ref 1');
 
[filename, pathname] = uigetfile('*.mat');
 
NAME = [pathname,filename];
 
struct=load(NAME);
structnames = fieldnames(struct, '-full'); % fields in the struct
 
%  disp(' ref 2');
 
k=length(structnames);
 
for i=1:k
    namevar=strcat('struct.',structnames{i});
    value=eval(namevar);
    assignin('base',structnames{i},value);
end
 
%  disp(' ref 3');
 
structnames
 
 
% struct
 
try
    LandingSettings=evalin('base','LandingSettings');
catch
    warndlg(' evalin failed ');
    return;
end
 
LandingSettings
 
%


try
    ne=LandingSettings.ne; 
    set(handles.listbox_engine,'Value',ne);
catch  
end

try
    aceff=get(handles.edit_aceff,'String');
    LandingSettings.aceff=aceff;
catch  
end

try
    rhoC=LandingSettings.rhoC; 
    set(handles.edit_rhoC,'String',rhoC);

catch  
end

try
    dB=get(handles.edit_dB,'String');
    LandingSettings.dB=dB;
catch  
end

try
    thrust=LandingSettings.thrust;    
    set(handles.edit_thrust,'String',thrust);
catch  
end

try
    velox=LandingSettings.velox;    
    set(handles.edit_velox,'String',velox);
catch  
end

try
    diam=LandingSettings.diam;    
    set(handles.edit_diam,'String',diam);
catch  
end

try
    r=LandingSettings.r;    
    set(handles.edit_r,'String',r);
catch  
end

try
    output_name=LandingSettings.output_name;    
    set(handles.edit_output_name,'String',output_name);
catch  
end

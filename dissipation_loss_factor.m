function varargout = dissipation_loss_factor(varargin)
% DISSIPATION_LOSS_FACTOR MATLAB code for dissipation_loss_factor.fig
%      DISSIPATION_LOSS_FACTOR, by itself, creates a new DISSIPATION_LOSS_FACTOR or raises the existing
%      singleton*.
%
%      H = DISSIPATION_LOSS_FACTOR returns the handle to a new DISSIPATION_LOSS_FACTOR or the handle to
%      the existing singleton*.
%
%      DISSIPATION_LOSS_FACTOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DISSIPATION_LOSS_FACTOR.M with the given input arguments.
%
%      DISSIPATION_LOSS_FACTOR('Property','Value',...) creates a new DISSIPATION_LOSS_FACTOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dissipation_loss_factor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dissipation_loss_factor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dissipation_loss_factor

% Last Modified by GUIDE v2.5 31-Dec-2015 09:45:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dissipation_loss_factor_OpeningFcn, ...
                   'gui_OutputFcn',  @dissipation_loss_factor_OutputFcn, ...
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


% --- Executes just before dissipation_loss_factor is made visible.
function dissipation_loss_factor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dissipation_loss_factor (see VARARGIN)

% Choose default command line output for dissipation_loss_factor
handles.output = hObject;

change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dissipation_loss_factor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dissipation_loss_factor_OutputFcn(hObject, eventdata, handles) 
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

delete(dissipation_loss_factor);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('  ');
disp(' * * * * * *');
disp('  ');

n=get(handles.listbox_type,'value');
nbands=get(handles.listbox_bands,'value');


if(nbands==1)    
    
    Sfreq = get(handles.edit_frequency, 'String');
    if isempty(Sfreq)
        warndlg('Enter Frequency');  
        return;
    else
        fc=str2num(Sfreq);  
    end
    
    
    f=fc;
    imax=1;
else    
    bw=get(handles.listbox_bandwidth,'Value');    
    if(bw==1)
        [~,fc,~,NL,fmin,fmax]=SEA_one_third_octave_frequencies_max_min();
    else
        [fl,fc,fu,imax]=SEA_full_octave_frequencies();
    end
    f=fc;
    imax=length(fc);
end

    
if(n==1)  % Plate
    
    stitle='Plate Dissipation Loss Factor';
        
    lf=zeros(imax,1);
    
    for i=1:imax
                     
        [lf(i)]=plate_dissipation_loss_factor(f(i));

    end
    
end
if(n==2)  % Sandwich Panel, Bare
    
    stitle='Sandwich Panel, Bare, Dissipation Loss Factor';        
    
    for i=1:imax
        [lf(i)]=sandwich_panel_bare_lf(f(i));
    end
    
end
if(n==3)  % Sandwich Panel, Built-up  
    
    stitle='Sandwich Panel with Equipment Dissipation Loss Factor';
    
    for i=1:imax
        [lf(i)]=sandwich_panel_built_up_lf(f(i));
    end         
    
end
if(n==4)  % Stowed Solar Array
    
    stitle='Stowed Solar Array Dissipation Loss Factor';

    
    fp=250;
    
    for i=1:imax

            if(f(i)<=fp)
                lf(i)=0.05;
            else
                lf(i)=0.050*(fp/f(i));
            end

    end    
end
if(n==5)  % Cylinder
    
    stitle='Cylinder Dissipation Loss Factor Estimate';
    
    k=1;
    
    fp=3000;
    
    f=fc;
    
    lf_low=zeros(imax,1);
    lf_high=zeros(imax,1);
    
    for i=1:imax
            
            if(f(i)<=fp)
                lf_low(i) =0.002;
                lf_high(i)=0.03;                
            else
                lf_low(i) =0.004;
                lf_high(i)=0.006;                     
            end
            
    end        

    
end

if(n==6)  % Acoustic Room
   
    stitle='Acoustic Room Loss Factor Estimate';
    
    if(nbands==1)
        
        fr=fc;
        tr=str2num(get(handles.edit_rt,'String'));

        loss_factor=2.2/(fr*tr);
    
        lf(1)=loss_factor;
    
    else
        
        try
            FS=get(handles.edit_input_array,'String');
            THM=evalin('base',FS);  

        catch  
            warndlg('Input Array does not exist.  Try again.')
            return;
        end

        sz=size(THM);

        if(sz(2)~=2)
            warndlg('Input array must have 2 columns');  
            return; 
        end

        f=THM(:,1);
        rt=THM(:,2);
        
        NL=length(f);
        
        lf=zeros(NL,1);
        
        for i=1:NL
            lf(i)=2.2/(f(i)*rt(i));
        end
        
    end
    
end

disp('   '); 
disp(stitle);
disp('   '); 

if(n~=5)
    disp(' Freq   Dissipation ');
    disp(' (Hz)   Loss Factor ');
    disp('   ');    
            
    for i=1:length(f)
        out1=sprintf(' %6.0f  %8.4g',f(i),lf(i));
        disp(out1);
    end      
    
else  % cylinder
        
    disp(' Freq        Dissipation Loss Factor ');
    disp(' (Hz)        Min       Max');    
            
    for i=1:length(f)
        out1=sprintf(' %6.0f  %8.4g  %8.4g',f(i),lf_low(i),lf_high(i));
        disp(out1);
    end      
    
end


if(nbands==2)    
    
    figure(1);
    
    if(n~=5)
        plot(f,lf);
        
        ymin=10^(floor(log10(min(lf))));
        ymax=10^(ceil(log10(max(lf))));
    
    end
    if(n==5) % cylinder
        plot(f,lf_high,f,lf_low);
        legend('high','low');
        
        ymin=10^(floor(log10(min(lf_low))));
        ymax=10^(ceil(log10(max(lf_high))));           
        
    end    
    
    
    title(stitle);
    xlabel('Frequency (Hz)');
    ylabel('Loss Factor');

	fmin=min(f);
	fmax=max(f);
    
    [xtt,xTT,iflag]=xtick_label(fmin,fmax);
 
    if(iflag==1)
        set(gca,'xtick',xtt);
        set(gca,'XTickLabel',xTT);
    end
    
    xlim([10,20000]);
    
    [xtt,xTT,iflag]=xtick_label(fmin,fmax);
   
    
    if(iflag==1)
        set(gca,'xtick',xtt);
        set(gca,'XTickLabel',xTT);
        xlim([min(xtt),max(xtt)]);
    end    
    
    ylim([ ymin,ymax]);
    
    set(gca,'XGrid','on','GridLineStyle',':');
    set(gca,'YGrid','on','GridLineStyle',':');    
    
    set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');   
                 
                     
    f=fix_size(f);
    
    if(n~=5)
    
        lf=fix_size(lf);
    
        loss_factor=[f lf];
    
        disp(' ');
        disp(' Dissipation Loss Factor array saved to:  loss_factor ');
        assignin('base', 'loss_factor', loss_factor); 
 
    end
    if(n==5)
    
        lf_low =fix_size(lf_low);
        lf_high=fix_size(lf_high);
        
        loss_factor_low= [f lf_low];
        loss_factor_high=[f lf_high];    
        
        disp(' ');
        disp(' Dissipation Loss Factor arrays saved to:  loss_factor_low & loss_factor_high ');
        assignin('base', 'loss_factor_low', loss_factor_low); 
        assignin('base', 'loss_factor_high', loss_factor_high); 
        
    end    
        
end

msgbox('Results written to Command Window');


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type

change(hObject, eventdata, handles);


function change(hObject, eventdata, handles)
%
n=get(handles.listbox_type,'value');
nbands=get(handles.listbox_bands,'value');

set(handles.listbox_bandwidth,'visible','off'); 
set(handles.text_bandwidth,'visible','off'); 

set(handles.text_a1,'visible','off');
set(handles.text_a2,'visible','off');
set(handles.text_a3,'visible','off');
set(handles.edit_input_array,'visible','off');

set(handles.text_rt,'visible','off');
set(handles.edit_rt,'visible','off');   

set(handles.text_frequency,'visible','off');
set(handles.edit_frequency,'visible','off');  


if(nbands==1)
    set(handles.text_frequency,'visible','on');
    set(handles.edit_frequency,'visible','on');    
    
    if(n==6) % aco

        set(handles.text_rt,'visible','on');
        set(handles.edit_rt,'visible','on');    
    end
    
else    
    set(handles.listbox_bandwidth,'visible','on'); 
    set(handles.text_bandwidth,'visible','on');
    
    if(n==6) % aco
    
        set(handles.listbox_bandwidth,'visible','off'); 
        set(handles.text_bandwidth,'visible','off');   
   
        set(handles.text_frequency,'visible','off');
        set(handles.edit_frequency,'visible','off');
        set(handles.text_rt,'visible','off');
        set(handles.edit_rt,'visible','off');      
        
        set(handles.text_a1,'visible','on');
        set(handles.text_a2,'visible','on');
        set(handles.text_a3,'visible','on');
        set(handles.edit_input_array,'visible','on');
        
        
    end    
        
end




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


% --- Executes on selection change in listbox_bandwidth.
function listbox_bandwidth_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_bandwidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_bandwidth contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_bandwidth


% --- Executes during object creation, after setting all properties.
function listbox_bandwidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_bandwidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to edit_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_frequency as text
%        str2double(get(hObject,'String')) returns contents of edit_frequency as a double


% --- Executes during object creation, after setting all properties.
function edit_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_rt_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rt as text
%        str2double(get(hObject,'String')) returns contents of edit_rt as a double


% --- Executes during object creation, after setting all properties.
function edit_rt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_lf_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lf as text
%        str2double(get(hObject,'String')) returns contents of edit_lf as a double


% --- Executes during object creation, after setting all properties.
function edit_lf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_lf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_frequency and none of its controls.
function edit_frequency_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_frequency (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on edit_rt and none of its controls.
function edit_rt_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_rt (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in pushbutton_eq.
function pushbutton_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_type,'value');

if(n==1)
    A = imread('plate_lf.jpg');
    figure(994) 
    imshow(A,'border','tight','InitialMagnification',100)      
end
if(n==2 || n==3)
    A = imread('sandwich_lf.jpg');
    figure(995) 
    imshow(A,'border','tight','InitialMagnification',100)           
end
if(n==4)
    A = imread('stowed_solar_array_lf.jpg');
    figure(997) 
    imshow(A,'border','tight','InitialMagnification',100)      
end
if(n==5)
    A = imread('cylinder_lf.jpg');
    figure(998) 
    imshow(A,'border','tight','InitialMagnification',100)      
end
if(n==6)
    A = imread('acoustic_room_lf.jpg');
    figure(999) 
    imshow(A,'border','tight','InitialMagnification',100)      
end


% --- Executes on selection change in listbox_bands.
function listbox_bands_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_bands (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_bands contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_bands
change(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_bands_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_bands (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
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

function varargout = internal_loss_factor(varargin)
% INTERNAL_LOSS_FACTOR MATLAB code for internal_loss_factor.fig
%      INTERNAL_LOSS_FACTOR, by itself, creates a new INTERNAL_LOSS_FACTOR or raises the existing
%      singleton*.
%
%      H = INTERNAL_LOSS_FACTOR returns the handle to a new INTERNAL_LOSS_FACTOR or the handle to
%      the existing singleton*.
%
%      INTERNAL_LOSS_FACTOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERNAL_LOSS_FACTOR.M with the given input arguments.
%
%      INTERNAL_LOSS_FACTOR('Property','Value',...) creates a new INTERNAL_LOSS_FACTOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before internal_loss_factor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to internal_loss_factor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help internal_loss_factor

% Last Modified by GUIDE v2.5 18-Dec-2015 12:14:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @internal_loss_factor_OpeningFcn, ...
                   'gui_OutputFcn',  @internal_loss_factor_OutputFcn, ...
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


% --- Executes just before internal_loss_factor is made visible.
function internal_loss_factor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to internal_loss_factor (see VARARGIN)

% Choose default command line output for internal_loss_factor
handles.output = hObject;

listbox_type_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes internal_loss_factor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = internal_loss_factor_OutputFcn(hObject, eventdata, handles) 
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

delete(internal_loss_factor);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('  ');
disp(' * * * * * *');
disp('  ');

n=get(handles.listbox_type,'value');


kflag=0;

if(n==1 || n==2 || n==3 || n==4 || n==5 )
    kflag=1;
end
    
if(kflag==1 || n==6 || n==7)
    bw=get(handles.listbox_band,'Value');    
    if(bw==1)
        [fl,fc,fu,imax]=one_third_octave_frequencies();
    else
        [fl,fc,fu,imax]=full_octave_frequencies();
    end
end

k=1;
    
if(n==1)  % Plate
    
    stitle='Plate Internal Loss Factor';
        
    fp=2500;
    
    for i=1:imax
        if(fc(i)>=10)
            
            f(k)=fc(i);
            
            if(f(k)<=80)
                lf(k)=0.05;
            end    
            if(f(k)>80 && f(k)<fp)
                lf(k)=1.8/(f(k)^0.87);
            end
            if(f(k)>=fp)
                lf(k)=0.002;
            end
            
            k=k+1;
        end
    end
    
end
if(n==2)  % Sandwich Panel, Bare
    
    stitle='Sandwich Panel, Bare, Loss Factor';    
    
    for i=1:imax
        if(fc(i)>=10)
            
            f(k)=fc(i);
            
            lf(k)=0.3/(f(k)^0.63);

            k=k+1;
        end
    end    
    
end
if(n==3)  % Sandwich Panel, Built-up  
    
    stitle='Sandwich Panel with Equipment Loss Factor';
    
    k=1;
    
    fp=500;
    
    for i=1:imax
        if(fc(i)>=10)
            
            f(k)=fc(i);
            
            if(f(k)<=fp)
                lf(k)=0.05;
            else
                lf(k)=0.050*sqrt(fp/f(k));
            end

            
            k=k+1;
        end
    end        
    
end
if(n==4)  % Stowed Solar Array
    
    stitle='Stowed Solar Array Loss Factor';
    
    k=1;
    
    fp=250;
    
    for i=1:imax
        if(fc(i)>=10)
            
            f(k)=fc(i);
            
            if(f(k)<=fp)
                lf(k)=0.05;
            else
                lf(k)=0.050*(fp/f(k));
            end

            
            k=k+1;
        end
    end    
end
if(n==5)  % Cylinder
    
    stitle='Cylinder Loss Factor';
    
    k=1;
    
    fp=3000;
    
    for i=1:imax
        if(fc(i)>=10)
            
            f(k)=fc(i);
            
            if(f(k)<=fp)
                lf_low(k) =0.002;
                lf_high(k)=0.03;                
            else
                lf_low(k) =0.004;
                lf_high(k)=0.006;                     
            end

            
            k=k+1;
        end
    end        
    
    kflag=2;
    
end

if(n==6)  % Acoustic Room
    
    set(handles.uipanel_results,'visible','on');
    
    fr=str2num(get(handles.edit_frequency,'String'));
    tr=str2num(get(handles.edit_rt,'String'));

    loss_factor=2.2/(fr*tr);
    
    out1=sprintf('\n Frequency = %8.4g Hz',fr);
    disp(out1);
    
    out1=sprintf('\n Reverberation Time = %8.4g sec',tr);
    disp(out1);    
    
    out1=sprintf('\n loss factor = %8.4g ',loss_factor);
    disp(out1);
    
    ss=sprintf('%8.4g',loss_factor);
    set(handles.edit_lf,'String',ss);
    
end


if(kflag==1 || kflag==2)
    

    figure(1);
    
    if(kflag==1)
        plot(f,lf);
        
        ymin=10^(floor(log10(min(lf))));
        ymax=10^(ceil(log10(max(lf))));

        
        disp(' Freq(Hz)  Loss Factor ');
        disp('   ');    
            
        for i=1:length(f)
            out1=sprintf(' %6.0f  %8.4g',f(i),lf(i));
            disp(out1);
        end            
    
    end
    if(kflag==2)
        plot(f,lf_high,f,lf_low);
        legend('high','low');
        
        ymin=10^(floor(log10(min(lf_low))));
        ymax=10^(ceil(log10(max(lf_high))));   
        
        
        disp(' Freq        Loss Factor ');
        disp(' (Hz)        Min       Max');    
            
        for i=1:length(f)
            out1=sprintf(' %6.0f  %8.4g  %8.4g',f(i),lf_low(i),lf_high(i));
            disp(out1);
        end          
        
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
    ylim([ ymin,ymax]);
    
    set(gca,'XGrid','on','GridLineStyle',':');
    set(gca,'YGrid','on','GridLineStyle',':');    
    
    set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');   
                 
                 
    
    f=fix_size(f);
    
    if(kflag==1)
    
        lf=fix_size(lf);
    
        loss_factor=[f lf];
    
        disp(' ');
        disp(' Internal Loss Factor array saved to:  loss_factor ');
        assignin('base', 'loss_factor', loss_factor); 
 
    end
    if(kflag==2)
    
        lf_low =fix_size(lf_low);
        lf_high=fix_size(lf_high);
        
        loss_factor_low= [f lf_low];
        loss_factor_high=[f lf_high];    
        
        disp(' ');
        disp(' Internal Loss Factor arrays saved to:  loss_factor_low & loss_factor_high ');
        assignin('base', 'loss_factor_low', loss_factor_low); 
        assignin('base', 'loss_factor_high', loss_factor_high); 
        
    end    
    
    msgbox('Results written to Command Window');
    
end



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

n=get(handles.listbox_type,'value');

set(handles.listbox_band,'visible','on'); 
set(handles.text_band,'visible','on'); 

set(handles.text_frequency,'visible','off');
set(handles.edit_frequency,'visible','off');
set(handles.text_rt,'visible','off');
set(handles.edit_rt,'visible','off');

set(handles.uipanel_results,'visible','off');


if(n==6)
    set(handles.listbox_band,'visible','off'); 
    set(handles.text_band,'visible','off');   
   
    set(handles.text_frequency,'visible','on');
    set(handles.edit_frequency,'visible','on');
    set(handles.text_rt,'visible','on');
    set(handles.edit_rt,'visible','on');   
    
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


% --- Executes on selection change in listbox_band.
function listbox_band_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_band (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_band contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_band


% --- Executes during object creation, after setting all properties.
function listbox_band_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_band (see GCBO)
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
set(handles.uipanel_results,'visible','off');


% --- Executes on key press with focus on edit_rt and none of its controls.
function edit_rt_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_rt (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'visible','off');


% --- Executes on button press in pushbutton_eq.
function pushbutton_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_type,'value');

if(n==1)
    A = imread('  .jpg');
    figure(994) 
    imshow(A,'border','tight','InitialMagnification',100)
end
if(n==2)
    A = imread('  .jpg');
    figure(995) 
    imshow(A,'border','tight','InitialMagnification',100)
end
if(n==3)
    A = imread('  .jpg');
    figure(996) 
    imshow(A,'border','tight','InitialMagnification',100)
end
if(n==4)
    A = imread('  .jpg');
    figure(997) 
    imshow(A,'border','tight','InitialMagnification',100)
end
if(n==5)
    A = imread('  .jpg');
    figure(998) 
    imshow(A,'border','tight','InitialMagnification',100)
end
if(n==6)
    A = imread('  .jpg');
    figure(999) 
    imshow(A,'border','tight','InitialMagnification',100)
end

    

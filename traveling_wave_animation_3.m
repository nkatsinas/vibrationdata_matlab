function varargout = traveling_wave_animation_3(varargin)
% TRAVELING_WAVE_ANIMATION_3 MATLAB code for traveling_wave_animation_3.fig
%      TRAVELING_WAVE_ANIMATION_3, by itself, creates a new TRAVELING_WAVE_ANIMATION_3 or raises the existing
%      singleton*.
%
%      H = TRAVELING_WAVE_ANIMATION_3 returns the handle to a new TRAVELING_WAVE_ANIMATION_3 or the handle to
%      the existing singleton*.
%
%      TRAVELING_WAVE_ANIMATION_3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRAVELING_WAVE_ANIMATION_3.M with the given input arguments.
%
%      TRAVELING_WAVE_ANIMATION_3('Property','Value',...) creates a new TRAVELING_WAVE_ANIMATION_3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before traveling_wave_animation_3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to traveling_wave_animation_3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help traveling_wave_animation_3

% Last Modified by GUIDE v2.5 14-Nov-2018 15:50:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @traveling_wave_animation_3_OpeningFcn, ...
                   'gui_OutputFcn',  @traveling_wave_animation_3_OutputFcn, ...
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


% --- Executes just before traveling_wave_animation_3 is made visible.
function traveling_wave_animation_3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to traveling_wave_animation_3 (see VARARGIN)

% Choose default command line output for traveling_wave_animation_3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes traveling_wave_animation_3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = traveling_wave_animation_3_OutputFcn(hObject, eventdata, handles) 
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



% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tpi=2*pi;

maxL=str2num(get(handles.edit_maxL,'String'));
 dur=str2num(get(handles.edit_dur,'String'));
 
  f1=str2num(get(handles.edit_f1,'String'));
  f2=str2num(get(handles.edit_f2,'String'));
  
  
  if(f1==f2)
      warndlg('Frequencies must be different.');
      return;
  end
  
  
  c1=str2num(get(handles.edit_c1,'String'));
  c2=str2num(get(handles.edit_c2,'String'));  
  
df=f2-f1;
domega=tpi*df;


a1=1;
a2=1;

omega1=tpi*f1;
k1=omega1/c1;

omega2=tpi*f2;
k2=omega2/c2;

dk=k2-k1;

out1=sprintf('     k2=%8.4g  k1=%8.4g  ',k2,k1);
disp(out1);
out1=sprintf(' domega=%8.4g  dk=%8.4g  ',domega,dk);
disp(out1);

cg= domega/dk;

ss=sprintf('%8.4g',cg);
set(handles.edit_cg,'String',ss);

fmax=max([f1 f2]);

sr=32*fmax;

dt=1/sr;

title_string=sprintf('Frequencies: f1=%g  f2=%g \n Velocities: c1=%g  c2=%g  cg=%6.3g',f1,f2,c1,c2,cg);

%%%%

figure(100);
axis([0 maxL -1 1])
xc = linspace(0,maxL,10000);
nx=length(xc);

y=zeros(nx,1);


filename=get(handles.edit_output_array,'String');

out_file=sprintf('%s.avi',filename);

v = VideoWriter(out_file);
open(v);


i=0;

tic;

while(1)
    
    tt=i*dt;
    i=i+1;
    
    for j = 1:nx
        x = xc(j);
        y(j) = a1*sin(k1*x-omega1*tt)+a2*sin(k2*x-omega2*tt);
    end

    xx = c1*tt;
    yy = a1*sin(k1*xx-omega1*tt)+a2*sin(k2*xx-omega2*tt);
    
    xxx=cg*tt;
    yyy = a1*sin(k1*xxx-omega1*tt)+a2*sin(k2*xxx-omega2*tt);    
    
    plot(xc,y,xx,yy,'-o',xxx,yyy,'bo');
    title('Phase Speed =  Group Speed'); 
    ylabel('Amplitude');
    xlabel('Distance');
    title(title_string);
    ylim([-4 4]);
    
    drawnow;
    
    if(i==1)
        set(gca,'nextplot','replacechildren');
    else    
        try
         frame = getframe(gcf);
         writeVideo(v,frame);
        catch
        end
    end
  
    elapsedTime = toc;
    
    if(elapsedTime >= dur)
        break;
    end
    
end
i

close(v);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


i=1;
figure(1);

    tt=i*dt;
  
    for j = 1:nx
        x = xc(j);
        y(j) = a1*sin(k1*x-omega1*tt)+a2*sin(k2*x-omega2*tt);
    end

    xx = c1*tt;
    yy = a1*sin(k1*xx-omega1*tt)+a2*sin(k2*xx-omega2*tt);
    
    xxx=cg*tt;
    yyy = a1*sin(k1*xxx-omega1*tt)+a2*sin(k2*xxx-omega2*tt);    
    
    plot(xc,y,xx,yy,'-o',xxx,yyy,'bo');
    title_string=sprintf('Frequencies: f1=%g  f2=%g \n Velocities: c1=%g  c2=%g  cg=%6.3g  Time=%6.3g',f1,f2,c1,c2,cg,tt);
    ylabel('Amplitude');
    xlabel('Distance');
    title(title_string);
    ylim([-4 4]);
    
    xc1=xc;
    y1=y;
    xx1=xx;
    yy1=yy;
    xxx1=xxx;
    yyy1=yyy;
    

ix=130
    
i=ix;
figure(2);

    tt=i*dt;
  
    for j = 1:nx
        x = xc(j);
        y(j) = a1*sin(k1*x-omega1*tt)+a2*sin(k2*x-omega2*tt);
    end

    xx = c1*tt;
    yy = a1*sin(k1*xx-omega1*tt)+a2*sin(k2*xx-omega2*tt);
    
    xxx=cg*tt;
    yyy = a1*sin(k1*xxx-omega1*tt)+a2*sin(k2*xxx-omega2*tt);    
    
    plot(xc,y,xx,yy,'-o',xxx,yyy,'bo');
    title_string=sprintf('Frequencies: f1=%g  f2=%g \n Velocities: c1=%g  c2=%g  cg=%6.3g  Time=%6.3g',f1,f2,c1,c2,cg,tt);
    ylabel('Amplitude');
    xlabel('Distance');
    title(title_string);
    ylim([-4 4]);
    
    
    xc2=xc;
    y2=y;
    xx2=xx;
    yy2=yy;
    xxx2=xxx;
    yyy2=yyy;
    
    

i=2*ix;
figure(3);

    tt=i*dt;
  
    for j = 1:nx
        x = xc(j);
        y(j) = a1*sin(k1*x-omega1*tt)+a2*sin(k2*x-omega2*tt);
    end

    xx = c1*tt;
    yy = a1*sin(k1*xx-omega1*tt)+a2*sin(k2*xx-omega2*tt);
    
    xxx=cg*tt;
    yyy = a1*sin(k1*xxx-omega1*tt)+a2*sin(k2*xxx-omega2*tt);    
    
    plot(xc,y,xx,yy,'-o',xxx,yyy,'bo');
    title_string=sprintf('Frequencies: f1=%g  f2=%g \n Velocities: c1=%g  c2=%g  cg=%6.3g  Time=%6.3g',f1,f2,c1,c2,cg,tt);
    ylabel('Amplitude');
    xlabel('Distance');
    title(title_string);
    ylim([-4 4]);
    

    
    xc3=xc;
    y3=y;
    xx3=xx;
    yy3=yy;
    xxx3=xxx;
    yyy3=yyy;
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(20);

subplot(3,1,1);
plot(xc1,y1,xx1,yy1,'-o',xxx1,yyy1,'bo');
title('Traveling Bending Wave Packet Simulation');
ylabel('Amplitude');
ylim([-4 4]);
    
subplot(3,1,2);
plot(xc2,y2,xx2,yy2,'-o',xxx2,yyy2,'bo');
ylabel('Amplitude');
ylim([-4 4]);

subplot(3,1,3);
plot(xc3,y3,xx3,yy3,'-o',xxx3,yyy3,'bo');
ylabel('Amplitude');
ylim([-4 4]);

xlabel('Distance');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function edit_maxL_Callback(hObject, eventdata, handles)
% hObject    handle to edit_maxL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_maxL as text
%        str2double(get(hObject,'String')) returns contents of edit_maxL as a double


% --- Executes during object creation, after setting all properties.
function edit_maxL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_maxL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_c1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_c1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_c1 as text
%        str2double(get(hObject,'String')) returns contents of edit_c1 as a double


% --- Executes during object creation, after setting all properties.
function edit_c1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_c1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dur_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dur as text
%        str2double(get(hObject,'String')) returns contents of edit_dur as a double


% --- Executes during object creation, after setting all properties.
function edit_dur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_f1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_f1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_f1 as text
%        str2double(get(hObject,'String')) returns contents of edit_f1 as a double


% --- Executes during object creation, after setting all properties.
function edit_f1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_f1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_f2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_f2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_f2 as text
%        str2double(get(hObject,'String')) returns contents of edit_f2 as a double


% --- Executes during object creation, after setting all properties.
function edit_f2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_f2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_c2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_c2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_c2 as text
%        str2double(get(hObject,'String')) returns contents of edit_c2 as a double


% --- Executes during object creation, after setting all properties.
function edit_c2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_c2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_c1 and none of its controls.
function edit_c1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_c1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.edit_cg,'String',' ');


% --- Executes on key press with focus on edit_c2 and none of its controls.
function edit_c2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_c2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_cg,'String',' ');


% --- Executes on key press with focus on edit_f1 and none of its controls.
function edit_f1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_f1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_cg,'String',' ');


% --- Executes on key press with focus on edit_f2 and none of its controls.
function edit_f2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_f2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_cg,'String',' ');



function edit_cg_Callback(hObject, eventdata, handles)
% hObject    handle to edit_cg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_cg as text
%        str2double(get(hObject,'String')) returns contents of edit_cg as a double


% --- Executes during object creation, after setting all properties.
function edit_cg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_cg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on button press in pushbutton_bwave.
function pushbutton_bwave_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_bwave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

  f1=str2num(get(handles.edit_f1,'String'));
  f2=str2num(get(handles.edit_f2,'String'));
  
  
  if(f1==f2)
      warndlg('Frequencies must be different.');
      return;
  end
  
  
  c1=str2num(get(handles.edit_c1,'String'));
  c2=str2num(get(handles.edit_c2,'String'));  
  
  c2=2*c1*f2/(f1+f2);

ss=sprintf('%9.6g',c2);
set(handles.edit_c2,'String',ss);

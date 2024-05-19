function varargout = vibrationdata_panel_flutter(varargin)
% VIBRATIONDATA_PANEL_FLUTTER MATLAB code for vibrationdata_panel_flutter.fig
%      VIBRATIONDATA_PANEL_FLUTTER, by itself, creates a new VIBRATIONDATA_PANEL_FLUTTER or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_PANEL_FLUTTER returns the handle to a new VIBRATIONDATA_PANEL_FLUTTER or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_PANEL_FLUTTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_PANEL_FLUTTER.M with the given input arguments.
%
%      VIBRATIONDATA_PANEL_FLUTTER('Property','Value',...) creates a new VIBRATIONDATA_PANEL_FLUTTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_panel_flutter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_panel_flutter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_panel_flutter

% Last Modified by GUIDE v2.5 26-May-2017 13:14:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_panel_flutter_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_panel_flutter_OutputFcn, ...
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


% --- Executes just before vibrationdata_panel_flutter is made visible.
function vibrationdata_panel_flutter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_panel_flutter (see VARARGIN)

% Choose default command line output for vibrationdata_panel_flutter
handles.output = hObject;

change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_panel_flutter wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function change(hObject, eventdata, handles)
%

n=get(handles.listbox_units,'Value');

m=get(handles.listbox_material,'Value');


if(n==1)
    set(handles.text_em,'String','Elastic Modulus (psi)');
    set(handles.text_q,'String','Dynamic Pressure (psf)');   
    set(handles.text_L,'String','Length (in)');
    set(handles.text_W,'String','Width (in)');
    set(handles.text_T,'String','Thickness (in)');    
else
    set(handles.text_em,'String','Elastic Modulus (GPa)'); 
    set(handles.text_q,'String','Dynamic Pressure (MPa)');
    set(handles.text_L,'String','Length (m)');
    set(handles.text_W,'String','Width (m)');
    set(handles.text_T,'String','Thickness (mm)');       
end

%%%%%%%%%%%%%%%%


if(n==1)  % English
    if(m==1) % aluminum
        E=1e+007;
    end  
    if(m==2)  % steel
        E=3e+007;
    end
    if(m==3)  % copper
        E=1.6e+007;
    end

else                 % metric
    if(m==1)  % aluminum
        E=70;
    end
    if(m==2)  % steel
        E=205;
    end
    if(m==3)   % copper
        E=110;
    end
end

if(m<4)
    ss1=sprintf('%8.4g',E);
    set(handles.edit_em,'String',ss1);
end






% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_panel_flutter_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_panel_flutter);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('  ');
disp(' * * * * * * * ');
disp(' ');


n=get(handles.listbox_units,'Value');

M=str2num(get(handles.edit_mach,'String'));

if(M<=1)
   warndlg(' Set Mach number > 1 ');
   return; 
end

E=str2num(get(handles.edit_em,'String'));
q=str2num(get(handles.edit_q,'String'));

L=str2num(get(handles.edit_L,'String'));
W=str2num(get(handles.edit_W,'String'));
T=str2num(get(handles.edit_T,'String'));


if(n==1) % English
    
    q=q/12^2;
    
else     % metric
    
    [E]=GPa_to_Pa(E);
    [q]=MPa_to_Pa(q);    
     T=T/1000;
    
end

ratio=L/W;

%%%

x(1)=	0.1;	    y(1)=	0.518208;
x(2)=	0.116423;	y(2)=	0.517726;
x(3)=	0.135053;	y(3)=	0.516763;
x(4)=	0.157232;	y(4)=	0.515607;
x(5)=	0.17977;	y(5)=	0.514162;
x(6)=	0.209293;	y(6)=	0.512524;
x(7)=	0.243665;	y(7)=	0.510501;
x(8)=	0.281634;	y(8)=	0.508478;
x(9)=	0.325521;	y(9)=	0.506166;
x(10)=	0.37761;	y(10)=	0.503661;
x(11)=	0.434875;	y(11)=	0.500289;
x(12)=	0.502641;	y(12)=	0.49605;
x(13)=	0.633705;	y(13)=	0.490944;
x(14)=	0.70641;	y(14)=	0.485742;
x(15)=	0.793179;	y(15)=	0.482;
x(16)=	0.957485;	y(16)=	0.474759;
x(17)=	1.05199;	y(17)=	0.468208;
x(18)=	1.15583;	y(18)=	0.460694;
x(19)=	1.25619;	y(19)=	0.45212;
x(20)=	1.35543;	y(20)=	0.4421;
x(21)=	1.46249;	y(21)=	0.429673;
x(22)=	1.57232;	y(22)=	0.414547;
x(23)=	1.6782;	    y(23)=	0.396532;
x(24)=	1.7912;	    y(24)=	0.376782;
x(25)=	1.91182;	y(25)=	0.355877;
x(26)=	2.01851;	y(26)=	0.335164;
x(27)=	2.15443;	y(27)=	0.314933;
x(28)=	2.27467;	y(28)=	0.295472;
x(29)=	2.41907;	y(29)=	0.276012;
x(30)=	2.61016;	y(30)=	0.256551;
x(31)=	2.82656;	y(31)=	0.237861;
x(32)=	3.072;	    y(32)=	0.221002;
x(33)=	3.30269;	y(33)=	0.206551;
x(34)=	3.58948;	y(34)=	0.193738;
x(35)=	3.87302;	y(35)=	0.18237;
x(36)=	4.28623;	y(36)=	0.171965;
x(37)=	4.72638;	y(37)=	0.163006;
x(38)=	5.2496;	    y(38)=	0.155106;
x(39)=	5.83074;	y(39)=	0.148266;
x(40)=	6.6907;	    y(40)=	0.142196;
x(41)=	7.62212;	y(41)=	0.137283;
x(42)=	8.37444;	y(42)=	0.133601;
x(43)=	8.90606;	y(43)=	0.131171;
x(44)=	9.5;	    y(44)=	0.129646;
x(45)=	10;	        y(45)=	0.129039;
%
for(i=1:44)
    if(ratio==x(i))
        YY=y(i);
        break;
    end
%
    if(ratio==x(i+1))
        YY=y(i+1);
        break;
    end
%
    if(ratio>x(i) && ratio<x(i+1))
        length=x(i+1)-x(i);
        xx=ratio-x(i);
        c2=xx/length;
        c1=1-c2;
        YY=c1*y(i)+c2*y(i+1);
        break;
    end    
end
%
FP=(T/L)*((E/q)*sqrt(M^2-1))^(1/3);

%%%

figure(1);
plot(x,y);
title('Flutter Diagram');
xlabel(' Length Width Ratio  L/W ');
ylabel(' Flutter Parameter ');
grid on;
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','lin');
hold on;
plot(ratio,FP,'ro');

if(FP<2)
    ylim([0 2.0]);
end
if(FP<0.8)
    ylim([0 1.0]);
end
if(FP<0.6)
    ylim([0 0.8]);
end



%
   out1=sprintf('\n Flutter Parameter = %8.4g   Upper Limit = %8.4g',FP,YY);
%
if(FP<YY)
   out2=sprintf('\n Flutter Zone ');
   legend('Threshold','Case: in Flutter Zone');
end
%
if(FP==YY)
   out2=sprintf(' Boderline Case ');
   legend('Threshold','Case: Boderline Case ');  
end
%
if(FP>YY)
   out2=sprintf('\n No Flutter Zone ');    
   legend('Threshold','Case: in No Flutter Zone');   
end
%
disp(out1);
disp(out2);
%
hold off;




% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units

change(hObject, eventdata, handles);


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



function edit_mach_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mach (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mach as text
%        str2double(get(hObject,'String')) returns contents of edit_mach as a double


% --- Executes during object creation, after setting all properties.
function edit_mach_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mach (see GCBO)
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



function edit_em_Callback(hObject, eventdata, handles)
% hObject    handle to edit_em (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_em as text
%        str2double(get(hObject,'String')) returns contents of edit_em as a double


% --- Executes during object creation, after setting all properties.
function edit_em_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_em (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_q_Callback(hObject, eventdata, handles)
% hObject    handle to edit_q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_q as text
%        str2double(get(hObject,'String')) returns contents of edit_q as a double


% --- Executes during object creation, after setting all properties.
function edit_q_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_L as text
%        str2double(get(hObject,'String')) returns contents of edit_L as a double


% --- Executes during object creation, after setting all properties.
function edit_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_L (see GCBO)
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



function edit_T_Callback(hObject, eventdata, handles)
% hObject    handle to edit_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_T as text
%        str2double(get(hObject,'String')) returns contents of edit_T as a double


% --- Executes during object creation, after setting all properties.
function edit_T_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function varargout = beam_bending_composite_laminate(varargin)
% BEAM_BENDING_COMPOSITE_LAMINATE MATLAB code for beam_bending_composite_laminate.fig
%      BEAM_BENDING_COMPOSITE_LAMINATE, by itself, creates a new BEAM_BENDING_COMPOSITE_LAMINATE or raises the existing
%      singleton*.
%
%      H = BEAM_BENDING_COMPOSITE_LAMINATE returns the handle to a new BEAM_BENDING_COMPOSITE_LAMINATE or the handle to
%      the existing singleton*.
%
%      BEAM_BENDING_COMPOSITE_LAMINATE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BEAM_BENDING_COMPOSITE_LAMINATE.M with the given input arguments.
%
%      BEAM_BENDING_COMPOSITE_LAMINATE('Property','Value',...) creates a new BEAM_BENDING_COMPOSITE_LAMINATE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before beam_bending_composite_laminate_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to beam_bending_composite_laminate_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help beam_bending_composite_laminate

% Last Modified by GUIDE v2.5 19-Apr-2016 12:23:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @beam_bending_composite_laminate_OpeningFcn, ...
                   'gui_OutputFcn',  @beam_bending_composite_laminate_OutputFcn, ...
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


% --- Executes just before beam_bending_composite_laminate is made visible.
function beam_bending_composite_laminate_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to beam_bending_composite_laminate (see VARARGIN)

% Choose default command line output for beam_bending_composite_laminate
handles.output = hObject;


clc;
axes(handles.axes_beam_image);
bg = imread('beam_image_2.jpg');
image(bg);
axis off; 

setappdata(0,'fig_num',1);

change_all(hObject, eventdata, handles);
listbox_layers_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);



% UIWAIT makes beam_bending_composite_laminate wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Executes on button press in calculatebutton.
function calculatebutton_Callback(hObject, eventdata, handles)
% hObject    handle to calculatebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iflag=0;

iu=get(handles.unitslistbox,'Value');
nL=get(handles.listbox_layers,'Value');

n=5;

fn=zeros(5,1);

LBC=get(handles.leftBClistbox,'Value');
RBC=get(handles.rightBClistbox,'Value');

if((LBC==2 && RBC==3) || (LBC==3 && RBC==2)) % pinned-free
    warndlg('case unavailable');
    return;
end   

if(LBC==3 && RBC==3) % free-free
    iflag=1;
end   

L=str2num(get(handles.lengtheditbox,'String'));

if(isempty(L)==1)
   warndlg('Enter Length'); 
   return; 
end

width=str2num(get(handles.edit_width,'String'));

%%%%

if((LBC==2 && RBC==3) || (LBC==3 && RBC==2)) % pinned-free
    warndlg('pinned-free case unavailable');
    return;
end   

[root]=beam_bending_roots(LBC,RBC);

A=char(get(handles.uitable_coordinates,'Data'));

B=str2num(A);

E=B(1:nL);
rho=B((nL+1):(2*nL));
thick=B((2*nL+1):(3*nL));

E=fix_size(E);
rho=fix_size(rho);
thick=fix_size(thick);

%%%%%%%%%%%%%%

if(iu==1)
   rho=rho/386;
else
   thick=thick/1000;
   width=width/1000;    
end

%%%%%%%%%%%%%%

MOI=zeros(nL,1);
A=zeros(nL,1);
AE=zeros(nL,1);
AEY=zeros(nL,1);
AEc2=zeros(nL,1);

mass_per_length=zeros(nL,1);
Y=zeros(nL,1);
c=zeros(nL,1);

EI=zeros(nL,1);

rthick=0;

for i=1:nL
    A(i)=width*thick(i);
    mass_per_length(i)=rho(i)*A(i);
    MOI(i)=(1/12)*width*thick(i)^3;
    
    Y(i)=rthick+thick(i)/2;
    
    AE(i)=A(i)*E(i);
    AEY(i)=AE(i)*Y(i);
    
    EI(i)=E(i)*MOI(i);
    
    rthick=rthick+thick(i);
end

Y_bar=sum(AEY)/sum(AE);

for i=1:nL
   c(i)=abs(Y_bar-Y(i));
   AEc2(i)=AE(i)*c(i)^2;
end    


EI_comp=sum(AEc2)+sum(EI);

mass_per_length_comp=sum(mass_per_length);

EI_term = sqrt(EI_comp/mass_per_length_comp);

%%%%%%%%%%%%%%
   
beta=zeros(n,1);
    
for i=1:n
    beta(i)=root(i)/L;
    omegan=beta(i)^2*EI_term;
    fn(i)=omegan/(2*pi);
end

fn_string=sprintf('%8.4g \n%8.4g \n%8.4g \n%8.4g \n%8.4g',fn(1),fn(2),fn(3),fn(4),fn(5));

set(handles.edit_fn_results,'String',fn_string);

set(handles.uipanel_results,'Visible','on');

%%%%%%%%%%%%%%%

mass=mass_per_length_comp*L;
sq_mass=sqrt(mass);

[ModeShape,C,part]=beam_bending_modes_shapes_C_part(LBC,RBC,root,mass,L);

%%%%%%%%%%%%%%%

disp(' ');
disp(' * * * * ');
disp(' ');

if(iu==1)
    out1=sprintf(' Y_bar = %8.4g in \n',Y_bar);
else
    out1=sprintf(' Y_bar = %8.4g mm \n',Y_bar/1000);    
end    
disp(out1);


emm=zeros(n,1);

%

clear sum;

    if(iflag==0)

        disp('        Natural    Participation    Effective  ');
        disp('Mode   Frequency      Factor        Modal Mass ');
%
        for i=1:n
            emm(i)=part(i)^2; 
        end
        
        if(iu==1)
            emm=emm*386; 
        end
        
        sum_emm=sum(emm);

        for i=1:n        
            out1 = sprintf('%d  %10.4g Hz   %10.4g      %10.4g%%',i,fn(i),part(i),100*emm(i)/sum_emm );
            disp(out1)
        end
        
        if(iu==1)
            out1=sprintf('\n modal mass sum = %8.4g lbm\n',sum_emm);
        else
            out1=sprintf('\n modal mass sum = %8.4g kg \n',sum_emm);            
        end
        disp(out1)
    
    else  % free-free
%
        disp('        Natural  ');
        disp('Mode   Frequency ');
%
        for i=1:n
            out1 = sprintf('%d  %10.4g Hz',i,fn(i) );
            disp(out1)
        end
        
    end    

%%%%%%%%%%%%%%%

num=100;

dx=L/num;
    
x=zeros(num+1,1);

y=zeros(num+1,n);

for i=1:num+1
    x(i)=(i-1)*dx;
        
    for j=1:n
        arg=beta(j)*x(i);
        y(i,j)=ModeShape(arg,C(j));
    end
end
    
for j=1:n
    my=max(abs(y(:,j)));     
    y(:,j)=y(:,j)/my;
end

%%%%%%%%%%%%%%%

for ijk=1:n

    figure(ijk);
    plot(x,y(:,ijk));
    grid on;
    axis([0,L,-1.1,1.1]);

    out1=sprintf('Mode %d   fn=%7.4g Hz',ijk,fn(ijk));
    title(out1);

    ylabel('Modal Displacement');

    if(iu==1)
        xlabel('x (inch) ');
    else
        xlabel('x (meters) ');
    end

end

function lengtheditbox_Callback(hObject, eventdata, handles)
% hObject    handle to lengtheditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lengtheditbox as text
%        str2double(get(hObject,'String')) returns contents of lengtheditbox as a double
set(handles.uipanel_results,'Visible','off');


% --- Executes during object creation, after setting all properties.
function lengtheditbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lengtheditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%

function change_all(hObject, eventdata, handles)

iu=get(handles.unitslistbox,'Value');
icross=get(handles.crosssectionlistbox,'Value');

if(iu==1)
    set(handles.lengthlabel,'String','Length (in)');
    set(handles.elasticmoduluslabel,'String','E=Elastic Modulus (lbf/in^2)');
    set(handles.massdensitylabel,'String','rho=Mass Density (lbm/in^3)');
    set(handles.text_thick,'String','t=Thickness (in)');    
else
    set(handles.lengthlabel,'String','Length (m)');
    set(handles.elasticmoduluslabel,'String','E=Elastic Modulus (Pa)'); 
    set(handles.massdensitylabel,'String','rho=Mass Density (kg/m^3)'); 
    set(handles.text_thick,'String','t=Thickness (mm)');     
end

if(iu==1)
     if(icross==1) % rectangular
         set(handles.crosssectionlabel2','String','Width (in)');
     end
else
     if(icross==1) % rectangular
         set(handles.crosssectionlabel2','String','Width (mm)');
     end
end

set(handles.uipanel_results,'Visible','off');





% --- Outputs from this function are returned to the command line.
function varargout = beam_bending_composite_laminate_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in leftBClistbox.
function leftBClistbox_Callback(hObject, eventdata, handles)
% hObject    handle to leftBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns leftBClistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from leftBClistbox
set(handles.uipanel_results,'Visible','off');


% --- Executes during object creation, after setting all properties.
function leftBClistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to leftBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in rightBClistbox.
function rightBClistbox_Callback(hObject, eventdata, handles)
% hObject    handle to rightBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns rightBClistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from rightBClistbox


set(handles.uipanel_results,'Visible','off')
handles.rightBC=get(hObject,'Value');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function rightBClistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rightBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in crosssectionlistbox.
function crosssectionlistbox_Callback(hObject, eventdata, handles)
% hObject    handle to crosssectionlistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns crosssectionlistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from crosssectionlistbox

change_all(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function crosssectionlistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to crosssectionlistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in unitslistbox.
function unitslistbox_Callback(hObject, eventdata, handles)
% hObject    handle to unitslistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns unitslistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from unitslistbox
set(handles.uipanel_results,'Visible','off');

change_all(hObject, eventdata, handles);




% --- Executes during object creation, after setting all properties.
function unitslistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to unitslistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on key press with focus on lengtheditbox and none of its controls.
function lengtheditbox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to lengtheditbox (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(beam_bending_composite_laminate);


% --- Executes on selection change in listbox_layers.
function listbox_layers_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_layers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_layers contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_layers

n=get(handles.listbox_layers,'Value');

for i = 1:n
   for j=1:3
      data_s{i,j} = '';     
   end 
end
set(handles.uitable_coordinates,'Data',data_s);

set(handles.uipanel_results,'Visible','off');


% --- Executes during object creation, after setting all properties.
function listbox_layers_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_layers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_width_Callback(hObject, eventdata, handles)
% hObject    handle to edit_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_width as text
%        str2double(get(hObject,'String')) returns contents of edit_width as a double


% --- Executes during object creation, after setting all properties.
function edit_width_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_width and none of its controls.
function edit_width_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_width (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');



function crosssectioneditbox2_Callback(hObject, eventdata, handles)
% hObject    handle to crosssectioneditbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of crosssectioneditbox2 as text
%        str2double(get(hObject,'String')) returns contents of crosssectioneditbox2 as a double


% --- Executes during object creation, after setting all properties.
function crosssectioneditbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to crosssectioneditbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on crosssectioneditbox2 and none of its controls.
function crosssectioneditbox2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to crosssectioneditbox2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



function Answer_Callback(hObject, eventdata, handles)
% hObject    handle to Answer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Answer as text
%        str2double(get(hObject,'String')) returns contents of Answer as a double


% --- Executes during object creation, after setting all properties.
function Answer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Answer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fn_results_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fn_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fn_results as text
%        str2double(get(hObject,'String')) returns contents of edit_fn_results as a double


% --- Executes during object creation, after setting all properties.
function edit_fn_results_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

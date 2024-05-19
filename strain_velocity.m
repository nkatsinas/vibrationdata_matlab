function varargout = strain_velocity(varargin)
% STRAIN_VELOCITY MATLAB code for strain_velocity.fig
%      STRAIN_VELOCITY, by itself, creates a new STRAIN_VELOCITY or raises the existing
%      singleton*.
%
%      H = STRAIN_VELOCITY returns the handle to a new STRAIN_VELOCITY or the handle to
%      the existing singleton*.
%
%      STRAIN_VELOCITY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STRAIN_VELOCITY.M with the given input arguments.
%
%      STRAIN_VELOCITY('Property','Value',...) creates a new STRAIN_VELOCITY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before strain_velocity_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to strain_velocity_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help strain_velocity

% Last Modified by GUIDE v2.5 03-Aug-2020 14:27:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @strain_velocity_OpeningFcn, ...
                   'gui_OutputFcn',  @strain_velocity_OutputFcn, ...
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


% --- Executes just before strain_velocity is made visible.
function strain_velocity_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to strain_velocity (see VARARGIN)

% Choose default command line output for strain_velocity
handles.output = hObject;

set(handles.uipanel_results,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes strain_velocity wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = strain_velocity_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * * * * * ');
disp(' ');

velox=str2num(get(handles.edit_V,'String'));

imat=1;

n=5000;

if(imat==1)

    dt=0.25/n;

    strain=linspace(0,(n-1)*dt,n);

    n=length(strain);

    E=zeros(n,1);
    
    for i=1:n
 
        if(strain(i)<=0.002)
            E(i)=2.8e+07;
        end
        if(strain(i)>0.002 && strain(i)<=0.005)
            E1=E(1);
            E2=2e+06;
            L=0.005-0.002;
            X1=strain(i)-0.002;
            C2=X1/L;
            C1=1-C2;
            E(i)=C1*E1+C2*E2;
        end    
        if(strain(i)>0.005 && strain(i)<=0.02)
            E(i)=0;
        end        
        if(strain(i)>0.02 && strain(i)<=0.2)
            E1=4e+05;
            E2=0;
            L=0.2-0.02;
            X1=strain(i)-0.02;
            C2=X1/L;
            C1=1-C2;
            E(i)=C1*E1+C2*E2;
        end    
    end    

    n=length(E);

    for i=n:-1:1
        if(E(i)<=0)
            E(i)=[];
            strain(i)=[];
        end
    end

    n=length(E);

    c=zeros(n,1);

    rho=0.28/386;

    V_LR=zeros(n,1);
    
    for i=1:n
        c(i)=sqrt(E(i)/rho);
        V_LR(i)=strain(i)*c(i);
    end
    
    V_BB=V_LR/sqrt(3);
    V_PB=V_LR/2;

    figure(7);
    plot(strain(1:n),V_LR,strain(1:n),V_BB,strain(1:n),V_PB,'k');
    ylabel('Velocity (in/sec)');
    xlabel('Strain');
    legend('Rod','Beam','Plate');
    title('Velocity Strain Curve   A286 Stainless Steel');
    grid on;

end

n=length(strain);

velox=abs(velox);

if(velox>max(V_LR))
    warndlg('Fracture: input velocity exceeds maximum limit ');
    return;
end

vstrain_LR=0;
vstrain_BB=0;
vstrain_PB=0;


for i=1:n-1
  
    if(velox>=V_LR(i) && velox<=V_LR(i+1))
        
        x1=V_LR(i);
        y1=strain(i);
        x2=V_LR(i+1);
        y2=strain(i+1);
        xnew=velox;
        
        [vstrain_LR]=linear_interpolation_function(x1,y1,x2,y2,xnew);
                
        break;
    end
end
%
for i=1:n-1    
    if(velox>=V_BB(i) && velox<=V_BB(i+1))
        
        x1=V_BB(i);
        y1=strain(i);
        x2=V_BB(i+1);
        y2=strain(i+1);
        xnew=velox;
        
        [vstrain_BB]=linear_interpolation_function(x1,y1,x2,y2,xnew);
         
        break;
    end   
end
%
for i=1:n-1
    if(velox>=V_PB(i) && velox<=V_PB(i+1))
        
        x1=V_PB(i);
        y1=strain(i);
        x2=V_PB(i+1);
        y2=strain(i+1);
        xnew=velox;
        
        [vstrain_PB]=linear_interpolation_function(x1,y1,x2,y2,xnew);

        break;
    end       
end


out1=sprintf(' Velocity=%8.4g ips ',velox);
disp(out1);



if(velox<=max(V_LR))
    out2=sprintf(' Strain=%7.2g Longitudinal Rod',vstrain_LR);
else
    out2='Velocity exceeds longitudinal rod limit';
end


if(velox<=max(V_BB))
    out3=sprintf(' Strain=%7.2g Beam Bending ',vstrain_BB);
else
    out3='Velocity exceeds beam bending limit';
end


if(velox<=max(V_PB))
    out4=sprintf(' Strain=%7.2g Plate Bending',vstrain_PB);        
else
    out4='Velocity exceeds plate bending limit';    
end
disp(out4);

sss=sprintf('%s \n\n %s \n\n %s \n\n %s ',out1,out2,out3,out4);    

set(handles.edit_results,'String',sss);

set(handles.uipanel_results,'Visible','on');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(strain_velocity)


% --- Executes on selection change in listbox_mat.
function listbox_mat_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_mat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_mat contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_mat


% --- Executes during object creation, after setting all properties.
function listbox_mat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_mat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_V_Callback(hObject, eventdata, handles)
% hObject    handle to edit_V (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_V as text
%        str2double(get(hObject,'String')) returns contents of edit_V as a double
set(handles.uipanel_results,'Visible','off');

% --- Executes during object creation, after setting all properties.
function edit_V_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_V (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_results_Callback(hObject, eventdata, handles)
% hObject    handle to edit_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_results as text
%        str2double(get(hObject,'String')) returns contents of edit_results as a double


% --- Executes during object creation, after setting all properties.
function edit_results_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

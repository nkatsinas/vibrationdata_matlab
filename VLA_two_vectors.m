function varargout = VLA_two_vectors(varargin)
% VLA_TWO_VECTORS MATLAB code for VLA_two_vectors.fig
%      VLA_TWO_VECTORS, by itself, creates a new VLA_TWO_VECTORS or raises the existing
%      singleton*.
%
%      H = VLA_TWO_VECTORS returns the handle to a new VLA_TWO_VECTORS or the handle to
%      the existing singleton*.
%
%      VLA_TWO_VECTORS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VLA_TWO_VECTORS.M with the given input arguments.
%
%      VLA_TWO_VECTORS('Property','Value',...) creates a new VLA_TWO_VECTORS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VLA_two_vectors_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VLA_two_vectors_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VLA_two_vectors

% Last Modified by GUIDE v2.5 04-Dec-2014 10:38:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VLA_two_vectors_OpeningFcn, ...
                   'gui_OutputFcn',  @VLA_two_vectors_OutputFcn, ...
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


% --- Executes just before VLA_two_vectors is made visible.
function VLA_two_vectors_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VLA_two_vectors (see VARARGIN)

% Choose default command line output for VLA_two_vectors
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes VLA_two_vectors wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VLA_two_vectors_OutputFcn(hObject, eventdata, handles) 
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


FS=get(handles.edit_V1,'String');
V1=evalin('base',FS); 

FS=get(handles.edit_V2,'String');
V2=evalin('base',FS); 


m=length(V1);
n=length(V2);

sz1=size(V1);
sz2=size(V2);

if(sz1(1)~=sz2(1) || sz1(2)~=sz2(2) )
    warndlg('Vectors do not have same length');
    return;
end


na=get(handles.listbox_analysis,'Value');

zprintf = @(z) sprintf('%8.4g + %8.4gi', z, z/1i);


[EIP]=Euclidean_Inner_Product(V1,V2);


if(na==1)  % Euclidean Inner Product

    disp(' ');  
    disp('Euclidean Inner Product:');

    
    if(abs(imag(EIP))==0)
        out1=sprintf('%8.4g',EIP);
    else    
        out1=zprintf(EIP);
    end
    
    disp(out1);
    
end
if(na==2)  % Distance
    
    V1=real(V1);
    V2=real(V2);
    
    dis=0;
    
    d=V1-V2;

    for i=1:m
        dis=dis+d(i)^2;
    end
    
    dis=sqrt(dis);
    
    out1=sprintf('\n Distance = %8.4g ',dis);
    disp(out1);
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    A=EIP/(norm(V1)*norm(V2));
    
    theta= acos(A);
    
    disp(' ');
    out2=sprintf('theta = %8.4g rad',theta);
    out3=sprintf('      = %8.4g deg',theta*(180/pi));    
    
    disp(out2);
    disp(out3);
end

if(na==3)  % cross product
    
    if( max(sz1)~=3 || max(sz2)~=3 )
        warndlg(' Each vector must have 3 elements. ');
        return;
    end    
    
    disp(' ');
    disp(' Cross product ');
    
    V3 = cross(V1,V2);
    
    out1=sprintf('  A x B = [%g, %g, %g]',V3(1),V3(2),V3(3));
    disp(out1);
    
    
    disp(' ');
    disp(' "cross_product" vector written to workspace ');
    disp(' ');
    output_name='cross_product';
    assignin('base', output_name, V3);    
    
    X1=[0 V1(1) ];
    X2=[0 V2(1) ];
    X3=[0 V3(1) ];    
    
    Y1=[0 V1(2) ];
    Y2=[0 V2(2) ];
    Y3=[0 V3(2) ];  
    
    Z1=[0 V1(3) ];
    Z2=[0 V2(3) ];
    Z3=[0 V3(3) ];     
    
    figure(1);
    plot3(X1,Y1,Z1,X2,Y2,Z2,X3,Y3,Z3);
    grid on;
    xlabel('X');
    ylabel('Y');
    zlabel('Z');   
    
    disp(' ');
    out1=sprintf(' Parallelogram Surface Area = %8.4g ',norm(V3));
    disp(out1);
    
    
end    
if(na==4)  % tensor product
    disp(' ');
    disp(' Tensor Product ');
    V1=fix_size(V1);
    V2=fix_size(V2);
    T=V1*V2'
    disp(' ');
    disp(' Determinant ');
    dT=det(T);
    out1=sprintf('%8.4g',dT);
    disp(out1);
    disp(' ');
    disp(' Trace ');
    Tr=trace(T);   
    out1=sprintf('%8.4g',Tr);
    disp(out1);    

    disp(' ');
    disp(' "tensor_product" array written to workspace ');
    disp(' ');
    output_name='tensor_product';
    assignin('base', output_name, T);

end    

msgbox('Results written to Matlab Command Window');



function edit_V1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_V1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_V1 as text
%        str2double(get(hObject,'String')) returns contents of edit_V1 as a double


% --- Executes during object creation, after setting all properties.
function edit_V1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_V1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_V2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_V2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_V2 as text
%        str2double(get(hObject,'String')) returns contents of edit_V2 as a double


% --- Executes during object creation, after setting all properties.
function edit_V2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_V2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_analysis.
function listbox_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis


% --- Executes during object creation, after setting all properties.
function listbox_analysis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(VLA_two_vectors);

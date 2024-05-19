function varargout = VLA_tensor(varargin)
% VLA_TENSOR MATLAB code for VLA_tensor.fig
%      VLA_TENSOR, by itself, creates a new VLA_TENSOR or raises the existing
%      singleton*.
%
%      H = VLA_TENSOR returns the handle to a new VLA_TENSOR or the handle to
%      the existing singleton*.
%
%      VLA_TENSOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VLA_TENSOR.M with the given input arguments.
%
%      VLA_TENSOR('Property','Value',...) creates a new VLA_TENSOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VLA_tensor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VLA_tensor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VLA_tensor

% Last Modified by GUIDE v2.5 08-Jan-2015 13:23:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VLA_tensor_OpeningFcn, ...
                   'gui_OutputFcn',  @VLA_tensor_OutputFcn, ...
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


% --- Executes just before VLA_tensor is made visible.
function VLA_tensor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VLA_tensor (see VARARGIN)

% Choose default command line output for VLA_tensor
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes VLA_tensor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VLA_tensor_OutputFcn(hObject, eventdata, handles) 
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

delete(VLA_tensor);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


try
    FS=get(handles.edit_array_name,'String');
    A=evalin('base',FS); 
catch
    warndlg('Input Tensor does not exist');
    return;
end

disp(' ');
disp(' Input Tensor' );
A

sz=size(A);

if(sz(1)~=3 || sz(2) ~=3 )
    warndlg('Input Tensor must be 3x3');
    return;    
end


I1=trace(A);

I2=0;

for i=1:3
    for j=1:3
        I2=I2+A(i,i)*A(j,j)-A(i,j)*A(j,i);
    end
end

I2=I2/2;

I3=det(A);

disp(' Invariants')
out1=sprintf(' I1=%8.4g  I2=%8.4g  I3=%8.4g  ',I1,I2,I3);
disp(out1);

%%%

[V,D] = eig(A);
   
sz=size(D);
   
n=sz(1);
   
lambda=zeros(n,1);
sqrt_lambda=zeros(n,1);   
   
disp(' ');   
disp(' Eigenvalues    sqrt(Eigenvalues)');
disp(' '); 
for i=1:n
       lambda(i)=D(i,i);
       sqrt_lambda(i)=sqrt(lambda(i));
       out1=sprintf('%8.4g \t %8.4g',lambda(i),sqrt_lambda(i));
       disp(out1);
end
   
disp(' ');
disp(' Eigenvectors ');
 V

 
disp(' ');
disp(' Gershgorin circle radii ')

R=zeros(3,1);

for i=1:3
    for j=1:3
        if(i~=j)
            R(i)=R(i)+abs(A(i,j));
        end
    end
end


out1=sprintf(' R1=%8.4g  R2=%8.4g  R3=%8.4g  ',R(1),R(2),R(3));
disp(out1);

%%%%%%%%%%%


figure(1)

    
x1=0;
y1=A(1,1);
r1=R(1);

x2=0;
y2=A(2,2);
r2=R(2);

x3=0;
y3=A(3,3);
r3=R(3);

    
ang=0:0.01:2*pi; 

xp1=r1*cos(ang);
yp1=r1*sin(ang);

xp2=r2*cos(ang);
yp2=r2*sin(ang);

xp3=r3*cos(ang);
yp3=r3*sin(ang);


hold on

plot(x1+xp1,y1+yp1,x2+xp2,y2+yp2,x3+xp3,y3+yp3);

aa=max([ x1+xp1,y1+yp1,x2+xp2,y2+yp2,x3+xp3,y3+yp3   ]);
    
for i=1:3    
    plot(imag(lambda(1)),real(lambda(i)),'*');
end
title('Gershgorin Circles');
grid on;


hold off;

%%%%%%%%%%%


disp(' ');
disp('Eigenvectors written to array: EV');

output_name='EV';
assignin('base', output_name, V);

msgbox('Results written to Matlab Workspace');


function edit_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_array_name (see GCBO)
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

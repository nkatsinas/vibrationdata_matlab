function varargout = GS_orthogonalization(varargin)
% GS_ORTHOGONALIZATION MATLAB code for GS_orthogonalization.fig
%      GS_ORTHOGONALIZATION, by itself, creates a new GS_ORTHOGONALIZATION or raises the existing
%      singleton*.
%
%      H = GS_ORTHOGONALIZATION returns the handle to a new GS_ORTHOGONALIZATION or the handle to
%      the existing singleton*.
%
%      GS_ORTHOGONALIZATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GS_ORTHOGONALIZATION.M with the given input arguments.
%
%      GS_ORTHOGONALIZATION('Property','Value',...) creates a new GS_ORTHOGONALIZATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GS_orthogonalization_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GS_orthogonalization_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GS_orthogonalization

% Last Modified by GUIDE v2.5 05-Dec-2014 16:47:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GS_orthogonalization_OpeningFcn, ...
                   'gui_OutputFcn',  @GS_orthogonalization_OutputFcn, ...
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


% --- Executes just before GS_orthogonalization is made visible.
function GS_orthogonalization_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GS_orthogonalization (see VARARGIN)

% Choose default command line output for GS_orthogonalization
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GS_orthogonalization wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GS_orthogonalization_OutputFcn(hObject, eventdata, handles) 
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

delete(GS_orthogonalization);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    FS=get(handles.edit_array_name,'String');
    A=evalin('base',FS); 
catch
    warndlg('Input array does not exist');
    return;
end    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sz=size(A);
n=sz(1);

Q=zeros(n,n);

Q(:,1)=A(:,1)/norm(A(:,1));

for i=2:n

    ss=zeros(n,1);
    
    for j=1:(i-1)  
        x=Euclidean_Inner_Product(A(:,i),Q(:,j));
        ss=ss+x*Q(:,j);
    end     
    
    Q(:,i)=A(:,i)-ss;
    
    Q(:,i)=Q(:,i)/norm(Q(:,i));
    
end

disp(' ');
disp(' Input Array ');

A

disp(' ');
disp(' Orthonormal Vectors ');

Q

disp(' ');
disp(' Upper Triangular Matrix ');

R=pinv(Q)*A

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

msgbox('Results written to Command Window');



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

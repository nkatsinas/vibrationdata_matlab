function varargout = VLA_array_two_columns(varargin)
% VLA_ARRAY_TWO_COLUMNS MATLAB code for VLA_array_two_columns.fig
%      VLA_ARRAY_TWO_COLUMNS, by itself, creates a new VLA_ARRAY_TWO_COLUMNS or raises the existing
%      singleton*.
%
%      H = VLA_ARRAY_TWO_COLUMNS returns the handle to a new VLA_ARRAY_TWO_COLUMNS or the handle to
%      the existing singleton*.
%
%      VLA_ARRAY_TWO_COLUMNS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VLA_ARRAY_TWO_COLUMNS.M with the given input arguments.
%
%      VLA_ARRAY_TWO_COLUMNS('Property','Value',...) creates a new VLA_ARRAY_TWO_COLUMNS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VLA_array_two_columns_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VLA_array_two_columns_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VLA_array_two_columns

% Last Modified by GUIDE v2.5 06-Dec-2014 12:19:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VLA_array_two_columns_OpeningFcn, ...
                   'gui_OutputFcn',  @VLA_array_two_columns_OutputFcn, ...
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


% --- Executes just before VLA_array_two_columns is made visible.
function VLA_array_two_columns_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VLA_array_two_columns (see VARARGIN)

% Choose default command line output for VLA_array_two_columns
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes VLA_array_two_columns wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VLA_array_two_columns_OutputFcn(hObject, eventdata, handles) 
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

delete(VLA_array_two_columns);


% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type


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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ntype=get(handles.listbox_type,'Value');

try
    FS=get(handles.edit_array_name,'String');
    A=evalin('base',FS); 
catch
    warndlg('Input array does not exist');
    return;
end


sz=size(A);
n=sz(1);

Y=A(:,2);

if(ntype==1)

    Z=ones(n,2);
    Z(:,1)=A(:,1);

    ZTZ=Z'*Z;
    ZTY=Z'*Y;

    xx = ZTZ\ZTY;

    m=xx(1);
    b=xx(2);

    out1=sprintf('\n m=%8.4g  b=%8.4g  ',m,b);
    disp(out1);

    x=[min(A(:,1)) ; max(A(:,1))];

    y=[m*x(1)+b ; m*x(2)+b];

else
    
%%    
    Z=ones(n,3);

    for i=1:n
        x=A(i,1);
        Z(i,1)=x^2;
        Z(i,2)=x;
    end
    
    V=(Z'*Z)\(Z'*Y);
    
    a=V(1);
    b=V(2);
    c=V(3);

    out1=sprintf('\n a=%8.4g  b=%8.4g  c=%8.4g',a,b,c);
    disp(out1);    
    
%%

    minA=min(A(:,1));
    maxA=max(A(:,1));
    
    num=100;
    
    dx=(maxA-minA)/(num-1);
    
    x=zeros(num,1);
    y=zeros(num,1);
    
    for i=1:num
        x(i)=(i-1)*dx;
        y(i)=a*x(i)^2+b*x(i)+c;
    end
    
end    

fig_num=1;
figure(fig_num);
plot(A(:,1),A(:,2),'o',x,y);

title('Least Squares Fit');
xlabel('X');
ylabel('Y');
grid on;

msgbox('Output written to Command Window');


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

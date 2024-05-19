function varargout = principal_vonMises_Tresca(varargin)
% PRINCIPAL_VONMISES_TRESCA MATLAB code for principal_vonMises_Tresca.fig
%      PRINCIPAL_VONMISES_TRESCA, by itself, creates a new PRINCIPAL_VONMISES_TRESCA or raises the existing
%      singleton*.
%
%      H = PRINCIPAL_VONMISES_TRESCA returns the handle to a new PRINCIPAL_VONMISES_TRESCA or the handle to
%      the existing singleton*.
%
%      PRINCIPAL_VONMISES_TRESCA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PRINCIPAL_VONMISES_TRESCA.M with the given input arguments.
%
%      PRINCIPAL_VONMISES_TRESCA('Property','Value',...) creates a new PRINCIPAL_VONMISES_TRESCA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before principal_vonMises_Tresca_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to principal_vonMises_Tresca_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help principal_vonMises_Tresca

% Last Modified by GUIDE v2.5 23-Apr-2016 15:00:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @principal_vonMises_Tresca_OpeningFcn, ...
                   'gui_OutputFcn',  @principal_vonMises_Tresca_OutputFcn, ...
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


% --- Executes just before principal_vonMises_Tresca is made visible.
function principal_vonMises_Tresca_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to principal_vonMises_Tresca (see VARARGIN)

% Choose default command line output for principal_vonMises_Tresca
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes principal_vonMises_Tresca wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = principal_vonMises_Tresca_OutputFcn(hObject, eventdata, handles) 
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

fig_num=1;

n=get(handles.listbox_type,'Value');

try
    FS=get(handles.edit_input_array,'String');
    A=evalin('base',FS); 
catch
    warndlg('Input Tensor does not exist');
    return;
end

disp(' ');
disp(' * * * * * * * * * ');
disp(' ');
disp(' Input Tensor' );
A

sz=size(A);

iflag=0;

if( sz(1)==2 && sz(2)==2)
    iflag=2;
end

if( sz(1)==3 && sz(2)==3)
    iflag=3;
end

if(iflag==0)
    warndlg('Input Array must be 2x2 or 3x3');    
    return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(iflag==2) %  2D

    [evector,D] = eig(A);
    
    lambda=zeros(2,1);
    
    for i=1:2
        lambda(i)=D(i,i);
    end
    
%%    
    big=zeros(3,2);
    big(1,:)=lambda;
    
    for i=2:3
        big(i,:)=evector(i-1,:);
    end
        
    clear lambda;
    clear evector;
   
    
    big=sortrows(big',-1)';    
        
    lambda=big(1,:);
    
    evector=zeros(2,2);
    
    for i=2:3
        evector(i-1,:)=big(i,:);
    end    
%   
    
end    
    
if(iflag==3) %  3D
    
    [lambda,evector]=three_by_three_invariants(A);
    
     disp(' ');   
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');   
    
if(n==1) % strain
    disp(' Principal Strains');
else % stress
    disp(' Principal Stresses');
end 

disp(' '); 

for i=1:length(lambda)
    out1=sprintf('%8.4g ',lambda(i));
    disp(out1);
end   
    
disp(' ');
disp(' Eigenvectors, direction cosines of principal plane ');
disp('      (column format) ');

    
evector

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

s1=lambda(1);
s2=lambda(2);
    
if(iflag==2)  % 2d
    s11=A(1,1);
    s12=A(1,2);
    s22=A(2,2);
    
    y=(2*s12);
    x=(s11-s22);
    
    theta=0.5*atan2(y,x);
    disp(' Major principal angle');
    out1=sprintf(' theta = %8.4g rad ',theta);
    out2=sprintf('       = %8.4g deg ',theta*180/pi);
    disp(out1);
    disp(out2);
    
    if(n==2)        
        [fig_num,center,radius]=Mohrs_circle_2D(s11,s12,s22,fig_num);
        

        sv=sqrt(s1.^2-s1.*s2+s2.^2);       
        ts=abs(s1-s2);
        
        disp(' ');
        out1=sprintf('  Ave principal stress = %7.4g ',center);       
        out2=sprintf('      Max shear stress = %7.4g',radius);
        out3=sprintf('      Min shear stress = %7.4g',-radius);
        out4=sprintf('      von Mises stress = %7.4g',sv);     
        out5=sprintf('         Tresca stress = %7.4g',ts);   
        
        disp(out1); 
        disp(out2); 
        disp(out3); 
        disp(out4); 
        disp(out5);
        
    end
end
    
    
if(iflag==3)  % 3d stress
    
    s3=lambda(3);
    
    y=(s1-s2)^2+(s1-s3)^2+(s2-s3)^2;
    vMstress=sqrt(y/2);
        
    ts=max([ abs(s1-s2) abs(s1-s3) abs(s2-s3)]);
    
    out1=sprintf('             von Mises stress = %7.4g',vMstress);
    out2=sprintf('                Tresca stress = %7.4g',ts);  
    out3=sprintf(' Overall maximum shear stress = %7.4g',0.5*(lambda(1)-lambda(3)));
    disp(out1); 
    disp(out2);
    disp(out3);
        
    L1=lambda(1);
    L2=lambda(2);
    L3=lambda(3);
        
    [fig_num]=Mohrs_circle_3D(L1,L2,L3,fig_num);
        
end

msgbox(' Results written to command window');
    
    




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


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(principal_vonMises_Tresca);

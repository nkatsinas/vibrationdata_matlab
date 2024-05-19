function varargout = VLA_one_array(varargin)
% VLA_ONE_ARRAY MATLAB code for VLA_one_array.fig
%      VLA_ONE_ARRAY, by itself, creates a new VLA_ONE_ARRAY or raises the existing
%      singleton*.
%
%      H = VLA_ONE_ARRAY returns the handle to a new VLA_ONE_ARRAY or the handle to
%      the existing singleton*.
%
%      VLA_ONE_ARRAY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VLA_ONE_ARRAY.M with the given input arguments.
%
%      VLA_ONE_ARRAY('Property','Value',...) creates a new VLA_ONE_ARRAY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VLA_one_array_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VLA_one_array_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VLA_one_array

% Last Modified by GUIDE v2.5 10-Dec-2014 13:31:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VLA_one_array_OpeningFcn, ...
                   'gui_OutputFcn',  @VLA_one_array_OutputFcn, ...
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


% --- Executes just before VLA_one_array is made visible.
function VLA_one_array_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VLA_one_array (see VARARGIN)

% Choose default command line output for VLA_one_array
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes VLA_one_array wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VLA_one_array_OutputFcn(hObject, eventdata, handles) 
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

ntype=get(handles.listbox_type,'Value');

try
    FS=get(handles.edit_array_name,'String');
    A=evalin('base',FS); 
catch
    warndlg('Input array does not exist');
    return;
end


disp(' ');
disp(' Input Array ');

A

sz=size(A);
n=sz(1);

if(ntype==1)
    
    disp(' ')
    disp(' Determinant ');
    
    out1=sprintf('%8.4g',det(A));
    disp(out1);
    
        
    disp(' ')
    disp(' Trace ');
    
    out1=sprintf('%8.4g',trace(A));
    disp(out1);
    
end    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(ntype==2)  % Gram-Schmidt 

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
    disp(' Orthonormal Vectors ');

    Q

    disp(' ');
    disp(' Upper Triangular Matrix ');

    R=pinv(Q)*A
    
    setappdata(0,'Q',Q);
    setappdata(0,'R',R);
    
    string_th{1}=sprintf('Orthonormal Vectors');       
    string_th{2}=sprintf('Upper Triangular Matrix'); 
    
    set(handles.listbox_save,'String',string_th);    

    set(handles.uipanel_save,'Visible','on');
    
end
if(ntype==3)

    [L,U,P] = lu(A)
    
    disp(' ');
    disp(' L*U ');
    L*U
    
end
if(ntype==4)
    
    L = chol(A,'lower')
    R = chol(A,'upper')
    
    disp(' L*R ');
    
    L*R
    
end
if(ntype==5)
    
    disp(' ');
    disp(' Inverse Array ');
    
    inv(A)
    
    IA=inv(A);
    
    setappdata(0,'IA',IA);
   
    set(handles.uipanel_save,'Visible','on');

    string_th{1}=sprintf('Inverse Array');        
    set(handles.listbox_save,'String',string_th);  
    
end
if(ntype==6)
    
    disp(' ');
    disp(' Pseudo Inverse Array ');    
    
    pinv(A)
    
    IA=pinv(A);
    
    setappdata(0,'IA',IA);    
    
    set(handles.uipanel_save,'Visible','on');
    
    string_th{1}=sprintf('Pseudo Inverse Array');        
    set(handles.listbox_save,'String',string_th);      
end
if(ntype==7)  % eigenvalues
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
   
   setappdata(0,'V',V);
   setappdata(0,'lambda',lambda);  
   setappdata(0,'sqrt_lambda',sqrt_lambda);   

    string_th{1}=sprintf('Eigenvalues');   
    string_th{2}=sprintf('sqrt(Eigenvalues)');     
    string_th{3}=sprintf('Eigenvectors'); 
    
    set(handles.listbox_save,'String',string_th);    

    set(handles.uipanel_save,'Visible','on');   
   
end

if(ntype==8)
   [R,jb] = rref(A) 

    string_th{1}=sprintf('Row Reduced Echelon R');   
    string_th{2}=sprintf('jb');     
    
    setappdata(0,'R',R);  
    setappdata(0,'jb',jb);     
    
    set(handles.listbox_save,'String',string_th);    

    set(handles.uipanel_save,'Visible','on');   

end

msgbox('Results written to Command Window');


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type
    set(handles.uipanel_save,'Visible','off');

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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_type,'Value');

m=get(handles.listbox_save,'Value');

if(n==2)
    if(m==1)
        data=getappdata(0,'Q');         
    else
        data=getappdata(0,'R');           
    end
end

if(n==5 || n==6)
     data=getappdata(0,'IA'); 
end    

if(n==7)
    if(m==1)    
        data=getappdata(0,'lambda');        
    end
    if(m==2)    
        data=getappdata(0,'sqrt_lambda');        
    end    
    if(m==3)
        data=getappdata(0,'V');
    end    
    
end

if(n==8)
    if(m==1)    
        data=getappdata(0,'R');        
    end
    if(m==2)    
        data=getappdata(0,'jb');        
    end      
     
end    


output_name=get(handles.edit_output_array_name,'String');

assignin('base', output_name, data);


h = msgbox('Save Complete'); 


% --- Executes on key press with focus on edit_array_name and none of its controls.
function edit_array_name_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_array_name (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on selection change in listbox_save.
function listbox_save_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_save contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_save


% --- Executes during object creation, after setting all properties.
function listbox_save_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_output_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function varargout = modified_Gram_Schmidt_orthogonalization(varargin)
% MODIFIED_GRAM_SCHMIDT_ORTHOGONALIZATION MATLAB code for modified_Gram_Schmidt_orthogonalization.fig
%      MODIFIED_GRAM_SCHMIDT_ORTHOGONALIZATION, by itself, creates a new MODIFIED_GRAM_SCHMIDT_ORTHOGONALIZATION or raises the existing
%      singleton*.
%
%      H = MODIFIED_GRAM_SCHMIDT_ORTHOGONALIZATION returns the handle to a new MODIFIED_GRAM_SCHMIDT_ORTHOGONALIZATION or the handle to
%      the existing singleton*.
%
%      MODIFIED_GRAM_SCHMIDT_ORTHOGONALIZATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MODIFIED_GRAM_SCHMIDT_ORTHOGONALIZATION.M with the given input arguments.
%
%      MODIFIED_GRAM_SCHMIDT_ORTHOGONALIZATION('Property','Value',...) creates a new MODIFIED_GRAM_SCHMIDT_ORTHOGONALIZATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before modified_Gram_Schmidt_orthogonalization_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to modified_Gram_Schmidt_orthogonalization_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help modified_Gram_Schmidt_orthogonalization

% Last Modified by GUIDE v2.5 04-Sep-2018 10:49:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @modified_Gram_Schmidt_orthogonalization_OpeningFcn, ...
                   'gui_OutputFcn',  @modified_Gram_Schmidt_orthogonalization_OutputFcn, ...
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


% --- Executes just before modified_Gram_Schmidt_orthogonalization is made visible.
function modified_Gram_Schmidt_orthogonalization_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to modified_Gram_Schmidt_orthogonalization (see VARARGIN)

% Choose default command line output for modified_Gram_Schmidt_orthogonalization
handles.output = hObject;

listbox_method_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes modified_Gram_Schmidt_orthogonalization wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = modified_Gram_Schmidt_orthogonalization_OutputFcn(hObject, eventdata, handles) 
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

delete(modified_Gram_Schmidt_orthogonalization);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * ');
disp(' ');

imethod=get(handles.listbox_method,'Value');

try
    xFS=get(handles.edit_trial,'String');
    x=evalin('base',xFS);
catch
    warndlg('Trial Vector Array not found');
    return;
end

m=size(x);  % number of columns
n=m(1,2);
%
yhat=zeros(n,n);



if(imethod==1)
%
% mass
%
    try
        massFS=get(handles.edit_mass,'String');
        mass=evalin('base',massFS);
    catch
        warndlg('Mass Matrix not found');
        return;        
    end
%
    scale=x(:,1)'*mass*x(:,1);
    yhat(:,1)=x(:,1)/sqrt(abs(scale));
    for i=2:n
        for j=i:n
            x(:,j)=x(:,j)-(yhat(:,i-1)'*mass*x(:,j))*yhat(:,i-1);
        end
        scale=x(:,i)'*mass*x(:,i);
        yhat(:,i)=x(:,i)/sqrt(abs(scale));
    end   
%
else
%    
% identity
%
    yhat(:,1)=x(:,1)/norm(x(:,1));
%    
    for i=2:n
        for j=i:n
            x(:,j)=x(:,j)-(yhat(:,i-1)'*x(:,j))*yhat(:,i-1);
        end
        yhat(:,i)=x(:,i)/norm(x(:,i));
    end
    
    mass=eye(n,n);
    
end


rcm=yhat'*mass*yhat;
%
if(n<=12)
    disp(' yhatT*mass*yhat = ');
    rcm
    disp(' ');
end  


if(n<=12)
   yhat 
   disp(' ');
end

disp(' ');
disp(' Output array: yhat ');
disp(' ');

assignin('base', 'yhat', yhat);

msgbox('Analysis Complete.  Results written to Command Window');


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method

n=get(handles.listbox_method,'Value');

if(n==1)
    set(handles.text_mass,'Visible','on');
    set(handles.edit_mass,'Visible','on');    
else
    set(handles.text_mass,'Visible','off');
    set(handles.edit_mass,'Visible','off');     
end



% --- Executes during object creation, after setting all properties.
function listbox_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_trial_Callback(hObject, eventdata, handles)
% hObject    handle to edit_trial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_trial as text
%        str2double(get(hObject,'String')) returns contents of edit_trial as a double


% --- Executes during object creation, after setting all properties.
function edit_trial_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_trial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_mass as a double


% --- Executes during object creation, after setting all properties.
function edit_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

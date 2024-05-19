function varargout = principal_stress_strain(varargin)
% PRINCIPAL_STRESS_STRAIN MATLAB code for principal_stress_strain.fig
%      PRINCIPAL_STRESS_STRAIN, by itself, creates a new PRINCIPAL_STRESS_STRAIN or raises the existing
%      singleton*.
%
%      H = PRINCIPAL_STRESS_STRAIN returns the handle to a new PRINCIPAL_STRESS_STRAIN or the handle to
%      the existing singleton*.
%
%      PRINCIPAL_STRESS_STRAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PRINCIPAL_STRESS_STRAIN.M with the given input arguments.
%
%      PRINCIPAL_STRESS_STRAIN('Property','Value',...) creates a new PRINCIPAL_STRESS_STRAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before principal_stress_strain_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to principal_stress_strain_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help principal_stress_strain

% Last Modified by GUIDE v2.5 10-May-2017 11:05:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @principal_stress_strain_OpeningFcn, ...
                   'gui_OutputFcn',  @principal_stress_strain_OutputFcn, ...
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


% --- Executes just before principal_stress_strain is made visible.
function principal_stress_strain_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to principal_stress_strain (see VARARGIN)

% Choose default command line output for principal_stress_strain
handles.output = hObject;

change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes principal_stress_strain wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function change(hObject, eventdata, handles)
%
n=get(handles.listbox_input_method,'Value');

m=get(handles.listbox_dimension,'Value');

set(handles.text_array_name,'Visible','off');
set(handles.edit_input_array,'Visible','off');

set(handles.text_dimension,'Visible','off');
set(handles.listbox_dimension,'Visible','off');

set(handles.text_Sxx,'Visible','off');
set(handles.text_Sxy,'Visible','off');
set(handles.text_Sxz,'Visible','off');
set(handles.text_Syy,'Visible','off');
set(handles.text_Syz,'Visible','off');
set(handles.text_Szz,'Visible','off');

set(handles.edit_Sxx,'Visible','off');
set(handles.edit_Sxy,'Visible','off');
set(handles.edit_Sxz,'Visible','off');
set(handles.edit_Syy,'Visible','off');
set(handles.edit_Syz,'Visible','off');
set(handles.edit_Szz,'Visible','off');




if(n==1)  % read
    
    set(handles.text_array_name,'Visible','on');
    set(handles.edit_input_array,'Visible','on');
    
else % manual
    
    set(handles.text_dimension,'Visible','on');
    set(handles.listbox_dimension,'Visible','on');

    set(handles.text_Sxx,'Visible','on');
    set(handles.text_Sxy,'Visible','on');
    set(handles.text_Syy,'Visible','on');
    set(handles.edit_Sxx,'Visible','on');
    set(handles.edit_Sxy,'Visible','on');
    set(handles.edit_Syy,'Visible','on');

    if(m==2)
       
        set(handles.text_Sxz,'Visible','on');       
        set(handles.text_Syz,'Visible','on');  
        set(handles.text_Szz,'Visible','on');
        set(handles.edit_Sxz,'Visible','on');
        set(handles.edit_Syz,'Visible','on');   
        set(handles.edit_Szz,'Visible','on');   
    end
    
end

%


% --- Outputs from this function are returned to the command line.
function varargout = principal_stress_strain_OutputFcn(hObject, eventdata, handles) 
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


nim=get(handles.listbox_input_method,'Value');

n=get(handles.listbox_type,'Value');


if(nim==1)

    try
        FS=get(handles.edit_input_array,'String');
        A=evalin('base',FS); 
    catch
        warndlg('Input Tensor does not exist');
        return;
    end
    
else    
    
    md=get(handles.listbox_dimension,'Value');
    
    A(1,1)=str2num(get(handles.edit_Sxx,'String'));
    A(1,2)=str2num(get(handles.edit_Sxy,'String'));
    A(2,2)=str2num(get(handles.edit_Syy,'String'));
    
    if(md==2)

        A(1,3)=str2num(get(handles.edit_Sxz,'String'));
        A(2,3)=str2num(get(handles.edit_Syz,'String'));   
        A(3,3)=str2num(get(handles.edit_Szz,'String'));           
        
    end
    
end    
    
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
        disp(' ');         
        
else % stress
        
        disp(' ');   
        disp(' Principal Stresses');
        disp(' ');        

end 

for i=1:length(lambda)
    out1=sprintf('%8.4g ',lambda(i));
    disp(out1);
end
    
disp(' ');
disp(' Eigenvectors, direction cosines of principal plane ');
disp('      (column format) ');
disp(' ');
    
evector

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
if(iflag==2)  % 2d
    s11=A(1,1);
    s12=A(1,2);
    s22=A(2,2);
    
    y=(2*s12);
    x=(s11-s22);
    
    theta=0.5*atan2(y,x);
    disp(' Major principal angle');
    out1=sprintf('\n theta = %8.4g rad ',theta);
    out2=sprintf('       = %8.4g deg \n',theta*180/pi);
    disp(out1);
    disp(out2);
    
    out3=sprintf(' 2*theta  = %8.4g deg ',2*theta*180/pi);    
    disp(out3);   
    
    if(n==2)        
        [fig_num,center,radius]=Mohrs_circle_2D(s11,s12,s22,fig_num);
        
        s1=lambda(1);
        s2=lambda(2);
        
         sv=sqrt(s1.^2-s1.*s2+s2.^2);       
        ts=max( [abs(s1-s2) abs(s1) abs(s2) ] );
        
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
    
    
if(iflag==3 && n==2)  % 3d stress
    
    s1=lambda(1);
    s2=lambda(2);
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

delete(principal_stress_strain);


% --- Executes on selection change in listbox_input_method.
function listbox_input_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_input_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_input_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_input_method
change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_input_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_input_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_dimension.
function listbox_dimension_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_dimension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_dimension contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_dimension
change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_dimension_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_dimension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Sxx_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Sxx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Sxx as text
%        str2double(get(hObject,'String')) returns contents of edit_Sxx as a double


% --- Executes during object creation, after setting all properties.
function edit_Sxx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Sxx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Sxy_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Sxy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Sxy as text
%        str2double(get(hObject,'String')) returns contents of edit_Sxy as a double


% --- Executes during object creation, after setting all properties.
function edit_Sxy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Sxy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Sxz_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Sxz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Sxz as text
%        str2double(get(hObject,'String')) returns contents of edit_Sxz as a double


% --- Executes during object creation, after setting all properties.
function edit_Sxz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Sxz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Syy_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Syy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Syy as text
%        str2double(get(hObject,'String')) returns contents of edit_Syy as a double


% --- Executes during object creation, after setting all properties.
function edit_Syy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Syy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Syz_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Syz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Syz as text
%        str2double(get(hObject,'String')) returns contents of edit_Syz as a double


% --- Executes during object creation, after setting all properties.
function edit_Syz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Syz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Szz_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Szz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Szz as text
%        str2double(get(hObject,'String')) returns contents of edit_Szz as a double


% --- Executes during object creation, after setting all properties.
function edit_Szz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Szz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

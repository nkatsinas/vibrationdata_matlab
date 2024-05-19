function varargout = vibrationdata_mdof_srs(varargin)
% VIBRATIONDATA_MDOF_SRS MATLAB code for vibrationdata_mdof_srs.fig
%      VIBRATIONDATA_MDOF_SRS, by itself, creates a new VIBRATIONDATA_MDOF_SRS or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_MDOF_SRS returns the handle to a new VIBRATIONDATA_MDOF_SRS or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_MDOF_SRS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_MDOF_SRS.M with the given input arguments.
%
%      VIBRATIONDATA_MDOF_SRS('Property','Value',...) creates a new VIBRATIONDATA_MDOF_SRS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_mdof_srs_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_mdof_srs_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_mdof_srs

% Last Modified by GUIDE v2.5 23-Aug-2014 10:34:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_mdof_srs_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_mdof_srs_OutputFcn, ...
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


% --- Executes just before vibrationdata_mdof_srs is made visible.
function vibrationdata_mdof_srs_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_mdof_srs (see VARARGIN)

% Choose default command line output for vibrationdata_mdof_srs
handles.output = hObject;

listbox_method_Callback(hObject, eventdata, handles);



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_mdof_srs wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_mdof_srs_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_mdof_srs);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iu=get(handles.listbox_units,'Value');

k=get(handles.listbox_method,'Value');

if(k==1)
  FS=get(handles.edit_input_array,'String');
  THM=evalin('base',FS);   
else
  THM=getappdata(0,'THM');
end

num_srs=length(THM(:,1));

try
    FS1=strtrim(get(handles.edit_fn,'String'));
    fn=evalin('base',FS1);
    fn=fix_size(fn);
    szfn=size(fn);
    if(szfn(2)>=2)
        warndlg('Natural Frequency Array must have only 1 column');
        return;
    end
catch
    warndlg(' Natural Frequency array unavailable');
    return
end    

try
    FS2=strtrim(get(handles.edit_pf,'String'));
    pf=evalin('base',FS2);
    pf=pf';
    pf=fix_size(pf);
    sz=size(pf);
    if(sz(2)>=2)
        warndlg('Participation Factor Array must have only 1 column');
        return;
    end    
catch
    warndlg(' Participation Factor array unavailable');    
    return    
end 

try
    FS3=strtrim(get(handles.edit_ModeShapes,'String'));
    ModeShapes=evalin('base',FS3);
    szM=size(ModeShapes);
    if(szM(1)~=szfn(1) || szM(2)~=szfn(1))
        out1=sprintf('Mode Shape Array must have dimensions (%d x %d)',szfn(1),szfn(1));
        warndlg(out1);
        return;
    end      
catch
    warndlg(' Mode Shape array unavailable');      
    return    
end 



num_fn=length(fn);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

omegan=2*pi*fn;

accel_abssum=zeros(num_fn,1);
  accel_srss=zeros(num_fn,1);
  
pv_abssum=zeros(num_fn,1);
  pv_srss=zeros(num_fn,1);  

rd_abssum=zeros(num_fn,1);
  rd_srss=zeros(num_fn,1);

 a_srs=zeros(num_fn,1);
pv_srs=zeros(num_fn,1);
rd_srs=zeros(num_fn,1);
  

f=THM(:,1);
a=THM(:,2);

slope=zeros(num_srs-1,1);

for i=1:(num_srs-1)
    slope(i)=log(a(i+1)/a(i))/log(f(i+1)/f(i));
end

for i=1:num_fn
    
    for k=1:(num_srs-1)
        if(fn(i)>=f(k) && fn(i)<=f(k+1))
             a_srs(i)=a(k)*(fn(i)/f(k))^slope(k);
            pv_srs(i)=a_srs(i)/omegan(i); 
            rd_srs(i)=a_srs(i)/omegan(i)^2;    
            break;
        end    
    end
end 
    


for i=1:num_fn
    
    for j=1:num_fn
        
         PFM=pf(j)*ModeShapes(i,j);
         
        accel_abssum(i)=accel_abssum(i)+abs(PFM*a_srs(j));
          accel_srss(i)=accel_srss(i)+(PFM*a_srs(j))^2;
  
           pv_abssum(i)=pv_abssum(i)+abs(PFM*pv_srs(j));
             pv_srss(i)=pv_srss(i)+(PFM*pv_srs(j))^2;             
          
           rd_abssum(i)=rd_abssum(i)+abs(PFM*rd_srs(j));
             rd_srss(i)=rd_srss(i)+(PFM*rd_srs(j))^2;   
  
    end
    
    accel_srss(i)=sqrt( accel_srss(i) );
       pv_srss(i)=sqrt(    pv_srss(i) );
       rd_srss(i)=sqrt(    rd_srss(i) );
       
end

if(iu==1)
    dconv=386;
    vconv=386;
else
    dconv=9.81*1000;
    vconv=9.81*100;
end

pv_abssum=pv_abssum*vconv;
pv_srss=pv_srss*vconv;   

rd_abssum=rd_abssum*dconv;
rd_srss=rd_srss*dconv;   
    

disp(' ');
disp('SRS Spec' );
disp(' ');
disp('Mode   fn(Hz)   Accel(G)');

for i=1:num_fn
    out1=sprintf(' %d  %8.4g  %8.4g ',i,fn(i),a_srs(i));
    disp(out1)
end


disp(' ');
disp(' Response Acceleration (G)');
disp(' ');
disp('dof    SRSS    Abssum' );

for i=1:num_fn
    out1=sprintf(' %d  %8.4g  %8.4g ',i,accel_srss(i),accel_abssum(i));
    disp(out1)
end


disp(' ');

if(iu==1)
    disp(' Pseudo Velocity (in/sec)');
else
    disp(' Pseudo Velocity (cm/sec)');    
end
disp(' ');
disp('dof    SRSS    Abssum' );


for i=1:num_fn
    out1=sprintf(' %d  %8.4g  %8.4g ',i,pv_srss(i),pv_abssum(i));
    disp(out1)
end



disp(' ');

if(iu==1)
    disp(' Relative Displacement (in)');
else
    disp(' Relative Displacement  (mm)');    
end    
    
disp(' ');
disp('dof   SRSS    Abssum' );

for i=1:num_fn
    out1=sprintf(' %d  %8.4g  %8.4g ',i,rd_srss(i),rd_abssum(i));
    disp(out1)
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

msgbox('Results written to Command Window');




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


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');

n=get(handles.listbox_method,'Value');

if(n==1)
   
    
   set(handles.edit_input_array,'enable','on') 
else

   
   set(handles.edit_input_array,'enable','off')
   
   set(handles.text_input_array_name,'Visible','off');
   set(handles.edit_input_array,'Visible','off');   
   
   [filename, pathname] = uigetfile('*.*');
   filename = fullfile(pathname, filename);
   fid = fopen(filename,'r');
   
   THM = fscanf(fid,'%g %g',[2 inf]);
   THM=THM';
    
   setappdata(0,'THM',THM);
   
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



function edit_Q_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q as text
%        str2double(get(hObject,'String')) returns contents of edit_Q as a double


% --- Executes during object creation, after setting all properties.
function edit_Q_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes during object creation, after setting all properties.
function listbox_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fn_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fn_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fn_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_fn_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_fn_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_pf_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pf_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pf_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_pf_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_pf_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pf_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_eig_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_eig_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_eig_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_eig_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_eig_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_eig_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_accel_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_accel_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_accel_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_accel_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_accel_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_accel_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fn_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fn_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fn_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_fn_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_fn_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fn_3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fn_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fn_3 as text
%        str2double(get(hObject,'String')) returns contents of edit_fn_3 as a double


% --- Executes during object creation, after setting all properties.
function edit_fn_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fn_4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fn_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fn_4 as text
%        str2double(get(hObject,'String')) returns contents of edit_fn_4 as a double


% --- Executes during object creation, after setting all properties.
function edit_fn_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fn_5_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fn_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fn_5 as text
%        str2double(get(hObject,'String')) returns contents of edit_fn_5 as a double


% --- Executes during object creation, after setting all properties.
function edit_fn_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fn_6_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fn_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fn_6 as text
%        str2double(get(hObject,'String')) returns contents of edit_fn_6 as a double


% --- Executes during object creation, after setting all properties.
function edit_fn_6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_pf_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pf_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pf_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_pf_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_pf_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pf_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_pf_3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pf_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pf_3 as text
%        str2double(get(hObject,'String')) returns contents of edit_pf_3 as a double


% --- Executes during object creation, after setting all properties.
function edit_pf_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pf_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_pf_4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pf_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pf_4 as text
%        str2double(get(hObject,'String')) returns contents of edit_pf_4 as a double


% --- Executes during object creation, after setting all properties.
function edit_pf_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pf_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_pf_5_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pf_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pf_5 as text
%        str2double(get(hObject,'String')) returns contents of edit_pf_5 as a double


% --- Executes during object creation, after setting all properties.
function edit_pf_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pf_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_pf_6_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pf_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pf_6 as text
%        str2double(get(hObject,'String')) returns contents of edit_pf_6 as a double


% --- Executes during object creation, after setting all properties.
function edit_pf_6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pf_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_eig_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_eig_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_eig_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_eig_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_eig_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_eig_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_eig_3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_eig_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_eig_3 as text
%        str2double(get(hObject,'String')) returns contents of edit_eig_3 as a double


% --- Executes during object creation, after setting all properties.
function edit_eig_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_eig_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_eig_4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_eig_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_eig_4 as text
%        str2double(get(hObject,'String')) returns contents of edit_eig_4 as a double


% --- Executes during object creation, after setting all properties.
function edit_eig_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_eig_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_eig_5_Callback(hObject, eventdata, handles)
% hObject    handle to edit_eig_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_eig_5 as text
%        str2double(get(hObject,'String')) returns contents of edit_eig_5 as a double


% --- Executes during object creation, after setting all properties.
function edit_eig_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_eig_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_eig_6_Callback(hObject, eventdata, handles)
% hObject    handle to edit_eig_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_eig_6 as text
%        str2double(get(hObject,'String')) returns contents of edit_eig_6 as a double


% --- Executes during object creation, after setting all properties.
function edit_eig_6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_eig_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_accel_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_accel_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_accel_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_accel_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_accel_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_accel_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_accel_3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_accel_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_accel_3 as text
%        str2double(get(hObject,'String')) returns contents of edit_accel_3 as a double


% --- Executes during object creation, after setting all properties.
function edit_accel_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_accel_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_accel_4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_accel_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_accel_4 as text
%        str2double(get(hObject,'String')) returns contents of edit_accel_4 as a double


% --- Executes during object creation, after setting all properties.
function edit_accel_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_accel_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_accel_5_Callback(hObject, eventdata, handles)
% hObject    handle to edit_accel_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_accel_5 as text
%        str2double(get(hObject,'String')) returns contents of edit_accel_5 as a double


% --- Executes during object creation, after setting all properties.
function edit_accel_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_accel_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_accel_6_Callback(hObject, eventdata, handles)
% hObject    handle to edit_accel_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_accel_6 as text
%        str2double(get(hObject,'String')) returns contents of edit_accel_6 as a double


% --- Executes during object creation, after setting all properties.
function edit_accel_6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_accel_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units


% --- Executes during object creation, after setting all properties.
function listbox_units_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fn_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fn as text
%        str2double(get(hObject,'String')) returns contents of edit_fn as a double


% --- Executes during object creation, after setting all properties.
function edit_fn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_pf_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pf as text
%        str2double(get(hObject,'String')) returns contents of edit_pf as a double


% --- Executes during object creation, after setting all properties.
function edit_pf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ModeShapes_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ModeShapes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ModeShapes as text
%        str2double(get(hObject,'String')) returns contents of edit_ModeShapes as a double


% --- Executes during object creation, after setting all properties.
function edit_ModeShapes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ModeShapes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

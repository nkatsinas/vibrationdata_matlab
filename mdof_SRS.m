function varargout = mdof_SRS(varargin)
% MDOF_SRS MATLAB code for mdof_SRS.fig
%      MDOF_SRS, by itself, creates a new MDOF_SRS or raises the existing
%      singleton*.
%
%      H = MDOF_SRS returns the handle to a new MDOF_SRS or the handle to
%      the existing singleton*.
%
%      MDOF_SRS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MDOF_SRS.M with the given input arguments.
%
%      MDOF_SRS('Property','Value',...) creates a new MDOF_SRS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mdof_SRS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mdof_SRS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mdof_SRS

% Last Modified by GUIDE v2.5 20-Aug-2014 16:25:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mdof_SRS_OpeningFcn, ...
                   'gui_OutputFcn',  @mdof_SRS_OutputFcn, ...
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


% --- Executes just before mdof_SRS is made visible.
function mdof_SRS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mdof_SRS (see VARARGIN)

% Choose default command line output for mdof_SRS
handles.output = hObject;


listbox_method_Callback(hObject, eventdata, handles)

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mdof_SRS wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mdof_SRS_OutputFcn(hObject, eventdata, handles) 
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

k=get(handles.listbox_method,'Value');


 
if(k==1)
  FS=get(handles.edit_input_array,'String');
  THM=evalin('base',FS);   
else
  THM=getappdata(0,'THM');
end

num_srs=length(THM(:,1));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   fig_num=getappdata(0,'fig_num');
ModeShapes=getappdata(0,'ModeShapes');
        PF=getappdata(0,'pff');
        fn=getappdata(0,'fn');
        
      iu=getappdata(0,'unit');

num_fn=length(fn);      

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(fig_num);
fig_num=fig_num+1;
setappdata(0,'fig_num',fig_num);
plot(THM(:,1),THM(:,2));
grid on;
xlabel('Natural Frequency (Hz)');
ylabel('Peak Accel (G)');

Q=get(handles.edit_Q,'String');

out1=sprintf('SRS Q=%s',Q);

title(out1);
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(fn(1)<THM(1,1))
   warndlg(' First Natural Frequency < First Specification Frequency '); 
   return 
end  
if(fn(num_fn)>THM(num_srs,1))
   warndlg(' Last Natural Frequency < Last Specification Frequency ');
   return
end 

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
        
        PFM=PF(j)*ModeShapes(i,j);
        
    
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
disp(' Acceleration (G)');
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

msgbox('Results written to Command Window');





% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(mdof_SRS);



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



function edit_acceleration_results_Callback(hObject, eventdata, handles)
% hObject    handle to edit_acceleration_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_acceleration_results as text
%        str2double(get(hObject,'String')) returns contents of edit_acceleration_results as a double


% --- Executes during object creation, after setting all properties.
function edit_acceleration_results_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_acceleration_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_rd_results_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rd_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rd_results as text
%        str2double(get(hObject,'String')) returns contents of edit_rd_results as a double


% --- Executes during object creation, after setting all properties.
function edit_rd_results_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rd_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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

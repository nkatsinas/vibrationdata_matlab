function varargout = two_dof_transmissibility(varargin)
% TWO_DOF_TRANSMISSIBILITY MATLAB code for two_dof_transmissibility.fig
%      TWO_DOF_TRANSMISSIBILITY, by itself, creates a new TWO_DOF_TRANSMISSIBILITY or raises the existing
%      singleton*.
%
%      H = TWO_DOF_TRANSMISSIBILITY returns the handle to a new TWO_DOF_TRANSMISSIBILITY or the handle to
%      the existing singleton*.
%
%      TWO_DOF_TRANSMISSIBILITY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TWO_DOF_TRANSMISSIBILITY.M with the given input arguments.
%
%      TWO_DOF_TRANSMISSIBILITY('Property','Value',...) creates a new TWO_DOF_TRANSMISSIBILITY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before two_dof_transmissibility_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to two_dof_transmissibility_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help two_dof_transmissibility

% Last Modified by GUIDE v2.5 20-Jan-2015 10:38:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @two_dof_transmissibility_OpeningFcn, ...
                   'gui_OutputFcn',  @two_dof_transmissibility_OutputFcn, ...
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


% --- Executes just before two_dof_transmissibility is made visible.
function two_dof_transmissibility_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to two_dof_transmissibility (see VARARGIN)

% Choose default command line output for two_dof_transmissibility
handles.output = hObject;


set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes two_dof_transmissibility wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = two_dof_transmissibility_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in calculate_pushbutton.
function calculate_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to calculate_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


fmin=str2num(get(handles.fstart_edit,'String'));
  fmax=str2num(get(handles.fend_edit,'String'));
  
    if(fmin<=0.01)
        fmin=0.01;
    end    

   fig_num=getappdata(0,'fig_num');
      damp=getappdata(0,'damping');
ModeShapes=getappdata(0,'ModeShapes');
        fn=getappdata(0,'fn');
      unit=getappdata(0,'unit');
        m2=getappdata(0,'m2');      

omegan=2*pi*fn;        
        
MST=ModeShapes';
%
sz=size(ModeShapes);
dof=(sz(1));
num=dof;
%
N=96;
%
[freq,omega,np]=frequencies_octave_spaced(fmin,fmax,N);

om2=omega.^2;
%
omn2=omegan.^2;
%
two_damp_omegan=zeros(2,1);
%
for i=1:dof 
    two_damp_omegan(i)=2*damp(i)*omegan(i);
end
%
out1=sprintf('\n number of dofs =%d \n',num);
disp(out1);
%
%
%  Being main loop ********************************************************
%
%  np=number of excitation frequencies
%   
%
     rd=zeros(np,dof);
     rdm2m1=zeros(np,1);
    acc=zeros(np,dof);
%
    mass(1)=m2(1,1);
    mass(2)=m2(2,2);
%
    mm=[mass(1); mass(2)];
%
    Y=-MST*mm;
%
    for i=1:np 
%
         n=zeros(2,1);
%
        for j=1:dof
           A=Y(j);
           den= (omn2(j)-om2(i)) + (1i)*(two_damp_omegan(j)*omega(i));
           n(j)=A/den;
        end
        na=-om2(i)*n;
%
         rd(i,:)=ModeShapes*n;
        acc(i,:)=ModeShapes*na;
        acc(i,:)=acc(i,:)+1;  
%
        rdm2m1(i,1)=rd(i,2)-rd(i,1);
%
    end 
%
     rd=abs(rd);
     rdm2m1=abs(rdm2m1);
    acc=abs(acc);
%
    if(unit==1)
      rd_trans=[freq 386*rd];
      rdm2m1_trans=[freq 386*rdm2m1];
    else
      rd_trans=[freq 9.81*rd];   
      rdm2m1_trans=[freq 9.81*rdm2m1];      
    end

%
    
    ppp1=[freq acc(:,1)];
    ppp2=[freq acc(:,2)];
    
    leg1='Mass 1';
    leg2='Mass 2';
    
    t_string=' Accel Transmissibility Magnitude';
    
    x_label='Frequency (Hz)';
    y_label='Trans (G/G)';
    
    md=5;
    
    [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
    md=5;
    x_label='Frequency (Hz)';
    if(unit==1)
        y_label='Trans (in/G)';
    else
        y_label='Trans (m/G)';       
    end
    
    ppp1=[freq  rd_trans(:,2)];
    ppp2=[freq  rd_trans(:,3)];
    ppp3=[freq  rdm2m1_trans(:,2)];
    
    leg1='mass 1 - base';
    leg2='mass 2 - base';
    leg3='mass 2 - mass 1';  
    
    t_string=' Rel Disp Transmissibility Magnitude';
    
    [fig_num,h2]=plot_loglog_function_md_three_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,leg1,leg2,leg3,fmin,fmax,md);
    
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' View plots.');
%
    trans(:,1)=freq;
    trans(:,2)=acc(:,1);
    trans(:,3)=acc(:,2);
%
    power_trans(:,1)=freq; 
%
    rd_power_trans(:,1)=freq;

%
    clear length;
    nnn=length(freq);
%
    for i=1:nnn
        for j=2:3
           power_trans(i,j)=(trans(i,j))^2;    
           rd_power_trans(i,j)=(rd_trans(i,j))^2;   
        end
    end
%
    setappdata(0,'trans',trans);           
%
    setappdata(0,'power_trans',power_trans);  
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    setappdata(0,'rd_trans',rd_trans); 
    setappdata(0,'rdm2m1_trans',rdm2m1_trans);     
%
%   
frf_flag=1;
setappdata(0,'frf_flag',frf_flag);

setappdata(0,'fig_num',fig_num); 

set(handles.uipanel_save,'Visible','on');

msgbox('Calculation complete.  See External Plots.  ');



function fstart_edit_Callback(hObject, eventdata, handles)
% hObject    handle to fstart_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fstart_edit as text
%        str2double(get(hObject,'String')) returns contents of fstart_edit as a double


% --- Executes during object creation, after setting all properties.
function fstart_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fstart_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fend_edit_Callback(hObject, eventdata, handles)
% hObject    handle to fend_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fend_edit as text
%        str2double(get(hObject,'String')) returns contents of fend_edit as a double


% --- Executes during object creation, after setting all properties.
function fend_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fend_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(two_dof_transmissibility);


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_save,'Value');

m=get(handles.listbox_trans_type,'Value');
 
if(n==1)
    qdata=getappdata(0,'trans');
    data=[qdata(:,1) qdata(:,2)];
end
if(n==2)
    qdata=getappdata(0,'trans');
    data=[qdata(:,1) qdata(:,3)];    
end
if(n==3)
    qdata=getappdata(0,'rd_trans');
    data=[qdata(:,1) qdata(:,2)];    
end
if(n==4)
    qdata=getappdata(0,'rd_trans');
    data=[qdata(:,1) qdata(:,3)];    
end
if(n==5)
    qdata=getappdata(0,'rdm2m1_trans');
    data=[qdata(:,1) qdata(:,2)];    
end

if(m==2)
    data=fix_size(data);
    sz=size(data);
    
    for i=1:sz(1)
        data(i,2)=data(i,2)^2;
    end

end
    
    
output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);
 
msgbox('Data saved');


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



function edit_output_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_trans_type.
function listbox_trans_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_trans_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_trans_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_trans_type


% --- Executes during object creation, after setting all properties.
function listbox_trans_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_trans_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

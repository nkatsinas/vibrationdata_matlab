function varargout = vibrationdata_cantilever_beam_fth(varargin)
% VIBRATIONDATA_CANTILEVER_BEAM_FTH MATLAB code for vibrationdata_cantilever_beam_fth.fig
%      VIBRATIONDATA_CANTILEVER_BEAM_FTH, by itself, creates a new VIBRATIONDATA_CANTILEVER_BEAM_FTH or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_CANTILEVER_BEAM_FTH returns the handle to a new VIBRATIONDATA_CANTILEVER_BEAM_FTH or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_CANTILEVER_BEAM_FTH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_CANTILEVER_BEAM_FTH.M with the given input arguments.
%
%      VIBRATIONDATA_CANTILEVER_BEAM_FTH('Property','Value',...) creates a new VIBRATIONDATA_CANTILEVER_BEAM_FTH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_cantilever_beam_fth_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_cantilever_beam_fth_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_cantilever_beam_fth

% Last Modified by GUIDE v2.5 10-Apr-2017 17:50:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_cantilever_beam_fth_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_cantilever_beam_fth_OutputFcn, ...
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


% --- Executes just before vibrationdata_cantilever_beam_fth is made visible.
function vibrationdata_cantilever_beam_fth_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_cantilever_beam_fth (see VARARGIN)

% Choose default command line output for vibrationdata_cantilever_beam_fth
handles.output = hObject;


iu=getappdata(0,'unit');
L=getappdata(0,'length');

if(iu==1)
%    set(handles.length_unit,'String','inch');
    LS=sprintf('Beam Length = %g inch',L);
else
%    set(handles.length_unit,'String','meters');
    LS=sprintf('Beam Length = %g meters',L);
end

set(handles.uipanel_save,'Visible','off');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_cantilever_beam_fth wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_cantilever_beam_fth_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_cantilever_beam_fth);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig_num=getappdata(0,'fig_num');
      damp=getappdata(0,'damp_ratio');
        fn=getappdata(0,'fn');
      iu=getappdata(0,'unit');
      Q=getappdata(0,'Q');
      part=getappdata(0,'part');
 
      beta=getappdata(0,'beta');
      
      E=getappdata(0,'E');  
      MOI=getappdata(0,'I'); 
      cna=getappdata(0,'cna');       

%      LBC=getappdata(0,'LBC');
%      RBC=getappdata(0,'RBC');
 
      LBC=1;
      RBC=3;

      mass=getappdata(0,'mass');      
      sq_mass=sqrt(mass);
   
      beta=getappdata(0,'beta');
      C=getappdata(0,'C');
      
      L=getappdata(0,'length'); 
       
    [ModeShape,ModeShape_dd]=beam_bending_modes_shapes(LBC,RBC);

   n=length(fn);
%
   disp(' ');
%
   YY=zeros(n,1);
   YYdd=zeros(n,1);
   
   for i=1:n
        arg=beta(i)*L;
        YY(i)=ModeShape(arg,C(i),sq_mass);
 
        arg=beta(i)*0;
        YYdd(i)=ModeShape_dd(arg,C(i),beta(i),sq_mass);
   end
%
%%%%%%%%%%%

FS=get(handles.edit_input,'String');
%
THM=evalin('base',FS);
%
    t=THM(:,1);
    num_steps=length(t);
    force=THM(:,2);
    num=length(t);
    tt=t;
%
    dt=(t(num)-t(1))/(num-1);
%
    sr=1./dt;
%
    disp(' ')
    disp(' Time Step ');
    dtmin=min(diff(t));
    dtmax=max(diff(t));
%
    out4 = sprintf(' dtmin  = %8.4g sec  ',dtmin);
    out5 = sprintf(' dt     = %8.4g sec  ',dt);
    out6 = sprintf(' dtmax  = %8.4g sec  ',dtmax);
    disp(out4)
    disp(out5)
    disp(out6)
%
    disp(' ')
    disp(' Sample Rate ');
    out4 = sprintf(' srmin  = %8.4g samples/sec  ',1/dtmax);
    out5 = sprintf(' sr     = %8.4g samples/sec  ',1/dt);
    out6 = sprintf(' srmax  = %8.4g samples/sec  \n',1/dtmin);
    disp(out4)
    disp(out5)
    disp(out6)
%
if(((dtmax-dtmin)/dt)>0.01)
    disp(' ')
    disp(' Warning:  time step is not constant.')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   
    nd=zeros(num_steps,1);
    nv=zeros(num_steps,1);
    na=zeros(num_steps,1); 
    nbm=zeros(num_steps,1);
%     
%
    [a1,a2,a_b1,a_b2,a_b3,v_b1,v_b2,v_b3,d_b1,d_b2,d_b3]=...
                                      srs_coefficients_avd(fn,damp,dt);

%%%%%%%%%%%  

    num_fn=get(handles.listbox_num_modes,'Value');
    
    d=zeros(num_steps,1);
    v=zeros(num_steps,1);
    a=zeros(num_steps,1);    
    bm=zeros(num_steps,1);    
                                  
    ZZ=zeros(n,num_fn);
%
    for j=1:num_fn
%
            yp=force*YY(j);
%
            back   =[     1, -a1(j), -a2(j) ];
%
%   velocity
%
            clear forward;
            forward=[ v_b1(j),  v_b2(j),  v_b3(j) ];    
            nv=filter(forward,back,yp);
%
%   displacement
%
            clear forward;
            forward=[ d_b1(j),  d_b2(j),  d_b3(j) ];      
            nd=filter(forward,back,yp);
            nbm=nd;
%
%   acceleration
%
            clear forward;  
            forward=[ a_b1(j),  a_b2(j),  a_b3(j) ];    
            na=filter(forward,back,yp);     
%
            arg=beta(j)*L;
            
            ZZ=ModeShape(arg,C(j),sq_mass);
            
            d= d +ZZ*nd;
            v= v +ZZ*nv;
            a= a +ZZ*na;               
           
            arg=beta(j)*0;
            ZZdd=ModeShape_dd(arg,C(j),beta(j),sq_mass);
            bm= bm +ZZdd*nbm;  
%        
    end
    
%%%%%%%%%%%

    bm=bm*E*MOI;
    
    bstress=bm*(cna/MOI);
    
%
    if(iu==1)
        a=a/386;
        
    else
        d=d*1000;
        a=a/9.81;        
    end
%    

%%%%%%%%%%%

disp(' ');
disp(' Peak Response at Beam Free End ');

out1=sprintf('\n  Acceleration = %8.4g G ',max(abs(a(:,1))));

if(iu==1)
	out2=sprintf('\n      Velocity = %8.4g in/sec ',max(abs(v(:,1))));
	out3=sprintf('\n  Displacement = %8.4g in ',max(abs(d(:,1))));
else
	out2=sprintf('\n      Velocity = %8.4g m/sec ',max(abs(v(:,1))));
	out3=sprintf('\n  Displacement = %8.4g mm ',max(abs(d(:,1))));
end

disp(out1);
disp(out2);
disp(out3);


disp(' ');
disp(' Peak Response at Beam Fixed End ');

if(iu==1)
    out1=sprintf('\n  Bending Stress = %8.4g psi ',max(abs(bstress(:,1))));
      out2=sprintf('                 = %8.4g ksi ',(1/1000)*max(abs(bstress(:,1))));    
    disp(out1);
    disp(out2);    
else
    out1=sprintf('\n  Bending Stress = %8.4g Pa ',max(abs(bstress(:,1))));
    disp(out1);
end




%%%%%%%%%%%

    figure(fig_num)
    fig_num=fig_num+1;
    plot(t,a,'b');
    title('Acceleration at Free End');
    ylabel('Accel (G)');
    xlabel('Time (sec)');
    grid on;
    
    figure(fig_num)
    fig_num=fig_num+1;
    plot(t,v,'b');
    title('Velocity at Free End');
    if(iu==1)
        ylabel('Vel (in/sec)');
    else
        ylabel('Vel (m/sec)');        
    end
    xlabel('Time (sec)');
    grid on;    

    figure(fig_num)
    fig_num=fig_num+1;
    plot(t,d,'b');
    if(iu==1)
        ylabel('Disp (in)');
    else
        ylabel('Disp (mm)');        
    end
    title('Displacement at Free End');
    xlabel('Time (sec)');
    grid on;      
    

    figure(fig_num)
    fig_num=fig_num+1;
    plot(t,bstress,'b');
    if(iu==1)
        ylabel('Stress (psi)');
    else
        ylabel('Stress (Pa)');        
    end
    title('Bending Stress at Fixed End');
    xlabel('Time (sec)');
    grid on;      
    
%%%%%%%%%%%
%

    disp(' ');

    setappdata(0,'acceleration',[t a]);
    setappdata(0,'velocity',[t v]);    
    setappdata(0,'displacement',[t d]);    
    setappdata(0,'bending_stress',[t bstress]);        
    
    
    set(handles.uipanel_save,'Visible','on');
    
    msgbox('Calculation complete.  Output written to Matlab Command Window.');
%



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



function x_edit_Callback(hObject, eventdata, handles)
% hObject    handle to x_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x_edit as text
%        str2double(get(hObject,'String')) returns contents of x_edit as a double


% --- Executes during object creation, after setting all properties.
function x_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_edit (see GCBO)
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

if(n==1)
    data=getappdata(0,'displacement');
end
if(n==2)
   data=getappdata(0,'velocity');
end
if(n==3)
    data=getappdata(0,'acceleration');
end
if(n==4)
    data=getappdata(0,'bending_stress');
end


output_name=get(handles.edit_output_array_name,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete');


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



function edit_input_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input as text
%        str2double(get(hObject,'String')) returns contents of edit_input as a double


% --- Executes during object creation, after setting all properties.
function edit_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_num_modes.
function listbox_num_modes_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num_modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num_modes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num_modes


% --- Executes during object creation, after setting all properties.
function listbox_num_modes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_num_modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

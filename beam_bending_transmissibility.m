function varargout = beam_bending_transmissibility(varargin)
% BEAM_BENDING_TRANSMISSIBILITY MATLAB code for beam_bending_transmissibility.fig
%      BEAM_BENDING_TRANSMISSIBILITY, by itself, creates a new BEAM_BENDING_TRANSMISSIBILITY or raises the existing
%      singleton*.
%
%      H = BEAM_BENDING_TRANSMISSIBILITY returns the handle to a new BEAM_BENDING_TRANSMISSIBILITY or the handle to
%      the existing singleton*.
%
%      BEAM_BENDING_TRANSMISSIBILITY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BEAM_BENDING_TRANSMISSIBILITY.M with the given input arguments.
%
%      BEAM_BENDING_TRANSMISSIBILITY('Property','Value',...) creates a new BEAM_BENDING_TRANSMISSIBILITY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before beam_bending_transmissibility_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to beam_bending_transmissibility_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help beam_bending_transmissibility

% Last Modified by GUIDE v2.5 27-Dec-2018 14:25:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @beam_bending_transmissibility_OpeningFcn, ...
                   'gui_OutputFcn',  @beam_bending_transmissibility_OutputFcn, ...
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


% --- Executes just before beam_bending_transmissibility is made visible.
function beam_bending_transmissibility_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to beam_bending_transmissibility (see VARARGIN)

% Choose default command line output for beam_bending_transmissibility
handles.output = hObject;

iu=getappdata(0,'unit');
L=getappdata(0,'length');

if(iu==1)
    set(handles.length_unit,'String','inch');
    LS=sprintf('Beam Length = %g inch',L);
else
    set(handles.length_unit,'String','meters');
    LS=sprintf('Beam Length = %g meters',L);
end

set(handles.uipanel_save,'Visible','off');

set(handles.beam_length,'String',LS);

    
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes beam_bending_transmissibility wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = beam_bending_transmissibility_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Calculate_pushbutton.
function Calculate_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Calculate_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * ');
disp(' ');

number_modes=get(handles.listbox_number_modes,'Value');

  fig_num=1;
      damp=getappdata(0,'damp_ratio');
        fn=getappdata(0,'fn');
      iu=getappdata(0,'unit');
      Q=getappdata(0,'Q');
      part=getappdata(0,'part');
 
      beta=getappdata(0,'beta');
      
      LBC=getappdata(0,'LBC');
      RBC=getappdata(0,'RBC');
      
      fstart=str2num(get(handles.fstart_edit,'String'));
      
      if(fstart==0)
          fstart=1;
      end
      
      fend=str2num(get(handles.fend_edit,'String'));
      x=str2num(get(handles.x_edit,'String')); 
      
      sq_mass=getappdata(0,'sq_mass');
      beta=getappdata(0,'beta');
      C=getappdata(0,'C');
      cna=getappdata(0,'cna');
            
      EI_term=getappdata(0,'EI_term');
            I=getappdata(0,'I');
            E=getappdata(0,'E');
      
     clear f;
   nf=1000;

%
   disp(' ');
   fmax=fend;
   
   N=48;
   fmin=fstart;
   [f,~,~]=frequencies_octave_spaced(fmin,fmax,N);

   fn=fn(1:number_modes);
   
   [acc_trans,rv_trans,rd_trans,moment_trans,shear_trans]=...
          beam_bending_trans_core_alt(beta,C,sq_mass,x,iu,LBC,RBC,f,part,fn,damp,E,I);   
      
   stress_trans=moment_trans;
   
   fprintf('  cna=%8.4g  I=%8.4g  cna/I=%8.4g \n',cna,I,cna/I);
   
   stress_trans(:,2)=stress_trans(:,2)*cna/I;
 
   
    [maxF,maxH]=find_max_alt(rd_trans);
    [maxFV,maxHV]=find_max_alt(rv_trans);    
    [maxFA,maxHA]=find_max_alt(acc_trans);  
    [maxFBM,maxHBM]=find_max_alt(moment_trans);
    [maxFSH,maxHSH]=find_max_alt(shear_trans);    
    [maxFST,maxHST]=find_max_alt(stress_trans);      

    md=6;
    x_label='Frequency (Hz)';
    
%%%
    if(iu==1)
        out1=sprintf('\n Response Location: x=%g inches\n',x);
    else
        out1=sprintf('\n Response Location: x=%g meters \n',x);        
    end
    disp(out1); 
%%%
%%%

    fmin=fstart;
    fend=fmax;

    [xtt,xTT,iflag]=xtick_label(fmin,fmax);

%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%
    if(iu==1)
        t_string=sprintf('Relative Displacement Frequency Response Function  x=%g inch',x);
        y_label='Rel Disp (in)/ Base Accel (G)';
    else
        t_string=sprintf('Relative Displacement Frequency Response Function  x=%g m',x);
        y_label='Rel Disp (m)/ Base Accel (G)';        
    end
 
    try
        ppp=rd_trans;
        if(min(ppp(:,2))>1.e-90)
            [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);
        end    
    catch
    end
%
  
    disp(' ');
    if(iu==1)
        out1=sprintf('  max Rel Disp FRF = %9.5f (in/G) at %8.4g Hz ',maxH,maxF);
    else
        out1=sprintf('  max Rel Disp FRF = %9.5f (m/G) at %8.4g Hz ',maxH,maxF);       
    end
    disp(out1);
%
    relative_disp=rd_trans;
%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%
    if(iu==1)
        t_string=sprintf('Relative Velocity Frequency Response Function  x=%g inch',x);
        y_label='Rel Vel (in/sec)/ Base Accel (G)';
    else
        t_string=sprintf('Relative Velocity Frequency Response Function  x=%g m',x);
        y_label='Rel Vel (m/sec)/ Base Accel (G)';        
    end
    
    try
        ppp=rv_trans;
        if(min(ppp(:,2))>1.e-90)
            [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);
        end
    catch
    end
%
    disp(' ');
    try
    
        if(iu==1)
            out1=sprintf('  max Rel Vel FRF = %9.5f ((in/sec)/G) at %8.4g Hz ',maxHV,maxFV);
        else
            out1=sprintf('  max Rel Vel FRF = %9.5f ((m/sec)/G) at %8.4g Hz ',maxHV,maxFV);       
        end
        disp(out1);
    catch 
    end
%
    relative_vel=rv_trans;
%%%

    if(iu==1)
        t_string=sprintf('Acceleration Frequency Response Function  x=%g inch',x);
    else
        t_string=sprintf('Acceleration Frequency Response Function  x=%g m',x);        
    end
    y_label='Absolute Accel / Base Accel';    
    
    ppp=acc_trans; 
    
    [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);
        
    fprintf('\n  max Absolute Accel FRF = %8.4g (G/G) at %8.4g Hz \n',maxHA,maxFA);
%
    absolute_accel=acc_trans;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    if(iu==1)
        t_string=sprintf('Bending Moment Frequency Response Function  x=%g inch',x);
        y_label='Moment (lbf-in)/ Base Accel (G)';
    else
        t_string=sprintf('Bending Moment Frequency Response Function  x=%g m',x);
        y_label='Moment (N-m)/ Base Accel (G)';        
    end
%
    ppp=moment_trans;
    try
        [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);
    catch
    end
%
    if(iu==1)
        out1=sprintf('  max Bending Moment FRF = %9.5g (lbf-in/G) at %8.4g Hz ',maxHBM,maxFBM);
    else
        out1=sprintf('  max Bending Moment FRF = %9.5g (N-m/G) at %8.4g Hz ',maxHBM,maxFBM);       
    end
    disp(out1);
%
    bending_moment=moment_trans;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    if(iu==1)
        t_string=sprintf('Shear Force Frequency Response Function  x=%g inch',x);
        y_label='Shear (lbf)/ Base Accel (G)';
    else
        t_string=sprintf('Shear Force Frequency Response Function  x=%g m',x);
        y_label='Shear (N)/ Base Accel (G)';        
    end
%
    ppp=shear_trans;
    try
        [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);
    catch
    end
%
    if(iu==1)
        out1=sprintf('  max Shear Force FRF = %9.5g (lbf/G) at %8.4g Hz ',maxHSH,maxFSH);
    else
        out1=sprintf('  max Shear Force FRF = %9.5g (N/G) at %8.4g Hz ',maxHSH,maxFSH);       
    end
    disp(out1);
%
    shear_force=shear_trans;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    ppp=stress_trans;

    if(iu==1)
        t_string=sprintf('Bending Stress Frequency Response Function  x=%g inch',x);
        y_label='Stress (psi) / Base Accel (G)';
    else
        t_string=sprintf('Bending Stress Frequency Response Function  x=%g m',x);
        y_label='Stress (Pa) / Base Accel (G)';        
    end

    try
        [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);
    catch
    end
        
    if(iu==1)
        out1=sprintf('  max Bending Stress FRF = %9.5g (psi/G) at %8.4g Hz ',maxHST,maxFST);
    else
        out1=sprintf('  max Bending Stress FRF = %9.5g (Pa/G) at %8.4g Hz ',maxHST,maxFST);       
    end
    disp(out1);
%
    bending_stress=stress_trans;
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    setappdata(0,'absolute_accel',absolute_accel);
    setappdata(0,'relative_vel',relative_vel);    
    setappdata(0,'relative_disp',relative_disp);    
    setappdata(0,'bending_moment',bending_moment);   
    setappdata(0,'shear_force',shear_force);        
    setappdata(0,'bending_stress',bending_stress);     
    
    set(handles.uipanel_save,'Visible','on');
    
    msgbox('Calculation complete.  Output written to Matlab Command Window.');
%


      
    
% --- Executes on button press in Return_pushbutton.
function Return_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Return_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(beam_bending_transmissibility)


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
    data=getappdata(0,'absolute_accel');
end
if(n==2)
   data=getappdata(0,'relative_vel');
end
if(n==3)
    data=getappdata(0,'relative_disp');
end
if(n==4)
    data=getappdata(0,'bending_moment');
end
if(n==5)
    data=getappdata(0,'shear_force');
end
if(n==6)
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


% --- Executes on selection change in listbox_number_modes.
function listbox_number_modes_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_number_modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_number_modes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_number_modes


% --- Executes during object creation, after setting all properties.
function listbox_number_modes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_number_modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

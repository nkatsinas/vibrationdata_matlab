function varargout = vibrationdata_cantilever_beam_frf(varargin)
% VIBRATIONDATA_CANTILEVER_BEAM_FRF MATLAB code for vibrationdata_cantilever_beam_frf.fig
%      VIBRATIONDATA_CANTILEVER_BEAM_FRF, by itself, creates a new VIBRATIONDATA_CANTILEVER_BEAM_FRF or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_CANTILEVER_BEAM_FRF returns the handle to a new VIBRATIONDATA_CANTILEVER_BEAM_FRF or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_CANTILEVER_BEAM_FRF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_CANTILEVER_BEAM_FRF.M with the given input arguments.
%
%      VIBRATIONDATA_CANTILEVER_BEAM_FRF('Property','Value',...) creates a new VIBRATIONDATA_CANTILEVER_BEAM_FRF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_cantilever_beam_frf_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_cantilever_beam_frf_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_cantilever_beam_frf

% Last Modified by GUIDE v2.5 07-Sep-2021 19:33:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_cantilever_beam_frf_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_cantilever_beam_frf_OutputFcn, ...
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


% --- Executes just before vibrationdata_cantilever_beam_frf is made visible.
function vibrationdata_cantilever_beam_frf_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_cantilever_beam_frf (see VARARGIN)

% Choose default command line output for vibrationdata_cantilever_beam_frf
handles.output = hObject;

set(handles.pushbutton_psd,'Enable','off');

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

set(handles.beam_length,'String',LS);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_cantilever_beam_frf wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_cantilever_beam_frf_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_cantilever_beam_frf);


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

      fstart=str2num(get(handles.fstart_edit,'String'));
      fend=str2num(get(handles.fend_edit,'String'));
      
      
      mass=getappdata(0,'mass');


      
      sq_mass=sqrt(mass);


      
      beta=getappdata(0,'beta');
      C=getappdata(0,'C');
      
      L=getappdata(0,'length'); 
       
    [ModeShape,ModeShape_dd]=beam_bending_modes_shapes(LBC,RBC);

     clear f;
   nf=1000;
   n=length(fn);
%
   disp(' ');
   fmax=fend;
%
   f=zeros(nf,1);
   f(1)=fstart;
   for k=2:nf
        f(k)=f(k-1)*2^(1/48);
        if(f(k)>fmax)
            break;
        end    
   end
   nf=max(size(f));
   
   YY=zeros(n,1);
   YYdd=zeros(n,1);
   
   for i=1:n
        arg=beta(i)*L;
        YY(i)=ModeShape(arg,C(i),sq_mass);
 
        arg=beta(i)*0;
        YYdd(i)=ModeShape_dd(arg,C(i),beta(i),sq_mass);
   end
%
   H_d=zeros(nf,1);
   H_v=zeros(nf,1);   
   H_a=zeros(nf,1);
   H_moment=zeros(nf,1);
 %
 
   for k=1:nf
       
        om=2*pi*f(k);
        
        for i=1:n
            
            omn=2*pi*fn(i);
            num=YY(i)^2;
            den=(omn^2-om^2)+(1i)*2*damp(i)*om*omn;
       
            H_d(k)=H_d(k)+(num/den);
            
            num_moment=YY(i)*YYdd(i);
            
            H_moment(k)=H_moment(k)+E*MOI*(num_moment/den);
            
        end
        
        H_v(k)=(1i)*om*H_d(k);       
        H_a(k)=-om^2*H_d(k);
        
   end
%
    H_d=abs(H_d);
    H_v=abs(H_v);    
    H_a=abs(H_a);  
    H_moment=abs(H_moment);
    H_stress=H_moment*cna/MOI;
%
    if(iu==1)
        H_a=H_a/386;
    else
        H_a=H_a/9.81;          
    end
%
    maxHd=0.;
    maxHv=0.;    
    maxHa=0.;
    maxHs=0.;
    maxFd=0.;
    maxFv=0.;
    maxFa=0.;    
    maxFs=0;
%
    out1=sprintf('\n nf=%d \n',nf);
    disp(out1);   
%
    for k=1:nf
        if(H_d(k)>maxHd)
            maxHd=H_d(k);
            maxFd=f(k);
        end
        if(H_v(k)>maxHv)
            maxHv=H_v(k);
            maxFv=f(k);
        end        
        if(H_a(k)>maxHa)
            maxHa=H_a(k);
            maxFa=f(k);
        end
        if(H_stress(k)>maxHs)
            maxHs=H_stress(k);
            maxFs=f(k);
        end      
    end       
%
    H_d=fix_size(H_d);
    H_v=fix_size(H_v);
    H_a=fix_size(H_a);
    H_stress=fix_size(H_stress);
%
    n=length(f);
    for i=n:-1:1
%
       if(f(i)==0)
             f(i)=[];
           H_d(i)=[];
           H_v(i)=[]; 
           H_a(i)=[];  
           H_stress(i)=[];
       end
%
    end
   
    
%%%

    out1=sprintf('\n Response at Free End');
    disp(out1); 
%%%

    md=5;
    fmin=fstart;
    fmax=fend;
    x_label='Frequency (Hz)';


%%%    
  
    t_string='Displacement Frequency Response Function at Free End';
    
    ppp=[f H_d];
        
    if(iu==1)
        y_label='Disp (in) / Force (lbf)';
    else
        y_label='Disp (m) / Force(N)';        
    end
    
    [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md); 
    
    if(iu==1)
        out1=sprintf('  max Disp FRF = %9.5f (in/lbf) at %8.4g Hz ',maxHd,maxFd);
    else
        out1=sprintf('  max Disp FRF = %9.5f (m/N) at %8.4g Hz ',maxHd,maxFd);       
    end
    disp(out1);
%
    clear disp;
    displacement=[f H_d];
%%%
%%%

    ppp=[f H_v];
%
    t_string='Velocity Frequency Response Function at Free End';
    if(iu==1)
        y_label='Vel (in/sec) / Force (lbf)';
    else
        y_label='Vel (m/sec) / Force (N)';        
    end
%
   [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);
%

    if(iu==1)
        out1=sprintf('  max Vel FRF = %9.5f ((in/sec)/lbf) at %8.4g Hz ',maxHv,maxFv);
    else
        out1=sprintf('  max Vel FRF = %9.5f ((m/sec)/N) at %8.4g Hz ',maxHv,maxFv);       
    end
    disp(out1);
%
    clear velocity;
    velocity=[f H_v];
%%%
%%%
%%%

    ppp=[f H_a];
    t_string='Acceleration Frequency Response Function at Free End';
%    
    if(iu==1)
        y_label='Accel (G) / Force (lbf) ';
    else
        y_label='Accel (G) / Force (N) ';        
    end
    
   [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);    
  
    if(iu==1)
        out1=sprintf('  max Absolute Accel FRF = %8.4g (G/lbf) at %8.4g Hz ',maxHa,maxFa);
    else
        out1=sprintf('  max Absolute Accel FRF = %8.4g (G/N) at %8.4g Hz ',maxHa,maxFa);        
    end
    disp(out1);
%
    clear acceleration;
    acceleration=[f H_a];
%
%%%%%%%%%%%
%
    ppp=[f H_stress];
    t_string='Bending Stress Frequency Response Function at Fixed End';
%    
    if(iu==1)
        y_label='Stress (psi) / Force (lbf) ';
    else
        y_label='Stress (Pa) / Force (N) ';        
    end
    
   [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);    
  
    if(iu==1)
        out1=sprintf('  max Bending Stress FRF = %8.4g (psi/lbf) at %8.4g Hz ',maxHs,maxFs);
    else
        out1=sprintf('  max Bending Stress FRF = %8.4g (Pa/N) at %8.4g Hz ',maxHs,maxFs);        
    end
    disp(out1);
%
    clear bending_stress;
    bending_stress=[f H_stress];

%
%%%%%%%%%%%
%

    disp(' ');

    setappdata(0,'acceleration',acceleration);
    setappdata(0,'velocity',velocity);    
    setappdata(0,'displacement',displacement);    
    setappdata(0,'bending_stress',bending_stress);        
    
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

set(handles.pushbutton_psd,'Enable','on');

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


% --- Executes on button press in pushbutton_psd.
function pushbutton_psd_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_psd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=vibrationdata_input_trans_mult;

set(handles.s,'Visible','on');

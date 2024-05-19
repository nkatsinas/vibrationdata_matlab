function varargout = beam_uniform_force_length_frf(varargin)
% BEAM_UNIFORM_FORCE_LENGTH_FRF MATLAB code for beam_uniform_force_length_frf.fig
%      BEAM_UNIFORM_FORCE_LENGTH_FRF, by itself, creates a new BEAM_UNIFORM_FORCE_LENGTH_FRF or raises the existing
%      singleton*.
%
%      H = BEAM_UNIFORM_FORCE_LENGTH_FRF returns the handle to a new BEAM_UNIFORM_FORCE_LENGTH_FRF or the handle to
%      the existing singleton*.
%
%      BEAM_UNIFORM_FORCE_LENGTH_FRF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BEAM_UNIFORM_FORCE_LENGTH_FRF.M with the given input arguments.
%
%      BEAM_UNIFORM_FORCE_LENGTH_FRF('Property','Value',...) creates a new BEAM_UNIFORM_FORCE_LENGTH_FRF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before beam_uniform_force_length_frf_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to beam_uniform_force_length_frf_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help beam_uniform_force_length_frf

% Last Modified by GUIDE v2.5 16-Sep-2015 13:52:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @beam_uniform_force_length_frf_OpeningFcn, ...
                   'gui_OutputFcn',  @beam_uniform_force_length_frf_OutputFcn, ...
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


% --- Executes just before beam_uniform_force_length_frf is made visible.
function beam_uniform_force_length_frf_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to beam_uniform_force_length_frf (see VARARGIN)

% Choose default command line output for beam_uniform_force_length_frf
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

% UIWAIT makes beam_uniform_force_length_frf wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = beam_uniform_force_length_frf_OutputFcn(hObject, eventdata, handles) 
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

delete(beam_uniform_force_length_frf);


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
      
      LBC=getappdata(0,'LBC');
      RBC=getappdata(0,'RBC');
      
      fstart=str2num(get(handles.fstart_edit,'String'));
      fend=str2num(get(handles.fend_edit,'String'));
      x=str2num(get(handles.x_edit,'String')); 
      
      sq_mass=getappdata(0,'sq_mass');
      beta=getappdata(0,'beta');
      C=getappdata(0,'C');
      
      L=getappdata(0,'length');      
      
      rho=(sq_mass^2)/L;
      
 
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
   for i=1:n
        arg=beta(i)*x;
        YY(i)=ModeShape(arg,C(i),sq_mass);
   end
%
   H_d=zeros(nf,1);
   H_v=zeros(nf,1);   
   H_a=zeros(nf,1);
 %
   out1=sprintf('\n rho=%8.4g \n',rho);
   disp(out1);
 %
   for k=1:nf 
        H_d(k)=0;
        om=2*pi*f(k);
        for i=1:n
            pY=part(i)*YY(i);
            
%%            if(k==1)
%%               out1=sprintf(' %d  %8.4g  %8.4g',i,part(i),YY(i));
%%               disp(out1); 
%%            end
            
            omn=2*pi*fn(i);
            num=pY;
            den=(omn^2-om^2)+(1i)*2*damp(i)*om*omn;
            H_d(k)=H_d(k)+(num/den)/rho;
%
        end
        H_v(k)=(1i)*om*H_d(k);       
        H_a(k)=-om^2*H_d(k);
   end
%
    H_d=abs(H_d);
    H_v=abs(H_v);    
    H_a=abs(H_a);   
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
    maxFd=0.;
    maxFv=0.;
    maxFa=0.;    
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
    end       
%
    H_d=fix_size(H_d);
    H_v=fix_size(H_v);
    H_a=fix_size(H_a);
%
    n=length(f);
    for i=n:-1:1
%
       if(f(i)==0)
             f(i)=[];
           H_d(i)=[];
           H_v(i)=[]; 
           H_a(i)=[];  
       end
%
    end
%%%
    if(iu==1)
        out1=sprintf('\n Response Location: x=%g inches\n',x);
    else
        out1=sprintf('\n Response Location: x=%g meters \n',x);        
    end
    disp(out1); 
%%%
%%%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(f,H_d);
    xlim([fstart fend]);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
%
    if(iu==1)
        out1=sprintf('Displacement Frequency Response Function  x=%g inch',x);
        ylabel('Disp (in)/ Force (lbf/in)');
    else
        out1=sprintf('Displacement Frequency Response Function  x=%g m',x);
        ylabel('Disp (m)/ Force(N/m)');        
    end
%
%
    title(out1);
    xlabel('Frequency (Hz)');
    set(gca,'FontSize',10.5);
    h = get(gca, 'xlabel');
    set(h, 'FontName', 'Arial','FontSize',10.5);
    h = get(gca, 'ylabel');
    set(h, 'FontName', 'Arial','FontSize',10.5); 
    h = get(gca, 'title');
    set(h, 'FontName', 'Arial','FontSize',10.5);
    grid on;
    disp(' ');
    if(iu==1)
        out1=sprintf('  max Disp FRF = %9.5f (in/(lbf/in)) at %8.4g Hz ',maxHd,maxFd);
    else
        out1=sprintf('  max Disp FRF = %9.5f (m/(N/m)) at %8.4g Hz ',maxHd,maxFd);       
    end
    disp(out1);
%
    clear disp;
    displacement=[f H_d];
%%%
%%%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(f,H_v);
    xlim([fstart fend]);    
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
%
    if(iu==1)
        out1=sprintf('Velocity Frequency Response Function  x=%g inch',x);
        ylabel('Vel (in/sec)/ Force (lbf/in)');
    else
        out1=sprintf('Velocity Frequency Response Function  x=%g m',x);
        ylabel('Vel (m/sec)/ Force (N/m)');        
    end
%
%
    title(out1);
    xlabel('Frequency (Hz)');
    set(gca,'FontSize',10.5);
    h = get(gca, 'xlabel');
    set(h, 'FontName', 'Arial','FontSize',10.5);
    h = get(gca, 'ylabel');
    set(h, 'FontName', 'Arial','FontSize',10.5); 
    h = get(gca, 'title');
    set(h, 'FontName', 'Arial','FontSize',10.5);
    grid on;
    disp(' ');
    if(iu==1)
        out1=sprintf('  max Vel FRF = %9.5f ((in/sec)/(lbf/in)) at %8.4g Hz ',maxHv,maxFv);
    else
        out1=sprintf('  max Vel FRF = %9.5f ((m/sec)/(N/m)) at %8.4g Hz ',maxHv,maxFv);       
    end
    disp(out1);
%
    clear velocity;
    velocity=[f H_v];
%%%
%%%
%%%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(f,H_a);
    xlim([fstart fend]);    
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
%    
    if(iu==1)
        out1=sprintf('Acceleration Frequency Response Function  x=%g inch',x);
    else
        out1=sprintf('Acceleration Frequency Response Function  x=%g m',x);        
    end
%    
    title(out1);
    ymax= 10^(ceil(log10(max(abs(H_a)))+0.1));
    ymin= 10^(floor(log10(min(abs(H_a)))-0.1));
%
    LL=ymax/10000;
%
    if(ymin<LL)
        ymin=LL;
    end
%
    axis([min(xlim),max(xlim),ymin,ymax]);
    if(iu==1)
        ylabel('Accel (G)/ Force (lbf/in) ');
    else
        ylabel('Accel (G)/ Force (N/m); ');        
    end
    xlabel('Frequency (Hz)');
    set(gca,'FontSize',10.5);
    h = get(gca, 'xlabel');
    set(h, 'FontName', 'Arial','FontSize',10.5);
    h = get(gca, 'ylabel');
    set(h, 'FontName', 'Arial','FontSize',10.5); 
    h = get(gca, 'title');
    set(h, 'FontName', 'Arial','FontSize',10.5);
    grid on;
    disp(' ');
    if(iu==1)
        out1=sprintf('  max Absolute Accel FRF = %8.4g (G/(lbf/in)) at %8.4g Hz ',maxHa,maxFa);
    else
        out1=sprintf('  max Absolute Accel FRF = %8.4g (G/(N/m)) at %8.4g Hz ',maxHa,maxFa);        
    end
    disp(out1);
%
    clear acceleration;
    acceleration=[f H_a];
%

    setappdata(0,'acceleration',acceleration);
    setappdata(0,'velocity',velocity);    
    setappdata(0,'displacement',displacement);    
    
    
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

function varargout = plate_bending_transmissibility(varargin)
% PLATE_BENDING_TRANSMISSIBILITY MATLAB code for plate_bending_transmissibility.fig
%      PLATE_BENDING_TRANSMISSIBILITY, by itself, creates a new PLATE_BENDING_TRANSMISSIBILITY or raises the existing
%      singleton*.
%
%      H = PLATE_BENDING_TRANSMISSIBILITY returns the handle to a new PLATE_BENDING_TRANSMISSIBILITY or the handle to
%      the existing singleton*.
%
%      PLATE_BENDING_TRANSMISSIBILITY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLATE_BENDING_TRANSMISSIBILITY.M with the given input arguments.
%
%      PLATE_BENDING_TRANSMISSIBILITY('Property','Value',...) creates a new PLATE_BENDING_TRANSMISSIBILITY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plate_bending_transmissibility_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plate_bending_transmissibility_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plate_bending_transmissibility

% Last Modified by GUIDE v2.5 03-Sep-2014 10:07:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plate_bending_transmissibility_OpeningFcn, ...
                   'gui_OutputFcn',  @plate_bending_transmissibility_OutputFcn, ...
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


% --- Executes just before plate_bending_transmissibility is made visible.
function plate_bending_transmissibility_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plate_bending_transmissibility (see VARARGIN)

% Choose default command line output for plate_bending_transmissibility
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes plate_bending_transmissibility wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plate_bending_transmissibility_OutputFcn(hObject, eventdata, handles) 
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

delete(plate_bending_transmissibility);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_fmax,'String'));

   fig_num=getappdata(0,'fig_num');
   
      damp=getappdata(0,'damp_ratio');
   
      if(length(damp)==0)
          warndlg('damping vector does not exist');
          return;
      end    
      
      
      fbig=getappdata(0,'fbig');
        iu=getappdata(0,'iu');
 num_nodes=getappdata(0,'num_nodes');   

         L=getappdata(0,'L');   
         W=getappdata(0,'W'); 
         T=getappdata(0,'T');
         E=getappdata(0,'E');
         mu=getappdata(0,'mu');
         
       Amn=getappdata(0,'Amn');         
        
a=L;
b=W;
h=T;
       
fn=fbig(:,1);
part=fbig(:,4);

m_index=fbig(:,6);
n_index=fbig(:,7);

num=length(fn);

try
    mt=getappdata(0,'mt');

    if(mt<num)
        num=mt;
    end
  
end   


n_loc=get(handles.listbox_location,'Value');

if(n_loc==1)
    x=0.5*L;
    y=0.5*W;
end
if(n_loc==2)
    x=0.5*L;
    y=0.25*W;
end
if(n_loc==3)
    x=0.25*L;
    y=0.5*W;
end
if(n_loc==4)
    x=0.25*L;
    y=0.25*W;
end
if(n_loc==5)
    x=0;
    y=0;
end

pax=x*pi/a;
pby=y*pi/b;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  nf=20000;
   f(1)=fmin;
   for k=2:nf
        f(k)=f(k-1)*2^(1/48);
        if(f(k)>fmax)
            break;
        end    
   end
   nf=max(size(f));
%
%
%
[accel_trans,rv_trans,rd_trans,vM_trans,HA,Hv,H,HM_stress_vM,Hsxx,Hsyy,Htxy]...
        =ss_plate_trans_core(nf,f,fn,damp,pax,pby,part,Amn,fbig,a,b,T,E,mu,iu);


setappdata(0,'rel_disp_H',rd_trans);
setappdata(0,'rel_vel_H',rv_trans);
setappdata(0,'accel_H',accel_trans);
setappdata(0,'H_vM',HM_stress_vM);


    HA=abs(HA);
    Hv=abs(Hv);
    H=abs(H);
    HM_stress_vM=abs(HM_stress_vM);    
    
    maxH=0;
    maxHv=0;
    maxHA=0;
    maxvM=0;
%
    for k=1:nf
        if(H(k)>maxH)
            maxH=H(k);
            maxF=f(k);
        end
        if(Hv(k)>maxHv)
            maxHv=Hv(k);
            maxFv=f(k);
        end      
        if(HA(k)>maxHA)
            maxHA=HA(k);
            maxFA=f(k);
        end
        if(HM_stress_vM(k)>maxvM)
            maxvM=HM_stress_vM(k);
            maxFvM=f(k);
        end       
    end       
%

%%%%%%%%%

md=6;

x_label='Frequency (Hz)';

f=fix_size(f);
H=fix_size(H);
Hv=fix_size(Hv);
HA=fix_size(HA);

%%%%%%%%%

ppp=[f H];

if(iu==1)
    t_string=sprintf('Rel Disp Frequency Response Function  x=%g in  y=%g in',x,y);
    y_label='Rel Disp (in)/ Base Accel (G) ';
else
    t_string=sprintf('Rel Disp Frequency Response Function  x=%g m  y=%g m',x,y);
    y_label='Rel Disp (m)/ Base Accel (G) ';        
end

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

%
%%%%%%%%%%
%

ppp=[f Hv];

if(iu==1)
    t_string=sprintf('Rel Vel Frequency Response Function  x=%g in  y=%g in',x,y);
    y_label='Rel Vel (in/sec)/ Base Accel (G) ';
else
    t_string=sprintf('Rel Vel Frequency Response Function  x=%g m  y=%g m',x,y);
    y_label='Rel Vel (m/sec)/ Base Accel (G) ';       
end

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);


%%%%%%%%

%

ppp=[f HA];

y_label='Response Accel(G) / Base Accel(G)';

if(iu==1)
    t_string=sprintf('Accel Frequency Response Function  x=%g in  y=%g in',x,y);
else
    t_string=sprintf('Accel Frequency Response Function  x=%g m  y=%g m',x,y);     
end

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

%%%%%%%%%%
%    

HA2=HA.*HA;

ppp=[f HA2];

ylabel='Trans (G^2/G^2)';

if(iu==1)
    t_string=sprintf('Accel Power Transmissibility  x=%g in  y=%g in',x,y);
else
    t_string=sprintf('Accel Power Transmissibility  x=%g m  y=%g m',x,y);       
end

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);
    
%

%%%%

    
    Hsxx=fix_size(Hsxx);
    Hsyy=fix_size(Hsyy);
    
    ppp1=[f Hsxx];
    ppp2=[f Hsyy];
    
    if(iu==1)
        t_string=sprintf('Bending Stress  x=%g in  y=%g in',x,y);
        y_label='Trans (psi/G)';
    else
        t_string=sprintf('Bending Stress  x=%g m  y=%g m',x,y);
        y_label='Trans (Pa/G)';        
    end   
    
    leg1='Sxx';
    leg2='Syy';

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);        
    
%
%%%%%



    if(iu==1)
        t_string=sprintf('Shear Stress  x=%g in  y=%g in',x,y);
        y_label='Trans (psi/G)';
    else
        t_string=sprintf('Shear Stress  x=%g m  y=%g m',x,y);
        y_label='Trans (Pa/G)';        
    end
 
%    

Htxy=fix_size(Htxy);
ppp=[f Htxy];

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);
    
%%%%%    
    

    
HM_stress_vM=fix_size(HM_stress_vM);

ppp=[f HM_stress_vM];

    if(iu==1)
        t_string=sprintf('von Mises Stress  x=%g in  y=%g in',x,y);
        y_label='Trans (psi/G)';
    else
        t_string=sprintf('von Mises Stress  x=%g m  y=%g m',x,y);
        y_label='Trans (Pa/G)';        
    end

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);
        
    
    
%
%%%%%%%
%
    try
        
        disp(' ');
%
        if(iu==1)
            out1=sprintf('  max Rel Disp FRF = %8.3g (in/G) at %8.4g Hz ',maxH,maxF);
            out2=sprintf('  max Rel Vel FRF = %8.3g (in/sec/G) at %8.4g Hz ',maxHv,maxFv);
        else
            out1=sprintf('  max Rel Disp FRF = %8.3g (m/G) at %8.4g Hz ',maxH,maxF);
            out2=sprintf('  max Rel Vel FRF = %8.3g (m/sec/G) at %8.4g Hz ',maxHv,maxFv);   
        end
        disp(out1);
        disp(out2);
    
    catch
    end
%   

    try
        
        out1=sprintf('  max Accel FRF    = %8.4g (G/G)     at %8.4g Hz ',maxHA,maxFA);
        disp(out1);
        disp(' ');
        out1=sprintf('  max Power Trans  = %8.4g (G^2/G^2) at %8.4g Hz ',maxHA^2,maxFA);
        disp(out1); 
    
        disp(' ');
        if(iu==1)
            out1=sprintf('  max von Mises Stress FRF = %8.3g (psi/G) at %8.4g Hz ',maxvM,maxFvM);
            disp(out1); 
        else
            out1=sprintf('  max von Mises Stress FRF = %8.3g (Pa/G) at %8.4g Hz ',maxvM,maxFvM);
            out2=sprintf('                           = %8.3g (MPa/G) at %8.4g Hz ',maxvM/(1.0e+06),maxFvM);        
            disp(out1); 
            disp(out2); 
        end
        
    catch
    end    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setappdata(0,'fig_num',fig_num);

set(handles.uipanel_save,'Visible','on');


% --- Executes on selection change in listbox_location.
function listbox_location_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_location contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_location


% --- Executes during object creation, after setting all properties.
function listbox_location_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fmin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmin as text
%        str2double(get(hObject,'String')) returns contents of edit_fmin as a double


% --- Executes during object creation, after setting all properties.
function edit_fmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmax as text
%        str2double(get(hObject,'String')) returns contents of edit_fmax as a double


% --- Executes during object creation, after setting all properties.
function edit_fmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_type,'Value');

if(n==1)
    data=getappdata(0,'accel_H');
end
if(n==2)
    data=getappdata(0,'rel_vel_H');
end
if(n==3)
    data=getappdata(0,'rel_disp_H');
end
if(n==4)
    data=getappdata(0,'H_vM');
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

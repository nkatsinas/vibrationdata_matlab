function varargout = ss_plate_bending_frf(varargin)
% SS_PLATE_BENDING_FRF MATLAB code for ss_plate_bending_frf.fig
%      SS_PLATE_BENDING_FRF, by itself, creates a new SS_PLATE_BENDING_FRF or raises the existing
%      singleton*.
%
%      H = SS_PLATE_BENDING_FRF returns the handle to a new SS_PLATE_BENDING_FRF or the handle to
%      the existing singleton*.
%
%      SS_PLATE_BENDING_FRF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SS_PLATE_BENDING_FRF.M with the given input arguments.
%
%      SS_PLATE_BENDING_FRF('Property','Value',...) creates a new SS_PLATE_BENDING_FRF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ss_plate_bending_frf_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ss_plate_bending_frf_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ss_plate_bending_frf

% Last Modified by GUIDE v2.5 27-Feb-2017 18:11:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ss_plate_bending_frf_OpeningFcn, ...
                   'gui_OutputFcn',  @ss_plate_bending_frf_OutputFcn, ...
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


% --- Executes just before ss_plate_bending_frf is made visible.
function ss_plate_bending_frf_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ss_plate_bending_frf (see VARARGIN)

% Choose default command line output for ss_plate_bending_frf
handles.output = hObject;


set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ss_plate_bending_frf wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ss_plate_bending_frf_OutputFcn(hObject, eventdata, handles) 
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

delete(ss_plate_bending_frf);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

num_modes=round(str2num(get(handles.edit_num_modes,'String')));

fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_fmax,'String'));

damp=str2num(get(handles.edit_damp,'String'));

   fig_num=getappdata(0,'fig_num');
         
      fbig=getappdata(0,'fbig');
        iu=getappdata(0,'iu');
  

         L=getappdata(0,'L');   
         W=getappdata(0,'W'); 
         T=getappdata(0,'T');
         E=getappdata(0,'E');
         mu=getappdata(0,'mu');

         DD=getappdata(0,'DD');
         
       Amn=getappdata(0,'Amn');         


    force_x=str2num(get(handles.edit_force_x,'String'));
    force_y=str2num(get(handles.edit_force_y,'String'));

    nresp=get(handles.listbox_response,'Value');       
    
    if(nresp==1)

        resp_loc=[ 0.5*L   0.5*W ];
                
    end    
    if(nresp==2)

        resp_loc=[ force_x*L   force_y*W ]/100;
                
    end     
    
    if(nresp==3)
       
        ns=21;
        
        x_resp_loc=zeros(ns,2);   
        y_resp_loc=zeros(ns,2);         
        
        dx=L/(ns-1);
        dy=W/(ns-1);
        
        for i=1:ns
            
            for j=1:ns
        
                x_resp_loc(i,j)=(i-1)*dx;                
                y_resp_loc(i,j)=(j-1)*dy;
                
            end
            
        end
    end    

    force_x=force_x*L/100;
    force_y=force_y*W/100;
 
    
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
   nmodes=floor(sqrt(num_modes));
%
%
    tpi=2*pi; 

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

disp(' ');
disp(' * * * * * * *  ');

try

    resp_loc
    force_x
    force_y

catch
end    

if(nresp<=2)
%
    H=zeros(nf,1);
    Hv=zeros(nf,1);
    HA=zeros(nf,1);   
%
    progressbar;
    for k=1:nf
        
        progressbar(k/nf);
        
         H(k)=0;
        Hv(k)=0;
        HA(k)=0;      
 %       
        om=tpi*f(k);
 %
 
        [qH,qHv,qHA,omegan]=ss_plate_frf_core(L,W,resp_loc,force_x,force_y,DD,damp,om,nmodes,Amn);
        
        H(k)=qH;
        Hv(k)=qHv;
        HA(k)=qHA;
 %
    end
%
    pause(0.2);
    progressbar(1);
%
    if(iu==1)
        HA=HA/386;
    else
        HA=HA/9.81;
    end


    HA=abs(HA);
    Hv=abs(Hv);
    H=abs(H);

    maxH=0;
    maxHv=0;
    maxHA=0;

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
      
    end       
%
    x=resp_loc(1);
    y=resp_loc(2);
%
    x_label='Frequency (Hz)';
    md=6;

    f=fix_size(f);
    H=fix_size(H);
    Hv=fix_size(Hv);
    HA=fix_size(HA);
    
%%    
    
    if(iu==1)
        t_string=sprintf('Receptance FRF  x=%g in  y=%g in',x,y);
        y_label='Disp(in) / Force(lbf)';
    else
        t_string=sprintf('Receptance FRF  x=%g m  y=%g m',x,y);
        y_label='Disp(m) / Force(N)';        
    end    
    ppp=[f H];
    [fig_num,h2]=...
    plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

%%

    if(iu==1)
        t_string=sprintf('Mobility FRF  x=%g in  y=%g in',x,y);
        y_label='Vel(in/sec)/ Force(lbf) ';
    else
        t_string=sprintf('Mobility FRF  x=%g m  y=%g m',x,y);
        y_label='Vel(m/sec)/ Force(N) ';        
    end

    ppp=[f Hv];
    [fig_num,h2]=...
    plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

%%

    if(iu==1)
        t_string=sprintf('Accelerance FRF  x=%g in  y=%g in',x,y);
        y_label='Accel(G) / Force(lbf) ';
    else
        t_string=sprintf('Accelerance FRF  x=%g m  y=%g m',x,y);
        y_label='Accel(G) / Force(N) ';
    end

    ppp=[f HA];
    [fig_num,h2]=...
    plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);


%%
%
  
    disp(' ');
    disp('   Maximum FRF Values      ');
%
    if(iu==1)
        out1=sprintf('    Receptance = %8.3g (in/lbf) at %8.4g Hz ',maxH,maxF);
        out2=sprintf('      Mobility = %8.3g (in/sec/lbf) at %8.4g Hz ',maxHv,maxFv);
        out3=sprintf('   Accelerance = %8.3g (G/lbf) at %8.4g Hz ',maxHA,maxFA);        
    else
        out1=sprintf('    Receptance = %8.3g (m/N) at %8.4g Hz ',maxH,maxF);
        out2=sprintf('      Mobility = %8.3g (m/sec/N) at %8.4g Hz ',maxHv,maxFv); 
        out3=sprintf('   Accelerance = %8.3g (G/lbf) at %8.4g Hz ',maxHA,maxFA);          
    end
    disp(out1);
    disp(out2);
    disp(out3);    
%   
    disp(' ');

end     
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nresp==3)  % spatial average
%
    H=zeros(nf,1);   % leave here
    Hv=zeros(nf,1);
    HA=zeros(nf,1);


    progressbar;
        
    for iv=1:ns
 
        progressbar(iv/ns); 
        
        for iw=1:ns
    
            for k=1:nf
 %       
                om=tpi*f(k);
                
                
                x_resp_loc(i,j)=(i-1)*dx;                
                y_resp_loc(i,j)=(j-1)*dy;    
                
                qresp_loc=[ x_resp_loc(iv,iw)   y_resp_loc(iv,iw) ];                
                
 %
                [qH,qHv,qHA,omegan]=ss_plate_frf_core(L,W,qresp_loc,force_x,force_y,DD,damp,om,nmodes,Amn);
        
                H(k)=H(k)+qH;
                Hv(k)=Hv(k)+qHv;
                HA(k)=HA(k)+qHA;
 %
            end
        end
    end
    
    
    ns2=ns^2;
    
    H=H/ns2;
    Hv=Hv/ns2;
    HA=HA/ns2;
    
%
    pause(0.2);
    progressbar(1);
%
    if(iu==1)
        HA=HA/386;
    else
        HA=HA/9.81;
    end


    HA=abs(HA);
    Hv=abs(Hv);
    H=abs(H);

    maxH=0;
    maxHv=0;
    maxHA=0;

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
      
    end       
%
    x_label='Frequency (Hz)';
    md=6;

    f=fix_size(f);
    H=fix_size(H);
    Hv=fix_size(Hv);
    HA=fix_size(HA);
    
%%    
    
    if(iu==1)
        t_string=sprintf('Spatial Average Receptance FRF');
        y_label='Disp(in) / Force(lbf)';
    else
        t_string=sprintf('Spatial Average Receptance FRF');
        y_label='Disp(m) / Force(N)';        
    end    
    ppp=[f H];
    [fig_num,h2]=...
    plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

%%

    if(iu==1)
        t_string=sprintf('Spatial Average Mobility FRF');
        y_label='Vel(in/sec)/ Force(lbf) ';
    else
        t_string=sprintf('Spatial Average Mobility FRF');
        y_label='Vel(m/sec)/ Force(N) ';        
    end

    ppp=[f Hv];
    [fig_num,h2]=...
    plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

%%

    if(iu==1)
        t_string=sprintf('Spatial Average Accelerance FRF');
        y_label='Accel(G) / Force(lbf) ';
    else
        t_string=sprintf('Spatial Average Accelerance FRF');
        y_label='Accel(G) / Force(N) ';
    end

    ppp=[f HA];
    [fig_num,h2]=...
    plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);


%%
%

  
    disp(' ');
    disp('   Spatial Average FRF Values      ');
%
    if(iu==1)
        out1=sprintf('    Receptance = %8.3g (in/lbf) at %8.4g Hz ',maxH,maxF);
        out2=sprintf('      Mobility = %8.3g (in/sec/lbf) at %8.4g Hz ',maxHv,maxFv);
        out3=sprintf('   Accelerance = %8.3g (G/lbf) at %8.4g Hz ',maxHA,maxFA);        
    else
        out1=sprintf('    Receptance = %8.3g (m/N) at %8.4g Hz ',maxH,maxF);
        out2=sprintf('      Mobility = %8.3g (m/sec/N) at %8.4g Hz ',maxHv,maxFv); 
        out3=sprintf('   Accelerance = %8.3g (G/lbf) at %8.4g Hz ',maxHA,maxFA);          
    end
    disp(out1);
    disp(out2);
    disp(out3);    
%   
    disp(' ');     
    
end


setappdata(0,'receptance',[f H]);
setappdata(0,'mobility',[f Hv]);
setappdata(0,'accelerance',[f HA]);


    fn_max=max(omegan)/tpi;
    
    out1=sprintf('\n maximum natural frequency = %8.4g Hz  \n',fn_max);
    disp(out1);

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
    data=getappdata(0,'receptance');
end
if(n==2)
    data=getappdata(0,'mobility');
end
if(n==3)
    data=getappdata(0,'accelerance');
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



function edit_force_x_Callback(hObject, eventdata, handles)
% hObject    handle to edit_force_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_force_x as text
%        str2double(get(hObject,'String')) returns contents of edit_force_x as a double


% --- Executes during object creation, after setting all properties.
function edit_force_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_force_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_response_location_Callback(hObject, eventdata, handles)
% hObject    handle to edit_response_location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_response_location as text
%        str2double(get(hObject,'String')) returns contents of edit_response_location as a double


% --- Executes during object creation, after setting all properties.
function edit_response_location_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_response_location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_force_y_Callback(hObject, eventdata, handles)
% hObject    handle to edit_force_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_force_y as text
%        str2double(get(hObject,'String')) returns contents of edit_force_y as a double


% --- Executes during object creation, after setting all properties.
function edit_force_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_force_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_response.
function listbox_response_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_response (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_response contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_response


% --- Executes during object creation, after setting all properties.
function listbox_response_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_response (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_num_modes_Callback(hObject, eventdata, handles)
% hObject    handle to edit_num_modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_num_modes as text
%        str2double(get(hObject,'String')) returns contents of edit_num_modes as a double


% --- Executes during object creation, after setting all properties.
function edit_num_modes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_num_modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_damp_Callback(hObject, eventdata, handles)
% hObject    handle to edit_damp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_damp as text
%        str2double(get(hObject,'String')) returns contents of edit_damp as a double


% --- Executes during object creation, after setting all properties.
function edit_damp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_damp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

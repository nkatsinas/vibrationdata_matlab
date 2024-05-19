function varargout = beam_bending_half_sine(varargin)
% BEAM_BENDING_HALF_SINE MATLAB code for beam_bending_half_sine.fig
%      BEAM_BENDING_HALF_SINE, by itself, creates a new BEAM_BENDING_HALF_SINE or raises the existing
%      singleton*.
%
%      H = BEAM_BENDING_HALF_SINE returns the handle to a new BEAM_BENDING_HALF_SINE or the handle to
%      the existing singleton*.
%
%      BEAM_BENDING_HALF_SINE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BEAM_BENDING_HALF_SINE.M with the given input arguments.
%
%      BEAM_BENDING_HALF_SINE('Property','Value',...) creates a new BEAM_BENDING_HALF_SINE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before beam_bending_half_sine_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to beam_bending_half_sine_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help beam_bending_half_sine

% Last Modified by GUIDE v2.5 23-Dec-2020 13:31:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @beam_bending_half_sine_OpeningFcn, ...
                   'gui_OutputFcn',  @beam_bending_half_sine_OutputFcn, ...
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


% --- Executes just before beam_bending_half_sine is made visible.
function beam_bending_half_sine_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to beam_bending_half_sine (see VARARGIN)

% Choose default command line output for beam_bending_half_sine
handles.output = hObject;

iu=getappdata(0,'unit');
L=getappdata(0,'length');

if(iu==1)
    set(handles.length_unit_text,'String','inch');
    LS=sprintf('Beam Length = %8.4g inch',L);
else
    set(handles.length_unit_text,'String','meters');
    LS=sprintf('Beam Length = %8.4g meters',L);
end

set(handles.beam_length_text,'String',LS);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes beam_bending_half_sine wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = beam_bending_half_sine_OutputFcn(hObject, eventdata, handles) 
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
 
disp('  ');
disp(' * * * * * ');
disp(' ');

tpi=2*pi;


num_fn=get(handles.listbox_num_modes,'Value');
fig_num=1;
      damp=getappdata(0,'damp_ratio');
      
      fn=getappdata(0,'fn');
      nmn=min([num_fn length(fn)]);
      fn=fn(1:nmn);        
       
        
      iu=getappdata(0,'unit');
      part=getappdata(0,'part');
      PF=part;
 
      LBC=getappdata(0,'LBC');
      RBC=getappdata(0,'RBC');
      
      E=getappdata(0,'E');  
      I=getappdata(0,'I');       
      cna=getappdata(0,'cna');
 
      c=cna;    
      
      
      EI=E*I;
    
      x=str2num(get(handles.x_edit,'String')); 
      
      sq_mass=getappdata(0,'sq_mass');
      beta=getappdata(0,'beta');
      C=getappdata(0,'C');
      
      n=length(fn);
      
      T=str2num(get(handles.duration_edit,'String')); 
      A=str2num(get(handles.amplitude_edit,'String')); 
      
    [ModeShape,ModeShape_dd,ModeShape_ddd]=beam_bending_modes_shapes_alt(LBC,RBC);
%
    dur1=5*T;
    dur2=5/fn(1);
    dur=max([dur1 dur2]);
%
    dt1=T/20;
    dt2=(1/max(fn))/10;
%
    dt=min([dt1 dt2]);
%
    num_steps=round(dur/dt);
%
    t=linspace(0,dur,num_steps);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    omega=pi/T;
    omegan=tpi*fn;
%
    NT=length(fn);
%
    den=zeros(NT,1);
    U1=zeros(NT,1);
    U2=zeros(NT,1);
    V1=zeros(NT,1);
    V2=zeros(NT,1);
    P=zeros(NT,1);
    omegad=zeros(NT,1);
    domegan=zeros(NT,1);
    omn2=zeros(NT,1);
%
    An=zeros(NT,1);
%
    A11=zeros(NT,1);
    A12=zeros(NT,1);
    A21=zeros(NT,1);
    A22=zeros(NT,1);
%
    om2=omega^2;
%    
    for i=1:NT
       omegad(i)=omegan(i)*sqrt(1-damp(i)^2);
       domegan(i)=damp(i)*omegan(i);
       omn2(i)=(omegan(i))^2;
       den(i)=( (om2-omn2(i))^2 + (2*damp(i)*omega*omegan(i))^2);
       U1(i)=2*damp(i)*omega*omegan(i);
       U2(i)=om2-omn2(i);
       V1(i)=2*damp(i)*omegan(i)*omegad(i);
       V2(i)=om2-omn2(i)*(1-2*(damp(i))^2);
       P(i)=omega/omegad(i);
%
       A11(i)=-(om2-omn2(i));
       A12(i)=-2*damp(i)*omega*omegan(i);
       A21(i)=2*damp(i)*om2;
       A22(i)=(omegan(i)/omegad(i))*(-omn2(i)+om2*(1-2*damp(i)^2));
%
    end
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Transition points
%
    eee=exp(-domegan*T); 
%
    arg=omega*T;
%
    argd=omegad*T;
%
    c1=cos(arg);
    s1=sin(arg);
    cd=cos(argd);
    sd=sin(argd);
%
    W=zeros(NT,1);
    Tn=zeros(NT,1);
    Tnv=zeros(NT,1);
    deee=zeros(NT,1);
%
    for j=1:NT
%
        An(j)=PF(j)*A;   
%               
        term1=U1(j)*c1 + U2(j)*s1;
        term2=V1(j)*cd(j)+V2(j)*sd(j);
        dterm1=    omega*( -U1(j)*s1 + U2(j)*c1 );
        dterm2=omegad(j)*( -V1(j)*sd(j) + V2(j)*cd(j) );
        deee(j)=-damp(j)*omegan(j)*eee(j);
%
        Tn(j)=An(j)*(term1-P(j)*eee(j)*term2)/den(j);
%
        Tnv(j)=An(j)*(dterm1 -P(j)*( deee(j)*term2 +eee(j)*dterm2))/den(j);          
%
        W(j)= ( Tnv(j) +   damp(j)*omegan(j)*Tn(j) )/omegad(j);
%
    end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    abase=zeros(num_steps,1);
       rd=zeros(num_steps,1);
      acc=zeros(num_steps,1);
       bm=zeros(num_steps,1);
       shear=zeros(num_steps,1);
%
    for i=1:num_steps
%
        eee=exp(-domegan*t(i)); 
%
        arg=omega*t(i);
%
        argd=omegad*t(i);
%
        c1=cos(arg);
        s1=sin(arg);
        cd=cos(argd);
        sd=sin(argd);     
%
        n=zeros(NT,1);
        nv=zeros(NT,1);
        na=zeros(NT,1);
        An=zeros(NT,1);
%
        deee=zeros(NT,1);
%
        for j=1:NT
%            
            if(abs(PF(j))>0)
%
                if t(i)<=T
%                   
                    abase(i)=A*s1;
                    An(j)=PF(j)*A;
%               
                    term1=U1(j)*c1 + U2(j)*s1;
                    term2=V1(j)*cd(j)+V2(j)*sd(j);
                    dterm1=    omega*( -U1(j)*s1 + U2(j)*c1 );
                    dterm2=omegad(j)*( -V1(j)*sd(j) + V2(j)*cd(j) );
                    deee(j)=-damp(j)*omegan(j)*eee(j);
%
                    n(j)=An(j)*(term1-P(j)*eee(j)*term2)/den(j);
%
                    nv(j)=An(j)*(dterm1 -P(j)*( deee(j)*term2 +eee(j)*dterm2))/den(j);
%
                    a1=om2*(  A11(j)*s1  + A12(j)*c1);
                    a2=omega*omegan(j)*eee(j)*(  A21(j)*cd(j) +A22(j)*sd(j));
%                    
                    na(j)=An(j)*(a1+a2)/den(j);
%
                else
                    ts=t(i)-T;
%
                    eee(j)=exp(-domegan(j)*ts); 
                    deee(j)=-damp(j)*omegan(j)*eee(j);                
%
                    arg=omega*ts;
%
                    argd=omegad*ts;
%
                    c1=cos(arg);
                    s1=sin(arg);
                    cd=cos(argd);
                    sd=sin(argd);
%
                     n(j)=    eee(j)*( Tn(j)*cd(j)  +W(j)*sd(j) );
                    nv(j)=   deee(j)*n(j)...
                            +omegad(j)*eee(j)*( -Tn(j)*sd(j)  +W(j)*cd(j) );
%                        
                    na(j)= -2*damp(j)*omegan(j)*nv(j) -omn2(j)*n(j);      
                end
%
                arg=beta(j)*x;
                ZZ=ModeShape(arg,C(j),sq_mass); 
                ZZdd=ModeShape_dd(arg,C(j),beta(j),sq_mass);    
                ZZddd=ModeShape_ddd(arg,C(j),beta(j),sq_mass);                   
%
                rd(i)=rd(i) +ZZ*n(j);
               acc(i)=acc(i)+ZZ*na(j);
                bm(i)=bm(i)+ZZdd*n(j);
                shear(i)=shear(i)+ZZddd*n(j);                
%                           
            end  % PF                    
%
        end  % j mode
%
    end      % i  time 
%
%       
    acc=acc+abase;
%
    if(iu==1)
        rd=rd*386;
        bm=bm*386;
        shear=shear*386;        
    else
        rd=rd*9.81;
        bm=bm*9.81;   
        shear=shear*9.81;        
    end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    bm=bm*EI;
    shear=shear*EI;
%
   
    disp(' ');
    if(iu==1)
        out12 =sprintf(' Peak Responses at x=%g inch ',x);
    else
        out12 =sprintf(' Peak Responses at x=%g m  ',x);    
    end
    disp(out12);
    
    
    out1=sprintf('          Acceleration = %8.4g G',max(abs(acc)));
%   
    if(iu==1)
        out2=sprintf('\n Relative Displacement = %8.4g in',max(abs(rd)));   
        out3=sprintf('        Bending Moment = %8.4g in-lbf',max(abs(bm)));  
        out4=sprintf('           Shear Force = %8.4g lbf',max(abs(shear)));        
        out5=sprintf('        Bending Stress = %8.4g psi',(c/I)*max(abs(bm)));  
    else
        out2=sprintf('\n Relative Displacement = %8.4g m',max(abs(rd))); 
        out3=sprintf('        Bending Moment = %8.4g N-m',max(abs(bm))); 
        out4=sprintf('           Shear Force = %8.4g N',max(abs(shear)));         
        out5=sprintf('        Bending Stress = %8.4g Pa',(c/I)*max(abs(bm)));        
    end

%    
    disp(out2);
    disp(out1);
    disp(' ');    
    disp(out3);
    disp(out4);
    disp(out5); 
    disp(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    t=fix_size(t);
%
    acc=fix_size(acc);
%
    rd=fix_size(rd);
%%%
    acc_hs_resp=[t acc];
    rd_hs_resp=[t rd];  
%%%
%
    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,rd);
%
    if(iu==1)
        out1=sprintf('Relative Displacement at %g in',x);        
        ylabel('Rel Disp(in) ');
    else
        out1=sprintf('Relative Displacement at %g m',x);        
        ylabel('Rel Disp(m) ');
    end
    title(out1);
    xlabel('Time(sec)');
    grid on;
%
%
    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,acc,t,abase);
%
    if(iu==1)
        out1=sprintf('Acceleration at %g in',x);
    else
        out1=sprintf('Acceleration at %g m',x);        
    end
%    
    title(out1);
    ylabel('Accel(G) ');
    xlabel('Time(sec)');
    legend('response','input');  
    grid on;
%

setappdata(0,'fig_num',fig_num);    
    
msgbox('Calculation complete.  Output written to Matlab Command Window.');


% --- Executes on button press in Return_pushbutton.
function Return_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Return_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(beam_bending_half_sine);


function amplitude_edit_Callback(hObject, eventdata, handles)
% hObject    handle to amplitude_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of amplitude_edit as text
%        str2double(get(hObject,'String')) returns contents of amplitude_edit as a double


% --- Executes during object creation, after setting all properties.
function amplitude_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amplitude_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function duration_edit_Callback(hObject, eventdata, handles)
% hObject    handle to duration_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of duration_edit as text
%        str2double(get(hObject,'String')) returns contents of duration_edit as a double


% --- Executes during object creation, after setting all properties.
function duration_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to duration_edit (see GCBO)
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

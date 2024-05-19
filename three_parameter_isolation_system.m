function varargout = three_parameter_isolation_system(varargin)
% THREE_PARAMETER_ISOLATION_SYSTEM MATLAB code for three_parameter_isolation_system.fig
%      THREE_PARAMETER_ISOLATION_SYSTEM, by itself, creates a new THREE_PARAMETER_ISOLATION_SYSTEM or raises the existing
%      singleton*.
%
%      H = THREE_PARAMETER_ISOLATION_SYSTEM returns the handle to a new THREE_PARAMETER_ISOLATION_SYSTEM or the handle to
%      the existing singleton*.
%
%      THREE_PARAMETER_ISOLATION_SYSTEM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in THREE_PARAMETER_ISOLATION_SYSTEM.M with the given input arguments.
%
%      THREE_PARAMETER_ISOLATION_SYSTEM('Property','Value',...) creates a new THREE_PARAMETER_ISOLATION_SYSTEM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before three_parameter_isolation_system_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to three_parameter_isolation_system_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help three_parameter_isolation_system

% Last Modified by GUIDE v2.5 10-Oct-2017 16:01:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @three_parameter_isolation_system_OpeningFcn, ...
                   'gui_OutputFcn',  @three_parameter_isolation_system_OutputFcn, ...
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


% --- Executes just before three_parameter_isolation_system is made visible.
function three_parameter_isolation_system_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to three_parameter_isolation_system (see VARARGIN)

% Choose default command line output for three_parameter_isolation_system
handles.output = hObject;


fstr='three_parameter_isolation.jpg';
bg = imread(fstr);
info = imfinfo(fstr);
w = info.Width;  %An integer indicating the width of the image in pixels
h = info.Height; %An integer indicating the height of the image in pixels
 
axes(handles.axes1);
image(bg);
pos1 = getpixelposition(handles.axes1,true);
 
set(handles.axes1, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [pos1(1) pos1(2) w h]);
axis off; 

change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes three_parameter_isolation_system wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = three_parameter_isolation_system_OutputFcn(hObject, eventdata, handles) 
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

delete(three_parameter_isolation_system);


function change(hObject, eventdata, handles)
%

set(handles.uipanel_save,'Visible','off');

iu=get(handles.listbox_unit,'Value');

m=get(handles.listbox_method,'Value');

n=get(handles.listbox_output,'Value');

if(iu==1)
   sss='Mass(lbm)';
   ttt='Spring k1 (lbf/in)';
   uuu='Spring k2 (lbf/in)';
   vvv='Dashpot c (lbf sec/in)';
else
   sss='Mass(kg)';   
   ttt='Spring k1 (N/m)';   
   uuu='Spring k2 (N/m)';   
   vvv='Dashpot c (N sec/m)';   
end

set(handles.text_mass,'String',sss); 
set(handles.text_k1,'String',ttt); 
set(handles.text_k2,'String',uuu); 
set(handles.text_c,'String',vvv); 


set(handles.text_sd,'Visible','off'); 
set(handles.text_k2,'Visible','off'); 
set(handles.text_c,'Visible','off'); 

set(handles.edit_sd,'Visible','off'); 
set(handles.edit_k2,'Visible','off'); 
set(handles.edit_c,'Visible','off'); 

set(handles.text_calibration,'Visible','off');      
set(handles.listbox_calibration,'Visible','off'); 


if(m==1)
    set(handles.text_k2,'Visible','on'); 
    set(handles.text_c,'Visible','on'); 
    set(handles.edit_k2,'Visible','on'); 
    set(handles.edit_c,'Visible','on');     
else
    set(handles.text_sd,'Visible','on');     
    set(handles.edit_sd,'Visible','on');  
    set(handles.text_calibration,'Visible','on');      
    set(handles.listbox_calibration,'Visible','on');       
end


set(handles.text_plot_freq,'Visible','off'); 
set(handles.text_min,'Visible','off'); 
set(handles.text_max,'Visible','off'); 
set(handles.edit_fstart,'Visible','off'); 
set(handles.edit_fend,'Visible','off'); 

set(handles.text_input_array,'Visible','off'); 
set(handles.edit_input_array,'Visible','off'); 
set(handles.text_columns,'Visible','off'); 



if(n==1)
    set(handles.text_plot_freq,'Visible','on'); 
    set(handles.text_min,'Visible','on'); 
    set(handles.text_max,'Visible','on'); 
    set(handles.edit_fstart,'Visible','on'); 
    set(handles.edit_fend,'Visible','on'); 
    set(handles.text_output,'String','Transmissibility');
else
    set(handles.text_input_array,'Visible','on'); 
    set(handles.edit_input_array,'Visible','on'); 
    set(handles.text_columns,'Visible','on');   
    set(handles.text_output,'String','Response Time History');    
end


%%%





% --- Executes on button press in pushbutton.
function pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('  ');
disp(' * * * * * * * * * * * ');
disp('  ');

tpi=2*pi;

fig_num=1;
setappdata(0,'fig_num',fig_num);

iu=get(handles.listbox_unit,'Value');
m=get(handles.listbox_method,'Value');
n=get(handles.listbox_output,'Value');


mass=str2num(get(handles.edit_mass,'String'));
k1=str2num(get(handles.edit_k1,'String'));


if(m==1)  % manual
    
    k2=str2num(get(handles.edit_k2,'String'));
    c=str2num(get(handles.edit_c,'String')); 
    
    sd=0;
    
else      % sd
    
    sd=str2num(get(handles.edit_sd,'String')); 
    
end

%%%%%%%%%%%%

if(iu==1)
   mass=mass/386; 
end

omegan=sqrt(k1/mass);

fn=omegan/tpi;

out1=sprintf('\n fn=%8.4g Hz \n',fn);
disp(out1);

if(m==2)  % sd input
    
    k2=2*sd*k1;
    
    c=k2/omegan;
    
    qcal=get(handles.listbox_calibration,'value');
        
end

out1=sprintf(' c=%8.4g  k2=%8.4g  ',c,k2);
disp(out1);

d=c/mass;

setappdata(0,'d',d);
setappdata(0,'k1',k1);
setappdata(0,'k2',k2);
setappdata(0,'mass',mass);
setappdata(0,'sd',sd);

m_array=[mass 0; 0 0];
c_array=[c -c; -c c];
k_array=[k1 0; 0 k2];

assignin('base', 'm_array', m_array);
assignin('base', 'c_array', c_array);
assignin('base', 'k_array', k_array);

%%%%%%%%%%%%

if(n==1)  % transmissibility
    
    fstart=str2num(get(handles.edit_fstart,'String'));
    fend=str2num(get(handles.edit_fend,'String'));    
    
    oct=1/96;
    
    if(fstart<0.1)
        fstart=0.1;
    end
    
    f(1)=fstart;
    
    i=2;
    
    while(1)
        f(i)=f(i-1)*2^oct;
        if(f(i)>fend)
            f(i)=fend;
            break;
        end
        i=i+1;
    end
    
    f=unique(f);

    nf=length(f);
    
    setappdata(0,'f',f);
    setappdata(0,'nf',nf);
    
%
    
    if(m==1) % manual
        transmissibility(hObject, eventdata, handles);
    else
        if(qcal==1)  % Genta Amati
            transmissibility(hObject, eventdata, handles);
        else         % optimized
            optimized(hObject, eventdata, handles);
        end
    end
     
else      % arbitrary base input  
   

    if(m==1) % manual
        time_history_response(hObject, eventdata, handles);
    else
        if(qcal==1)  % Genta Amati
            transmissibility(hObject, eventdata, handles);
            time_history_response(hObject, eventdata, handles);
        else         % optimized    
            
            optimized(hObject, eventdata, handles);
            time_history_response(hObject, eventdata, handles);            
            
        end
    end    
    
end

set(handles.uipanel_save,'Visible','on');



function optimized(hObject, eventdata, handles)
%
    tpi=2*pi;

    d=getappdata(0,'d');
    k1=getappdata(0,'k1');
    k2=getappdata(0,'k2');
    mass=getappdata(0,'mass');
    sd=getappdata(0,'sd');
    fig_num=getappdata(0,'fig_num');
    
    f=getappdata(0,'f');
    nf=getappdata(0,'nf');    
    
    fstart=f(1);
    fend=f(nf);

 
    A=zeros(nf,1);
    B=zeros(nf,1);
    
    a_rec=1000;
    f_rec=1000;
    
    d_orig=d;
    k1_orig=k1;
    k2_orig=k2;
    
    
    for ijk=1:6000
        
        if(ijk==1)
            scale1=1;
            scale2=1;
            scale3=1;
        else
            scale1=(0.92+0.16*rand());
            scale2=(0.92+0.16*rand());
            scale3=(0.92+0.16*rand());            
            
            if(ijk>100 && rand()>0.5)
                scale1=scr1*(0.98+0.04*rand());
                scale2=scr2*(0.98+0.04*rand());
                scale3=scr3*(0.98+0.04*rand());               
            end
            
        end
        
        d=d_orig*scale1;
        k1=k1_orig*scale2;
        k2=k2_orig*scale3;
 
        omega_1=sqrt(k1/mass);
        omega_2=sqrt(k2/mass);
        
        fn=omega_1/tpi;
        
        
        for i=1:nf
        
            omega=tpi*f(i);
            s=(1i)*omega;
        
            term= (  omega_2^2 + omega_1^2 )*d*s + omega_1^2*omega_2^2;
            num=term;
            den= d*s^3 + omega_2^2*s^2 + term;
            A(i)=num/den;        
        
            rho=f(i)/fn;
        
            if(ijk==1)
                B(i)=(1+(1i*sd))/(1-rho^2+(1i*sd));
            end
            
        end
        
        if(ijk==1)
            [Bmax,I]=max(B);
            fB=f(I);
        end
        
        [Amax,I]=max(A);
        fA=f(I);
        
        aerr=abs(20*log10(max(A)/Bmax));
            
        ferr=abs(log(fA/fB)/log(2));
        
        if((aerr<a_rec && ferr<=f_rec) || (aerr<a_rec && ferr<=0 ) )
                Ar=A;
                a_rec=aerr;
                f_rec=ferr;
                out1=sprintf(' %d  %8.4g  %8.4g  %8.4g   %8.4g   %8.4g  ',ijk,a_rec,f_rec,scale1,scale2,scale3);
                disp(out1);
                
                scr1=scale1;
                scr2=scale2;
                scr3=scale3;
                
                d_rec=d;
                k1_rec=k1;
                k2_rec=k2;
        end
        
    end
    
    A=Ar;
    
    A=fix_size(A);
    B=fix_size(B);
    
    B_mag=abs(B);
    B_phase=atan2(imag(B),real(B))*180/pi;
%
    A_mag=abs(A);
    A_phase=atan2(imag(A),real(A))*180/pi;
%
    f=fix_size(f);
    A_mag=fix_size(A_mag);
    A_phase=fix_size(A_phase);
    B_mag=fix_size(B_mag);
    B_phase=fix_size(B_phase);    
 
    AA=[f A_mag];
    BB=[f B_mag];
    
    data1=[f A];
    data2=[f B];
    
    assignin('base', 'simplified_model_trans', AA);
    assignin('base', 'ideal_trans', BB);
    
    
%
      [zmax,fz_max]=find_max(AA);
    [zzmax,fzz_max]=find_max(BB);
%
    out1=sprintf('\n Optimized parameters:  c=%8.4g  k1=%8.4g  k2=%8.4g  ',d_rec*mass,k1_rec,k2_rec);
    disp(out1);
    
    setappdata(0,'d',d);
    setappdata(0,'k1',k1);
    setappdata(0,'k2',k2);     
 
    out5 = sprintf('\n Simplified Model: Peak is %10.5g (G/G) at %10.5g Hz ',zmax,fz_max);
    disp(out5);
    out6 = sprintf('\n      Ideal Model: Peak is %10.5g (G/G) at %10.5g Hz ',zzmax,fzz_max);
    disp(out6);   
    
    t_string='Transmissibility';
    
    fmin=fstart;
    fmax=fend;
    ff=f;
    FRF_p=A_phase;
    FRF_m=A_mag;
    ylab='Trans (G/G)';
    md=5;
    
    [fig_num]=...
    plot_magnitude_phase_function(fig_num,t_string,fmin,fmax,ff,FRF_p,FRF_m,ylab,md);
 
     setappdata(0,'trans',[f  A_mag A_phase]);
 
     ppp1=AA;
     ppp2=BB;
     
     leg1='Simple Model';
     leg2='Ideal';
     x_label='Frequency (Hz)';
     y_label=ylab;
 

     [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);
    
 
     [fig_num]=subplot_real_image_two_loglin(fig_num,data1,data2,x_label,y_label,fmin,fmax,leg1,leg2);

     setappdata(0,'fig_num',fig_num);        
    
%%%     
     

function transmissibility(hObject, eventdata, handles)
%
    tpi=2*pi;

    d=getappdata(0,'d');
    k1=getappdata(0,'k1');
    k2=getappdata(0,'k2');
    mass=getappdata(0,'mass');
    fig_num=getappdata(0,'fig_num');
    
    f=getappdata(0,'f');
    nf=getappdata(0,'nf');    
    
    fstart=f(1);
    fend=f(nf);
    
    omega1_2=(k1/mass);
    omega2_2=(k2/mass); 
   
    A=zeros(nf,1);

    for i=1:nf
        
        omega=tpi*f(i);
        s=(1i)*omega;
        
        term= (  omega2_2 + omega1_2 )*d*s + omega1_2*omega2_2;
        num=term;
        den= d*s^3 + omega2_2*s^2 + term;
        A(i)=num/den;        
    
    end
    
   
    A=fix_size(A);
%
    A_mag=abs(A);
    A_phase=atan2(imag(A),real(A))*180/pi;
%
    f=fix_size(f);
    A_mag=fix_size(A_mag);
    A_phase=fix_size(A_phase);
    
    AA=[f A_mag];
    
    setappdata(0,'trans',[f  A_mag A_phase]);

%
    [zmax,fz_max]=find_max(AA);
%
 
    out5 = sprintf('\n Peak is %10.5g (G/G) at %10.5g Hz ',zmax,fz_max);
    disp(out5);
    
    t_string='Transmissibility';
    
    fmin=fstart;
    fmax=fend;
    ff=f;
    FRF_p=A_phase;
    FRF_m=A_mag;
    ylab='Trans (G/G)';
    md=5;
    
    [fig_num]=...
    plot_magnitude_phase_function(fig_num,t_string,fmin,fmax,ff,FRF_p,FRF_m,ylab,md);
 
    setappdata(0,'fig_num',fig_num);
    
%%%%%%%%%%%%%    
    

function Genta_Amati(hObject, eventdata, handles)
%
    transmissibility(hObject, eventdata, handles);
    
    

function time_history_response(hObject, eventdata, handles)
%
    fig_num=getappdata(0,'fig_num');
    d=getappdata(0,'d');
    k1=getappdata(0,'k1');
    k2=getappdata(0,'k2'); 
    mass=getappdata(0,'mass');
    
    try  
        FS=get(handles.edit_input_array,'String');
        THM=evalin('base',FS);  

    catch  
        warndlg('Input Array does not exist.  Try again.')
        return;
    end


    t=THM(:,1);
    base=THM(:,2);
    yin=base;
    
    num=length(t);
%
    dt=(t(num)-t(1))/(num-1);
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
        warndlg(' Warning:  time step is not constant.  ')
        return;
    end
    

    omega1_2=(k1/mass);
    omega2_2=(k2/mass);    
    
    f=(omega1_2+omega2_2);
    g=(omega1_2*omega2_2)/d;
    
    p = [1 omega2_2/d   f  g];

%   [Rc]=cubic_roots(p(1),p(2),p(3),p(4));

    R=roots(p); 
    
    R
   
    RI=imag(R);
    
    [~,index] = min(abs(0-RI));
   
    u=real(R(index));
    
    R(index)=[];
    
    v=R(1);
       
    A=f;
    B=g;

    a=real(v);
    b=abs(imag(v));
    
    out1=sprintf('\n a=%8.4g  b=%8.4g  u=%8.4g\n',a,b,u);
    disp(out1);    
    
    C1=(A*u+B)/(u^2-2*a*u+b^2+a^2);
    C2=C1;
    Q=B*u-A*b^2-A*a^2-2*B*a;
    P=(A*u+B);
    lambda=Q/P;

    C1;
    C3=(lambda+a)/b;

    D=C1;
    E=C3;
    

    T=dt;

    bT=b*T;
    aT=a*T;

%%%

%   assume(b>0);ilt(( ((A*s+B)/( (s-c)*( s^2*((s-a)^2+b^2 ) ) ))), s, t);

    W1=(A*a-B);
    W2=(W1*b^2+A*a^3+B*a^2)*u^3;
    W3=(W2+(A*b^4+3*B*a*b^2-A*a^4-B*a^3)*u^2);
    W4=((-A*a^2-2*B*a)*b-A*b^3)*u^3;
    W5=((2*A*a-B)*b^3+(2*A*a^3+3*B*a^2)*b)*u^2;
    W6=(W4+W5);
    W7=(-A*b^5-2*A*a^2*b^3-A*a^4*b)*u;
    W8=(W7-B*b^5-2*B*a^2*b^3-B*a^4*b);
    W9=(B*b^3+B*a^2*b)*u^3;
    W10=(-2*B*a*b^3-2*B*a^3*b)*u^2;
    W11=(B*b^5+2*B*a^2*b^3+B*a^4*b)*u;
    W12=(W9+W10+W11);
    W13=(A*b^3+(A*a^2+2*B*a)*b)*u^3;
    W14=(B-2*A*a)*b^3;
    W15=(-2*A*a^3-3*B*a^2)*b;
    W16=(W14+W15)*u^2;
    W17=(A*b^5+2*A*a^2*b^3+A*a^4*b)*u;
    W18=B*b^5+2*B*a^2*b^3+B*a^4*b;
    W19=W16+W17+W18;
    W20=W13+W19;
    W21=(b^5+2*a^2*b^3+a^4*b)*u^4;
    W22=(-2*a*b^5-4*a^3*b^3-2*a^5*b)*u^3;
    W23=(b^7+3*a^2*b^5+3*a^4*b^3+a^6*b)*u^2;
    W24=(W21+W22+W23);
    
    % Inverse Laplace transform
    % -(W3*exp(a*t)*sin(b*t)+W6*exp(a*t)*cos(b*t)+ W8*exp(u*t)+W12*t+W20)/W24
 
 
    V1=(W3/W24);
    V2=(W6/W24);
    V3=(W8/W24);
    V4=(W12/W24);
    V5=(W20/W24);
    
    % Simplified Inverse Laplace transform
    % qqq=-V1*exp(a*t)*sin(b*t)-V2*exp(a*t)*cos(b*t)-V3*exp(u*t)-V4*t-V5;
    
 
    P0=(V5+V3+V2)/T;
    P1=((-V5-V2)*exp(T*u)+V1*exp(T*a)*sin(T*b)+(-2*V5-2*V3-V2)*exp(T*a)*cos(T*b)-2*V5+T*V4-2*V3-2*V2)/T;
    P2=((-V1*exp(T*a)*sin(T*b)+(2*V5+V2)*exp(T*a)*cos(T*b)+2*V5-T*V4+2*V2)*exp(T*u)-2*V1*exp(T*a)*sin(T*b)+(4*V5-2*T*V4+4*V3+2*V2)*exp(T*a)*cos(T*b)+(V5+V3)*exp(2*T*a)+V5+V3+V2)/T;
    P3=((2*V1*exp(T*a)*sin(T*b)+(-4*V5+2*T*V4-2*V2)*exp(T*a)*cos(T*b)-V5*exp(2*T*a)-V5-V2)*exp(T*u)+V1*exp(T*a)*sin(T*b)+(-2*V5-2*V3-V2)*exp(T*a)*cos(T*b)+(-2*V5+T*V4-2*V3)*exp(2*T*a))/T;
    P4=((-V1*exp(T*a)*sin(T*b)+(2*V5+V2)*exp(T*a)*cos(T*b)+(2*V5-T*V4)*exp(2*T*a))*exp(T*u)+(V5+V3)*exp(2*T*a))/T;
    P5=-V5*exp(T*u+2*T*a)/T;
 
 
    Q1=(-exp(T*u)-2*exp(T*a)*cos(T*b));
    Q2=(2*cos(T*b)*exp(T*u+T*a)+exp(2*T*a));
    Q3=-exp(T*u+2*T*a);
    Q4=0;    
    
    out1=sprintf('\n Q1=%8.4g   Q2=%8.4g   Q3=%8.4g   Q4=%8.4g  ',Q1,Q2,Q3,Q4);
    disp(out1);
 
 
    % RI Z-transform
    % zzz=-(P0*z^5+P1*z^4+P2*z^3+P3*z^2+P4*z+P5)/(z^4+Q1*z^3+Q2*z^2+Q3*z);
    
    forward=-[ P0, P1, P2, P3, P4, P5 ];    
    back   =[ 1, Q1, Q2, Q3, Q4];   % recursive    
%    

    accel=filter(forward,back,yin); 
    

    xlabel2='Time (sec)';
    ylabel1='Accel (G)';
    ylabel2=ylabel1;
    data1=[t accel];
    data2=[t yin];
    t_string1='Response';
    t_string2='Input';

    
    setappdata(0,'response',[t accel]);
    
    try
        [fig_num]=subplots_two_linlin_two_titles_scale(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2);   
    catch
        disp(' Plot unsuccessful');
    end
%
    amax=max(abs(accel));
    
    out1=sprintf('\n Max Abs Response = %8.4g G  \n',amax);
    disp(out1);

    setappdata(0,'fig_num',fig_num);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit

change(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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

change(hObject, eventdata, handles);


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



function edit_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_mass as a double


% --- Executes during object creation, after setting all properties.
function edit_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_k1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_k1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_k1 as text
%        str2double(get(hObject,'String')) returns contents of edit_k1 as a double


% --- Executes during object creation, after setting all properties.
function edit_k1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_k1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_k2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_k2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_k2 as text
%        str2double(get(hObject,'String')) returns contents of edit_k2 as a double


% --- Executes during object creation, after setting all properties.
function edit_k2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_k2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_c_Callback(hObject, eventdata, handles)
% hObject    handle to edit_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_c as text
%        str2double(get(hObject,'String')) returns contents of edit_c as a double


% --- Executes during object creation, after setting all properties.
function edit_c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_sd_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sd as text
%        str2double(get(hObject,'String')) returns contents of edit_sd as a double


% --- Executes during object creation, after setting all properties.
function edit_sd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_output.
function listbox_output_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output

change(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fstart_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fstart as text
%        str2double(get(hObject,'String')) returns contents of edit_fstart as a double


% --- Executes during object creation, after setting all properties.
function edit_fstart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fend_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fend as text
%        str2double(get(hObject,'String')) returns contents of edit_fend as a double


% --- Executes during object creation, after setting all properties.
function edit_fend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on selection change in listbox_calibration.
function listbox_calibration_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_calibration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_calibration contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_calibration


% --- Executes during object creation, after setting all properties.
function listbox_calibration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_calibration (see GCBO)
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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_output,'Value');

if(n==1)
    data=getappdata(0,'trans');
else
    data=getappdata(0,'response');    
end

output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);
 
h = msgbox('Save Complete'); 



% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_save,'Visible','off');

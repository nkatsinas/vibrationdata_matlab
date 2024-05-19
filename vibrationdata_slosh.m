function varargout = vibrationdata_slosh(varargin)
% VIBRATIONDATA_SLOSH MATLAB code for vibrationdata_slosh.fig
%      VIBRATIONDATA_SLOSH, by itself, creates a new VIBRATIONDATA_SLOSH or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_SLOSH returns the handle to a new VIBRATIONDATA_SLOSH or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_SLOSH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_SLOSH.M with the given input arguments.
%
%      VIBRATIONDATA_SLOSH('Property','Value',...) creates a new VIBRATIONDATA_SLOSH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_slosh_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_slosh_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_slosh

% Last Modified by GUIDE v2.5 29-Jun-2015 17:37:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_slosh_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_slosh_OutputFcn, ...
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


% --- Executes just before vibrationdata_slosh is made visible.
function vibrationdata_slosh_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_slosh (see VARARGIN)

% Choose default command line output for vibrationdata_slosh
handles.output = hObject;

listbox_units_Callback(hObject, eventdata, handles);
listbox_geometry_Callback(hObject, eventdata, handles);
disp(' ');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_slosh wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_slosh_OutputFcn(hObject, eventdata, handles) 
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

tpi=2*pi;

iu=get(handles.listbox_units,'Value');

n=get(handles.listbox_geometry,'Value');

g=str2num(get(handles.edit_gravity,'String'));

disp(' ');
if(iu==1)
    out1=sprintf(' gravity acceleration = %g in/sec^2',g);
else
     out1=sprintf(' gravity acceleration = %g m/sec^2',g);   
end
disp(out1);

disp(' ');
if(n==1)  % cone
    disp('cone');
        D=str2num(get(handles.edit_dimension_1,'String'));
    alpha=str2num(get(handles.edit_dimension_2,'String'));
%
    if(iu==1)
        out1=sprintf(' D=%g in, alpha=%g deg',D,alpha);
    else
        out1=sprintf(' D=%g m, alpha=%g deg',D,alpha);      
    end
    disp(out1);
%
    beta=6.65e-09*alpha^4-3.03e-06*alpha^3+5.90e-04*alpha^2-0.0680*alpha+4.12;
%
    fn=(beta/(2*pi))*sqrt(g/D);
%
    out1=sprintf('\n fn = %8.4g Hz  ',fn);
    disp(out1);
%
end
if(n==2)  % cylinder
    disp('cylinder');    
    D=str2num(get(handles.edit_dimension_1,'String'));    
    h=str2num(get(handles.edit_dimension_2,'String'));
%
    if(iu==1)
        out1=sprintf(' D=%g in, h=%g in',D,h);
    else
        out1=sprintf(' D=%g m, h=%g m',D,h);      
    end
    disp(out1);    
%%%
    R=D/2;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    term=@(i,x)(besselj(i-1,x)-(i/x)*besselj(i,x));
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    ib=5;
    mj=4;
%
    lambda=zeros(ib,mj);
%
    for i=0:(ib-1)   % order
%
        j=0;
        dx=0.1;
        a=term(i,dx);
        for k=2:1000
            x=dx*k;
            b=term(i,x);
%
            if(abs(b)<1.0e-20)
                lambda(i+1,j+1)=root;
                j=j+1;
                break;
            end
%
            if((a*b)<0)
                x1=x-dx;
                x2=x;
                [root]=secant_method_sc(term,i,x1,x2);
                lambda(i+1,j+1)=root;
                j=j+1;
            end
            if(j==mj)
                break;
            end
            a=b;
%
        end
%
    end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    kk=1;
    sz=size(lambda);
    for i=0:(sz(1)-1)
%
        for j=0:(sz(2)-1)
            lam=lambda(i+1,j+1)/R;
            f(i+1,j+1)=(1/tpi)*sqrt((lam*g)*tanh(lam*h));
%
            ff(kk,1)=f(i+1,j+1);
            ff(kk,2)=lambda(i+1,j+1);
            ff(kk,3)=i;
            if(i==0)
                ff(kk,4)=j+1;                 
            else
                ff(kk,4)=j;     
            end
            kk=kk+1;
        end
    end    
%
    B = sortrows(ff,1);
%
    kk=kk-1;
%
    disp(' ');
    disp(' i=number of nodal diameters ');
    disp(' j=number of nodal circles ');
    disp(' ');
    disp(' Freq(Hz)      lambda        i   j  ');
    for i=1:16
        out1=sprintf(' %8.4g \t %10.6g \t %d \t %d',B(i,1),B(i,2),round(B(i,3)),round(B(i,4)));
        disp(out1);
    end
%%%
end
%%
%%
%%
if(n==3)  % cylinder, annular
%
    disp('cylinder annular');
%    
    D1=str2num(get(handles.edit_dimension_1,'String'));    
    D2=str2num(get(handles.edit_dimension_2,'String'));     
     h=str2num(get(handles.edit_dimension_3,'String')); 
%
%
    if(iu==1)
        out1=sprintf(' OD=%g in, ID=%g in, h=%g in',D1,D2,h);
    else
        out1=sprintf(' OD=%g m, ID=%g m, h=%g m',D1,D2,h);    
    end
    disp(out1)
%
    cylinder_annular(iu,g,D2,D1,h,tpi);
%
end
%
%%%
%
if(n==4)  % rectangular basin
    disp('rectangular basin');
    L=str2num(get(handles.edit_dimension_1,'String'));    
    W=str2num(get(handles.edit_dimension_2,'String'));     
    h=str2num(get(handles.edit_dimension_3,'String'));    
%
    if(W>L)
        temp=L;
        L=W;
        W=temp;
    end
%
%
    if(iu==1)
        out1=sprintf(' L=%g in, W=%g in, h=%g in',L,W,h);
    else
        out1=sprintf(' L=%g m, W=%g m, h=%g m',L,W,h);    
    end
    disp(out1)
%
    f=zeros(7,7);
    sz=size(f);
%
    kk=1;
    for i=0:(sz(1)-1)
%
        for j=0:(sz(2)-1)
            D=sqrt((i/L)^2+(j/W)^2);
%
            if(D>1.0e-20)
                f(i+1,j+1)=(1/(2*sqrt(pi)))*sqrt((D*g)*tanh(pi*h*D));
%
                ff(kk,1)=f(i+1,j+1);
                ff(kk,2)=D;
                ff(kk,3)=i;
                ff(kk,4)=j+1;                 
                ff(kk,4)=j;     
                kk=kk+1;
            end
        end
    end    
%
    B = sortrows(ff,1);
%
    kk=kk-1;
%
    disp(' ');
    disp(' i=number of nodal diameters ');
    disp(' j=number of nodal circles ');
    disp(' ');
    disp(' Freq(Hz)     i    j  ');
    for i=1:10
        out1=sprintf(' %8.4g     %d    %d',B(i,1),round(B(i,3)),round(B(i,4)));
        disp(out1);
    end
%
end
if(n==5)  % sphere
    disp('sphere');
    d=str2num(get(handles.edit_dimension_1,'String'));    
    h=str2num(get(handles.edit_dimension_2,'String'));
%
    if(iu==1)
        out1=sprintf(' d=%g in, h=%g in',d,h);
    else
        out1=sprintf(' d=%g m, h=%g m',d,h);   
    end
    disp(out1)
%
    r=d/2;
%
    x=h/d;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    beta(1)=12.1*x^5-24.2*x^4+18.7*x^3-6.22*x^2+1.27*x+0.975;
    beta(2)=(-0.2001)*x^5+(14.1148 )*x^4+(-26.1881)*x^3+(19.8671)*x^2+(-7.0447)*x+(3.2759);
    beta(3)=19.3*x^4-37.7*x^3+29.5*x^2-10.8*x+4.50;
%
    disp(' ');
    for i=1:3
%
        fn=(beta(i)/(2*pi))*sqrt(g/r);
%
        out1=sprintf(' f%d = %8.4g Hz  beta=%g',i,fn,beta(i));
        disp(out1);
%
    end
%
end

msgbox('Results written to Command Window');



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(vibrationdata_slosh);


% --- Executes on selection change in listbox_geometry.
function listbox_geometry_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_geometry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_geometry contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_geometry

n=get(handles.listbox_geometry,'Value');


set(handles.text_dimension_3,'Visible','off');
set(handles.edit_dimension_3,'Visible','off');



if(n==1)  % cone
    set(handles.text_dimension_1,'String','Diameter');
    set(handles.text_dimension_2,'String','Cone Apex Angle (deg)');   
end
if(n==2)  % cylinder
    set(handles.text_dimension_1,'String','Diameter');    
    set(handles.text_dimension_2,'String','Height');
end
if(n==3)  % cylinder, annular
    set(handles.text_dimension_1,'String','Outer Diameter');    
    set(handles.text_dimension_2,'String','Inner Diameter');     
    set(handles.text_dimension_3,'String','Height');    
%    
    set(handles.text_dimension_3,'Visible','on');
    set(handles.edit_dimension_3,'Visible','on');     
end
if(n==4)  % rectangular basin
    set(handles.text_dimension_1,'String','Length');    
    set(handles.text_dimension_2,'String','Width');     
    set(handles.text_dimension_3,'String','Height');    
%    
    set(handles.text_dimension_3,'Visible','on');
    set(handles.edit_dimension_3,'Visible','on');    
end
if(n==5)  % sphere
    set(handles.text_dimension_1,'String','Diameter');    
    set(handles.text_dimension_2,'String','Height')      
end


% --- Executes during object creation, after setting all properties.
function listbox_geometry_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_geometry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units

n=get(handles.listbox_units,'Value');

if(n==1)
    set(handles.edit_gravity,'String','386');
    set(handles.text_gravity,'String','in/sec^2');
    set(handles.text_unit,'String','Unit: inches');
else
    set(handles.edit_gravity,'String','9.81');    
    set(handles.text_gravity,'String','m/sec^2');
    set(handles.text_unit,'String','Unit: meters');    
end


% --- Executes during object creation, after setting all properties.
function listbox_units_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_gravity_Callback(hObject, eventdata, handles)
% hObject    handle to edit_gravity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_gravity as text
%        str2double(get(hObject,'String')) returns contents of edit_gravity as a double


% --- Executes during object creation, after setting all properties.
function edit_gravity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gravity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dimension_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dimension_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dimension_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_dimension_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_dimension_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dimension_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dimension_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dimension_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dimension_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_dimension_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_dimension_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dimension_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dimension_3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dimension_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dimension_3 as text
%        str2double(get(hObject,'String')) returns contents of edit_dimension_3 as a double


% --- Executes during object creation, after setting all properties.
function edit_dimension_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dimension_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function cylinder_annular(iu,g,D2,D1,h,tpi)
%
R2=D2/2;
R1=D1/2;
%
x=R2/R1;
if(x>1)
    x=1/x;
end
if(R1<R2)
    R1=R2;
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
term1=@(i,x)((besselj(i-1,x)-besselj(i+1,x))/2);
term2=@(i,x)((bessely(i-1,x)-bessely(i+1,x))/2);  
%
lambda=zeros(10,10);
for i=0:6
   n=1;
   for kj=1:500
       k=kj*0.1;
       x=k;
       xba=x*R2/R1;
       CF=term1(i,x)*term2(i,xba)-term1(i,xba)*term2(i,x);
 %
 %      out1=sprintf('kj=%d  x=%g  t1=%g  t2=%g  t3=%g  t4=%g  CF=%g',kj,x,term1,term2,term3,term4,CF);
 %      disp(out1);
 %
       if(CF==0)
           lambda(i+1,n)=k;
           n=n+1;
           if(n==4)
               break;
           end
       else
           if(kj>=2)
              if((CF*CFb)<0.)
                 for(m=1:20)
                     nk=kb-CFb*(k-kb)/(CF-CFb);
                     x=nk;
                     xba=x*R2/R1;
                     CFn=term1(i,x)*term2(i,xba)-term1(i,xba)*term2(i,x);
                     %
                     if(CFn*CF>0.)
                         CF=CFn;
                         k=nk;
                     else
                         CFb=CFn;
                         kb=nk;                         
                     end
                 end
                 lambda(i+1,n)=nk;
                 n=n+1;
                 if(n==11)
                    break;
                 end  
              end
           end
       end
       CFb=CF;
       kb=k;
   end
end   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
kk=1;
for i=1:6
     for j=1:3
         lam=lambda(i,j)/R1;
         f(i,j)=(1/tpi)*sqrt((lam*g)*tanh(lam*h));
         ii=i-1;
         if(i==1)
             jj=j;
         else
             jj=j-1;
         end
%%         out1=sprintf(' f=%g Hz  lambda=%10.6g  i=%d j=%d',f(i,j),lambda(i,j),ii,jj);
%%         disp(out1);
         ff(kk,1)=f(i,j);
         ff(kk,2)=lambda(i,j);
         ff(kk,3)=ii;
         ff(kk,4)=jj;     
         kk=kk+1;
     end
end    
%
B = sortrows(ff,1);
%
kk=kk-1;
disp(' ');
disp(' i=number of nodal diameters ');
disp(' j=number of nodal circles ');
disp(' ');
disp(' Freq(Hz)      lambda        i   j  ');
for i=1:kk
    out1=sprintf(' %8.4g \t %10.6g \t %d \t %d',B(i,1),B(i,2),round(B(i,3)),round(B(i,4)));
    disp(out1);
end
%
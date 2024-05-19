function varargout = beam_bending_arbitrary(varargin)
% BEAM_BENDING_ARBITRARY MATLAB code for beam_bending_arbitrary.fig
%      BEAM_BENDING_ARBITRARY, by itself, creates a new BEAM_BENDING_ARBITRARY or raises the existing
%      singleton*.
%
%      H = BEAM_BENDING_ARBITRARY returns the handle to a new BEAM_BENDING_ARBITRARY or the handle to
%      the existing singleton*.
%
%      BEAM_BENDING_ARBITRARY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BEAM_BENDING_ARBITRARY.M with the given input arguments.
%
%      BEAM_BENDING_ARBITRARY('Property','Value',...) creates a new BEAM_BENDING_ARBITRARY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before beam_bending_arbitrary_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to beam_bending_arbitrary_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help beam_bending_arbitrary

% Last Modified by GUIDE v2.5 02-Oct-2014 15:18:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @beam_bending_arbitrary_OpeningFcn, ...
                   'gui_OutputFcn',  @beam_bending_arbitrary_OutputFcn, ...
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


% --- Executes just before beam_bending_arbitrary is made visible.
function beam_bending_arbitrary_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to beam_bending_arbitrary (see VARARGIN)

% Choose default command line output for beam_bending_arbitrary
handles.output = hObject;

iu=getappdata(0,'unit');
L=getappdata(0,'length');

if(iu==1)
    set(handles.length_unit_text,'String','inch');
    LS=sprintf('Beam Length = %g inch',L);
else
    set(handles.length_unit_text,'String','meters');
    LS=sprintf('Beam Length = %g meters',L);
end

set(handles.uipanel_save,'Visible','off');

set(handles.beam_length_text,'String',LS);

set(handles.pushbutton_rainflow,'Enable','off');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes beam_bending_arbitrary wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = beam_bending_arbitrary_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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



function input_edit_Callback(hObject, eventdata, handles)
% hObject    handle to input_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_edit as text
%        str2double(get(hObject,'String')) returns contents of input_edit as a double


% --- Executes during object creation, after setting all properties.
function input_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Calculate_pushbutton.
function Calculate_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Calculate_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


try
 
    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end   


disp(' ');
disp(' * * * * * * ');
disp(' ');

 fig_num=1;
 
      try  
        damp=getappdata(0,'damp_ratio');
      catch
        warndlg('Damping vector does not exist');
        return
      end  
 
      
      fn=getappdata(0,'fn');
      iu=getappdata(0,'unit');
      part=getappdata(0,'part');
      PF=part;
 
      beta=getappdata(0,'beta');
      
      LBC=getappdata(0,'LBC');
      RBC=getappdata(0,'RBC');
      
      E=getappdata(0,'E');
      I=getappdata(0,'I'); 
      
      EI=E*I;
      
      x=str2num(get(handles.x_edit,'String')); 
      
      sq_mass=getappdata(0,'sq_mass');
      beta=getappdata(0,'beta');
      C=getappdata(0,'C');
      
      n=length(fn);
      num_fn=n;
      
    [ModeShape,ModeShape_dd,ModeShape_ddd]=beam_bending_modes_shapes_alt(LBC,RBC);
%
%
%
FS=get(handles.input_edit,'String');
%
THM=evalin('base',FS);
%
    t=THM(:,1);
    num_steps=length(t);
    abase=THM(:,2);
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
%
disp(' ');
    
disp('        Natural    Participation   Damping  ');
disp('Mode   Frequency      Factor        Ratio   ');
%
for i=1:length(fn)
    out1 = sprintf('%d  %10.4g Hz   %10.4g   %8.4g ',i,fn(i),part(i),damp(i) );
    disp(out1)
end    
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
       nrd=zeros(num_steps,n);
       nrv=zeros(num_steps,n);
       nra=zeros(num_steps,n); 
       nbm=zeros(num_steps,n);
%     
%
    [a1,a2,ra_b1,ra_b2,ra_b3,rv_b1,rv_b2,rv_b3,rd_b1,rd_b2,rd_b3]=...
                                      srs_coefficients_avd(fn,damp,dt);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

%
    L=getappdata(0,'length');

    xx=sort(unique([x L*[0 0.5 1]]));
    
    nxx=length(xx);
    
    rd=zeros(num_steps,nxx);
    rv=zeros(num_steps,nxx);
    ra=zeros(num_steps,nxx);    
    bm=zeros(num_steps,nxx);
    shear=zeros(num_steps,nxx);
%
    ZZ=zeros(nxx,num_fn);
%
    num_fn=get(handles.listbox_num_modes,'Value');
%
    for j=1:num_fn
%
        if(abs(PF(j))>0)
%
            yp=-abase*PF(j);
%
            back   =[     1, -a1(j), -a2(j) ];
%
%   relative velocity
%
            clear forward;
            forward=[ rv_b1(j),  rv_b2(j),  rv_b3(j) ];    
            nrv(:,j)=filter(forward,back,yp);
%
%   relative displacement
%
            clear forward;
            forward=[ rd_b1(j),  rd_b2(j),  rd_b3(j) ];      
            nrd(:,j)=filter(forward,back,yp);
%
%   relative acceleraiton
%
            clear forward;  
            forward=[ ra_b1(j),  ra_b2(j),  ra_b3(j) ];    
            nra(:,j)=filter(forward,back,yp);                
   
%            
            for k=1:nxx      
                
               arg=beta(j)*xx(k);
               ZZ(k,j)=ModeShape(arg,C(j),sq_mass);
%
               rd(:,k)= rd(:,k) +ZZ(k,j)*nrd(:,j);
               rv(:,k)= rv(:,k) +ZZ(k,j)*nrv(:,j);
               ra(:,k)= ra(:,k) +ZZ(k,j)*nra(:,j);                
                            
               ZZdd=ModeShape_dd(arg,C(j),beta(j),sq_mass);
               ZZddd=ModeShape_ddd(arg,C(j),beta(j),sq_mass);
                  bm(:,k)=    bm(:,k) +ZZdd*nrd(:,j);  
               shear(:,k)= shear(:,k) +ZZddd*nrd(:,j);               
            end
%        
        end
    end
%
    bm=bm*EI;
    shear=shear*EI;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    nt=length(abase);
    acc=zeros(nt,nxx);
%
    for i=1:nxx
        acc(:,i)=ra(:,i)+abase;
    end
%
    if(iu==1)
        rd=rd*386;
        rv=rv*386;        
        bm=bm*386; 
        shear=shear*386;
    else
        rd=rd*9.81;
        rv=rv*9.81;       
        bm=bm*9.81;     
        shear=shear*9.81;
    end
%
    cna=getappdata(0,'cna');
%

%%%
%%%
    if(iu==1)
        out3=sprintf('\n Absolute Acceleration = %8.4g G at %g in',max(abs(acc(:,1))),xx(1)); 
          out4=sprintf('                       = %8.4g G at %g in',max(abs(acc(:,2))),xx(2));   
          out5=sprintf('                       = %8.4g G at %g in',max(abs(acc(:,3))),xx(3));           
   
          if(length(xx)==4)
             out6=sprintf('                       = %8.4g in/sec at %g in',max(abs(acc(:,4))),xx(4));               
          end
    
    else
        out3=sprintf('\n Absolute  Acceleration = %8.4g G at %g m',max(abs(acc(:,1))),xx(1)); 
          out4=sprintf('                        = %8.4g G at %g m',max(abs(acc(:,2))),xx(2));   
          out5=sprintf('                        = %8.4g G at %g m',max(abs(acc(:,3))),xx(3));           
   
          if(length(xx)==4)
           out6=sprintf('                       = %8.4g G at %g m',max(abs(rv(:,4))),xx(4));               
          end
    end    
%
    disp(out3);
    disp(out4);
    disp(out5);
    if(length(xx)==4)
        disp(out6);
    end    
%%%
%%%
    if(iu==1)
        out3=sprintf('\n Relative Velocity = %8.4g in/sec at %g in',max(abs(rv(:,1))),xx(1)); 
          out4=sprintf('                   = %8.4g in/sec at %g in',max(abs(rv(:,2))),xx(2));   
          out5=sprintf('                   = %8.4g in/sec at %g in',max(abs(rv(:,3))),xx(3));           
   
          if(length(xx)==4)
           out6=sprintf('                  = %8.4g in/sec at %g in',max(abs(rv(:,4))),xx(4));               
          end
    
    else
        out3=sprintf('\n Relative Velocity = %8.4g m/sec at %g m',max(abs(rv(:,1))),xx(1)); 
          out4=sprintf('                   = %8.4g m/sec at %g m',max(abs(rv(:,2))),xx(2));   
          out5=sprintf('                   = %8.4g m/sec at %g m',max(abs(rv(:,3))),xx(3));           
   
          if(length(xx)==4)
           out6=sprintf('                  = %8.4g m/sec at %g m',max(abs(rv(:,4))),xx(4));               
          end
    end    
%
    disp(out3);
    disp(out4);
    disp(out5);
    if(length(xx)==4)
        disp(out6);
    end    
%%%
%%%
    if(iu==1)
        out3=sprintf('\n Relative Displacement = %8.4g in at %g in',max(abs(rd(:,1))),xx(1)); 
          out4=sprintf('                       = %8.4g in at %g in',max(abs(rd(:,2))),xx(2));   
          out5=sprintf('                       = %8.4g in at %g in',max(abs(rd(:,3))),xx(3));           
   
          if(length(xx)==4)
           out6=sprintf('                      = %8.4g in at %g in',max(abs(rd(:,4))),xx(4));               
          end
    
    else
        out3=sprintf('\n Relative Displacement = %8.4g mm at %g m',max(abs(rd(:,1))),xx(1)); 
          out4=sprintf('                       = %8.4g mm at %g m',max(abs(rd(:,2))),xx(2));   
          out5=sprintf('                       = %8.4g mm at %g m',max(abs(rd(:,3))),xx(3));           
   
          if(length(xx)==4)
           out6=sprintf('                      = %8.4g mm at %g m',max(abs(rd(:,4))),xx(4));               
          end
    end    
%
    disp(out3);
    disp(out4);
    disp(out5);
    if(length(xx)==4)
        disp(out6);
    end    

%%%
%%%
    if(iu==1)
        out3=sprintf('\n Bending Moment = %8.4g in-lbf at %g in',max(abs(bm(:,1))),xx(1)); 
          out4=sprintf('                = %8.4g in-lbf at %g in',max(abs(bm(:,2))),xx(2));   
          out5=sprintf('                = %8.4g in-lbf at %g in',max(abs(bm(:,3))),xx(3));           
   
          if(length(xx)==4)
            out6=sprintf('                = %8.4g in-lbf at %g in',max(abs(bm(:,4))),xx(4));               
          end
    
    else
        out3=sprintf('\n Bending Moment = %8.4g Nm at %g m',max(abs(bm(:,1))),xx(1)); 
          out4=sprintf('                = %8.4g Nm at %g m',max(abs(bm(:,2))),xx(2));   
          out5=sprintf('                = %8.4g Nm at %g m',max(abs(bm(:,3))),xx(3));
    
           if(length(xx)==4)
            out6=sprintf('                = %8.4g in-lbf at %g m',max(abs(bm(:,4))),xx(4));               
          end   
    end    
%
    disp(out3);
    disp(out4);
    disp(out5);
    if(length(xx)==4)
        disp(out6);
    end    
    disp(' ');
    
%%%
%%%
    if(iu==1)
        out3=sprintf('\n  Shear Force = %8.4g lbf at %g in',max(abs(shear(:,1))),xx(1)); 
          out4=sprintf('                = %8.4g lbf at %g in',max(abs(shear(:,2))),xx(2));   
          out5=sprintf('                = %8.4g lbf at %g in',max(abs(shear(:,3))),xx(3));           
   
          if(length(xx)==4)
            out6=sprintf('                = %8.4g lbf at %g in',max(abs(shear(:,4))),xx(4));               
          end
    
    else
        out3=sprintf('\n Shear Force = %8.4g N at %g m',max(abs(shear(:,1))),xx(1)); 
          out4=sprintf('                = %8.4g N at %g m',max(abs(shear(:,2))),xx(2));   
          out5=sprintf('                = %8.4g N at %g m',max(abs(shear(:,3))),xx(3));
    
           if(length(xx)==4)
            out6=sprintf('                = %8.4g N at %g m',max(abs(shear(:,4))),xx(4));               
          end   
    end    
%
    disp(out3);
    disp(out4);
    disp(out5);
    if(length(xx)==4)
        disp(out6);
    end    
    disp(' ');
    
%%%
%%%
    c=cna;
%
    if(iu==1)
        
        out2=sprintf('\n Distance from neutral axis = %8.4g in ',cna);
        
        out3=sprintf('\n Bending Stress = %8.4g psi at %g in',(c/I)*max(abs(bm(:,1))),xx(1)); 
          out4=sprintf('                = %8.4g psi at %g in',(c/I)*max(abs(bm(:,2))),xx(2));   
          out5=sprintf('                = %8.4g psi at %g in',(c/I)*max(abs(bm(:,3))),xx(3));           
   
          if(length(xx)==4)
            out6=sprintf('                = %8.4g psi at %g in',(c/I)*max(abs(bm(:,4))),xx(4));               
          end
    
    else
        
        out2=sprintf('\n Distance from neutral axis = %8.4g m ',cna);
        
        out3=sprintf('\n Bending Stress = %8.4g Pa at %g m',(c/I)*max(abs(bm(:,1))),xx(1)); 
          out4=sprintf('                = %8.4g Pa at %g m',(c/I)*max(abs(bm(:,2))),xx(2));   
          out5=sprintf('                = %8.4g Pa at %g m',(c/I)*max(abs(bm(:,3))),xx(3));
    
           if(length(xx)==4)
            out6=sprintf('                = %8.4g Pa at %g m',max(abs(bm(:,4))),xx(4));               
          end   
    end    
%
    disp(out2);
    disp(out3);
    disp(out4);
    disp(out5);
    if(length(xx)==4)
        disp(out6);
    end    
    disp(' ');

%%%
%%%
    sz=size(t);
    if(sz(2)>sz(1))
        t=t';
    end
%
    sz=size(acc);
    if(sz(2)>sz(1))
        acc=acc';
    end
%
    sz=size(rd);
    if(sz(2)>sz(1))
        rd=rd';
    end
%%%
%%%
%
    for i=1:nxx
        if(x==xx(i))
            k=i;
            break;
        end
    end
%
    bstress=(c/I)*bm(:,k);
%
    sz=size(bstress);
    if(sz(2)>sz(1))
        bstress=bstress';
    end
%
    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,abase);
%
    title('Base Input Acceleration');
    ylabel('Accel(G) ');
    xlabel('Time(sec)'); 
    grid on;
%%
%
    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,acc(:,k)); 
    acceleration=[t acc(:,k)];
%
    if(iu==1)
        out1=sprintf('Response Absolute Acceleration at %g in',x);        
    else
        out1=sprintf('Response Absolute Acceleration at %g m',x);
    end
    title(out1);
    ylabel('Accel(G) ');
    xlabel('Time(sec)'); 
    grid on;
%%
%%
    figure(fig_num)
    fig_num=fig_num+1;
%
    if(iu==1)
        plot(t,rv(:,k));
        out1=sprintf('Relative Velocity at %g in',x);
        ylabel('Rel Vel (in/sec)');      
    else
        plot(t,rv(:,k));
        out1=sprintf('Relative Velocity  at %g m',x);
        ylabel('Rel Vel (m/sec)');        
    end
    relative_velocity=[t rv(:,k)];   
    title(out1);
    xlabel('Time(sec)'); 
    grid on;     
%%
%%
    figure(fig_num)
    fig_num=fig_num+1;
%
    if(iu==1)
        plot(t,rd(:,k));
        out1=sprintf('Relative Displacement at %g in',x);
        ylabel('Rel Disp (inch)');      
    else
        plot(t,rd(:,k)*1000);
        out1=sprintf('Relative Displacement  at %g m',x);
        ylabel('Rel Disp (mm)');        
    end
    relative_displacement=[t rd(:,k)];       
    title(out1);
    xlabel('Time(sec)'); 
    grid on;    
%%
%%
    figure(fig_num)
    fig_num=fig_num+1;
%
    stss=std(bstress);

    if(iu==1)
        plot(t,bstress);
        out1=sprintf('Bending Stress at %g in, %8.4g psi RMS',x,stss);
        ylabel('Stress (psi)');      
    else
        plot(t,bstress);
        out1=sprintf('Bending Stress  at %g m, %8.4g Pa RMS',x,stss);
        ylabel('Stress (Pa)');        
    end
    bending_stress=[t bstress];   
    title(out1);
    xlabel('Time(sec)'); 
    grid on;        
%%
%%

setappdata(0,'acceleration',acceleration);
setappdata(0,'relative_velocity',relative_velocity);
setappdata(0,'relative_displacement',relative_displacement);
setappdata(0,'bending_stress',bending_stress);
setappdata(0,'ZZ',ZZ);
setappdata(0,'xx',xx);

%%
%%
set(handles.uipanel_save,'Visible','on');

msgbox('Calculation complete.  Output written to Matlab Command Window.');      

setappdata(0,'fig_num',fig_num);    
    


% --- Executes on button press in Return_pushbutton.
function Return_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Return_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close(beam_bending_arbitrary);


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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_response,'Value');

if(n==1)
    data=getappdata(0,'acceleration');
end
if(n==2)
   data=getappdata(0,'relative_velocity');
end
if(n==3)
    data=getappdata(0,'relative_displacement');
end
if(n==4)
    data=getappdata(0,'bending_stress');
end


output_name=get(handles.edit_output_array_name,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 

set(handles.pushbutton_rainflow,'Enable','on');


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


% --- Executes on button press in pushbutton_rainflow.
function pushbutton_rainflow_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_rainflow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s1= fatigue_toolbox;
set(handles.s1,'Visible','on');

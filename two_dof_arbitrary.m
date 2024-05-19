function varargout = two_dof_arbitrary(varargin)
% TWO_DOF_ARBITRARY MATLAB code for two_dof_arbitrary.fig
%      TWO_DOF_ARBITRARY, by itself, creates a new TWO_DOF_ARBITRARY or raises the existing
%      singleton*.
%
%      H = TWO_DOF_ARBITRARY returns the handle to a new TWO_DOF_ARBITRARY or the handle to
%      the existing singleton*.
%
%      TWO_DOF_ARBITRARY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TWO_DOF_ARBITRARY.M with the given input arguments.
%
%      TWO_DOF_ARBITRARY('Property','Value',...) creates a new TWO_DOF_ARBITRARY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before two_dof_arbitrary_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to two_dof_arbitrary_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help two_dof_arbitrary

% Last Modified by GUIDE v2.5 11-Apr-2015 14:25:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @two_dof_arbitrary_OpeningFcn, ...
                   'gui_OutputFcn',  @two_dof_arbitrary_OutputFcn, ...
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


% --- Executes just before two_dof_arbitrary is made visible.
function two_dof_arbitrary_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to two_dof_arbitrary (see VARARGIN)

% Choose default command line output for two_dof_arbitrary
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

set(handles.listbox_psave,'Value',2);

listbox_method_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes two_dof_arbitrary wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = two_dof_arbitrary_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in calculate_pushbutton.
function calculate_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to calculate_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

psave=get(handles.listbox_psave,'Value');

fig_num=getappdata(0,'fig_num');
      damp=getappdata(0,'damping');
ModeShapes=getappdata(0,'ModeShapes');
        fn=getappdata(0,'fn');
        m2=getappdata(0,'m2');
      unit=getappdata(0,'unit');
%


k=get(handles.listbox_method,'Value');
 
if(k==1)
  FS=get(handles.edit_input_array,'String');
  THM=evalin('base',FS);   
else
  THM=getappdata(0,'THM');
end


    t=THM(:,1);
    base=THM(:,2);
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
ncontinue=1;
if(((dtmax-dtmin)/dt)>0.01)
    disp(' ')
    disp(' Warning:  time step is not constant.  ')
    Icon='warn';
    Title='Warning';
    Message='Time step is not constant.'; 
    msgbox(Message,Title,Icon);
end
if(ncontinue==1)
%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(t,base);
    data1=[t base];
    grid on;
    xlabel('Time(sec)');
    ylabel('Accel(G)');
    title('Base Input ');
%
    Q=ModeShapes;
    MST=ModeShapes';
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Digital Recursive Filtering Relationship 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
    clear temp;
    temp=base;
    clear base;
    ntt=length(temp)+round((1.5/fn(1))/dt);
    base=zeros(ntt,1);
    base(1:length(temp))=temp;
%
    clear t;
    t=THM(1,1)+linspace(0,(ntt-1)*dt,ntt);
%
    nt=ntt;
%
    rd=zeros(nt,2);
    ra=zeros(nt,2);
%
    x=zeros(nt,2);
    a=zeros(nt,2);
%    
    acc=zeros(nt,2);
%
    mass=[m2(1,1); m2(2,2)];
%
    yy=-MST*mass*base';
    
%
    for j=1:2
%        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
        omegan=2.*pi*fn(j);
        omegad=omegan*sqrt(1.-(damp(j)^2));
%    
        cosd=cos(omegad*dt);
        sind=sin(omegad*dt);
%
        domegadt=damp(j)*omegan*dt;
%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
        eee1=exp(-domegadt);
        eee2=exp(-2.*domegadt);
%
        ecosd=eee1*cosd;
        esind=eee1*sind; 
%
        a1= 2.*ecosd;
        a2=-eee2;    
%
        omeganT=omegan*dt;
%
        phi=2*(damp(j))^2-1;
        DD1=(omegan/omegad)*phi;
        DD2=2*DD1;
%    
        df1=2*damp(j)*(ecosd-1) +DD1*esind +omeganT;
        df2=-2*omeganT*ecosd +2*damp(j)*(1-eee2) -DD2*esind;
        df3=(2*damp(j)+omeganT)*eee2 +(DD1*esind-2*damp(j)*ecosd);
%
        MD=(omegan^3*dt);
        df1=df1/MD;
        df2=df2/MD;
        df3=df3/MD;
%
        af1=esind/(omegad*dt);
        af2=-2*af1;
        af3=af1;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
%
        yj=yy(j,:);
%
%   Relative Acceleration Response
%
        forward=[ af1,  af2,  af3 ];    
        back   =[     1, -a1, -a2 ];    
%    
        a(:,j)=filter(forward,back,yj);

%
%   Relative Displacement Response   
%
        rd_forward=[ df1,  df2,  df3 ];    
        rd_back   =[     1, -a1, -a2 ];     
%    
        x(:,j)=filter(rd_forward,rd_back,yj);
%
    end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    for i=1:nt 
        rd(i,:)=Q*x(i,:)';
        ra(i,:)=Q*a(i,:)';  
%
        acc(i,:)=ra(i,:);
    end
%
    for i=1:2
      acc(:,i)=acc(:,i)+base;
    end
%
    clear a;
    a=acc;
%
    if(unit==1)
       rd=rd*386;
    else
       rd=rd*9.81*1000;     
    end
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
        h1=figure(fig_num);
        fig_num=fig_num+1;
        setappdata(0,'fig_num',fig_num);       
        plot(t,rd(:,1),t,rd(:,2));
        grid on; 
        xlabel('Time(sec)');

        out1=sprintf('Relative Displacement Response to Base Input');
       
        title(out1);
        if(unit==1)
            ylabel('Rel Disp(in)');
        else
            ylabel('Rel Disp(mm)');    
        end  
        legend('Mass 1','Mass 2');     
        
        if(psave==1)
    
            disp(' ');
            disp(' Plot files:');
            disp(' ');
    
            pname='rel_disp_m1_m2_plot';
        
            out1=sprintf('   %s.png',pname);
            disp(out1);
    
            set(gca,'Fontsize',12);
            print(h1,pname,'-dpng','-r300');
    
        end            
        
%
%
        h2=figure(fig_num);
        fig_num=fig_num+1;
        setappdata(0,'fig_num',fig_num);
        rd21=rd(:,2)-rd(:,1);
        plot(t,rd21);
        grid on; 
        xlabel('Time(sec)');

        out1=sprintf('Relative Displacement Mass 2 - Mass 1');
       
        title(out1);
        if(unit==1)
            ylabel('Rel Disp(in)');
        else
            ylabel('Rel Disp(mm)');    
        end
        
        if(psave==1)

            pname='rel_disp_m2_minus_m1_plot';
        
            out1=sprintf('   %s.png',pname);
            disp(out1);
    
            set(gca,'Fontsize',12);
            print(h1,pname,'-dpng','-r300');
    
        end          
        
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
        h3=figure(fig_num);
        fig_num=fig_num+1;
        setappdata(0,'fig_num',fig_num);      
        plot(t,a(:,1),t,a(:,2));
        grid on;
        xlabel('Time(sec)');

        out1=sprintf('Acceleration Response to Base Input');   
        title(out1);

        ylabel('Accel(G)');
        legend('Mass 1','Mass 2');
        
        
        if(psave==1)

            pname='acceleration_m1_m2_plot';
        
            out1=sprintf('   %s.png',pname);
            disp(out1);
    
            set(gca,'Fontsize',12);
            print(h3,pname,'-dpng','-r300');
    
        end          
        
%
%
        t=fix_size(t);
        
        aone=a(:,1);
        aone=fix_size(aone);
        atwo=a(:,2);
        atwo=fix_size(atwo);        

        h4=figure(fig_num);
        fig_num=fig_num+1;
        setappdata(0,'fig_num',fig_num);      
        plot(t,aone);
        data2=[t aone];
        grid on;
        xlabel('Time(sec)');

        out1=sprintf('Acceleration Response Mass 1');   
        title(out1);

        ylabel('Accel(G)');
%
        if(psave==1)

            pname='acceleration_m1_plot';
        
            out1=sprintf('   %s.png',pname);
            disp(out1);
    
            set(gca,'Fontsize',12);
            print(h4,pname,'-dpng','-r300');
    
        end  


%
        h5=figure(fig_num);
        fig_num=fig_num+1;
        setappdata(0,'fig_num',fig_num);      
        plot(t,atwo);
        data3=[t atwo];
        grid on;
        xlabel('Time(sec)');

        out1=sprintf('Acceleration Response Mass 2');   
        title(out1);

        ylabel('Accel(G)');
  
        if(psave==1)

            pname='acceleration_m2_plot';
        
            out1=sprintf('   %s.png',pname);
            disp(out1);
    
            set(gca,'Fontsize',12);
            print(h5,pname,'-dpng','-r300');
    
        end          
        
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
        a1=a(:,1);
        a2=a(:,2);

        rd1=rd(:,1);
        rd2=rd(:,2);

%
        if(max(abs(a1))<1.0e-09 )
            a1=0.;
        end
        if(max(abs(a2))<1.0e-09 )
            a2=0.;
        end

%
        if(max(abs(rd1))<1.0e-09 )
            rd1=0.;
        end
        if(max(abs(rd2))<1.0e-09 )
            rd2=0.;
        end      
%
        
        disp(out1);
        
        disp(' ');
        disp('  Acceleration Response (G)');
        disp('              max       min  ');
        out1=sprintf('  Mass 1:  %7.4g   %7.4g ',max(a1),min(a1));
        out2=sprintf('  Mass 2:  %7.4g   %7.4g ',max(a2),min(a2));
        disp(out1);
        disp(out2);
%
        disp(' ');
        if(unit==1)
            disp('  Relative Displacement Response (inch) ');
        else
            disp('  Relative Displacement Response (mm) ');            
        end
        disp('              max      min  ');
        out1=sprintf('  Mass 1:  %7.4g   %7.4g ',max(rd1),min(rd1));
        out2=sprintf('  Mass 2:  %7.4g   %7.4g \n',max(rd2),min(rd2));
        disp(out1);
        disp(out2);

        out3=sprintf(' Mass 2-Mass 1:  %7.4g   %7.4g ',max(rd21),min(rd21));
        disp(out3);

        
        xlabel3='Time (sec)';
        ylabel1='Accel (G)';
        ylabel2='Accel (G)';
        ylabel3='Accel (G)';
        
        t_string1='Base Input';
        t_string2='Mass 1 Response';
        t_string3='Mass 2 Response';
       
        
        [fig_num]=...
           subplots_three_linlin_three_titles(fig_num,xlabel3,ylabel1,ylabel2,ylabel3,...
                                          data1,data2,data3,t_string1,t_string2,t_string3);
        
end

t=fix_size(t);
a1=fix_size(a1);
a2=fix_size(a2);
rd1=fix_size(rd1);
rd2=fix_size(rd2);
    
A1=[t a1];
A2=[t a2];
Z1=[t rd1];
Z2=[t rd2];
Z21=[t rd2-rd1];

setappdata(0,'accel_1',A1);
setappdata(0,'accel_2',A2);

setappdata(0,'rd_1',Z1);
setappdata(0,'rd_2',Z2);
setappdata(0,'rd_21',Z21);

msgbox('Calculation complete.  Output written to Matlab Command Window.');

set(handles.uipanel_save,'Visible','on');




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


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(two_dof_arbitrary);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_output,'Value');

if(n==1)
    data=getappdata(0,'accel_1');
end
if(n==2)
    data=getappdata(0,'accel_2');
end
if(n==3)
    data=getappdata(0,'rd_1');
end
if(n==4)
    data=getappdata(0,'rd_2');
end
if(n==5)
    data=getappdata(0,'rd_21');
end

output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 




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


% --- Executes on selection change in listbox_output.
function listbox_output_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output


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


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');

n=get(handles.listbox_method,'Value');

if(n==1)
    
   set(handles.edit_input_array,'enable','on') 
else
   
   set(handles.edit_input_array,'enable','off')
   
   set(handles.text_input_array_name,'Visible','off');
   set(handles.edit_input_array,'Visible','off');   
   
   [filename, pathname] = uigetfile('*.*');
   filename = fullfile(pathname, filename);
   fid = fopen(filename,'r');
   THM = fscanf(fid,'%g %g',[2 inf]);
   THM=THM';
    
   setappdata(0,'THM',THM);
   
end



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


% --- Executes on selection change in listbox_psave.
function listbox_psave_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_psave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_psave contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_psave


% --- Executes during object creation, after setting all properties.
function listbox_psave_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_psave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function varargout = beam_bending_sine(varargin)
% BEAM_BENDING_SINE MATLAB code for beam_bending_sine.fig
%      BEAM_BENDING_SINE, by itself, creates a new BEAM_BENDING_SINE or raises the existing
%      singleton*.
%
%      H = BEAM_BENDING_SINE returns the handle to a new BEAM_BENDING_SINE or the handle to
%      the existing singleton*.
%
%      BEAM_BENDING_SINE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BEAM_BENDING_SINE.M with the given input arguments.
%
%      BEAM_BENDING_SINE('Property','Value',...) creates a new BEAM_BENDING_SINE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before beam_bending_sine_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to beam_bending_sine_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help beam_bending_sine

% Last Modified by GUIDE v2.5 23-Dec-2020 12:50:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @beam_bending_sine_OpeningFcn, ...
                   'gui_OutputFcn',  @beam_bending_sine_OutputFcn, ...
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


% --- Executes just before beam_bending_sine is made visible.
function beam_bending_sine_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to beam_bending_sine (see VARARGIN)

% Choose default command line output for beam_bending_sine
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

% UIWAIT makes beam_bending_sine wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = beam_bending_sine_OutputFcn(hObject, eventdata, handles) 
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


num_fn=get(handles.listbox_num_modes,'Value');

      damp=getappdata(0,'damp_ratio');
        fn=getappdata(0,'fn');
        nmn=min([num_fn length(fn)]);
        fn=fn(1:nmn);
        
      iu=getappdata(0,'unit');
      part=getappdata(0,'part');
 
      L=getappdata(0,'length');
      
      E=getappdata(0,'E');  
      I=getappdata(0,'I');       
    
      EI=E*I;
      
      beta=getappdata(0,'beta');
      
      LBC=getappdata(0,'LBC');
      RBC=getappdata(0,'RBC');
      
      f_base=str2num(get(handles.freq_edit,'String'));
      amp=str2num(get(handles.amplitude_edit,'String'));
    
      x=str2num(get(handles.x_edit,'String')); 
      
      sq_mass=getappdata(0,'sq_mass');
      beta=getappdata(0,'beta');
      C=getappdata(0,'C');
      
      n=length(fn);
      
     [ModeShape,ModeShape_dd,ModeShape_ddd]=beam_bending_modes_shapes_alt(LBC,RBC);      

%
arg=beta*x;
%
sH=0;
sHv=0;
sH_relA=0;
om=2*pi*f_base;
%

xx=sort(unique([x L*[0 0.5 1]]));
    
nxx=length(xx);
       
bm=zeros(nxx,1);
shear=zeros(nxx,1);
%
for i=1:n
%
   pY=part(i)*ModeShape(arg(i),C(i),sq_mass);
   omn=2*pi*fn(i);
   num=-pY;
   den=(omn^2-om^2)+(1i)*2*damp(i)*om*omn;
   nrd=num/den;
   sH=sH+nrd;
%
   sHv=sHv+(1i)*om*(num/den);
%
   num=om^2*pY;
   sH_relA=sH_relA+(num/den); 
%
   for k=1:nxx                      
               alpha=beta(i)*xx(k);                          
               pY=part(i)*ModeShape_dd(alpha,C(i),beta(i),sq_mass);
               num=-pY;
               bm(k)= bm(k) +(num/den);     
               
               pY=part(i)*ModeShape_ddd(alpha,C(i),beta(i),sq_mass);
               num=-pY;
               shear(k)= shear(k) +(num/den);                
   end
%
end
bm=abs(bm);
shear=abs(shear);
%
bm=EI*bm;
shear=EI*shear;
%
sH=abs(sH);
sHv=abs(sHv);
sHA=abs(sH_relA+1);      

%
disp(' '); 
out1 =sprintf('  Base excitation = %8.4g G at %8.4g Hz',amp,f_base);
disp(out1); 
%
disp(' ');
if(iu==1)
    out2 =sprintf('     Response at x=%8.4g inch \n',x);
else
    out2 =sprintf('     Response at x=%8.4g m \n',x);    
end
%
out3 =sprintf(' Transfer Magnitude = %8.4g G/G \n',sHA);
out4 =sprintf('              Accel = %8.4g G ',sHA*amp);
%

if(iu==1)
    conv=386;
else
    conv=9.81;    
end


sH=sH*conv;
sHv=sHv*conv;

bm=bm*conv;
shear=shear*conv;


if(iu==1)
    out5 =sprintf('            Rel Vel = %8.4g in/sec ',sHv*amp);
else
    out5 =sprintf('            Rel Vel = %8.4g m/sec ',sHv*amp);    
end

if(iu==1)
    out6 =sprintf('           Rel Disp = %8.4g in \n',sH*amp);
else
    out6 =sprintf('           Rel Disp = %8.4g m \n',sH*amp);    
end
%         
disp(out2);      
disp(out3);
disp(out4);
disp(out5);
disp(out6);

disp(' '); 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%

 cna=getappdata(0,'cna');
%
 
    c=cna;
    bm=bm*amp;
    shear=shear*amp;
%
    if(iu==1)
        
        out2=sprintf('\n Distance from neutral axis = %8.4g in ',cna);
        
        out3=sprintf('\n Bending Moment = %8.4g in-lbf at %6.3g in',bm(1),xx(1)); 
          out4=sprintf('                = %8.4g in-lbf at %6.3g in',bm(2),xx(2));   
          out5=sprintf('                = %8.4g in-lbf at %6.3g in',bm(3),xx(3));           
   
          if(length(xx)==4)
            out6=sprintf('                = %8.4g in-lbf at %6.3g in',bm(4),xx(4));               
          end        
        
        
        out13=sprintf('\n Shear Force = %8.4g lbf at %6.3g in',shear(1),xx(1)); 
          out14=sprintf('                = %8.4g lbf at %6.3g in',shear(2),xx(2));   
          out15=sprintf('                = %8.4g lbf at %6.3g in',shear(3),xx(3));           
   
          if(length(xx)==4)
            out16=sprintf('                = %8.4g lbf at %6.3g in',shear(4),xx(4));               
          end               
          
          
        out23=sprintf('\n Bending Stress = %8.4g psi at %6.3g in',(c/I)*bm(1),xx(1)); 
          out24=sprintf('                = %8.4g psi at %6.3g in',(c/I)*bm(2),xx(2));   
          out25=sprintf('                = %8.4g psi at %6.3g in',(c/I)*bm(3),xx(3));           
   
          if(length(xx)==4)
            out26=sprintf('                = %8.4g psi at %6.3g in',(c/I)*bm(4),xx(4));               
          end
    
    else
        
        out2=sprintf('\n Distance from neutral axis = %8.4g mm ',cna*1000);
        
        out3=sprintf('\n Bending Moment = %8.4g N-m at %6.3g m',bm(1),xx(1)); 
          out4=sprintf('                = %8.4g N-m at %6.3g m',bm(2),xx(2));   
          out5=sprintf('                = %8.4g N-m at %6.3g m',bm(3),xx(3));           
   
          if(length(xx)==4)
            out6=sprintf('                = %8.4g N-m at %6.3g m',bm(4),xx(4));               
          end     
          
          
         out13=sprintf('\n Shear Force = %8.4g N at %6.3g m',shear(1),xx(1)); 
          out14=sprintf('                = %8.4g N at %6.3g m',shear(2),xx(2));   
          out15=sprintf('                = %8.4g N at %6.3g m',shear(3),xx(3));           
   
          if(length(xx)==4)
            out16=sprintf('                = %8.4g N at %6.3g m',shear(4),xx(4));               
          end           
           
        
        out23=sprintf('\n Bending Stress = %8.4g Pa at %6.3g m',(c/I)*max(abs(bm(:,1))),xx(1)); 
          out24=sprintf('                = %8.4g Pa at %6.3g m',(c/I)*max(abs(bm(:,2))),xx(2));   
          out25=sprintf('                = %8.4g Pa at %6.3g m',(c/I)*max(abs(bm(:,3))),xx(3));
    
           if(length(xx)==4)
            out26=sprintf('                = %8.4g Pa at %6.3g m',max(abs(bm(:,4))),xx(4));               
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
    

    disp(out13);
    disp(out14);
    disp(out15);
    if(length(xx)==4)
        disp(out16);
    end    
    disp(' ');    

    disp(out23);
    disp(out24);
    disp(out25);
    if(length(xx)==4)
        disp(out26);
    end    
    disp(' ');       
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
msgbox('Calculation complete.  Output written to Matlab Command Window.');
    
    

% --- Executes on button press in Return_pushbutton.
function Return_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Return_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(beam_bending_sine);


function freq_edit_Callback(hObject, eventdata, handles)
% hObject    handle to freq_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of freq_edit as text
%        str2double(get(hObject,'String')) returns contents of freq_edit as a double


% --- Executes during object creation, after setting all properties.
function freq_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to freq_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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

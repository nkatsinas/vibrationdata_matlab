function varargout = two_dof_sine_trot(varargin)
% TWO_DOF_SINE_TROT MATLAB code for two_dof_sine_trot.fig
%      TWO_DOF_SINE_TROT, by itself, creates a new TWO_DOF_SINE_TROT or raises the existing
%      singleton*.
%
%      H = TWO_DOF_SINE_TROT returns the handle to a new TWO_DOF_SINE_TROT or the handle to
%      the existing singleton*.
%
%      TWO_DOF_SINE_TROT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TWO_DOF_SINE_TROT.M with the given input arguments.
%
%      TWO_DOF_SINE_TROT('Property','Value',...) creates a new TWO_DOF_SINE_TROT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before two_dof_sine_trot_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to two_dof_sine_trot_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help two_dof_sine_trot

% Last Modified by GUIDE v2.5 09-Feb-2015 10:56:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @two_dof_sine_trot_OpeningFcn, ...
                   'gui_OutputFcn',  @two_dof_sine_trot_OutputFcn, ...
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


% --- Executes just before two_dof_sine_trot is made visible.
function two_dof_sine_trot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to two_dof_sine_trot (see VARARGIN)

% Choose default command line output for two_dof_sine_trot
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes two_dof_sine_trot wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = two_dof_sine_trot_OutputFcn(hObject, eventdata, handles) 
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

delete(two_dof_sine_trot);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig_num=getappdata(0,'fig_num');
      damp=getappdata(0,'damping');
ModeShapes=getappdata(0,'ModeShapes');
        fn=getappdata(0,'fn');
        
        L1=getappdata(0,'L1');
        L2=getappdata(0,'L2');
        
      unit=getappdata(0,'unit');
         m2=getappdata(0,'m2');
         k2=getappdata(0,'k2');
         
         mass=getappdata(0,'mass');
         stiff=getappdata(0,'stiff');         
         
%
amp=str2num(get(handles.A_edit,'String'));  % amplitude
freq=str2num(get(handles.F_edit,'String'));  % frequency

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp(' Base Input ');

out1=sprintf('\n %8.4g G  %8.4g Hz \n',amp,freq);
disp(out1);
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


num=3; % total dof
nem=1; % number of dof with enforce acceleration
ea(1)=1; % dof with enforced

dtype=1; % display partitioned matrices

fmin=freq;
fmax=freq;

[acc_trans_xc,rd_trans_xc]=...
    vibrationdata_enforce_acceleration_frf_complex(mass,stiff,damp,num,nem,ea,fmin,fmax,dtype,freq);


acc_trans = [ acc_trans_xc(:,1) abs(acc_trans_xc(:,2)) abs(acc_trans_xc(:,3)) ];
rd_trans  = [  rd_trans_xc(:,1)  abs(rd_trans_xc(:,2))  abs(rd_trans_xc(:,3)) ];



np=length( acc_trans_xc(:,1)  );

rd_trans_s1_xc=zeros(np,2);
rd_trans_s2_xc=zeros(np,2);

for i=1:np
    omega=2*pi*freq(i);
    omega2=omega^2;
    theta=acc_trans_xc(i,3)/( -omega2 );
    rd_trans_s1_xc(i,2)= rd_trans_xc(i,2)-L1*tan(theta);
    rd_trans_s2_xc(i,2)= rd_trans_xc(i,2)+L2*tan(theta);
end


rd_trans_s1=[ freq abs(rd_trans_s1_xc(:,2)) ];
rd_trans_s2=[ freq abs(rd_trans_s2_xc(:,2)) ];



if(unit==1)   
    scale=386;    
else
    scale=9.81;    
end    



    rd_trans_s1=scale*rd_trans_s1(:,2);
       rd_trans=scale*rd_trans(:,2);
    rd_trans_s2=scale*rd_trans_s2(:,2);
    
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


a1=amp*acc_trans(1,2);
a2=amp*acc_trans(1,3);

a2=scale*a2;


rs1=amp*rd_trans_s1;
rcg=amp*rd_trans;
rs2=amp*rd_trans_s2;

%
aa1=abs(a1);
aa2=abs(a2);

rs1=abs(rs1);
rcg=abs(rcg);
rs2=abs(rs2);


%
if(unit==1)
   dd='in'; 
else
   dd='mm'; 
   rs1=rs1*1000;
   rcg=rcg*1000;   
   rs2=rs2*1000;   
end


%
disp(' ');
disp(' Acceleration Response at C.G. ');
out1=sprintf(' translation:  %8.4g G',aa1);
out2=sprintf('    rotation:  %8.4g rad/sec^2',aa2);
disp(out1);
disp(out2);
%


%

%        
disp(' ');
disp(' Relative Displacement Response Translation ');
out1=sprintf('  Spring 1:  %8.4g %s',rs1,dd);
out2=sprintf('     C.G. :  %8.4g %s',rcg,dd);
out3=sprintf('  Spring 2:  %8.4g %s',rs2,dd);
disp(out1);
disp(out2);
disp(out3);

%
msgbox('Calculation complete.  Output written to Matlab Command Window.');



function A_edit_Callback(hObject, eventdata, handles)
% hObject    handle to A_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of A_edit as text
%        str2double(get(hObject,'String')) returns contents of A_edit as a double


% --- Executes during object creation, after setting all properties.
function A_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to A_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function F_edit_Callback(hObject, eventdata, handles)
% hObject    handle to F_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of F_edit as text
%        str2double(get(hObject,'String')) returns contents of F_edit as a double


% --- Executes during object creation, after setting all properties.
function F_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to F_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

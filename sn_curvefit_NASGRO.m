function varargout = sn_curvefit_NASGRO(varargin)
% SN_CURVEFIT_NASGRO MATLAB code for sn_curvefit_NASGRO.fig
%      SN_CURVEFIT_NASGRO, by itself, creates a new SN_CURVEFIT_NASGRO or raises the existing
%      singleton*.
%
%      H = SN_CURVEFIT_NASGRO returns the handle to a new SN_CURVEFIT_NASGRO or the handle to
%      the existing singleton*.
%
%      SN_CURVEFIT_NASGRO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SN_CURVEFIT_NASGRO.M with the given input arguments.
%
%      SN_CURVEFIT_NASGRO('Property','Value',...) creates a new SN_CURVEFIT_NASGRO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sn_curvefit_NASGRO_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sn_curvefit_NASGRO_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sn_curvefit_NASGRO

% Last Modified by GUIDE v2.5 30-Jul-2022 15:59:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sn_curvefit_NASGRO_OpeningFcn, ...
                   'gui_OutputFcn',  @sn_curvefit_NASGRO_OutputFcn, ...
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


% --- Executes just before sn_curvefit_NASGRO is made visible.
function sn_curvefit_NASGRO_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sn_curvefit_NASGRO (see VARARGIN)

% Choose default command line output for sn_curvefit_NASGRO
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sn_curvefit_NASGRO wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sn_curvefit_NASGRO_OutputFcn(hObject, eventdata, handles) 
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
delete(sn_curvefit_NASGRO);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('  ');
disp(' * * * * * ');
disp('  ');

try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end    


try
      FS=get(handles.edit_input_array,'String');
      SN1=evalin('base',FS);
%      disp('ref 2')
catch
      warndlg('Unable to read input file','Warning');
      return;
end   

iu=get(handles.listbox_stress_unit,'Value');

if(iu==1)
    SN1(:,2)=SN1(:,2)/1000;
end

R=str2double(get(handles.edit_R,'String'));

num=length(SN1(:,1));

ntrials=600000;
%

rng(1);

error_max=1.0e+50;

disp('  ');
disp(' i  error   P     A     B    C  ');

for i=1:ntrials
    
    error=0;

    P=1*rand;
    B=10*rand;
    A=50*rand;
    C=100*rand;    
    
    if(i> round(0.1*ntrials))
        if(rand>0.5)
            P=Pr*(0.98+0.04*rand);
        end
        if(rand>0.5)
            B=Br*(0.98+0.04*rand);            
        end
        if(rand>0.5)
            A=Ar*(0.98+0.04*rand);             
        end
        if(rand>0.5)
            C=Cr*(0.98+0.04*rand);               
        end        
        
        if(rand>0.9)
            P=Pr*(0.98+0.04*rand);  
            B=Br*(0.98+0.04*rand);  
            A=Ar*(0.98+0.04*rand);  
            C=Cr*(0.98+0.04*rand);            
        end
    end    
       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

    [error]=sn_curve_fit_error(num,SN1,error,R,P,A,B,C);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
    if(error<error_max)
        
        Pr=P;
        Br=B;
        Ar=A;
        Cr=C;     
        out1=sprintf(' %d %8.4g %8.4g %8.4g %8.4g %8.4g',i,error,Pr,Ar,Br,Cr);
        disp(out1);
        
        error_max=error;
    end
    
end    
    
disp(' ');
disp(' Best case ');

out1=sprintf(' P=%8.4g ',Pr);
out2=sprintf(' A=%8.4g ',Ar);
out3=sprintf(' B=%8.4g ',Br);
out4=sprintf(' C=%8.4g ',Cr);

disp(out1);
disp(out2);
disp(out3);
disp(out4);


nc=1;



figure(1);

[NN1,SS1]=sn_curve_fit_plot(num(1),SN1,R(1),Pr,Ar,Br,Cr);
plot(SN1(:,1),SN1(:,2),'d',NN1,SS1);

grid on;
set(gca,'MinorGridLineStyle','none','GridLineStyle','-','XScale','log','YScale','lin'); 
xlabel('Cycles');
ylabel('Stress (ksi)');

out1=sprintf('S-N Curve-fit  R=%g',R);
title(out1);






msgbox('Calculation complete.  Coefficients written to Command Window.');



% --- Executes on button press in pushbutton_view.
function pushbutton_view_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

open sn_curvefit_equation.pdf



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



function edit_R_Callback(hObject, eventdata, handles)
% hObject    handle to edit_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_R as text
%        str2double(get(hObject,'String')) returns contents of edit_R as a double


% --- Executes during object creation, after setting all properties.
function edit_R_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_stress_unit.
function listbox_stress_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_stress_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_stress_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_stress_unit


% --- Executes during object creation, after setting all properties.
function listbox_stress_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_stress_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

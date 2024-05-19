function varargout = Holzer_torsional(varargin)
% HOLZER_TORSIONAL MATLAB code for Holzer_torsional.fig
%      HOLZER_TORSIONAL, by itself, creates a new HOLZER_TORSIONAL or raises the existing
%      singleton*.
%
%      H = HOLZER_TORSIONAL returns the handle to a new HOLZER_TORSIONAL or the handle to
%      the existing singleton*.
%
%      HOLZER_TORSIONAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HOLZER_TORSIONAL.M with the given input arguments.
%
%      HOLZER_TORSIONAL('Property','Value',...) creates a new HOLZER_TORSIONAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Holzer_torsional_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Holzer_torsional_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Holzer_torsional

% Last Modified by GUIDE v2.5 09-Oct-2014 18:21:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Holzer_torsional_OpeningFcn, ...
                   'gui_OutputFcn',  @Holzer_torsional_OutputFcn, ...
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


% --- Executes just before Holzer_torsional is made visible.
function Holzer_torsional_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Holzer_torsional (see VARARGIN)

% Choose default command line output for Holzer_torsional
handles.output = hObject;

set(handles.listbox_BC,'Value',2);
input_change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Holzer_torsional wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Holzer_torsional_OutputFcn(hObject, eventdata, handles) 
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

FINE=400;

  i_inertia_unit=get(handles.listbox_inertia,'Value');
i_stiffness_unit=get(handles.listbox_stiffness,'Value');
i_disks=get(handles.listbox_disks,'Value');

ibc=get(handles.listbox_BC,'Value');

if(i_disks==1 && ibc==1)
    msgbox('At least two disks are required for this boundary condition case.');
    return;
end

nd=i_disks;

if(nd>=1)
    j(1)=str2num(get(handles.edit_inertia_1,'String'));
end
if(nd>=2)
    j(2)=str2num(get(handles.edit_inertia_2,'String'));
end
if(nd>=3)
    j(3)=str2num(get(handles.edit_inertia_3,'String'));
end
if(nd>=4)
    j(4)=str2num(get(handles.edit_inertia_4,'String'));   
end
if(nd>=5)
    j(5)=str2num(get(handles.edit_inertia_5,'String'));
end
if(nd>=6)
    j(6)=str2num(get(handles.edit_inertia_6,'String'));
end 


NT=32000;

% 23.734 lbm ft^2 = kg m^2

lbmft2_per_kgm2 = 23.734;
lbmin2_per_kgm2 = 3417.8;

inlbfrad_per_Nmrad = 8.8504;
ftlbfrad_per_Nmrad = 0.73753;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(i_inertia_unit==1)  
    inertia_scale=1./lbmft2_per_kgm2;
end

if(i_inertia_unit==2)
    inertia_scale=1./lbmin2_per_kgm2;
end

if(i_inertia_unit==3)
    inertia_scale=1.;
end

j=j*inertia_scale;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(i_stiffness_unit==1)
    stiffness_scale=1./ftlbfrad_per_Nmrad;
end

if(i_stiffness_unit==2)
	stiffness_scale=1./inlbfrad_per_Nmrad;
end

if(i_stiffness_unit==3)
	stiffness_scale=1.;
end


if(ibc == 1) % free-free
    i_shafts=i_disks-1;
end    
if(ibc == 2) % fixed-free
    i_shafts=i_disks;
end
if(ibc == 3) % fixed-fixed
    i_shafts=i_disks+1;
end

ns=i_shafts;

if(ns>=1)
    k(1)=str2num(get(handles.edit_stiffness_1,'String'));
end
if(ns>=2)
    k(2)=str2num(get(handles.edit_stiffness_2,'String'));
end
if(ns>=3)
    k(3)=str2num(get(handles.edit_stiffness_3,'String'));
end
if(ns>=4)
    k(4)=str2num(get(handles.edit_stiffness_4,'String'));   
end
if(ns>=5)
    k(5)=str2num(get(handles.edit_stiffness_5,'String'));
end
if(ns>=6)
    k(6)=str2num(get(handles.edit_stiffness_6,'String'));
end 
if(ns>=7)
    k(7)=str2num(get(handles.edit_stiffness_7,'String'));
end 


for i=1:i_shafts  
	k(i)=k(i)*stiffness_scale;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f1=0.001;

oct=(2^(1/48));

omega_before=f1;

Tb=0;

kv=1;


if(ibc == 1) %free-free
%
    disp(' BC:  Free-Free ');

    x=zeros(i_disks,1);
    
	for i=1:i_disks
		x(i)=1.;
    end

    omega = 0.;

	[top]=Holzer_printvector(kv,ibc,i_disks,omega,x);
    
	kv=2;
%
    for n=1:NT

	    omega=omega_before*oct;
		temp=omega;

		[T,x]=Holzer_freefree_engine(i_disks,j,k,omega);

        [Tb,top,kv]=...
           Holzer_torque_core(kv,ibc,i_disks,omega,omega_before,T,Tb,FINE,n,j,k,x);
                
		omega_before=temp;

		if(omega > 1.0e+05)
            break;
        end    
		if( kv == i_disks+1 && omega > 2*top )
			break;
        end
    end
%
end

if(ibc == 2) % fixed free
    
    disp(' BC:  Fixed-Free ');    
    
	for n=1:NT
	
	    omega=omega_before*oct;

		temp=omega;
		
        [T,x]=Holzer_fixedfree_engine(i_disks,j,k,omega);

           [Tb,top,kv]=...
           Holzer_torque_core(kv,ibc,i_disks,omega,omega_before,T,Tb,FINE,n,j,k,x);

		omega_before=temp;

		if(omega > 1.0e+05)
			break;
		end

		if( kv == i_disks+1 && omega > 2*top )
			break;
		end
    end
    
end

if(ibc == 3)
    
    disp(' BC:  Fixed-Fixed ');   
    
    kv=1;

	for n=1:NT

	    omega=omega_before*oct;

		temp=omega;

        [T,x]=Holzer_fixedfixed_engine(i_disks,j,k,omega);

           [Tb,top,kv]=...
           Holzer_torque_core(kv,ibc,i_disks,omega,omega_before,T,Tb,FINE,n,j,k,x);

		omega_before=temp;

		if(omega > 1.0e+05)
			break;
		end

		if( kv == i_disks+1 && omega > 2*top )
		
			break;

		end

	end    

end


msgbox('Results written to Command Window');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(Holzer_torsional);


% --- Executes on selection change in listbox_inertia.
function listbox_inertia_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_inertia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_inertia contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_inertia


% --- Executes during object creation, after setting all properties.
function listbox_inertia_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_inertia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_stiffness.
function listbox_stiffness_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_stiffness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_stiffness contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_stiffness


% --- Executes during object creation, after setting all properties.
function listbox_stiffness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_stiffness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_BC.
function listbox_BC_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_BC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_BC contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_BC

i_disks=get(handles.listbox_disks,'Value');

ibc=get(handles.listbox_BC,'Value');

if(ibc==2)
    set(handles.text_disk_free_end,'Visible','on');
else
    set(handles.text_disk_free_end,'Visible','off');    
end

if(i_disks==1 && ibc==1)
    msgbox('At least two disks are required for this boundary condition case.');
    return;
end

input_change(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_BC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_BC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_disks.
function listbox_disks_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_disks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_disks contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_disks

input_change(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_disks_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_disks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function input_change(hObject, eventdata, handles)
%
nBC=get(handles.listbox_BC,'Value');
nd=get(handles.listbox_disks,'Value');

    set(handles.text_I1,'Visible','off');
    set(handles.edit_inertia_1,'Visible','off');
 
    set(handles.text_I2,'Visible','off');
    set(handles.edit_inertia_2,'Visible','off');
 
    set(handles.text_I3,'Visible','off');
    set(handles.edit_inertia_3,'Visible','off');
 
    set(handles.text_I4,'Visible','off');
    set(handles.edit_inertia_4,'Visible','off');   
 
    set(handles.text_I5,'Visible','off');
    set(handles.edit_inertia_5,'Visible','off');
 
    set(handles.text_I6,'Visible','off');
    set(handles.edit_inertia_6,'Visible','off');



if(nBC==1 && nd==1)
    msgbox('At least two disks are required for this boundary condition case.');
    return;
end

if(nd>=1)
    set(handles.text_I1,'Visible','on');
    set(handles.edit_inertia_1,'Visible','on');
end
if(nd>=2)
    set(handles.text_I2,'Visible','on');
    set(handles.edit_inertia_2,'Visible','on');
end
if(nd>=3)
    set(handles.text_I3,'Visible','on');
    set(handles.edit_inertia_3,'Visible','on');
end
if(nd>=4)
    set(handles.text_I4,'Visible','on');
    set(handles.edit_inertia_4,'Visible','on');   
end
if(nd>=5)
    set(handles.text_I5,'Visible','on');
    set(handles.edit_inertia_5,'Visible','on');
end
if(nd>=6)
    set(handles.text_I6,'Visible','on');
    set(handles.edit_inertia_6,'Visible','on');
end 


if(nBC==1) % free-free
   ns=nd-1;
end
if(nBC==2) % fixed-free
   ns=nd;
end
if(nBC==3) % fixed-fixed
   ns=nd+1;
end


    set(handles.text_S1,'Visible','off');
    set(handles.edit_stiffness_1,'Visible','off');

    set(handles.text_S2,'Visible','off');
    set(handles.edit_stiffness_2,'Visible','off');

    set(handles.text_S3,'Visible','off');
    set(handles.edit_stiffness_3,'Visible','off');

    set(handles.text_S4,'Visible','off');
    set(handles.edit_stiffness_4,'Visible','off');   

    set(handles.text_S5,'Visible','off');
    set(handles.edit_stiffness_5,'Visible','off');

    set(handles.text_S6,'Visible','off');
    set(handles.edit_stiffness_6,'Visible','off');

    set(handles.text_S7,'Visible','off');
    set(handles.edit_stiffness_7,'Visible','off');

if(ns>=1)
    set(handles.text_S1,'Visible','on');
    set(handles.edit_stiffness_1,'Visible','on');
end
if(ns>=2)
    set(handles.text_S2,'Visible','on');
    set(handles.edit_stiffness_2,'Visible','on');
end
if(ns>=3)
    set(handles.text_S3,'Visible','on');
    set(handles.edit_stiffness_3,'Visible','on');
end
if(ns>=4)
    set(handles.text_S4,'Visible','on');
    set(handles.edit_stiffness_4,'Visible','on');   
end
if(ns>=5)
    set(handles.text_S5,'Visible','on');
    set(handles.edit_stiffness_5,'Visible','on');
end
if(ns>=6)
    set(handles.text_S6,'Visible','on');
    set(handles.edit_stiffness_6,'Visible','on');
end 
if(ns>=7)
    set(handles.text_S7,'Visible','on');
    set(handles.edit_stiffness_7,'Visible','on');
end 


function edit_inertia_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_inertia_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_inertia_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_inertia_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_inertia_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_inertia_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_inertia_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_inertia_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_inertia_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_inertia_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_inertia_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_inertia_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_inertia_3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_inertia_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_inertia_3 as text
%        str2double(get(hObject,'String')) returns contents of edit_inertia_3 as a double


% --- Executes during object creation, after setting all properties.
function edit_inertia_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_inertia_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_inertia_4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_inertia_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_inertia_4 as text
%        str2double(get(hObject,'String')) returns contents of edit_inertia_4 as a double


% --- Executes during object creation, after setting all properties.
function edit_inertia_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_inertia_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_inertia_5_Callback(hObject, eventdata, handles)
% hObject    handle to edit_inertia_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_inertia_5 as text
%        str2double(get(hObject,'String')) returns contents of edit_inertia_5 as a double


% --- Executes during object creation, after setting all properties.
function edit_inertia_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_inertia_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_inertia_6_Callback(hObject, eventdata, handles)
% hObject    handle to edit_inertia_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_inertia_6 as text
%        str2double(get(hObject,'String')) returns contents of edit_inertia_6 as a double


% --- Executes during object creation, after setting all properties.
function edit_inertia_6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_inertia_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_stiffness_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stiffness_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stiffness_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_stiffness_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_stiffness_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stiffness_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_stiffness_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stiffness_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stiffness_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_stiffness_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_stiffness_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stiffness_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_stiffness_3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stiffness_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stiffness_3 as text
%        str2double(get(hObject,'String')) returns contents of edit_stiffness_3 as a double


% --- Executes during object creation, after setting all properties.
function edit_stiffness_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stiffness_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_stiffness_4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stiffness_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stiffness_4 as text
%        str2double(get(hObject,'String')) returns contents of edit_stiffness_4 as a double


% --- Executes during object creation, after setting all properties.
function edit_stiffness_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stiffness_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_stiffness_5_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stiffness_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stiffness_5 as text
%        str2double(get(hObject,'String')) returns contents of edit_stiffness_5 as a double


% --- Executes during object creation, after setting all properties.
function edit_stiffness_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stiffness_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_stiffness_6_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stiffness_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stiffness_6 as text
%        str2double(get(hObject,'String')) returns contents of edit_stiffness_6 as a double


% --- Executes during object creation, after setting all properties.
function edit_stiffness_6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stiffness_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_stiffness_7_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stiffness_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stiffness_7 as text
%        str2double(get(hObject,'String')) returns contents of edit_stiffness_7 as a double


% --- Executes during object creation, after setting all properties.
function edit_stiffness_7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stiffness_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

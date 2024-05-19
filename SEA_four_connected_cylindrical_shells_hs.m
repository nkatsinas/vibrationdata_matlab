function varargout = SEA_four_connected_cylindrical_shells_hs(varargin)
% SEA_FOUR_CONNECTED_CYLINDRICAL_SHELLS_HS MATLAB code for SEA_four_connected_cylindrical_shells_hs.fig
%      SEA_FOUR_CONNECTED_CYLINDRICAL_SHELLS_HS, by itself, creates a new SEA_FOUR_CONNECTED_CYLINDRICAL_SHELLS_HS or raises the existing
%      singleton*.
%
%      H = SEA_FOUR_CONNECTED_CYLINDRICAL_SHELLS_HS returns the handle to a new SEA_FOUR_CONNECTED_CYLINDRICAL_SHELLS_HS or the handle to
%      the existing singleton*.
%
%      SEA_FOUR_CONNECTED_CYLINDRICAL_SHELLS_HS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEA_FOUR_CONNECTED_CYLINDRICAL_SHELLS_HS.M with the given input arguments.
%
%      SEA_FOUR_CONNECTED_CYLINDRICAL_SHELLS_HS('Property','Value',...) creates a new SEA_FOUR_CONNECTED_CYLINDRICAL_SHELLS_HS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SEA_four_connected_cylindrical_shells_hs_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SEA_four_connected_cylindrical_shells_hs_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SEA_four_connected_cylindrical_shells_hs

% Last Modified by GUIDE v2.5 19-Sep-2018 13:25:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SEA_four_connected_cylindrical_shells_hs_OpeningFcn, ...
                   'gui_OutputFcn',  @SEA_four_connected_cylindrical_shells_hs_OutputFcn, ...
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


% --- Executes just before SEA_four_connected_cylindrical_shells_hs is made visible.
function SEA_four_connected_cylindrical_shells_hs_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SEA_four_connected_cylindrical_shells_hs (see VARARGIN)

% Choose default command line output for SEA_four_connected_cylindrical_shells_hs
handles.output = hObject;

clc;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cn={'Name'};

data{1,1}='subsystem 1';
data{2,1}='subsystem 2';
data{3,1}='subsystem 3';
data{4,1}='subsystem 4';

set(handles.uitable_names,'Data',data,'ColumnName',cn);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
cmap(1,:)=[0 0.1 0.4];        % dark blue
cmap(2,:)=[0.8 0 0];        % red
cmap(3,:)=[0 0 0];          % black
cmap(4,:)=[0.6 0.3 0];      % brown
cmap(5,:)=[0 0.5 0.5];      % teal
cmap(6,:)=[1 0.5 0];        % orange
cmap(7,:)=[0.5 0.5 0];      % olive
cmap(8,:)=[0.13 0.55 0.13]; % forest green  
cmap(9,:)=[0.5 0 0];        % maroon
cmap(10,:)=[0.5 0.5 0.5 ];  % grey
cmap(11,:)=[1. 0.4 0.4];    % pink-orange
cmap(12,:)=[0.5 0.5 1];     % lavender
cmap(13,:)=[0.05 0.7 1.];   % light blue
cmap(14,:)=[0  0.8 0.4 ];   % green
cmap(15,:)=[1 0.84 0];      % gold
cmap(16,:)=[0 0.8 0.8];     % turquoise 

axes(handles.axes1);
y=[7 12 12 7 7];

x=[-18 -18 -12 -12 -18]; 
plot(x,y,'Color',cmap(1,:),'linewidth',0.75);
hold on;

x=[-18 -18 -12 -12 -18]+10; 
plot(x,y,'Color',cmap(1,:),'linewidth',0.75);

x=[-18 -18 -12 -12 -18]+20; 
plot(x,y,'Color',cmap(1,:),'linewidth',0.75);

x=[-18 -18 -12 -12 -18]+30; 
plot(x,y,'Color',cmap(1,:),'linewidth',0.75);

hold off;
grid on;
set(gca,'XTick',[], 'YTick', [])
xlim([-20 20]);
ylim([0 20]);

%%

text(-11.4,11,'\Pi_{12}','fontsize',11.5);
text(-11.4+10,11,'\Pi_{23}','fontsize',11.5);
text(-11.4+20,11,'\Pi_{34}','fontsize',11.5);

text(-16,17,'\Pi_{in,1}','fontsize',11.5);
text(-16+10,17,'\Pi_{in,2}','fontsize',11.5);
text(-16+20,17,'\Pi_{in,3}','fontsize',11.5);
text(-16+30,17,'\Pi_{in,4}','fontsize',11.5);


text(-16,2,'\Pi_{diss,1}','fontsize',11.5);
text(-16+10,2,'\Pi_{diss,2}','fontsize',11.5);
text(-16+20,2,'\Pi_{diss,3}','fontsize',11.5);
text(-16+30,2,'\Pi_{diss,4}','fontsize',11.5);



text(-16,9.5,'(1)','fontsize',11);
text(-16+10,9.5,'(2)','fontsize',11);
text(-16+20,9.5,'(3)','fontsize',11);
text(-16+30,9.5,'(4)','fontsize',11);

%%


headWidth = 4;
headLength = 4;

%%

ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[-15 15 0 -3]);
        
ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[-15 7 0 -3]);  
        
        
ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[-15+10 15 0 -3]);
        
ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[-15+10 7 0 -3]);  
        
        
ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[-15+20 15 0 -3]);
        
ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[-15+20 7 0 -3]);  
        
ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[-15+30 15 0 -3]);
        
ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[-15+30 7 0 -3]);        
        

%%
  
ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[-12 9.5 4 0]);
        
ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[-12+10 9.5 4 0])
        
 ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[-12+20 9.5 4 0])       

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



change(hObject, eventdata, handles);

set(handles.pushbutton_geometry,'Enable','on');
set(handles.pushbutton_sandwich,'Enable','on');
set(handles.pushbutton_calculate,'Enable','on');

set(handles.listbox_acoustic_field,'Value',1);

try
    naf=getappdata(0,'naf');
    if(isempty(naf))
    else    
        set(handles.listbox_acoustic_field,'Value',naf);
    end
catch
end

try
    alt=getappdata(0,'altitude_orig');
    if(isempty(alt))
    else    
        ss=sprintf('%9.5g',alt);
        set(handles.edit_altitude,'String',ss);
    end
catch
end

try
    alt=getappdata(0,'altitude_orig');
    if(isempty(alt))
    else    
        ss=sprintf('%9.5g',alt);
        set(handles.edit_altitude,'String',ss);
    end
catch
end


try
    mach=getappdata(0,'mach');
    if(isempty(mach))
    else    
        ss=sprintf('%9.5g',mach);
        set(handles.edit_mach,'String',ss);
    end
catch
end


try
    ax=getappdata(0,'ax');
    if(isempty(ax))
    else    
        ss=sprintf('%9.5g',a1);
        set(handles.edit_ax,'String',ss);
    end
catch
end

try
    az=getappdata(0,'az');
    if(isempty(az))
    else    
        ss=sprintf('%9.5g',a2);
        set(handles.edit_az,'String',ss);
    end
catch
end

change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SEA_four_connected_cylindrical_shells_hs wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function edit_gas_md_Callback(hObject, eventdata, handles)
% hObject    handle to edit_gas_md (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_gas_md as text
%        str2double(get(hObject,'String')) returns contents of edit_gas_md as a double


% --- Executes during object creation, after setting all properties.
function edit_gas_md_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gas_md (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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


% --- Executes on selection change in listbox_gas.
function listbox_gas_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_gas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_gas contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_gas
change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_gas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_gas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_acoustic_field.
function listbox_acoustic_field_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_acoustic_field (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_acoustic_field contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_acoustic_field

change(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_acoustic_field_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_acoustic_field (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mach_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mach (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mach as text
%        str2double(get(hObject,'String')) returns contents of edit_mach as a double


% --- Executes during object creation, after setting all properties.
function edit_mach_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mach (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_altitude_Callback(hObject, eventdata, handles)
% hObject    handle to edit_altitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_altitude as text
%        str2double(get(hObject,'String')) returns contents of edit_altitude as a double


% --- Executes during object creation, after setting all properties.
function edit_altitude_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_altitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function reverse_speed(hObject, eventdata, handles)
%

ft_per_km=getappdata(0,'ft_per_km');
 altitude=getappdata(0,'altitude');

alt_num=length(altitude);

c=zeros(alt_num,1);


for ikk=1:alt_num
   
    h=altitude(ikk);

    LH1=11*ft_per_km;
    LH2=20*ft_per_km;
    
    if( h < LH1)  % troposphere
	
        Tz=288.;
		L=6.5;
        gamma=1.402;
        ROM = (8314.3/28.97);

        if( h < 0.)
			h=0;
        end

		c(ikk)=sqrt(abs(gamma*ROM*(Tz-L*(h/(ft_per_km)))))*3.28;

        if( h >= LH1 && h <= LH2 )  % lower stratosphere
		
			c(ikk) = 295.*3.28;
            
        end
        if( h > LH2 )
            warndlg('Altitude too high for speed of sound calculation');
            return;
        end
 
    end
end

setappdata(0,'speed_of_sound',c);

function density(hObject, eventdata, handles)
%
ft_per_km=getappdata(0,'ft_per_km');

h=getappdata(0,'altitude');

if(isempty(h))
    warndlg('Enter altitude');
    return;
end    



alt=zeros(21,1);

for i=1:21
    alt(i)=(i-1)*ft_per_km;
end

dens(1)=1.226;
dens(2)=1.112;
dens(3)=1.007;
dens(4)=0.9096;
dens(5)=0.8195;
dens(6)=0.7365;
dens(7)=0.6600;
dens(8)=0.5898;
dens(9)=0.5254;
dens(10)=0.4666;
dens(11)=0.4129;
dens(12)=0.3641;
dens(13)=0.3104;
dens(14)=0.2652;
dens(15)=0.2266;
dens(16)=0.1936;
dens(17)=0.1654;
dens(18)=0.1413;
dens(19)=0.1207;
dens(20)=0.1032;
dens(21)=0.0881;

rho=0.;

for i=1:20
    
    if( h >= alt(i) && h < alt(i+1) )
		
        len = alt(i+1)-alt(i);
        c2  = (h-alt(i))/len;
        c1  = 1. -c2;

		rho = c1*dens(i) + c2*dens(i+1);

		break;
    end	

end
	
setappdata(0,'gas_md',rho);



function edit_az_Callback(hObject, eventdata, handles)
% hObject    handle to edit_az (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_az as text
%        str2double(get(hObject,'String')) returns contents of edit_az as a double


% --- Executes during object creation, after setting all properties.
function edit_az_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_az (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ax as text
%        str2double(get(hObject,'String')) returns contents of edit_ax as a double


% --- Executes during object creation, after setting all properties.
function edit_ax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton_load_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Outputs from this function are returned to the command line.
function varargout = SEA_four_connected_cylindrical_shells_hs_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

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


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(SEA_four_connected_cylindrical_shells_hs);


% --- Executes on button press in pushbutton_view.
function pushbutton_view_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_view,'Value');

if(n==1)
    A = imread('power_balance_4s.jpg');
end
if(n==2)
    A = imread('clf_line_joint_plates.jpg');    
end
if(n==3)
    A = imread('transmission_coefficient_sandwich.jpg');    
end
if(n==4)
    A = imread('equivalent_acoustic_power_cylinder.jpg');
end
if(n==5)
    A = imread('Corcos_TBL.jpg');
end
if(n==6)
    A = imread('re_sandwich_cylinder.jpg');
end
if(n==7)
    A = imread('modal_density_sandwich_cylinder.jpg');  
end
if(n==8)
    A = imread('wavespeed_sandwich.jpg'); 
end


figure(999)
imshow(A,'border','tight','InitialMagnification',100) 



% --- Executes on selection change in listbox_view.
function listbox_view_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_view contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_view


% --- Executes during object creation, after setting all properties.
function listbox_view_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_view (see GCBO)
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
change(hObject, eventdata, handles);

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


% --- Executes on button press in pushbutton_geometry.
function pushbutton_geometry_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_geometry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iu=get(handles.listbox_units,'Value');
setappdata(0,'iu',iu);

handles.s=SEA_four_geometry;
set(handles.s,'Visible','on');

set(handles.pushbutton_sandwich,'Enable','on');


% --- Executes on button press in pushbutton_sandwich.
function pushbutton_sandwich_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_sandwich (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iu=get(handles.listbox_units,'Value');
setappdata(0,'iu',iu);

handles.s=SEA_honeycomb_sandwich_four;
set(handles.s,'Visible','on');

set(handles.pushbutton_calculate,'Enable','on');


% --- Executes on button press in pushbutton_SPL.
function pushbutton_SPL_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_SPL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_acoustic_field,'Value');

if(n==1)
    handles.s=SEA_four_honeycomb_cylindrical_shells_SPL;
else
    handles.s=SEA_four_honeycomb_cylindrical_shells_SPL;  
end
    
set(handles.s,'Visible','on');

  
set(handles.pushbutton_geometry,'Enable','on');

% --- Executes on button press in pushbutton_load.
function pushbutton_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ref 1');
 
[filename, pathname] = uigetfile('*.mat');
 
NAME = [pathname,filename];
 
struct=load(NAME);
structnames = fieldnames(struct, '-full'); % fields in the struct
 
disp(' ref 2');
 
k=length(structnames);
 
for i=1:k
    namevar=strcat('struct.',structnames{i});
    value=eval(namevar);
    assignin('base',structnames{i},value);
end
 
disp(' ref 3');
 
structnames
 
 
% struct
 
try
    SEA_four_shells_hs=evalin('base','SEA_four_shells_hs');
catch
   warndlg(' evalin failed ');
   return;
end
 
SEA_four_shells_hs
 
disp(' ref 4');
 
 
%%%
 
try
    naf=SEA_four_shells_hs.naf;     
    setappdata(0,'naf',naf);    
    set(handles.listbox_acoustic_field,'value',naf);
catch
end


try
    gas_c=SEA_four_shells_hs.gas_c;    
    setappdata(0,'gas_c_orig',gas_c);
    ss=sprintf('%8.4g',gas_c);
    set(handles.edit_c,'String',ss);
catch
end
 
try
    gas_md=SEA_four_shells_hs.gas_md;    
    setappdata(0,'gas_md_orig',gas_md);
    ss=sprintf('%8.4g',gas_md);
    set(handles.edit_gas_md,'String',ss);
catch
end
 
try
    fstart=SEA_four_shells_hs.fstart;    
    setappdata(0,'fstart_orig',fstart); 
    ss=sprintf('%8.4g',fstart);
    set(handles.edit_fstart,'String',ss);    
catch
end
 
try
    iu=SEA_four_shells_hs.iu;    
    setappdata(0,'iu',iu);
    set(handles.listbox_units,'Value',iu);
catch
end
 
try
    ng=SEA_four_shells_hs.ng;    
    setappdata(0,'ng',ng);
    set(handles.listbox_gas,'Value',ng);
catch
end
 
 
try
    nj12=SEA_four_shells_hs.nj12;    
    setappdata(0,'nj12',nj12);
    set(handles.listbox_j12,'Value',nj12);
catch
end

try
    nj23=SEA_four_shells_hs.nj23;    
    setappdata(0,'nj23',nj23);
    set(handles.listbox_j23,'Value',nj23);
catch
end

try
    nj34=SEA_four_shells_hs.nj34;    
    setappdata(0,'nj34',nj34);
    set(handles.listbox_j34,'Value',nj34);
catch
end
 

try
    L1=SEA_four_shells_hs.L1;    
    setappdata(0,'L1',L1); 
catch
end
 
try
    L2=SEA_four_shells_hs.L2;    
    setappdata(0,'L2',L2);
catch
end

try
    L3=SEA_four_shells_hs.L3;    
    setappdata(0,'L3',L3); 
catch
end
 
try
    L4=SEA_four_shells_hs.L4;    
    setappdata(0,'L4',L4);
catch
end
 

try
    L1_orig=SEA_four_shells_hs.L1_orig;    
    setappdata(0,'L1_orig',L1_orig); 
catch
end
 
try
    L2_orig=SEA_four_shells_hs.L2_orig;    
    setappdata(0,'L2_orig',L2_orig);
catch
end

try
    L3_orig=SEA_four_shells_hs.L3_orig;    
    setappdata(0,'L3_orig',L3_orig); 
catch
end
 
try
    L4_orig=SEA_four_shells_hs.L4_orig;    
    setappdata(0,'L4_orig',L4_orig);
catch
end




try
    diam1=SEA_four_shells_hs.diam1;    
    setappdata(0,'diam1',diam1);    
catch
end
 
try
    diam2=SEA_four_shells_hs.diam2;    
    setappdata(0,'diam2',diam2);    
catch
end
 
 
try
    diam3=SEA_four_shells_hs.diam3;    
    setappdata(0,'diam3',diam3);    
catch
end
 
try
    diam4=SEA_four_shells_hs.diam4;    
    setappdata(0,'diam4',diam4);    
catch
end
 


try
    diam1_orig=SEA_four_shells_hs.diam1_orig;    
    setappdata(0,'diam1_orig',diam1_orig);    
catch
end
 
try
    diam2_orig=SEA_four_shells_hs.diam2_orig;    
    setappdata(0,'diam2_orig',diam2_orig);    
catch
end
 
 
try
    diam3_orig=SEA_four_shells_hs.diam3_orig;    
    setappdata(0,'diam3_orig',diam3_orig);    
catch
end
 
try
    diam4_orig=SEA_four_shells_hs.diam4_orig;    
    setappdata(0,'diam4_orig',diam4_orig);    
catch
end



%%%%%%%%%%%
 
try
    THM=SEA_four_shells_hs.THM;    
    setappdata(0,'SPL_nine',THM);
%    assignin('base',FS,THM);
catch
end
 
try
    FS=SEA_four_shells_hs.FS;    
    setappdata(0,'SPL_nine_name',FS);          
catch
end

%%%%%%%%%%%
 
try
    THM=SEA_four_shells_hs.THM_five;    
    setappdata(0,'SPL_five',THM);
catch
end
 
try
    FS=SEA_four_shells_hs.FS_five;    
    setappdata(0,'SPL_five_name',FS);          
catch
end

%%%%%%%%%%%



try
    assignin('base',FS,THM);    
catch
end

try
    listbox_array_type=SEA_four_shells_hs.listbox_array_type;    
    setappdata(0,'listbox_array_type',listbox_array_type);        
catch
end


%%%


try
    naf=SEA_four_shells_hs.naf;
    set(handles.listbox_acoustic_field,'Value',naf);
catch
end
 
try
    alt=SEA_four_shells_hs.altitude_orig;
    ss=sprintf('%9.5g',alt);
    set(handles.edit_altitude,'String',ss);

catch
end
 
 
 
try
    mach=SEA_four_shells_hs.mach;
    ss=sprintf('%9.5g',mach);
    set(handles.edit_mach,'String',ss);
catch
end
 
 
try
    ax=SEA_four_shells_hs.ax;
    ss=sprintf('%9.5g',ax);
    set(handles.edit_ax,'String',ss);
catch
end
 
try
    az=SEA_four_shells_hs.az;
    ss=sprintf('%9.5g',az);
    set(handles.edit_az,'String',ss);
catch
end

%%%

try
    imat_orig=SEA_four_shells_hs.imat_orig;    
    setappdata(0,'imat_orig',imat_orig);    
catch
end

try
    tf_orig=SEA_four_shells_hs.tf_orig;    
    setappdata(0,'tf_orig',tf_orig);    
catch
end

try
    E_orig=SEA_four_shells_hs.E_orig;    
    setappdata(0,'E_orig',E_orig);    
catch
end

try
    rhof_orig=SEA_four_shells_hs.rhof_orig;    
    setappdata(0,'rhof_orig',rhof_orig);    
catch
end

try
    G_orig=SEA_four_shells_hs.G_orig;    
    setappdata(0,'G_orig',G_orig);    
catch
end

try
    rhoc_orig=SEA_four_shells_hs.rhoc_orig;    
    setappdata(0,'rhoc_orig',rhoc_orig);    
catch
end

try
    hc_orig=SEA_four_shells_hs.hc_orig;    
    setappdata(0,'hc_orig',hc_orig);    
catch
end


try
    mu_orig=SEA_four_shells_hs.mu_orig;    
    setappdata(0,'mu_orig',mu_orig);    
catch
end

try
    tf=SEA_four_shells_hs.tf;    
    setappdata(0,'tf',tf);    
catch
end
 
try
    E=SEA_four_shells_hs.E;    
    setappdata(0,'E',E);    
catch
end
 
try
    rhof=SEA_four_shells_hs.rhof;    
    setappdata(0,'rhof',rhof);    
catch
end
 
try
    G=SEA_four_shells_hs.G;    
    setappdata(0,'G',G);    
catch
end
 
try
    rhoc=SEA_four_shells_hs.rhoc;    
    setappdata(0,'rhoc',rhoc);    
catch
end
 
try
    hc=SEA_four_shells_hs.hc;    
    setappdata(0,'hc',hc);    
catch
end
 
 
try
    mu=SEA_four_shells_hs.mu;    
    setappdata(0,'mu',mu);    
catch
end


%%%

try
    
    sname_1=SEA_four_shells_hs.sname_1;    
    sname_2=SEA_four_shells_hs.sname_2; 
    sname_3=SEA_four_shells_hs.sname_3; 
    sname_4=SEA_four_shells_hs.sname_4;     
   
    data{1,1}=sname_1;
    data{2,1}=sname_2;
    data{3,1}=sname_3;
    data{4,1}=sname_4;

    set(handles.uitable_names,'Data',data);
    
catch
end


try
    smd=SEA_four_shells_hs.smd;
    setappdata(0,'smd_orig',smd);
catch
end

%%%


change(hObject, eventdata, handles);

%%%%



% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    naf=get(handles.listbox_acoustic_field,'Value');
    SEA_four_shells_hs.naf=naf;
catch
end

try
    altitude_orig=str2num(get(handles.edit_altitude,'String')); 
    SEA_four_shells_hs.altitude_orig=altitude_orig;
catch
end

try
    mach=str2num(get(handles.edit_mach,'String'));      
    SEA_four_shells_hs.mach=mach;
catch
end

try
    ax=str2num(get(handles.edit_ax,'String'));     
    SEA_four_shells_hs.ax=ax;
catch
end

try
    az=str2num(get(handles.edit_az,'String')); 
    SEA_four_shells_hs.az=az;
catch
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    gas_c=getappdata(0,'gas_c_orig');        
    SEA_four_shells_hs.gas_c=gas_c;
catch
end
 
try
    gas_md=getappdata(0,'gas_md_orig');
    SEA_four_shells_hs.gas_md=gas_md;
catch
end
 
try
    fstart=getappdata(0,'fstart_orig'); 
    SEA_four_shells_hs.fstart=fstart;
catch
end
 
try
    iu=getappdata(0,'iu');
    SEA_four_shells_hs.iu=iu;
catch
end
 
try
    ng=getappdata(0,'ng');
    SEA_four_shells_hs.ng=ng;
catch
end
 
try
    nj12=getappdata(0,'nj12');
    SEA_four_shells_hs.nj12=nj12;
catch
end

try
    nj23=getappdata(0,'nj23');
    SEA_four_shells_hs.nj23=nj23;
catch
end

try
    nj34=getappdata(0,'nj34');
    SEA_four_shells_hs.nj34=nj34;
catch
end
 
try
    L1=getappdata(0,'L1');
    SEA_four_shells_hs.L1=L1;
catch
end
 
try
    L2=getappdata(0,'L2');
    SEA_four_shells_hs.L2=L2;
catch
end

try
    L3=getappdata(0,'L3');
    SEA_four_shells_hs.L3=L3;
catch
end
 
try
    L4=getappdata(0,'L4');
    SEA_four_shells_hs.L4=L4;
catch
end

try
    L1_orig=getappdata(0,'L1_orig');
    SEA_four_shells_hs.L1_orig=L1_orig;
catch
end
 
try
    L2_orig=getappdata(0,'L2_orig');
    SEA_four_shells_hs.L2_orig=L2_orig;
catch
end

try
    L3_orig=getappdata(0,'L3_orig');
    SEA_four_shells_hs.L3_orig=L3_orig;
catch
end
 
try
    L4_orig=getappdata(0,'L4_orig');
    SEA_four_shells_hs.L4_orig=L4_orig;
catch
end


 
try
    diam1=getappdata(0,'diam1');  
    SEA_four_shells_hs.diam1=diam1;
catch
end
 
try
    diam2=getappdata(0,'diam2');  
    SEA_four_shells_hs.diam2=diam2;
catch
end

 
try
    diam3=getappdata(0,'diam3');  
    SEA_four_shells_hs.diam3=diam3;
catch
end
 
try
    diam4=getappdata(0,'diam4');  
    SEA_four_shells_hs.diam4=diam4;
catch
end
 
try
    diam1_orig=getappdata(0,'diam1_orig');  
    SEA_four_shells_hs.diam1_orig=diam1_orig;
catch
end
 
try
    diam2_orig=getappdata(0,'diam2_orig');  
    SEA_four_shells_hs.diam2_orig=diam2_orig;
catch
end
 
 
try
    diam3_orig=getappdata(0,'diam3_orig');  
    SEA_four_shells_hs.diam3_orig=diam3_orig;
catch
end
 
try
    diam4_orig=getappdata(0,'diam4_orig');  
    SEA_four_shells_hs.diam4_orig=diam4_orig;
catch
end
 
 
try
    THM=getappdata(0,'SPL_five');
    SEA_four_shells_hs.THM_five=THM;
catch
end
 
try
    FS=getappdata(0,'SPL_five_name');          
    SEA_four_shells_hs.FS_five=FS;
catch
end
 
try
    THM=getappdata(0,'SPL_nine');
    SEA_four_shells_hs.THM=THM;
catch
end
 
try
    FS=getappdata(0,'SPL_nine_name');          
    SEA_four_shells_hs.FS=FS;
catch
end


try
    listbox_array_type=getappdata(0,'listbox_array_type');        
    SEA_four_shells_hs.listbox_array_type=listbox_array_type;
catch
end


%%%

try
    imat_orig=getappdata(0,'imat_orig');
    SEA_four_shells_hs.imat_orig=imat_orig;
catch
end

try
    tf_orig=getappdata(0,'tf_orig');
    SEA_four_shells_hs.tf_orig=tf_orig;
catch
end

try
    E_orig=getappdata(0,'E_orig');
    SEA_four_shells_hs.E_orig=E_orig;
catch
end
 
 
try
    rhof_orig=getappdata(0,'rhof_orig');
    SEA_four_shells_hs.rhof_orig=rhof_orig;
catch
end

try
    smd=getappdata(0,'smd_orig');
    SEA_four_shells_hs.smd=smd;
catch
end


try
    G_orig=getappdata(0,'G_orig');
    SEA_four_shells_hs.G_orig=G_orig;
catch
end

try
    rhoc_orig=getappdata(0,'rhoc_orig');
    SEA_four_shells_hs.rhoc_orig=rhoc_orig;
catch
end
 
 
try
    hc_orig=getappdata(0,'hc_orig');
    SEA_four_shells_hs.hc_orig=hc_orig;
catch
end

try
    mu_orig=getappdata(0,'mu_orig');
    SEA_four_shells_hs.mu_orig=mu_orig;
catch
end

try
    tf=getappdata(0,'tf');
    SEA_four_shells_hs.tf=tf;
catch
end
 
try
    E=getappdata(0,'E');
    SEA_four_shells_hs.E=E;
catch
end
 
 
try
    rhof=getappdata(0,'rhof');
    SEA_four_shells_hs.rhof=rhof;
catch
end
 
try
    G=getappdata(0,'G');
    SEA_four_shells_hs.G=G;
catch
end
 
try
    rhoc=getappdata(0,'rhoc');
    SEA_four_shells_hs.rhoc=rhoc;
catch
end
 
 
try
    hc=getappdata(0,'hc');
    SEA_four_shells_hs.hc=hc;
catch
end
 
try
    mu=getappdata(0,'mu');
    SEA_four_shells_hs.mu=mu;
catch
end


try
   
    AA=get(handles.uitable_names,'Data');

    sname_1=char(AA{1,1});
    sname_2=char(AA{2,1});
    sname_3=char(AA{3,1});
    sname_4=char(AA{4,1});

    SEA_four_shells_hs.sname_1=sname_1;
    SEA_four_shells_hs.sname_2=sname_2;
    SEA_four_shells_hs.sname_3=sname_3;
    SEA_four_shells_hs.sname_4=sname_4;    
    
catch
end

 
% % %
 
structnames = fieldnames(SEA_four_shells_hs, '-full'); % fields in the struct
 
 
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);
 
    try
 
        save(elk, 'SEA_four_shells_hs'); 
 
    catch
        warndlg('Save error');
        return;
    end
 
%%% SSS=load(elk)
 
%%%%%%%%%%
%%%%%%%%%%
 
% Construct a questdlg with four options
choice = questdlg('Save Complete.  Reset Workspace?', ...
    'Options', ...
    'Yes','No','No');
% Handle response
switch choice
    case 'Yes'
%%        disp([choice ' Reseting'])
%%        pushbutton_reset_Callback(hObject, eventdata, handles)
        appdata = get(0,'ApplicationData');
        fnsx = fieldnames(appdata);
        for ii = 1:numel(fnsx)
            rmappdata(0,fnsx{ii});
        end
end  

% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('    ');
disp(' * * * * * * ');
disp('    ');

fig_num=1;

setappdata(0,'fig_num',1);

Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end


AA=get(handles.uitable_names,'Data');

sname_1=char(AA{1,1});
sname_2=char(AA{2,1});
sname_3=char(AA{3,1});
sname_4=char(AA{4,1});


NSM_per_area=0;

tpi=2*pi;

iu=get(handles.listbox_units,'Value');
setappdata(0,'iu',iu);

iuo=iu;

%%%%

ft_per_km  = 3.28*1000.;
meters_per_inch=0.0254;
Pa_per_psi = 6894.;
kgpm3_per_lbmpft3=16.016;
kgpm3_per_lbmpin3=27675;

lbmpft3_per_kgpm3=1/kgpm3_per_lbmpft3;

setappdata(0,'ft_per_km',ft_per_km);

%%%%

naf=get(handles.listbox_acoustic_field,'Value');
setappdata(0,'naf',naf);


%
if(naf==1) % Diffuse

    fs_velox=0;
    mach=0;
    altitude=0;
    ax=0;
    az=0;
    setappdata(0,'altitude_orig',altitude);    
    
    ng=get(handles.listbox_gas,'Value');
    gas_c=str2num(get(handles.edit_c,'String')); 
    gas_md=str2num(get(handles.edit_gas_md,'String'));    
    
else       % TBL
    
    ng=1;
    mach=str2num(get(handles.edit_mach,'String'));
    altitude=str2num(get(handles.edit_altitude,'String'));
    
    if(isempty(mach))
        warndlg('Enter mach');
        return;
    end
    if(isempty(altitude))
        warndlg('Enter altitude');
        return;
    end
    
    setappdata(0,'altitude_orig',altitude);

    [~,mass_dens,~,~,sound_speed]=atmopheric_properties(altitude,iu);
    
    fs_velox=mach*sound_speed;

    gas_md=mass_dens;
    gas_c=sound_speed;
    
%%    gammax=getappdata(0,'gammax');
%%    gamma_3=getappdata(0,'gamma_3');
%%    delta_star=getappdata(0,'delta_star');
%%    Reynolds=getappdata(0,'Reynolds');
    
    ax=str2num(get(handles.edit_ax,'String'));
    az=str2num(get(handles.edit_az,'String'));
    
end


setappdata(0,'mach',mach);
setappdata(0,'ax',ax);
setappdata(0,'az',ax);

setappdata(0,'ng',ng);
setappdata(0,'gas_c_orig',gas_c);
setappdata(0,'gas_md_orig',gas_md);
setappdata(0,'fs_velox',fs_velox);


if(iu==1)  % convert English to metric
   
   gas_c=gas_c*12;
   gas_c=gas_c*meters_per_inch;
   
   gas_md=gas_md*kgpm3_per_lbmpft3;
   
end

if(naf==2)
    fs_velox=mach*gas_c;  % m/sec
end

%%%%

L1=getappdata(0,'L1');
L2=getappdata(0,'L2');
L3=getappdata(0,'L3');
L4=getappdata(0,'L4');



diam1=getappdata(0,'diam1');
diam2=getappdata(0,'diam2');
diam3=getappdata(0,'diam3');
diam4=getappdata(0,'diam4');

nj12=getappdata(0,'nj12');
nj23=getappdata(0,'nj23');
nj34=getappdata(0,'nj34');



if(isempty(nj12))
    warndlg('nj12 not found.  Run geometry');
    return;
end
if(isempty(nj23))
    warndlg('nj23 not found.  Run geometry');
    return;
end
if(isempty(nj34))
    warndlg('nj34 not found.  Run geometry');
    return;
end

%%%%

if(nj12==1)
    Lc12=pi*diam1;
end
if(nj12==2)
    Lc12=pi*diam2;    
end
if(nj12==3)
    Lc12=pi*mean([ diam1 diam2  ]);
end

%%%%

if(nj23==1)
    Lc23=pi*diam2;
end
if(nj23==2)
    Lc23=pi*diam3;    
end
if(nj23==3)
    Lc23=pi*mean([ diam2 diam3  ]);
end

%%%%

if(nj34==1)
    Lc34=pi*diam3;
end
if(nj34==2)
    Lc34=pi*diam4;    
end
if(nj34==3)
    Lc34=pi*mean([ diam3 diam4  ]);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
   THM=getappdata(0,'SPL_nine');
catch
   warndlg('Enter SPL'); 
   return;     
end
    
if(isempty(THM))
   warndlg('Enter SPL'); 
   return; 
end    

freq=THM(:,1);
fc=freq;

dB1=THM(:,2);
dB2=THM(:,3);
dB3=THM(:,4);
dB4=THM(:,5);
lf1=THM(:,6);
lf2=THM(:,7);
lf3=THM(:,8);
lf4=THM(:,9); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

E=getappdata(0,'E');
mu=getappdata(0,'mu');
G=getappdata(0,'G');

rhoc=getappdata(0,'rhoc');
hc=getappdata(0,'hc');

tf=getappdata(0,'tf');
rhof=getappdata(0,'rhof');

smd=getappdata(0,'smd');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(isempty(tf))
    warndlg('tf missing. Enter Sandwich Data');
    return;
end
if(isempty(hc))
    warndlg('hc missing. Enter Sandwich Data');
    return;
end
if(isempty(G))
    warndlg('G missing. Enter Sandwich Data');
    return;
end
if(isempty(rhof))
    warndlg('rhof missing. Enter Sandwich Data');
    return;
end
if(isempty(rhoc))
    warndlg('rhoc missing. Enter Sandwich Data');
    return;
end
if(isempty(smd))
    warndlg('smd missing. Enter Sandwich Data');
    return;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% bc=get(handles.listbox_bc,'Value');
bc=4;   % simply supported at each end


fstart=str2num(get(handles.edit_fstart,'String')); 


if(isempty(fstart))
   warndlg(' Enter output starting frequency '); 
   return; 
end    

setappdata(0,'fstart_orig',fstart);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

iu=2;

c=gas_c;

rho_c=gas_md*gas_c;

disp(' ');
out1=sprintf(' L1=%8.4g  L2=%8.4g  L3=%8.4g  L4=%8.4g ',L1,L2,L3,L4);
disp(out1);
out1=sprintf(' diam1=%8.4g  diam2=%8.4g  diam3=%8.4g  diam4=%8.4g ',diam1,diam2,diam3,diam4);
disp(out1);
out1=sprintf(' E=%8.4g  G=%8.4g  mu=%8.4g  tf=%8.4g  hc=%8.4g rhof=%8.4g  rhoc=%8.4g',E,G,mu,tf,hc,rhof,rhoc);
disp(out1);
disp(' ');
 

[D1,K1,S1,~,fring1]=honeycomb_sandwich_properties_wave(E(1),G(1),mu(1),tf(1),hc(1),diam1,rhof(1),rhoc(1));
[D2,K2,S2,~,fring2]=honeycomb_sandwich_properties_wave(E(2),G(2),mu(2),tf(2),hc(2),diam2,rhof(2),rhoc(2));
[D3,K3,S3,~,fring3]=honeycomb_sandwich_properties_wave(E(3),G(3),mu(3),tf(3),hc(3),diam3,rhof(3),rhoc(3));
[D4,K4,S4,~,fring4]=honeycomb_sandwich_properties_wave(E(4),G(4),mu(4),tf(4),hc(4),diam4,rhof(4),rhoc(4));

[f11,f12]=shear_frequencies(E(1),G(1),mu(1),tf(1),hc(1),rhof(1),rhoc(1));
[f21,f22]=shear_frequencies(E(2),G(2),mu(2),tf(2),hc(2),rhof(2),rhoc(2));
[f31,f32]=shear_frequencies(E(3),G(3),mu(3),tf(3),hc(3),rhof(3),rhoc(3));
[f41,f42]=shear_frequencies(E(4),G(4),mu(4),tf(4),hc(4),rhof(4),rhoc(4));


NSM_per_area=0;

fcr=zeros(4,1);
mpa=zeros(4,1);
B=zeros(4,1);
Bf=zeros(4,1);
kflag=zeros(4,1);

for i=1:4

    [fcr(i),mpa(i),B(i),Bf(i),kflag(i)]=...
          honeycomb_sandwich_critical_frequency_D(E(i),G(i),mu(i),tf(i),hc(i),rhof(i),rhoc(i),gas_c,NSM_per_area);

    if(kflag(i)==1)
        warndlg('Critical frequency does not exist for this case');
        return;
    end

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mpa=smd;

mmax=220;
nmax=220;

Ap1=L1*pi*diam1;
mass1=mpa(1)*Ap1;
m1=mass1;

Ap2=L2*pi*diam2;
mass2=mpa(2)*Ap2;
m2=mass2;

Ap3=L3*pi*diam3;
mass3=mpa(3)*Ap3;
m3=mass3;

Ap4=L4*pi*diam4;
mass4=mpa(4)*Ap4;
m4=mass4;


num=length(fc);




[rad_eff1,mph1]=...
    re_sandwich_cylinder_engine_alt(D1,K1,mu(1),diam1,L1,mpa(1),bc,mmax,nmax,gas_c,fcr(1),fring1,freq);

[rad_eff2,mph2]=...
    re_sandwich_cylinder_engine_alt(D2,K2,mu(2),diam2,L2,mpa(2),bc,mmax,nmax,gas_c,fcr(2),fring2,freq);


[rad_eff3,mph3]=...
    re_sandwich_cylinder_engine_alt(D3,K3,mu(3),diam3,L3,mpa(3),bc,mmax,nmax,gas_c,fcr(3),fring3,freq);

[rad_eff4,mph4]=...
    re_sandwich_cylinder_engine_alt(D4,K4,mu(4),diam4,L4,mpa(4),bc,mmax,nmax,gas_c,fcr(4),fring4,freq);



jf=1;
jg=1;

for i=(num-2):-1:1
    if(mph1(i)<1.e-20 || mph2(i)<1.e-20 || mph3(i)<1.e-20 || mph4(i)<1.e-20 || rad_eff1(i)<1.e-20 || rad_eff2(i)<1.e-20 || rad_eff3(i)<1.e-20 || rad_eff4(i)<1.e-20 ||fc(i)<fstart ) 
        
        jf=i+1;
        disp(' break 1');
        break;
    end
end

for i=(num-2):-1:1
    
    if(mph1(i)<1.e-20 || mph2(i)<1.e-20 || mph3(i)<1.e-20 || mph4(i)<1.e-20 || rad_eff1(i)<1.e-20 || rad_eff2(i)<1.e-20 || rad_eff3(i)<1.e-20 || rad_eff4(i)<1.e-20 )
        
        
        out1=sprintf('i=%d  mph1=%8.4g  mph2=%8.4g  mph3=%8.4g  mph4=%8.4g \n     rad_eff1=%8.4g  rad_eff2=%8.4g  rad_eff3=%8.4g  rad_eff4=%8.4g   ',i,mph1(i),mph2(i),mph3(i),mph4(i),rad_eff1(i),rad_eff2(i),rad_eff3(i),rad_eff4(i));
        disp(out1);
        
        jg=i+1;
        disp(' break 2');
        break;
    end
end

out1=sprintf(' jf=%d jg=%d  num=%d',jf,jg,num);
disp(out1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ppp1=[fc(jg:num) rad_eff1(jg:num)];
ppp2=[fc(jg:num) rad_eff2(jg:num)];
ppp3=[fc(jg:num) rad_eff3(jg:num)];
ppp4=[fc(jg:num) rad_eff4(jg:num)];


try
    fmin=fc(jf);
catch
    fmin=fc(1);
end
        
fmax=fc(num);

try
    out1=sprintf('\n fc(jf)=%8.4g  jf=%d  fc(jg)=%8.4g  jg=%d  \n',fc(jf),jf,fc(jg),jg);
    disp(out1);
catch
end
    
out1=sprintf('\n fmin=%8.4g   fmax=%8.4g  \n',fmin,fmax);
disp(out1);

if(fmax<1)
    warndlg('fmax error');
    return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

freq=THM(:,1);
fc=freq;

dB1=THM(:,2);
dB2=THM(:,3);
dB3=THM(:,4);
dB4=THM(:,5);


leg1=sname_1;
leg2=sname_2;
leg3=sname_3;
leg4=sname_4;

f1=fc;
f2=f1;
f3=f1;
f4=f1;

n_type=1;

if(naf==1)
    [fig_num]=spl_plot_four(fig_num,n_type,f1,dB1,f2,dB2,f3,dB3,f4,dB4,leg1,leg2,leg3,leg4);
else
    [fig_num]=fpl_plot_four(fig_num,n_type,f1,dB1,f2,dB2,f3,dB3,f4,dB4,leg1,leg2,leg3,leg4);    
end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

leg1=sname_1;
leg2=sname_2;
leg3=sname_3;
leg4=sname_4;


x_label='Center Frequency (Hz)';
y_label='Ratio';
t_string='Radiation Efficiency';

md=3;
[fig_num,h2]=plot_loglog_function_md_four_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,ppp4,leg1,leg2,leg3,leg4,fmin,fmax,md);
           
           
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

alpha=2^(1/6)-1/2^(1/6);

k=1;

num_modes_1=zeros((num-jg+1),1);
num_modes_2=zeros((num-jg+1),1);
num_modes_3=zeros((num-jg+1),1);
num_modes_4=zeros((num-jg+1),1);

fnm=zeros((num-jg+1),1);


for i=jg:num
    
    bw=fc(i)*alpha;
    
    fnm(k)=fc(i);
    
    num_modes_1(k)=mph1(i)*bw;
    num_modes_2(k)=mph2(i)*bw;    
    num_modes_3(k)=mph3(i)*bw;
    num_modes_4(k)=mph4(i)*bw;     
    
    k=k+1;
    
end

data1=[fnm num_modes_1];
data2=[fnm num_modes_2];
data3=[fnm num_modes_3];
data4=[fnm num_modes_4];

xlabel2='Center Frequency (Hz)';
ylabel1='Modes';
ylabel2='Modes';
ylabel3='Modes';
ylabel4='Modes';


t_string1=sprintf('Number of Modes in Band  %s',sname_1);
t_string2=sprintf('Number of Modes in Band  %s',sname_2);
t_string3=sprintf('Number of Modes in Band  %s',sname_3);
t_string4=sprintf('Number of Modes in Band  %s',sname_4);

[fig_num]=subplots_four_onethird_bar(fig_num,xlabel2,...
                                     ylabel1,ylabel2,ylabel3,ylabel4,...
                                     data1,data2,data3,data4,...
                                     t_string1,t_string2,t_string3,t_string4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ppp1=[fc(jg:num) mph1(jg:num)];
ppp2=[fc(jg:num) mph2(jg:num)];
ppp3=[fc(jg:num) mph3(jg:num)];
ppp4=[fc(jg:num) mph4(jg:num)];


leg1=sname_1;
leg2=sname_2;
leg3=sname_3;
leg4=sname_4;


x_label='Center Frequency (Hz)';
y_label='n (modes/Hz)';
t_string='Modal Density';

md=3;
[fig_num,h2]=plot_loglog_function_md_four_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,ppp4,leg1,leg2,leg3,leg4,fmin,fmax,md);

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


disp(' ');
disp('   Modal Density (modes/Hz)');
disp(' ');
disp('   fc(Hz)   mph1   mph2    mph3   mph4 ');
disp(' ');

for i=1:num    

    out1=sprintf('%7.1f  %8.4g  %8.4g  %8.4g  %8.4g',fc(i),mph1(i),mph2(i),mph3(i),mph4(i));
    disp(out1);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


   power1=zeros(num,1);
power_dB1=zeros(num,1);

   power2=zeros(num,1);
power_dB2=zeros(num,1);

   power3=zeros(num,1);
power_dB3=zeros(num,1);

   power4=zeros(num,1);
power_dB4=zeros(num,1);

md=rhof;
md_core=rhoc;
v=mu;

for i=1:4

%    [B(i),~,~,mpa(i)]=honeycomb_sandwich_properties(E(i),G(i),v(i),tf(i),hc(i),md(i),md_core(i));
%    [Bf(i)]=flexural_rigidity(E(i),tf(i),v(i));


    if(naf==2)
        Uc=0.8*fs_velox;
        omegac = (Uc/( (B(i)/mpa(i))^(1/4)))^2; 
        fh=omegac/tpi;
        out1=sprintf('%d  fh=%8.4g Hz  Uc=%8.4g  B=%8.4g  mpa=%8.4g',i,fh,Uc,B(i),mpa(i));
        disp(out1);

    end

end


omega=tpi*fc;

cp=zeros(4,1);

disp(' ');


for i=1:num    
    
    if(naf==1) % diffuse
        
        [power1(i),power_dB1(i)]=power_from_spl_dB(fc(i),dB1(i),mph1(i),c,mpa(1),rad_eff1(i));    
        [power2(i),power_dB2(i)]=power_from_spl_dB(fc(i),dB2(i),mph2(i),c,mpa(2),rad_eff2(i));
        [power3(i),power_dB3(i)]=power_from_spl_dB(fc(i),dB3(i),mph3(i),c,mpa(3),rad_eff3(i));    
        [power4(i),power_dB4(i)]=power_from_spl_dB(fc(i),dB4(i),mph4(i),c,mpa(4),rad_eff4(i)); 
        
%%        out1=sprintf('fc=%8.4g  c=%8.4g  mpa=%8.4g   ',fc(i),c,mpa);
%%        disp(out1);
    
    else       % TBL
        
        for j=1:4
            [cp(j)]=sandwich_wavespeed_polynomial(omega(i),B(j),Bf(j),G(j),mpa(j),hc(j));
        end    
 
        [power1(i),power_dB1(i)]=power_from_TBL_spl_dB(fc(i),dB1(i),mpa(1),Ap1,L1,diam1,Uc,ax,az,D1);     
        [power2(i),power_dB2(i)]=power_from_TBL_spl_dB(fc(i),dB2(i),mpa(2),Ap2,L2,diam2,Uc,ax,az,D2);  
        [power3(i),power_dB3(i)]=power_from_TBL_spl_dB(fc(i),dB3(i),mpa(3),Ap3,L3,diam3,Uc,ax,az,D3);       
        [power4(i),power_dB4(i)]=power_from_TBL_spl_dB(fc(i),dB4(i),mpa(4),Ap4,L4,diam4,Uc,ax,az,D4);        
        
 %      out1=sprintf('om=%8.4g B=%8.4g Bf=%8.4g G=%8.4g hc=%8.4g',omega(i),B,Bf,G,mpa,hc);
 %      disp(out1);
    
    end
    
end

if(naf==2)
    
  disp(' ');  
  disp('Hydrodynamically slow to fast transition frequencies '); 
  
  for i=1:4
  
    [ftrans]=sandwich_wavespeed_polynomial_transition(B(i),Bf(i),G(i),mpa(i),hc(i),Uc); 
   
    out1=sprintf(' %d   %8.4g Hz',i,ftrans);
    disp(out1);
  
  end
  
end


disp(' ');
disp(' Zero dB References: ');
disp('   Pressure 20 micro Pa');
disp('   Power     1 pico Watt ');
disp(' ');
disp('   fc    SPL1    SPL2    SPL3     SPL4    ');
disp('  (Hz)   (dB)    (dB)    (dB)     (dB)    ');

for i=1:num
    out1=sprintf('%7.1f  %6.1f  %6.1f  %6.1f  %6.1f',fc(i),dB1(i),dB2(i),dB3(i),dB4(i));
    disp(out1);
end    


disp(' ');
disp('   fc    Power1  Power2  Power3   Power4    ');
disp('  (Hz)   (dB)    (dB)    (dB)     (dB)    ');


for i=1:num    
    out1=sprintf('%7.1f  %6.1f  %6.1f  %6.1f  %6.1f',fc(i),power_dB1(i),power_dB2(i),power_dB3(i),power_dB4(i));
    disp(out1);
end


disp(' ');

[oapow1]=oaspl_function(power_dB1);
[oapow2]=oaspl_function(power_dB2);
[oapow3]=oaspl_function(power_dB3);
[oapow4]=oaspl_function(power_dB4);

out1=sprintf('\n Overall Power Levels \n  Power 1 = %7.4g dB \n  Power 2 = %7.4g dB \n  Power 3 = %7.4g dB \n  Power 4 = %7.4g dB ',oapow1,oapow2,oapow3,oapow4);
disp(out1);


power_ref=1.0e-12;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

NL=length(fc);

omega=tpi*fc;

clf_12=zeros(NL,1);
clf_21=zeros(NL,1);

clf_23=zeros(NL,1);
clf_32=zeros(NL,1);

clf_34=zeros(NL,1);
clf_43=zeros(NL,1);

Moverlap1=zeros(NL,1);
Moverlap2=zeros(NL,1);
Moverlap3=zeros(NL,1);
Moverlap4=zeros(NL,1);


lfa1=zeros(NL,1);
lfa2=zeros(NL,1);
lfa3=zeros(NL,1);
lfa4=zeros(NL,1);



% [B,~,~,mpa]=honeycomb_sandwich_properties(E,G,mu,tf,hc,rhof,rhoc);
% [Bf]=flexural_rigidity(E,tf,mu);


for i=1:NL

    [Moverlap1(i)]=SEA_modal_overlap(mph1(i),lf1(i),freq(i));
    [Moverlap2(i)]=SEA_modal_overlap(mph2(i),lf2(i),freq(i));
    [Moverlap3(i)]=SEA_modal_overlap(mph3(i),lf3(i),freq(i));
    [Moverlap4(i)]=SEA_modal_overlap(mph4(i),lf4(i),freq(i));       
    
    [clf_12(i),clf_21(i),~,~]=line_joint_plates(E,rho,mu,h1,h2,Ap1,Ap2,omega(i),Lc12);
    [clf_23(i),clf_32(i),~,~]=line_joint_plates(E,rho,mu,h1,h2,Ap2,Ap3,omega(i),Lc23);
    [clf_34(i),clf_43(i),~,~]=line_joint_plates(E,rho,mu,h1,h2,Ap3,Ap4,omega(i),Lc34);
    
    radiation_resistance1=rho_c*Ap1*rad_eff1(i);
    lfa1(i)=radiation_resistance1/(m1*omega(i));  
    
    radiation_resistance2=rho_c*Ap2*rad_eff2(i);
    lfa2(i)=radiation_resistance2/(m2*omega(i));      
    
    radiation_resistance3=rho_c*Ap3*rad_eff3(i);
    lfa3(i)=radiation_resistance3/(m3*omega(i));   
    
    radiation_resistance4=rho_c*Ap4*rad_eff4(i);
    lfa4(i)=radiation_resistance4/(m4*omega(i));       

end


total_lf1=lf1+lfa1;
total_lf2=lf2+lfa2;
total_lf3=lf3+lfa3;
total_lf4=lf4+lfa4;

ppq1=[fc(jg:num)  Moverlap1(jg:num) ];
ppq2=[fc(jg:num)  Moverlap2(jg:num) ];
ppq3=[fc(jg:num)  Moverlap3(jg:num) ];
ppq4=[fc(jg:num)  Moverlap4(jg:num) ];


leg1=sname_1;
leg2=sname_2;
leg3=sname_3;
leg4=sname_4;


x_label='Center Frequency (Hz)';
y_label=' ';
t_string='Modal Overlap';

md=4;
[fig_num,h2]=plot_loglog_function_md_four_h2(fig_num,x_label,...
               y_label,t_string,ppq1,ppq2,ppq3,ppq4,leg1,leg2,leg3,leg4,fmin,fmax,md);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      

v1=zeros(NL,1);
v2=zeros(NL,1);
v3=zeros(NL,1);
v4=zeros(NL,1);

a1=zeros(NL,1);
a2=zeros(NL,1);
a3=zeros(NL,1);
a4=zeros(NL,1);

broadband=zeros(NL,4);
 
DD=2;
z=2^(1/6);

for i=1:NL

    A=zeros(4,4);
    
    A(1,1)=total_lf1(i)+clf_12(i);
    A(1,2)=-clf_21(i);
    
    A(2,1)=-clf_12(i);
    A(2,2)=total_lf2(i)+clf_21(i)+clf_23(i);
    A(2,3)=-clf_32(i);
    
    A(3,2)=-clf_23(i);
    A(3,3)=total_lf3(i)+clf_32(i)+clf_34(i);
    A(3,4)=-clf_43(i);
    
    A(4,3)=-clf_34(i);
    A(4,4)=total_lf4(i)+clf_43(i);
   

    B=[ power1(i); power2(i); power3(i); power4(i)]/omega(i);

    E=A\B;

    E1=E(1);
    E2=E(2);
    E3=E(3);
    E4=E(4);    
    
    [v1(i),a1(i)]=energy_to_velox_accel(E1,m1,omega(i));    
    [v2(i),a2(i)]=energy_to_velox_accel(E2,m2,omega(i));
    [v3(i),a3(i)]=energy_to_velox_accel(E3,m3,omega(i));
    [v4(i),a4(i)]=energy_to_velox_accel(E4,m4,omega(i));   
    
    delta_f=fc(i)*(z-1/z);
    
    for j=1:4
        
        if(j==1)
            nnet= total_lf1(i);
            mdens=mph1(i);
        end
        if(j==2)
            nnet= total_lf2(i);  
            mdens=mph2(i);           
        end
        if(j==3)
            nnet= total_lf3(i);
            mdens=mph3(i);
        end
        if(j==4)
            nnet= total_lf4(i);  
            mdens=mph4(i);           
        end        
        
        [~,broadband(i,j)]=statistical_response_concentration_core(fc(i),delta_f,nnet,mdens,DD);
        
    end
    

end


if(iu==2)
   v1=v1*1000;
   v2=v2*1000;
   v3=v3*1000;
   v4=v4*1000;   
end

if(iu==1)
   a1=a1/386;
   a2=a2/386;
   a3=a3/386;
   a4=a4/386;   
else
   a1=a1/9.81;
   a2=a2/9.81;  
   a3=a3/9.81;
   a4=a4/9.81;       
end


if(iu==1)
    seu='in-lbf';
    spu='in-lbf/sec';
    spv='in/sec';
else
    seu='J';
    spu='W';
    spv='mm/sec';    
end  

if(iuo==1)
    v1=v1/25.4;
    v2=v2/25.4;
    v3=v3/25.4;
    v4=v4/25.4;    
    spv='in/sec';
end


disp(' ');
disp(' * * * * ');
disp(' ');
   disp(' Freq      a1       a2       a3       a4');
   
if(iuo==1)
    disp(' (Hz)    (G)      (G)       (G)      (G)');    
else
    disp(' (Hz)    (G)      (G)       (G)      (G)');  
end
    
    
for i=1:NL
    
    out1=sprintf(' %g   %8.4g   %8.4g  %8.4g  %8.4g',fc(i),a1(i),a2(i),a3(i),a4(i));
    disp(out1);
    
end



x_label='Frequency (Hz)';
y_label=sprintf('Velocity (%s) rms',spv);


md=5;
leg1=sname_1;
leg2=sname_2;
leg3=sname_3;
leg4=sname_4;

ppp1=[fc(jf:num) v1(jf:num)];
ppp2=[fc(jf:num) v2(jf:num)];
ppp3=[fc(jf:num) v3(jf:num)];
ppp4=[fc(jf:num) v4(jf:num)];

t_string='Velocity Spectrum';

[fig_num,h2]=plot_loglog_function_md_four_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,ppp4,leg1,leg2,leg3,leg4,fmin,fmax,md);

aaa1=[fc(jf:num) a1(jf:num)];
aaa2=[fc(jf:num) a2(jf:num)];
aaa3=[fc(jf:num) a3(jf:num)];
aaa4=[fc(jf:num) a4(jf:num)];           
           
y_label=sprintf('Accel (G rms)');           
t_string='Acceleration Spectrum';

[fig_num,h2]=plot_loglog_function_md_four_h2(fig_num,x_label,...
               y_label,t_string,aaa1,aaa2,aaa3,aaa4,leg1,leg2,leg3,leg4,fmin,fmax,md);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



qqq1=[fc(jf:num) power1(jf:num)];
qqq2=[fc(jf:num) power2(jf:num)];
qqq3=[fc(jf:num) power3(jf:num)];
qqq4=[fc(jf:num) power4(jf:num)];

t_string='Input Power Spectrum';

if(iu==1)
   y_label='Power (in-lbf/sec)'; 
else
   y_label='Power (W)';    
end

[oapow1]=oaspl_function(power_dB1(jf:num));
[oapow2]=oaspl_function(power_dB2(jf:num));
[oapow3]=oaspl_function(power_dB3(jf:num));
[oapow4]=oaspl_function(power_dB4(jf:num));

wov1=power_ref*10^(oapow1/10);
wov2=power_ref*10^(oapow2/10);
wov3=power_ref*10^(oapow3/10);
wov4=power_ref*10^(oapow4/10);

leg1=sprintf('%s  %8.4g W overall',sname_1,wov1);
leg2=sprintf('%s  %8.4g W overall',sname_2,wov2);
leg3=sprintf('%s  %8.4g W overall',sname_3,wov3);
leg4=sprintf('%s  %8.4g W overall',sname_4,wov4);


    [fig_num,h2]=plot_loglog_function_md_four_h2(fig_num,x_label,...
               y_label,t_string,qqq1,qqq2,qqq3,qqq4,leg1,leg2,leg3,leg4,fmin,fmax,md);           
           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t_string='Loss Factors';
y_label='Loss Factor'; 

rrr1=[fc total_lf1];
rrr2=[fc total_lf2];
rrr3=[fc total_lf3];
rrr4=[fc total_lf4];

leg1='total lf 1';
leg2='total lf 2';
leg3='total lf 3';
leg4='total lf 4';


[fig_num,h2]=plot_loglog_function_md_four_h2(fig_num,x_label,...
               y_label,t_string,rrr1,rrr2,rrr3,rrr4,leg1,leg2,leg3,leg4,fmin,fmax,md);

leg1='clf 12';
leg2='clf 21';
leg3='clf 23';
leg4='clf 32';    
leg5='clf 34';
leg6='clf 43';  
  
t_string='Coupling Loss Factors';
y_label='CLF'; 
           
rrr1=[fc clf_12];
rrr2=[fc clf_21];   

rrr3=[fc clf_23];
rrr4=[fc clf_32]; 

rrr5=[fc clf_34];
rrr6=[fc clf_43]; 

[fig_num,h2]=plot_loglog_function_md_six_h2(fig_num,x_label,...
               y_label,t_string,rrr1,rrr2,rrr3,rrr4,rrr5,rrr6,...
              leg1,leg2,leg3,leg4,leg5,leg6,fmin,fmax,md);
          
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
t_string='Maximum Mean-Square Velocity Amplification';
y_label='Amplification (dB)'; 
 
leg1=sname_1;
leg2=sname_2;
leg3=sname_3;
leg4=sname_4;

ppp1=[fc(jf:num) broadband(jf:num,1)];
ppp2=[fc(jf:num) broadband(jf:num,2)];
ppp3=[fc(jf:num) broadband(jf:num,3)];
ppp4=[fc(jf:num) broadband(jf:num,4)];

broadband1=ppp1;
broadband2=ppp2;
broadband3=ppp3;
broadband4=ppp4;
 

[fig_num,h2]=plot_loglin_function_four_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,ppp4,leg1,leg2,leg3,leg4,fmin,fmax);
          

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nb=1;

if(nb<=2)
    
    [psd1,~]=psd_from_spectrum(nb,fc,a1);    
    [psd2,~]=psd_from_spectrum(nb,fc,a2);  
    [psd3,~]=psd_from_spectrum(nb,fc,a3);    
    [psd4,~]=psd_from_spectrum(nb,fc,a4);     
    
    [~,grms1] = calculate_PSD_slopes(fc(jf:num),psd1(jf:num));
    [~,grms2] = calculate_PSD_slopes(fc(jf:num),psd2(jf:num));
    [~,grms3] = calculate_PSD_slopes(fc(jf:num),psd3(jf:num));
    [~,grms4] = calculate_PSD_slopes(fc(jf:num),psd4(jf:num));    
 
    disp(' ');
    disp(' Power Spectral Density ');
    disp(' ');
    disp('   Freq    PSD 1     PSD 2     PSD 3     PSD 4 ');
    disp('   (Hz)   (G^2/Hz)  (G^2/Hz)   (G^2/Hz)  (G^2/Hz)');
           
    for i=jf:NL
    
        out1=sprintf('  %g    %8.4g  %8.4g  %8.4g  %8.4g',fc(i),psd1(i),psd2(i),psd3(i),psd4(i));
        disp(out1);
    
    end
 

    leg1=sprintf('%s  %7.3g GRMS',sname_1,grms1);
    leg2=sprintf('%s  %7.3g GRMS',sname_2,grms2);
    leg3=sprintf('%s  %7.3g GRMS',sname_3,grms3);
    leg4=sprintf('%s  %7.3g GRMS',sname_4,grms4);   
    
    disp(' ');
    disp(' Overall Levels ');
    disp(' ');   
    out1=sprintf(' Subsystem 1 = %8.4g GRMS',grms1);
    disp(out1);
    out2=sprintf(' Subsystem 2 = %8.4g GRMS',grms2);
    disp(out2);
    out3=sprintf(' Subsystem 3 = %8.4g GRMS',grms3);
    disp(out3);
    out4=sprintf(' Subsystem 4 = %8.4g GRMS',grms4);
    disp(out4);      
    
    psd1=[fc(jf:num) psd1(jf:num)];
    psd2=[fc(jf:num) psd2(jf:num)];  
    psd3=[fc(jf:num) psd3(jf:num)];
    psd4=[fc(jf:num) psd4(jf:num)];     
    
    qqq1=psd1;
    qqq2=psd2;    
    qqq3=psd3;
    qqq4=psd4;        
    
    y_label='Accel (G^2/Hz)';
    
    t_string=sprintf('Power Spectral Density');
 

    [fig_num,h2]=plot_loglog_function_md_four_h2(fig_num,x_label,...
               y_label,t_string,qqq1,qqq2,qqq3,qqq4,leg1,leg2,leg3,leg4,fmin,fmax,md);
end
 
disp(' ');
disp('  Ring Frequencies ');
disp(' ');
out1=sprintf('%s  %8.4g Hz',sname_1,fring1);
out2=sprintf('%s  %8.4g Hz',sname_2,fring2);
out3=sprintf('%s  %8.4g Hz',sname_3,fring3);
out4=sprintf('%s  %8.4g Hz',sname_4,fring4);
disp(out1);
disp(out2);
disp(out3);
disp(out4);

disp(' ');
disp(' Subsystem 1');
display_shear_frequencies(f11,f12);
disp(' ')
disp(' Subsystem 2');
display_shear_frequencies(f21,f22);
disp(' ')
disp(' Subsystem 3');
display_shear_frequencies(f31,f32);
disp(' ')
disp(' Subsystem 4');
display_shear_frequencies(f41,f42);

for i=1:4

    out1=sprintf('\n Subsystem %d ',i);
    disp(out1);
    out1=sprintf(' Mass per area = %8.4g kg/m^2',mpa(i));
    out2=sprintf('               = %8.4g lbm/ft^2',mpa(i)*0.20485 );
    out3=sprintf('               = %8.4g lbm/in^2',mpa(i)*0.0014226 );
    disp(out1);
    disp(out2);
    disp(out3);

end



aa1=[fc dB1 rad_eff1 mph1];
aa2=[fc dB2 rad_eff2 mph2];
aa3=[fc dB3 rad_eff3 mph3];
aa4=[fc dB4 rad_eff4 mph4];

assignin('base', 'aa1',aa1);
assignin('base', 'aa2',aa2);
assignin('base', 'aa3',aa3);
assignin('base', 'aa4',aa4);

assignin('base', 'power_dB1',[fc(jf:num) power_dB1(jf:num)]);
assignin('base', 'power_dB2',[fc(jf:num) power_dB2(jf:num)]);
assignin('base', 'power_dB3',[fc(jf:num) power_dB3(jf:num)]);
assignin('base', 'power_dB4',[fc(jf:num) power_dB4(jf:num)]);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp(' Output Arrays:');

disp(' ');
disp(' Power Spectra:   vel_ps_1,   vel_ps_2,   vel_ps_3,   vel_ps_4');        
disp('                accel_ps_1, accel_ps_2, accel_ps_3, accel_ps_4');    

disp(' ');
disp('                power_dB1, power_dB2, power_dB3, power_dB4'); 
disp(' ');

assignin('base', 'vel_ps_1',ppp1);
assignin('base', 'vel_ps_2',ppp2);
assignin('base', 'vel_ps_3',ppp3);
assignin('base', 'vel_ps_4',ppp4);
 
assignin('base', 'accel_ps_1',aaa1);
assignin('base', 'accel_ps_2',aaa2); 
assignin('base', 'accel_ps_3',aaa3);
assignin('base', 'accel_ps_4',aaa4); 

assignin('base', 'accel_psd_1',psd1);
assignin('base', 'accel_psd_2',psd2);   
assignin('base', 'accel_psd_3',psd3);
assignin('base', 'accel_psd_4',psd4);     
disp(' Power Spectral Densities: accel_psd_1, accel_psd_2, accel_psd_3, accel_psd_4');
    

disp(' '); 
disp(' Velocity Response Amplification: vra_dB_1, vra_dB_2, vra_dB_3, vra_dB_4 ');
disp(' ');
assignin('base', 'vra_dB_1',broadband1);
assignin('base', 'vra_dB_2',broadband2);
assignin('base', 'vra_dB_3',broadband3);
assignin('base', 'vra_dB_4',broadband4);

    
msgbox('Results written to Command Window');



           


function change(hObject, eventdata, handles)

iu=get(handles.listbox_units,'Value');
ng=get(handles.listbox_gas,'Value');

naf=get(handles.listbox_acoustic_field,'Value');

%

if(naf==1)  % diffuse
    set(handles.text_mach,'Visible','off');
    set(handles.text_altitude,'Visible','off');
    set(handles.edit_mach,'Visible','off');
    set(handles.edit_altitude,'Visible','off');
    set(handles.edit_c,'Enable','on');   
    set(handles.edit_gas_md,'Enable','on');
    set(handles.text_ax,'Visible','off');
    set(handles.text_az,'Visible','off');
    set(handles.edit_ax,'Visible','off');
    set(handles.edit_az,'Visible','off');
    set(handles.text_Corcos,'Visible','off');
else
    set(handles.text_mach,'Visible','on');
    set(handles.text_altitude,'Visible','on');
    set(handles.edit_mach,'Visible','on');
    set(handles.edit_altitude,'Visible','on');    
    set(handles.edit_c,'Enable','off');   
    set(handles.edit_gas_md,'Enable','off');   
    set(handles.text_ax,'Visible','on');
    set(handles.text_az,'Visible','on');
    set(handles.edit_ax,'Visible','on');
    set(handles.edit_az,'Visible','on'); 
    set(handles.text_Corcos,'Visible','on');    
end


set(handles.edit_c,'String',' ');   
set(handles.edit_gas_md,'String',' ');  

%%%%%%%%%%%%%   

if(iu==1)
    
    set(handles.text_gas_c,'String','Gas Speed of Sound (ft/sec)'); 
    set(handles.text_gas_md,'String','Gas Mass Density (lbm/ft^3)');
    set(handles.text_altitude,'String','Altitude (ft)');
    
    if(ng==1 && naf==1)
        set(handles.edit_c,'String','1125');
        set(handles.edit_gas_md,'String','0.076487');       
    end
    
else
    
    set(handles.text_gas_c,'String','Gas Speed of Sound (m/sec)');
    set(handles.text_gas_md,'String','Gas Mass Density (kg/m^3)'); 
    set(handles.text_altitude,'String','Altitude (km)');
        
    if(ng==1 && naf==1)
        set(handles.edit_c,'String','343');  
        set(handles.edit_gas_md,'String','1.225');                   
    end    
    
end

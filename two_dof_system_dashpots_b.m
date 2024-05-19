function varargout = two_dof_system_dashpots_b(varargin)
% TWO_DOF_SYSTEM_DASHPOTS_B MATLAB code for two_dof_system_dashpots_b.fig
%      TWO_DOF_SYSTEM_DASHPOTS_B, by itself, creates a new TWO_DOF_SYSTEM_DASHPOTS_B or raises the existing
%      singleton*.
%
%      H = TWO_DOF_SYSTEM_DASHPOTS_B returns the handle to a new TWO_DOF_SYSTEM_DASHPOTS_B or the handle to
%      the existing singleton*.
%
%      TWO_DOF_SYSTEM_DASHPOTS_B('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TWO_DOF_SYSTEM_DASHPOTS_B.M with the given input arguments.
%
%      TWO_DOF_SYSTEM_DASHPOTS_B('Property','Value',...) creates a new TWO_DOF_SYSTEM_DASHPOTS_B or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before two_dof_system_dashpots_b_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to two_dof_system_dashpots_b_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help two_dof_system_dashpots_b

% Last Modified by GUIDE v2.5 24-Aug-2018 12:58:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @two_dof_system_dashpots_b_OpeningFcn, ...
                   'gui_OutputFcn',  @two_dof_system_dashpots_b_OutputFcn, ...
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


% --- Executes just before two_dof_system_dashpots_b is made visible.
function two_dof_system_dashpots_b_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to two_dof_system_dashpots_b (see VARARGIN)

% Choose default command line output for two_dof_system_dashpots_b
handles.output = hObject;



%%%%%%%%%%%

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
x=[-6 -6 6 6 -6];
y=[3 6 6 3 3]-3;

plot(x,y,'Color',cmap(1,:),'linewidth',0.75);
hold on;

x=[-6 -6 6 6 -6];
y=[3 6 6 3 3]+4;

plot(x,y,'Color',cmap(1,:),'linewidth',0.75);

%%%%%% side lines %%%%%%%%%%%%

x=[4 6]+2;
y=[1.5 1.5];
plot(x,y,'Color','k');


x=[4 6]+2;
y=[8.5 8.5];
plot(x,y,'Color','k');

%%%%%% text %%%%%%%%%%%%

text(9,3,'x_{1}','fontsize',11);
text(9,10,'x_{2}','fontsize',11);


text(-1,12.5,'F_{2}','fontsize',10.5);
text(-1,5.5,'F_{1}','fontsize',10.5);

text(-0.9,8.5,'m_{2}','fontsize',11);
text(-0.9,1.5,'m_{1}','fontsize',11);

text(-8,5,'k_{2}','fontsize',11);
text(-8,-2,'k_{1}','fontsize',11);

text(6,5,'c_{2}','fontsize',11);
text(6,-2,'c_{1}','fontsize',11);


%%%%%% arrows %%%%%%%%%%%%

headWidth = 4;
headLength = 4;

ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[0 3 0 1.5]);

ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[0 10 0 1.5]);
        
  
ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[8 1.5 0 1.5]);        
        
ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[8 8.5 0 1.5]);        
        

        
%%%%%% spring %%%%%%%%%%%%        

nn=2000;

dt=4/(nn-1);

t=zeros(nn,1);
for i=1:nn
    t(i)=(i-1)*dt;
end
t=t-0.75;
y=sawtooth(2*pi*t,0.5);

t=3*t/(max(t)-min(t))+2;

plot(y-3.5,t+2,'Color',cmap(5,:),'linewidth',0.75);
plot(y-3.5,t+2-7,'Color',cmap(5,:),'linewidth',0.75);



x=[0 0];
y=[3 min(t+2)];
plot(x-3.5,y,'Color',cmap(5,:),'linewidth',0.75);

x=[0 0];
y=[max(t)+2 max(t)+2.5];
plot(x-3.5,y,'Color',cmap(5,:),'linewidth',0.75);

x=[0 0];
y=[3 min(t+2)]-7;
plot(x-3.5,y,'Color',cmap(5,:),'linewidth',0.75);

x=[0 0];
y=[max(t)+2 max(t)+2.5]-7;
plot(x-3.5,y,'Color',cmap(5,:),'linewidth',0.75);

%%%%%% base %%%%%%%%%%%

x=[-6.5 6.5];
y=[ 1 1]-5;
plot(x,y,'Color','k','linewidth',0.75);
y=[0.5 1]-5;
x=[-0.7 0];
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]-1.4;
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]-2.8;
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]-4.2;
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]-4.2-1.4;
plot(x,y,'Color','k','linewidth',0.75);

x=[-0.7 0]+1.4;
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]+2.8;
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]+4.2;
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]+4.2+1.4;
plot(x,y,'Color','k','linewidth',0.75);

%%%%%% dashpot %%%%%%%%%%

x=[2.25 2.25]+1.25;
y=[2.5 4.625]-6.5;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);

x=[1.75 2.75]+1.25;
y=[4.625 4.625]-6.5;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);



x=[2.25 2.25]+1.25;
y=[5 6.5]-6.5;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);

x=[1.25 3.25]+1.25;
y=[5 5]-6.5;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);



x=[1.25 1.25]+1.25;
y=[4.6 5]-6.5;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);

x=[3.25 3.25]+1.25;
y=[4.6 5]-6.5;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);

%%%%%%

x=[2.25 2.25]+1.25;
y=[2.5 4.625]-6.5+7;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);

x=[1.75 2.75]+1.25;
y=[4.625 4.625]-6.5+7;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);



x=[2.25 2.25]+1.25;
y=[5 6.5]-6.5+7;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);

x=[1.25 3.25]+1.25;
y=[5 5]-6.5+7;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);



x=[1.25 1.25]+1.25;
y=[4.6 5]-6.5+7;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);

x=[3.25 3.25]+1.25;
y=[4.6 5]-6.5+7;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);

%%%%%% end %%%%%%%%%%%%


hold off;
grid on;
set(gca,'XTick',[], 'YTick', [])
xlim([-10 13]);
ylim([-5.5 14]);


 
units_listbox_Callback(hObject, eventdata, handles);

set(handles.pushbutton_frf,'Visible','on');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes two_dof_system_dashpots_b wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = two_dof_system_dashpots_b_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in units_listbox.
function units_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to units_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns units_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from units_listbox

n=get(handles.units_listbox,'Value');

data_s=get(handles.uitable_data,'Data');

if(n==1)
    data_s{1,2}='lbm';
    data_s{2,2}='lbm';
    data_s{3,2}='lbf sec/in'; 
    data_s{4,2}='lbf sec/in';
    data_s{5,2}='lbf/in';
    data_s{6,2}='lbf/in';      
else
    data_s{1,2}='kg';
    data_s{2,2}='kg';
    data_s{3,2}='N sec/m'; 
    data_s{4,2}='N sec/m';
    data_s{5,2}='N/m';
    data_s{6,2}='N/m';       
end

set(handles.uitable_data,'Data',data_s);


set(handles.pushbutton_frf,'Enable','off');


% --- Executes during object creation, after setting all properties.
function units_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to units_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * * * ');
disp(' ');

tpi=2*pi;

iu=get(handles.units_listbox,'value');
setappdata(0,'iu',iu);

A=char(get(handles.uitable_data,'Data'));


m1=str2num(A(1,:));
m2=str2num(A(2,:));
c1=str2num(A(3,:));
c2=str2num(A(4,:));
k1=str2num(A(5,:));
k2=str2num(A(6,:));


M=zeros(2,2);

M(1,1)=m1;
M(2,2)=m2;

K=[(k1+k2) -k2; -k2 k2];

C=[(c1+c2) -c2; -c2 c2];


disp(' ');
disp(' Mass Matrix');
disp(' ');
out1=sprintf(' %g   %g ',M(1,1),M(1,2));
out2=sprintf(' %g   %g ',M(2,1),M(2,2));
disp(out1);
disp(out2);

disp(' ');
disp(' Damping Matrix ');
disp(' ');
out1=sprintf(' %g   %g ',C(1,1),C(1,2));
out2=sprintf(' %g   %g ',C(2,1),C(2,2));
disp(out1);
disp(out2);

disp(' ');
disp(' Stiffness Matrix ');
disp(' ');
out1=sprintf(' %g   %g ',K(1,1),K(1,2));
out2=sprintf(' %g   %g ',K(2,1),K(2,2));
disp(out1);
disp(out2);



%
if(iu==1)
   M=M/386.;
end
%

Z=zeros(2,2);

clear A;
clear B;

A=[ C M ; M  Z ];
B=[ K Z ; Z -M ];

disp(' ');
disp(' A Matrix ');
disp(' ');
A


disp(' ');
disp(' B Matrix ');
disp(' ');
B


[ModeShapes,Evals]=eig(B,-A);

szz=max(size(Evals));

EEE=zeros(szz,szz+2);

for i=1:szz
    EEE(i,1)=abs(Evals(i,i));
    EEE(i,2)=Evals(i,i);    
end
EEE(:,3:szz+2)=transpose(ModeShapes);
EEE=sortrows(EEE);

Eigenvalues=EEE(:,2);
ModeShapes=transpose(EEE(:,3:szz+2));
MST=transpose(ModeShapes);


disp(' ');
disp(' Eigenvalues');
disp(' ');

for i=1:4
    v=Eigenvalues(i);
    out1=sprintf('Complex: %8.4g + %8.4gi   Mag: %8.4g rad/sec  f=%8.4g Hz',real(v),imag(v),abs(v),abs(v)/tpi);
    disp(out1);
end

disp(' ');
disp(' Mode Shapes');

ModeShapes

disp(' ');


ar=MST*A*ModeShapes;
br=MST*B*ModeShapes;

lambda=zeros(4,1);

for i=1:4
    q=-br(i,i)/ar(i,i);
    out1=sprintf(' lambda%d =   %8.4g + %8.4gi  ',i,real(q),imag(q));
    disp(out1);
    lambda(i)=q;
end

disp(' ');

assignin('base','A',A); 
assignin('base','B',B); 
assignin('base','ar',ar);
assignin('base','br',br);
assignin('base','ModeShapes',ModeShapes);
assignin('base','Eigenvalues',Eigenvalues); 

setappdata(0,'A',A);
setappdata(0,'B',B);
setappdata(0,'ar',diag(ar));
setappdata(0,'br',diag(br));
setappdata(0,'lambda',lambda);
setappdata(0,'ModeShapes',ModeShapes);
setappdata(0,'MST',MST);
setappdata(0,'Eigenvalues',Eigenvalues);


set(handles.pushbutton_frf,'Enable','on');

msgbox('Calculation complete.  Output written to Matlab Command Window.');




function mass2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to mass2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mass2_edit as text
%        str2double(get(hObject,'String')) returns contents of mass2_edit as a double


% --- Executes during object creation, after setting all properties.
function mass2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mass2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stiffness2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to stiffness2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stiffness2_edit as text
%        str2double(get(hObject,'String')) returns contents of stiffness2_edit as a double


% --- Executes during object creation, after setting all properties.
function stiffness2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stiffness2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mass1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to mass1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mass1_edit as text
%        str2double(get(hObject,'String')) returns contents of mass1_edit as a double


% --- Executes during object creation, after setting all properties.
function mass1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mass1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stiffness1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to stiffness1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stiffness1_edit as text
%        str2double(get(hObject,'String')) returns contents of stiffness1_edit as a double


% --- Executes during object creation, after setting all properties.
function stiffness1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stiffness1_edit (see GCBO)
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
delete(two_dof_system_dashpots_b);


% --- Executes on button press in pushbutton_frf.
function pushbutton_frf_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_frf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=state_space_frf;
set(handles.s,'Visible','on');   


% --- Executes on key press with focus on uitable_data and none of its controls.
function uitable_data_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to uitable_data (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pushbutton_frf,'Enable','off');


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


 
iu=get(handles.units_listbox,'Value');
two_dof_dashpots.iu=iu;

A=get(handles.uitable_data,'Data');
two_dof_dashpots.A=A;

% % %
 
structnames = fieldnames(two_dof_dashpots, '-full'); % fields in the struct
  
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);
 
    try
 
        save(elk, 'two_dof_dashpots'); 
 
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
    two_dof_dashpots=evalin('base','two_dof_dashpots');
catch
    warndlg(' evalin failed ');
    return;
end
 
two_dof_dashpots


try
    iu=two_dof_dashpots.iu;    
    set(handles.units_listbox,'Value',iu);
catch
end

units_listbox_Callback(hObject, eventdata, handles);

try
    A=two_dof_dashpots.A;     
    set(handles.uitable_data,'Data',A);   
catch
    disp('set unsuccessful')
end    

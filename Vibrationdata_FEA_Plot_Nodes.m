function varargout = Vibrationdata_FEA_Plot_Nodes(varargin)
% VIBRATIONDATA_FEA_PLOT_NODES MATLAB code for Vibrationdata_FEA_Plot_Nodes.fig
%      VIBRATIONDATA_FEA_PLOT_NODES, by itself, creates a new VIBRATIONDATA_FEA_PLOT_NODES or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_FEA_PLOT_NODES returns the handle to a new VIBRATIONDATA_FEA_PLOT_NODES or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_FEA_PLOT_NODES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_FEA_PLOT_NODES.M with the given input arguments.
%
%      VIBRATIONDATA_FEA_PLOT_NODES('Property','Value',...) creates a new VIBRATIONDATA_FEA_PLOT_NODES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Vibrationdata_FEA_Plot_Nodes_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Vibrationdata_FEA_Plot_Nodes_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Vibrationdata_FEA_Plot_Nodes

% Last Modified by GUIDE v2.5 05-Mar-2014 14:36:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Vibrationdata_FEA_Plot_Nodes_OpeningFcn, ...
                   'gui_OutputFcn',  @Vibrationdata_FEA_Plot_Nodes_OutputFcn, ...
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


% --- Executes just before Vibrationdata_FEA_Plot_Nodes is made visible.
function Vibrationdata_FEA_Plot_Nodes_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Vibrationdata_FEA_Plot_Nodes (see VARARGIN)

% Choose default command line output for Vibrationdata_FEA_Plot_Nodes
handles.output = hObject;

set(handles.Listbox_node_numbers,'Value',1);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Vibrationdata_FEA_Plot_Nodes wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Vibrationdata_FEA_Plot_Nodes_OutputFcn(hObject, eventdata, handles) 
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

delete(Vibrationdata_FEA_Plot_Nodes);


% --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ncoor=getappdata(0,'ncoor');
 
sz=size(ncoor);
 
number_nodes=sz(1);
 
noden=ncoor(:,1);
nodex=ncoor(:,2);
nodey=ncoor(:,3);
nodez=ncoor(:,4);
 
 
figure(1);
plot3(nodex,nodey,nodez,'.');
for i=1:number_nodes
   string=num2str(noden(i),'%d\n');
   text(nodex(i),nodey(i),string);
end
xlabel('X');
ylabel('Y');
zlabel('Z');
grid on;


% --- Executes on selection change in Listbox_node_numbers.
function Listbox_node_numbers_Callback(hObject, eventdata, handles)
% hObject    handle to Listbox_node_numbers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Listbox_node_numbers contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Listbox_node_numbers


% --- Executes during object creation, after setting all properties.
function Listbox_node_numbers_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Listbox_node_numbers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

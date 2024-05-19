function varargout = two_psd_synthesis_variable_phase(varargin)
% TWO_PSD_SYNTHESIS_VARIABLE_PHASE MATLAB code for two_psd_synthesis_variable_phase.fig
%      TWO_PSD_SYNTHESIS_VARIABLE_PHASE, by itself, creates a new TWO_PSD_SYNTHESIS_VARIABLE_PHASE or raises the existing
%      singleton*.
%
%      H = TWO_PSD_SYNTHESIS_VARIABLE_PHASE returns the handle to a new TWO_PSD_SYNTHESIS_VARIABLE_PHASE or the handle to
%      the existing singleton*.
%
%      TWO_PSD_SYNTHESIS_VARIABLE_PHASE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TWO_PSD_SYNTHESIS_VARIABLE_PHASE.M with the given input arguments.
%
%      TWO_PSD_SYNTHESIS_VARIABLE_PHASE('Property','Value',...) creates a new TWO_PSD_SYNTHESIS_VARIABLE_PHASE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before two_psd_synthesis_variable_phase_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to two_psd_synthesis_variable_phase_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help two_psd_synthesis_variable_phase

% Last Modified by GUIDE v2.5 08-Oct-2021 16:09:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @two_psd_synthesis_variable_phase_OpeningFcn, ...
                   'gui_OutputFcn',  @two_psd_synthesis_variable_phase_OutputFcn, ...
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


% --- Executes just before two_psd_synthesis_variable_phase is made visible.
function two_psd_synthesis_variable_phase_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to two_psd_synthesis_variable_phase (see VARARGIN)

% Choose default command line output for two_psd_synthesis_variable_phase
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes two_psd_synthesis_variable_phase wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = two_psd_synthesis_variable_phase_OutputFcn(hObject, eventdata, handles) 
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
delete(two_psd_synthesis_variable_phase);

% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
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
disp(' * * * * * * * ');
disp(' ');

fig_num=1;

try  
    FS=get(handles.edit_input_array,'String');
    psd=evalin('base',FS);  
catch
    warndlg('Input Array does not exist.  Try again.')
    return;
end

sz=size(psd);

if(sz(2)~=4)
    warndlg('Input array must have four columns');
    return;
end
     
f=psd(:,1);

sr=12*f(end);

duration=str2num(get(handles.edit_dur,'String'));

[psd_synthesis,psd_synthesis1,psd_synthesis2,~,~,~]=...
                             two_generic_psd_syn_function(duration,psd,sr);
                                         
                         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

u=get(handles.listbox1,'Value');
v=get(handles.listbox2,'Value');

% plots

t_string1='Signal 1';
t_string2='Signal 2';

if(u==1)
    ylabel1='Force (lbf)';
    r1='lbf rms';
    y_label1='Force (lbf^2/Hz)';
end
if(u==2)
    ylabel1='Moment (lbf-in)';
    r1='lbf-in rms';
    y_label1='Force ((lbf-in)^2/Hz)';    
end
if(u==3)
    ylabel1='Pressure (psi)';
    r1='psi rms';
    y_label1='Pressure (psi^2/Hz)';      
end

if(v==1)
    ylabel2='Force (lbf)';
    r2='lbf rms';
    y_label2='Force (lbf^2/Hz)';    
end
if(v==2)
    ylabel2='Moment (lbf-in)';
    r2='lbf-in rms';
    y_label2='Force ((lbf-in)^2/Hz)';     
end
if(v==3)
    ylabel2='Pressure (psi)';
    r2='psi rms';
    y_label2='Pressure (psi^2/Hz)';     
end


xlabel2='Time (sec)';
data1=psd_synthesis1;
data2=psd_synthesis2;

[fig_num]=...
    subplots_two_linlin_two_titles(fig_num,xlabel2,ylabel1,ylabel2,...
                                          data1,data2,t_string1,t_string2);

nbars=31;                                      
                                      
[fig_num]=plot_two_time_histories_histograms_alt2(fig_num,xlabel2,...
            ylabel1,ylabel2,data1,data2,t_string1,t_string2,nbars); 
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mr=1;
window=2;
A=psd_synthesis1(:,2);

df=4;
B=psd_synthesis2(:,2);

[CPSD,COH,PSD_A,PSD_B]=cpsd_ensemble_function(mr,window,duration,A,B,df);

psd_synthesis1_check=PSD_A;
psd_synthesis2_check=PSD_B;
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% plot psds

fmin=psd(1,1);
fmax=psd(end,1);

x_label='Frequency (Hz)';

ppp=[psd(:,1) psd(:,2)];
[~,rmsa] = calculate_PSD_slopes_no(ppp(:,1),ppp(:,2));
qqq=psd_synthesis1_check;
[~,rmsb] = calculate_PSD_slopes_no(qqq(:,1),qqq(:,2));
leg_a=sprintf(' Specification %7.3g %s \n',rmsa,r1);
leg_b=sprintf(' Synthesis %7.3g %s \n',rmsb,r1);

t_string='PSD  Signal 1';
y_label=y_label1;

w=log10(max(ppp(:,2)))-log10(min(ppp(:,2)));

md=ceil(w)+1;

[fig_num,h2]=...
         plot_PSD_two_h2_flimits_md(fig_num,x_label,y_label,t_string,ppp,qqq,leg_a,leg_b,fmin,fmax,md);

%%%%%%%%     
     
ppp=[psd(:,1) psd(:,3)];
[~,rmsa] = calculate_PSD_slopes_no(ppp(:,1),ppp(:,2));
qqq=psd_synthesis2_check;
[~,rmsb] = calculate_PSD_slopes_no(qqq(:,1),qqq(:,2));
leg_a=sprintf(' Specification %7.3g %s \n',rmsa,r2);
leg_b=sprintf(' Synthesis %7.3g %s \n',rmsb,r2);     
     
t_string='PSD  Signal 2';
y_label=y_label2;

w=log10(max(ppp(:,2)))-log10(min(ppp(:,2)));

md=ceil(w)+1;


[fig_num,h2]=...
         plot_PSD_two_h2_flimits_md(fig_num,x_label,y_label,t_string,ppp,qqq,leg_a,leg_b,fmin,fmax,md);

%%%%%%%%

% plot cross psd

   [~,rms] = calculate_PSD_slopes_no(CPSD(:,1),CPSD(:,2));

   t_string=sprintf('Cross Power Spectral Density %6.3g RMS Overall ',rms);      
   
   ff=CPSD(:,1);
 
   yout='Magnitude';
   
   if(u==1 && v==1)
       yout='Force (lbf^2/Hz)';
       t_string=sprintf('Cross Power Spectral Density %6.3g lbf rms Overall ',rms); 
   end
   if(u==2 && v==2)
       yout='Moment ((lbf-in)^2/Hz)';
       t_string=sprintf('Cross Power Spectral Density %6.3g lbf-in rms Overall ',rmsS); 
   end      
   if(u==3 && v==3)
       yout='Pressure (psi^2/Hz)';
       t_string=sprintf('Cross Power Spectral Density %6.3g psi rms Overall ',rms); 
   end   
   
   [fig_num]=plot_CPSD(fig_num,t_string,ff,CPSD(:,2),CPSD(:,3),COH(:,2),fmin,fmax,yout);  
%
                                      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nnn=get(handles.edit_output_name,'String');

 name=sprintf('%s_12',nnn);
name1=sprintf('%s_1',nnn);
name2=sprintf('%s_2',nnn);

assignin('base',name,psd_synthesis);
assignin('base',name1,psd_synthesis1);
assignin('base',name2,psd_synthesis2);
 
fprintf('\n Output arrays \n\n');
fprintf('   %s: time(sec) signal_1(units) signal_2(units) \n',name);
fprintf('   %s: time(sec) signal_1(units) \n',name1);
fprintf('   %s: time(sec) signal_2(units) \n\n',name2);



function edit_dur_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dur as text
%        str2double(get(hObject,'String')) returns contents of edit_dur as a double


% --- Executes during object creation, after setting all properties.
function edit_dur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_output_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_name as text
%        str2double(get(hObject,'String')) returns contents of edit_output_name as a double


% --- Executes during object creation, after setting all properties.
function edit_output_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function varargout = shock_joint(varargin)
% SHOCK_JOINT MATLAB code for shock_joint.fig
%      SHOCK_JOINT, by itself, creates a new SHOCK_JOINT or raises the existing
%      singleton*.
%
%      H = SHOCK_JOINT returns the handle to a new SHOCK_JOINT or the handle to
%      the existing singleton*.
%
%      SHOCK_JOINT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHOCK_JOINT.M with the given input arguments.
%
%      SHOCK_JOINT('Property','Value',...) creates a new SHOCK_JOINT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before shock_joint_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to shock_joint_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help shock_joint

% Last Modified by GUIDE v2.5 24-Aug-2015 15:20:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @shock_joint_OpeningFcn, ...
                   'gui_OutputFcn',  @shock_joint_OutputFcn, ...
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


% --- Executes just before shock_joint is made visible.
function shock_joint_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to shock_joint (see VARARGIN)

% Choose default command line output for shock_joint
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes shock_joint wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = shock_joint_OutputFcn(hObject, eventdata, handles) 
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

delete(shock_joint);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fig_num=100;

% amp   freq   nhs  delay

    try
        FS=get(handles.edit_wt,'String');
        wt=evalin('base',FS);
    catch
        warndlg('Input array not found');
        return; 
    end
    

      f=wt(:,2);
    amp=wt(:,3);
    nhs=wt(:,4);
     td=wt(:,5);

    sr=50*max(f);
    dt=1/sr;

    dur=0.5;
    nt=round(dur/dt);

%%

    tt=zeros(nt,1);
    Ain=zeros(nt,1);
    Atr=zeros(nt,1);
    
    clear length;
    nwaves=length(f);

    
    tend=zeros(nwaves,1);
    
    ratio=zeros(nwaves,1);
    
    new_amp=zeros(nwaves,1);
  
    beta=zeros(nt,1);
    alpha=zeros(nt,1);
  
    new_wavelet_table=zeros(nwaves,5); 

%%

    disp(' Scaling wavelets...');
    
    fc=str2num(get(handles.edit_fc,'String'));
    slope=str2num(get(handles.edit_slope,'String'));
    
    
    for i=1:nwaves
       
        [rr]=bending_joint_atten_us(f(i),fc,slope);

        beta(i)=2*pi*f(i);
        alpha(i)=beta(i)/nhs(i);
       
        
        NF=nhs(i)/(2*f(i));
        
        tend(i)=td(i)+NF;
  
       
        ratio(i)=rr;
        
        new_amp(i)=amp(i)*ratio(i);
        
        new_wavelet_table(i,:)=[ i f(i) new_amp(i) nhs(i)  td(i) ];           
             
    end
    
    setappdata(0,'new_wavelet_table',new_wavelet_table);
   

%%

    f=fix_size(f);
    ratio=fix_size(ratio);
    
    fff=[f ratio];
    fff=sortrows(fff,1);
     
    
%%
    clear ff;
    clear rr;

    oct=2^(1/6);
    ff(1)=10;
    k=1;
    while(1)
  
        [rq]=bending_joint_atten_us(ff(k),fc,slope);
        
        rr(k)=rq;
        
        if(ff(k)>12000)
            break;
        end
        
        k=k+1;
        ff(k)=ff(k-1)*oct;
    end    
%%


    
    figure(fig_num);
    fig_num=fig_num+1;
  
    
    plot(ff,rr);
    grid on;
    set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');
    xlabel('Frequency (Hz)');
    ylabel('Ratio');
    xlim([10 10000]);
    ylim([0.1 2]);
    title('Remaining Ratio ');
    
    
%%    

    for i=1:nt
    
        tt(i)=(i-1)*dt; 
        t=tt(i);    
%
%  Incident
%
        for j=1:nwaves 
    
            if(t>=td(j) && t<=tend(j))
               tq=t-td(j); 
               Ain(i)=Ain(i)+amp(j)*sin(alpha(j)*tq)*sin(beta(j)*tq);
            end 
            
        end    
% 
%  Transmitted
%
        for j=1:nwaves 
        
            if(t>=td(j) && t<= tend(j))
                tq=t-td(j);
                Atr(i)=Atr(i)+new_amp(j)*sin(alpha(j)*tq)*sin(beta(j)*tq);
            end
    
        end
%

    end
    
    disp(' ');
    disp(' Calculating shock response spectra... ');
    
    clear f;

    f(1)=10;

    damp=0.05;

    k=1;
    
    oct=2^(1/12);
    
    while(1)
   
        fnn=f(k)*oct;
    
        if(fnn>23000)
            break;
        else
            k=k+1;
            f(k)=fnn;
        end
    
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    clear srs;
    
    figure(fig_num);
    fig_num=fig_num+1;
    plot(tt,Atr);
    grid on;
    xlabel('Time (sec)');
    ylabel('Accel (G)');
        
    title('Transmitted');     
    

%%
    tt=fix_size(tt);
    Ain=fix_size(Ain);
    Atr=fix_size(Atr);
    
    figure(fig_num);
    fig_num=fig_num+1;
        subplot(2,1,1);
        plot(tt,Ain);
        grid on;
        xlabel('Time (sec)');
        ylabel('Accel (G)');
        out1=sprintf('Incident');
        title(out1);
        yLimits = get(gca,'YLim');
%
        subplot(2,1,2);
        plot(tt,Atr);
        grid on;
        xlabel('Time (sec)');
        ylabel('Accel (G)');
        ylim(yLimits);
        
        title('Transmitted'); 
 
%%%
 
    setappdata(0,'Ain',[tt Ain]);
    setappdata(0,'Atr',[tt Atr]);    
    
    [~,srs_in]=srs_function_abs(Ain,dt,damp,f);
    [~,srs_tr]=srs_function_abs(Atr,dt,damp,f);    
    
    setappdata(0,'srs_in',srs_in);
    setappdata(0,'srs_tr',srs_tr);    
    
%%%    
    
    


figure(fig_num);
    fig_num=fig_num+1;
    plot(srs_in(:,1),srs_in(:,2),srs_tr(:,1),srs_tr(:,2));
    legend ('Incident','Transmitted','location','northwest');       
    ylabel('Peak Accel (G)');
%
    Q=1/(2*damp);
    if(damp==0.05)
        Q=10;
    end
    
    xlabel('Natural Frequency (Hz)');
    out5 = sprintf(' Shock Response Spectrum Q=%g ',Q);
    title(out5);
    grid;
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
    xlim([10 10000]);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
 
    set(handles.uipanel_save,'Visible','on');
 
    scale=max(abs(Atr))/max(abs(Ain));
    out1=sprintf('\n Overall Remaining Ratio Time Domain Peaks = %8.4g',scale); 
    disp(out1);
 
%%
    
set(handles.uipanel_save,'Visible','on');




% --- Executes on selection change in listbox_save.
function listbox_save_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_save contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_save


% --- Executes during object creation, after setting all properties.
function listbox_save_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_save,'Value');

if(n==1)
   data=getappdata(0,'Ain');
end
if(n==2)
   data=getappdata(0,'srs_in');
end
if(n==3)
   data=getappdata(0,'Atr'); 
end
if(n==4)
   data=getappdata(0,'srs_tr'); 
end
if(n==5)
   data=getappdata(0,'new_wavelet_table');  
end

output_name=get(handles.edit_output_array_name,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 




function edit_wt_Callback(hObject, eventdata, handles)
% hObject    handle to edit_wt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_wt as text
%        str2double(get(hObject,'String')) returns contents of edit_wt as a double


% --- Executes during object creation, after setting all properties.
function edit_wt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_wt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fc_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fc as text
%        str2double(get(hObject,'String')) returns contents of edit_fc as a double


% --- Executes during object creation, after setting all properties.
function edit_fc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_slope_Callback(hObject, eventdata, handles)
% hObject    handle to edit_slope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_slope as text
%        str2double(get(hObject,'String')) returns contents of edit_slope as a double


% --- Executes during object creation, after setting all properties.
function edit_slope_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_slope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_fc and none of its controls.
function edit_fc_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_fc (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_slope and none of its controls.
function edit_slope_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_slope (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_save,'Visible','off');

function varargout = vibrationdata_psd_rms(varargin)
% VIBRATIONDATA_PSD_RMS MATLAB code for vibrationdata_psd_rms.fig
%      VIBRATIONDATA_PSD_RMS, by itself, creates a new VIBRATIONDATA_PSD_RMS or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_PSD_RMS returns the handle to a new VIBRATIONDATA_PSD_RMS or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_PSD_RMS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_PSD_RMS.M with the given input arguments.
%
%      VIBRATIONDATA_PSD_RMS('Property','Value',...) creates a new VIBRATIONDATA_PSD_RMS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_psd_rms_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_psd_rms_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_psd_rms

% Last Modified by GUIDE v2.5 16-Oct-2018 16:09:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_psd_rms_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_psd_rms_OutputFcn, ...
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


% --- Executes just before vibrationdata_psd_rms is made visible.
function vibrationdata_psd_rms_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_psd_rms (see VARARGIN)

% Choose default command line output for vibrationdata_psd_rms
handles.output = hObject;

set(handles.listbox_output,'Visible','off');
set(handles.text_output_metric,'Visible','off');

set(handles.listbox_method,'Value',1);


i=getappdata(0,'psd_type');
set(handles.listbox_type,'Value',i);

set(handles.listbox_add_dB,'Value',1);
set(handles.listbox_amp_unit,'Value',1);
set(handles.listbox_output,'Value',1);

set(handles.text_dB_Margin,'Visible','off');
set(handles.edit_dB,'Visible','off');

% set(handles.pushbutton_calculate,'Enable','off');

set(handles.edit_output_array,'Enable','off');
set(handles.pushbutton_save,'Enable','off');

set(handles.listbox_psave,'Value',2);

listbox_type_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_psd_rms wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_psd_rms_OutputFcn(~, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


n=get(handles.listbox_type,'Value');

if(n==1)
%    
    p=get(handles.listbox_output,'Value');
%    
    if(p==1) % accel
        data=getappdata(0,'PSD');
    end
    if(p==2) % vel
        data=getappdata(0,'vpsd');        
    end
    if(p==3) % disp
        data=getappdata(0,'dpsd');           
    end
%    
else
%
    data=getappdata(0,'PSD');
%
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


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method
% set(handles.pushbutton_calculate,'Enable','off');

n=get(hObject,'Value');

set(handles.edit_output_array,'Enable','off');

set(handles.pushbutton_save,'Enable','off');

set(handles.edit_input_array,'String',' ');

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');

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
   
   
   if(isempty(THM))
       warndlg('Ref 1:  Input Array is empty ');
       return;
   end
    
   setappdata(0,'THM',THM);
   
   set(handles.pushbutton_calculate,'Enable','on');
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


% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type

set(handles.listbox_output,'Visible','off');
set(handles.text_output_metric,'Visible','off');

n=get(handles.listbox_type,'Value');

set(handles.listbox_amp_unit, 'String','');

if(n==1)
    string_unit{1}=sprintf('G, in/sec, in'); 
    string_unit{2}=sprintf('G, cm/sec, mm');  
    string_unit{3}=sprintf('m/sec^2, cm/sec, mm'); 
    
    set(handles.listbox_output,'Visible','on');
    set(handles.text_output_metric,'Visible','on');    
end
if(n==2)
    string_unit{1}=sprintf('in/sec'); 
    string_unit{2}=sprintf('m/sec');  
    string_unit{3}=sprintf('cm/sec');    
end
if(n==3)
    string_unit{1}=sprintf('in'); 
    string_unit{2}=sprintf('m');
    string_unit{3}=sprintf('mm');    
end
if(n==4)
    string_unit{1}=sprintf('lbf'); 
    string_unit{2}=sprintf('N');
end
if(n==5 || n==6)
    string_unit{1}=sprintf('psi'); 
    string_unit{2}=sprintf('ksi');     
    string_unit{3}=sprintf('Pa');
    string_unit{4}=sprintf('KPa');    
    string_unit{5}=sprintf('MPa');    
end
if(n==7)
    string_unit{1}=sprintf('unit');
end

set(handles.listbox_amp_unit, 'String', string_unit);


% --- Executes during object creation, after setting all properties.
function listbox_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ylabel_input_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ylabel_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ylabel_input as text
%        str2double(get(hObject,'String')) returns contents of edit_ylabel_input as a double


% --- Executes during object creation, after setting all properties.
function edit_ylabel_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ylabel_input (see GCBO)
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


% --- Executes on selection change in listbox_add_dB.
function listbox_add_dB_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_add_dB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_add_dB contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_add_dB

n=get(hObject,'Value');

if(n==1)
    set(handles.text_dB_Margin,'Visible','off');
    set(handles.edit_dB,'Visible','off');
else
    set(handles.text_dB_Margin,'Visible','on');
    set(handles.edit_dB,'Visible','on');
    set(handles.edit_dB,'String','');
end


% --- Executes during object creation, after setting all properties.
function listbox_add_dB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_add_dB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmax as text
%        str2double(get(hObject,'String')) returns contents of edit_fmax as a double


% --- Executes during object creation, after setting all properties.
function edit_fmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fmin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmin as text
%        str2double(get(hObject,'String')) returns contents of edit_fmin as a double


% --- Executes during object creation, after setting all properties.
function edit_fmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dB_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dB as text
%        str2double(get(hObject,'String')) returns contents of edit_dB as a double


% --- Executes during object creation, after setting all properties.
function edit_dB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dB (see GCBO)
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
delete(vibrationdata_psd_rms)

% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (se


%%%%%%%%%%%
 
try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end    

%%%%%%%%%%%

fprintf('\n * * * * * * * \n');

psave=get(handles.listbox_psave,'Value');

k=get(handles.listbox_method,'Value');

set(handles.edit_output_array,'Enable','on');
set(handles.pushbutton_save,'Enable','on')


try
 
    if(k==1)
        FS=get(handles.edit_input_array,'String');
        THM=evalin('base',FS);   
    else
        THM=getappdata(0,'THM');
    end

catch
   
    warndlg('Input array not found');
    return;
    
end

if(isempty(THM))
    warndlg('Input array is empty');
    return; 
end

n=length(THM(:,1));

if(THM(1,1)<1.0e-04)
    THM(1,1)=1.0e-04;
end


sminf=get(handles.edit_fmin,'String');
smaxf=get(handles.edit_fmax,'String');

if isempty(sminf)
    string=sprintf('%8.4g',THM(1,1));
    set(handles.edit_fmin,'String',string);
end

if isempty(smaxf)
    string=sprintf('%8.4g',THM(n,1));    
    set(handles.edit_fmax,'String',string);
end


f=THM(:,1);
ddd=diff(f);
maxd=max(ddd);
mind=min(ddd);
ratio=(maxd-mind)/maxd;

if(ratio<0.02)
    
    fmin=str2double(get(handles.edit_fmin,'String'));
    fmax=str2double(get(handles.edit_fmax,'String'));
    
    [~,i]=min(abs(f-fmin));
    [~,j]=min(abs(f-fmax));
    
    if(i>=2 && f(i)>fmin)
        i=i-1;
    end
    
    THM=THM(i:j,:);
end


md=get(handles.listbox_add_dB,'Value');

if(md==2)
   dB=str2num(get(handles.edit_dB,'String'));
   scale=10^(dB/10);
%
   for i=1:n
       THM(i,2)=THM(i,2)*scale;
   end
%
end

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[aslope,rms] = calculate_PSD_slopes_no(THM(:,1),THM(:,2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

qrms=rms;

if(length(THM(:,1))<=60)
    
    disp(' ');

    disp('   Freq      Accel                  ');
    disp('   (Hz)     (G^2/Hz)   Slope    dB/oct');

    fprintf(' %8.4g  %8.4g \n',THM(1,1),THM(1,2));
    
    for i=2:n
        try
            dbo=10*aslope(i-1)*log10(2);
            fprintf(' %8.4g  %8.4g  %7.3g  %7.3g \n',THM(i,1),THM(i,2),aslope(i-1),dbo);
        catch
            break;
        end
    end       

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%


n=get(handles.listbox_type,'Value');

m=get(handles.listbox_amp_unit,'Value');


if(n==1)
    if(m==1)
        YS=sprintf('G');
        YSV=sprintf('in/sec');
        YSD=sprintf('in');
    end
    if(m==2)
        YS=sprintf('G'); 
        YSV=sprintf('cm/sec');
        YSD=sprintf('mm');
    end    
    if(m==3)    
        YS=sprintf('m/sec^2');
        YSV=sprintf('cm/sec');
        YSD=sprintf('mm');
    end
end
if(n==2)
    if(m==1)
        YS=sprintf('in/sec');
    end
    if(m==2)
        YS=sprintf('m/sec');
    end
    if(m==3)
        YS=sprintf('cm/sec');
    end    
end
if(n==3)
    if(m==1)
        YS=sprintf('in');
    end
    if(m==2)
        YS=sprintf('m');
    end
    if(m==3)
        YS=sprintf('mm');
    end    
end
if(n==4)
    if(m==1)
        YS=sprintf('lbf');
    end
    if(m==2)
        YS=sprintf('N');
    end    
end
if(n==5 || n==6)
    if(m==1)
        YS=sprintf('psi');
    end
    if(m==2)
        YS=sprintf('ksi');
    end
    if(m==3)
        YS=sprintf('Pa');
    end
    if(m==4)
        YS=sprintf('KPa');
    end
    if(m==5)
        YS=sprintf('MPa');
    end    
end
if(n==7)
    YS=sprintf('unit');
end

   

k = strfind(YS,'/');

if(n==1)
    out2=sprintf('Accel (%s^2/Hz)',YS);
    if( k>=1)
      out2=sprintf('Accel ((%s)^2/Hz)',YS);        
    end
end
if(n==2)
    out2=sprintf('Vel ((%s)^2/Hz)',YS);
    if( k>=1)
      out2=sprintf('Vel ((%s)^2/Hz)',YS);        
    end    
end
if(n==3)
    out2=sprintf('Disp (%s^2/Hz)',YS);
end
if(n==4)
    out2=sprintf('Force (%s^2/Hz)',YS);
end
if(n==5)
    out2=sprintf('Pressure (%s^2/Hz)',YS);
    if( k>=1)
      out2=sprintf('Pressure ((%s)^2/Hz)',YS);        
    end     
end
if(n==6)
    out2=sprintf('Stress (%s^2/Hz)',YS);
    if( k>=1)
      out2=sprintf('Stress ((%s)^2/Hz)',YS);        
    end     
end
if(n==7)
    out2=sprintf('(%s^2/Hz)',YS);
end

clear length;
f=THM(:,1);
a=THM(:,2);
nA=length(a);

dpsd=zeros(nA,2);
vpsd=zeros(nA,2);

if(n==1) % integerate to velocity & displacement
%
    set(handles.listbox_output,'Visible','on');
    set(handles.text_output_metric,'Visible','on');    
%
  omega=2*pi*f;
%
  v=zeros(nA,1);
  d=zeros(nA,1);
%      
  for i=1:nA
    v(i)=a(i)/omega(i)^2;
    d(i)=v(i)/omega(i)^2;         
  end
%
  if(f(1)<=1.0e-10)
     f(1)=[];
     v(1)=[];
     d(1)=[];          
  end
%    
  if(m==1)
      v=v*386^2;
      d=d*386^2;  
  end
  if(m==2)
      v=v*(9.81*100)^2;
      d=d*(9.81*1000)^2;       
  end
  if(m==3)
      v=v*(100)^2;
      d=d*(1000)^2;       
  end    
%
  d=fix_size(d);
  v=fix_size(v);
%
  dpsd=[f d];
  vpsd=[f v];
%
    setappdata(0,'vpsd',vpsd);
    setappdata(0,'dpsd',dpsd);
%

  

  [~,vrms]=calculate_PSD_slopes_no(f,v);
  [~,drms]=calculate_PSD_slopes_no(f,d);
%
      disp(' ');
      disp(' Overall levels ');
      disp(' ');
%
   if(m<=2)
      out12=sprintf(' Acceleration = %6.3g GRMS ',rms);
      out13=sprintf('              = %6.3g G (3-sigma) \n',3*rms);
   else
      out12=sprintf(' Acceleration = %6.3g m/sec^2 RMS ',rms);
      out13=sprintf('              = %6.3g m/sec^2 (3-sigma) \n',3*rms);       
   end    
%
   if(m==1)
      out22=sprintf('     Velocity = %6.3g in/sec RMS ',vrms);
      out23=sprintf('              = %6.3g in/sec (3-sigma) \n',3*vrms);
      out32=sprintf(' Displacement = %6.3g inch RMS ',drms);
      out33=sprintf('              = %6.3g inch (3-sigma) ',3*drms);      
   else
      out22=sprintf('     Velocity = %6.3g cm/sec RMS ',vrms);
      out23=sprintf('              = %6.3g cm/sec (3-sigma) \n',3*vrms);
      out32=sprintf(' Displacement = %6.3g mm RMS ',drms);
      out33=sprintf('              = %6.3g mm (3-sigma) ',3*drms);       
   end    
%
      disp(out12);
      disp(out13);
      disp(out22);
      disp(out23);   
      disp(out32);
      disp(out33);    
%
else
    fprintf('\n Power Spectral Density \n \n %6.3g %sRMS Overall \n',qrms,YS);
end    

fig_num=1;
xlab='Frequency (Hz)';

try
    fmin=str2num(get(handles.edit_fmin,'String'));
catch
    fmin=f(1); 
end

try
    fmax=str2num(get(handles.edit_fmax,'String'));
catch
    fmax=f(end);
end
    
power_spectral_density=THM;

setappdata(0,'PSD',power_spectral_density);

[crms]=cumulative_rms(power_spectral_density);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(n==1 && m<=2)
    ylab=sprintf('%sRMS',YS);    
else
    ylab=sprintf('%s RMS',YS);    
end 

t_string=...
    sprintf(' Cumulative RMS'); 
[fig_num]=plot_cumulative_RMS(fig_num,xlab,ylab,t_string,crms,fmin,fmax);


if(n==1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    ylab=sprintf('Disp (%s^2/Hz)',YSD);

    t_string=sprintf('Displacement Power Spectral Density %6.3g %s RMS Overall ',drms,YSD);    
    [fig_num,h]=plot_PSD_function(fig_num,xlab,ylab,t_string,dpsd,fmin,fmax);

    if(psave==1)
        
        disp(' ');
        disp(' Plot files');
        disp(' ');
    
        pname='displacement_psd';
        
        out1=sprintf('   %s.png',pname);
        disp(out1);
    
        set(gca,'Fontsize',12);
        print(h,pname,'-dpng','-r300');
    
    end        
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    ylab=sprintf('Vel ((%s)^2/Hz)',YSV);

    t_string=sprintf('Velocity Power Spectral Density %6.3g %s RMS Overall ',vrms,YSV);    
    [fig_num,h]=plot_PSD_function(fig_num,xlab,ylab,t_string,vpsd,fmin,fmax);
   
    if(psave==1)
    
        pname='velocity_psd'; 
    
        out1=sprintf('   %s.png',pname);
        disp(out1);        
        
        set(gca,'Fontsize',12);
        print(h,pname,'-dpng','-r300');
    
    end    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    ylab=out2;
    if(n==1 && m<=2)
        t_string=sprintf('Acceleration Power Spectral Density %6.3g %sRMS Overall ',qrms,YS);    
    else
        t_string=sprintf('Acceleration Power Spectral Density %6.3g %s RMS Overall ',qrms,YS);    
    end 
    [fig_num,h]=plot_PSD_function(fig_num,xlab,ylab,t_string,power_spectral_density,fmin,fmax);

else
   
    ylab=out2;
    t_string=sprintf('Power Spectral Density %6.3g %s RMS Overall ',qrms,YS);    
    [fig_num,h]=plot_PSD_function(fig_num,xlab,ylab,t_string,power_spectral_density,fmin,fmax);
    
end

if(psave==1)
    
    pname='accel_psd';
    
    out1=sprintf('   %s.png',pname);
    disp(out1);
    
    set(gca,'Fontsize',12);
    print(h,pname,'-dpng','-r300');
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f=THM(:,1);
a=THM(:,2);
%

if(f(1)<0.001)
    f(1)=0.001;
end

df=0.2;

[s,~]=calculate_PSD_slopes_no(f,a);

[fi,ai]=interpolate_PSD(f,a,s,df);

[~,ii]=min(abs(fi-fmin));
[~,jj]=min(abs(fi-fmax));

fi=fi(ii:jj);
ai=ai(ii:jj);

[EP,vo,m0,m1,m2,m4,alpha2,e]=spectal_moments_alt(fi,ai,df);

disp(' Spectral Moments');
disp(' ');

fprintf(' m0=%8.4g \t m1=%8.4g \t m2=%8.4g  \t m4=%8.4g \n\n',m0,m1,m2,m4);

fprintf(' alpha2=%8.4g \t e=%8.4g spectral width \n\n',alpha2,e);

fprintf(' Rate of Up-zero crossings = %7.4g Hz \n',vo);
fprintf('             Rate of peaks = %7.4g Hz \n\n',EP);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
   set(handles.pushbutton_calculate,'Enable','on');


% --- Executes on selection change in listbox_amp_unit.
function listbox_amp_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_amp_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_amp_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_amp_unit


% --- Executes during object creation, after setting all properties.
function listbox_amp_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_amp_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

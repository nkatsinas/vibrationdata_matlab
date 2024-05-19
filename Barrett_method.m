function varargout = Barrett_method(varargin)
% BARRETT_METHOD MATLAB code for Barrett_method.fig
%      BARRETT_METHOD, by itself, creates a new BARRETT_METHOD or raises the existing
%      singleton*.
%
%      H = BARRETT_METHOD returns the handle to a new BARRETT_METHOD or the handle to
%      the existing singleton*.
%
%      BARRETT_METHOD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BARRETT_METHOD.M with the given input arguments.
%
%      BARRETT_METHOD('Property','Value',...) creates a new BARRETT_METHOD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Barrett_method_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Barrett_method_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Barrett_method

% Last Modified by GUIDE v2.5 08-Oct-2019 16:51:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Barrett_method_OpeningFcn, ...
                   'gui_OutputFcn',  @Barrett_method_OutputFcn, ...
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


% --- Executes just before Barrett_method is made visible.
function Barrett_method_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Barrett_method (see VARARGIN)

% Choose default command line output for Barrett_method
handles.output = hObject;

set(handles.uipanel_save,'Visible','on');

listbox_add_mass_Callback(hObject, eventdata, handles);
listbox_diam_Callback(hObject, eventdata, handles);

listbox_num_curves_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Barrett_method wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Barrett_method_OutputFcn(hObject, eventdata, handles) 
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

delete(Barrett_method);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%

fig_num=1;


Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end

try
    A_legend=char(get(handles.uitable_legend,'Data'));
    szA=size(A_legend);
catch
    warndlg('Enter legend');
    return;
end

if(isempty(A_legend))
    warndlg('Enter legend');
    return;    
end
    

Mr=str2num(get(handles.edit_reference_mass,'String'));
Mn=str2num(get(handles.edit_new_mass,'String'));

nmr=get(handles.listbox_mass_type,'Value');
nam=get(handles.listbox_add_mass,'Value');
W=str2num(get(handles.edit_W,'String'));
Wc=str2num(get(handles.edit_Wc,'String')); 

M_ratio=Mr/Mn;


try
    FS1=strtrim(get(handles.edit_ref_spl,'String'));
    SPL_ref=evalin('base',FS1);  
catch
    warndlg('Reference SPL array not find ');
    return; 
end

try
    FS2=strtrim(get(handles.edit_new_spl,'String'));
    SPL_new=evalin('base',FS2);  
catch
    warndlg('New SPL array not find ');
    return;     
end

try
    FS3=strtrim(get(handles.edit_ref_psd,'String'));
    PSD_ref=evalin('base',FS3);  
catch
    warndlg('Reference PSD array not find ');
    return;       
end

szr=size(SPL_ref);


szn=size(SPL_new);
ncols=szn(2)-1;   


if(ncols~=szA(1))
    out1=sprintf('Number of New SPL Curves=%d  Fix legend',ncols);
    warndlg(out1);
    return;
end

%%%%%%%%%%%%%%%%%%

if(szr(2)~=2)
    warndlg('Input Reference SPL array must have two columns');
    return;
end
if(szn(2)<2)
    warndlg('Input New SPL array must have at least two columns');
    return;
end

%%%%%%%%%%%%%%%%%%%%%%

ppp=PSD_ref;

[~,grms] = calculate_PSD_slopes(ppp(:,1),ppp(:,2));

t_string=sprintf('Reference Power Spectral Density  %7.3g GRMS',grms);

md=6;

fmin=ppp(1,1);
fmax=max(ppp(:,1));

x_label='Frequency (Hz)';
y_label='Accel (G^2/Hz)';

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

%%%%%%%%%%%%%%%%%%


ppp1=SPL_ref;
[oadb1]=oaspl_function(ppp1(:,2));



for j=2:szn(2)
    
%%%%%%%%%%%%%%%%%%%%%%

    Lr=szr(1);

    [fc,~,ratio2,LL]=Barrett_ratio(SPL_ref,[SPL_new(:,1) SPL_new(:,j)],Lr);
    
    disp('ref 99')
    fc(1)
    fc(end)

    [fl,fu,imax]=Barrett_set_limits(fc);

    npsd=get(handles.listbox_psd_type,'Value');


    if(npsd==1) % already one-third octave

        PSD_ref_one_third=PSD_ref;
        [PSDn]=Barrett_PSD_new_alr(LL,fc,ratio2,M_ratio,nmr,nam,W,Wc,PSD_ref_one_third);
        PSD_new(:,1)=PSDn(:,1);
        PSD_new(:,j)=PSDn(:,2);        
        ppp1=PSD_ref;
    end

    if(npsd==2) % narrowband, convert to one-third octave
    
        X=PSD_ref(:,1);
    
        X=diff(X);
    
        R=(max(X)-mean(X))/mean(X);
    
        if( R<0.05)
    
            [PSD_ref_one_third,ff,ossum]=Barrett_count(fl,fc,fu,PSD_ref,imax);
            [PSDn]=Barrett_PSD_new(LL,fc,ff,ratio2,M_ratio,nmr,nam,ossum,W,Wc);
            
            PSD_new(:,1)=PSDn(:,1);
            PSD_new(:,j)=PSDn(:,2);   
            
            ppp1=PSD_ref_one_third;
       
        else
        
            warndlg(' Frequency spacing is not narrowband '); 
            return; 
        end
            
    end

    if(npsd==3) % narrowband, leave as is
    
        [PSDn,ppp1]=Barrett_narrowband(PSD_ref,ratio2,M_ratio,W,Wc,nmr,nam,fc);     
        
        PSD_new(:,1)=PSDn(:,1);
        PSD_new(:,j)=PSDn(:,2);   
        
    end
    
    if(npsd==4) % specification, convert to one-third octave    
 
        disp('**');
        
        ff=PSD_ref(:,1);
        aa=PSD_ref(:,2);
 
        df=1;
        fmin=ff(1);
        fmax=ff(end);
 
 
        [~,ii]=min(abs(ff-fmin));
        [~,jj]=min(abs(ff-fmax));

        f=ff(ii:jj);
        a=aa(ii:jj);

        s=1;
 
        [fi,ai] = interpolate_log(f,a,s,df);
 
        
        fi=fix_size(fi);
        ai=fix_size(ai);
 
        PSD_ref=[fi ai];
        
        PSD_ref(1,1)
        PSD_ref(end,1)
        
        disp('fc')
        fc(1)
        fc(end)

        [PSD_ref_one_third,ff,ossum]=Barrett_count(fl,fc,fu,PSD_ref,imax);
        
          disp('ff')
        ff(1)
        ff(end)
        
        
        [PSDn]=Barrett_PSD_new(LL,fc,ff,ratio2,M_ratio,nmr,nam,ossum,W,Wc);
            
        PSD_new(:,1)=PSDn(:,1);
        PSD_new(:,j)=PSDn(:,2);   
            
        ppp1=PSD_ref_one_third;  
        

    end   
    
end

%%%%%%%%%%%

n=get(handles.listbox_diam,'Value');

if(n==2)

    diam_refer=str2num(get(handles.edit_diam_refer,'String'));
    diam_new=str2num(get(handles.edit_diam_new,'String'));

    dratio=(diam_refer/diam_new);

    try

        PSD_new(:,1)=PSD_new(:,1)*dratio;

    catch
    
        dratio
    
        size(PSD_new)
    
        warndlg('Error at dratio step');
        return;
    
    end
end

%%%%%%%%%%%

[~,grms_ref] = calculate_PSD_slopes(ppp1(:,1),ppp1(:,2));


for j=2:szn(2)    % keep after frequency shift
        
    [oadb2]=oaspl_function(SPL_new(:,j));
    
    leg_spl{j-1}=sprintf('%s  oaspl %7.4g dB',A_legend(j-1,:),oadb2);
    
    [~,grms_new] = calculate_PSD_slopes(PSD_new(:,1),PSD_new(:,j));
    leg_psd{j-1}=sprintf('%s  %7.3g GRMS',A_legend(j-1,:),grms_new);    
    
end    


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n_type=1;  

if(ncols==1)
   
    leg1=sprintf('New');
    leg2=sprintf('Ref');
           
    [fig_num]=spl_plot_two(fig_num,n_type,SPL_new(:,1),SPL_new(:,2),SPL_ref(:,1),SPL_ref(:,2),leg1,leg2);           
    
else
    
    tstring='Reference';
    
    [fig_num]=spl_plot_title(fig_num,n_type,SPL_ref(:,1),SPL_ref(:,2),tstring);  
    
    t_string=sprintf(' New One-Third Ocative Sound Pressure Level  \n Zero dB Ref = 20 micro Pa');
    
    [fig_num]=spl_plot_all(fig_num,t_string,SPL_new,leg_spl);
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


sz=size(PSD_new);

PSD_max=zeros(sz(1),2);
PSD_max(:,1)=PSD_new(:,1);
 
for i=1:sz(1)
    PSD_max(i,2)=max(PSD_new(i,2:sz(2)));
end


if(ncols==1)
    
    md=6;    
    fmin=fc(1);
    fmax=PSD_max(end,1);

    x_label='Frequency (Hz)';
    y_label='Accel (G^2/Hz)';

    leg1=sprintf('New %7.3g GRMS',grms_new);
    leg2=sprintf('Ref %7.3g GRMS',grms_ref);

    t_string='Power Spectral Density, Barrett, One-Third Octave';

    if(npsd==3)
        t_string='Power Spectral Density, Barrett, Narrowband';
    end


    [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,PSD_new,PSD_ref,leg1,leg2,fmin,fmax,md);

else
    
    x_label='Frequency (Hz)';
    y_label='Accel (G^2/Hz)';
    
    leg=leg_psd;
    
    t_string=sprintf('Power Spectral Density  Barrett');
    [fig_num]=plot_loglog_multiple_function(fig_num,x_label,y_label,t_string,PSD_new,leg,fmin,fmax);
 
end


if(ncols>=2)
    f=PSD_max(:,1);
    a=PSD_max(:,2);
    [~,grms] = calculate_PSD_slopes(f,a);
    
    x_label='Frequency (Hz)';
    y_label='Accel (G^2/Hz)';
    
    t_string=sprintf('PSD  Barrett Maximum Envelope  %7.3g GRMS',grms);
    
    md=6;
    
    ppp=PSD_max;
    
    [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);    
    
end    


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear f;
clear a;

f=PSD_new(:,1);
a=PSD_new(:,2);

nA=length(f);

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
      v=v*386^2;
      d=d*386^2;    
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
  [~,grms]=calculate_PSD_slopes(f,a);
  [~,vrms]=calculate_PSD_slopes(f,v);
  [~,drms]=calculate_PSD_slopes(f,d);
%
%%%



disp(' ');
disp(' Format:  %9.5g '); 
disp(' ');

for i=1:sz(1)
    out1=sprintf(' %9.5g \t %9.5g ',f(i),a(i));
    disp(out1); 
end




%%%
      disp(' ');
      disp(' Overall levels ');
      disp(' ');
%

      out12=sprintf(' Acceleration = %6.3g GRMS ',grms);
      out13=sprintf('              = %6.3g G (3-sigma) \n',3*grms);
 

      out22=sprintf('     Velocity = %6.3g in/sec RMS ',vrms);
      out23=sprintf('              = %6.3g in/sec (3-sigma) \n',3*vrms);
      out32=sprintf(' Displacement = %6.3g inch RMS ',drms);
      out33=sprintf('              = %6.3g inch (3-sigma) ',3*drms);      
   
%
      disp(out12);
      disp(out13);
      disp(out22);
      disp(out23);   
      disp(out32);
      disp(out33);   
%      
      disp(' '); 
%

data=getappdata(0,'PSD_new');

output_name1=strtrim(get(handles.edit_output_array,'String'));
set(handles.edit_output_array,'String',output_name1);

out1=sprintf('\n Output file: \n   %s \n',output_name1);
disp(out1);

try
    assignin('base', output_name1, [f a]);
catch
    disp(' no output_name1 ');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
           
setappdata(0,'PSD_new',PSD_new);
setappdata(0,'PSD_max',PSD_max);
           
set(handles.uipanel_save,'Visible','on');

pushbutton_save_model_Callback(hObject, eventdata, handles);




function edit_ref_spl_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ref_spl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ref_spl as text
%        str2double(get(hObject,'String')) returns contents of edit_ref_spl as a double


% --- Executes during object creation, after setting all properties.
function edit_ref_spl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ref_spl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_new_spl_Callback(hObject, eventdata, handles)
% hObject    handle to edit_new_spl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_new_spl as text
%        str2double(get(hObject,'String')) returns contents of edit_new_spl as a double


% --- Executes during object creation, after setting all properties.
function edit_new_spl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_new_spl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ref_psd_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ref_psd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ref_psd as text
%        str2double(get(hObject,'String')) returns contents of edit_ref_psd as a double


% --- Executes during object creation, after setting all properties.
function edit_ref_psd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ref_psd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_new_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_new_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_new_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_new_mass as a double


% --- Executes during object creation, after setting all properties.
function edit_new_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_new_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_reference_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_reference_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_reference_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_reference_mass as a double


% --- Executes during object creation, after setting all properties.
function edit_reference_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_reference_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_eq.
function pushbutton_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

     A = imread('Barrett_equation.jpg');
     figure(990) 
     imshow(A,'border','tight','InitialMagnification',100) 



% --- Executes on selection change in listbox_mass_type.
function listbox_mass_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_mass_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_mass_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_mass_type
set(handles.uipanel_save,'Visible','on');

% --- Executes during object creation, after setting all properties.
function listbox_mass_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_mass_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_ref_spl and none of its controls.
function edit_ref_spl_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_ref_spl (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','on');


% --- Executes on key press with focus on edit_new_spl and none of its controls.
function edit_new_spl_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_new_spl (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','on');


% --- Executes on key press with focus on edit_ref_psd and none of its controls.
function edit_ref_psd_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_ref_psd (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','on');


% --- Executes on key press with focus on edit_reference_mass and none of its controls.
function edit_reference_mass_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_reference_mass (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','on');


% --- Executes on key press with focus on edit_new_mass and none of its controls.
function edit_new_mass_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_new_mass (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','on');



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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



data_max=getappdata(0,'PSD_max');

output_name_max=sprintf('%s_max',output_name);
assignin('base', output_name_max, data_max);




h = msgbox('Save Complete'); 


% --- Executes on selection change in listbox_add_mass.
function listbox_add_mass_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_add_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_add_mass contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_add_mass

n=get(handles.listbox_add_mass,'Value');

set(handles.text_W,'Visible','off');
set(handles.edit_W,'Visible','off');
set(handles.text_Wc,'Visible','off');
set(handles.edit_Wc,'Visible','off');
set(handles.text_ame1,'Visible','off');
set(handles.text_ame2,'Visible','off');

set(handles.listbox_add_mass,'Visible','on');

if(n==2 || n==3)

    set(handles.text_W,'Visible','on');
    set(handles.edit_W,'Visible','on');
    set(handles.text_Wc,'Visible','on');
    set(handles.edit_Wc,'Visible','on');    
    set(handles.text_ame1,'Visible','on');
    set(handles.text_ame2,'Visible','on');
end


set(handles.uipanel_save,'Visible','on');

% --- Executes during object creation, after setting all properties.
function listbox_add_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_add_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Wc_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Wc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Wc as text
%        str2double(get(hObject,'String')) returns contents of edit_Wc as a double


% --- Executes during object creation, after setting all properties.
function edit_Wc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Wc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_W_Callback(hObject, eventdata, handles)
% hObject    handle to edit_W (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_W as text
%        str2double(get(hObject,'String')) returns contents of edit_W as a double


% --- Executes during object creation, after setting all properties.
function edit_W_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_W (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_W and none of its controls.
function edit_W_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_W (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','on');


% --- Executes on key press with focus on edit_Wc and none of its controls.
function edit_Wc_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Wc (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','on');


% --- Executes on selection change in listbox_psd_type.
function listbox_psd_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_psd_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_psd_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_psd_type


% --- Executes during object creation, after setting all properties.
function listbox_psd_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_psd_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function[fc,ratio,ratio2,LL]=Barrett_ratio(SPL_ref,SPL_new,Lr)

disp('Barrett ratio')

k=1;

SPL_ref(1,1)
SPL_new(1,1)

SPL_ref(end,1)
SPL_new(end,1)


for i=1:Lr
    
        freq=SPL_ref(i,1);
        
        [~,inx] = min(abs(freq-SPL_new(:,1)));
        
        fx=SPL_new(inx,1);
        
        fg=abs(log(freq/fx)/log(2));
        
        if( fg < 1/12 )
            
        
            dB_diff=SPL_new(inx,2)-SPL_ref(i,2);
        
            fc(k)=freq;
             ratio(k)=10^(dB_diff/20);
            ratio2(k)=ratio(k)^2;
                    
            out1=sprintf('i=%d  fc=%8.4g  ratio=%8.4g ',i,fc(k),ratio(k));
            disp(out1);            
        
            k=k+1;
            
        end
    
end

LL=length(ratio);


function[fl,fu,imax]=Barrett_set_limits(fc)

%%


oex=1/6;

imax=length(fc);


%
disp(' ');
disp(' set limits... ');
%
fl=zeros(imax,1);
fu=zeros(imax,1);

for i=1:imax
    fl(i)=fc(i)/(2.^oex);
end

for i=1:(imax-1)
    fu(i)=fl(i+1);	
end

fu(imax)=fc(i)*(2.^oex);
%


function[PSD_ref_one_third,ff,ossum]=Barrett_count(fl,fc,fu,PSD_ref,imax)



disp(' ');
disp('  counts...');

ssum=zeros(imax,1);
count=zeros(imax,1);

f=PSD_ref(:,1);
amp=PSD_ref(:,2);

%% 

for k=1:length(f)

    for i=1:imax
		
        if( f(k)>= fl(i) && f(k) <= fu(i))

				ssum(i)=ssum(i)+ amp(k);
				count(i)=count(i)+1;
                
                break;
        end        
    end
end



disp(' ');
disp('  calculate output data...');

clear length; 
    
ijk=1;

f_max=max(f);

    
for i=1:(length(count))

    
    iflag=0;
        
    if( fl(i) > f_max)
        
%        out1=sprintf(' fl(i)=%8.4g  f(LL)=%8.4g',fl(i),f(LL));
%        disp(out1);
        
        break;
    end
         
    if(iflag==0)
        if(count(i)>=1)
            iflag=1;
        end
    end
    
    if( iflag==1 && ssum(i) > 1.0e-20)
		
        ossum(ijk)=ssum(i)/count(i);
        ff(ijk)=fc(i);
        ijk=ijk+1;
 
    end
    
%    out1=sprintf(' i=%d  iflag=%d  ',i,iflag);
%    disp(out1);
        
end

ff=fix_size(ff);
ossum=fix_size(ossum);

PSD_ref_one_third=[ff ossum];

%% count




function[PSD_new]=Barrett_PSD_new(LL,fc,ff,ratio2,M_ratio,nmr,nam,ossum,W,Wc)

if(nmr==1)
    R=(ratio2)*M_ratio;
else
    R=(ratio2)*M_ratio^2;    
end



fmax=ff(end);

if(fc(end)>fmax) 
    [~,LL]=min(abs(ff-fmax));
end 



%% PSD_new=zeros(LL,2);
%% PSD_new(:,1)=fc(1:LL);

%% for i=1:LL
%%    [~,idx]=min(abs(fc(i)-ff));
%%    psd_r=ossum(idx);
%%    PSD_new(i,2)=R(i)*psd_r;    
%% end

disp(' ref 1');
ff(end)

LL=length(ossum);

PSD_new=zeros(LL,2);
PSD_new(:,1)=ff(1:LL);

for i=1:LL
    [~,idx]=min(abs(fc-ff(i)));  
    psd_r=ossum(i);
    PSD_new(i,2)=R(idx)*psd_r;
end

%%

if(nam==2)
    F=W/(W+Wc);
    PSD_new(:,2)=PSD_new(:,2)*F;    
end
if(nam==3)
    F=W/Wc;
    PSD_new(:,2)=PSD_new(:,2)*F;    
end

out1=sprintf('\n M_ratio=%7.3g \n',M_ratio);
disp(out1);

%%%

function[PSD_new]=Barrett_PSD_new_alr(LL,fc,ratio2,M_ratio,nmr,nam,W,Wc,PSD_ref_one_third)


if(nmr==1)
    R=(ratio2)*M_ratio;
else
    R=(ratio2)*M_ratio^2;    
end


PSD_new=zeros(LL,2);
PSD_new(:,1)=fc;

ff=PSD_ref_one_third(:,1);

ff_min=ff(1);
ff_max=ff(length(ff));

for i=1:LL
    
    if(fc(i)>=ff_min && fc(i)<=ff_max)
    
        [~,idx]=min(abs(fc(i)-ff));
        
        psd_r=PSD_ref_one_third(idx,2);
    
        PSD_new(i,2)=R(i)*psd_r;    
    
    end

end

for i=LL:-1:1
 
    if(PSD_new(i,2)==0)
        PSD_new(i,:)=[];
    end
    
end


if(nam==2)
    F=W/(W+Wc);
    PSD_new(:,2)=PSD_new(:,2)*F;    
end
if(nam==3)
    F=W/Wc;
    PSD_new(:,2)=PSD_new(:,2)*F;    
end

out1=sprintf('\n M_ratio=%7.3g \n',M_ratio);
disp(out1);

%%%

function[PSD_new,ppp1]=Barrett_narrowband(PSD_ref,ratio2,M_ratio,W,Wc,nmr,nam,fc)

    ppp1=PSD_ref;

    m=length(PSD_ref(:,1));
    
    PSD_new=zeros(m,1);
    
    PSD_new(:,1)=PSD_ref(:,1);
  
    
    
    if(nmr==1)
        R=(ratio2)*M_ratio;
    else
        R=(ratio2)*M_ratio^2;    
    end
    
    
    for i=1:m
       
        ff=PSD_ref(i,1);
        
        [~,idx]=min(abs(fc-ff));
    
        PSD_new(i,2)=R(idx)*PSD_ref(i,2);
        
    end


    if(nam==2)
        F=W/(W+Wc);
        PSD_new(:,2)=PSD_new(:,2)*F;    
    end
    if(nam==3)
        F=W/Wc;
        PSD_new(:,2)=PSD_new(:,2)*F;    
    end    

    out1=sprintf('\n M_ratio=%7.3g \n',M_ratio);
    disp(out1);
    
    
    


% --- Executes on button press in pushbutton_save_model.
function pushbutton_save_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




FS_ref_spl=get(handles.edit_ref_spl,'String');
Barrett.FS_ref_spl=FS_ref_spl;
 
FS_new_spl=get(handles.edit_new_spl,'String');
Barrett.FS_new_spl=FS_new_spl;

FS_ref_psd=get(handles.edit_ref_psd,'String');
Barrett.FS_ref_psd=FS_ref_psd;

try
    output_array=get(handles.edit_output_array,'String');
    Barrett.output_array=output_array;
catch
end


try
    output_array=get(handles.edit_save_array_name,'String');
    Barrett.save_array_name=save_array_name;
catch
end




try
    THM_ref_spl=evalin('base',FS_ref_spl);
    Barrett.THM_ref_spl=THM_ref_spl;
catch
end

try
    THM_new_spl=evalin('base',FS_new_spl);
    Barrett.THM_new_spl=THM_new_spl;
catch
end

try
    THM_ref_psd=evalin('base',FS_ref_psd);
    Barrett.THM_ref_psd=THM_ref_psd;
catch
end


 W=str2num(get(handles.edit_W,'String'));
Wc=str2num(get(handles.edit_Wc,'String'));

reference_mass=str2num(get(handles.edit_reference_mass,'String'));
      new_mass=str2num(get(handles.edit_new_mass,'String'));

      
Barrett.W=W;
Barrett.Wc=Wc;

Barrett.reference_mass=reference_mass;
Barrett.new_mass=new_mass;


psd_type=get(handles.listbox_psd_type,'Value');
add_mass=get(handles.listbox_add_mass,'Value');
mass_type=get(handles.listbox_mass_type,'Value');

Barrett.psd_type=psd_type;
Barrett.add_mass=add_mass;
Barrett.mass_type=mass_type;
  

listbox_diam=get(handles.listbox_diam,'Value');
diam_refer=str2num(get(handles.edit_diam_refer,'String'));
diam_new=str2num(get(handles.edit_diam_new,'String'));

Barrett.listbox_diam=listbox_diam;
Barrett.diam_refer=diam_refer;
Barrett.diam_new=diam_new;

num_curves=get(handles.listbox_num_curves,'Value');
Barrett.num_curves=num_curves;

A_legend=get(handles.uitable_legend,'Data');
Barrett.A_legend=A_legend;

 
% % %
 
structnames = fieldnames(Barrett, '-full'); % fields in the struct
  
% % %
 
try
    save_array_name=get(handles.edit_save_array_name,'String');
    Barrett.save_array_name=save_array_name; 
catch 
    warndlg('Enter save array name');
    return;
end
 
if(isempty(save_array_name))
    warndlg('Enter save array name');
    return;    
end

    
name=save_array_name;
 
name=strrep(name,'.mat','');
name=strrep(name,'_model',''); 
name2=sprintf('%s_model',name);
name=sprintf('%s_model.mat',name);
 
try
    save(name, 'Barrett'); 
catch
    warndlg('Save error');
    return;
end
 
out1=sprintf('Save Complete: %s',name);
disp(out1);
msgbox(out1);

%%%@@@@@

%%    disp('**ref b**');
    
  
    
    try
        filename = 'Barrett_method_load_list.txt';
        THM=importdata(filename);
        
 %        THM
        

    catch
         THM=[];
         disp('no read 1');       
    end
    
    [THM,nrows]=THM_save(THM,name2);
    
    fileID = fopen(filename,'w');

    for row = 1:nrows
        fprintf(fileID,'%s\n',THM{row,:});
        char(THM{row,:});
    end
    fclose(fileID);
    
    
%%%@@@@@
    
    
out1=sprintf('Save Complete: %s',name);
msgbox(out1);



function pushbutton_load_modal_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    [filename, pathname] = uigetfile('*.mat');

    setappdata(0,'filename',filename);
    setappdata(0,'pathname',pathname);
 
    load_core(hObject, eventdata, handles)

catch
end
    

function load_core(hObject, eventdata, handles)

disp('*** ref 1 ***');

filename=strtrim(getappdata(0,'filename'))
% pathname=getappdata(0,'pathname')

try
%    NAME = [pathname,filename];
    NAME=filename;
    struct=load(NAME);
catch    
    NAME
    warndlg('load failed');
    return;
end



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
    Barrett=evalin('base','Barrett');
catch
    warndlg(' evalin failed ');
    return;
end
 
Barrett
 
%

try
    save_array_name=Barrett.save_array_name;    
    set(handles.edit_save_array_name,'String',save_array_name);
catch
end



try
    output_array=Barrett.output_array;    
    set(handles.edit_output_array,'String',output_array);
catch
end


try
    FS_ref_spl=Barrett.FS_ref_spl;    
    set(handles.edit_ref_spl,'String',FS_ref_spl);
    
    iflag=0;
    
    try
        temp=evalin('base',FS_ref_spl);
        ss=sprintf('Replace %s with Previously Saved Array',FS_ref_spl);
        answer = questdlg(ss,'Array Overwrite','Yes','No','No');
 
        switch answer
            case 'Yes'
                iflag=0;
            case 'No'
                iflag=1;
        end    
    catch 
    end 
    
    if(iflag==0)
        try
            THM_ref_spl=Barrett.THM_ref_spl;    
            assignin('base',FS_ref_spl,THM_ref_spl); 
        catch
        end    
    end      
    
catch
end

%

try
    FS_new_spl=Barrett.FS_new_spl;    
    set(handles.edit_new_spl,'String',FS_new_spl);
    
    iflag=0;
    
    try
        temp=evalin('base',FS_new_spl);
        ss=sprintf('Replace %s with Previously Saved Array',FS_new_spl);
        answer = questdlg(ss,'Array Overwrite','Yes','No','No');
 
        switch answer
            case 'Yes'
                iflag=0;
            case 'No'
                iflag=1;
        end    
    catch 
    end
    
    if(iflag==0)
        try
            THM_new_spl=Barrett.THM_new_spl;    
            assignin('base',FS_new_spl,THM_new_spl); 
        catch
        end    
    end    
    
catch
end

%

try
    FS_ref_psd=Barrett.FS_ref_psd;    
    set(handles.edit_ref_psd,'String',FS_ref_psd);
 
    iflag=0;
    
    try
        temp=evalin('base',FS_ref_psd);
        ss=sprintf('Replace %s with Previously Saved Array',FS_ref_psd);
        answer = questdlg(ss,'Array Overwrite','Yes','No','No');
 
        switch answer
            case 'Yes'
                iflag=0;
            case 'No'
                iflag=1;
        end    
    catch 
    end
    
    if(iflag==0)
        try
            THM_ref_psd=Barrett.THM_ref_psd;    
            assignin('base',FS_ref_psd,THM_ref_psd); 
        catch
        end
    end
       
catch
end

%

try
    W=Barrett.W;
    ss=sprintf('%g',W);
    set(handles.edit_W,'String',ss);
catch
end

try
    Wc=Barrett.Wc; 
    ss=sprintf('%g',Wc);    
    set(handles.edit_Wc,'String',ss);
catch
end

try
    reference_mass=Barrett.reference_mass;
    ss=sprintf('%g',reference_mass);    
    set(handles.edit_reference_mass,'String',ss);
catch
end


try
    new_mass=Barrett.new_mass;
    ss=sprintf('%g',new_mass);    
    set(handles.edit_new_mass,'String',ss);
catch
end


try      
    psd_type=Barrett.psd_type;
    set(handles.listbox_psd_type,'Value',psd_type);
catch
end

try      
    add_mass=Barrett.add_mass;
    set(handles.listbox_add_mass,'Value',add_mass);
catch
end

try
    mass_type=Barrett.mass_type;
    set(handles.listbox_mass_type,'Value',mass_type);
catch
end


try
    listbox_diam=Barrett.listbox_diam;
    set(handles.listbox_diam,'Value',listbox_diam);
catch
end


try
    diam_refer=Barrett.diam_refer;
    ss=sprintf('%g',diam_refer);  
    set(handles.edit_diam_refer,'String',ss);
catch
end


try
    diam_new=Barrett.diam_new;
    ss=sprintf('%g',diam_new);  
    set(handles.edit_diam_new,'String',ss);
catch
end


listbox_add_mass_Callback(hObject, eventdata, handles);
listbox_diam_Callback(hObject, eventdata, handles);

set(handles.listbox_add_mass,'Visible','on');



try
    num_curves=Barrett.num_curves;    
    set(handles.listbox_num_curves,'Value',num_curves);
    listbox_num_curves_Callback(hObject, eventdata, handles)
    
    try
        A_legend=Barrett.A_legend;        
        set(handles.uitable_legend,'Data',A_legend);
    catch
        warndlg('Set Legend Failed');
    end
    
catch
end




% --- Executes on selection change in listbox_diam.
function listbox_diam_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_diam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_diam contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_diam

n=get(handles.listbox_diam,'Value');


set(handles.text_diam_main,'Visible','off');
set(handles.text_RD,'Visible','off');
set(handles.text_ND,'Visible','off');
set(handles.edit_diam_refer,'Visible','off');
set(handles.edit_diam_new,'Visible','off');

if(n==2)

    set(handles.text_diam_main,'Visible','on');
    set(handles.text_RD,'Visible','on');
    set(handles.text_ND,'Visible','on');
    set(handles.edit_diam_refer,'Visible','on');
    set(handles.edit_diam_new,'Visible','on');
end


% --- Executes during object creation, after setting all properties.
function listbox_diam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_diam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_diam_refer_Callback(hObject, eventdata, handles)
% hObject    handle to edit_diam_refer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_diam_refer as text
%        str2double(get(hObject,'String')) returns contents of edit_diam_refer as a double


% --- Executes during object creation, after setting all properties.
function edit_diam_refer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_diam_refer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_diam_new_Callback(hObject, eventdata, handles)
% hObject    handle to edit_diam_new (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_diam_new as text
%        str2double(get(hObject,'String')) returns contents of edit_diam_new as a double


% --- Executes during object creation, after setting all properties.
function edit_diam_new_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_diam_new (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_num_curves.
function listbox_num_curves_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num_curves (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num_curves contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num_curves
Nrows=get(handles.listbox_num_curves,'Value');

Ncolumns=1;
headers1={'Legend Title'};

set(handles.uitable_legend,'Data',cell(Nrows,Ncolumns),'ColumnName',headers1);

% --- Executes during object creation, after setting all properties.
function listbox_num_curves_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_num_curves (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_save_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_save_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_save_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_save_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_save_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_save_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_load_model_list.
function pushbutton_load_model_list_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_model_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Barrett_method_load;

uiwait()

uiresume(Barrett_method_load)

delete(Barrett_method_load);
    
Lflag=getappdata(0,'Lflag');


if(Lflag==0)
    
    load_core(hObject, eventdata, handles);

    delete(Barrett_method_load);

else
    delete(Barrett_method_load);    
end

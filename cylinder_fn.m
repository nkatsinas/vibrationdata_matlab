function varargout = cylinder_fn(varargin)
% CYLINDER_FN MATLAB code for cylinder_fn.fig
%      CYLINDER_FN, by itself, creates a new CYLINDER_FN or raises the existing
%      singleton*.
%
%      H = CYLINDER_FN returns the handle to a new CYLINDER_FN or the handle to
%      the existing singleton*.
%
%      CYLINDER_FN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CYLINDER_FN.M with the given input arguments.
%
%      CYLINDER_FN('Property','Value',...) creates a new CYLINDER_FN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cylinder_fn_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cylinder_fn_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cylinder_fn

% Last Modified by GUIDE v2.5 28-May-2022 18:56:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cylinder_fn_OpeningFcn, ...
                   'gui_OutputFcn',  @cylinder_fn_OutputFcn, ...
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


% --- Executes just before cylinder_fn is made visible.
function cylinder_fn_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cylinder_fn (see VARARGIN)

% Choose default command line output for cylinder_fn
handles.output = hObject;

change_material_units(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes cylinder_fn wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = cylinder_fn_OutputFcn(hObject, eventdata, handles) 
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

try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end    

fprintf('\n * * * * * * * * * * * \n');

cspeed=str2num(get(handles.edit_sound_speed,'String'));

iu=get(handles.listbox_units,'Value');

E=str2num(get(handles.edit_elastic_modulus,'String'));
rho=str2num(get(handles.edit_mass_density,'String'));
v=str2num(get(handles.edit_poisson,'String'));
h=str2num(get(handles.edit_thickness,'String'));
L=str2num(get(handles.edit_length,'String'));
diam=str2num(get(handles.edit_diameter,'String'));

if(iu==1)     % English
    rho=rho/386.;
else              % metric
    [E]=GPa_to_Pa(E);
    h=h/1000;
end

c=sqrt(E/rho);

bc=get(handles.listbox_bc,'Value');

%
nmax=160;
mmax=160;
%

[fring]=infinite_cylinder_ring(E,rho,v,h,diam);

[fn,kv,radius,kL]=cylinder_engine_alt(E,rho,v,h,diam,L,mmax,nmax,bc);

setappdata(0,'kL',kL);

a=radius;

%
disp('  ');
disp(' n is circumferential mode parameter, where 2n=the number of ');
disp('   cross points in the radial displacement shape'); 
disp(' ');
disp(' m is axial mode parameter');
disp(' k is the wave number');
disp(' c is the speed of sound');
disp('   ');
disp(' AF is acoustically fast ');
disp(' AS is acoustically slow ');
disp('  ');
%
disp(' ')
if(iu==1)
    disp('    fn(Hz)   m   n   k(rad/in)   c(ft/sec)');
else
    disp('    fn(Hz)   m   n   k(rad/m)   c(m/sec)');    
end
%
mmm=kv-1;
if(mmm>6000)
    mmm=6000;
end


ir=0;
ik=1;

tpi=2*pi;

ccc=zeros(mmm,1);
LCn=zeros(mmm,1);

for i=1:mmm
    
    c=tpi*fn(i,1)/fn(i,8);
    
    if(iu==1)
        c=c/12;
    end
    
    ccc(i)=c;
    
    LC='AS';
    LCn(i)=1;
    if(c>cspeed)
        LC='AF';
        LCn(i)=2;
    end    
    
    if(fn(i,1)<=20000)
        if(fn(i,2)==1 && i<=2000)
            fprintf(' %d  %8.2f  %d  %d  %8.3g  %8.5g  flexural %s\n',i,fn(i,1),fn(i,3),fn(i,4),fn(i,8),c,LC);        
        end
        if(fn(i,2)==2 && i<=2000)
            fprintf(' %d  %8.2f  %d  %d  %8.3g  %8.5g  in-plane 1  %s\n',i,fn(i,1),fn(i,3),fn(i,4),fn(i,8),c,LC);        
        end    
        if(fn(i,2)==3 && i<=2000)
            fprintf(' %d  %8.2f  %d  %d  %8.3g  %8.5g  in-plane 2  %s\n',i,fn(i,1),fn(i,3),fn(i,4),fn(i,8),c,LC);        
        end    
    end
    
    if(fn(i,2)==1)
        flex(ik,:)=[fn(i,1),fn(i,3),fn(i,4)];
        ik=ik+1;
    end
    
    if(fn(i,2)==2 && fn(i,3)==1 && fn(i,4)==0)
        ir=i;
    end
    
end
%
setappdata(0,'LCn',LCn);


if(ir>=1)
    
    c=tpi*fn(ir,1)/fn(ir,8);
    
    if(iu==1)
        c=c/12;
    end
    
    LC='AS';
    if(c>cspeed)
        LC='AF';
    end
    
    if(iu==1)
        fprintf('\n Ring Mode Frequency: \n   %d  %8.2f Hz  m=%d  n=%d  k=%8.3g rad/in  c=%8.5g ft/sec  in-plane 1  %s\n',ir,fn(ir,1),fn(ir,3),fn(ir,4),fn(ir,8),c,LC);   
    else
        fprintf('\n Ring Mode Frequency: \n   %d  %8.2f Hz  m=%d  n=%d  k=%8.3g rad/m  c=%8.5g m/sec   in-plane 1  %s\n',ir,fn(ir,1),fn(ir,3),fn(ir,4),fn(ir,8),c,LC);           
    end
    fprintf('    Modal Coefficients:  Long=%6.3g    Tang=%6.3g    Rad=%6.3g \n',fn(ir,5),fn(ir,6),fn(ir,7));

end

setappdata(0,'ir',ir);

if(fring>0)
    fprintf('\n Infinite Length Ring Frequency: %8.4g Hz \n',fring);
end

CL=sqrt(E/rho);

if(bc==1 || bc==2 || bc==4)
    flong=pi*CL/L;
end
    
if(bc==3) % Fixed-Free
    flong=pi*CL/(2*L); 
end
    
flong=flong/tpi;

fprintf('\n First Longitudinal Mode f = %8.5g Hz \n',flong);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear fc;
clear nn;
%
ioct=2;
if(ioct==1)
	fc(1)=2.;
	fc(2)=4.;
	fc(3)=8.;
	fc(4)=16.;
	fc(5)=31.5;
	fc(6)=63.;
	fc(7)=125.;
	fc(8)=250.;
	fc(9)=500.;
	fc(10)=1000.;
	fc(11)=2000.;
	fc(12)=4000.;
	fc(13)=8000.;
	fc(14)=16000.;
    imax=14;
end
if(ioct==2)
	fc(1)=2.5;
	fc(2)=3.15;
	fc(3)=4.;
	fc(4)=5.;
	fc(5)=6.3;
	fc(6)=8.;
	fc(7)=10.;
	fc(8)=12.5;
	fc(9)=16.;
	fc(10)=20.;
	fc(11)=25.;
	fc(12)=31.5;
	fc(13)=40.;
	fc(14)=50.;
	fc(15)=63.;
	fc(16)=80.;
	fc(17)=100.;
	fc(18)=125.;
	fc(19)=160.;
	fc(20)=200.;
	fc(21)=250.;
	fc(22)=315.;
	fc(23)=400.;
	fc(24)=500.;
	fc(25)=630.;
	fc(26)=800.;
	fc(27)=1000.;
	fc(28)=1250.;
	fc(29)=1600.;
	fc(30)=2000.;
	fc(31)=2500.;
	fc(32)=3150.;
	fc(33)=4000.;
	fc(34)=5000.;
	fc(35)=6300.;
	fc(36)=8000.;
	fc(37)=10000.;
    imax=length(fc);
end
%

sz=size(fn);
kv=sz(1);

nun=zeros([1 imax]);
for j=1:imax
    fl=fc(j)/sqrt(2);
    fu=fc(j)*sqrt(2);
    for i=1:(kv-1)
        if(fn(i,1)>=fl && fn(i,1) < fu)
           nun(j)=nun(j)+1;    
        end
        if(flex(i,1)>fu)
            break;
        end
    end    
end
%
for j=1:imax
    fl=fc(j)/sqrt(2);
    fu=fc(j)*sqrt(2);  
    nun(j)=nun(j)/(fu-fl);
end
%
md=[fc' nun'];
md=sortrows(md,1);


sz=size(md);
k=1;
for i=1:sz(1)
    if(md(i,2)>1.0e-08)
        mmd(k,:)=md(i,:);
        k=k+1;
    end
end

setappdata(0,'flex',flex);
setappdata(0,'fn',fn);
setappdata(0,'mmd',mmd);
setappdata(0,'a',a);
setappdata(0,'L',L);
setappdata(0,'fn',fn);
setappdata(0,'bc',bc);
setappdata(0,'iu',iu);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=1;

t_string='Cylinder Modal Density, Wave Method, One-Third Octave Bands';
y_label='Modes/Hz';
x_label='Frequency (Hz)';
ppp=md;

  
  ijk=0;
  
  sz=size(ppp);
  for i=1:sz(1)
      if(ppp(i,2)>0)
          ijk=i;
          break;
      end
  end
  
  for i=(ijk-1):-1:1
      ppp(i,:)=[];
  end
  
  fmin=ppp(1,1);
  fmax=ppp(end,1);

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,4);

 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

NL=length(ppp);

sea_mph=zeros(NL,1);
 
for i=1:NL 
    [sea_mph(i)] = cylinder_mdens(ppp(i,1),fring,L,h);
end        

t_string='Cylinder Modal Density, One-Third Octave Bands';
y_label='Modes/Hz';
x_label='Frequency (Hz)';
md=4;

ppp1=ppp;
ppp2=[ppp(:,1) sea_mph];

leg1='Wave Method';
leg2='SEA Approximation';

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);
           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(fig_num)
 fig_num=fig_num+1;
 plot(fn(1:length(ccc),1),ccc,'bo','MarkerSize',3);
 grid on;
 title('Wave Speed');
 xlabel('Frequency (Hz)');
 if(iu==1)
    ylabel('Speed (ft/sec)');
 else
    ylabel('Speed (m/sec)');     
 end
 
 set(gca, 'xminorgrid', 'on', 'yminorgrid', 'on')
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log','YScale','log');  

[xtt,xTT,iflag]=xtick_label(fmin,fmax);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);
    xlim([fmin,fmax]);    
end   

md=4;

ymax= 10^ceil(0.01+log10(max(ccc)));
%
ymin= 10^floor(log10(min(ccc)));


if(ymin<ymax/10^md)
    ymin=ymax/10^md;
end

if(ymin==ymax)
    ymin=ymin/10;
    ymax=ymax*10;
end    

ylim([ymin,ymax]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 assignin('base','cyl_modal_density',ppp);
 assignin('base','cyl_fn',[fn(:,1) fn(:,3) fn(:,4)]);
 
 fprintf('\n Output Arrays for Wave Method \n');
 fprintf('\n       Modal Density:  cyl_modal_density   [fc(Hz) (modes/Hz)] ');
 fprintf('\n Natural Frequencies:  cyl_fn              [fn(Hz)  m  n] \n\n');
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


setappdata(0,'fig_num',fig_num);

set(handles.uipanel_plot,'Visible','on');

msgbox('Results written to Command Window');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units
change_material_units(hObject, eventdata, handles);


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


% --- Executes on selection change in listbox_materials.
function listbox_materials_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_materials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_materials contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_materials
change_material_units(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_materials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_materials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_elastic_modulus_Callback(hObject, eventdata, handles)
% hObject    handle to edit_elastic_modulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_elastic_modulus as text
%        str2double(get(hObject,'String')) returns contents of edit_elastic_modulus as a double


% --- Executes during object creation, after setting all properties.
function edit_elastic_modulus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_elastic_modulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mass_density_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mass_density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mass_density as text
%        str2double(get(hObject,'String')) returns contents of edit_mass_density as a double


% --- Executes during object creation, after setting all properties.
function edit_mass_density_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass_density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_poisson_Callback(hObject, eventdata, handles)
% hObject    handle to edit_poisson (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_poisson as text
%        str2double(get(hObject,'String')) returns contents of edit_poisson as a double


% --- Executes during object creation, after setting all properties.
function edit_poisson_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_poisson (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function change_material_units(hObject, eventdata, handles)

set(handles.uipanel_plot,'Visible','off');

n=get(handles.listbox_units,'Value');

if(n==1)
    s1='Diameter (in)';
    sem='Elastic Modulus (psi)';
    smd='Mass Density (lbm/in^3)';
    sth='Thickness (in)';  
    sh='Length (in)';
    sss='Speed of Sound (ft/sec)';
    ccc=sprintf('1125');
else
    s1='Diameter (m)';
    sem='Elastic Modulus (GPa)';
    smd='Mass Density (kg/m^3)'; 
    sth='Thickness (mm)';    
    sh='Length (m)'; 
    sss='Speed of Sound (m/sec)';
    ccc=sprintf('343');
end

set(handles.edit_sound_speed,'String',ccc);
set(handles.text_sound_speed,'String',sss);
set(handles.text_diameter,'String',s1);
set(handles.text_elastic_modulus,'String',sem);
set(handles.text_mass_density,'String',smd);
set(handles.text_thickness,'String',sth);
set(handles.text_length,'String',sh);

m=get(handles.listbox_materials,'Value');

[elastic_modulus,mass_density,poisson]=six_materials(n,m);


ss1=' ';
ss2=' ';
ss3=' ';   

if(m<=6)
        ss1=sprintf('%8.4g',elastic_modulus);
        ss2=sprintf('%8.4g',mass_density);
        ss3=sprintf('%8.4g',poisson);
end
     
set(handles.edit_elastic_modulus,'String',ss1);
set(handles.edit_mass_density,'String',ss2); 
set(handles.edit_poisson,'String',ss3);



function edit_diameter_Callback(hObject, eventdata, handles)
% hObject    handle to edit_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_diameter as text
%        str2double(get(hObject,'String')) returns contents of edit_diameter as a double


% --- Executes during object creation, after setting all properties.
function edit_diameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thickness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thickness as text
%        str2double(get(hObject,'String')) returns contents of edit_thickness as a double


% --- Executes during object creation, after setting all properties.
function edit_thickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_length_Callback(hObject, eventdata, handles)
% hObject    handle to edit_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_length as text
%        str2double(get(hObject,'String')) returns contents of edit_length as a double


% --- Executes during object creation, after setting all properties.
function edit_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_bc.
function listbox_bc_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_bc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_bc contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_bc
set(handles.uipanel_plot,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_bc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_bc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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

n=get(handles.listbox_save,'Value');

if(n==1)
    data=getappdata(0,'fn');
else
    data=getappdata(0,'mmd');
end


output_name=get(handles.edit_output_array,'String');

assignin('base', output_name, data);

h = msgbox('Save Complete'); 


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


% --- Executes on selection change in listbox4.
function listbox4_Callback(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox4


% --- Executes during object creation, after setting all properties.
function listbox4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' plotting... ');

a=getappdata(0,'a');
L=getappdata(0,'L');
fn=getappdata(0,'fn');
bc=getappdata(0,'bc');
kL=getappdata(0,'kL');
LCn=getappdata(0,'LCn');

nq=str2num(get(handles.edit_mode_number,'String'));

if(nq>length(fn(:,1)))
    out1=sprintf(' Maximum mode number = %d',length(fn));
    warndlg(out1);
    return;
end


LN=64;

radius=a;

dL=L/LN;
dT=pi/45;


fig_num=getappdata(0,'fig_num');

figure(fig_num);
fig_num=fig_num+1;
setappdata(0,'fig_num',fig_num);

hold on;

m=fn(nq,3);
n=fn(nq,4);


nnt=90; 
 
dtd=360/nnt; 
 
theta=zeros(nnt,1);

for i=1:nnt
    theta(i)=(i-1)*dtd;
end    

dT=2*radius*pi/720;
theta=theta*pi/180;

ntheta=n*theta;
ndT=n*dT;


k=kL(m)/L;
dr=radius/15; 
ddL=dL/0.5;

bL=kL(m);

MSb=fn(nq,5:7);

sq=max(abs(MSb));

if(abs(MSb(3))>1.0e-04)
    sq=sq/sign(MSb(3));
end


scale1=(radius/25)*MSb(1)/sq;
scale2=(radius/25)*MSb(2)/sq;
scale3=(radius/25)*MSb(3)/sq;


dr=dr*scale3;
ddL=ddL*scale1;


for j=1:LN
    
    L1=(j-1)*dL;
    L2=L1+dL;
        
    for i=1:90
         
        p=theta(i);
        np=ntheta(i);
       
        arg1=k*L1;
        arg2=k*L2;
    
        if(bc==1)  % free-free
            C=(-cosh(bL)+cos(bL))/(sinh(bL)+sin(bL));
            qmm1=((sinh(arg1)+sin(arg1))+C*(cosh(arg1)+cos(arg1)));
            qmm2=((sinh(arg2)+sin(arg2))+C*(cosh(arg2)+cos(arg2)));            
        end
        if(bc==2)  % fixed-fixed
            C=(sinh(bL)+sin(bL))/(cosh(bL)-cos(bL));
            if(m<=6)
                qmm1=((cosh(arg1)-cos(arg1))-C*(sinh(arg1)-sin(arg1)));
                qmm2=((cosh(arg2)-cos(arg2))-C*(sinh(arg2)-sin(arg2)));
            else
                qmm1=1-cos(arg1);
                qmm2=1-cos(arg2);                
            end    
        end
        if(bc==3) % fixed-free
            C=-(cos(bL)+cosh(bL))/(sin(bL)+sinh(bL));
            qmm1=((cosh(arg1)-cos(arg1))+C*(sinh(arg1)-sin(arg1)));
            qmm2=((cosh(arg2)-cos(arg2))+C*(sinh(arg2)-sin(arg2)));                  
        end
        if(bc==4) % ss-ss
            qmm1=sin(arg1);
            qmm2=sin(arg2);
        end
        
        cnp=cos(np);
        cnpndT=cos(np+ndT);
        
        r1=radius + dr*cnp*qmm1;
        r2=radius + dr*cnpndT*qmm1;
        r3=radius + dr*cnpndT*qmm2;
        r4=radius + dr*cnp*qmm2;
        
        LL1=L1+ddL*cnp*qmm1;
        LL2=LL1;   
        LL3=L2+ddL*cnpndT*qmm2;        
        LL4=LL3;

        T1= dT*sin(np)*qmm1;
        T2= dT*sin(np+ndT)*qmm1;
        T3= dT*sin(np+ndT)*qmm2;
        T4= dT*sin(np)*qmm2;        
        
        alpha1=atan2(T1,radius)*scale2;
        alpha2=atan2(T2,radius)*scale2;
        alpha3=atan2(T3,radius)*scale2;
        alpha4=atan2(T4,radius)*scale2;        

        beta1=p+alpha1;
        beta2=p+dT+alpha2;
        beta3=p+dT+alpha3;
        beta4=p+alpha4;        
        
        x1=r1*cos(beta1);
        x2=r2*cos(beta2);   
        x3=r3*cos(beta3);         
        x4=r4*cos(beta4);
                   
        y1=r1*sin(beta1);
        y2=r2*sin(beta2);   
        y3=r3*sin(beta3);         
        y4=r4*sin(beta4);
        
        X=[x1 x2 x3 x4 ];
        Y=[y1 y2 y3 y4 ];
        
        Z=[LL1 LL2 LL3 LL4];
        
%        if(i==1)
%            fprintf('%8.4g \n',LL3-LL1);
%        end
        
        patch(X,Y,Z,'g');
    end
end

view([-45 45]);
grid on;

U=max([radius L]);

Ur=U/2;

xlim([ -Ur Ur ]);
ylim([ -Ur Ur ]);

if(LCn(nq)==1)
    LC='AS';
else
    LC='AF';
end

if(fn(nq,2)==1)
    out1=sprintf(' Mode %d  fn=%8.4g Hz  m=%d n=%d  flexural  %s',nq,fn(nq,1),m,n,LC);
end
if(fn(nq,2)==2)
    out1=sprintf(' Mode %d  fn=%8.4g Hz  m=%d n=%d  in-plane 1  %s',nq,fn(nq,1),m,n,LC);
end
if(fn(nq,2)==3)
    out1=sprintf(' Mode %d  fn=%8.4g Hz  m=%d n=%d  in-plane 3  %s',nq,fn(nq,1),m,n,LC);
end

title(out1);

iu=getappdata(0,'iu');

if(iu==1)
    xlabel('x(in)');
    ylabel('y(in)');
    zlabel('z(in)');
else
    xlabel('x(m)');
    ylabel('y(m)');
    zlabel('z(m)');    
end

hold off;



function edit_scale1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_scale1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_scale1 as text
%        str2double(get(hObject,'String')) returns contents of edit_scale1 as a double


% --- Executes during object creation, after setting all properties.
function edit_scale1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_scale1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_scale2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_scale2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_scale2 as text
%        str2double(get(hObject,'String')) returns contents of edit_scale2 as a double


% --- Executes during object creation, after setting all properties.
function edit_scale2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_scale2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_scale3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_scale3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_scale3 as text
%        str2double(get(hObject,'String')) returns contents of edit_scale3 as a double


% --- Executes during object creation, after setting all properties.
function edit_scale3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_scale3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_ring_mode.
function pushbutton_ring_mode_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ring_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ir=getappdata(0,'ir');

irs=sprintf('%d',ir);

set(handles.edit_mode_number,'String',irs);

pushbutton_plot_Callback(hObject, eventdata, handles);


function edit_mode_number_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mode_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mode_number as text
%        str2double(get(hObject,'String')) returns contents of edit_mode_number as a double


% --- Executes during object creation, after setting all properties.
function edit_mode_number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mode_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_sound_speed_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sound_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sound_speed as text
%        str2double(get(hObject,'String')) returns contents of edit_sound_speed as a double


% --- Executes during object creation, after setting all properties.
function edit_sound_speed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sound_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

A = imread('Cylinder_md.jpg');
    figure(998) 
    imshow(A,'border','tight','InitialMagnification',100)

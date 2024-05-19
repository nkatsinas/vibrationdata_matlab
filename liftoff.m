function varargout = liftoff(varargin)
% LIFTOFF MATLAB code for liftoff.fig
%      LIFTOFF, by itself, creates a new LIFTOFF or raises the existing
%      singleton*.
%
%      H = LIFTOFF returns the handle to a new LIFTOFF or the handle to
%      the existing singleton*.
%
%      LIFTOFF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LIFTOFF.M with the given input arguments.
%
%      LIFTOFF('Property','Value',...) creates a new LIFTOFF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before liftoff_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to liftoff_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help liftoff

% Last Modified by GUIDE v2.5 26-Sep-2019 10:48:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @liftoff_OpeningFcn, ...
                   'gui_OutputFcn',  @liftoff_OutputFcn, ...
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


% --- Executes just before liftoff is made visible.
function liftoff_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to liftoff (see VARARGIN)

% Choose default command line output for liftoff
handles.output = hObject;


disp('opening liftoff');

set(handles.listbox_motor,'Value',1);
set(handles.listbox_units,'Value',1);


listbox_units_Callback(hObject, eventdata, handles);
listbox_motor_Callback(hObject, eventdata, handles);
listbox_igeo_Callback(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes liftoff wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = liftoff_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units

iu=get(handles.listbox_units,'Value');
setappdata(0,'iu',iu);


if(iu==1)
   set(handles.text_C,'String','Sound Speed (ft/sec)');     
   set(handles.edit_C,'String','1120'); 
   set(handles.text_length_unit,'String','in');
else
   set(handles.text_C,'String','Sound Speed (m/sec)');    
   set(handles.edit_C,'String','343');   
   set(handles.text_length_unit,'String','m');
end

listbox_motor_Callback(hObject, eventdata, handles);

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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('  ');
disp(' * * * * * * * * * * * * ');
disp('  ');

c1(hObject, eventdata, handles);
c2(hObject, eventdata, handles);
c3(hObject, eventdata, handles);
c4(hObject, eventdata, handles);
c5(hObject, eventdata, handles);

fig_num=1;

%%%%%%%

ref  = 1.0e-12;
Aref = 20.e-06;

setappdata(0,'ref',ref);


mm_per_inch = 25.4;
inch_per_mm = 1./mm_per_inch;

m_per_ft = 0.3048;
ft_per_m = 1./m_per_ft;

m_per_inch = 0.3048/12.;
inch_per_m=1./m_per_inch;

N_per_lbf = 4.448;
lbf_per_N = 1./N_per_lbf;

kgpm3_per_lbmpin3 = 27675;
kg_per_lbm = 0.45351;

%%%%%%%

% i_end_slope=1;

% db_per_octave = 6;   % conservative slope limit

% slope_limit=db_per_octave/3;

%%%%%%%

     prefix=getappdata(0,'prefix');
          L=getappdata(0,'q_length');
      sdiam=getappdata(0,'q_diameter');


if(isempty(prefix))
   warndlg('Enter prefix via Stations pushbutton'); 
   return; 
end

if(isempty(L))
   warndlg('Enter length via Stations pushbutton'); 
   return; 
end

if(isempty(sdiam))
   warndlg('Enter diameter via Stations pushbutton'); 
   return; 
end

isi=length(L);

%%%%%%%

isys=get(handles.listbox_units,'Value');
setappdata(0,'isys',isys);

irad=get(handles.listbox_irad,'Value');
setappdata(0,'irad',irad);

iw=get(handles.listbox_iw,'Value');
setappdata(0,'iw',iw);

igeo=get(handles.listbox_igeo,'Value');
setappdata(0,'igeo',igeo);

ich=get(handles.listbox_ascent,'Value');
setappdata(0,'ich',ich);

motor=get(handles.listbox_motor,'Value');
setappdata(0,'motor',motor);

N=1;

if(motor==6 || motor==7 || motor==8 || motor==11)
    N=str2num(get(handles.edit_num_nozzles,'String'));
end

thrust_1=str2num(get(handles.edit_thrust_1,'String'));
diameter_1=str2num(get(handles.edit_diameter_1,'String'));
velox_1=str2num(get(handles.edit_velox_1,'String'));

thrust_2=0;
diameter_2=0;
velox_2=0;


if(motor==2 || motor==7)
   
    thrust_2=str2num(get(handles.edit_thrust_2,'String'));
    diameter_2=str2num(get(handles.edit_diameter_2,'String'));
    velox_2=str2num(get(handles.edit_velox_2,'String'));    
end

%%%%%%%

aceff=str2num(get(handles.edit_aceff,'String'));
cspeed=str2num(get(handles.edit_C,'String'));

F1=thrust_1;
F2=thrust_2;

U1=velox_1;
U2=velox_2;

if(isys==1)
   F1=F1*N_per_lbf; 
   F2=F2*N_per_lbf;
   U1=U1*m_per_ft;
   U2=U2*m_per_ft;
   cspeed=cspeed*m_per_ft;
end    
setappdata(0,'cspeed',cspeed);

if(motor==2 || motor==7)
    MP=(N*F1*U1)+(2*F2*U2);
    U=MP/(N*F1+2*F2);
else
    MP=N*F1*U1;   
    U=U1;
end
setappdata(0,'U',U);
    
WOA=aceff*MP;   % do not include 0.5 factor.  See NASA SP-8072, Fig 3   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(isys==1)
    diameter_1=diameter_1*m_per_inch;    
    diameter_2=diameter_2*m_per_inch;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% display motor name

   outm=' Other ';    

   disp(' ');
   if(motor<=2)
        outm=' SR-19 ';
   end
   if(motor==3)
        outm=' Castor 4B ';
   end     
   if(motor==4)
        outm=' Castor 120 ';
   end     
   if(motor==5)
        outm=' Peacekeeper Stage 1 ';
   end     
   if(motor==6)
        outm=' NK-33 ';
   end     
   if(motor==7)
        outm=' SLS Core Stage ';    
   end
   if(motor==8)
        outm=' BE-3 Liftoff ';    
   end   
   if(motor==9)
        outm=' BE-3 Max Descent ';    
   end   
   if(motor==10)
        outm=' BE-3 Touchdown ';    
   end      
   if(motor==11)
        outm=' Other ';    
   end   
   
   disp(outm);
   
   ntx=1;
   text{ntx}=outm;
   ntx=ntx+1;
   text{ntx}=' ';
   ntx=ntx+1;
   
   out1=sprintf('\n Thrust = %8.4g lbf',F1*lbf_per_N); 
   out2=sprintf('        = %8.4g N',F1);  
   out3=sprintf('\n Exhaust velocity = %8.4g ft/sec',U1*ft_per_m); 
   out4=sprintf('                  = %8.4g m/sec',U1);    
   out5=sprintf('\n Nozzle Exit Diameter = %8.4g in',diameter_1*inch_per_m); 
   out6=sprintf('                     = %8.4g m',diameter_1);     
   
   disp(out1); 
   disp(out2);
   disp(out3); 
   disp(out4); 
   disp(out5);
   disp(out6); 
   
   out7=sprintf('\n Number of nozzles = %d ',N);
   disp(out7);
   
   text{ntx}=out1;
   ntx=ntx+1;
   text{ntx}=out2;
   ntx=ntx+1;
   text{ntx}=' ';
   ntx=ntx+1;   
   text{ntx}=out3;
   ntx=ntx+1; 
   text{ntx}=out4;
   ntx=ntx+1;
   text{ntx}=' ';
   ntx=ntx+1;   
   text{ntx}=out5;
   ntx=ntx+1; 
   text{ntx}=out6;
   ntx=ntx+1;
   text{ntx}=' ';
   ntx=ntx+1;   
   text{ntx}=out7;
   ntx=ntx+1;   
   text{ntx}=' ';
   ntx=ntx+1;
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
   
if(motor==2 || motor==7)

   disp(' ');
   if(motor==2)
        outm2=' MLRS ';
   end
   if(motor==7)
        outm2=' SRB ';    
   end    
   disp(outm2);
   text{ntx}=outm2;
   ntx=ntx+1;
   text{ntx}=' ';
   ntx=ntx+1;
   
    
   out1=sprintf('\n Thrust = %8.4g lbf',F2*lbf_per_N); 
   out2=sprintf('        = %8.4g N',F2);  
   out3=sprintf('\n Exhaust velocity = %8.4g ft/sec',U2*ft_per_m); 
   out4=sprintf('                  = %8.4g m/sec',U2);    
   out5=sprintf('\n Nozzle Exit Diameter = %8.4g in',diameter_2*inch_per_m); 
   out6=sprintf('                  = %8.4g m',diameter_2);     
   
   disp(out1); 
   disp(out2);
   disp(out3); 
   disp(out4); 
   disp(out5);
   disp(out6); 
   
   text{ntx}=out1;
   ntx=ntx+1;  
   text{ntx}=out2;
   ntx=ntx+1;
   text{ntx}=' ';
   ntx=ntx+1;   
   text{ntx}=out3;
   ntx=ntx+1;   
   text{ntx}=out4;
   ntx=ntx+1;
   text{ntx}=' ';
   ntx=ntx+1;   
   text{ntx}=out5;
   ntx=ntx+1;  
   text{ntx}=out6;
   ntx=ntx+1;
   text{ntx}=' ';
   ntx=ntx+1;   
      
end

if(motor==7)
    ttt=(4*F1)+(2*F2);
    out1=sprintf('\n Total thrust = %8.4g lbf ',ttt*lbf_per_N); 
    out2=sprintf('              = %8.4g N \n',ttt);     
    disp(out1);    
    disp(out2);
    
   text{ntx}=out1;
   ntx=ntx+1;   
   text{ntx}=out2;
   ntx=ntx+1;
   text{ntx}=' ';
   ntx=ntx+1;   
end  


if(irad==1)
    outr=' Sound Radiation Volume: hemisphere (flat ground plane)';
else
    outr=' Sound Radiation Volume: spherical (free space)';    
end
disp(outr);

text{ntx}=outr;
ntx=ntx+1;
text{ntx}=' ';
ntx=ntx+1;


if(iw==1)
    outiw=' Surface Reflection Correction: yes ';
else
    outiw=' Surface Reflection Correction: no';    
end
disp(outiw);

text{ntx}=outiw;
ntx=ntx+1;
text{ntx}=' ';
ntx=ntx+1;

out1=sprintf('\n Speed of sound = %8.4g ft/sec',cspeed*ft_per_m);
out2=sprintf('                = %8.4g m/sec',cspeed);
disp(out1);
disp(out2);

text{ntx}=out1;
ntx=ntx+1;
text{ntx}=out2;
ntx=ntx+1;
text{ntx}=' ';
ntx=ntx+1;


out1=sprintf('\n Acoustic efficiency = %8.4g ',aceff);
disp(out1);

text{ntx}=out1;
ntx=ntx+1;
text{ntx}=' ';
ntx=ntx+1;  

out1=sprintf('\n Peak Instantaneous Mechanical Power = %8.4g ft-lbf/sec ',MP/1.3557);
out2=sprintf('                                     = %8.4g Watts        ',MP);

out3=sprintf('\n overall acoustic power WOA = %12.3g ft-lbf/sec  ',WOA/1.3557);
out4=sprintf('                            = %12.3g Watts      \n',WOA);

disp(out1);
disp(out2);
disp(out3);
disp(out4);

text{ntx}=out1;
ntx=ntx+1;
text{ntx}=out2;
ntx=ntx+1;
text{ntx}=' ';
ntx=ntx+1;
text{ntx}=out3;
ntx=ntx+1;
text{ntx}=out4;
ntx=ntx+1;
text{ntx}=' ';
ntx=ntx+1;

LW=120 + 10*log10(WOA);

if(igeo==7)
    outs=' Subtract 3 dB for: deflected, 90 deg flat plate, conical diffuser, or wedge';
	LW=LW-3;
    text{ntx}=outs;
    ntx=ntx+1;
    text{ntx}=' ';
    ntx=ntx+1;    
end
setappdata(0,'LW',LW);

outp5=sprintf('\n overall acoustic power level LW = %8.4g dB ',LW);
outp6=sprintf(' Ref = 1.0e-12 Watts \n');  

disp(outp5);
disp(outp6);

text{ntx}=outp5;
ntx=ntx+1;
text{ntx}=outp6;
ntx=ntx+1;
text{ntx}=' ';
ntx=ntx+1;

%%%%%%%

if(igeo==1)
		outn=' single nozzle, undeflected (Smith & Brown)';
end
if(igeo==2)
		outn=' single nozzle, undeflected (Morgan & Young)';   
end
if(igeo==3)
		outn=' multiple nozzles, undeflected';       
end
if(igeo==4)
		outn=' deflected, open scoop';      
end
if(igeo==5)
		outn=' deflected, closed bucket';
end
if(igeo==6)
		outn=' deflected, single 45 deg plate';    
end
if(igeo==7)
		outn=' deflected, 90 deg flat plate, conical diffuser, or wedge';        
end

disp(outn);

text{ntx}=outn;
ntx=ntx+1;


if(igeo==4 || igeo==5 || igeo==6 || igeo==7)

     x1=str2num(get(handles.edit_distance_nozzle,'String'));
    rho=str2num(get(handles.edit_rho,'String'));
    
    if(isys==1)
       x1=x1*m_per_inch; 
    end
    
    setappdata(0,'rho',rho);
    setappdata(0,'x1',x1);    
    
    disp(' ');
    out1=sprintf(' Distance from nozzle exit to ground = %8.4g in',x1*inch_per_m);
    out2=sprintf('                                     = %8.4g m',x1);    
    out3=sprintf('\n rho = %g deg',rho);
    
    disp(out1);
    disp(out2);
    disp(out3);

    text{ntx}=out1;
    ntx=ntx+1;
    text{ntx}=out2;
    ntx=ntx+1;  
    text{ntx}=' ';
    ntx=ntx+1;        
    text{ntx}=out3;
    ntx=ntx+1;    
    
end 

if(motor==2 || motor==7)
    de=sqrt( N*diameter_1^2  + 2*diameter_2^2 );
else    
    de=sqrt(N)*diameter_1;    
end

out1=sprintf('\n de = %g in',de*inch_per_m);
disp(out1);

try
    out2=sprintf('    = %g m',rho);    
    disp(out2);
catch
end
    
setappdata(0,'de',de);
setappdata(0,'dei',diameter_1);

if(motor==7)
    setappdata(0,'dei',diameter_2);    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setappdata(0,'text',text);
setappdata(0,'ntx',ntx);  

step5(hObject, eventdata, handles);

freq=getappdata(0,'freq');
freq=fix_size(freq);
Lwb=getappdata(0,'Lwb');
Lwb=fix_size(Lwb);

 
if isempty(freq)
        warndlg(' freq array is empty ');
        return;
end
LW=getappdata(0,'LW');
if isempty(LW)
        warndlg(' LW array is empty ');
        return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for ivk=1:isi

%%%

    xs=L(ivk);
        
    if(isys==1)
        xs=xs*m_per_inch;
        stationdiam=sdiam(ivk)*m_per_inch;
    end

    try
        setappdata(0,'xs',xs);
        setappdata(0,'stationdiam',stationdiam);    

        out0=sprintf('\n Station %s \n',prefix{ivk}');
        out1=sprintf('    Length = %8.4g in',xs*inch_per_m);
        out2=sprintf('           = %8.4g m',xs);
        out3=sprintf('  Diameter = %8.4g in',stationdiam*inch_per_m);
        out4=sprintf('           = %8.4g m',stationdiam);   
    
        disp(out0);
        disp(out1);
        disp(out2);
        disp(out3);
        disp(out4);  
        
        text{ntx}=out0;
        ntx=ntx+1;
        text{ntx}=' ';
        ntx=ntx+1;     
        text{ntx}=out1;
        ntx=ntx+1;   
        text{ntx}=out2;
        ntx=ntx+1;
        text{ntx}=out3;
        ntx=ntx+1;   
        text{ntx}=out4;
        ntx=ntx+1; 
        text{ntx}=' ';
        ntx=ntx+1;    
    
        setappdata(0,'text',text);
        setappdata(0,'ntx',ntx);   
    
    catch
    end
    
    try
        step6(hObject, eventdata, handles); 
    catch
        warndlg('step6 error');
        return;
    end
    try
        step7(hObject, eventdata, handles);
    catch
        warndlg('step7 error');
        return;        
    end
    try
        step8(hObject, eventdata, handles);    
    catch
        warndlg('step8 error');
        return;        
    end

    spl=getappdata(0,'spl');
    oadb=getappdata(0,'oadb');

    spl=fix_size(spl);
    
    if isempty(spl)
        warndlg(' spl array is empty ');
        return;
    end
    
    main_prefix=get(handles.edit_main_prefix,'String');
    
    prefix{ivk}= prefix{ivk}(~isspace(prefix{ivk}));
    
    if(ivk==1)
        t_string=sprintf('Source One-Third Octave Sound Power Level \n Overall Level = %8.4g dB  Ref: 1 pico Watts ',LW); 
        t_string=strrep(t_string,'_',' ');       
        x_label='Frequency (Hz)';
        y_label='Lw (dB)';
        ppp=[freq Lwb];
        fmin=min(freq);
        fmax=max(freq);
        [fig_num,h2]=plot_loglin_function_h2_yfree(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);
        

        outname=sprintf('%s_Lwb',main_prefix);
        assignin('base', outname,ppp);
        output_name_power=outname; 
    
    end    
    

    
    t_string=sprintf(' %s  One-Third Octave Sound Pressure Level \n OASPL = %8.4g dB  Ref: 20 micro Pa ',prefix{ivk},oadb); 
    t_string=strrep(t_string,'_',' ');
    x_label='Frequency (Hz)';
    y_label='SPL (dB)';
    ppp=[freq spl];
    fmin=min(freq);
    fmax=max(freq);
    [fig_num,h2]=plot_loglin_function_h2_yfree(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);
%


    [oadb]=oaspl_function(spl(1:21));
    
    out1=sprintf('\n oaspl = %8.4g dB  up to 2000 Hz ',oadb);
    disp(out1);
    

    outname=sprintf('%s_%s_spl_%d',main_prefix,prefix{ivk},ivk);
    assignin('base', outname,ppp);
    output_name{ivk}=outname;
    
    
    qqq=ppp;
    
    for i=1:length(spl)
        qqq(i,2)=Aref*10^(spl(i)/20);
    end
    
    iu=get(handles.listbox_units,'Value');
    if(iu==1)
        qqq(:,2)=qqq(:,2)*(0.00014511^2);  % convert Pa to psi
    end
    
    outname_psd=sprintf('%s_%s_psd_%d',main_prefix,prefix{ivk},ivk);
    assignin('base', outname_psd,qqq);
    output_name_psd{ivk}=outname_psd;
    
%    
    
    aname{ivk}=sprintf('%s.txt',outname);
    
    try
        dlmwrite(aname{ivk},ppp,'delimiter','\t');
    catch
        warndlg('Could not open output ASCII text file. May already be open.');
    end
       
%%%
   
end

try

    text=getappdata(0,'text');
     ntx=getappdata(0,'ntx');   
    
%%%    [writefname, writepname] = uiputfile('*','Save summary file as');
 
%%%    writefname=strrep(writefname,'.mat','.txt');
%%%    writepfname = fullfile(writepname, writefname);
   
    writepfname=sprintf('%s.txt',main_prefix); 

    fid = fopen(writepfname,'w');
  
    for i=1:(ntx-1)
        fprintf(fid,'%s \n',text{i});      
    end
    
    fclose(fid);
    
catch
    warndlg('Could not open summary ASCII text file. May already be open.');    
end
    
disp(' ');
disp(' SPL Output format:  freq(Hz) & spl(dB) ref 20 micro Pa');
disp(' ');
disp(' Matlab Output arrays: ');


out1=sprintf('    %s',output_name_power);  
disp(out1);  

for ivk=1:isi
     out1=sprintf('    %s',output_name{ivk});  
     disp(out1);  
end
disp(' ');


disp(' ');
if(iu==1)
    disp(' PSD Output format:  freq(Hz) & psd(psi^2/Hz)');
else
    disp(' PSD Output format:  freq(Hz) & psd(Pa^2/Hz)');    
end
disp(' ');
disp(' Matlab Output arrays: ');

for ivk=1:isi
     out1=sprintf('    %s',output_name_psd{ivk});  
     disp(out1);  
end
disp(' ');


disp(' SPL ASCII text arrays (tab delimited): '); 

for ivk=1:isi
     out1=sprintf('    %s',aname{ivk});  
     disp(out1);  
end
disp(' ');

     

%%%%%%%

function blocked(hObject, eventdata, handles)
%
	beta_rad=getappdata(0,'beta_rad');
    freq_i=getappdata(0,'freq_i');
    stationdiam=getappdata(0,'stationdiam');
    cspeed=getappdata(0,'cspeed');
   
% strouhal, stationdiam, cspeed,beta

	sinB=sin(beta_rad);

    ZZ=sinB*pi*freq_i*stationdiam/cspeed;

%	printf("\n ZZ=%12.4e  sinB=%12.4e  beta=%12.4e  freq(i)=%12.4e  stationdiam=%12.4e  cspeed=%12.4e \n",ZZ,sinB,beta,freq(i),PI,stationdiam,cspeed);
%   exit(1);

    if(ZZ <= 0.1)
        delta=3.;
    end

    if(ZZ > 0.1 && ZZ < 12.8)
	
		ZZ=2.*log10(1.25*ZZ)/log10(10.);

		delta=1.5*(3.+tanh(ZZ));
    end
    
    if(ZZ >= 12.8)
        delta=6.;
    end

    setappdata(0,'delta',delta);


function directivity(hObject, eventdata, handles)

%	printf("\n directivity \n");


    strouhal=getappdata(0,'strouhal');


    c1_an=getappdata(0,'c1_an');
    c2_an=getappdata(0,'c2_an');   
    c3_an=getappdata(0,'c3_an');
    c4_an=getappdata(0,'c4_an'); 
    c5_an=getappdata(0,'c5_an');     
 
    c1_dn=getappdata(0,'c1_dn');
    c2_dn=getappdata(0,'c2_dn');   
    c3_dn=getappdata(0,'c3_dn');
    c4_dn=getappdata(0,'c4_dn'); 
    c5_dn=getappdata(0,'c5_dn');     
    
    theta=getappdata(0,'theta');
    
    
    for jk=1:10
	
		if(theta >= c1_an(jk) && theta <= c1_an(jk+1) )

			len=c1_an(jk+1)-c1_an(jk);
			k2= (theta   -c1_an(jk))/len;

			k1=1.-k2;
			d1 = k1*c1_dn(jk) + k2*c1_dn(jk+1);

			break;
		
        end
    end
    
    
    for jk=1:10
	
		if(theta >= c2_an(jk) && theta <= c2_an(jk+1) )
		
			len=c2_an(jk+1)-c2_an(jk);
			k2= (theta   -c2_an(jk))/len;

			k1=1.-k2;
			d2 = k1*c2_dn(jk) + k2*c2_dn(jk+1);

			break;
		
        end
    end   

    
    for jk=1:10
	
            if(theta >= c3_an(jk) && theta <= c3_an(jk+1) )
		
                len=c3_an(jk+1)-c3_an(jk);
                k2= (theta   -c3_an(jk))/len;

                k1=1.-k2;
                d3 = k1*c3_dn(jk) + k2*c3_dn(jk+1);

                break;
		
            end
    end
 


    for jk=1:10
	
		if(theta >= c4_an(jk) && theta <= c4_an(jk+1) )
		
			len=c4_an(jk+1)-c4_an(jk);
			k2= (theta   -c4_an(jk))/len;

			k1=1.-k2;
			d4 = k1*c4_dn(jk) + k2*c4_dn(jk+1);

			break;
		
        end
    end    

    for jk=1:10
	
        if(theta >= c5_an(jk) && theta <= c5_an(jk+1) )
		
			len=c5_an(jk+1)-c5_an(jk);
			k2= (theta   -c5_an(jk))/len;

			k1=1.-k2;
			d5 = k1*c5_dn(jk) + k2*c5_dn(jk+1);

			break;
		
        end
   end     

	m1= 0.004;
	m2= 0.0125;
	m3= 0.04;
	m4= 0.125;
	m5= 0.4;

%	fprintf(pFile(1),"\n %4.1f %4.1f %4.1f %4.1f %4.1f\n",d1,d2,d3,d4,d5);

    if(strouhal <= m1)
	
		DI =d1;

%		fprintf(pFile(1)," %12.3e %12.3e %12.3e\n",strouhal,theta,DI);
    end

    if(strouhal > m1  && strouhal <= m2)
	
		len=m2-m1;
		k2=(strouhal-m1)/len;

		k1=1.-k2;
		DI = k1*d1 + k2*d2;

%		fprintf(pFile(1)," %12.3e %12.3e %12.3e\n",strouhal,theta,DI);
    end
    
    if(strouhal > m2 && strouhal <= m3)
	
		len=m3-m2;
		k2=(strouhal-m2)/len;

		k1=1.-k2;
		DI = k1*d2 + k2*d3;

%		fprintf(pFile(1)," %12.3e %12.3e %12.3e\n",strouhal,theta,DI);
    end

    if(strouhal > m3   && strouhal <= m4)
	
		len=m4-m3;
		k2=(strouhal-m3)/len;

		k1=1.-k2;
		DI = k1*d3 + k2*d4;

%		fprintf(pFile(1)," %12.3e %12.3e %12.3e\n",strouhal,theta,DI);
    end

    if(strouhal > m4  && strouhal <= m5)
	
		len=m5-m4;
		k2=(strouhal-m4)/len;

		k1=1.-k2;
		DI = k1*d4 + k2*d5;

%		fprintf(pFile(1)," %12.3e %12.3e %12.3e\n",strouhal,theta,DI);
    end
    
    if(strouhal > m5)
	
		DI =d5;

%		fprintf(pFile(1)," %12.3e %12.3e %12.3e\n",strouhal,theta,DI);
    end

%    printf(" %12.3e %12.3e %12.3e\n",strouhal,theta,DI);

%	printf("\n end directivity \n");

    setappdata(0,'DI',DI);

    
%%%    
        

function step7(hObject, eventdata, handles)
%
    disp(' step7 ref 1');

    try
        freq=getappdata(0,'freq');
        freq
    catch
        warndlg('freq error');
    end
    
    if(length(freq)<=1)
        freq
        warndlg('freq length error');
    end
    
    try
        ndirect=get(handles.listbox_max_directivity,'Value');
    catch
        warndlg('ndirect fail');
        return;
    end
    
    try
        text=getappdata(0,'text');
    catch
        warndlg('text fail');
        return;
    end
    
    try
        ntx=getappdata(0,'ntx');   
    catch
        warndlg('ntx fail');
        return;
    end
  
    try
      x1=getappdata(0,'x1');
    catch    
    end
    
    try
        rho=getappdata(0,'rho');
    catch    
        warndlg('rho fail');
        return;
    end

       U=getappdata(0,'U');
      iw=getappdata(0,'iw');

      xs=getappdata(0,'xs');  
      de=getappdata(0,'de');
     dei=getappdata(0,'dei');
     Lwb=getappdata(0,'Lwb');  
     ich=getappdata(0,'ich');  
    irad=getappdata(0,'irad');    
    igeo=getappdata(0,'igeo');    
    samp=getappdata(0,'samp');
    
    
     disp(' step7 ref 2'); 

    ilast=length(samp);
            
	nhe=1;

    if(ich==1)
		nhe=250;
    else
        disp(' ');
        disp('   f     Strouhal    Lwb   source     x      r     theta    beta     DI     delta   spl ');
        disp('  (Hz)                      (m)      (m)    (m)    (deg)    (deg)   (dB)    (dB)    (dB) ');        
    end 

    spl=zeros(ilast,1);

    progressbar;
    
    if(ilast>100)
        warndlg('ilast error');
        return;
    end
    
    ilast
    igeo
    
    xmax=0;
    rmax=0;
    theta_max=0;
    beta_max=0;
    DI_max=0;
    delta_max=0;
    
	for i=1:ilast   % frequency
        
       out1=sprintf(' freq=%8.4g Hz ',freq(i));
       disp(out1);
        
        progressbar(i/ilast);

		for jk=1:nhe   % altitude
	
            
            out1=sprintf(' i=%d jk=%d ',i,jk);
            disp(out1);
            
            try
                x1_alt=x1+(jk-1)*dei*(0.2);
            catch
                warndlg('x1_alt error');
            end

%%			if(jk==1 && (igeo==1 || igeo==2 || igeo==3) )  %undeflected
%%              break;
%%          end

			theta=180.;

			beta_rad=pi;
			beta_deg = 180.*beta_rad/pi;

			strouhal = freq(i)*de/U;
            
            out1=sprintf(' strouhal=%8.4g ',strouhal);
            disp(out1);

			if(igeo==1 || igeo==2 || igeo==3)  %undeflected
			
				r=xs+samp(i);    %samp(i) is apparent source allocation position
			
			else   %deflected

                if(ndirect==2)
                    if(samp(i)>x1_alt)
                        samp(i)=x1_alt;
                    end
                end

 				x2= samp(i)-x1_alt;
                
				if(x2 > 0. )
				
                    try
                    
%                       ry= (xs+x1)-samp(i)*sin(PI*rho/180.);

                        ry= (xs+x1_alt)-x2*sin(pi*rho/180.);

                        rx= x2*cos(pi*rho/180.);

                        r=sqrt( rx^2 + ry^2 );

                        beta_rad = atan2(ry,rx);
                        beta_deg = 180.*beta_rad/pi;

                        theta = 180. - rho - beta_deg;
                    
                    catch
                       warndlg('fail: X2>0 case');
                       return; 
                    end
				
				else   %special case where source occurs before deflection
				
%					    xs  =  station length
%					samp(i) =  apparent source allocation position

                    try

                        r = xs + x1_alt;

                        theta = 90.-rho;

                        beta_deg=-(theta-180.+rho);
                        beta_rad=beta_deg*pi/180.;
                    
                    catch
                        warndlg('Error: special case where source occurs before deflection');
                        return;    
                    end
                        
				end
            end

 
            if(theta>180)
                theta=180;
            end
            if(theta< 20)
                theta= 20;
            end
            
            out1=sprintf(' theta=%8.4g deg',theta);
            disp(out1);
            
%%		      if(ndirect==2)
%%                theta=40;
%%                rho=90-theta;
%%                beta_deg = 180. - rho -theta;
%%            end           
            
            setappdata(0,'beta_rad',beta_rad);
            setappdata(0,'theta',theta);
            setappdata(0,'strouhal',strouhal);

            iflag=0;
            try
                directivity(hObject, eventdata, handles);
            catch
                warndlg('directivity error');
                iflag=1;
                break;
            end

			ab = 8.; %hemisphere (flat ground plane)

            if(irad==2)     %sphere (free space)
				ab = 11;
            end

            try
                DI=getappdata(0,'DI');
            catch
                warndlg('DI error');
            end
            
            out1=sprintf(' DI=%8.4g ',DI);
 %%%           disp(out1);
            
            try
                spl_trial=Lwb(i)-10*log10(r^2) -ab +DI;   %SPL equation
            catch
                warndlg('spl_trial error');
                return;
            end
            
            out1=sprintf(' spl_trial=%8.4g ',spl_trial);
 %%%           disp(out1);
            
            try
                if(iw==1)
                    setappdata(0,'freq_i',freq(i));
                    blocked(hObject, eventdata, handles);
                end
            catch
                warndlg('blocked error');
                return;
            end
            
            delta=getappdata(0,'delta');
            
            out1=sprintf(' delta=%8.4g ',delta);
%%%            disp(out1);

            spl_trial=spl_trial+delta;

			if(spl_trial>spl(i) )
			
				spl(i)=spl_trial;
				xmax=x1_alt;

				theta_max=theta;
				DI_max=DI;
				delta_max=delta;
				beta_max=beta_deg;
				rmax=r;
            end
            

		end
% format


        if(i==1)
 
            text{ntx}=' ';
            ntx=ntx+1;    

            out1=sprintf('\n Zero dB reference: 20 micro Pa ');
            out2=sprintf('\n   f(Hz)   Strouhal  Lwb(i) source(m) x(m) r(m) theta(deg) beta(deg) DI(dB) delta(dB) spl(dB) \n');
        
            disp(out1);
            disp(out2);

            try
                text{ntx}=out1;
                ntx=ntx+1;
                text{ntx}=out2;
                ntx=ntx+1;             
            catch
                warndlg(' text failure 1');
                return;
            end
        end
        


%                        f(Hz) Strouhal Lwb(i)  source(m)  x(m)  r(m)  theta(deg) beta(deg)  DI(dB)  delta(dB) spl(dB);

       try
           
        fprintf('  freq(i)=%8.4g \n',freq(i));
        fprintf('  strouhal=%8.4g \n',strouhal);
        fprintf('  Lwb(i)=%8.4g \n',Lwb(i));
        fprintf('  samp(i)=%8.4g \n',samp(i));
        fprintf('  xmax=%8.4g \n',xmax);
        fprintf('  rmax=%8.4g \n',rmax);
        fprintf('  theta_max=%8.4g \n',theta_max);
        fprintf('  beta_max=%8.4g \n',beta_max);
        fprintf('  DI_max=%8.4g \n',DI_max);
        fprintf('  delta_max=%8.4g \n',delta_max);
        fprintf('  spl(i)=%8.4g \n',spl(i));

       catch
           warndlg('fprintf fail');
           return;
       end

 %       out1=sprintf('%8.1f %7.3f %8.1f %7.2f %7.2f %7.2f %6.1f %6.1f %7.2f %7.2f %7.1f',...
 %                               freq(i),strouhal,Lwb(i),samp(i),xmax,rmax,theta_max,beta_max,DI_max,delta_max,spl(i));

%        disp(out1);
      
 
              
                            
        if(ich==2)
 %           disp(out1);
        end

        try
            text{ntx}=out1;
            ntx=ntx+1;
        catch
            warndlg('Fail:  text 2');
            return;
        end

%%		fprintf(pFile[1],"%8.1f %8.4f %8.1f %7.2f %7.2f %7.2f %6.1f %6.1f %7.2f %7.2f %7.1f\n",freq(i),strouhal,Lwb(i),samp(i),xmax,rmax,theta_max,beta_max,DI_max,delta_max,spl(i));
%%		fprintf(pFile[7]," %8.4e \t %8.4e \t %8.4e \n",freq(i),samp(i),spl(i));
%%		fprintf(pFile[2],"%9.4e \t %9.4e \n",freq(i),spl(i));
%%		fprintf(pFile[3],"%9.4e \t %9.4e \n",freq(i),spl(i)+3.);


    end
    pause(0.3);
    progressbar(1);
    
    try

        setappdata(0,'spl',spl);
        setappdata(0,'text',text);
        setappdata(0,'ntx',ntx);   
    catch
        warndlg('setappdata fail');
        return;
    end
        
    if(iflag==1)
        warndlg('Directivity failure');
        return;
    end
    


function step8(hObject, eventdata, handles)
%
    
    text=getappdata(0,'text');
     ntx=getappdata(0,'ntx');  

     spl=getappdata(0,'spl');
     freq=getappdata(0,'freq');
     
    text{ntx}=' ';
    ntx=ntx+1;    
     
    out1=sprintf('  Freq(Hz)   SPL(dB) ');     
    text{ntx}=out1;
    ntx=ntx+1;    
    
    for i=1:length(freq)          
        outs=sprintf(' %8.1f  %8.1f',freq(i),spl(i));
        text{ntx}=outs;
        ntx=ntx+1;    
    end

    text{ntx}=' ';
    ntx=ntx+1;        
     
    spl
    [oadb]=oaspl_function(spl);
    setappdata(0,'oadb',oadb);

	 psi_rms=(2.9e-09)*(10^(oadb/20.));
     Pa_rms=(20e-06)*(10^(oadb/20.));


	 out1=sprintf('\n     overall SPL = %12.4g dB  ref 20 micro Pa\n',oadb);

     out2=sprintf('\n pressure in air = %8.4g psi rms ',psi_rms);
     out3=sprintf('                 = %8.4g Pa rms \n',Pa_rms);

        
     disp(out1);
     disp(out2);
     disp(out3);
     
     text{ntx}=out1;
     ntx=ntx+1;       
     text{ntx}=' ';
     ntx=ntx+1; 
     text{ntx}=out2;
     ntx=ntx+1;    
     text{ntx}=out3;
     ntx=ntx+1;        
     text{ntx}=' ';
     ntx=ntx+1;    
     
     setappdata(0,'text',text);
     setappdata(0,'ntx',ntx);      


        
%	fprintf(pFile[1],"\n\n     overall SPL = %12.3g dB   ref 20 micro Pa\n\n",oadb);

%      fprintf(pFile[1],"\n pressure in air = %8.4g psi rms  ",psi_rms);
%      fprintf(pFile[1],"\n                 = %8.4g Pa rms \n",Pa_rms);


function step6(hObject, eventdata, handles)

    igeo=getappdata(0,'igeo');
    ref=getappdata(0,'ref');
    
    if(igeo==1)  % single nozzle, undeflected (Smith & Brown)  Fig 14 from SP-8072
	
		 sns(1)=ref;
		 sns(2)=1.0e-03;
		 sns(3)=2.0;
		 sns(4)=1.0e+12;

		 asap(1)=90.;
		 asap(2)=90.;
		 asap(3)=17.;
		 asap(4)=17.*0.999;

    end
	if(igeo==2)  % single nozzle, undeflected (Morgan & Young)  Fig 14 from SP-8072
	
		 sns(1)=ref;
		 sns(2)=1.0e-03;
		 sns(3)=2.0e-02;
		 sns(4)=5.0e-02;
		 sns(5)=2.0e-00;
		 sns(6)=1.0e+12;

		 asap(1)=30.;
		 asap(2)=30.;
		 asap(3)=26.;
		 asap(4)=18.;
		 asap(5)=10.;
		 asap(6)=10.*0.999;

	end
	if(igeo==3) % multiple nozzles, undeflected   Fig 14 from SP-8072
	
		 sns(1)=ref;
		 sns(2)=1.0e-03;
		 sns(3)=7.0e-03;
		 sns(4)=1.2e-02;
		 sns(5)=1.0e-01;
		 sns(6)=2.0e-00;
		 sns(7)=1.0e+12;

		 asap(1)=90.;
		 asap(2)=90.;
		 asap(3)=45.;
		 asap(4)=35.;
		 asap(5)=17.;
		 asap(6)=10.;
		 asap(7)=10.*0.999;

	end
	if(igeo==4)  % deflected, open scoop    Fig 14 from SP-8072
	
		 sns(1)=ref;
		 sns(2)=1.0e-03;
		 sns(3)=1.0e-02;
	     sns(4)=4.0e-02;
		 sns(5)=1.0e-01;
	     sns(6)=5.0e-01;
		 sns(7)=1.0e-00;
		 sns(8)=2.0e-00;
		 sns(9)=1.0e+12;

		 asap(1)=35.;
		 asap(2)=35.;
		 asap(3)=32.;
		 asap(4)=25.;
		 asap(5)=18.;
		 asap(6)=5.;
		 asap(7)=2.1;
		 asap(8)=0.2;
		 asap(9)=0.2*0.999;

    end
    if(igeo==5) % deflected, closed bucket   Fig 14 from SP-8072
	
		 sns(1)=ref;
		 sns(2)=1.0e-03;
		 sns(3)=5.0e-02;
		 sns(4)=1.0e-01;
		 sns(5)=1.0e-00;
		 sns(6)=1.0e+12;

		 asap(1)=17.;
		 asap(2)=17.;
		 asap(3)=8.;
		 asap(4)=6.;
		 asap(5)=0.3;
		 asap(6)=0.3*0.999;
    end
    
    if(igeo<=5)
        setappdata(0,'sns',sns);
        setappdata(0,'asap',asap);    
    end
    
    if(igeo ~=6 && igeo ~=7)
		source_allocate(hObject, eventdata, handles);
    else
		source_allocate_Eldred_Wilby(hObject, eventdata, handles)
    end
    

    
function source_allocate(hObject, eventdata, handles)
%
    disp('  ');
    disp(' source allocation ');
    disp('  ');

    freq=getappdata(0,'freq');
      de=getappdata(0,'de');
       U=getappdata(0,'U');
     sns=getappdata(0,'sns');
    asap=getappdata(0,'asap');
    
    ilast=length(freq);
      num=length(sns);

    samp=zeros(ilast,1);  
      
    for i=1:ilast
	
		strouhal = freq(i)*de/U;

        for j=1:(num-1)
		
			if(strouhal==sns(j))
			
                samp(i)=asap(i);   % asap - apparent source allocation position
				break;
                
			end
			if(strouhal>sns(j) && strouhal<sns(j+1) )
			
				slope=log10(asap(j+1)/asap(j))/log10(sns(j+1)/sns(j));

				samp(i) = asap(j)*(strouhal/sns(j))^slope;

                if(i>1 && samp(i) > samp(i-1) )
				
                    out1=sprintf('samp(%d)= %8.3g  asap= %8.3g str= %8.3g  sns(%d)= %8.3g  slope= %8.3g ',...
                                i,samp(i),asap(j),strouhal,j,sns(j),slope);
                    disp(out1);

                end
                
				break;
                
			end
        end
    end

    samp=samp*de;

    setappdata(0,'samp',samp);
%
          
function source_allocate_Eldred_Wilby(hObject, eventdata, handles)
%
    disp('  ');
	disp(' source allocation (Eldred & Wilby) ');
    disp('  ');
    
    freq=getappdata(0,'freq');
      de=getappdata(0,'de');
       U=getappdata(0,'U');
    
    ilast=length(freq);
 
    samp=zeros(ilast,1);
    
	for i=1:ilast
	
		strouhal = freq(i)*de/U;

		if( strouhal <= 1.87)
		
			sigma=log10(strouhal) - 0.5645;

            yn=1.61273 + 1.550865/( exp(sigma)-exp(-sigma) );

			samp(i) = 10^yn;

        else		
			samp(i)=0.1;
		end

	end

    samp=samp*de;
    setappdata(0,'samp',samp);
%


function step5(hObject, eventdata, handles)


    text=getappdata(0,'text');
    ntx=getappdata(0,'ntx'); 

   ref=getappdata(0,'ref');
    de=getappdata(0,'de');
     U=getappdata(0,'U');   
    LW=getappdata(0,'LW');
   
    
  %%%
  
    [sn,nrspl,num]=sn_nrspl();

    [fl,fc,fu,imax]=one_third_octave_frequencies();
    
    
    ffmin=str2num(get(handles.edit_ffmin,'String'));
    ffmax=str2num(get(handles.edit_ffmax,'String'));   
    
    if(isempty(ffmin))
        warndlg('Enter min frequency');
        return;
    end
    if(isempty(ffmax))
        warndlg('Enter max frequency');
        return;
    end    
    
        
    [~,idx1]=min(abs(fc-ffmin));
    [~,idx2]=min(abs(fc-ffmax));    
    
    freq=fc(idx1:idx2);
    
    freq=fix_size(freq);
    
	ilast = length(freq);
    
    setappdata(0,'freq',freq);
    
    
    amp=zeros(ilast,1);

    for i=1:ilast
    
        iflag=0;  
      
        strouhal = freq(i)*de/U;
            
        
        for j=1:num-1
        
                if(strouhal==sn(j))
            
                    amp(i)=nrspl(i);
 
                    break;
                end

            
                if( strouhal>sn(j) && strouhal<sn(j+1) )    
 
                    slope=log10(nrspl(j+1)/nrspl(j))/log10(sn(j+1)/sn(j));
 
                    az=log10(nrspl(j));
                    az=az+slope*(log10(strouhal)-log10(sn(j)));
 
                    amp(i)=10^az;
                    break;
                end
        end
        
        
        if(isnan(amp(i)))
            warndlg('amp(i) NaN');
            out1=sprintf(' %8.4g  %8.4g  NaN',freq(i),strouhal);
            disp(out1);
            pause(20);
            return;
        end        
 
    end 

    Lwb=zeros(ilast,1);

    
    sss=str2num(get(handles.edit_slope,'String'));
    ss=-abs(sss)/3;

    
	for i=1:ilast   % Lwb = Sound Power Level
	
        df = ((2^(1/6))-1/(2^(1/6)))*freq(i);

		Lwb(i)= 10*log10(amp(i)/ref) +LW -10*log10(U/de) +10*log10(df);
        
        if(isnan(Lwb(i)))
            warndlg('Lwb(i) NaN');
            return;
        end

		if( i>=2 && (Lwb(i)-Lwb(i-1) ) < ss )
		
            Lwb(i)=Lwb(i-1)+ss;
		end

%		printspl();
	end    
    
    setappdata(0,'freq',freq);
    setappdata(0,'amp',amp);
    setappdata(0,'Lwb',Lwb); 
    
    
    
    text{ntx}=' ';
    ntx=ntx+1;    
   
    text{ntx}=' Source Sound Power (ref= 1 pico Watt)';
    ntx=ntx+1;  
    text{ntx}='   Freq(Hz)     Lwb(dB)';
    ntx=ntx+1;     
    
 	for i=1:ilast    
        text{ntx}=sprintf(' %8.1f   %8.1f',freq(i),Lwb(i));
        ntx=ntx+1;         
    end
    
    setappdata(0,'text',text);
    setappdata(0,'ntx',ntx);   
   
    
    
% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(liftoff);


% --- Executes on selection change in listbox_motor.
function listbox_motor_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_motor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_motor contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_motor

%%%

N_per_lbf = 4.448;
lbf_per_N = 1./N_per_lbf;

m_per_ft = 0.3048;
ft_per_m = 1./m_per_ft;

m_per_inch = 0.3048/12.;
inch_per_m=1./m_per_inch;

%%%

     thrust_2=0;
   diameter_2=0;  
      velox_2=0;

%%%

set(handles.text_num_nozzles,'Visible','on');
set(handles.edit_num_nozzles,'Visible','on');
set(handles.edit_num_nozzles,'String','1'); 


n=get(handles.listbox_motor,'Value');

iu=get(handles.listbox_units,'Value');

set(handles.text_m_1,'Visible','off');
set(handles.text_m_2,'Visible','off');



set(handles.text_thrust_2,'Visible','off');
set(handles.edit_thrust_2,'Visible','off');

set(handles.text_diameter_2,'Visible','off');
set(handles.edit_diameter_2,'Visible','off');

set(handles.text_velox_2,'Visible','off');
set(handles.edit_velox_2,'Visible','off');


if(n==2 || n==7)
    
    set(handles.text_thrust_2,'Visible','on');
    set(handles.edit_thrust_2,'Visible','on');

    set(handles.text_diameter_2,'Visible','on');
    set(handles.edit_diameter_2,'Visible','on');
    
    set(handles.text_velox_2,'Visible','on');
    set(handles.edit_velox_2,'Visible','on');    
    
end


if(iu==1)
    set(handles.text_diameter_1,'String','Nozzle Diameter (in)');
    set(handles.text_thrust_1,'String','Thrust (lbf)');
    set(handles.text_velox_1,'String','Exhaust Velocity (ft/sec)');
    set(handles.text_diameter_2,'String','Nozzle Diameter (in)');
    set(handles.text_thrust_2,'String','Thrust (lbf)');   
    set(handles.text_velox_2,'String','Exhaust Velocity (ft/sec)');    
else
    set(handles.text_diameter_1,'String','Nozzle Diameter (m)'); 
    set(handles.text_thrust_1,'String','Thrust (N)');   
    set(handles.text_velox_1,'String','Exhaust Velocity (m/sec)');    
    set(handles.text_diameter_2,'String','Nozzle Diameter (m)'); 
    set(handles.text_thrust_2,'String','Thrust (N)');  
    set(handles.text_velox_2,'String','Exhaust Velocity (m/sec)');      
end



if(n==2)  % SR-19 with two MLRS Stap-ons
    
    set(handles.text_m_1,'String','SR-19');
    set(handles.text_m_2,'String','MLRS');
    
end    

if(n==7)  % SLS Core Stage & SRBs
    
    set(handles.text_m_1,'String','Core Stage');
    set(handles.text_m_2,'String','SRB');
    
end   


if(n==6 || n==7 || n==8)
    set(handles.text_num_nozzles,'Visible','on');
    set(handles.edit_num_nozzles,'Visible','on');
end

%%%%%%%%%%%%%%%

if(n==1 || n==2)  % SR-19
     thrust_1=50000;
   diameter_1=28.5;
      velox_1=9254;
end

if(n==2)  % SR-19 with two MLRS Strap-ons
     thrust_2=37000;
   diameter_2=9;
      velox_2=7600;   
end

if(n==3)  % Castor 4B
     thrust_1=1.12e+005;
   diameter_1=37.5;
      velox_1=8475;   
end

if(n==4)  % Castor 120
     thrust_1=2.95e+005;
   diameter_1=63.0;
      velox_1=9060;   
end

if(n==5)  % Peacekeeper 1
     thrust_1=5.70e+005;
   diameter_1=60.9;
      velox_1=9060;  
end

if(n==6)  % NK-33
     thrust_1=3.425e+005;
   diameter_1=58.7;
      velox_1=10000;   
end

if(n==7)  %  SLS Core Stage & SRBS
    
     thrust_1=417500;
   diameter_1=96;
      velox_1=14590; 
      
     thrust_2=3.6e+06;
   diameter_2=149.6;
      velox_2=8436;   
end

if(n==8)  % BE-3 Liftoff
     thrust_1=110000;
   diameter_1=25.6;
      velox_1=12168;   
end
if(n==9)  % BE-3 Max Descent
     thrust_1=72800;
   diameter_1=25.6;
      velox_1=12000;   
end
if(n==10)  % BE-3 Touchdown
     thrust_1=15000;
   diameter_1=25.6;
      velox_1=12000;   
end
if(n==11)  % BE-4 Liftoff
     thrust_1=605000;
   diameter_1=76;
      velox_1=10934;   
end

if(iu==2)
    
    thrust_1=thrust_1*N_per_lbf;
    thrust_2=thrust_2*N_per_lbf;
    
    diameter_1=diameter_1*m_per_inch;
    diameter_2=diameter_2*m_per_inch;
    
    velox_1=velox_1*m_per_ft;
    velox_2=velox_2*m_per_ft;    
    
end

if(n==2 || n==7)
    set(handles.text_m_1,'Visible','on');
    set(handles.text_m_2,'Visible','on');
end

if(n==7)
    set(handles.edit_num_nozzles,'String','4'); 
end
if(n==11)
    set(handles.edit_num_nozzles,'String','7'); 
end


if(n<=11)

    st1=sprintf('%9.5g',thrust_1);
    st2=sprintf('%9.5g',thrust_2);

    sd1=sprintf('%9.5g',diameter_1);
    sd2=sprintf('%9.5g',diameter_2);

    sv1=sprintf('%9.5g',velox_1);
    sv2=sprintf('%9.5g',velox_2);
    
else
    
    st1='';
    st2='';

    sd1='';
    sd2='';   
    
    sv1='';
    sv2='';
    
end    


set(handles.edit_thrust_1,'String',st1);
set(handles.edit_thrust_2,'String',st2);

set(handles.edit_diameter_1,'String',sd1);
set(handles.edit_diameter_2,'String',sd2);

set(handles.edit_velox_1,'String',sv1);
set(handles.edit_velox_2,'String',sv2);



% --- Executes during object creation, after setting all properties.
function listbox_motor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_motor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_aceff_Callback(hObject, eventdata, handles)
% hObject    handle to edit_aceff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_aceff as text
%        str2double(get(hObject,'String')) returns contents of edit_aceff as a double


% --- Executes during object creation, after setting all properties.
function edit_aceff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_aceff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thrust_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thrust_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thrust_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_thrust_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_thrust_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thrust_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thrust_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thrust_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thrust_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_thrust_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_thrust_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thrust_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_diameter_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_diameter_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_diameter_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_diameter_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_diameter_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_diameter_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_diameter_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_diameter_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_diameter_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_diameter_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_diameter_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_diameter_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_igeo.
function listbox_igeo_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_igeo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_igeo contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_igeo

igeo=get(handles.listbox_igeo,'Value');

set(handles.text_distance_nozzle,'Visible','off');
set(handles.edit_distance_nozzle,'Visible','off');
set(handles.text_length_unit,'Visible','off');
set(handles.text_rho,'Visible','off');
set(handles.text_deg,'Visible','off');
set(handles.edit_rho,'Visible','off');

if(igeo==4 || igeo==5 || igeo==6 || igeo==7)

    set(handles.text_distance_nozzle,'Visible','on');
    set(handles.edit_distance_nozzle,'Visible','on');
    set(handles.text_length_unit,'Visible','on');
    set(handles.text_rho,'Visible','on');
    set(handles.text_deg,'Visible','on');    
    set(handles.edit_rho,'Visible','on');

end    



% --- Executes during object creation, after setting all properties.
function listbox_igeo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_igeo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_num_nozzles_Callback(hObject, eventdata, handles)
% hObject    handle to edit_num_nozzles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_num_nozzles as text
%        str2double(get(hObject,'String')) returns contents of edit_num_nozzles as a double


% --- Executes during object creation, after setting all properties.
function edit_num_nozzles_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_num_nozzles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_velox_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_velox_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_velox_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_velox_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_velox_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_velox_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_velox_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_velox_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_velox_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_velox_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_velox_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_velox_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_stations.
function pushbutton_stations_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_stations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=liftoff_stations;

set(handles.s,'Visible','on')



function edit_C_Callback(hObject, eventdata, handles)
% hObject    handle to edit_C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_C as text
%        str2double(get(hObject,'String')) returns contents of edit_C as a double


% --- Executes during object creation, after setting all properties.
function edit_C_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_irad.
function listbox_irad_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_irad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_irad contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_irad


% --- Executes during object creation, after setting all properties.
function listbox_irad_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_irad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_iw.
function listbox_iw_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_iw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_iw contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_iw


% --- Executes during object creation, after setting all properties.
function listbox_iw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_iw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_distance_nozzle_Callback(hObject, eventdata, handles)
% hObject    handle to edit_distance_nozzle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_distance_nozzle as text
%        str2double(get(hObject,'String')) returns contents of edit_distance_nozzle as a double


% --- Executes during object creation, after setting all properties.
function edit_distance_nozzle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_distance_nozzle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_rho_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rho (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rho as text
%        str2double(get(hObject,'String')) returns contents of edit_rho as a double


% --- Executes during object creation, after setting all properties.
function edit_rho_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rho (see GCBO)
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


    disp('**ref a**');

try
    mp=get(handles.edit_main_prefix,'String');
    LiftoffSettings.mp=mp;     
end


try
    slope=get(handles.edit_slope,'String');
    LiftoffSettings.slope=slope;  
end
try
    iascent=get(handles.listbox_ascent,'Value');
    LiftoffSettings.iascent=iascent;  
end
try
    isys=get(handles.listbox_units,'Value');
    LiftoffSettings.isys=isys;    
end
try
    motor=get(handles.listbox_motor,'Value');
    LiftoffSettings.motor=motor;    
end
try
    irad=get(handles.listbox_irad,'Value');
    LiftoffSettings.irad=irad;    
end
try
    iw=get(handles.listbox_iw,'Value');
    LiftoffSettings.iw=iw;    
end
try
    igeo=get(handles.listbox_igeo,'Value');
    LiftoffSettings.igeo=igeo;    
end
try
    aceff=str2num(get(handles.edit_aceff,'String'));
    LiftoffSettings.aceff=aceff;   
end
try
    cspeed=str2num(get(handles.edit_C,'String'));
    LiftoffSettings.cspeed=cspeed;    
end    
    num_nozzles=str2num(get(handles.edit_num_nozzles,'String'));
    LiftoffSettings.num_nozzles=num_nozzles;    
try    
    LiftoffSettings.xl=str2num(get(handles.edit_distance_nozzle,'String'))'
end
try
    rho=str2num(get(handles.edit_rho,'String'));
    LiftoffSettings.rho=rho;    
end
try
    thrust_1=str2num(get(handles.edit_thrust_1,'String'));
    LiftoffSettings.thrust_1=thrust_1;    
end
try
    diameter_1=str2num(get(handles.edit_diameter_1,'String'));
    LiftoffSettings.diameter_1=diameter_1;    
end
try
    velox_1=str2num(get(handles.edit_velox_1,'String'));
    LiftoffSettings.velox_1=velox_1;    
end
try
    thrust_2=str2num(get(handles.edit_thrust_2,'String'));
    LiftoffSettings.thrust_2=thrust_2;    
end
try
    diameter_2=str2num(get(handles.edit_diameter_2,'String'));
    LiftoffSettings.diameter_2=diameter_2;    
end
try
    velox_2=str2num(get(handles.edit_velox_2,'String')); 
    LiftoffSettings.velox_2=velox_2;    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    prefix=getappdata(0,'prefix');
    LiftoffSettings.prefix=prefix;    
end
try
    q_L=getappdata(0,'q_length');
    LiftoffSettings.q_L=q_L;    
end
try
    q_sdiam=getappdata(0,'q_diameter');
    LiftoffSettings.sdiam=sdiam;    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    L=getappdata(0,'length');
    LiftoffSettings.L=L;    
end
try
    sdiam=getappdata(0,'diameter');
    LiftoffSettings.sdiam=sdiam;    
end
try
    n_stations=getappdata(0,'n_stations');
    LiftoffSettings.n_stations=n_stations;    
end

try
    data_s=getappdata(0,'data_s');
    LiftoffSettings.data_s=data_s;     
end
    
% % %

structnames = fieldnames(LiftoffSettings, '-full'); % fields in the struct

% % %

   [writefname, writepname] = uiputfile('*.mat','Save data as');

   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);

    try
 
        save(elk, 'LiftoffSettings'); 
 
    catch
        warndlg('Save error');
        return;
    end
 
%%%@@@@@

    disp('**ref b**');
     
 
    NTHM{1,:}=sprintf('%s%s',writepname,writefname);

    try
        filename = 'liftoff_load_list.txt';
        THM=importdata(filename);
        
         sz=size(THM);
        
         num=sz(1);
        
         if(num>20)
             num=20;
         end
         
      

    catch
         disp('no read 1');       
    end
        
   
    THM=sort(THM);
    
    for i=1:num
        NTHM{i+1,:}=THM(i,:);       
    end    
  
    disp('**ref c**');
        
    for j=1:5
        
        sz=size(NTHM);
        num=sz(1);
        
 %%       out1=sprintf('j=%d num=%d',j,num);
 %%       disp(out1);
        
        for i=num:-1:2

            s1=(NTHM{1,:});
            s2=(NTHM{i,:});
            
            if( strcmp(s1,s2))
                NTHM{1,:}=[];
                disp('break');
                break;
            end
        end
        
    end

       
    sz=size(NTHM);
    nrows=sz(1);
    
    fileID = fopen(filename,'w');

    for row = 1:nrows
        fprintf(fileID,'%s\n',char(NTHM{row,:}));
    end
    fclose(fileID);
    
    
%%%@@@@@

    msgbox('Save complete');



% --- Executes on button press in pushbutton_load.
function pushbutton_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile('*.mat');

setappdata(0,'filename',filename);
setappdata(0,'pathname',pathname);
 
load_core(hObject, eventdata, handles)


function load_core(hObject, eventdata, handles)

disp('*** ref 1 ***');

filename=getappdata(0,'filename')
% pathname=getappdata(0,'pathname')

try
%    NAME = [pathname,filename];
%    struct=load(NAME);
     struct=load(filename);
catch    
    filename=sprintf('anteater_%s',filename);
    filename=strrep(filename,'anteater_','\');
    NAME = [pathname,filename];
    
    try
        struct=load(NAME);
    catch
        NAME
        warndlg('load failed');
        return;
    end
    
end




structnames = fieldnames(struct, '-full'); % fields in the struct

k=length(structnames);

for i=1:k
    namevar=strcat('struct.',structnames{i});
    value=eval(namevar);
    assignin('base',structnames{i},value);
end

% struct

try
   LiftoffSettings=evalin('base','LiftoffSettings');
catch
   warndlg(' evalin failed ');
   return;
end

%%%%%%%%%%%%%%%%%%

try
    data_s=LiftoffSettings.data_s;    
    setappdata(0,'data_s',data_s);
end

try
    mp=LiftoffSettings.mp;      
    set(handles.edit_main_prefix,'String',mp);
catch
end


try
    slope=LiftoffSettings.slope;     
    set(handles.edit_slope,'String',slope);
catch    
end

try
    isys=LiftoffSettings.isys;
    setappdata(0,'isys',isys);
    set(handles.listbox_units,'Value',isys);
    listbox_units_Callback(hObject, eventdata, handles);    
catch    
end

try
    iascent=LiftoffSettings.iascent;      
    set(handles.listbox_ascent,'Value',iascent);
catch    
end

try
    motor=LiftoffSettings.motor;  
    set(handles.listbox_motor,'Value',motor);
    listbox_motor_Callback(hObject, eventdata, handles);    
catch
end

try
    irad=LiftoffSettings.irad;  
    set(handles.listbox_irad,'Value',irad);    
catch
end

try
    iw=LiftoffSettings.iw; 
    set(handles.listbox_iw,'Value',iw);    
catch
end

try
    igeo=LiftoffSettings.igeo; 
    set(handles.listbox_igeo,'Value',igeo);    
    listbox_igeo_Callback(hObject, eventdata, handles);    
catch
end

try
    aceff=LiftoffSettings.aceff; 
    ss=sprintf('%g',aceff);
    set(handles.edit_aceff,'String',ss);    
catch
end

try
    cspeed=LiftoffSettings.cspeed;
    ss=sprintf('%g',cspeed);
    set(handles.edit_C,'String',ss);    
catch
end

try
    num_nozzles=LiftoffSettings.num_nozzles;
    ss=sprintf('%d',num_nozzles);
    set(handles.edit_num_nozzles,'String',ss);    
catch
end

try
    ss=sprintf('%g',LiftoffSettings.xl); 
    set(handles.edit_distance_nozzle,'String',ss);   
catch
end

try
    rho=LiftoffSettings.rho;    
    ss=sprintf('%g',rho);
    set(handles.edit_rho,'String',ss);        
catch
end

try
    thrust_1=LiftoffSettings.thrust_1;   
    ss=sprintf('%g',thrust_1);
    set(handles.edit_thrust_1,'String',ss);    
catch
end

try
    diameter_1=LiftoffSettings.diameter_1;  
    ss=sprintf('%g',diameter_1);
    set(handles.edit_diameter_1,'String',ss);     
catch
end

try
    velox_1=LiftoffSettings.velox_1; 
    ss=sprintf('%g',velox_1);
    set(handles.edit_velox_1,'String',ss);     
catch
end

try
    thrust_2=LiftoffSettings.thrust_2;  
    ss=sprintf('%g',thrust_2);
    set(handles.edit_thrust_2,'String',ss);       
catch
end

try
    diameter_2=LiftoffSettings.diameter_2;        
    ss=sprintf('%g',diameter_2);
    set(handles.edit_diameter_2,'String',ss);     
catch
end

try
    velox_2=LiftoffSettings.velox_2;   
    ss=sprintf('%g',velox_2);
    set(handles.edit_velox_2,'String',ss);      
catch
end

try
    prefix=LiftoffSettings.prefix; 
    setappdata(0,'prefix',prefix);
catch
end

try
    q_L=LiftoffSettings.q_L; 
    setappdata(0,'q_length',q_L);   
catch
end

try
    L=LiftoffSettings.L; 
    setappdata(0,'length',L);   
catch
end


try
    sdiam=LiftoffSettings.sdiam; 
    setappdata(0,'q_diameter',sdiam);       
    setappdata(0,'diameter',sdiam);      
catch
end

try
    n_stations=LiftoffSettings.n_stations;   
    setappdata(0,'n_stations',n_stations);     
catch
end

liftoff_stations;

disp(' ');
disp('Load complete');
msgbox('Load Complete');


function c1(hObject, eventdata, handles)
	an(1)=  20.;
	an(2)=	28.;
	an(3)=	32.;
	an(4)=	40.;
	an(5)=	60.;
	an(6)=	80.;
	an(7)=	100.;
	an(8)=	140.;
	an(9)=	150.;
	an(10)=	160.;
	an(11)=  180.;

	dn(1)=	3.5;
	dn(2)=	7.5;
	dn(3)=	7.5;
	dn(4)=	6.;
	dn(5)=	0.65;
	dn(6)=	-4.5;
	dn(7)=	-9.;
	dn(8)=	-14.;
	dn(9)=	-15.;
	dn(10)=	-16.;
	dn(11)=	-17.2;
	setappdata(0,'c1_an',an);
	setappdata(0,'c1_dn',dn);

function c2(hObject, eventdata, handles)

	an(1)=  20.;
	an(2)=	30.;
	an(3)=	32.;
	an(4)=	38.;
	an(5)=	40.;
	an(6)=	43.;
	an(7)=	60.;
	an(8)=	100.;
	an(9)=	140.;
	an(10)=	160.;
	an(11)=  180.;

	dn(1)=	0.;
	dn(2)=	3.5;
	dn(3)=	6.0;
	dn(4)=	6.3;
	dn(5)=	6.0;
	dn(6)=	2.5;
	dn(7)=	-7.5;
	dn(8)=	-13.5;
	dn(9)=	-15.5;
	dn(10)=	-16.;
	dn(11)=	-17.;

	setappdata(0,'c2_an',an);
	setappdata(0,'c2_dn',dn);


function c3(hObject, eventdata, handles)
	an(1)=  20.;
	an(2)=	30.;
	an(3)=	40.;
	an(4)=	48.;
	an(5)=	52.;
	an(6)=	60.;
	an(7)=	100.;
	an(8)=	120.;
	an(9)=	140.;
	an(10)=	160.;
	an(11)=  180.;

	dn(1)=	-1.;
	dn(2)=	2.1;
	dn(3)=	5.0;
	dn(4)=	5.5;
	dn(5)=	5.5;
	dn(6)=	3.5;
	dn(7)=	-7.;
	dn(8)=	-9.9;
	dn(9)=	-12.5;
	dn(10)=	-14.5;
	dn(11)=	-16.;
	setappdata(0,'c3_an',an);
	setappdata(0,'c3_dn',dn);

function c4(hObject, eventdata, handles)

	an(1)=  20.;
	an(2)=	30.;
	an(3)=	40.;
	an(4)=	50.;
	an(5)=	60.;
	an(6)=	100.;
	an(7)=	120.;
	an(8)=	140.;
	an(9)=	160.;
	an(10)=	160.;
	an(11)=  180.;

	dn(1)=	-2.;
	dn(2)=	1.5;
	dn(3)=	3.5;
	dn(4)=	5.0;
	dn(5)=	4.0;
	dn(6)=	-5.5;
	dn(7)=	-9.;
	dn(8)=	-11.5;
	dn(9)=	-12.8;
	dn(10)=	-13.4;
	dn(11)=	-14.;

	setappdata(0,'c4_an',an);
	setappdata(0,'c4_dn',dn);

function c5(hObject, eventdata, handles)

	an(1)=  20.;
	an(2)=	30.;
	an(3)=	40.;
	an(4)=	57.;
	an(5)=	60.;
	an(6)=	80.;
	an(7)=	100.;
	an(8)=	120.;
	an(9)=	140.;
	an(10)=	160.;
	an(11)=  180.;

	dn(1)=	-2.5;
	dn(2)=	0.9;
	dn(3)=	2.8;
	dn(4)=	4.;
	dn(5)=	4.;
	dn(6)=	1.;
	dn(7)=	-4.;
	dn(8)=	-8.;
	dn(9)=	-10.;
	dn(10)=	-12.;
	dn(11)=	-13.;

	setappdata(0,'c5_an',an);
	setappdata(0,'c5_dn',dn);


% --- Executes on selection change in listbox_ascent.
function listbox_ascent_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_ascent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_ascent contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_ascent


% --- Executes during object creation, after setting all properties.
function listbox_ascent_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_ascent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_Franken.
function pushbutton_Franken_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Franken (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=Franken_method;    
    
set(handles.s,'Visible','on'); 


% --- Executes on selection change in listbox_max_directivity.
function listbox_max_directivity_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_max_directivity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_max_directivity contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_max_directivity


% --- Executes during object creation, after setting all properties.
function listbox_max_directivity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_max_directivity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton_load_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton_load_list.
function pushbutton_load_list_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

liftoff_load;

uiwait()

uiresume(liftoff_load)

delete(liftoff_load);

Lflag=getappdata(0,'Lflag');


if(Lflag==0)
    
    load_core(hObject, eventdata, handles);

    delete(liftoff_load);

else
    delete(liftoff_load);    
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



function edit_main_prefix_Callback(hObject, eventdata, handles)
% hObject    handle to edit_main_prefix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_main_prefix as text
%        str2double(get(hObject,'String')) returns contents of edit_main_prefix as a double


% --- Executes during object creation, after setting all properties.
function edit_main_prefix_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_main_prefix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ffmin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ffmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ffmin as text
%        str2double(get(hObject,'String')) returns contents of edit_ffmin as a double


% --- Executes during object creation, after setting all properties.
function edit_ffmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ffmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ffmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ffmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ffmax as text
%        str2double(get(hObject,'String')) returns contents of edit_ffmax as a double


% --- Executes during object creation, after setting all properties.
function edit_ffmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ffmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

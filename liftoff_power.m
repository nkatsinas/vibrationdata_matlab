function varargout = liftoff_power(varargin)
% LIFTOFF_POWER MATLAB code for liftoff_power.fig
%      LIFTOFF_POWER, by itself, creates a new LIFTOFF_POWER or raises the existing
%      singleton*.
%
%      H = LIFTOFF_POWER returns the handle to a new LIFTOFF_POWER or the handle to
%      the existing singleton*.
%f
%      LIFTOFF_POWER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LIFTOFF_POWER.M with the given input arguments.
%
%      LIFTOFF_POWER('Property','Value',...) creates a new LIFTOFF_POWER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before liftoff_power_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to liftoff_power_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help liftoff_power

% Last Modified by GUIDE v2.5 28-Feb-2019 11:58:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @liftoff_power_OpeningFcn, ...
                   'gui_OutputFcn',  @liftoff_power_OutputFcn, ...
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


% --- Executes just before liftoff_power is made visible.
function liftoff_power_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to liftoff_power (see VARARGIN)

% Choose default command line output for liftoff_power
handles.output = hObject;

set(handles.listbox_motor,'Value',1);
set(handles.listbox_units,'Value',1);


listbox_units_Callback(hObject, eventdata, handles);
listbox_motor_Callback(hObject, eventdata, handles);
listbox_igeo_Callback(hObject, eventdata, handles);


set(handles.uipanel_save,'Visible','off');   

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes liftoff_power wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = liftoff_power_OutputFcn(hObject, eventdata, handles) 
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
else
   set(handles.text_C,'String','Sound Speed (m/sec)');    
   set(handles.edit_C,'String','343');   
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



isi=length(L);

%%%%%%%

isys=get(handles.listbox_units,'Value');
setappdata(0,'isys',isys);

irad=get(handles.listbox_irad,'Value');
setappdata(0,'irad',irad);


igeo=get(handles.listbox_igeo,'Value');
setappdata(0,'igeo',igeo);


motor=get(handles.listbox_motor,'Value');
setappdata(0,'motor',motor);

N=1;

if(motor==6 || motor==7 || motor==8)
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
    
WOA=0.5*aceff*MP;   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(isys==1)
    diameter_1=diameter_1*m_per_inch;    
    diameter_2=diameter_2*m_per_inch;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% display motor name

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



if(motor==2 || motor==7)
    de=sqrt( N*diameter_1^2  + 2*diameter_2^2 );
else    
    de=sqrt(N)*diameter_1;    
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


ilast=length(freq);

disp(' ');
disp(' Source Sound Power (ref= 1 pico Watt)'); 
disp('   Freq(Hz)     Lwb(dB)');
 
for i=1:ilast    
    out1=sprintf(' %8.1f   %8.1f',freq(i),Lwb(i));
    disp(out1);
end
disp(' ');


freq=fix_size(freq);
Lwb=fix_size(Lwb);


fig_num=1;

[fig_num]=power_dB_plot(fig_num,1,freq,Lwb)

setappdata(0,'Lwb',[freq Lwb]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



 

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

    text=getappdata(0,'text');
     ntx=getappdata(0,'ntx');   

  
    try
      x1=getappdata(0,'x1');
    catch    
    end
    
    try
        rho=getappdata(0,'rho');
    catch    
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
    freq=getappdata(0,'freq');

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
    
	for i=1:ilast   % frequency
        
        progressbar(i/ilast);

		for jk=1:nhe   % altitude
		
			x1_alt=x1+(jk-1)*dei*(0.2);


%%			if(jk==1 && (igeo==1 || igeo==2 || igeo==3) )  %undeflected
%%              break;
%%          end

			theta=180.;

			beta_rad=pi;
			beta_deg = 180.*beta_rad/pi;

			strouhal = freq(i)*de/U;

			if(igeo==1 || igeo==2 || igeo==3)  %undeflected
			
				r=xs+samp(i);    %samp(i) is apparent source allocation position
			
			else   %deflected

				x2= samp(i) -x1_alt;
                

				if(x2 > 0. )
				
%					ry= (xs+x1)-samp(i)*sin(PI*rho/180.);

					ry= (xs+x1_alt)-x2*sin(pi*rho/180.);

					rx= x2*cos(pi*rho/180.);

					r=sqrt( rx^2 + ry^2 );

					beta_rad = atan2(ry,rx);
					beta_deg = 180.*beta_rad/pi;

					theta = 180. - rho - beta_deg;
				
				else   %special case where source occurs before deflection
				
%					    xs  =  station length
%					samp(i) =  apparent source allocation position

					r = xs + x1_alt;

					theta = 90.-rho;

                    beta_deg=-(theta-180.+rho);
					beta_rad=beta_deg*pi/180.;

				end
            end

            if(theta>180)
                theta=180;
            end
            if(theta< 20)
                theta= 20;
            end
            
            setappdata(0,'beta_rad',beta_rad);
            setappdata(0,'theta',theta);
            setappdata(0,'strouhal',strouhal);

            iflag=0;
            try
                directivity(hObject, eventdata, handles);
            catch
                iflag=1;
                break;
            end

			ab = 8.; %hemisphere (flat ground plane)

            if(irad==2)     %sphere (free space)
				ab = 11;
            end

            DI=getappdata(0,'DI');

			spl_trial=Lwb(i)-10*log10(r^2) -ab +DI;   %SPL equation

            if(iw==1)
                setappdata(0,'freq_i',freq(i));
				blocked(hObject, eventdata, handles);
            end
            
            delta=getappdata(0,'delta');

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

            text{ntx}=out1;
            ntx=ntx+1;
            text{ntx}=out2;
            ntx=ntx+1;             
            
        end

%                        f(Hz) Strouhal Lwb(i)  source(m)  x(m)  r(m)  theta(deg) beta(deg)  DI(dB)  delta(dB) spl(dB);

        out1=sprintf('%8.1f %7.3f %8.1f %7.2f %7.2f %7.2f %6.1f %6.1f %7.2f %7.2f %7.1f',...
                                freq(i),strouhal,Lwb(i),samp(i),xmax,rmax,theta_max,beta_max,DI_max,delta_max,spl(i));

        if(ich==2)
            disp(out1);
        end
            
        text{ntx}=out1;
        ntx=ntx+1;    

%%		fprintf(pFile[1],"%8.1f %8.4f %8.1f %7.2f %7.2f %7.2f %6.1f %6.1f %7.2f %7.2f %7.1f\n",freq(i),strouhal,Lwb(i),samp(i),xmax,rmax,theta_max,beta_max,DI_max,delta_max,spl(i));
%%		fprintf(pFile[7]," %8.4e \t %8.4e \t %8.4e \n",freq(i),samp(i),spl(i));
%%		fprintf(pFile[2],"%9.4e \t %9.4e \n",freq(i),spl(i));
%%		fprintf(pFile[3],"%9.4e \t %9.4e \n",freq(i),spl(i)+3.);

    end
    pause(0.3);
    progressbar(1);
    

    setappdata(0,'spl',spl);

    setappdata(0,'text',text);
    setappdata(0,'ntx',ntx);   
 
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
   
   sn(1)=ref;
	nrspl(1)=-1.0e+12;

	   sn(2)=0.002;
	nrspl(2)=-1.;

	   sn(3)=0.005;
	nrspl(3)=8.;

	   sn(4)=0.01;
	nrspl(4)=10.;

	   sn(5)=0.02;
	nrspl(5)=11.;

	   sn(6)=0.03;
	nrspl(6)=10.5;

	   sn(7)=0.05;
	nrspl(7)=9.;

	   sn(8)=0.1;
	nrspl(8)=6.;

	   sn(9)=0.2;
	nrspl(9)=1.;

	   sn(10)=0.5;
	nrspl(10)=-7.5;

	   sn(11)=1.;
	nrspl(11)=-13.5;

	   sn(12)=2.;
	nrspl(12)=-20.;

	   sn(13)=5.0;
	nrspl(13)=-27.;

	   sn(14)=10000.;
	nrspl(14)=-500.;


	num=length(nrspl);

	for i=1:num
		nrspl(i)=ref* 10^(0.1*nrspl(i));
    end

    freq(1)=10.;
	freq(2)=12.5;
	freq(3)=16.;
	freq(4)=20.;
	freq(5)=25.;
	freq(6)=31.5;
	freq(7)=40.;
	freq(8)=50.;
	freq(9)=63.;
	freq(10)=80.;
	freq(11)=100.;
	freq(12)=125.;
	freq(13)=160.;
	freq(14)=200.;
	freq(15)=250.;
	freq(16)=315.;
	freq(17)=400.;
	freq(18)=500.;
	freq(19)=630.;
	freq(20)=800.;
	freq(21)=1000.;
	freq(22)=1250.;
	freq(23)=1600.;
	freq(24)=2000.;
	freq(25)=2500.;
	freq(26)=3150.;
	freq(27)=4000.;
	freq(28)=5000.;
	freq(29)=6300.;
	freq(30)=8000.;
	freq(31)=10000.;
	ilast = length(freq);
    
    amp=zeros(ilast,1);

    for i=1:ilast
    
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
 
    end 

    Lwb=zeros(ilast,1);
    
	for i=1:ilast   % Lwb = Sound Power Level
	
        df = ((2^(1/6))-1/(2^(1/6)))*freq(i);

		Lwb(i)= 10*log10(amp(i)/ref) +LW -10*log10(U/de) +10*log10(df);

		if( i>=2 && (Lwb(i-1)-Lwb(i) ) > 2. )
		
            Lwb(i)=Lwb(i-1)-2;
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
   
  
set(handles.uipanel_save,'Visible','on');    
    
    
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

n=get(handles.listbox_motor,'Value');

iu=get(handles.listbox_units,'Value');

set(handles.text_m_1,'Visible','off');
set(handles.text_m_2,'Visible','off');

set(handles.text_num_nozzles,'Visible','off');
set(handles.edit_num_nozzles,'Visible','off');

set(handles.text_thrust_2,'Visible','off');
set(handles.edit_thrust_2,'Visible','off');

set(handles.text_diameter_2,'Visible','off');
set(handles.edit_diameter_2,'Visible','off');

set(handles.text_velox_2,'Visible','off');
set(handles.edit_velox_2,'Visible','off');


if(n==2 || n==9)
    
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


if(n==6 || n==7 || n==8 || n==9)
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

if(n==8)  % BE-4
     thrust_1=550000;
   diameter_1=75.6;
      velox_1=9826;   
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

if(n<9)

    st1=sprintf('%7.4g',thrust_1);
    st2=sprintf('%7.4g',thrust_2);

    sd1=sprintf('%7.4g',diameter_1);
    sd2=sprintf('%7.4g',diameter_2);

    sv1=sprintf('%7.4g',velox_1);
    sv2=sprintf('%7.4g',velox_2);
    
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


if(n==8)
    set(handles.edit_num_nozzles,'String','7');
end

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


% --- Executes on button press in pushbutton_save_power.
function pushbutton_save_power_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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
 

    msgbox('Save complete');



% --- Executes on button press in pushbutton_load.
function pushbutton_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile('*.mat');
 
NAME = [pathname,filename];

struct=load(NAME);
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
    sdiam=LiftoffSettings.sdiam; 
    setappdata(0,'q_diameter',sdiam);       
catch
end

try
    n_stations=LiftoffSettings.n_stations;   
    setappdata(0,'n_stations',n_stations);     
catch
end


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


% --- Executes on button press in pushbutton_export.
function pushbutton_export_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'Lwb');

output_name=get(handles.edit_output_array,'String');

assignin('base', output_name,data);

msgbox('Array saved');

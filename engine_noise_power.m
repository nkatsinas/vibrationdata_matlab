function varargout = engine_noise_power(varargin)
% ENGINE_NOISE_POWER MATLAB code for engine_noise_power.fig
%      ENGINE_NOISE_POWER, by itself, creates a new ENGINE_NOISE_POWER or raises the existing
%      singleton*.
%
%      H = ENGINE_NOISE_POWER returns the handle to a new ENGINE_NOISE_POWER or the handle to
%      the existing singleton*.
%f
%      ENGINE_NOISE_POWER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ENGINE_NOISE_POWER.M with the given input arguments.
%
%      ENGINE_NOISE_POWER('Property','Value',...) creates a new ENGINE_NOISE_POWER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before engine_noise_power_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to engine_noise_power_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help engine_noise_power

% Last Modified by GUIDE v2.5 31-Aug-2018 16:25:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @engine_noise_power_OpeningFcn, ...
                   'gui_OutputFcn',  @engine_noise_power_OutputFcn, ...
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


% --- Executes just before engine_noise_power is made visible.
function engine_noise_power_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to engine_noise_power (see VARARGIN)

% Choose default command line output for engine_noise_power
handles.output = hObject;

set(handles.uipanel_export,'Visible','off');

set(handles.listbox_motor,'Value',1);
set(handles.listbox_units,'Value',1);


listbox_units_Callback(hObject, eventdata, handles);
listbox_motor_Callback(hObject, eventdata, handles);
listbox_igeo_Callback(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes engine_noise_power wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = engine_noise_power_OutputFcn(hObject, eventdata, handles) 
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

set(handles.uipanel_export,'Visible','off');

iu=get(handles.listbox_units,'Value');
setappdata(0,'iu',iu);


if(iu==1)
   set(handles.text_C,'String','Sound Speed (ft/sec)');     
   set(handles.edit_C,'String','1120'); 
%   set(handles.text_length_unit,'String','in');
else
   set(handles.text_C,'String','Sound Speed (m/sec)');    
   set(handles.edit_C,'String','343');   
%   set(handles.text_length_unit,'String','m');
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


%%%%%%%

isys=get(handles.listbox_units,'Value');
setappdata(0,'isys',isys);


%% iw=get(handles.listbox_iw,'Value');
%% setappdata(0,'iw',iw);

igeo=get(handles.listbox_igeo,'Value');
setappdata(0,'igeo',igeo);

% ich=get(handles.listbox_ascent,'Value');
% setappdata(0,'ich',ich);

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


% if(irad==1)
%     outr=' Sound Radiation Volume: hemisphere (flat ground plane)';
% else
%     outr=' Sound Radiation Volume: spherical (free space)';    
% end
% disp(outr);

% text{ntx}=outr;
% ntx=ntx+1;
text{ntx}=' ';
ntx=ntx+1;


% if(iw==1)
%     outiw=' Surface Reflection Correction: yes ';
% else
%     outiw=' Surface Reflection Correction: no';    
% end
% disp(outiw);

% text{ntx}=outiw;
% ntx=ntx+1;
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


step5(hObject, eventdata, handles);


set(handles.uipanel_export,'Visible','on');



%%%%%%%
   
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

	freq(1)=20.;
	freq(2)=25.;
	freq(3)=31.5;
	freq(4)=40.;
	freq(5)=50.;
	freq(6)=63.;
	freq(7)=80.;
	freq(8)=100.;
	freq(9)=125.;
	freq(10)=160.;
	freq(11)=200.;
	freq(12)=250.;
	freq(13)=315.;
	freq(14)=400.;
	freq(15)=500.;
	freq(16)=630.;
	freq(17)=800.;
	freq(18)=1000.;
	freq(19)=1250.;
	freq(20)=1600.;
	freq(21)=2000.;
	freq(22)=2500.;
	freq(23)=3150.;
	freq(24)=4000.;
	freq(25)=5000.;
	freq(26)=6300.;
	freq(27)=8000.;
	freq(28)=10000.;
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
   
    out3=' Source Sound Power (ref= 1 pico Watt)';
    out4='   Freq(Hz)     Lwb(dB)';
    
    text{ntx}=out3;
    ntx=ntx+1;  
    text{ntx}=out4;
    ntx=ntx+1;     
    
    
    disp(out3);
    disp(out4);
    
 	for i=1:ilast    
        out1=sprintf(' %8.1f   %8.1f',freq(i),Lwb(i));
        text{ntx}=out1;
        ntx=ntx+1;
        disp(out1);
    end
    
    setappdata(0,'text',text);
    setappdata(0,'ntx',ntx);   
    
freq=fix_size(freq);
Lwb=fix_size(Lwb);
   
n_type=1;    
fig_num=1;
f=freq;
dB=Lwb;
[fig_num]=power_dB_plot(fig_num,n_type,f,dB);

setappdata(0,'power_dB',[freq Lwb]);

    
% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(engine_noise_power);



% --- Executes on selection change in listbox_motor.
function listbox_motor_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_motor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_motor contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_motor

set(handles.uipanel_export,'Visible','off');

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

if(n<8)

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

set(handles.uipanel_export,'Visible','off');

igeo=get(handles.listbox_igeo,'Value');

% set(handles.text_distance_nozzle,'Visible','off');
% set(handles.edit_distance_nozzle,'Visible','off');
% set(handles.text_length_unit,'Visible','off');
% set(handles.text_rho,'Visible','off');
% set(handles.text_deg,'Visible','off');
% set(handles.edit_rho,'Visible','off');

if(igeo==4 || igeo==5 || igeo==6 || igeo==7)

%    set(handles.text_distance_nozzle,'Visible','on');
%    set(handles.edit_distance_nozzle,'Visible','on');
%    set(handles.text_length_unit,'Visible','on');
%    set(handles.text_rho,'Visible','on');
%    set(handles.text_deg,'Visible','on');    
%    set(handles.edit_rho,'Visible','on');

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


% --- Executes on button press in pushbutton_export.
function pushbutton_export_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'power_dB');

output_name=get(handles.edit_array_name,'String');

assignin('base', output_name, data);

h = msgbox('Save Complete');



function edit_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_aceff and none of its controls.
function edit_aceff_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_aceff (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_export,'Visible','off');


% --- Executes on key press with focus on edit_C and none of its controls.
function edit_C_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_C (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_export,'Visible','off');


% --- Executes on key press with focus on edit_num_nozzles and none of its controls.
function edit_num_nozzles_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_num_nozzles (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_export,'Visible','off');


% --- Executes on key press with focus on edit_thrust_1 and none of its controls.
function edit_thrust_1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_thrust_1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_export,'Visible','off');


% --- Executes on key press with focus on edit_diameter_1 and none of its controls.
function edit_diameter_1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_diameter_1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_export,'Visible','off');


% --- Executes on key press with focus on edit_velox_1 and none of its controls.
function edit_velox_1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_velox_1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_export,'Visible','off');


% --- Executes on key press with focus on edit_thrust_2 and none of its controls.
function edit_thrust_2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_thrust_2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_export,'Visible','off');


% --- Executes on key press with focus on edit_diameter_2 and none of its controls.
function edit_diameter_2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_diameter_2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_export,'Visible','off');


% --- Executes on key press with focus on edit_velox_2 and none of its controls.
function edit_velox_2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_velox_2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_export,'Visible','off');
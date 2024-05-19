function varargout = aerodynamic_flow(varargin)
% AERODYNAMIC_FLOW MATLAB code for aerodynamic_flow.fig
%      AERODYNAMIC_FLOW, by itself, creates a new AERODYNAMIC_FLOW or raises the existing
%      singleton*.
%
%      H = AERODYNAMIC_FLOW returns the handle to a new AERODYNAMIC_FLOW or the handle to
%      the existing singleton*.
%
%      AERODYNAMIC_FLOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AERODYNAMIC_FLOW.M with the given input arguments.
%
%      AERODYNAMIC_FLOW('Property','Value',...) creates a new AERODYNAMIC_FLOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before aerodynamic_flow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to aerodynamic_flow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help aerodynamic_flow

% Last Modified by GUIDE v2.5 19-Jan-2023 19:44:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @aerodynamic_flow_OpeningFcn, ...
                   'gui_OutputFcn',  @aerodynamic_flow_OutputFcn, ...
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


% --- Executes just before aerodynamic_flow is made visible.
function aerodynamic_flow_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to aerodynamic_flow (see VARARGIN)

% Choose default command line output for aerodynamic_flow
handles.output = hObject;

set(handles.listbox_aux,'Value',1);

set(handles.edit_angle','Visible','off');
set(handles.text_angle','Visible','off');
set(handles.edit_mach','Visible','off');
set(handles.text_mach','Visible','off');

listbox_regime_Callback(hObject, eventdata, handles);

set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes aerodynamic_flow wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = aerodynamic_flow_OutputFcn(hObject, eventdata, handles) 
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

delete(aerodynamic_flow);


function onethird_octave_frequency(hObject, eventdata, handles)

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

    setappdata(0,'freq',freq);
    

% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('  ');
disp(' * * * * * * * * * ');
disp('  ');

fig_num=1;

%%%%%%%%%%%%%%%%%%%%%%%%%

fplref = (2.9e-09)*144.;

ft_per_m   = 3.28;
ft_per_km  = 3.28*1000.;
ft_per_nmi = 6076.1;

km_per_nmi = 1.852;

conv = 0.00194;  % kg/m^3 to slugs/ft^3  (lbf sec^2/ft^4)

setappdata(0,'fplref',fplref);
setappdata(0,'ft_per_km',ft_per_km);
setappdata(0,'conv',conv);

%%%%%%%%%%%%%%%%%%%%%%%%%

max_fpl=zeros(28,1);
setappdata(0,'max_fpl',max_fpl);


onethird_octave_frequency(hObject, eventdata, handles);

freq=getappdata(0,'freq');

%%%

iflow=get(handles.listbox_regime,'Value');
setappdata(0,'iflow',iflow);

%%%

icc=0;
if(iflow==2)
    icc=get(handles.listbox_aux,'Value');
end
setappdata(0,'icc',icc);

%%%

iex=0;
if(iflow==3)
    iex=get(handles.listbox_aux,'Value');
end
setappdata(0,'iex',iex);

%%%


x=str2num(get(handles.edit_x,'String'));

iu=get(handles.listbox_units,'Value');

if(iu==1)       % convert inch to ft
    x=x/12;
else            % convert m to ft
    x=x*3.2808;     
end
setappdata(0,'x',x);

out1=sprintf('\n  x=%8.4g ft \n',x);
disp(out1);

%%%%%%%%

try  
    FS=strtrim(get(handles.edit_input_array,'String'));
    THM=evalin('base',FS);  
catch  
    warndlg('Input Array does not exist.  Try again.')
    return;
end

THM

altitude=THM(:,1);
velox=THM(:,2);

alt_num=length(altitude);

alt_num

%%%%%%%%

ivel_unit=get(handles.listbox_velox_unit,'Value');
ialt_unit=get(handles.listbox_alt_unit,'Value');


if(ialt_unit==1)
    altitude=altitude*ft_per_nmi;
end
if(ialt_unit==3)
    altitude=altitude*ft_per_km;
end


max_alt=131200;

for i=alt_num:1:-1
    if(altitude(i)>max_alt)
        altitude(i)=[];
        velox(i)=[];
    end
end

alt_num=length(altitude);


%%%%%%%%%

setappdata(0,'altitude',altitude);
reverse_speed(hObject, eventdata, handles);
speed_of_sound=getappdata(0,'speed_of_sound');



if(ivel_unit==1)  % convert Mach to ft/sec
    
    macht=velox;
    
    for i=1:alt_num
        velox(i)=velox(i)*speed_of_sound(i);  
    end
      
end     
if(ivel_unit==3)  % convert m/sec to ft/sec
    velox=velox*ft_per_m;
end
if(ivel_unit>=2)
    
    for i=1:alt_num    
       macht(i)=velox(i)/speed_of_sound(i);       
    end   
    
end

%%%%%%%%



for i=alt_num:1:-1
    if(macht(i)<1)
        altitude(i)=[];
        velox(i)=[];
        macht(i)=[];
    end
end


alt_num=length(altitude);

setappdata(0,'alt_num',alt_num);

maxoafpl=0; 

%%%%%%%%

QS=str2num(get(handles.edit_QS,'String'));

for i=1:alt_num
    
    h=altitude(i);
	M=macht(i);  
        
    if(h>131200)
        warndlg('Maximum allowable altitude is 131200 feet');
        return;
    end
    
    setappdata(0,'h',h);
    setappdata(0,'M',M);
        
	mach(hObject, eventdata, handles);

	U=velox(i);
    setappdata(0,'U',U);

	density(hObject, eventdata, handles);        
    
    rho=getappdata(0,'rho');
        
    q = 0.5*rho*(U^2);
    q=q*QS;
    setappdata(0,'q',q);
    
    reynolds(hObject, eventdata, handles);
    
    
%%

    if(iflow==1)  % Attached Flow (Type I)                                    
		
        if(i==1)
            disp(' Attached Flow via the Laganelli and Wolfe method, AIAA paper 89-1064 ');
        end 

		attach(hObject, eventdata, handles);
	    
    end
 
    if(iflow==2)  % Separated Flow & Shockwaves: Compression Corner (IV or V)   
        if(i==1)
            disp(' Separated Flow & Shockwaves: Compression Corner  ');
        end
        if(icc==1)
            if(i==1)
                disp(' Plateau Region, Transonic Flow (Type IV) ');
            end
			cc_plateau_tf(hObject, eventdata, handles);
        end
        if(icc==2)
            if(i==1)		
                disp(' Reattachment Region, Transonic Flow (Type V) ');  
            end
			cc_reattachment_tf(hObject, eventdata, handles);
        end
        if(icc==3)
            if(i==1)	
                disp(' Plateau Region, Supersonic Flow (Type IV) '); 
            end	
			cc_plateau_supersonic(hObject, eventdata, handles);
        end	
        if(icc==4)
            if(i==1)	
                disp(' Separation or Reattachment Shockwave (Type V) ');
            end
			cc_separation_or_shockwave(hObject, eventdata, handles);
        end
        
        if(icc>=3 && i==1)
            angle=str2num(get(handles.edit_angle,'String'));
            out1=sprintf(' Frustum angle = %g deg',angle);
            disp(out1);
            um=str2num(get(handles.edit_mach,'String'));
            out1=sprintf(' Upstream Mach number = %g ',um);
            disp(out1);           
        end
        
		cc_auto(hObject, eventdata, handles);
    end
		if( iflow==3)  % Separated Flow & Shockwaves: Expansion Corner (II or III) 
        
            if(i==1)
                disp(' Separated Flow & Shockwaves: Expansion Corner ');
            end
            
			if(iex==1)
                if(i==1)
					disp(' Plateau Region, Transonic and Supersonic (Type II) ');
                end
				exp_plateau(hObject, eventdata, handles);
			end
			if(iex==2)	
				if(i==1)
					disp(' Reattachment Region, Transonic (Type III) ');
				end
				exp_reattachment(hObject, eventdata, handles);
			end
			exp_auto(hObject, eventdata, handles);
		end
		auto_spectrum(hObject, eventdata, handles);

        oafpl=getappdata(0,'oafpl');
         
        if(oafpl > maxoafpl )
            maxfplcase=getappdata(0,'fpl');
            maxG=getappdata(0,'G');
			maxq = q;
			maxMach=M;
			maxaltitude=altitude(i);
			maxikk = i;
			maxoafpl=oafpl;
        end

        
        if(i==1)		
            disp('  ');
            disp('  alt       Mach     q        c       OAFPL');
            disp('  (ft)       No.    (psf)   (ft/sec)  (dB)');
        end
        
        c=getappdata(0,'speed_of_sound');
        
        out1=sprintf(' %7.0f  %6.2f  %8.1f  %8.1f  %6.1f',h,M,q,c(i),oafpl);
        disp(out1);
        		
%		fprintf(pFile[3]," %ld  %8.4g   %8.4g  %8.4g   %8.4g  \n",ikk,altitude(ikk)/ft_per_nmi,M,q,sum);	 
%		printf(" %ld  alt=%8.4g nmi  Mach=%8.4g   q=%8.4g psf   OAFPL=%8.4g dB\n",ikk,altitude(ikk)/ft_per_nmi,M,q,sum);
%%
    
end

try
    disp(' ');
    disp('  Maximum FPL ');
    disp(' ');
    disp('  Freq(Hz)   FPL(dB) ');

    for i=1:length(freq)
        out1=sprintf(' %7.1f  %7.1f',freq(i),maxfplcase(i)); 
        disp(out1); 
    end

catch
   warndlg('Output error.  Check input parameters.');
   return;
end

% out1=sprintf('\n Overall FPL = %7.1f dB \n',maxoafpl);
% disp(out1);

f=freq;
dB=maxfplcase;
n_type=1;
[fig_num]=fpl_plot(fig_num,n_type,f,dB);

f=fix_size(f);
dB=fix_size(dB);
maxG=fix_size(maxG);

maxG=maxG/12^4;

data1=[f dB];
setappdata(0,'aeroflow_fpl',data1);

data2=[f maxG];
setappdata(0,'maxG',data2);

set(handles.uipanel_save,'Visible','on');


prms=10^(maxoafpl/20)*(2.9e-09);


out1=sprintf('\n Overall Pressure = %8.4g psi rms ',prms);
  out2=sprintf('                  = %8.4g Pa rms \n',prms*6891.2);
disp(out1);
disp(out2);

%%%%%%%%



function reynolds(hObject, eventdata, handles)
%

 U=getappdata(0,'U');
 x=getappdata(0,'x');
 h=getappdata(0,'h');
M2=getappdata(0,'M2');

ht=h/1000.;

if(h<360000.)
    mu = 1.560401 + 0.0395762*ht + 3.009485e-04*(ht^2)+ 1.675145e-05*(ht^3);
else
    mu = -4.48529 + 0.4546508*ht - 1.090837e-02*(ht^2)+ 1.373416e-04*(ht^3);
end
mu=mu*0.0001;  % Kinematic viscosity

Rex = U*x/mu;     % Equation (6.23) in heat transfer text

deltastar = x*0.0371*(Rex^(-0.2))*((9/7)+0.475*M2)/((1.+0.13*M2)^0.64);
		
setappdata(0,'deltastar',deltastar);



function mach(hObject, eventdata, handles)
%
    M=getappdata(0,'M');
    
	WT_ratio=1.;
	M2 = M^2;
    F= 0.5 + WT_ratio*(0.5 + 0.09*M2) + 0.04*M2;

    setappdata(0,'M2',M2);
    setappdata(0,'F',F);
%    



function density(hObject, eventdata, handles)
%
ft_per_km=getappdata(0,'ft_per_km');

h=getappdata(0,'h');
conv=getappdata(0,'conv');

dens(1)=1.226;
dens(2)=1.112;
dens(3)=1.007;
dens(4)=0.9096;
dens(5)=0.8195;
dens(6)=0.7365;
dens(7)=0.6600;
dens(8)=0.5898;
dens(9)=0.5254;
dens(10)=0.4666;
dens(11)=0.4129;
dens(12)=0.3641;
dens(13)=0.3104;
dens(14)=0.2652;
dens(15)=0.2266;
dens(16)=0.1936;
dens(17)=0.1654;
dens(18)=0.1413;
dens(19)=0.1207;
dens(20)=0.1032;
dens(21)=0.075715;
dens(22)=0.064510;
dens(23)=0.055006;
dens(24)=0.046938;


dens=dens*conv;    % kg/m^3 to slugs/ft^3  (lbf sec^2/ft^4)

nn=length(dens);

alt=zeros(nn,1);

for i=1:nn
    alt(i)=(i-1)*ft_per_km;
end

rho=0.;

for i=1:(nn-1)
    
    if( h >= alt(i) && h < alt(i+1) )
		
        len = alt(i+1)-alt(i);
        c2  = (h-alt(i))/len;
        c1  = 1. -c2;

		rho = c1*dens(i) + c2*dens(i+1);

		break;
    end	

end
	
setappdata(0,'rho',rho);

% conv
% rho

	
%%%%%%

function reverse_speed(hObject, eventdata, handles)
%

ft_per_km=getappdata(0,'ft_per_km');
 altitude=getappdata(0,'altitude');

alt_num=length(altitude);

c=zeros(alt_num,1);


for ikk=1:alt_num
   
    h=altitude(ikk);
    
   
    LH1=11*ft_per_km;
    LH2=20*ft_per_km;
    LH3=40*ft_per_km;
  
    if( h < LH1)  % troposphere
	
        Tz=288.;
		L=6.5;
        gamma=1.402;
        ROM = (8314.3/28.97);

        if( h < 0.)
			h=0;
        end

		c(ikk)=sqrt(abs(gamma*ROM*(Tz-L*(h/(ft_per_km)))))*3.28;
        
     end
     if( h >= LH1 && h <= LH2 )  % lower stratosphere
            
        c(ikk) = 295.*3.28;
                        
     end
     if( h> LH2 && h <= LH3)
        
         clear y;
         y(1)=20;
         y(2)=25;
         y(3)=30;
         y(4)=35;
         y(5)=40;
         y=y*ft_per_km;

         cc(1)=295;
         cc(2)=298;
         cc(3)=302;
         cc(4)=308;
         cc(5)=317;
         cc=cc*3.28;

         for i=1:(length(y)-1)
            if(h>=y(i) && h<=y(i+1))
                x1=y(i);
                y1=cc(i);
                x2=y(i+1);
                y2=cc(i+1);
                xnew=h;
                [c(ikk)]=linear_interpolation_function(x1,y1,x2,y2,xnew);
                break;
            end    
         end    

     end    
     if( h > LH3 )
            warndlg('Altitude too high for speed of sound calculation');
            return;
     end
end

setappdata(0,'speed_of_sound',c);


function P2P1_ratio(hObject, eventdata, handles)
%

    alpha=str2num(get(handles.edit_angle,'String'));
       M1=str2num(get(handles.edit_mach,'String'));

	alpha=alpha*pi/180;

    if( M1 < 1.0 )
        warndlg('Mach must be >=1 ');
        return;
    end    

	theta = alpha + asin(1/M1);

	s2 = (sin(theta))^2;

	P2P1 = ( (2.8*(M1^2)*s2) - 0.4 )/2.4;

    setappdata(0,'P2P1',P2P1);
	



function auto_spectrum(hObject, eventdata, handles)
%
      G=getappdata(0,'G');
   freq=getappdata(0,'freq');   
 fplref=getappdata(0,'fplref');
   
 
 num=length(freq);
   
 fpl=zeros(num,1);
Goct=zeros(num,1);


for jk=1:num

    Goct(jk)= G(jk)*(freq(jk)*0.2301);

    prms=sqrt(Goct(jk));
    
    fpl(jk)=20*log10(prms/fplref);

end

[oafpl]=oaspl_function(fpl);

setappdata(0,'fpl',fpl);
setappdata(0,'oafpl',oafpl);
setappdata(0,'Goct',Goct);
setappdata(0,'G',G);


function exp_auto(hObject, eventdata, handles)
%
TPI=2*pi;

        U=getappdata(0,'U');
        q=getappdata(0,'q');
        F=getappdata(0,'F');
     cexp=getappdata(0,'cexp');  
     freq=getappdata(0,'freq');
   poqexp=getappdata(0,'poqexp');
deltastar=getappdata(0,'deltastar');

constant = 4*(poqexp^2)*cexp*(F^1.433);
constant=constant*(q^2)*(deltastar/U);


ilast=length(freq);
	
G=zeros(ilast,1);

for i=1:ilast        
    omega= TPI*freq(i)*deltastar/U;
	G(i) = constant/(1. + (F^2.867)*((cexp*omega)^2));
end

setappdata(0,'G',G);



function exp_reattachment(hObject, eventdata, handles)
%
M2=getappdata(0,'M2');
 q=getappdata(0,'q');

poqexp  = 0.16/(1. + M2);
prms=poqexp*q;
cexp = 9;
    
setappdata(0,'poqexp',poqexp);    
setappdata(0,'prms',prms); 
setappdata(0,'cexp',cexp);


function exp_plateau(hObject, eventdata, handles)
%
M2=getappdata(0,'M2');
 q=getappdata(0,'q');

poqexp  = 0.040/(1. + M2);
prms=poqexp*q;
cexp = 3.;
    
setappdata(0,'poqexp',poqexp);    
setappdata(0,'prms',prms); 
setappdata(0,'cexp',cexp);


function cc_auto(hObject, eventdata, handles)
%
TPI=2*pi;

        q=getappdata(0,'q');
        U=getappdata(0,'U');
        F=getappdata(0,'F');
     freq=getappdata(0,'freq');   
     comp=getappdata(0,'comp');
  poqcomp=getappdata(0,'poqcomp');
deltastar=getappdata(0,'deltastar');

ilast=length(freq);

constant = 4.*(poqcomp^2)*comp*(F^1.433);
constant=constant*(q^2.)*(deltastar/U);

G=zeros(ilast,1);

for i=1:ilast
 
	omega= TPI*freq(i)*deltastar/U; 
    G(i) = constant/(1. + (F^2.867)*((comp*omega)^2));
    
end        
    
setappdata(0,'G',G);    



function cc_separation_or_shockwave(hObject, eventdata, handles)
%
    q=getappdata(0,'q');
    F=getappdata(0,'F');

    P2P1_ratio(hObject, eventdata, handles);
    P2P1=getappdata(0,'P2P1');
    
	poqtbl = (0.006/F);	   % turbulent boundary layer
	ptbl = (0.006/F)*q;

    if( P2P1 < 0.593 )
	
		warndlg(' (p2/p1) must be > 0.593 ');
        return;
        
    end

	pshock= ( -1.181 + 1.713*P2P1 + 0.468*( P2P1^2) )*(0.006/F)*q;

    if( pshock < 0 )
		warndlg(' pshock must be >= 0 ');
		return;
    end

	poq = ( -1.181 + 1.713*P2P1 + 0.468*( P2P1^2) )*(0.006/F);

    comp = 30.;

    poqcomp = ( -1.181 + 1.713*P2P1 + 0.468*( P2P1^2) )*(0.006/F);

    setappdata(0,'poq',poq);
    setappdata(0,'comp',comp);
    setappdata(0,'poqcomp',poqcomp);    
    


function cc_plateau_supersonic(hObject, eventdata, handles)
%
    q=getappdata(0,'q');
    F=getappdata(0,'F');
    
    P2P1_ratio(hObject, eventdata, handles);
    P2P1=getappdata(0,'P2P1');    

	poqtbl = (0.006/F);	% turbulent boundary layer
	
	poq = poqtbl*P2P1;	% plateau

    prms = poq*q;
	comp = 10.;
	poqcomp = poqtbl*P2P1;
    
    setappdata(0,'prms',prms);
    setappdata(0,'comp',comp);
    setappdata(0,'poqcomp',poqcomp); 
    

function cc_reattachment_tf(hObject, eventdata, handles)
%
    q=getappdata(0,'q');
    M2=getappdata(0,'M2');

	comp = 9.;
	poqcomp = 0.10/(1+M2);
	prms = poqcomp*q;
    
    setappdata(0,'prms',prms);
    setappdata(0,'comp',comp);
    setappdata(0,'poqcomp',poqcomp); 
    

function cc_plateau_tf(hObject, eventdata, handles)
%
    q=getappdata(0,'q');
    M2=getappdata(0,'M2');
 
	comp = 3.;

	poqcomp = 0.025/(1.+M2);
	prms = poqcomp*q;
    
    setappdata(0,'prms',prms);
    setappdata(0,'comp',comp);
    setappdata(0,'poqcomp',poqcomp); 
    
    
       
function attach(hObject, eventdata, handles)
%
%  G is the pressure autospectrum

TPI=2*pi;

            q=getappdata(0,'q');
            F=getappdata(0,'F');
            U=getappdata(0,'U');
    
         freq=getappdata(0,'freq');
    deltastar=getappdata(0,'deltastar');
    
    
	prms = (0.01/F)*q;
	poq = prms/q;

	constant = 4.*(poq^2)*(F^1.433);
	constant =constant*(q^2)*(deltastar/U);
	
    
    ilast=length(freq);

    G=zeros(ilast,1);
    
    for i=1:ilast
	
		omega= TPI*freq(i)*deltastar/U;

		G(i) = constant/(1 + (F^2.867)*(omega^2));
    
    end
    
    setappdata(0,'G',G);
	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit





% --- Executes during object creation, after setting all properties.
function listbox_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_regime.
function listbox_regime_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_regime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_regime contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_regime

set(handles.uipanel_save,'Visible','off');

set(handles.listbox_aux,'Value',1);

set(handles.edit_angle','Visible','off');
set(handles.text_angle','Visible','off');
set(handles.edit_mach','Visible','off');
set(handles.text_mach','Visible','off');


iflow=get(handles.listbox_regime,'Value');

if(iflow==1)
    set(handles.text_regime_aux,'Visible','off');
    set(handles.listbox_aux,'Visible','off');
else
    set(handles.text_regime_aux,'Visible','on');
    set(handles.listbox_aux,'Visible','on');   
    
    listbox_aux_Callback(hObject, eventdata, handles);    
end


set(handles.listbox_aux,'Value',1);
set(handles.listbox_aux,'String','')    

if(iflow==2)
    set(handles.text_regime_aux,'String','Separated Flow, Compression Corner');
    string_th{1}='Plateau Region, Transonic Flow (IV)';                             
    string_th{2}='Reattachment Region, Transonic Flow (V)';                         
    string_th{3}='Plateau Region, Supersonic Flow (IV)';                           
    string_th{4}='Separation or Reattachment Shockwave (Local Supersonic Flow) (V)';
    set(handles.listbox_aux,'String',string_th)    
    
end
if(iflow==3)
    set(handles.text_regime_aux,'String','Separated Flow, Expansion Corner');
    string_th{1}='Plateau Region, Transonic and Supersonic (II)';                             
    string_th{2}='Reattachment Region, Transonic (III)';                         
    set(handles.listbox_aux,'String',string_th)    
end



% --- Executes during object creation, after setting all properties.
function listbox_regime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_regime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_aux.
function listbox_aux_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_aux (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_aux contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_aux

set(handles.uipanel_save,'Visible','off');

n=get(handles.listbox_aux,'Value');

set(handles.edit_angle','Visible','off');
set(handles.text_angle','Visible','off');
set(handles.edit_mach','Visible','off');
set(handles.text_mach','Visible','off');

if(n>=3)
    set(handles.edit_angle','Visible','on');
    set(handles.text_angle','Visible','on');
    set(handles.edit_mach','Visible','on');
    set(handles.text_mach','Visible','on');    
end


% --- Executes during object creation, after setting all properties.
function listbox_aux_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_aux (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_x_Callback(hObject, eventdata, handles)
% hObject    handle to edit_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_x as text
%        str2double(get(hObject,'String')) returns contents of edit_x as a double


% --- Executes during object creation, after setting all properties.
function edit_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_x (see GCBO)
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


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units
set(handles.uipanel_save,'Visible','off');

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


% --- Executes on selection change in listbox_alt_unit.
function listbox_alt_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_alt_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_alt_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_alt_unit
set(handles.uipanel_save,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_alt_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_alt_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_velox_unit.
function listbox_velox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_velox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_velox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_velox_unit
set(handles.uipanel_save,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_velox_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_velox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_angle_Callback(hObject, eventdata, handles)
% hObject    handle to edit_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_angle as text
%        str2double(get(hObject,'String')) returns contents of edit_angle as a double


% --- Executes during object creation, after setting all properties.
function edit_angle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mach_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mach (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mach as text
%        str2double(get(hObject,'String')) returns contents of edit_mach as a double


% --- Executes during object creation, after setting all properties.
function edit_mach_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mach (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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

output_name=get(handles.edit_output_array,'String');
n=get(handles.listbox_save,'Value');

if(n==1)
    data=getappdata(0,'aeroflow_fpl');    
    out1=sprintf('\n Output Array - freq(Hz) & FPL(dB) \n    %s \n',output_name); 
else
    data=getappdata(0,'maxG');    
end
if(n==2)
    out1=sprintf('\n Output Array - freq(Hz) & PSD(psi^2/Hz) \n    %s \n',output_name);      
end
if(n==3)
    data(:,2)=data(:,2)*6891.2^2;
    out1=sprintf('\n Output Array - freq(Hz) & PSD(Pa^2/Hz) \n    %s \n',output_name);     
end
    
assignin('base', output_name, data);

disp(out1);


h = msgbox('Save Complete'); 


% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_x and none of its controls.
function edit_x_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_x (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_angle and none of its controls.
function edit_angle_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_angle (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_mach and none of its controls.
function edit_mach_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_mach (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


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


% --- Executes on button press in pushbutton_Franken.
function pushbutton_Franken_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Franken (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=Franken_method;    
    
set(handles.s,'Visible','on');     


% --- Executes on button press in pushbutton_save_model.
function pushbutton_save_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iflow=get(handles.listbox_regime,'Value');
iaux=get(handles.listbox_aux,'Value');
iu=get(handles.listbox_units,'Value');
ivel_unit=get(handles.listbox_velox_unit,'Value');
ialt_unit=get(handles.listbox_alt_unit,'Value');


x=str2num(get(handles.edit_x,'String'));
angle=str2num(get(handles.edit_angle,'String'));
um=str2num(get(handles.edit_mach,'String'));




flow.iflow=iflow;
flow.iaux=iaux;
flow.iu=iu;
flow.ivel_unit=ivel_unit;
flow.ialt_unit=ialt_unit;

flow.x=x;
flow.angle=angle;
flow.um=um;

try  
    FS=strtrim(get(handles.edit_input_array,'String'));
    THM_trajectory=evalin('base',FS);  
    flow.FS=FS;
    flow.THM=THM_trajectory;

catch  
    warndlg('Input Array does not exist.  Try again.')
    return;
end



% % %
 
structnames = fieldnames(flow, '-full'); % fields in the struct
  
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);
 
    try
 
        save(elk, 'flow'); 
 
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
 

% --- Executes on button press in pushbutton_load_model.
function pushbutton_load_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_model (see GCBO)
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
    flow=evalin('base','flow');
catch
    warndlg(' evalin failed ');
    return;
end
 
flow

try
    FS=flow.FS;    
    set(handles.edit_input_array,'String',FS);
catch
    disp(' error 1');
    return;
end

try
        THM_trajectory=flow.THM;    
        assignin('base',FS,THM_trajectory); 
catch
    disp(' error 2');    
end    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    iflow=flow.iflow;    
    set(handles.listbox_regime,'Value',iflow);
catch
end

try
    iaux=flow.iaux;    
    set(handles.listbox_aux,'Value',iaux);
catch
end

try
    iu=flow.iu;    
    set(handles.listbox_units,'Value',iu);
catch
end

try
    ivel_unit=flow.ivel_unit;    
    set(handles.listbox_velox_unit,'Value',ivel_unit);
catch
end

try
    ialt_unit=flow.ialt_unit;    
    set(handles.listbox_alt_unit,'Value',ialt_unit);
catch
end

%%%%%%%%%

try
    x=flow.x;    
    sx=sprintf('%g',x);
    set(handles.edit_x,'String',sx);
catch
end

try
    angle=flow.angle;    
    ss=sprintf('%g',angle);
    set(handles.edit_angle,'String',ss);
catch
end

try
    um=flow.um;    
    ss=sprintf('%g',um);
    set(handles.edit_mach,'String',ss);
catch
end

%%%%%%%%%%%%

set(handles.edit_angle','Visible','off');
set(handles.text_angle','Visible','off');
set(handles.edit_mach','Visible','off');
set(handles.text_mach','Visible','off');

listbox_regime_Callback(hObject, eventdata, handles);

set(handles.uipanel_save,'Visible','off');



% --- Executes during object creation, after setting all properties.
function pushbutton_save_model_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



 



function edit_QS_Callback(hObject, eventdata, handles)
% hObject    handle to edit_QS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_QS as text
%        str2double(get(hObject,'String')) returns contents of edit_QS as a double


% --- Executes during object creation, after setting all properties.
function edit_QS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_QS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

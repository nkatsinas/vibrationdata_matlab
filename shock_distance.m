function varargout = shock_distance(varargin)
% SHOCK_DISTANCE MATLAB code for shock_distance.fig
%      SHOCK_DISTANCE, by itself, creates a new SHOCK_DISTANCE or raises the existing
%      singleton*.
%
%      H = SHOCK_DISTANCE returns the handle to a new SHOCK_DISTANCE or the handle to
%      the existing singleton*.
%
%      SHOCK_DISTANCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHOCK_DISTANCE.M with the given input arguments.
%
%      SHOCK_DISTANCE('Property','Value',...) creates a new SHOCK_DISTANCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before shock_distance_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to shock_distance_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help shock_distance

% Last Modified by GUIDE v2.5 24-Aug-2015 09:28:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @shock_distance_OpeningFcn, ...
                   'gui_OutputFcn',  @shock_distance_OutputFcn, ...
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


% --- Executes just before shock_distance is made visible.
function shock_distance_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to shock_distance (see VARARGIN)

% Choose default command line output for shock_distance
handles.output = hObject;

set(handles.listbox_material,'Value',1);

change(hObject, eventdata, handles);



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes shock_distance wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function change(hObject, eventdata, handles)

set(handles.uipanel_save,'Visible','off');

nstr=get(handles.listbox_type,'Value');
iu=get(handles.listbox_units,'Value');
nmat=get(handles.listbox_material,'Value');


if(iu==1)  % English
    if(nmat==1) % aluminum
        handles.elastic_modulus=1e+007;
        handles.mass_density=0.1;  
    end  
    if(nmat==2)  % steel
        handles.elastic_modulus=3e+007;
        handles.mass_density= 0.28;         
    end
    if(nmat==3)  % copper
        handles.elastic_modulus=1.6e+007;
        handles.mass_density=  0.322;
    end
    if(nmat==4)  % G10
        handles.elastic_modulus=2.7e+006;
        handles.mass_density=  0.065;
    end
    if(nmat==5)  % PVC
        handles.elastic_modulus=3.5e+005;
        handles.mass_density=  0.052;
    end
else                 % metric
    if(nmat==1)  % aluminum
        handles.elastic_modulus=70;
        handles.mass_density=  2700;
    end
    if(nmat==2)  % steel
        handles.elastic_modulus=205;
        handles.mass_density=  7700;        
    end
    if(nmat==3)   % copper
        handles.elastic_modulus=110;
        handles.mass_density=  8900;
    end
    if(nmat==4)  % G10
        handles.elastic_modulus=18.6;
        handles.mass_density=  1800;
    end
    if(nmat==5)  % PVC
        handles.elastic_modulus=24.1;
        handles.mass_density=  1440;
    end
end
 
if(nmat<6)
    ss1=sprintf('%8.4g',handles.elastic_modulus);
    ss2=sprintf('%8.4g',handles.mass_density);
 
    set(handles.edit_elastic_modulus,'String',ss1);
    set(handles.edit_mass_density,'String',ss2);    
end




if(iu==1)
    set(handles.text_distance_unit,'String','in');
    set(handles.text_elastic_modulus,'String','lbf/in^2');
    set(handles.text_mass_density,'String','lbm/in^3');
    
    set(handles.text_width_unit,'String','in'); 
    set(handles.text_thickness_unit,'String','in');     
    
else
    set(handles.text_distance_unit,'String','cm'); 
    set(handles.text_elastic_modulus,'String','GPa');
    set(handles.text_mass_density,'String','kg/m^3');  
    
    set(handles.text_width_unit,'String','mm'); 
    set(handles.text_thickness_unit,'String','mm');     
end

set(handles.text_elastic_modulus,'Visible','off');
set(handles.text_mass_density,'Visible','off');
set(handles.listbox_material,'Visible','off');
set(handles.text_material,'Visible','off');
set(handles.text_em,'Visible','off');
set(handles.text_md,'Visible','off'); 
set(handles.edit_mass_density,'Visible','off'); 
set(handles.edit_elastic_modulus,'Visible','off'); 

set(handles.text_width,'Visible','off'); 
set(handles.edit_width,'Visible','off'); 
set(handles.text_thickness,'Visible','off'); 
set(handles.edit_thickness,'Visible','off'); 
set(handles.text_width_unit,'Visible','off'); 
set(handles.text_thickness_unit,'Visible','off'); 
set(handles.text_damping,'Visible','off'); 
set(handles.edit_damping,'Visible','off'); 

set(handles.text_w1,'Visible','off'); 
set(handles.text_w2,'Visible','off'); 
set(handles.text_w3,'Visible','off'); 
set(handles.edit_wt,'Visible','off'); 


if(nstr==9)
    set(handles.text_elastic_modulus,'Visible','on');
    set(handles.text_mass_density,'Visible','on');
    set(handles.listbox_material,'Visible','on');
    set(handles.text_material,'Visible','on');
    set(handles.text_em,'Visible','on');
    set(handles.text_md,'Visible','on'); 
    set(handles.edit_mass_density,'Visible','on'); 
    set(handles.edit_elastic_modulus,'Visible','on'); 
    
    set(handles.text_width,'Visible','on'); 
    set(handles.edit_width,'Visible','on'); 
    set(handles.text_thickness,'Visible','on'); 
    set(handles.edit_thickness,'Visible','on'); 
    set(handles.text_width_unit,'Visible','on'); 
    set(handles.text_thickness_unit,'Visible','on'); 
    set(handles.text_damping,'Visible','on'); 
    set(handles.edit_damping,'Visible','on');     
    
    set(handles.text_w1,'Visible','on'); 
    set(handles.text_w2,'Visible','on'); 
    set(handles.text_w3,'Visible','on'); 
    set(handles.edit_wt,'Visible','on');     
end




% --- Outputs from this function are returned to the command line.
function varargout = shock_distance_OutputFcn(hObject, eventdata, handles) 
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

delete(shock_distance);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_type,'Value');

iu=get(handles.listbox_units,'Value');

x=str2num(get(handles.edit_x,'String'));

disp(' ');
disp(' * * * * ');
disp(' ');
disp(' Distance from Source ');

if(iu==1)
    out1=sprintf(' x=%8.4g in ',x);
else    
    out1=sprintf(' x=%8.4g cm ',x);    
    x=x/2.54;
end
disp(out1);

if(x<6)
   warndlg('Distance is too close to source. Minimum=6 inch');
   return; 
end  
if(x>110)
   warndlg('Distance is too far from source. Maximum=110 inch');
   return; 
end   

if(x>100)
   x=100;
end 

x2=x^2;
x3=x^3;
x4=x^4;
x5=x^5;
x6=x^6;


disp(' ');

if(n==1)  % cylindrical shell
   disp(' Cylindrical Shell '); 

    
   	q=[5.93391	101.923;
	9.72384	86.1693;
	14.9656	71.9115;
	20.3187	59.6266;
	26.4529	48.491;
	33.0337	39.1805;
	39.9511	32.4844;
	48.6548	26.2443;
	55.5736	22.3277;
	63.1641	19.4914;
	71.6474	16.6885;
	80.9136	14.4736;
	88.9524	12.9649;
	95.4284	11.918;
	102.128	11.0978;
	108.83	10.5359;
	119.664	9.93589];

    [p,S,mu] = polyfit(q(:,1),q(:,2),5);
    y = polyval(p,x,S,mu);
    
end
if(n==2)  % longeron
   disp(' Longeron or Stringer ');     

    q=[6.41215	101.187;
	13.3584	87.906;
	21.4248	73.7439;
	28.9894	64.4953;
	35.019	57.6197;
	39.8237	52.9432;
	43.5101	50.7268;
	48.4234	47.585;
	53.8543	45.2514;
	60.7293	43.9123;
	70.0738	42.6695;
	80.2381	41.648;
	89.8809	40.5101;
	100.355	39.3179;
	110.109	38.381;
	120.17	37.4624];

   
    [p,S,mu] = polyfit(q(:,1),q(:,2),6);
    y = polyval(p,x,S,mu);   
end
if(n==3)  % skin/ring frame
    disp(' Skin/Ring Frame ');     
   
	q=[5.09144	101.448;
	8.42118	81.8503;
	13.6251	61.8944;
	18.931	48.3592;
	25.3293	38.0428;
	32.168	29.5423;
	37.6752	24.9654;
	43.7337	20.6912;
	50.1144	17.6043;
	56.5972	15.4756;
	63.7393	13.4302;
	71.9795	11.4324;
	78.2407	10.1815;
	85.5971	9.0112;
	93.1737	7.92395;
	100.201	7.05845;
	110.3	6.01149;
	120.07	5.15292];
    
    
    [p,S,mu] = polyfit(q(:,1),q(:,2),6);
    y = polyval(p,x,S,mu);
end
if(n==4)  % primary truss
   disp(' Primary Truss ');    
   
    q=[	5.77905	99.9214;
	12.2137	82.6752;
	20.1817	66.2036;
	26.3111	55.8586;
	32.8475	45.9173;
	39.4871	37.9911;
	46.9435	30.6225;
	52.4588	26.0081;
	56.7502	23.2726;
	62.269	20.4191;
	67.7913	18.5077;
	72.7002	16.9962;
	78.5312	15.6063;
	84.5658	14.1445;
	90.0881	12.8204;
	100.112	10.8822];

   
    [p,S,mu] = polyfit(q(:,1),q(:,2),6);
    y = polyval(p,x,S,mu);   
end
if(n==5)  % complex airframe
   disp(' Complex Airframe ');    

   	q=[5.03518	99.9722;
	18.4084	56.169;
	31.0397	33.2554;
	42.8214	20.2123;
	51.8435	13.8225;
	62.7766	8.79528;
	72.1161	5.8211;
	80.0765	4.14047;
	88.0379	3.00343;
	93.3444	2.37243;
	103.004	1.60126];

   
    [p,S,mu] = polyfit(q(:,1),q(:,2),6);
    y = polyval(p,x,S,mu);    
end
if(n==6)  % complex equipment structure
   disp(' Complex Equipment Structure ');     
   
   q=[	5.07011	101.878;
	8.51195	88.3615;
	12.174	79.2522;
	15.8286	69.1962;
	20.4288	59.5902;
	24.4017	52.3743;
	28.5819	45.4143;
	33.1766	38.3289;
	37.6713	33.0092;
	42.4788	28.0452;
	47.1789	23.6688;
	51.8791	19.9754;
	58.2613	16.5124;
	63.276	13.8409;
	67.6615	11.7611;
	72.5745	9.99206;
	78.2165	8.20649;
	83.0221	6.92565;
	88.2459	5.76585;
	92.4279	5.03335;
	98.2791	4.10591;
	100.372	3.86211];

   
    [p,S,mu] = polyfit(q(:,1),q(:,2),6);
    y = polyval(p,x,S,mu);    
end
if(n==7)  % honeycomb
    disp(' Honeycomb ');
    
    q=[	4.89935	100.562;
	13.0992	93.393;
	19.1683	87.9216;
	24.8142	84.4237;
	32.2675	78.4181;
	38.0201	75.2965;
	46.4333	69.9255;
	54.3144	65.3725;
	60.4913	61.9463;
	66.6682	58.6997;
	74.016	54.8841;
	82.2171	51.307;
	90.3079	47.0293;
	97.3405	45.1446;
	105.011	42.7646;
	111.72	40.2536;
	120.237	36.8941];

    
    [p,S,mu] = polyfit(q(:,1),q(:,2),4);
    y = polyval(p,x,S,mu); 
end
if(n==8)  % constant velocity line
    disp('  Constant velocity line ');       
    
    q=[	6.04684	99.1182;
	9.32304	85.5445;
	14.0714	72.8733;
	19.2719	61.0125;
	24.0206	52.2005;
	29.1105	45.4406;
	34.8802	39.5551;
	40.649	33.9877;
	48.4592	29.9701;
	55.1369	26.6582;
	60.9101	24.4426;
	69.0628	22.4091;
	77.3292	20.6339;
	88.3149	18.9153;
	97.941	17.416;
	106.21	16.7456;
	115.952	15.9615;
	120.031	15.7532];

    
    [p,S,mu] = polyfit(q(:,1),q(:,2),5);
    y = polyval(p,x,S,mu);     
end

if(n==9)  % beam analogy

    damp=str2num(get(handles.edit_damping,'String'));
    E=str2num(get(handles.edit_elastic_modulus,'String'));
    rho=str2num(get(handles.edit_mass_density,'String'));
    thick=str2num(get(handles.edit_thickness,'String'));
    width=str2num(get(handles.edit_width,'String'));    
    L=str2num(get(handles.edit_x,'String'));
    
    if(iu==1)
       rho=rho/386; 
    else
       [E]=GPa_to_Pa(E);
       width=width/1000;
       thick=thick/1000;
       L=L/100;
    end
    
    [area,MOI,~]=beam_rectangular_geometry(width,thick); 
    
    mp=rho*area;
    
    lf=2*damp/100;
    
    B=E*MOI;
    x=L;

%%

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

    
    tt=zeros(nt,1);
    Ain=zeros(nt,1);
    Atr=zeros(nt,1);
    
    clear length;
    nwaves=length(f);

    
    tstart=zeros(nwaves,1);
    tend=zeros(nwaves,1);
    
    tin_end=zeros(nwaves,1);
    
    tdx=zeros(nwaves,1);
    ratio=zeros(nwaves,1);
    
    new_amp=zeros(nwaves,1);
  
    beta=zeros(nt,1);
    alpha=zeros(nt,1);
  
    new_wavelet_table=zeros(nwaves,5); 

%%

    disp(' Scaling wavelets...');
    
    for i=1:nwaves
        
        omega=2*pi*f(i);

        beta(i)=2*pi*f(i);
        alpha(i)=beta(i)/nhs(i);
        
        CB=( (B/mp)^(1/4))*sqrt(omega);
    
        Cg=2*CB;

        Dp=27.2*f(i)*lf/Cg;
    
        delta=-Dp*x;
        ratio(i)=10^(delta/20); 
        
        tdx(i)=x/Cg;

        tstart(i)=(td(i)+tdx(i));
        
        NF=nhs(i)/(2*f(i));
        
        tend(i)=tstart(i)+NF;
    
        tin_end(i)=td(i)+NF;
        
        new_amp(i)=amp(i)*ratio(i);
        
        new_wavelet_table(i,:)=[ i f(i) new_amp(i) nhs(i)  tstart(i) ];           
             
    end
    
    setappdata(0,'new_wavelet_table',new_wavelet_table);
   
    
    f=fix_size(f);
    ratio=fix_size(ratio);
    
    fff=[f ratio];
    fff=sortrows(fff,1);
    
%%
    clear CB;
    clear Cg;

    oct=2^(1/6);
    ff(1)=10;
    k=1;
    while(1)
        
        omega=2*pi*ff(k);
 
        CB(k)=( (B/mp)^(1/4))*sqrt(omega);
    
        Cg(k)=2*CB(k);

        Dp=27.2*ff(k)*lf/Cg(k);
    
        delta=-Dp*x;
        rr(k)=10^(delta/20);
        
        if(ff(k)>12000)
            break;
        end
        
        k=k+1;
        ff(k)=ff(k-1)*oct;
    end    
%%

    fig_num=100;
    figure(fig_num);
    fig_num=fig_num+1;
    plot(ff,Cg,ff,CB);
    legend('Group','Phase','location','northwest');
    xlabel('Frequency (Hz)');
    if(iu==1)
            out1=sprintf('Bending Wave Speed  x=%6.3g in, damp=%6.3g%%',x,100*lf/2);
            ylabel('Speed (in/sec)');
    else
            out1=sprintf('Bending Wave Speed  x=%6.3g cm, damp=%6.3g%%',x,100*lf/2);  
            ylabel('Speed (m/sec)');        
    end  
    title(out1);   
    set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log'); 
    grid on;
    xlim([10 10000]);   
    
    figure(fig_num);
    fig_num=fig_num+1;
  
    plot(ff,rr);
    grid on;
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin');
    xlabel('Frequency (Hz)');
    ylabel('Ratio');
    xlim([10 10000]);
    if(iu==1)
            out1=sprintf('Remaining Ratio  x=%6.3g in, damp=%6.3g%%',x,100*lf/2);
    else
            out1=sprintf('Remaining Ratio  x=%6.3g cm, damp=%6.3g%%',x,100*lf/2);            
    end  
    title(out1);
    
    
%%    

    for i=1:nt
    
        tt(i)=(i-1)*dt; 
        t=tt(i);    
%
%  Source
%
        for j=1:nwaves 

            
            if(t>=td(j) && t<=tin_end(j))
               tq=t-td(j); 
               Ain(i)=Ain(i)+amp(j)*sin(alpha(j)*tq)*sin(beta(j)*tq);
            end 
            
        end    
% 
%  Transmitted
%
        for j=1:nwaves 
        
            if(t>=tstart(j) && t<= tend(j))
                tq=t-tstart(j);
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
        
    if(iu==1)
            out1=sprintf('Transmitted  x=%6.3g in, damp=%6.3g%%',x,100*lf/2);
    else
            out1=sprintf('Transmitted  x=%6.3g cm, damp=%6.3g%%',x,100*lf/2);            
    end    
    title(out1);     
    
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
        out1=sprintf('Source');
        title(out1);
        yLimits = get(gca,'YLim');
%
        subplot(2,1,2);
        plot(tt,Atr);
        grid on;
        xlabel('Time (sec)');
        ylabel('Accel (G)');
        ylim(yLimits);
        
        if(iu==1)
            out1=sprintf('Transmitted  x=%6.3g in, damp=%6.3g%%',x,100*lf/2);
        else
            out1=sprintf('Transmitted  x=%6.3g cm, damp=%6.3g%%',x,100*lf/2);            
        end
            
        title(out1); 

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
    legend ('Source','Transmitted','location','northwest');       
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

end


if(n<9)

    att=y;

    disp(' ');

    out1=sprintf(' Remaining = %8.4g percent',att); 
    disp(out1);

    out1=sprintf('     Ratio = %8.4g',att/100); 
    disp(out1);

    msgbox('Remaining percent written to Command Window');

end


% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type



change(hObject, eventdata, handles);







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


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units

change(hObject, eventdata, handles)





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


% --- Executes on selection change in listbox_material.
function listbox_material_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_material

change(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
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



function edit_width_Callback(hObject, eventdata, handles)
% hObject    handle to edit_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_width as text
%        str2double(get(hObject,'String')) returns contents of edit_width as a double


% --- Executes during object creation, after setting all properties.
function edit_width_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_width (see GCBO)
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



function edit_damping_Callback(hObject, eventdata, handles)
% hObject    handle to edit_damping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_damping as text
%        str2double(get(hObject,'String')) returns contents of edit_damping as a double


% --- Executes during object creation, after setting all properties.
function edit_damping_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_damping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on key press with focus on edit_damping and none of its controls.
function edit_damping_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_damping (see GCBO)
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


% --- Executes on key press with focus on edit_elastic_modulus and none of its controls.
function edit_elastic_modulus_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_elastic_modulus (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_mass_density and none of its controls.
function edit_mass_density_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass_density (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_width and none of its controls.
function edit_width_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_width (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_thickness and none of its controls.
function edit_thickness_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_wt and none of its controls.
function edit_wt_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_wt (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_save,'Visible','off');

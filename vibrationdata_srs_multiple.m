function varargout = vibrationdata_srs_multiple(varargin)
% VIBRATIONDATA_SRS_MULTIPLE MATLAB code for vibrationdata_srs_multiple.fig
%      VIBRATIONDATA_SRS_MULTIPLE, by itself, creates a new VIBRATIONDATA_SRS_MULTIPLE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_SRS_MULTIPLE returns the handle to a new VIBRATIONDATA_SRS_MULTIPLE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_SRS_MULTIPLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_SRS_MULTIPLE.M with the given input arguments.
%
%      VIBRATIONDATA_SRS_MULTIPLE('Property','Value',...) creates a new VIBRATIONDATA_SRS_MULTIPLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_srs_multiple_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_srs_multiple_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_srs_multiple

% Last Modified by GUIDE v2.5 17-Apr-2020 16:39:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_srs_multiple_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_srs_multiple_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    try
        gui_mainfcn(gui_State, varargin{:});
    catch
    end
end
% End initialization code - DO NOT EDIT




% --- Executes just before vibrationdata_srs_multiple is made visible.
function vibrationdata_srs_multiple_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_srs_multiple (see VARARGIN)

% Choose default command line output for vibrationdata_srs_multiple
handles.output = hObject;

set(handles.listbox_psave,'Value',2);
set(handles.edit_Q,'String','10');

listbox_num_Callback(hObject, eventdata, handles);

set(handles.listbox_frequency_spacing,'Value',1);

listbox_plots_Callback(hObject, eventdata, handles)

listbox_time_Callback(hObject, eventdata, handles);

%%%%%%%%%%

try
    load NSreadtemp_srs.mat;
catch    
end

% disp('ref 3b');
% NSreadtemp_srs.data

try
    cn={'Time History','Legend'};
    data=NSreadtemp_srs.data;
catch
    disp('data none 1');
end


try
    data
    set(handles.uitable_data,'Data',data,'ColumnName',cn);
catch
    disp('data none 2');
end

try
    nflights=NSreadtemp_srs.nflights;
    set(handles.listbox_num,'Value',nflights);
catch
end


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_srs_multiple wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_srs_multiple_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on selection change in listbox_output_type.
function listbox_output_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output_type


% --- Executes during object creation, after setting all properties.
function listbox_output_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method


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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('  ');
disp(' * * * * * ');
disp('  ');


Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end




fig_num=1;
nfont=10;

get_table_data(hObject, eventdata, handles);  
 
sarray=getappdata(0,'array_name');
leg=getappdata(0,'legend');

np=get(handles.listbox_plots,'Value'); 

if(np==1)

    psave=get(handles.listbox_psave,'Value');    
    nfont=str2num(get(handles.edit_font_size,'String'));    

end    
 
kv=length(sarray);
ext=get(handles.edit_extension,'String');

cv=get(handles.listbox_cv,'Value');

%%%

res=get(handles.listbox_residual,'Value');
fspace=get(handles.listbox_frequency_spacing,'Value');
iu=get(handles.listbox_unit,'Value');

Q=str2num(get(handles.edit_Q,'String'));

fstart=str2num(get(handles.edit_start_frequency,'String'));
  fend=str2num(get(handles.edit_plot_fmax,'String'));
  
fmin=fstart;
  
damp=1/(2*Q);

nformat=get(handles.listbox_output_type,'Value');

ntime=get(handles.listbox_time,'Value');


for i=1:kv
    
    clear THM;
    clear fn;
    
    out1=sprintf(' array %d of %d',i,kv);
    disp(out1);
    
    try
        THM=evalin('base',strtrim(sarray{i}));
    catch
        out1=sprintf('Error: %s  not found',sarray{i});
        warndlg(out1);
        return;
    end
    
    sz=size(THM);
    if(sz(2)~=2)
        warndlg('Input array must have two columns');
        return;
    end

%%

    
    if(ntime==2)

        start_time=str2num(get(handles.edit_start_time,'String'));
          end_time=str2num(get(handles.edit_end_time,'String'));   
      
        [~,istart]=min(abs(start_time-THM(:,1)));      
          [~,iend]=min(abs(end_time-THM(:,1)));      
       
        THM=THM(istart:iend,:);
               
    end

    [THM,iflag]=time_check_with_linear_interpolation(THM);
    if(iflag==999)
        return;
    end
    
%%    
      
    output_array{i}=strcat(sarray{i},ext);
    
    clear THM_SRS;
    
    try
        THM_SRS=evalin('base',strtrim(output_array{i}));
        qqq=1;
    catch
        qqq=0;
    end
    

    if(qqq==1)
        
        out1=sprintf('%s  already exists.  Replace?',output_array{i});
        choice = questdlg(out1,'Options','Yes','No','No');
        
% Handle response
        switch choice
            case 'Yes'
                clear THM_SRS;
                qqq=0; 
        end         
    end
    

    t=THM(:,1);
    y=THM(:,2);


    yy=y;
    

    if(qqq==0)
        

        n=length(y);             % leave here because may vary per time history
        dur=THM(n,1)-THM(1,1);
        dt=dur/(n-1);
        sr=1/dt;
        fmax=sr/4;
    
%  not recommended due to potential numerical instability       
        
%%%        if(  fmax < fend)
%%% 
%%%             sr=4*fend;
%%%             dt=1/sr;  
%%%             [t,y]=linear_interpolation(t,y,dt);
%%%             n=length(y);
%%%             fmax=sr/4;
%%%       end
    


        [fn,num]=srs_fn(fspace,fstart,fend,fmax);

        [a1,a2,b1,b2,b3,rd_a1,rd_a2,rd_b1,rd_b2,rd_b3]=...
                                   srs_coefficients(fn,damp,dt);

        NL=length(yy);
   
        clear a_pos;
        clear a_neg;
        clear pv_pos;
        clear pv_neg;
        clear rd_pos;
        clear rd_neg;
    
        a_pos=zeros(num,1);
        a_neg=zeros(num,1);   
        a_rms=zeros(num,1);
    
        pv_pos=zeros(num,1);
        pv_neg=zeros(num,1); 
    
        rd_pos=zeros(num,1);
        rd_neg=zeros(num,1);     

        for j=1:num

            if(res==1)
                ML=NL+round((1/fn(j))/dt);
                ys=zeros(ML,1);
                ys(1:NL)=yy;
            else
                ys=yy;
            end
%
            forward=[ b1(j),  b2(j),  b3(j) ];    
            back   =[     1, -a1(j), -a2(j) ];
%    
            a_resp=filter(forward,back,ys);
%
            a_pos(j)= max(a_resp);
            a_neg(j)= min(a_resp);
            a_rms(j)= std(a_resp);
%
            rd_forward=[ rd_b1(j),  rd_b2(j),  rd_b3(j) ];    
            rd_back   =[     1, -rd_a1(j), -rd_a2(j) ];      
%    
            rd_resp=filter(rd_forward,rd_back,ys);
%
            if(iu==1)
                rd_resp=rd_resp*386;
            end
            if(iu==2)
                rd_resp=rd_resp*9.81*1000;        
            end
%
            rd_pos(j)= max(rd_resp);
            rd_neg(j)= min(rd_resp);
%
            omegan=2*pi*fn(j);
%
            pv_pos(j)=omegan*rd_pos(j);
            pv_neg(j)=omegan*rd_neg(j);
%
        end
%
        a_neg=abs(a_neg);
        pv_neg=abs(pv_neg);
        rd_neg=abs(rd_neg);
%
        if(iu==2)
            pv_pos=pv_pos/1000;
            pv_neg=pv_neg/1000;
        end
   
        fn=fix_size(fn);
        a_pos=fix_size(a_pos);
        a_neg=fix_size(a_neg);
        pv_pos=fix_size(pv_pos);
        pv_neg=fix_size(pv_neg);
        rd_pos=fix_size(rd_pos);
        rd_neg=fix_size(rd_neg);
    
%
        clear accel_data;
        clear p_vel_data;
        clear rel_disp_data;

        accel_rms=[fn a_rms];
        accel_data=[fn a_pos a_neg];
        p_vel_data=[fn pv_pos pv_neg];
        rel_disp_data=[fn rd_pos rd_neg];
    
        accel_data_abs=zeros(num,2);
        p_vel_data_abs=zeros(num,2);
        rel_disp_data_abs=zeros(num,2);
    
        try
            accel_data_abs(:,1)=fn;
            p_vel_data_abs(:,1)=fn;
            rel_disp_data_abs(:,1)=fn;
        catch
            disp('fn error');
            num
            size(fn)
            size(accel_data_abs)
            size(p_vel_data_abs)
            size(rel_disp_data_abs)
            warndlg('fn error');
            return;
        end
    
        a_abs=zeros(num,1);
        pv_abs=zeros(num,1);
        rd_abs=zeros(num,1);

        
        for j=1:num
        
           a_abs(j)=max([ a_pos(j)  a_neg(j)]);
           accel_data_abs(j,2)= a_abs(j);
           
           pv_abs(j)=max([pv_pos(j) pv_neg(j)]);
           p_vel_data_abs(j,2)=pv_abs(j);
        
           rd_abs(j)=max([rd_pos(j) rd_neg(j)]);
           rel_disp_data_abs(j,2)= rd_abs(j);
 
        end
        
 
        if(nformat==1)
            sdata=accel_data;
        end
        if(nformat==2)
            sdata=p_vel_data;
        end
        if(nformat==3)
            sdata=rel_disp_data;
        end    
        if(nformat==4)
            sdata=accel_data_abs;
        end
        if(nformat==5)
            sdata=p_vel_data_abs;
        end
        if(nformat==6)
            sdata=rel_disp_data_abs;
        end  
        if(nformat==7)
            sdata=accel_rms;
        end  
    
        assignin('base', output_array{i}, sdata);
        out2=sprintf('%s',output_array{i});
        ss{i}=out2; 
        
        out2=sprintf('%s',output_array{i});
        ss{i}=out2;        
    
        output_array2=sprintf('%s_rms',output_array{i});
        assignin('base', output_array2, accel_rms);        
        
%%%
        fmax=fend;

    end
    
    if(qqq==0)
        THM_SRS=sdata;
    else    
        fn=THM_SRS(:,1);
        fmin=fn(1);
        fmax=fn(end);
    end    
    
    out1=sprintf('np=%d   nformat=%d  cv=%d  qqq=%d',np,nformat,cv,qqq);
    disp(out1);
    
    if(np==1)
    
        leg{i}=strrep(leg{i},'_',' ');

        [newStr]=plot_title_fix_alt(leg{i});        
      
        if(nformat==1 || nformat==4)

           
            t_string=sprintf(' Acceleration SRS Q=%g \n %s',Q,newStr);
            t_string2=sprintf(' Acceleration SRS Q=%g',Q);            
            setappdata(0,'t_string',t_string);
            setappdata(0,'t_string',t_string2);            
 
            if(iu==1 || iu==2)
                y_lab='Peak Accel (G)';
            else
                y_lab='Peak Accel (m/sec^2)';    
            end
            setappdata(0,'y_label',y_lab);
            
            x_label='Natural Frequency (Hz)';
            
            md=5;
            
            if(cv==1)

                ppp50=[1 0.8; 10000 8000];
                leg1='Measured';
                leg50='50 ips';
                y_label=y_lab;

            end

            
            if(nformat==1)

                if(qqq==1)
                    a_pos=THM_SRS(:,2);
                    a_neg=THM_SRS(:,3);
                end
                
              
                [fig_num,h2]=srs_plot_function_h(fig_num,fn,a_pos,a_neg,t_string,y_lab,fmin,fmax);
                   
            end
            if(nformat>=2)
                
                if(qqq==1)
                   a_abs=THM_SRS(:,2);
                end                
                if(cv==1)
 
                  try
                    ppp1=THM_SRS;
                  catch
                    disp('ppp1 failure');
                    return;
                  end
                  [fig_num,h2]=plot_loglog_function_md_two_h2_second_dash(fig_num,x_label,...
                  y_label,t_string,ppp1,ppp50,leg1,leg50,fmin,fmax,md);
                else
                    
                    [fig_num,h2]=srs_plot_abs_function_h(fig_num,fn,a_abs,t_string,y_lab,fmin,fmax);                    
                end
            end
                
        end
        if(nformat==2 || nformat==5)
            
            t_string=sprintf(' Pseudo Velocity SRS Q=%g \n %s',Q,newStr);
            t_string2=sprintf(' Pseudo Velocity SRS Q=%g',Q);            
            setappdata(0,'t_string',t_string2);            
            
            if(iu==1)
                y_lab='Peak Vel (in/sec)';
            else
                y_lab='Peak Vel (m/sec)';    
            end
            setappdata(0,'y_label',y_lab);            
            
            if(nformat==2)
                
               if(qqq==1)
                    pv_pos=THM_SRS(:,2);
                    pv_neg=THM_SRS(:,3);
                end                
                
                [fig_num,h2]=srs_plot_function_h(fig_num,fn,pv_pos,pv_neg,t_string,y_lab,fmin,fmax);
            else
                
                if(qqq==1)
                    pv_abs=THM_SRS(:,2);
                end
                
                [fig_num,h2]=srs_plot_abs_function_h(fig_num,fn,pv_abs,t_string,y_lab,fmin,fmax);                
            end
                
        end 
        if(nformat==3 || nformat==6)
            
            t_string=sprintf(' Relative Displacement SRS Q=%g \n %s',Q,newStr);
            t_string2=sprintf(' Relative Displacement SRS Q=%g',Q);
            setappdata(0,'t_string',t_string2);           
            
            if(iu==1)
                y_lab='Peak Rel Disp (in)';
            else
                y_lab='Peak Rel Disp (mm)';    
            end
            setappdata(0,'y_label',y_lab);            
            
            if(nformat==3)             
                
               if(qqq==1)
                    rd_pos=THM_SRS(:,2);
                    rd_neg=THM_SRS(:,3);
               end                
                
                [fig_num,h2]=srs_plot_function_h(fig_num,fn,rd_pos,rd_neg,t_string,y_lab,fmin,fmax);
            else        
                
               if(qqq==1)
                    rd_abs=THM_SRS(:,2);
               end      
               
                [fig_num,h2]=srs_plot_abs_function_h(fig_num,fn,rd_abs,t_string,y_lab,fmin,fmax);               
            end                
 
        end         
        
        set(gca,'Fontsize',nfont);
        set(h2, 'Position', [20 20 550 450]);
        
        if(psave>1)
            
            try
                pname=output_array{i};
       
                if(psave==2)
                    print(h2,pname,'-dmeta','-r300');
                    out1=sprintf('%s.emf',pname');
                end  
                if(psave==3)
                    print(h2,pname,'-dpng','-r300');
                    out1=sprintf('%s.png',pname');           
                end
                image_file{i}=out1;            
            catch
            end
        end             

    end    

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(np==1)
 
    if(psave>1)
        disp(' ');
        disp(' External Plot Names ');
        disp(' ');
        
        for i=1:kv
            out1=sprintf(' %s',image_file{i});
            disp(out1);
        end        
    end
        
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('  ');
disp('  Output Arrays ');
disp('  ');

for i=1:kv
   out1=sprintf(' %s',output_array{i});
   disp(out1);    
end

output_name='srs_array';
 
try
    assignin('base', output_name, ss');
    disp(' ');
    disp('Output array names stored in string array:');
    disp(' srs_array');
catch
end


%%%%%%%%%

legend=getappdata(0,'legend');
leg=legend;


disp(' flight names');

try
    [flight_names,~,~,~,~]=NS_flight_names();
catch
    warndlg('flight_names failed');
    return;
end

flight_names';
sz=size(flight_names);
nflights=max(sz);


for i=1:kv
  
%%
   a=output_array{i};
   
   for j=1:nflights
        ssx=strtrim(flight_names{j});
         ax=sprintf('%s_',ssx); 
         a=strrep(a,ax,'');
         a=strtrim(a);
   end
   
   output_name_sh{i}=a;
   
   a=legend{i};
   
   for j=1:nflights
        ssx=strtrim(flight_names{j});
         ax=sprintf('%s',ssx); 
         a=strrep(a,ax,'');
         a=strrep(a,'_','');
         a=strtrim(a);
   end
   
   legg{i}=a;

%%

end

output_name_uq=unique(output_name_sh);    
legg=unique(legg);

sz=size(output_name_uq);

n=max(sz);


nb=get(handles.listbox_basis,'Value');


disp(' ');
disp(' Envelope Arrays');
disp(' ');

output_array;

for i=1:n
    
    clear THM;
    
    sq=output_name_uq{i};
    
    kk=1;
    
    for j=1:kv
        if(contains(output_array{j},output_name_uq{i}))
            FSS=output_array{j};
            
            b=evalin('base',FSS);
            fn=b(:,1);
            THM(:,kk)=b(:,2);
            kk=kk+1;
        end    
    end 
    
    sz=size(THM);
    
    if(sz(2)>=2)
        
        m=sz(1);
        
        if(length(fn)~=m)
            warndlg('fn error');
            return;
        end
        
        maxa=zeros(m,1);
 
        for j=1:m
            maxa(j)=max(THM(j,:));
        end           
        
        [p9550,p9550_lognormal]=p9550_function(THM);
        
        amax=sprintf('%s_max',sq);
        ap9550=sprintf('%s_p9550',sq);
        ap9550_lognormal=sprintf('%s_p9550_lognormal',sq);
  
        assignin('base',amax, [fn maxa]);
        assignin('base',ap9550, [fn p9550]);
        assignin('base',ap9550_lognormal,[fn p9550_lognormal]);
               
%%%

        if(nb==2)
            save_array{i}=amax;
        end
        if(nb==3)
            save_array{i}=ap9550;        
        end
        if(nb==4)
            save_array{i}=ap9550_lognormal;        
        end  
        
%%%        
        
        out1=sprintf('  %s',amax);
        out2=sprintf('  %s',ap9550);
        out3=sprintf('  %s',ap9550_lognormal);        
        disp(out1);
        disp(out2);
        disp(out3);
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        md=15;
 
        ppp1=[fn p9550_lognormal];
        ppp2=[fn p9550];       
        ppp3=[fn maxa];

        leg1='P95/50 lognormal';
        leg2='P95/50';
        leg3='Maximum';    
        x_label='Natural Frequency';
        y_label=getappdata(0,'y_label');
        t_string=getappdata(0,'t_string');
        
        [fig_num,h2]=plot_loglog_function_md_three_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,leg1,leg2,leg3,fmin,fmax,md);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        for j=1:length(leg)
            leg{j}=strrep(leg{j},'_',' ');
        end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        ppp=[fn  maxa   THM];

        pleg{1}='Maximum';

        for j=1:sz(2)
            pleg{j+1}=leg{j};
        end

        [fig_num]=plot_loglog_multiple_function_none(fig_num,x_label,y_label,t_string,ppp,pleg,fmin,fmax);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        ppp=[fn p9550_lognormal p9550  maxa   THM];

        pleg{1}='P95/50 log';
        pleg{2}='P95/50';
        pleg{3}='Maximum';

        for j=1:sz(2)
            pleg{j+3}=leg{j};
        end

        [fig_num]=plot_loglog_multiple_function_none(fig_num,x_label,y_label,t_string,ppp,pleg,fmin,fmax);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        ppp=[fn   THM];

        for j=1:sz(2)
            pleg{j}=leg{j};
        end

        [fig_num]=plot_loglog_multiple_function_none(fig_num,x_label,y_label,t_string,ppp,pleg,fmin,fmax);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
    else
        ab=sprintf('%s_3dB',output_name_uq{i});
        assignin('base',ab, [fn b(:,2)*sqrt(2)]);
        
        save_array{i}=ab;
                
        out4=sprintf('  %s',ab); 
        disp(out4);
    end
    
end

%%%%%%%%%

try
    SRStemp.save_array=save_array;
    SRStemp.leg=legg;   
    
% % %
 
    try
        save SRStemp.mat SRStemp;
    catch
        warndlg('Save error');
        return;
    end    
    
catch
end

%%%%%%%%%

msgbox('Calculation complete.  See Command Window.');


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_srs_multiple)

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



function edit_start_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to edit_start_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_start_frequency as text
%        str2double(get(hObject,'String')) returns contents of edit_start_frequency as a double


% --- Executes during object creation, after setting all properties.
function edit_start_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_start_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Q_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q as text
%        str2double(get(hObject,'String')) returns contents of edit_Q as a double


% --- Executes during object creation, after setting all properties.
function edit_Q_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_plot_fmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_plot_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_plot_fmax as text
%        str2double(get(hObject,'String')) returns contents of edit_plot_fmax as a double


% --- Executes during object creation, after setting all properties.
function edit_plot_fmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_plot_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_Q and none of its controls.
function edit_Q_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_start_frequency and none of its controls.
function edit_start_frequency_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_start_frequency (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_plot_fmax and none of its controls.
function edit_plot_fmax_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_plot_fmax (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on listbox_unit and none of its controls.
function listbox_unit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


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


% --- Executes on selection change in listbox_frequency_spacing.
function listbox_frequency_spacing_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_frequency_spacing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_frequency_spacing contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_frequency_spacing


% --- Executes during object creation, after setting all properties.
function listbox_frequency_spacing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_frequency_spacing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_residual.
function listbox_residual_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_residual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_residual contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_residual


% --- Executes during object creation, after setting all properties.
function listbox_residual_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_residual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_extension_Callback(hObject, eventdata, handles)
% hObject    handle to edit_extension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_extension as text
%        str2double(get(hObject,'String')) returns contents of edit_extension as a double


% --- Executes during object creation, after setting all properties.
function edit_extension_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_extension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_plots.
function listbox_plots_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_plots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_plots contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_plots

np=get(handles.listbox_plots,'Value');

if(np==1)

    set(handles.listbox_psave,'Visible','on');
    set(handles.text_export,'Visible','on');    
    
    set(handles.text_font_size,'Visible','on');
    set(handles.edit_font_size,'Visible','on');
   
else
    
    set(handles.listbox_psave,'Visible','off');
    set(handles.text_export,'Visible','off');
    
    set(handles.text_font_size,'Visible','off');
    set(handles.edit_font_size,'Visible','off');
end    


% --- Executes during object creation, after setting all properties.
function listbox_plots_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_plots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_font_size_Callback(hObject, eventdata, handles)
% hObject    handle to edit_font_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_font_size as text
%        str2double(get(hObject,'String')) returns contents of edit_font_size as a double


% --- Executes during object creation, after setting all properties.
function edit_font_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_font_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_num.
function listbox_num_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num


%%%%
 
Nrows=get(handles.listbox_num,'Value');
Ncolumns=2;
 
A=get(handles.uitable_data,'Data');
 
sz=size(A);
Arows=sz(1);
 
for i=1:Nrows
    for j=1:Ncolumns
        data_s{i,j}='';
    end    
end    
 
if(~isempty(A))
    
    M=min([ Arows Nrows ]);
    
    for i=1:M
        for j=1:Ncolumns
            data_s{i,j}=A{i,j};
        end    
    end   
 
end
 
set(handles.uitable_data,'Data',data_s);


% --- Executes during object creation, after setting all properties.
function listbox_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save_model.
function pushbutton_save_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%

try
    time=get(handles.listbox_time,'Value'); 
    SRSmult.time=time;      
catch
end

try
    start_time=get(handles.edit_start_time,'String'); 
    SRSmult.start_time=start_time;      
catch
end

try
    end_time=get(handles.edit_end_time,'String'); 
    SRSmult.end_time=end_time;      
catch
end


%%%

try
    A=get(handles.uitable_data,'Data'); 
    SRSmult.A=A;      
catch
end

try
    output_type=get(handles.listbox_output_type,'Value'); 
    SRSmult.output_type=output_type;      
catch
end

try
    num=get(handles.listbox_num,'Value'); 
    SRSmult.num=num;      
catch
end

try
    unit=get(handles.listbox_unit,'Value'); 
    SRSmult.unit=unit;      
catch
end

try
    frequency_spacing=get(handles.listbox_frequency_spacing,'Value'); 
    SRSmult.frequency_spacing=frequency_spacing;      
catch
end

try
    residual=get(handles.listbox_residual,'Value'); 
    SRSmult.residual=residual;      
catch
end


try
    plots=get(handles.listbox_plots,'Value'); 
    SRSmult.plots=plots;      
catch
end

try
    psave=get(handles.listbox_psave,'Value'); 
    SRSmult.psave=psave;      
catch
end


% % %


try
    fmin=get(handles.edit_start_frequency,'String'); 
    SRSmult.fmin=fmin;      
catch
end

try
    fmax=get(handles.edit_plot_fmax,'String'); 
    SRSmult.fmax=fmax;      
catch
end

try
    Q=get(handles.edit_Q,'String'); 
    SRSmult.Q=Q;      
catch
end

try
    ext=get(handles.edit_extension,'String'); 
    SRSmult.ext=ext;      
catch
end

try
    font_size=get(handles.edit_font_size,'String'); 
    SRSmult.font_size=font_size;      
catch
end

% % %
SRSmult
 
structnames = fieldnames(SRSmult, '-full'); % fields in the struct
  
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);

    
    try
 
        save(elk, 'SRSmult'); 
 
    catch
        warndlg('Save error');
        return;
    end
 
%%% SSS=load(elk)
 
%%%%%%%%%%
%%%%%%%%%%
 
msgbox('Save Complete');


% --- Executes on button press in pushbutton_load_model.
function pushbutton_load_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile('*.mat', 'Select plot save file');

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

   SRSmult=evalin('base','SRSmult');

catch
   warndlg(' evalin failed ');
   return;
end

%%%%%%%%%%%%

try
    num=SRSmult.num;
    set(handles.listbox_num,'Value',num); 
catch
end

listbox_num_Callback(hObject, eventdata, handles);

%%%

try
    A=SRSmult.A;
    set(handles.uitable_data,'Data',A); 
catch
end


try
    output_type=SRSmult.output_type;     
    set(handles.listbox_output_type,'Value',output_type);      
catch
end


try
    unit=SRSmult.unit;   
    set(handles.listbox_unit,'Value',unit);     
catch
end


try
    frequency_spacing=SRSmult.frequency_spacing;    
    set(handles.listbox_frequency_spacing,'Value',frequency_spacing);       
catch
end



try
    residual=SRSmult.residual;     
    set(handles.listbox_residual,'Value',residual);      
catch
end


try
    plots=SRSmult.plots;      
    set(handles.listbox_plots,'Value',plots);     
catch
end

try
    psave=SRSmult.psave;     
    set(handles.listbox_psave,'Value',psave);      
catch
end


% % %

try
    fmin=SRSmult.fmin;  
    set(handles.edit_start_frequency,'String',fmin);      
catch
end

try
    fmax=SRSmult.fmax;    
    set(handles.edit_plot_fmax,'String',fmax); 
catch
end

try
    Q=SRSmult.Q;     
    set(handles.edit_Q,'String',Q);      
catch
end

try
    ext=SRSmult.ext;    
    set(handles.edit_extension,'String',ext);       
catch
end

try
    font_size=SRSmult.font_size;     
    set(handles.edit_font_size,'String',font_size);      
catch
end



try
    time=SRSmult.time;    
    set(handles.listbox_time,'Value',time); 
catch
end

try
    start_time=SRSmult.start_time;      
    set(handles.edit_start_time,'String',start_time);     
catch
end

try
    end_time=SRSmult.end_time;       
    set(handles.edit_end_time,'String',end_time);    
catch
end

listbox_time_Callback(hObject, eventdata, handles);

% % %






% --- Executes on button press in pushbutton_envelope.
function pushbutton_envelope_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_envelope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=srs_envelope_plus;

set(handles.s,'Visible','on');


function get_table_data(hObject, eventdata, handles)


try
    data=get(handles.uitable_data,'Data');
    A=char(data);
    setappdata(0,'data',data);
    
    
    N=get(handles.listbox_num,'Value');

    k=1;

    for i=1:N
        array_name{i}=A(k,:); k=k+1;
        array_name{i} = strtrim(array_name{i});
    end 
    for i=1:N
        legend{i}=A(k,:); k=k+1;
        legend{i} = strtrim(legend{i});
    end 

catch
    warndlg('Input Arrays read failed');
    return;
end

array_name

setappdata(0,'array_name',array_name); 
setappdata(0,'legend',legend);


% --- Executes on button press in pushbutton_reset.
function pushbutton_reset_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Nrows=get(handles.listbox_num,'Value');
 
Ncolumns=2;
 
for i=1:Nrows
    for j=1:Ncolumns
        data_s{i,j}='';
    end    
end  


set(handles.uitable_data,'Data',data_s);


% --- Executes on button press in pushbutton_delete.
function pushbutton_delete_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Nrows=get(handles.listbox_num,'Value');
 
Ncolumns=2;
 
A=get(handles.uitable_data,'Data');
 
sz=size(A);
Arows=sz(1);
 
for i=1:Nrows
    for j=1:Ncolumns
        data_s{i,j}='';
    end    
end    
 
if(~isempty(A))
    
    M=min([ Arows Nrows ]);
    
    for i=1:M
        for j=1:Ncolumns
            data_s{i,j}='';
            try
                data_s{i,j}=A{i,j};
            catch
            end
            
        end    
    end   
 
end
 
nd=get(handles.listbox_delete,'Value');
 
if(nd<=Nrows)
    
    temp=data_s;
    clear data_s;
    
    
    
    for i=1:(nd-1)
        for j=1:Ncolumns
            try
                data_s{i,j}=temp{i,j};
            catch
            end
            
        end    
    end  
    
    for i=(nd+1):Nrows
        for j=1:Ncolumns
            try
                data_s{i-1,j}=temp{i,j};
            catch
            end
            
        end    
    end      
    
    Nrows=Nrows-1;
    set(handles.listbox_num,'Value',Nrows);    
end
 
set(handles.uitable_data,'Data',data_s);
 
 




% --- Executes on selection change in listbox_delete.
function listbox_delete_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_delete contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_delete


% --- Executes during object creation, after setting all properties.
function listbox_delete_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_basis.
function listbox_basis_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_basis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_basis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_basis


% --- Executes during object creation, after setting all properties.
function listbox_basis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_basis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_cv.
function listbox_cv_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_cv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_cv contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_cv


% --- Executes during object creation, after setting all properties.
function listbox_cv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_cv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_time.
function listbox_time_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_time contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_time
n=get(handles.listbox_time,'Value');

if(n==1)
    set(handles.edit_start_time,'Visible','off');
    set(handles.edit_end_time,'Visible','off');    
    set(handles.text_start_time,'Visible','off');
    set(handles.text_end_time,'Visible','off');       
else
    set(handles.edit_start_time,'Visible','on');
    set(handles.edit_end_time,'Visible','on');    
    set(handles.text_start_time,'Visible','on');
    set(handles.text_end_time,'Visible','on');           
end


% --- Executes during object creation, after setting all properties.
function listbox_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_start_time_Callback(hObject, eventdata, handles)
% hObject    handle to edit_start_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_start_time as text
%        str2double(get(hObject,'String')) returns contents of edit_start_time as a double


% --- Executes during object creation, after setting all properties.
function edit_start_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_start_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_end_time_Callback(hObject, eventdata, handles)
% hObject    handle to edit_end_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_end_time as text
%        str2double(get(hObject,'String')) returns contents of edit_end_time as a double


% --- Executes during object creation, after setting all properties.
function edit_end_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_end_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

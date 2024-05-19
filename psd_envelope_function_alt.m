%
%  psd_envelope_function_alt.m  ver 1.0   by Tom Irvine
%
%  This script calculates a simplified PSD for a narrowband PSD
%  via the VRS method.  The simplified PSD includes the SMC-S-016
%  minimum workmanship PSD.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Input Data
%
%   input_psd = input PSD  freq (Hz) & accel (G^2/Hz)
%
%   ntrials = number of trials, suggest 1000
%
%   PSD envelope choice number & type
%
%   Note that the envelope will be modified to cover SMC-S-016
%
%   npb
%
%   1  two arbitrary
%   2  three arbitrary
%   3  three ramp-plateau
%   4  four arbitrary
%   5  four ramp-plateau-ramp
%   6  five arbitrary
%   7  fire ramp-plateau-ramp-plateau
%   8  six Three Ramps & Two Plateaus
%   9  eight Four Ramps & Three Plateaus
%   10  three plateau-ramp
%   11  six arbitrary
%   12  seven arbitrary
%   13  ten Five Ramps & Four Plateaus
%   14  eleven Six Ramps & Five Plateaus
%   15  twelve Seven Ramps & Six Plateaus
%
%   Q = amplification factor
%
%   plots = 1 for plots on
%         = 2 for plots off   
%
%   seed = random number seed, suggest 1
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Output Data
%
%       env_psd = envelope psd
%       env_vrs = envelope vrs
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   External functions
%
%       calculate_PSD_slopes_no
%       interpolate_PSD_arbitrary_frequency
%       env_make_input_vrs
%       fix_size
%       env_generate_sample_psd_via_vrs
%       opt_psd_amplitude_adjust_via_vrs
%       freq_slope_check
%       env_generate_sample_psd2_via_vrs
%       env_interp_sam
%       env_grms_sam
%       env_vrms_sam
%       env_drms_sam
%       env_checklow
%       env_interp_best
%       env_vrs_best
%       plot_loglog_function_md_two_h2
%       subplots_two_and_two_h2
%       xtick_label
%       ymax_ymin_md
%       smooth_psd_function
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

function[env_psd,env_vrs]=...
    psd_envelope_function_alt(input_psd,ntrials,npb,Q,plots,seed)

    rng(seed);

    fig_num=1;

    fmin=20;
    fmax=2000;

    spsd=[  20 	  0.0053 
            150   0.04 
            800   0.04 
            2000  0.0064];     

    [nbreak]=number_break(npb);

    THM=input_psd;

    initial=2;
    final=2;    

    nfc=2;
            
    if(THM(:,1)<1.0e-20)
        THM(1,:)=[];
    end
            
    [~,ii]=min(abs(THM(:,1)-fmin));
    [~,jj]=min(abs(THM(:,1)-fmax));
            
    THM=THM(ii:jj,:);
            
    f1=fmin;
    f2=fmax;
            
    FL(1)=fmin;
    FU(1)=fmin;
    FL(nbreak)=fmax;
    FU(nbreak)=fmax;
            
    dam=1/(2*Q);
            
    record = 1.0e+90;
    grmslow=1.0e+50;
    vrmslow=1.0e+50;
    drmslow=1.0e+50;
            
    goal=3;  % Minimize: acceleration, velocty, displacement

    xf=zeros(nbreak,1);
    xapsd=zeros(nbreak,1);
            
    slopec=21;
    slopec=(slopec/10)/log10(2);
            
    %
    ocn=1/48;
    %
    octave=-1.+(2.^ocn);
    %
    fin=THM(:,1);
    psdin=THM(:,2);
    %
    if( min(psdin) <= 0. )
        disp(' Input error:  each PSD amplitude must be > 0.');
        return;
    end               
    %
    if( min(fin) < 0. )
        disp(' Input error:  each frequency must be > 0.');
        return;
    end               
    %
    if(fin(1)<1.0e-04)
        fin(1)=1.0e-04;
    end
    %
    clear length;
    nin = length(fin);
    %
    inslope=zeros((nin-1),1);
    %
    for i=2:nin
        inslope(i-1)= log(psdin(i)/psdin(i-1))/log(fin(i)/fin(i-1));
    end
    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %
    [~,grms_input]= calculate_PSD_slopes_no(fin,psdin);
    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %
    % Interpolate Input PSD
    %       
    f=fin;
    a=psdin;

    new_freq=round(fmin):round(fmax);

    [fi,ai] = interpolate_PSD_arbitrary_frequency(f,a,new_freq);

    n_ref=length(fi);
            
    interp_psdin=ai;
    f_ref=fi;

    %
    % Interpolate SMC-S-016
    %

    [~,sai] = interpolate_PSD_arbitrary_frequency(spsd(:,1),spsd(:,2),new_freq);

    %
    % Convert the input PSD to a VRS
    %  
    [a_ref]=env_make_input_vrs(interp_psdin,n_ref,f_ref,octave,dam);
                
    a_ref=fix_size(a_ref);
                
    input_vrs=[f_ref a_ref];
    %            
    nx=ntrials*0.3;
                
    if(nx<4)
        nx=4;
    end
            
    for ik=1:ntrials                
    %      
        if(rand()>0.7 || ik<nx)
          
        % Generate the sample psd
                        
            [f_sam,apsd_sam,~,slopec]=...
                            env_generate_sample_psd_via_vrs(n_ref,nbreak,npb,f_ref,slopec,initial,final,f1,f2,FL,FU,nfc);
        %          
        else
        %         
            [f_sam,apsd_sam]=env_generate_sample_psd2_via_vrs_alt(xf,xapsd);                 
        end
            
        %
        %     Interpolate the sample psd
        [f_samfine,apsd_samfine]=env_interp_sam(f_sam,apsd_sam,nbreak,n_ref,f_ref);

        %     envelope SMC-S-016

        for i=1:n_ref
            if(apsd_samfine(i)<sai(i))
                apsd_samfine(i)=sai(i);
            end    
        end   

        ppp1=[spsd(:,1) spsd(:,2)];
        ppp2=[f_samfine apsd_samfine];
        t_string='PSD';
        x_label='Frequency (Hz)';
        y_label='Accel (G^2/Hz)';
        md=4;
        leg1='a';
        leg2='b';

        % [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
        %       y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);

        %                         
        %      Calculate the vrs of the sample psd
        [vrs_samfine]=env_vrs_sample(n_ref,f_ref,octave,dam,apsd_samfine);
        %    
        %      Compare the sample vrs with the reference vrs
        [scale]=env_compare_rms(n_ref,a_ref,vrs_samfine);
        %
        %      scale the psd
        scale=(scale^2);
        apsd_samfine=apsd_samfine*scale*1.04;

        %     envelope SMC-S-016

        for i=1:n_ref
            if(apsd_samfine(i)<sai(i))
                apsd_samfine(i)=sai(i);
            end    
        end   

        %
        %      Smooth the PSD
        %
        [f_sam,apsd_sam]=smooth_psd_function(f_samfine,apsd_samfine);
        nbreak2=length(f_sam);

        %       
        %      calculate the grms value 
        %             
        [grms]=env_grms_sam(nbreak2,f_sam,apsd_sam);
        [vrms]=env_vrms_sam(nbreak2,f_sam,apsd_sam);
        [drms]=env_drms_sam(nbreak2,f_sam,apsd_sam);
        %    
        [iflag,record]=env_checklow(grms,vrms,drms,grmslow,vrmslow,drmslow,record,goal);
        %       
        if(iflag==1)
        %           
            if(drms<drmslow)
                drmslow=drms;
            end
            if(vrms<vrmslow)
                vrmslow=vrms;
            end
            if(grms<grmslow)
                grmslow=grms;
            end
            %           
            drmsp=drms;
            vrmsp=vrms;
            grmsp=grms;
            %
            xf=f_sam;
            xapsd=apsd_sam;             
            %       
            % Interpolate the best psd
            %
            f_ref=fix_size(f_ref);
            %         
            [xapsdfine]=env_interp_best(nbreak2,n_ref,xf,xapsd,f_ref);
            %
            xapsdfine=fix_size(xapsdfine);
            %
            xf=fix_size(xf); 
            xapsd=fix_size(xapsd);
            %
            best_psd=[xf xapsd];
            %
            % Calculate the vrs of the best vrs
            %
            [xvrs]=env_vrs_best(n_ref,dam,octave,xapsdfine,f_ref);          
            %
            xvrs=fix_size(xvrs);
            %
            best_vrs=[f_ref xvrs];
      
        end  
            
    end
                      
    %
    disp('__________________________________________________________');
    %
    disp('Optimum Case');
    disp(' ');
    %
    fprintf(' drms=%10.4g  vrms=%10.4g  grms=%10.4g \n',drmsp,vrmsp,grmsp); 
    %   
    disp('__________________________________________________________');
    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %

    if(plots==1)

        pmd=6;
        px_label='Frequency(Hz)';
              
        py_label='Accel (G^2/Hz)';
        pleg1=sprintf('Input, %6.3g GRMS',grms_input);
        pleg2=sprintf('Envelope, %6.3g GRMS',grmsp); 
        pt_string='Power Spectral Density';

        ppp1=[fin psdin];
        ppp2=best_psd;
             
        [fig_num,~]=plot_loglog_function_md_two_h2(fig_num,px_label,...
                           py_label,pt_string,ppp1,ppp2,pleg1,pleg2,fmin,fmax,pmd);

        qqq1=input_vrs;
        qqq2=best_vrs;

        qy_label='Accel (GRMS)';
        qt_string=sprintf('Vibration Response Spectra  Q=%g',Q);   
      
        qx_label='Natural Frequency(Hz)';
        qmd=5;
            
        qleg1=pleg1;
        qleg2=pleg2;
              
        [fig_num,~]=plot_loglog_function_md_two_h2(fig_num,qx_label,...
                           qy_label,qt_string,qqq1,qqq2,qleg1,qleg2,fmin,fmax,qmd);
                        
        [fig_num,~]=subplots_two_and_two_h2(fig_num,...
                            px_label,py_label,pt_string,ppp1,ppp2,pleg1,pleg2,...
                            qx_label,qy_label,qt_string,qqq1,qqq2,qleg1,qleg2,...
                            fmin,fmax,pmd,qmd);      
        
    end
                  
    disp(' ');
    disp(' Best PSD ');
    disp(' ');

    ss=' Freq(Hz)  Accel(G^2/Hz) ';
    s5=sprintf('\n\n Overall %7.3g GRMS',grmsp);

    disp(ss);
    ss=sprintf('%s\n\n',ss);

    for i=1:nbreak
        s2=sprintf(' %8.4g \t %7.3g \n',best_psd(i,1),best_psd(i,2));
        fprintf('%s',s2);
        ss=sprintf('%s %s',ss,s2);
    end
            
    ss=sprintf('%s %s \n\n',ss,s5);           
    fprintf(ss);

    env_psd=best_psd;
    env_vrs=best_vrs;

end

function[nbreak]=number_break(npb)
            if(npb==1)
                nbreak=2;
            end
            if(npb==2)
                nbreak=3;    
            end
            if(npb==3)
                nbreak=3;    
            end
            if(npb==4)
                nbreak=4;    
            end
            if(npb==5)
                nbreak=4;    
            end
            if(npb==6)
                nbreak=5;    
            end
            if(npb==7)
                nbreak=5;    
            end
            if(npb==8)
                nbreak=6;    
            end
            if(npb==9)
                nbreak=8;    
            end
            if(npb==10)
                nbreak=3;    
            end
            if(npb==11)
                nbreak=6;    
            end
            if(npb==12)
                nbreak=7;    
            end
            if(npb==13)
                nbreak=10;    
            end
            if(npb==14)
                nbreak=12;    
            end
            if(npb==15)
                nbreak=14; 
            end
end                        
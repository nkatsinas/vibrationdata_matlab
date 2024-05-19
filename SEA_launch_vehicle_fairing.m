
%  SEA_launch_vehicle_faring.m   ver 1.0  by Tom Irvine

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Input variables
%
%  max_dB = Maximum Allowable Noise Reduction (dB) considering Vent Openings, 
%           Flanking Noise, etc, suggest 20 d
%
%  air_dens = air density (lbm/ft^3), suggest 0.0765
%
%  c = gas speed of sound (ft/sec), suggest 1125
%
%  em = elastic moduls (psi)
%  md = mass density (lbm/in^3) 
%  mu = Poisson ratio
%  thick = thickness (in)
%  diam= diameter (in)
%  L= length (in)
%
%  SPL = one-third octave SPL:  fc(Hz) & SPL(dB)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Output variables
%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function[]=SEA_launch_vehicle_fairing(max_dB,air_dens,c,em,md,mu,thick,diam,L,SPL)

    tpi=2*pi;

    fairing(max_dB,air_dens,c,em,md,mu,thick,diam,L,SPL);

            power=getappdata(0,'external_acoustic_power');
     external_SPL=getappdata(0,'external_spl_data');
            
    fairing_modal_density=getappdata(0,'fairing_modal_density');
  fairing_rad_eff=getappdata(0,'fairing_rad_eff');
      fairing_dlf=getappdata(0,'fairing_dlf');
     fairing_mass=getappdata(0,'fairing_mass');
       fairing_md=getappdata(0,'fairing_md');
    fairing_thick=getappdata(0,'fairing_thick');
       fairing_cL=getappdata(0,'fairing_cL');     
     fairing_area=getappdata(0,'fairing_area');    
     
    fairing_fring=getappdata(0,'fairing_fring');     
      fairing_fcr=getappdata(0,'fairing_fcr');           
            
      fairing_mass_area= fairing_mass/fairing_area; 
      
end
function[]=fairing(SPL)

    THM=SPL;

    sz=size(THM);
    
    if(sz(2)~=2)
        warndlg('Input file must have 2 columns ');
        return;
    end
    
    %%%%%%
    
    fc=THM(:,1);
    dB=THM(:,2);
    
    setappdata(0,'fc',fc);
    
    NL=length(fc);
    
    pressure=zeros(NL,1);
    
    for i=1:NL
    
        [psi_rms,Pa_rms]=convert_dB_pressure(dB(i));
    
        if(iu==1)
            pressure(i)=psi_rms; 
        else
            pressure(i)=Pa_rms;     
        end
    
    end

    setappdata(0,'fairing_L',L);
    getappdata(0,'fairing_L');

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    setappdata(0,'fairing_homogeneous_shell_em',em);
    setappdata(0,'fairing_homogeneous_shell_rho',md);
    setappdata(0,'fairing_homogeneous_shell_mu',mu);
    setappdata(0,'fairing_c',c);
    setappdata(0,'fairing_gas_md',gas_md);
    setappdata(0,'external_spl_data',THM);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    iu=1;
    
    if(iu==1)
        md=md/386;
        gas_md=gas_md/(12^3*386);
        c=c*12;
        su='in/sec';
    else
        [em]=GPa_to_Pa(em);
        thick=thick/1000; 
        su='m/sec';    
    end

    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
function[]=acoustic_cavity()

end
function[psi_rms,Pa_rms]=convert_dB_pressure(dB)
    %
    ref=20e-06;
    %
    Pa_rms=ref*10^(dB/20);
    %
    psi_rms=Pa_rms*0.00014511;
end    

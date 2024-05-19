%
%  env_ers.m  ver 1.0  November 3, 2015
%
function[ers_sam,base]=env_ers(interp_psdin,fn,dam,iu,...
                                       white_noise,num_white,syn_dur,df,dt) 
%
n_dam=length(dam);
n_fn=length(fn);
np=num_white;

tmax=syn_dur;

[aslope,rms] = calculate_PSD_slopes(interp_psdin(:,1),interp_psdin(:,2));


freq=interp_psdin(:,1);
amp=interp_psdin(:,2);
slope=aslope;




[fft_freq,spec]=interpolate_PSD_spec_ers(np,freq,amp,slope,df);

fmax=max(freq);


%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
nsegments = 1;
%
sq_spec=sqrt(spec);

sq_spec=fix_size(sq_spec);


mmm=round(np/2);


%% out1=sprintf('\n syn_dur=%8.4g  num_white=%8.4g',syn_dur,num_white);
%% disp(out1);

%% out1=sprintf('\n df=%8.4g  fmax=%8.4g  mmm=%d   np=%d  dt=%8.4g',df,fmax,mmm,np,dt);
%% disp(out1);


[Y,psd_th,nL]=PSD_syn_FFT_core_ers(nsegments,mmm,np,fmax,df,sq_spec,white_noise);
%



psd_th=fix_size(psd_th);



%% data=[tt psd_th];
%% output_name='unscaled';
%% assignin('base', output_name, data);



[TT,psd_th,dt]=PSD_syn_scale_time_history_ers(psd_th,rms,np,tmax);
%

base=psd_th;

%
ers_samfine=zeros(n_dam,n_fn);

pbar=2;

for ijk=1:n_dam

    [ers_sam,slabel]=env_ers_th_direct(base,dt,fn,dam,iu,pbar);

    for i=1:n_fn
        ers_samfine(ijk,i)=ers_sam(i);
    end
    
end

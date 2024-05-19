
%   env_fds_batch_interpolated_scale.m  ver 1.0  by Tom Irvine


function[apsd_sam,grms,vrms,drms]=...
    env_fds_batch_interpolated_scale(f_sam,apsd_sam,nbreak,n_ref,fn,iu,damp,bex,T_out,nmetric,fds_ref)


%      Interpolate the sample psd

    [fn,apsd_samfine]=env_interp_sam(f_sam,apsd_sam,nbreak,n_ref,fn);
% 
 
    a11=max(apsd_samfine);
    a22=min(apsd_samfine);
    
    if(a22<1.0e-20)
    
        out1=sprintf('\n max(apsd_samfine)=%8.4g  min(apsd_samfine)=%8.4g \n',a11,a22);
        disp(out1);    
    
    end
    
    for nv=1:length(apsd_samfine)
       
        if isnan(apsd_samfine(nv))
           
                disp(' error in env_fds_batch_interpolated_scale.m');
                disp(' '); 
                
                for iv=1:length(fn)
                    out1=sprintf(' %8.4g  %8.4g ',fn(iv),apsd_samfine(iv));
                    disp(out1);                    
                end

                disp(' ');
                disp('  Type  Ctrl-C ');
                aaa=input(' ');
                return;
            
        end    
    end
    
 
%      Calculate the fds of the sample psd
    [fds_samfine]=env_fds_batch(apsd_samfine,n_ref,fn,damp,bex,T_out,iu,nmetric);    
%    


%      Compare the sample fds with the reference fds
    [scale]=env_compare(n_ref,fds_ref,fds_samfine,bex);
%
%      scale the psd
    scale=(scale^2.);
    apsd_sam=apsd_sam*scale;

    
%       
%      calculate the grms value 
%             
    [grms]=env_grms_sam(nbreak,f_sam,apsd_sam);
%
    [vrms]=env_vrms_sam(nbreak,f_sam,apsd_sam);
%
    [drms]=env_drms_sam(nbreak,f_sam,apsd_sam);
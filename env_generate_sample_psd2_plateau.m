%
%   env_generate_sample_psd2_plateau.m  ver 1.0  January 10, 2013
%
function[f_sam,apsd_sam]=...
    env_generate_sample_psd2_plateau(n_ref,nbreak,f_ref,xf,xapsd,...
                                             slopec,initial,final,ik,f1,f2)
%  
    f_sam(1)=f1;
    f_sam(nbreak)=f2;
%
    if( rand()>0.2)
        bbb=(rand())^3.;
    else
        bbb=0.1*rand();
    end
%
    aaa=1.-bbb/2.;
%  
    for(i=1:(nbreak-1))
        f_sam(i)=xf(i)*(aaa+bbb*rand());    
    end
%   
        % sort the frequencies
%
          f_sam=sort(f_sam);  
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% check frequencies for adequate spacing
%		  
    ialarm = 0;
    fnum = (f_ref(n_ref)-f_ref(1))/200.;
%
    for i=1:(nbreak-1)
%
        if (  abs( log(f_sam(i+1)/f_sam(i))/log(2) ) < 1 )
            ialarm = 1;
            break;
        end
    end
%    
    if(ialarm == 1 )
%
        df=(f_ref(n_ref)-f_ref(1))/(n_ref-1);
%    
        for i=2:nbreak
            f_sam(i)=f_sam(i-1)+df;
        end
    end
    f_sam(nbreak)=f_ref(n_ref);
    f_sam=sort(f_sam);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
       % generate some random number for amplitude
%
        bbb=(rand())^3.;
%
        aaa=1.-bbb/2.;
%
        for(i=1:nbreak)
%       
            apsd_sam(i)=xapsd(i)*(aaa+bbb*rand());
%
            if(apsd_sam(i)>2000.)
%           
                out1=sprintf(' Error: %ld  %8.4g  %8.4g \n',i,apsd_sam(i),xapsd(i));
                disp(out1);
%               
                exit(1);
%
            end
        end
%
    % add constraint
%
    % absolute slopes are limited to slopec
%
    for i=1:(nbreak-1)
        fr=f_sam(i+1)/f_sam(i);
        sss=0.;
        sss=log(apsd_sam(i+1)/apsd_sam(i))/log(fr);
        if(sss > slopec)
            apsd_sam(i+1)=apsd_sam(i)*(fr^slopec);
        end
        if(sss < -slopec)
            apsd_sam(i+1)=apsd_sam(i)*(fr^(-slopec));
        end
    end
    if(initial==1 && apsd_sam(1) > apsd_sam(1))
        apsd_sam(1)=apsd_sam(1);
    end
    if(final==1 && apsd_sam(nbreak) > apsd_sam(nbreak-1))
        apsd_sam(nbreak)=apsd_sam(nbreak-1);
    end
%
f_sam(1)=f1;
f_sam(nbreak)=f2;
%
f_sam=sort(f_sam);
%
    out1=sprintf('\n Phase 2, Trial %ld, PSD Coordinates \n',ik);
    disp(out1);
% 
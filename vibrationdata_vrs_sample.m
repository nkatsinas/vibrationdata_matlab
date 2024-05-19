%
%   vibrationdata_vrs_sample.m  ver 1.0 by Tom Irvine
%
function[vrs_samfine_grms,vrs_samfine_peak]=...
                         vibrationdata_vrs_sample(f_ref,apsd_samfine,Q,dur)
%
    fn=f_ref;
%
    n_ref=length(f_ref);
%
    nq=size(apsd_samfine);
    if(nq~=n_ref)
        out1=sprintf('\n  vibrationdata_vrs_sample error: nq=%d  n_ref=%d ',nq,n_ref);
        disp(out1);
        fn'
    end
%
    dam=1/(2*Q);
%
    vrs_samfine_grms=zeros(n_ref,1);
    vrs_samfine_peak=zeros(n_ref,1);
%
    for i=1:n_ref
%	
		response_psd=zeros(n_ref,1); 
%
		for j=1:n_ref
%		
              % f_ref(i) is the natural frequency
			  % f_ref(j) is the forcing frequency
%
	          rho=f_ref(j)/f_ref(i);			  
			  tdr=2.*dam*rho;
%
			  tden=((1.-(rho^2))^2)+ (tdr^2);
			  tnum=1.+(tdr^2);
%
			  trans=tnum/tden;
%
              response_psd(j)=trans*apsd_samfine(j);       
%
        end
%
        [~,rms] = calculate_PSD_slopes_no(f_ref,response_psd);
%	
		vrs_samfine_grms(i)=rms;
        fnT=f_ref(i)*dur;
        A=sqrt(2*log(fnT));
        vrs_samfine_peak(i)=rms*(A+(0.5772/A));
    end

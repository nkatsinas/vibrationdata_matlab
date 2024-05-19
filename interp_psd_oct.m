%
%  interp_psd_oct.m  ver 1.0  December 13, 2013
%
function[apsd_samfine]=interp_psd_oct(f_sam,apsd_sam,fi)
%
    n_break=length(f_sam);
    n_ref=length(fi);
%
    apsd_samfine=zeros(n_ref,1);
%
    slope=zeros(n_break-1,1);
%
    for i=1:(n_break-1)
		slope(i)=log(apsd_sam(i+1)/apsd_sam(i))/log(f_sam(i+1)/f_sam(i));
    end
%
    for i=1:n_ref 
%
        for j=1:(n_break-1)
%		
            if( ( fi(i) >= f_sam(j) ) &&  ( fi(i) <= f_sam(j+1) )  )		
				apsd_samfine(i)=apsd_sam(j)*( ( fi(i) / f_sam(j) )^slope(j) );
				break;
            end
        end
%
    end
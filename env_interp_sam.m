%
%  env_interp_sam.m  ver 1.2 by Tom Irvine
%
function[f_samfine,apsd_samfine]=env_interp_sam(f_sam,apsd_sam,nbreak,n_ref,f_ref)
%
    nbreak=min([length(f_sam) length(apsd_sam)]);

    apsd_samfine=zeros(n_ref,1);
    f_samfine=f_ref;
%
    slope=zeros(nbreak-1,1);
%
	for i=1:(nbreak-1)
		slope(i)=log(apsd_sam(i+1)/apsd_sam(i))/log(f_sam(i+1)/f_sam(i));
        
        if(isnan( slope(i)))
            out1=sprintf(' %8.4g %8.4g',f_sam(i),apsd_sam(i));
            out2=sprintf(' %8.4g %8.4g',f_sam(i+1),apsd_sam(i+1));
            disp(out1);
            disp(out2);
            disp('  apsd_samfine(1)  error ');
        end
        
    end
    
    
%
    for i=1:n_ref 
%
        for j=1:(nbreak-1)
%		
			if( ( f_samfine(i) >= f_sam(j) ) &&  ( f_samfine(i) <= f_sam(j+1) )  )		
				apsd_samfine(i)=apsd_sam(j)*( ( f_samfine(i) / f_sam(j) )^slope(j) );
				break;
            end
        end
%
    end
%
    nq=size(apsd_samfine);
    if(nq~=n_ref)
        out1=sprintf('\n env_interp_sam error: nq=%d  n_ref=%d ',nq,n_ref);
        disp(out1);
    end
 
    apsd_samfine(1)=apsd_sam(1);
    
    if(isnan( apsd_samfine(1)))
        disp('  apsd_samfine(1)  error ');
    end
    
    
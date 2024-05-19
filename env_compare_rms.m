%
%  env_compare_rms.m  ver 1.0  May 5, 2014
%
function[scale]=env_compare_rms(n_ref,a_ref,vrs_samfine)
%
	scale=0.;
%
	for i=1:n_ref 
		    if( vrs_samfine(i) < 1.0e-30)
			    out1=sprintf('\n Error:  vrs_samfine(%ld])=%10.4g ',i,vrs_samfine(i));
                disp(out1);
			    uuu=input(' Enter Ctrl-c ');
            end
            if(  (a_ref(i)/vrs_samfine(i)) > scale )
			    scale=(a_ref(i)/vrs_samfine(i));
            end
    end
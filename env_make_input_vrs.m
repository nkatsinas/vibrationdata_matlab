
%  env_make_input_vrs.m  ver 1.0  by Tom Irvine

function[a_ref]=env_make_input_vrs(interp_psdin,n_ref,f_ref,octave,dam)
%
    a_ref=zeros(n_ref,1);

    for i=1:n_ref
%	
		sum=0.;
%
	    for j=1:n_ref
%		
              % f_ref(i) is the natural frequency
			  % f_ref(j) is the forcing frequency
%
	          rho=f_ref(j)/f_ref(i);
%			  
			  tdr=2.*dam*rho;
%
			  tden=((1.-(rho^2))^2)+(tdr^2);
			  tnum=1.+(tdr^2);
%
			  trans=tnum/tden;
%
              dfi=f_ref(j)*octave;
%
			  sum=sum+trans*interp_psdin(j)*dfi;
%	  
        end
		sum=sqrt(sum);
		a_ref(i)=sum;
   end     
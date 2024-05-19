function[vrs_samfine]=env_vrs_sample(n_ref,f_ref,octave,dam,apsd_samfine)
%   
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
			  tdr=2.*dam*rho;
%
			  tden=((1.-(rho^2))^2)+ (tdr^2);
			  tnum=1.+(tdr^2);
%
			  trans=tnum/tden;
%
               dfi=f_ref(j)*octave;
%
			  sum=sum+trans*apsd_samfine(j)*dfi;
%
			  if(dfi<1.0e-20)
                   out1=sprintf(' Error: dfi=%12.4g \n',dfi);
                   disp(out1); 
                   uuu=input(' press Ctrl-c ');
              end
%
			  if(trans<1.0e-30)
                   out1=sprintf(' Error: trans=%12.4g \n',dfi);
                   disp(out1); 
                   uuu=input(' press Ctrl-c ');        
              end
%
        end
%
		sum=sqrt(sum);
		vrs_samfine(i)=sum;
    end

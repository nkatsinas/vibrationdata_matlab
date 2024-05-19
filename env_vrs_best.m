function[xvrs]=env_vrs_best(n_ref,dam,octave,xapsdfine,f_ref)
%
    xvrs=zeros(n_ref,1);
    
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
              sum=sum+trans*xapsdfine(j)*dfi;
%
       end
        sum=sqrt(sum);
        xvrs(i)=sum;
    end
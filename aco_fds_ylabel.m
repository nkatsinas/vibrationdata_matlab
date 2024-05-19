
%  aco_fds_ylabel.m  ver 1.0  by Tom Irvine


function[y_label,t_string]=aco_fds_ylabel(Q,bex,nmetric,iu)


if(nmetric==1)
    t_string=sprintf('Trans Pressure FDS  Q=%g b=%g ',Q,bex);
    if(iu==1)
        y_label=sprintf('Damage (psi^{ %g})',bex);
    else
        y_label=sprintf('Damage (Pa^{ %g})',bex);        
    end
else
    t_string=sprintf('Pseudo Velocity FDS  Q=%g b=%g ',Q,bex);   
    if(iu==1)
        y_label=sprintf('Damage (ips^{ %g})',bex);
    else
        y_label=sprintf('Damage ((m/sec)^{ %g})',bex);        
    end    
end   

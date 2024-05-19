%
%  env_compare_alt_error.m  ver 1.0  November 25, 2013
%
function[scale,error]=env_compare_alt_error(n_ref,fds_ref,fds_samfine,bex)
%

error=0;


sz=size(fds_ref);

% size(fds_samfine)

%
n=sz(2);
%
scale=0;
%
for i=1:n
    for k=1:n_ref
        
        s=fds_ref(k,i)/fds_samfine(k,i);
        
        error=error+abs(10*log10(s));
        
    end
end    
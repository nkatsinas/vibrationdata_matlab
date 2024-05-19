%
%  env_compare_altz.m  ver 1.0  by Tom Irvine
%
function[error]=env_compare_altz(n_ref,fds_ref,fds_samfine,bex)
%
sz=size(fds_ref);

% size(fds_samfine)

%
n=sz(2);
%
error=0;
%
for i=1:n
    for k=1:n_ref
        
        s=fds_ref(k,i)/fds_samfine(k,i);
        
        error=error+abs(log10(s));
        
    end
end    
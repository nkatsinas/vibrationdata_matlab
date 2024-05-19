%
%  env_compare_alt_error_spl.m  ver 1.0  November 25, 2013
%
function[scale,error,error_max]=env_compare_alt_error_spl(n_ref,fds_ref,fds_samfine,bex)
%



sz=size(fds_ref);

% size(fds_samfine)

%
n=sz(2);
%
scale=0;
%

ijk=1;

err=zeros(n*n_ref,1);

for i=1:n
    for k=1:n_ref
        
        s=fds_ref(k,i)/fds_samfine(k,i);
        
        err(ijk)=abs(10*log10(s));
        ijk=ijk+1;
        
    end
end    

error=sum(err);
error_max=max(err);
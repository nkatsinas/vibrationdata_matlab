%
%  env_compare_alt.m  ver 1.0  November 25, 2013
%
function[scale]=env_compare_alt(n_ref,fds_ref,fds_samfine,bex)
%
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
        s=s^(1/bex(i));
        if(s>scale)
            scale=s;
        end
        
    end
end    
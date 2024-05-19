%
%  env_compare.m  ver 1.0  November 25, 2013
%
function[scale]=env_compare(n_ref,fds_ref,fds_samfine,bex)
%
sz=size(fds_ref);
%
n_dam=sz(1);
n_dex=sz(2);
%
scale=0;
%
for i=1:n_dam
    for j=1:n_dex
        for k=1:n_ref
            s=fds_ref(i,j,k)/fds_samfine(i,j,k);
            s=s^(1/bex(j));
            if(s>scale)
                scale=s;
            end
        end
    end
end    
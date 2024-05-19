%
%  env_ers_compare.m  ver 1.0  November 3, 2015
%
function[scale]=env_ers_compare(n_ref,ers_ref,ers_samfine)
%
sz=size(ers_ref);
%
n_dam=sz(1);
n_fn=sz(2);
%
scale=0;
%
for i=1:n_dam
        for k=1:n_fn
            s=abs(ers_ref(i,k)/ers_samfine(i,k));
            if(s>scale)
                scale=s;
            end
        end
end    
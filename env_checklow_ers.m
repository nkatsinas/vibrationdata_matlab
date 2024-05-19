%
%   env_checklow_ers.m  ver 1.0  by Tom Irvine
%
function[error]=env_checklow_ers(ers_ref,ers_sam)
%
sz=size(ers_ref);
%
n_dam=sz(1);
n_fn=sz(2);
%
error=0;
%
for i=1:n_dam
        for k=1:n_fn
            error=error+10*abs(log10(abs(ers_ref(i,k)/ers_sam(i,k))));
        end
end       
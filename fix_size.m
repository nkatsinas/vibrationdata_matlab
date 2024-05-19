%
%  fix_size.m  ver 1.2  August 22, 2018
%
%  by Tom Irvine
%
function[a]=fix_size(a)
sz=size(a);
if(sz(2)>sz(1))
    a=transpose(a);
end
%
%   remove_zeros_from_second_column.m  ver 1.0  by Tom Irvine
%
%   ppp must have at least two columns
%

function[ppp]=remove_zeros_from_second_column(ppp)

sz=size(ppp);

n=sz(1);

for i=n:-1:1
    if(ppp(i,2)==0)
        ppp(i,:)=[];
    end
end
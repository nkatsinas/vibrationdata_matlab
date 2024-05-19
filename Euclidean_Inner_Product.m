%
%   Euclidean_Inner_Product.m  ver 1.0  by Tom Irvine
%
function[EIP]=Euclidean_Inner_Product(V1,V2)

EIP=0;

for i=1:length(V1)
        EIP=EIP+V1(i)*(conj(V2(i)));
end
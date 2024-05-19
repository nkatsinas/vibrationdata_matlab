
%  find_max_2d_array.m   ver 1.1  by Tom Irvine

function[row,column,value]=find_max_2d_array(A)

sz=size(A);

A=abs(A);

if(sz(1)==1)
    row=1;
    [value,column]=max(abs(A));
else
    [value,column] = max(max(A));
    [~,row] = max(A(:,column));
end

% fprintf('\n row=%d  column=%d  value=%7.3g\n',row,column,value);
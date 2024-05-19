
% darray.m  ver 1.1  by Tom Irvine

disp(' ');
disp(' Enter array name ');

FS = input(' Enter the array name:  ','s');
THM=evalin('caller',FS);

sz=size(THM);

for i=1:sz(1)
    out1=sprintf(' %9.0f  %9.0f ',THM(i,1),THM(i,2));
    disp(out1); 
end

disp(' ');

for i=1:sz(1)
    out1=sprintf(' %9.5g  %9.5g ',THM(i,1),THM(i,2));
    disp(out1); 
end

disp(' ');

clipboard('copy',THM)
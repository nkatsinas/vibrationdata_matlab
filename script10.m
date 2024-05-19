%
%  1D array  size ( 1 x 3 )
%
% Initialize an array with all zeros
%
a=zeros(3,1);
fprintf('\n %g %g %g \n', a(1),a(2),a(3));
%
%  Now put some nonzero numbers in the array
%
a=[ 1 7 4];
fprintf('\n %g %g %g \n', a(1),a(2),a(3));
%
%  Change the first entry to 2
%
a(1)=2;
fprintf('\n %g %g %g \n', a(1),a(2),a(3));
%
%  Multiply the entire array by 2
%
a=a*2;
fprintf('\n %g %g %g \n', a(1),a(2),a(3));
%
%  Sort the array
%
a=sort(a);
fprintf('\n %g %g %g \n', a(1),a(2),a(3))
%
%  Determine the mean & std dev
%
fprintf('\n mean=%6.3g  std dev=%6.3g\n', mean(a),std(a));
%
%  Determine the max & min
%
fprintf('\n max=%g  min=%g\n', max(a),min(a));
%
%  Determine the array length
%
fprintf('\n array length = %d \n', length(a));
%
%  Determine the array size
%
fprintf('\n array size: rows=%d  columns=%d \n', size(a));
%
%  Transpose the array
%
a=a';
fprintf('\n %g %g %g \n', a(1),a(2),a(3));
%
%  Determine the array size
%
fprintf('\n array size: rows=%d  columns=%d \n', size(a));






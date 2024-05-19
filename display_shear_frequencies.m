%
%  display_shear_frequencies.m ver 1.1  by Tom Irvine
%

function[]=display_shear_frequencies(f1,f2)

disp(' ');
disp(' Transition Frequencies ');
disp(' ');
out1=sprintf('     Global Bending to Shear = %8.4g Hz',f1);
out2=sprintf(' Shear to Face Sheet Bending = %9.5g Hz',f2);
disp(out1);
disp(out2);
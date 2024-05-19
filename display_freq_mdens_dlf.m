%
%  display_freq_mdens_dlf.m  ver 1.0  by Tom Irvine
%
function[]=display_freq_mdens_dlf(fc,mph,dlf)
%
disp(' ');
disp('  One-third Octave ');
disp('  ');
disp('  Center    Modal     Dissipation  ');
disp('  Freq     Density    Loss Factor  ');
disp('  (Hz)    (modes/Hz)               ');
                 
for i=1:length(fc)
    out1=sprintf(' %6.0f   %8.4f    %8.4f',fc(i),mph(i),dlf(i));
    disp(out1);
end
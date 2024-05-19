%
%  plot_title_fix_alt.m  by Tom Irvine
%

function[newStr]=plot_title_fix_alt(str)

expression='_';
replace='\_';
 
newStr = strrep(str,expression,replace);

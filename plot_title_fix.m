%
%  plot_title_fix.m  by Tom Irvine
%

function[newStr]=plot_title_fix(str)

expression='_';
replace='\\_';
 
newStr = strrep(str,expression,replace);


%  ytick_log.m  ver 1.0  by Tom Irvine

function[ymin,ymax]=ytick_log(yymin,yymax)
   
ymin=10^(floor(log10(yymin)));
ymax=10^(ceil(log10(yymax)));

if( (yymax/ymax) >0.8)
    ymax=ymax*10;
end




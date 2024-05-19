%
%   ws_scale.m  ver 1.2  by Tom Irvine
%

function[amp]=ws_scale(xmax,xmin,spec,exponent,amp,inn,nspec)
%    
    for i=1:nspec
%
        ave = mean([abs(xmax(i)), abs(xmin(i))]);
%
        ss= ( spec(i)/ave )^exponent;
%
        if(ss>=1.0e-20 && ss <=1.0e+20)
%
        else
%
            fprintf('\n scale error: i=%ld  ss=%8.4g  ave=%8.4g  spec=%8.4g\n\n',i,ss,ave,spec(i));
%
        end
%
        amp(inn,i)=amp(inn,i)*ss;
% 
    end
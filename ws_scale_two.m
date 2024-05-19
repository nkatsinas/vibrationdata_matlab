
%   ws_scale_two.m  ver 1.0  by Tom Irvine


function[amp]=ws_scale_two(xmax_one,xmin_one,xmax_two,xmin_two,...
                                 spec_one,spec_two,exponent,amp,inn,nspec)

%    
    for i=1:nspec 
%
        ave_one = (( abs(xmax_one(i)) + abs(xmin_one(i)) )/2.);
        ave_two = (( abs(xmax_two(i)) + abs(xmin_two(i)) )/2.);        
%

        r_one=spec_one(i)/ave_one;
        r_two=spec_two(i)/ave_two;
        

        r=mean([ r_one, r_two]);
        
        ss=r^exponent;
        
        
%
        if(ss>=1.0e-20 && ss <=1.0e+20)
%
        else
%
            out1=sprintf('\n scale error: i=%ld  ss=%8.4g  \n',i,ss);
            disp(out1);
%
        end
%
        amp(inn,i)=amp(inn,i)*ss;
% 
    end
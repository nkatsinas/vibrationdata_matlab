%
%   Temperature conversion script
%
disp(' Calculation Types');
disp(' ');
disp(' 1=Farehnheit to Celsius');
disp(' 2=Celsius to Farehnheit');
disp(' ');
n=input('Enter conversion type:  ');
%
disp(' ');
if(n==1)
    F=input('Enter temperature °F: ');
    C=(F-32)*5/9;
    fprintf('\n %6.3g °F  = %6.3g °C \n',F,C);
else
    C=input('Enter temperature °C: ');
    F=C*(9/5)+32;
    fprintf('\n %6.3g °C  = %6.3g °F \n',C,F);
end
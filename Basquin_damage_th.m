
%

function[D]=Basquin_damage_th(A,b,range_cycles)

Se=range_cycles(:,1);
n=range_cycles(:,2);

sz=size(n);

D=0;

for i=1:sz(1)

    D=D+n(i)*(Se(i)/2)^b;
    
end

D=D/A;
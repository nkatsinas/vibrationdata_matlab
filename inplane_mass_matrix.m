
e=[-1 1 1 -1];
n=[-1 -1 1 1];
%

mass=zeros(8,8);

for i=1:4
    for j=1:4
        
        iu=2*i-1;
        ju=2*j-1;
        
        iv=2*i;
        jv=2*j;
        
        mass(iu,ju)=(3+e(i)*e(j))*(3+n(i)*n(j))/36;
        mass(iv,jv)=(3+e(i)*e(j))*(3+n(i)*n(j))/36;
        
        
    end
end
%
mass
mass*9
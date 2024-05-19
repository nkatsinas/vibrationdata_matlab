%
%  inplane_plate_local_mass.m  ver 1.2  by Tom Irvine
%
function[mlocal]=inplane_plate_local_mass(a,b,thick,rho)
%

mlocal=zeros(8,8);

for i=1:8
    mlocal(i,i)=4;
end

for i=1:6
    mlocal(i,i+2)=2;
end

for i=1:4
    mlocal(i,i+4)=1;
end

for i=1:2
    mlocal(i,i+6)=2;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:8
    for j=i:8
        mlocal(j,i)=mlocal(i,j);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mlocal=mlocal*a*b*thick*rho/9;
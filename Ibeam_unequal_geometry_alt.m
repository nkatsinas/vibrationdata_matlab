

%  Ibeam_unequal_geometry_alt.m  ver 1.0  by Tom Irvine

function[area,MOIy,MOIz,J,cna]=Ibeam_unequal_geometry_alt(A,B,H,Tf,Tw)


hw=H-2*Tf;


%%%

area1=A*Tf;
area2=Tw*hw;
area3=B*Tf;

area=area1+area2+area3;

%%%

y1=Tf/2;
y2=Tf+(hw/2);
y3=Tf+hw+(Tf/2);

term=area1*y1 + area2*y2 + area3*y3;

cna=term/area;

%%%

k1=(1/12)*A^3*Tf;
k2=(1/12)*Tw^3*hw;
k3=(1/12)*B^3*Tf;

MOIy=k1+k2+k3;

%%%

c1=(1/12)*A*Tf^3  + area1*(y1-cna)^2;
c2=(1/12)*Tw*hw^3 + area2*(y2-cna)^2;
c3=(1/12)*B*Tf^3  + area3*(y3-cna)^2;

MOIz=c1+c2+c3;

%%%


J=MOIy+MOIz;

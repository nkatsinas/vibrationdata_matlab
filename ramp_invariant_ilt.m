 
W1=(A*a-B);
W2=(W1*b^2+A*a^3+B*a^2)*c^3;
W3=(W2+(A*b^4+3*B*a*b^2-A*a^4-B*a^3)*c^2);
W4=((-A*a^2-2*B*a)*b-A*b^3)*c^3;
W5=((2*A*a-B)*b^3+(2*A*a^3+3*B*a^2)*b)*c^2;
W6=(W4+W5);
W7=(-A*b^5-2*A*a^2*b^3-A*a^4*b)*c;
W8=(W7-B*b^5-2*B*a^2*b^3-B*a^4*b);
W9=(B*b^3+B*a^2*b)*c^3;
W10=(-2*B*a*b^3-2*B*a^3*b)*c^2;
W11=(B*b^5+2*B*a^2*b^3+B*a^4*b)*c;
W12=(W9+W10+W11);
W13=(A*b^3+(A*a^2+2*B*a)*b)*c^3;
W14=(B-2*A*a)*b^3;
W15=(-2*A*a^3-3*B*a^2)*b;
W16=(W14+W15)*c^2;
W17=(A*b^5+2*A*a^2*b^3+A*a^4*b)*c;
W18=B*b^5+2*B*a^2*b^3+B*a^4*b;
W19=W16+W17+W18;
W20=W13+W19;
W21=(b^5+2*a^2*b^3+a^4*b)*c^4;
W22=(-2*a*b^5-4*a^3*b^3-2*a^5*b)*c^3;
W23=(b^7+3*a^2*b^5+3*a^4*b^3+a^6*b)*c^2;
W24=(W21+W22+W23);

% -(W3*exp(a*t)*sin(b*t)+W6*exp(a*t)*cos(b*t)+ W8*exp(c*t)+W12*t+W20)/W24
% -(V1*exp(a*t)*sin(b*t)+V2*exp(a*t)*cos(b*t)+ V3*exp(c*t)+V4*t+V5)

V1=(W3/W24);
V2=(W6/W24);
V3=(W8/W24);
V4=(W12/W24);
V5=(W20/W24);

% qqq=-V1*exp(a*t)*sin(b*t)-V2*exp(a*t)*cos(b*t)-V3*exp(c*t)-V4*t-V5;

P0=(V5+V3+V2)/T;
P1=((-V5-V2)*exp(T*c)+V1*exp(T*a)*sin(T*b)+(-2*V5-2*V3-V2)*exp(T*a)*cos(T*b)-2*V5+T*V4-2*V3-2*V2)/T;
P2=((-V1*exp(T*a)*sin(T*b)+(2*V5+V2)*exp(T*a)*cos(T*b)+2*V5-T*V4+2*V2)*exp(T*c)-2*V1*exp(T*a)*sin(T*b)+(4*V5-2*T*V4+4*V3+2*V2)*exp(T*a)*cos(T*b)+(V5+V3)*exp(2*T*a)+V5+V3+V2)/T;
P3=((2*V1*exp(T*a)*sin(T*b)+(-4*V5+2*T*V4-2*V2)*exp(T*a)*cos(T*b)-V5*exp(2*T*a)-V5-V2)*exp(T*c)+V1*exp(T*a)*sin(T*b)+(-2*V5-2*V3-V2)*exp(T*a)*cos(T*b)+(-2*V5+T*V4-2*V3)*exp(2*T*a))/T;
P4=((-V1*exp(T*a)*sin(T*b)+(2*V5+V2)*exp(T*a)*cos(T*b)+(2*V5-T*V4)*exp(2*T*a))*exp(T*c)+(V5+V3)*exp(2*T*a))/T;
P5=-V5*exp(T*c+2*T*a)/T;

Q1=(-exp(T*c)-2*exp(T*a)*cos(T*b));
Q2=(2*cos(T*b)*exp(T*c+T*a)+exp(2*T*a));
Q3=-exp(T*c+2*T*a);
Q4=0;

% zzz=-(P0*z^5+P1*z^4+P2*z^3+P3*z^2+P4*z+P5)/(z^4+Q1*z^3+Q2*z^2+Q3*z);







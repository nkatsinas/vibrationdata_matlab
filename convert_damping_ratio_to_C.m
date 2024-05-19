disp(' ');
damp=input(' Enter damping ratio:  ');
mass=input(' Enter mass (lbm):  ');
stiff=input(' Enter stiffness (lbf/in):  ');

mass=mass/386;

omegan=sqrt(stiff/mass);

fn=omegan/(2*pi);

c=mass*2*damp*omegan;

disp(' ');
out1=sprintf(' fn=%7.3g Hz     c=%8.4g  lbf sec/in ',fn,c);
disp(out1);
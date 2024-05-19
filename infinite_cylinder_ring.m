%
%  infinite_cylinder_ring.m  ver 1.0  by Tom Irvine
%
function[fring]=infinite_cylinder_ring(E,rho,v,h,diam)                         
                         
a=diam/2; % radius


K=E*h/(1-v^2);

[D]=flexural_rigidity(E,h,v);

%
ma=eye(3);
%
ma=ma*(rho*h);
%

disp(' ');
disp(' Calculating Modal Frequencies... ');
%
for m=0:0
%    
    for n=0:0
%
        clear ka;
%
        kt=n/a;
        kt2=kt^2;
        khat=sqrt(kt2);
%
        ka(1,1)=((1-v)/2)*kt2;
        ka(1,2)=0; 
        ka(1,3)=0; 
        ka(2,1)=ka(1,2);
        ka(2,2)=kt2; 
        ka(2,3)=kt/a;
        ka(3,1)=ka(1,3);
        ka(3,2)=ka(2,3); 
        ka(3,3)=((D/K)*(khat^4))+(1/a^2);    
        ka=K*ka;  
%
%  Optional for mode shapes
%
%        ka(1,2)=ka(1,2)*i;
%        ka(1,3)=ka(1,3)*i;
%        ka(2,1)=-ka(2,1)*i;
%        ka(3,1)=-ka(3,1)*i;
%

        
        [~,som2]=eig(ka,ma);
        fn(1)=sqrt(som2(1,1));
        fn(2)=sqrt(som2(2,2));
        fn(3)=sqrt(som2(3,3));   
        fn=fn/(2.*pi);
        fring=max(fn);  % ignore rigid-body modes
%
%%        out1=sprintf(' n=%d m=%d  fn1=%g  fn2=%g  fn3=%g',n,m,fn(1),fn(2),fn(3));
%%        disp(out1)

    end
end
%

disp(' Newton_Raphson.m  ver 1.1  July 30, 2010  ');
disp(' by Tom Irvine  Email: tomirvine@aol.com   ');
disp(' ');
disp(' This script finds the roots of equations ');
disp(' ');
%
clear t;
clear t1;
clear t2;
clear t3;
clear t4;
clear y;
clear z;
clear z1;
clear z2;
clear z3;
clear z4;
%
disp(' Select equation        ');
disp('  1=  cos(x)cosh(x)+1=0  fixed-free beam');  
disp('  2=  cos(x)cosh(x)-1=0  free-free or fixed-fixed beam');
disp('  3=  tan(x)-tanh(x)=0   fixed-pinned beam');
disp('  4=  tan(x)+tanh(x)=0  ');
disp('  5=  Jo(x)=0           ');
disp('  6=  J1(x)=0           ');
disp('  7=  J2(x)=0           ');
disp('  8=  d[Jo(x)]/dx=0     ');
disp('  9=  d[J1(x)]/dx=0     ');
%
ic=input(' ');
figure(1);
%
if(ic==1) % cos(x)cosh(x)+1=0
    for(i=1:600)
        x=i*0.05;
        t(i)=x;
        y(i)=cos(x);
        z(i)=-1/cosh(x);
    end
    plot(t,y,t,z);
    axis([0,30,-2,2]);
    grid on;  
    a=input(' Enter initial estimate ');
    for(i=1:10)
        den=-sin(a)*cosh(a)+cos(a)*sinh(a);
        x=a-(cos(a)*cosh(a)+1)/den;
        a=x;
        out1=sprintf('%d \t %12.8g',i,x);
        disp(out1);
    end
    ff=cos(a)*cosh(a)+1;
    out1=sprintf('\n  f(%12.8g)=%12.8g ',a,ff);
    disp(out1);
end
if(ic==2) % cos(x)cosh(x)-1=0
    for(i=1:600)
        x=i*0.05;
        t(i)=x;
        y(i)=cos(x);
        z(i)=1/cosh(x);
    end
    plot(t,y,t,z);
    axis([0,30,-2,2]);
    grid on;      
    a=input(' Enter initial estimate ');    
    for(i=1:10)
        den=-sin(a)*cosh(a)+cos(a)*sinh(a);
        x=a-(cos(a)*cosh(a)-1)/den;
        a=x;
        out1=sprintf('%d \t %12.8g',i,x);
        disp(out1);
    end
    ff=cos(a)*cosh(a)-1;
    out1=sprintf('\n  f(%12.8g)=%12.8g ',a,ff);
    disp(out1);
end
if(ic==3) % tan(x)-tanh(x)=0
    i1=1;
    i2=1;
    i3=1;
    i4=1;
    for(i=1:600)
        x=i*0.05;
        t(i)=x;
        y(i)=tanh(x);
        if(x<pi/2)
            t1(i1)=x;
            z1(i1)=tan(x);
            i1=i1+1;
        end
        if( x>pi/2 && x<1.5*pi)
            t2(i2)=x;  
            z2(i2)=tan(x);  
            i2=i2+1;
        end
        if( x>1.5*pi && x<2.5*pi)
            t3(i3)=x;   
            z3(i3)=tan(x);
            i3=i3+1;
        end
        if( x>2.5*pi && x<3.5*pi)
            t4(i4)=x;  
            z4(i4)=tan(x);
            i4=i4+1;
        end
    end
    plot(t,y,'r');
    hold on;
    axis([0,3.5*pi,-2,2]);
    grid on;
    plot(t1,z1);
    plot(t2,z2);
    plot(t3,z3)
    plot(t4,z4);
    hold off;          
    a=input(' Enter initial estimate ');    
    for(i=1:10)
        den=(1/cos(a))^2-(1/cosh(a))^2;
        x=a-(tan(a)-tanh(a))/den;
        a=x;
        out1=sprintf('%d \t %12.8g',i,x);
        disp(out1);
    end
end
if(ic==4) % tan(x)+tanh(x)=0
i1=1;
    i2=1;
    i3=1;
    i4=1;
    for(i=1:600)
        x=i*0.05;
        t(i)=x;
        y(i)=-tanh(x);
        if(x<pi/2)
            t1(i1)=x;
            z1(i1)=tan(x);
            i1=i1+1;
        end
        if( x>pi/2 && x<1.5*pi)
            t2(i2)=x;  
            z2(i2)=tan(x);  
            i2=i2+1;
        end
        if( x>1.5*pi && x<2.5*pi)
            t3(i3)=x;   
            z3(i3)=tan(x);
            i3=i3+1;
        end
        if( x>2.5*pi && x<3.5*pi)
            t4(i4)=x;  
            z4(i4)=tan(x);
            i4=i4+1;
        end
    end
    plot(t,y,'r');
    hold on;
    axis([0,3.5*pi,-2,2]);
    grid on;
    plot(t1,z1);
    plot(t2,z2);
    plot(t3,z3)
    plot(t4,z4);
    hold off;           
    a=input(' Enter initial estimate ');
    for(i=1:10)
        den=(1/cos(a))^2+(1/cosh(a))^2;
        x=a-(tan(a)+tanh(a))/den;
        a=x;
        out1=sprintf('%d \t %12.8g',i,x);
        disp(out1);
    end
end
if(ic==5) % Jo(x)=0
    for(i=1:600)
        x=i*0.05;
        t(i)=x;
        y(i)=besselj(0,x);
    end
    plot(t,y);
    grid on;      
    a=input(' Enter initial estimate ');    
    for(i=1:10)
        den=-besselj(1,a);
        x=a-besselj(0,a)/den;
        a=x;
        out1=sprintf('%d \t %12.8g',i,x);
        disp(out1);
    end
end
if(ic==6 || ic==8) % J1(x)=0  & d[Jo(x)]/dx=0
    for(i=1:600)
        x=i*0.05;
        t(i)=x;
        y(i)=besselj(1,x);
    end
    plot(t,y);
    grid on;    
    a=input(' Enter initial estimate ');    
    for(i=1:10)
        den=-besselj(2,a)+(besselj(1,a)/a);
        x=a-besselj(1,a)/den;
        a=x;
        out1=sprintf('%d \t %12.8g',i,x);  
        disp(out1);
    end
end
if(ic==7) % J2(x)=0
    for(i=1:600)
        x=i*0.05;
        t(i)=x;
        y(i)=besselj(2,x);
    end
    plot(t,y);
    grid on;
    a=input(' Enter initial estimate ');    
    for(i=1:10)
        den=-besselj(3,a)+(besselj(2,a)/a);
        x=a-besselj(2,a)/den;
        a=x;
        out1=sprintf('%d \t %12.8g',i,x);
        disp(out1);
    end
end
if(ic==9) % d[J1(x)]/dx=0 
    for(i=1:600)
        x=i*0.05;
        t(i)=x;
        y(i)=besselj(0,x)-(1/x)*besselj(1,x);
    end
    plot(t,y);
    grid on;
    a=input(' Enter initial estimate ');
    for(i=1:10)
%
        derative_Jo=-besselj(1,a);
        derative_J1=-besselj(2,a)+(besselj(1,a)/a);
%        derative_J2=-besselj(3,a)+(besselj(2,a)/a);
%
        den=derative_Jo+(1/a)*derative_J1;
        x=a-(besselj(0,a)-(1/a)*besselj(1,a))/den;
        a=x;
        out1=sprintf('%d \t %12.8g',i,x);
        disp(out1);
    end
end
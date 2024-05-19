disp(' ')
disp(' vibration_roots.m   ver 1.6  July 1, 2015 ')
disp(' ')
disp(' by Tom Irvine   Email: tom@vibrationdata.com ')
disp(' ');
%
clear a;
clear b;
clear q;
clear xo;
%
disp(' Function Library');
disp(' ');
disp('1   f(x)=cos(x)cosh(x)+1 ')
disp('2   f(x)=cos(x)cosh(x)-1 ')
disp('3   f(x)=tan(x)+tanh(x)  ')
disp('4   f(x)=tan(x)-tanh(x)  ')
disp('5   f(x)=Bessel Jo  ')
disp('6   f(x)=Bessel J1  ')
disp('7   f(x)=Bessel J2  ')
disp('8   f(x)=Bessel   (Jn+1(x)/Jn(x)) + (In+1(x)/In(x)) -2x/(1-mu) ')  % SS circular plate
%
disp(' ');
disp(' Select function ');
ichoice=input(' ');
%
if(ichoice==1)
   qcc=@(x)(cos(x).*cosh(x)+1); 
   out2=('f(x)=cos(x)*cosh(x)+1');
end
if(ichoice==2)
   qcc=@(x)(cos(x).*cosh(x)-1);  
   out2=('f(x)=cos(x)*cosh(x)-1');   
end
if(ichoice==3)
   qcc=@(x)(tan(x)+tanh(x)); 
   out2=('f(x)=tan(x)+tanh(x)');    
end
if(ichoice==4)
%   qcc=@(x)(tan(x)-tanh(x));
   qcc=@(x)(sinh(x).*cos(x)-sin(x).*cosh(x)); % more stable
   out2=('f(x)=tan(x)-tanh(x)');   
end
if(ichoice==5)
   qcc=@(x)(besselj(0,x)); 
   out2=('Bessel Jo(x)');    
end
if(ichoice==6)
   qcc=@(x)(besselj(1,x)); 
   out2=('Bessel J1(x)');    
end
if(ichoice==7)
   qcc=@(x)(besselj(2,x)); 
   out2=('Bessel J2(x)');    
end
%
if(ichoice<=7)
%
    j=1;
    x1=0.1;
    for i=2:5000
        x2=i*0.1;
        if(qcc(x1)*qcc(x2)<=0)
            a(j)=x1;
            b(j)=x2;
            j=j+1;
            if(j==20)
                j=19;
                break;
            end
        end
        x1=x2;
    end
    options=optimset('display','off');
    disp(' ')
    disp(' roots ')
    disp(' ')
    for n=1:j
        xo=[a(n) b(n)];
        q(n)=fzero(qcc,xo,options);
        if(q(n)>0)
            out1=sprintf(' %8.4f',q(n));
            disp(out1)
        end
    end
%
    disp(' ')
    disp(' Plot function?')
    disp(' 1=yes  2=no ')
    np=input(' ');
    if(np==1)
        x=linspace(0,q(n),200);
        plot(x,qcc(x));
        grid;
        title(out2);
        xlabel('x');  
        ylabel('f(x)');    
        axis([0,max(x),-10,10]);
    end
end
%
if(ichoice==8)
%
    clear a;
    clear b;
    clear x;
    clear y;
    clear root;
%
    disp(' ');
    n= input(' Enter n ');
    disp(' ');
    mu=input(' Enter mu ');    
%
    j=1;
    delta=0.1;
    for i=1:600
        xx=i*delta;
        x(i)=xx;
%        
        JN1=besselj(n+1,xx);
        JN =besselj(n,xx);
        IN1=besseli(n+1,xx);
        IN =besseli(n,xx);
        T3 =2*xx/(1-mu);
%   
        ya=(IN*JN1)+(IN1*JN)-(JN*IN*T3);
        y(i)=ya;   
%
        if(i>2)
            if(ya*yb<=0)
                b(j)=xx;
                j=j+1;
            end
        end
        yb=ya;    
        if(j>4)
            break;
        end
%        
    end
    a=b-delta;
%
%   secant
%
    for i=1:max(size(a))
%
        for j=1:100
%            
            xx=a(i);
            JN1=besselj(n+1,xx);
            JN =besselj(n,xx);
            IN1=besseli(n+1,xx);
            IN =besseli(n,xx);
            T3 =2*xx/(1-mu);           
            ya=(IN*JN1)+(IN1*JN)-(JN*IN*T3);       
%
            xx=b(i);
            JN1=besselj(n+1,xx);
            JN =besselj(n,xx);
            IN1=besseli(n+1,xx);
            IN =besseli(n,xx);
            T3 =2*xx/(1-mu);           
            yb=(IN*JN1)+(IN1*JN)-(JN*IN*T3);   
%
            if(abs(b(i)-a(i))<0.0001)
                break;
            end
%
            m=(yb-ya)/(b(i)-a(i));
            bb=ya-m*a(i);
            ab=-bb/m;
%
            xx=ab;
            JN1=besselj(n+1,xx);
            JN =besselj(n,xx);
            IN1=besseli(n+1,xx);
            IN =besseli(n,xx);
            T3 =2*xx/(1-mu);           
            yab=(IN*JN1)+(IN1*JN)-(JN*IN*T3);   
%
            if(ya*yab<=0)
                b(i)=ab;    
            else
                a(i)=ab;
            end
%
        end
        root(i)=0.25*(a(i)+b(i))^2;
%        
    end    
%
    plot(x,y);
    grid on;
    axis([0,max(x),-10,10]);
    disp(' ');
    disp(' root^2 ');
    root'
end
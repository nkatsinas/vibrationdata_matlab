%
%  beam_bending_roots.m  ver 1.0  by Tom Irvine
%

function[root]=beam_bending_roots(LBC,RBC)

    n=8;
    
    root=zeros(n,1);
    
    if((LBC==1 && RBC==1)||((LBC==3 && RBC==3))) % fixed-fixed or free-free
        root(1)=4.73004;
        root(2)=7.8532;
        root(3)=10.9956;
        root(4)=14.13717;
        root(5)=17.27876;    
        root(6)=13*pi/2; 
        root(7)=15*pi/2;
        root(8)=17*pi/2;     
    end
    if((LBC==1 && RBC==2) || (LBC==2 && RBC==1)) % fixed-pinned
        
        fun = @fixed_pinned; % function
        
        xx=[3.927 7.069 10.21 13.352 16.493 6.25*pi 7.25*pi 8.25*pi];
        
        for i=1:8
            root(i) = fzero(fun,xx(i));
        end
      
    end
    if((LBC==1 && RBC==3) || (LBC==3 && RBC==1)) % fixed-free
        root(1)=1.87510;
        root(2)=4.69409;
        root(3)=7.85476;
        root(4)=10.99554;
        root(5)=9*pi/2;
        root(6)=11*pi/2;
        root(7)=13*pi/2;
        root(8)=15*pi/2;    
    end
    if(LBC==2 && RBC==2) % pinned-pinned
        for i=1:n
            root(i)=i*pi;
        end
    end

end

function y = fixed_pinned(x)
    y = tanh(x)-tan(x);
end
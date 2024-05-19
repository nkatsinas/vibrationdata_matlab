
%  PSD_plateau_attenuation.m  ver 1.1  by Tom Irvine

function[PSD2]=PSD_plateau_attenuation(PSD1,ratio)

ratio=ratio^2;  % convert from (G/G) to (G^2/G^2);

PSD2=PSD1;

fr=PSD2(:,1);
r=PSD2(:,2);


[s,num]=calculate_slopes(fr,r);

octave=(1/784);

[ff,aa]=octave_interpolation(octave,fr,r,s,num);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

LF=length(ff);

if(LF==3 && aa(3)==aa(2))

    attr=1;
    attp=ratio;
    
    n=log10(aa(2)/aa(1))/log10(ff(2)/ff(1));
    
    a(1)=aa(1)*attr;
    a(2)=aa(2)*attp;
    a(3)=aa(3)*attp;
    
    ar31=a(3)/a(1);    
    
    f(1)=ff(1);
    f(2)=ff(1)*ar31^(1/n);
    f(3)=ff(3);
    
    if(f(2)>f(3))
        a(2)=a(1)*(f(3)/f(1))^n;
        a(3)=a(2);
        f(2)=f(3);
        f(3)=[];
        a(3)=[];
    end
    
    f=fix_size(f);
    a=fix_size(a);    
    
    PSD2=[f a];
    
    return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

aamax=max(aa);

iflag=0;

for i=1:length(aa)
    if(aa(i)>=aamax)
        aamax_reduced=aa(i)*ratio;
        iflag=1;
    end
    if(iflag==1)
        aa(i)=aa(i)*ratio;
    end    
end


for i=1:length(aa)

    if(aa(i)>aamax_reduced)
        aa(i)=aamax_reduced;
    end
    
end

c=zeros(length(aa),1);

for i=2:length(aa)-1
    s1=log(aa(i)/aa(i-1))/log(ff(i)/ff(i-1));
    s2=log(aa(i+1)/aa(i))/log(ff(i+1)/ff(i));
    if( abs(s2-s1)<0.001)
        c(i)=1;
    end
end    

for i=length(aa)-1:-1:2
    if(c(i)==1)
        ff(i)=[];
        aa(i)=[];
    end
end

for i=length(aa)-1:-1:2
    noct=log2(ff(i)/ff(i-1));
    if(noct<1/48)
        ff(i)=[];
        aa(i)=[];
    end
end


ff=fix_size(ff);
aa=fix_size(aa);

clear PSD2;
PSD2(:,1)=ff;
PSD2(:,2)=aa; 
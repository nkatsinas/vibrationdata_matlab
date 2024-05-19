
%  SRS_plateau_attenuation.m  ver 1.1  by Tom Irvine

function[srs2]=SRS_plateau_attenuation(srs1,ratio)

srs2=srs1;

fr=srs2(:,1);
r=srs2(:,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ff=fr;
aa=r;

if(length(ff)==3 && aa(3)==aa(2))

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
    
    srs2=[f a];
    
    return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

aamax=max(r);
aamax_reduced=aamax*ratio;

[s,num]=calculate_slopes(fr,r);

octave=(1/784);
noct_limit=4*(1/96);

[f,spec]=octave_interpolation(octave,fr,r,s,num);


LF=length(f);

ia=zeros(LF,1);

for i=1:LF

    if(spec(i)>=aamax_reduced)
        spec(i)=aamax_reduced;
        ia(i)=i;
    end
    
end

for i=2:LF
    if(ia(i-1)==0 && ia(i)==1)
        n=log10(spec(i)/spec(i-1))/log10(f(i)/f(i-1));
        f(i)=f(i-1)*(spec(i)/spec(i-1))^(1/n);  
    end
end

for i=1:LF-1
    if(ia(i)==1 && ia(i+1)==0)
        n=log10(spec(i+1)/spec(i))/log10(f(i+1)/f(i));
        f(i+1)=f(i)*(spec(i+1)/spec(i))^(1/n);  
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=(LF-1):-1:2
    n1=log10(spec(i)/spec(i-1))/log10(f(i)/f(i-1));
    n2=log10(spec(i+1)/spec(i))/log10(f(i+1)/f(i));
  
    noct=log(f(i+1)/f(i))/log(2); 

    if((abs(n1-n2)<0.1) || noct<noct_limit)
        f(i)=[];
        spec(i)=[];
    end
end
    
clear srs2;

srs2(:,1)=f;
srs2(:,2)=spec; 

%  PSD_distance_atten_ramp_plateau.m  ver 1.2  by Tom Irvine

function[f,a]=PSD_distance_atten_ramp_plateau(attp,attr,f,a)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

attp=attp^2;   % convert from (G/G) to (G^2/G^2);
attr=attr^2;

PSD1=[f a];
PSD2=PSD1;

fr=PSD2(:,1);
r=PSD2(:,2);

[s,num]=calculate_slopes(fr,r);

octave=(1/784);

[ff,aa]=octave_interpolation(octave,fr,r,s,num);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

aamax=max(aa);

iflag=0;

for i=1:length(aa)
    if(aa(i)>=aamax)
        aamax_reduced=aa(i)*attp;
        iflag=1;
    end
    if(iflag==1)
        aa(i)=aa(i)*attp;
    else
        aa(i)=aa(i)*attr;
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

f=PSD2(:,1);
a=PSD2(:,2);
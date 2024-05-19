
%  SRS_ramp_attenuation.m  ver 1.0  by Tom Irvine

function[srs2]=SRS_ramp_attenuation(srs1,ratio)

srs2=srs1;

fr=srs2(:,1);
r=srs2(:,2);

aamax=max(r);
aamax_reduced=aamax*ratio;

[s,num]=calculate_slopes(fr,r);

octave=(1/784);
noct_limit=4*(1/96);

[f,spec]=octave_interpolation(octave,fr,r,s,num);
LF=length(f);


nknee=LF;

for i=1:(LF-2)
    
    n1=log10(spec(i+1)/spec(i))/log10(f(i+1)/f(i));
    n2=log10(spec(i+2)/spec(i+1))/log10(f(i+2)/f(i+1));
    
%%    out1=sprintf(' %8.4g  %8.4g  %8.4g   ',f(i),n1,n2);
%%    disp(out1);
    
    if(abs(n2-n1)> 0.1 )
        fref=f(i);
        aref=spec(i)*ratio;
        nref=n1;
        nknee=i;
        break;
    end
    
end    

out1=sprintf('\n old knee frequency = %8.4g Hz ',fref);
disp(out1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:nknee
    spec(i)=spec(i)*ratio;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nknee>1)

    for i=(nknee+1):LF
        anext=aref*(f(i)/fref)^nref;
                
        if(spec(i)>anext)
           spec(i)=anext;
           fnk=f(i);
        else
           break; 
        end
    end    

end

out1=sprintf(' new knee frequency = %8.4g Hz \n',fnk);
disp(out1);
    
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

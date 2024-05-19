
%   octave_interpolation.m  ver 1.0  by Tom Irvine

function[f,spec]=octave_interpolation(octave,fr,r,s,num)

f(1)= fr(1);
fa=fr(1);
fb=fr(1);
spec(1)=r(1);

f(1)=fr(1);
spec(1)=r(1);
i=2;
%
while(1) 
    ff=(2.^octave)*fb;
    fb=ff;
    if(ff>fr(end))
        break;
    end    
%
    if( ff >= fr(1))
%
        for j=1:num
%
            if(ff == fr(j))
                        f(i)=ff;
                        spec(i)=r(j);
                        nspec=i;
                        i=i+1;                        
                        break;
            end
            if(ff < fr(j) && j>1)
%                   
                        f(i)=ff;
                        az=(log10(r(j-1)));
                        az=az+(s(j-1)*(log10(ff)-log10(fr(j-1))));
                        spec(i)=10.^az;
                        nspec=i;
                        i=i+1;
                        break;
            end
%
        end
    end
end

if(f(i-1)~=fr(num))

    f(i)=fr(num);
    spec(i)=r(num);

end



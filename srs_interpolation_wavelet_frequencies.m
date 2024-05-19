%
%  srs_interpolation_wavelet_frequencies.m  ver 1.0  by Tom Irvine
%
function[srsa]=...
    srs_interpolation_wavelet_frequencies(fn,fr,r)

num=length(fn);

srsa=zeros(num,1);
%
for i=1:length(fr);
%
        for j=1:(num-1)
%
            if(  fr(i)>= fn(j) && fr(i)<= fn(j+1) )
%

                
                aratio=r(j+1)/r(j);
                fratio=fn(j+1)/fn(j);
                
                n=log(aratio)/log(fratio);
                            
                srsa(i)=r(j)*(fr(i)/fn(j))^n;
%
                break;
%
            end
        end
end

%
%   Franken_function_alt.m  ver 1.0  by Tom Irvine
%

function[psd]=Franken_function_alt(stationdiam_ft,W_lbm_per_ft2,rf,f,spl)

ilast=length(spl);

stationdiam=stationdiam_ft;
W=W_lbm_per_ft2;

% cmat=cmat_ft_per_sec;

cmat=pi*stationdiam_ft*rf;

cref=200000./12.;  % feet per second
 
scale = cmat/cref; 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    fr(1)=1.0;
    fr(2)=2.0;
    fr(3)=2.7;
    fr(4)=3.0;
    fr(5)=3.3;
    fr(6)=3.6;
    fr(7)=3.7;
    fr(8)=3.78;
    fr(9)=3.9;
    fr(10)=4.0;
    fr(11)=4.1;
    fr(12)=4.3;
    fr(13)=4.7;
%
    ar(1)=-158; 
    ar(2)=-146;
    ar(3)=-140.5;
    ar(4)=-136.;
    ar(5)=-130.;
    ar(6)=-121.;
    ar(7)=-119.;
    ar(8)=-118.8;
    ar(9)=-119.;
    ar(10)=-120.;
    ar(11)=-121.7;
    ar(12)=-123.;
    ar(13)=-124.5;
%
    for i=1:13
        fr(i)= log10( ((10.^fr(i))*scale) );
    end
%
    jlast = 13;
%
BWT=(2^(1/6))-1/(2^(1/6));
%
psd=zeros(ilast,1);
%
 
 
for i=1:ilast
%
        sfr = log10( f(i)*stationdiam );
%
        if( sfr <= fr(1))
            va= ar(1);
        end
        if(sfr >= fr(jlast) )
            va= ar(jlast);
        end
        if( sfr > fr(1) && sfr < fr(jlast) )
%
            for j=1:11
%
                if(sfr >= fr(j) && sfr <= fr(j+1) )
%
                    len = fr(j+1) -fr(j);
                    k2  = (sfr    -fr(j))/len;
%
                    k1=1.-k2;
                    va = k1*ar(j) + k2*ar(j+1);
%
                    break;
                end
            end
        end
%
        vdb = va - 20.*log10(W) + spl(i);
       
%
        al = 1.*(10.^(vdb/20.));
%
        df = BWT*f(i);
%
% assume vdb is in terms of RMS
%
        psd(i) = (al^2.)/df;
%
end

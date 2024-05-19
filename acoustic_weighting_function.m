%
%  acoustic_weighting_function.m   ver 1.0  May 29, 2013
%
function[pf,pspl,oaspl,scale_label]=acoustic_weighting_function(pf,pspl,imax,ref,iwn)
%
[fw,aw,bw,cw]=SPL_weights(); 
%
%
if(iwn==2)
    ww=aw;
    scale_label=sprintf('A');
end
if(iwn==3)
    ww=bw;
    scale_label=sprintf('B');    
end
if(iwn==4)
    ww=cw;
    scale_label=sprintf('C');    
end
%
wmax=length(fw);
%
js=1;
%
k=1;
%
ms=0;
%
for i=1:imax
    for j=js:wmax
%        
        dff=abs(log(pf(i)/fw(j))/log(2));
%
        if( dff < 0.1 )
            ft(k)=pf(i);
            pt(k)=pspl(i)+ww(j);
%
            bs=ref*10^(pt(k)/20);
            ms=ms+bs^2;
%
            k=k+1;
            js=j;
            break;
        end
    end
end
%
ms=sqrt(ms);
%
oaspl = 20*log10(ms/ref);
%
clear pf;
clear pspl;
%
pf=ft;
pspl=pt;
  
%  modal_density_one_third_octave.m  ver 1.0  by Tom Irvine


function[fc,mdens]=modal_density_one_third_octave(fn)    
    
    [fl,fc,fu,imax]=one_third_octave_frequencies();

    n=length(fn);

    mdens=zeros(imax,1);
    nmodes=zeros(imax,1);

    for i=1:n
        
        for j=1:imax
        
            if(fn(i)>=fl(j) && fn(i)<=fu(j))
        
                nmodes(j)=nmodes(j)+1;
            
                break;
        
            end
        
        end
    
    end    


for j=imax:-1:1
    if(nmodes(j)==0 || fc(j)<10.)
        fl(j)=[];
        fc(j)=[];
        fu(j)=[];
        mdens(j)=[];
        nmodes(j)=[];
    else
        bw=fc(j)-fl(j);
        mdens(j)=nmodes(j)/bw;
    end
end


fc=fix_size(fc);
mdens=fix_size(mdens);
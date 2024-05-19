
% find_index.m  ver 1.0  by Tom Irvine

function[n]=find_index(Items,im)

    n=1;

    sz=size(Items);

    im=strtrim(im);
   
    for i=1:sz(1)
        sss=strtrim(Items(i,:));
        if(strcmp(im,sss))
            n=i;
            break;
        end    
    end

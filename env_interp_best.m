
%  env_interp_best.m  ver 1.2  by Tom Irvine

function[xapsdfine]=env_interp_best(nbreak,n_ref,xf,xapsd,f_ref)
%
   n_ref=length(f_ref); 

    xapsdfine=zeros(nbreak-1,1);
    xslope=zeros(nbreak-1,1);

    xffine=zeros(n_ref,1);
    xffine(1)=xf(1);
	xapsdfine(1)=xapsd(1);       
%
    LL=length(xapsd)-1;

    for i=1:LL
		xslope(i)=log(xapsd(i+1)/xapsd(i))/log(xf(i+1)/xf(i));
    end
%

    for i=1:n_ref 
	
		xffine(i)=f_ref(i);  

        for j=1:nbreak-1
		
	        if( ( xffine(i) >= xf(j) ) &&  ( xffine(i) <= xf(j+1) )  )
					
				xapsdfine(i)=xapsd(j)*( ( xffine(i) / xf(j) )^xslope(j) );
				break;
            end
        end
    end
    
    if(length(xffine)>length(xapsdfine))
        xapsdfine(end+1)=xapsd(end);
    end
    
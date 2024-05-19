%
%  werror2.m  ver 1.1  by Tom Irvine
%
function[wavelet_table_add,amp,ramp,emax1,emax2,last_wavelet,ferr,serr]=...
    werror2(wavelet_table_add,mflag,fn,xabs,xmin,xmax,srs_spec,last_srs,...
                                 last_wavelet,rrr,amp,ramp,emax1,emax2,ijk)    
%
	em1=0.;
	ew1=0.;
    emax1=1.*emax1;
%    
 	em2=0.;
	ew2=0.;
    emax2=1.*emax2;
%       
    amp=1.*amp;
%
	for(i=1:last_srs)
        ew1=abs(20.*log10(abs(xmin(i)/srs_spec(i))));
		if( ew1>em1)
			em1=ew1;
            ferr=fn(i);
            serr=srs_spec(i);            
         end
%
        ew1=abs(20.*log10(abs(xmax(i)/srs_spec(i))));
		if( ew1>em1)
			em1=ew1;
            ferr=fn(i);
            serr=srs_spec(i);            
         end
%
        em2=em2+abs(20.*log10(abs(xmin(i)/srs_spec(i))));
        em2=em2+abs(20.*log10(abs(xmax(i)/srs_spec(i))));      
    end
%
    em2=em2/last_srs;
%
	if( (em1*em2) < emax1)
%
        emax1=(em1*em2);
%
        clear temp;
        temp(1:max(size(amp)))=rrr(1:max(size(amp)));
        clear rrr;
        rrr=temp';
%
		amp=amp.*rrr;
        clear ramp;
        ramp=amp; 
        out1=sprintf(' %d  %9.5g  %9.5g  %9.5g  %9.5g %d %d   *',ijk,em1,em2,(em1*em2),emax1,mflag,last_wavelet);
        disp(out1);
%
        if(mflag==1)
            last_wavelet=last_wavelet+1;
        end
%       
        for(i=1:max(size(amp)))
            wavelet_table_add(i,3)=amp(i);
        end
        output_filename=sprintf('el_int_%d.txt',round(1000*rand));
        save(output_filename,'wavelet_table_add','-ASCII')    
%
    else
%        out1=sprintf(' %d  %9.5g  %9.5g  %9.5g  %9.5g %d %d   ',ijk,em1,em2,(em1*em2),emax1,mflag,last_wavelet);       
    end
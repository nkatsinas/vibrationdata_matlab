%
%  DSS_th_syn.m  ver 1.0  October 5, 2012
%
function[acc,sym]=DSS_th_syn(ns,amp,sss,last)
%
     amp=fix_size(amp);
%
	 for(j=1:ns)
%
		acc(j)=amp(1:last)'*sss(1:last,j);   
%
     end
%
     acc(1)=0.;
%
     big=max(acc);
     small=min(acc);
%
	 sym = abs(20*log10( big/abs(small)));
%
	 if(sym ==0)
		 out1=sprintf('  error: sym=%8.4g ',sym);
         disp(out1);
		 exit(1);
     end
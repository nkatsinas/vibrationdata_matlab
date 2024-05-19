 %
 %  dp_nastran_export_num.m  ver 1.0  by Tom Irvine
 %
 function[k]=dp_nastran_export_num(n,t,a,fid,num,type)
 %
    k = floor( double(n)/4.);
    
    out1=sprintf(' n=%d  k=%d   ',n,k);
    disp(out1);
%    
    
    [fid]=nastran_export_begin(num,type,fid);
%
    progressbar;
%    
%%    for i=1:4:(n-3)
    i=1;    
    while(i<=n)
%
       progressbar(i/n);
%
	   x1=t(i);
       [iflag,ss]=datafix_dp(x1);
	   s1=ss;
%
	   x=a(i);
       [iflag,ss]=datafix_dp(x);
	   s2=ss;
%
       if((i+1)<=n)
          x3=t(i+1);
          [iflag,ss]=datafix_dp(x3);
	      s3=ss;
%
          x=a(i+1);
          [iflag,ss]=datafix_dp(x);
          s4=ss;
%
          if( t(i)==0 && t(i+1)==0 )
		     printf('\n double zero error \n');
           end
       end
%
%
%%       out1=sprintf(' %8.4g %8.4g %8.4g %8.4g ',x1,x3,x5,x7);
%%       disp(out1);
%
       if(    x1 < x3 )
%	   
		   fprintf(fid,'*       %s%s%s%s+\n',s1,s2,s3,s4);
%
           i=i+2;
		   iflag=1;
       end
       if(    x1 >= x3 )
%	   
		   fprintf(fid,'*       %s%s',s1,s2);
           i=i+1;
%
           out1=sprintf('%12.7g %12.7g',str2double(s1),str2double(s3));
           disp(out1);
           disp('ref 3');
		   iflag=2;
%
		   break;
       end
%
    end
%
    out1=sprintf('\n iflag=%d  i=%d  x1=%8.4g\n',iflag,i,x1);
    disp(out1);
%
    nastran_export_end(fid,iflag);
%    
    pause(0.3);
    progressbar(1);
%
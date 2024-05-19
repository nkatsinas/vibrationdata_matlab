 %
 %  sp_nastran_export.m  ver 1.0  by Tom Irvine
 %
 function[k]=sp_nastran_export(n,t,a,fid)
 %

    k = floor( double(n)/4.);
    
    out1=sprintf(' n=%d  k=%d   ',n,k);
    disp(out1);
%
    fprintf(fid,'ID  \n');
    fprintf(fid,'SOL SEMTRAN \n');
    fprintf(fid,'TIME 10000 \n');
    fprintf(fid,'CEND \n');
    fprintf(fid,' TITLE = Transient \n');
    fprintf(fid,'BEGIN BULK \n');
    fprintf(fid,'TABLED2        9      0.                                                +    \n');
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
       [iflag,ss]=datafix(x1);
	   s1=ss;
%
	   x=a(i);
       [iflag,ss]=datafix(x);
	   s2=ss;
%
       if((i+1)<=n)
          x3=t(i+1);
          [iflag,ss]=datafix(x3);
	      s3=ss;
%
          x=a(i+1);
          [iflag,ss]=datafix(x);
          s4=ss;
%
          if( t(i)==0 && t(i+1)==0 )
		     printf('\n double zero error \n');
           end
       end
%
       if((i+2)<=n)
            x5=t(i+2);
            [iflag,ss]=datafix(x5);
            s5=ss;
%
            x=a(i+2);
            [iflag,ss]=datafix(x);
            s6=ss;
       end
%
       if((i+3)<=n)
            x7=t(i+3);
            [iflag,ss]=datafix(x7);
            s7=ss;
%
            x=a(i+3);
            [iflag,ss]=datafix(x);
            s8=ss;   
       end     
%
%%       out1=sprintf(' %8.4g %8.4g %8.4g %8.4g ',x1,x3,x5,x7);
%%       disp(out1);
%
       if(    x1 < x3 ...
		   && x3 < x5 ...
		   && x5 < x7 )
%       
			fprintf(fid,'+       %s%s%s%s%s%s%s%s+\n',s1,s2,s3,s4,s5,s6,s7,s8);
            i=i+4;
       end

       if(    x1 < x3 ...
		   && x3 < x5 ...
		   && x5 >= x7 )
%	   
		   fprintf(fid,'+       %s%s%s%s%s%s',s1,s2,s3,s4,s5,s6);
           i=i+3;
           disp('ref 1');
		   iflag=2;
%
		   break;
       end
%
       if(    x1 < x3 && x3 >= x5 )
%	   
		   fprintf(fid,'+       %s%s%s%s',s1,s2,s3,s4);
%
           i=i+2;
           disp('ref 2');
		   iflag=2;
		   break;
       end
       if(    x1 >= x3 )
%	   
		   fprintf(fid,'+       %s%s',s1,s2);
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
    if(iflag==1)
        fprintf(fid,'+,ENDT\n');
        fprintf(fid,'ENDDATA');
    end
    if(iflag==2)
        fprintf(fid,'ENDT\n');
        fprintf(fid,'ENDDATA');
    end
%
    fclose(fid);
%    
    pause(0.3);
    progressbar(1);
%
%
%   xtick_label_gnuplot.m  ver 2.9  by Tom Irvine
%
function[xstring,iflag]=xtick_label_gnuplot(fmin,fmax)


try

xtt=[];
xTT={};
iflag=0;


%  xstring='set xtics add ("20" 20,"100" 100,"1000" 1000,"2000" 2000) \n';

%
%  start 0.001
%
if(fmin>=0.001 && fmin<0.005)

    if(fmax<=0.2)
        xstring='set xtics add ( "0.001" 0.001,"0.01" 0.01,"0.02" 0.02 ) \n';
        iflag=1; 
        return;
    end
    if(fmax<=0.1)
        xstring='set xtics add ( "0.001" 0.001,"0.01" 0.01,"0.1" 0.1 ) \n';
        iflag=1; 
        return;
    end
    if(fmax<=0.2)
        xstring='set xtics add ( "0.001" 0.001,"0.01" 0.01,"0.1" 0.1,"0.2" 0.2 ) \n';        
        iflag=1; 
        return;
    end
    if(fmax<=0.5)
        xstring='set xtics add ( "0.001" 0.001,"0.01" 0.01,"0.1" 0.1,"0.5" 0.5 ) \n';        
        iflag=1; 
        return;
    end
    if(fmax<=1)
        xstring='set xtics add ( "0.001" 0.001,"0.01" 0.01,"0.1" 0.1,"1" 1 ) \n';          
        iflag=1; 
        return;
    end
    if(fmax<=5)
        xstring='set xtics add ( "0.001" 0.001,"0.01" 0.01,"0.1" 0.1,"1" 1,"5" 5) \n';          
        iflag=1; 
        return;
    end    
end


%
%  start 0.01
%
if(fmin>=0.01 && fmin<0.03)

    if(fmax<=0.2)
        xstring='set xtics add ( "0.01" 0.01,"0.1" 0.1,"0.2" 0.2) \n';  
        iflag=1; 
        return;
    end
    if(fmax<=1)
        xstring='set xtics add ( "0.01" 0.01,"0.1" 0.1,"1" 1) \n';         
        iflag=1; 
        return;
    end
    if(fmax<=2)
        xstring='set xtics add ( "0.01" 0.01,"0.1" 0.1,"1" 1,"2" 2) \n';   
        iflag=1; 
        return;
    end
    if(fmax<=5)
        xstring='set xtics add ( "0.01" 0.01,"0.1" 0.1,"1" 1,"5" 5) \n';          
        iflag=1; 
        return;
    end

end


%
%  start 0.1
%
if(fmin>=0.1 && fmin<0.3)

    if(fmax<=2)
        xstring='set xtics add ( "0.1" 0.1,"1" 1,"2" 2) \n';         
        iflag=1; 
        return;
    end
    if(fmax<=10)
        xstring='set xtics add ( "0.1" 0.1,"1" 1,"10" 10) \n';          
        iflag=1; 
        return;
    end
    if(fmax<=20)
        xstring='set xtics add ( "0.1" 0.1,"1" 1,"10" 10,"20" 20) \n';         
        iflag=1; 
        return;
    end
    if(fmax<=50)
        xstring='set xtics add ( "0.1" 0.1,"1" 1,"10" 10,"50" 50) \n';           
        iflag=1; 
        return;
    end

end

%
%
%  start 0.3
%
if(fmin>=0.3 && fmin<1)

    if(fmax<=20)
        xstring='set xtics add ( "0.3" 0.3,"1" 1,"10" 10,"20" 20) \n'; 
        iflag=1; 
        return;
    end
    if(fmax<=50)
        xstring='set xtics add ( "0.3" 0.3,"1" 1,"10" 10,"50" 50) \n';         
        iflag=1; 
        return;
    end
    if(fmax<=100)
        xstring='set xtics add ( "0.3" 0.3,"1" 1,"10" 10,"100" 100) \n';  
        iflag=1; 
        return;
    end
end

%
%
%  start 1
%

if(fmin>=1 && fmin<2)

    if(fmax<=20)
        xstring='set xtics add ("1" 1,"10" 10,"20" 20) \n'; 
        iflag=1; 
        return;
    end
    if(fmax<=50)
        xstring='set xtics add ("1" 1,"10" 10,"20" 20,"30" 30,"40" 40,"50" 50) \n'; 
        iflag=1; 
        return;
    end  
    if(fmax<=100)
        xstring='set xtics add ("1" 1,"10" 10,"100" 100) \n';         
        iflag=1; 
        return;
    end  

end



%
%  start 2
%


if(fmin>=2 && fmin<5)

    if(fmax<=80)
        xstring='set xtics add ("2" 2,"10" 10,"80" 80) \n';          
        iflag=1; 
        return;
    end
end


%
%  start 5
%

if(fmin>=5 && fmin<10)

    if(fmax<51)
        xstring='set xtics add ("5" 5,"10" 10,"50" 50) \n';         
        iflag=1; 
        return;
    end
    if(fmax<101)
        xstring='set xtics add ("5" 5,"10" 10,"100" 100) \n';          
        iflag=1; 
        return;
    end
    if(fmax<510)
        xstring='set xtics add ("5" 5,"10" 10,"100" 100,"500" 500) \n';         
        iflag=1; 
        return;
    end
    if(fmax<1010)
        xstring='set xtics add ("5" 5,"10" 10,"100" 100,"500" 500,"1000" 1000) \n';          
        iflag=1; 
        return;
    end
    if(fmax<=2050)
        xstring='set xtics add ("5" 5,"10" 10,"100" 100,"500" 500,"1000" 1000,"2000" 2000) \n';        
        iflag=1; 
        return;
    end

end


%
%  start 10
%

if(fmin>=10 && fmin<20)

    if(fmax<51)
        xstring='set xtics add ("10" 10,"20" 20,"30" 30,"40" 40,"50" 50) \n';         
        iflag=1; 
        return;
    end
    if(fmax<=105)
        xstring='set xtics add ("10" 10,"100" 100) \n';
        iflag=1; 
        return;    
    end
    if(fmax<=205)
        xstring='set xtics add ("10" 10,"100" 100,"200" 200) \n';        
        iflag=1; 
        return;    
    end
    if(fmax<=505)
        xstring='set xtics add ("10" 10,"100" 100,"500" 500) \n';            
        iflag=1; 
        return;
    end
    if(fmax<=1020)
        xstring='set xtics add ("10" 10,"100" 100,"1000" 1000) \n';           
        iflag=1; 
        return;
    end
    if(fmax<=2050)
        xstring='set xtics add ("10" 10,"100" 100,"1000" 1000,"2000" 2000) \n';          
        iflag=1; 
        return;
    end
    if(fmax<=3050)
        xstring='set xtics add ("10" 10,"100" 100,"1000" 1000,"3000" 3000) \n';        
        iflag=1; 
        return;
    end
    if(fmax<=4050)
        xstring='set xtics add ("10" 10,"100" 100,"1000" 1000,"4000" 4000) \n';           
        iflag=1; 
        return;
    end
    if(fmax<=5100)
        xstring='set xtics add ("10" 10,"100" 100,"1000" 1000,"5000" 5000) \n';          
        iflag=1; 
        return;
    end
%
    if(fmax<=10010)
        xstring='set xtics add ("10" 10,"100" 100,"1000" 1000,"10K" 10000) \n';        
        iflag=1; 
        return;
    end
%
    if(fmax<=20010)
        xstring='set xtics add ("10" 10,"100" 100,"1000" 1000,"10K" 10000,"20K" 20000) \n';          
        iflag=1; 
        return;
    end

end


%
%  start 20
%

if(fmin>=20 && fmin<50)

    if(fmax<=1010)
        xstring='set xtics add ("20" 20,"100" 100,"1000" 1000) \n'; 
        iflag=1; 
        return;
    end    
    if(fmax<=2010)
        xstring='set xtics add ("20" 20,"100" 100,"1000" 1000,"2000" 2000) \n';
        iflag=1; 
        return;
    end
    if(fmax<=3000)
        xstring='set xtics add ("20" 20,"100" 100,"1K" 1000,"2K" 2000,"3K" 3000) \n';        
        iflag=1; 
        return;
    end
    if(fmax<=4000)
        xstring='set xtics add ("20" 20,"100" 100,"1K" 1000,"4K" 4000) \n';          
        iflag=1; 
        return;
    end
    if(fmax<=5010)
        xstring='set xtics add ("20" 20,"100" 100,"1K" 1000,"5K" 5000) \n';            
        iflag=1; 
        return;
    end
    if(fmax<=10010)
        xstring='set xtics add ("20" 20,"100" 100,"1000" 1000,"10K" 10000) \n';          
        iflag=1; 
        return;
    end
    if(fmax<=15010)
        xstring='set xtics add ("20" 20,"100" 100,"1000" 1000,"10K" 10000,"15K" 15000) \n';          
        iflag=1; 
        return;
    end
    if(fmax<=20010)
        xstring='set xtics add ("20" 20,"100" 100,"1000" 1000,"10K" 10000,"20K" 20000) \n';                
        iflag=1; 
        return;
    end

end


%
%  start 50
%

if(fmin>=50 && fmin<100)

    if(fmax<=2010)
        xstring='set xtics add ("50" 50,"100" 100,"1K" 1000,"2K" 2000) \n';         
        iflag=1; 
        return;
    end    
    if(fmax<=3010)
        xstring='set xtics add ("50" 50,"100" 100,"1K" 1000,"2K" 2000,"3K" 3000) \n';         
        iflag=1; 
        return;
    end
    if(fmax<=4010)
        xstring='set xtics add ("50" 50,"100" 100,"1K" 1000,"2K" 2000,"3K" 3000,"4K" 4000) \n';        
        iflag=1; 
        return;
    end

end

%
%  start 100
%

if(fmin>=100 && fmin<200)

    if(fmax<=2010)
        xstring='set xtics add ("100" 100,"1000" 1000,"2000" 2000) \n';        
        iflag=1; 
        return;
    end

    if(fmax<=3010)
        xstring='set xtics add ("100" 100,"200" 200,"500" 500,"1000" 1000,"2000" 2000,"3000" 3000) \n';         
        iflag=1; 
        return;
    end

    if(fmax<=4010)
        xstring='set xtics add ("100" 100,"1000" 1000,"2000" 2000,"3000" 3000,"4000" 4000) \n';           
        iflag=1; 
        return;
    end

    if(fmax<=5010)
        xstring='set xtics add ("100" 100,"1000" 1000,"2000" 2000,"3000" 3000,"4000" 4000,"5000" 5000) \n';          
        iflag=1; 
        return;
    end

    if(fmax<=10010)
        xstring='set xtics add ("100" 100,"1000" 1000,"10K" 10000) \n';         
        iflag=1; 
        return;
    end

end

%
%  start 200
%

if(fmin>=200 && fmin<=2000)

    if(fmax<=2010)
        xstring='set xtics add ("200" 200,"1000" 1000,"2000" 2000) \n';    
        iflag=1; 
        return;
    end
    if(fmax<=3010)
        xstring='set xtics add ("200" 200,"1000" 1000,"2000" 2000,"3000" 3000) \n';           
        iflag=1; 
        return;
    end   
    if(fmax<=10010)
        xstring='set xtics add ("200" 200,"1000" 1000,"10K" 10000) \n';            
        iflag=1; 
        return;
    end     
    
end


%
%

catch
   
   out1=sprintf(' fmin=%9.5g  fmax=%9.5g  ',fmin,fmax);
   disp(out1);
   
   warndlg('xtick_label error ');
   return;
end


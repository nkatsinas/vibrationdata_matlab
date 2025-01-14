%
%   skewness_kurtosis_coefficients.m  ver 1.0  October 20,2014
%
function[p1,p2,skgoal]=skewness_kurtosis_coefficients(n,m)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(n==2)  % skew = 0.1
   if(m==1)
     p1=[   -0.3100    2.0549    0.2659]; 
     p2=[    0.0075    1.6978    0.0119];
   else    
     p1=[   -0.0638    1.7302    0.2267];
     p2=[   -0.3365    2.1928   -0.0098];
   end  
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(n==3)  % skew = 0.2
   if(m==1) 
     p1=[    -0.3675    1.9622    0.4881 ];
     p2=[     0.1892    1.5378   -0.0978 ];       
   else       
     p1=[     0.0377    1.5555    0.3153 ];
     p2=[    -0.3783    2.3621   -0.1399 ];
   end 
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(n==4)  % skew = 0.3
   if(m==1) 
     p1=[    -0.2023    1.4790    0.8660 ];
     p2=[     0.3582    1.3980   -0.2165 ];          
   else       
     p1=[     0.0979    1.4367    0.3832 ];
     p2=[    -0.4802    2.6160   -0.3075 ];
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(n==5)  % skew = 0.4
  
   if(m==1) 
     p1=[     0.2615    0.4642    1.4733 ];
     p2=[     0.4592    1.3612   -0.3785 ];          
   else       
     p1=[     0.1378    1.3543    0.4332 ];
     p2=[    -0.6061    2.9163   -0.5015 ];
   end 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(n==6)  % skew = 0.5
  
   if(m==1) 
     p1=[      0.8345   -0.8109    2.2314];
     p2=[      0.5346    1.3846   -0.5814];          
   else       
     p1=[     0.1655    1.2931    0.4720 ];
     p2=[    -0.7503    3.2775   -0.7384 ];
   end 
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(n==7)  % skew = 0.6
   
   if(m==1) 
     p1=[      1.4545   -2.2469    3.1115];
     p2=[      0.6143    1.4277   -0.8181 ];          
   else     
     p1=[     0.1926    1.2393    0.5034 ];
     p2=[    -0.9560    3.7524   -1.0336 ];
   end 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(n==8)  % skew = 0.7
 
   if(m==1) 
     p1=[     1.7263   -3.0944    3.7660 ];
     p2=[     0.8559    1.1956   -0.9560 ];          
   else       
     p1=[     0.2029    1.2217    0.5148 ];
     p2=[    -1.1728    4.2621   -1.3608 ];
   end 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if(n==1)
    skgoal=0;
end
if(n==2)
    skgoal=0.1;
end
if(n==3)
    skgoal=0.2;
end
if(n==4)
    skgoal=0.3;
end
if(n==5)
    skgoal=0.4;
end
if(n==6)
    skgoal=0.5;
end
if(n==7)
    skgoal=0.6;
end
if(n==8)
    skgoal=0.7;
end
if(n==9)
    skgoal=0.8;
end

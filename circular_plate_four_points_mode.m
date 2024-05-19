%
%  circular_plate_four_points_mode.m  ver 1.0  by Tom Irvine
%
function[Z]=circular_plate_four_points_mode(r,radius,theta,ZAA)
%       
        n=4;  
        nc=4; 
 
        rrn=r/radius;
    
        cos_sum=zeros(length(r),1);     

        arg=[ 0.8709    0.0846    0.6709    0.6157 ]*pi;

        AA= [1.9619   -1.3048   -3.4583    3.0771];
    
        for ijk=1:nc
            Q=AA(ijk);

            for j=1:length(r)
                   alpha=arg(ijk)*rrn(j);
                   cos_sum(j)=   cos_sum(j)+Q*cos(alpha);        
            end
        end
        

%      
      mec=3.6059;
      med=3.9948;
 
%
     cc=2.8808;
     dd=-1.8808;
%%
     clear A; 
     A=0.8744;


%
    for i=1:length(theta)  % theta
%       
        cos_nth=cos(n*theta(i));
%
        for j=1:length(r)  % radius
%
%
              modu=(cc*rrn(j)^(mec-1) + dd*rrn(j)^med);  
%        
              wave=0.5+0.5*cos_nth;
              term=   modu*wave;
 %

            out1=sprintf(' term=%8.4g wave=%8.4g A=%8.4g cos_sum(j)=%8.4g ',term,wave,A,cos_sum(j)); 
            disp(out1);
            
            
            Z=A*term + cos_sum(j);


        end
    end    
    

    Z
    ZAA
    
    Z=Z/ZAA;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



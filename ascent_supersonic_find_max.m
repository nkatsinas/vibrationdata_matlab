


sz=size(NG_trajectory_Mach);

num=sz(1);

clear NG_Q;
clear NG_R1;
clear NG_R2;

k=1;
for i=1:2000
   
    if( NG_trajectory_Mach(i,2) > 1)
        NG_Q(k)=NG_trajectory_Q(i,2);
        NG_R1(k)=NG_trajectory_Q(i,2)/( 1 + 0.13*NG_trajectory_Mach(i,2)^2  );
        NG_R2(k)=NG_trajectory_Q(i,2)/( 1 +      NG_trajectory_Mach(i,2)^2  );
        k=k+1;
    end
end


out1=sprintf('\n\n NG \t %8.4g  \t %8.4g  \t %8.3g  ',max(NG_Q),max(NG_R1),max(NG_R2));
disp(out1);





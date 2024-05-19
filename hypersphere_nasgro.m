
%  hypersphere_nasgro.m  ver 1.0  by Tom Irvine

function[ycr,cr,drec]=hypersphere_nasgro(normal_stress_array,num_eng,A,B,CC,P,NT)

drec=0;

ss=size(normal_stress_array);

num_rows=ss(1);

nc=ss(2);
num_cols=nc;

if(nc==3 || nc==6)
else
    errordlg(' Column error');
    return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('  ');
disp(' trial      damage     c coefficients ');
progressbar;

c=zeros(num_cols,1);

for i=1:NT
    
    progressbar(i/NT);
    
    if(i< round(NT/10) || rand()>0.3 )
        c=rand(num_cols,1);
        c=c-0.5;
    else
        for k=1:num_cols
            c(k)=cr(k)*(0.98+0.04*rand());
        end        
    end
    
    c=c/norm(c);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

    yc=zeros(num_rows,1);

    for j=1:num_rows
        for k=1:num_cols
            yc(j)=yc(j)+c(k)*normal_stress_array(j,k);
        end
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%%    

[amp_mean_cycles]=rainflow_function_choice_mean(yc,num_eng);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%

[damage]=nasgro_damage_th(A,B,CC,P,amp_mean_cycles);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if(damage>drec || i==1)
       cr=c; 
       ycr=yc;    
       
       drec=damage;
     
       iflag=0;
       
       if(num_cols==3)
            out1=sprintf('    %d    %8.3e   %6.3g %6.3g %6.3g ',i,drec,c(1),c(2),c(3));
            iflag=1;            
       end

       if(num_cols==6)
            out1=sprintf('    %d    %8.3e   %6.3g %6.3g %6.3g %6.3g %6.3g %6.3g ',i,drec,c(1),c(2),c(3),c(4),c(5),c(6));
            iflag=1;            
       end
       
       if(iflag==0)
            out1=sprintf(' %d  %8.4g ',i,drec);                
       end
       
       disp(out1);       
       
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end


pause(0.4);
progressbar(1);
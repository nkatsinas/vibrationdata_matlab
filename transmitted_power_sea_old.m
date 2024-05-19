  
               power_cavity_shelf(i)=om*( eas(i)*E(2,i) - esa(i)*E(3,i) );                   
   power_cylindrical_shell_cavity(i)=om*( eca(i)*E(1,i) - eac(i)*E(2,i) ); 
   
   
   power_cylindrical_shell_shelf(i)=om*(  ecs(i)*E(1,i) - esc(i)*E(3,i) );    
   

%% out1=sprintf('%8.4g  %8.4g  %8.4g  %8.4g  %8.4g',feng(i),xpower(i,2),power_cylindrical_shell_cavity(i),power_cylindrical_shell_shelf(i),power_cavity_shelf(i));
%% disp(out1);
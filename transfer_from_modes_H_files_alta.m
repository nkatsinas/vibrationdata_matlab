%
%  transfer_from_modes_H_files_alta.m  ver 1.4  by Tom Irvine
%
function[str1_s,str2_s,str3_s]=...
                         transfer_from_modes_H_files_alta(iam,i,k,freq,H,HM)  
%
    if(iam==1)
        str1=sprintf('H_disp_force_%d_%d',i,k);
        str2=sprintf('HM_disp_force_%d_%d',i,k);
        str3=sprintf('HMP_disp_force_%d_%d',i,k);
    end
%    
    if(iam==2)
        str1=sprintf('H_vel_force_%d_%d',i,k);
        str2=sprintf('HM_vel_force_%d_%d',i,k);
        str3=sprintf('HMP_vel_force_%d_%d',i,k); 
    end
%    
    if(iam==3)
        str1=sprintf('H_acc_force_%d_%d',i,k);
        str2=sprintf('HM_acc_force_%d_%d',i,k);
        str3=sprintf('HMP_acc_force_%d_%d',i,k);        
    end
%    
    if(iam==4)
        str1=sprintf('H_force_disp_%d_%d',i,k);
        str2=sprintf('HM_force_disp_%d_%d',i,k);
        str3=sprintf('HMP_force_disp_%d_%d',i,k);        
    end   
%    
    if(iam==5)
        str1=sprintf('H_force_vel_%d_%d',i,k);
        str2=sprintf('HM_force_vel_%d_%d',i,k);
        str3=sprintf('HMP_force_vel_%d_%d',i,k);        
    end   
 %    
    if(iam==6)
        str1=sprintf('H_force_acc_%d_%d',i,k);
        str2=sprintf('HM_force_acc_%d_%d',i,k);
        str3=sprintf('HMP_force_acc_%d_%d',i,k);        
    end      
%    
    if(iam==7)
        str1=sprintf('H_acc_acc_%d_%d',i,k);
        str2=sprintf('HM_acc_acc_%d_%d',i,k);
        str3=sprintf('HMP_acc_acc_%d_%d',i,k);
    end    
   
%
    str1_s=str1;
    str2_s=str2;
    str3_s=str3;    
%
    v1=sprintf('%s.txt',str1);
    v2=sprintf('%s.txt',str2);   
    v3=sprintf('%s.txt',str3);
%    
%%    varname1 = genvarname(str1);
%%    varname2 = genvarname(str2); 
%%    varname3 = genvarname(str3);
%
%%    varname1b = genvarname(str1);
%%    varname2b = genvarname(str2);  
%%    varname3b = genvarname(str3);     
%
    eval('str1 = [freq  real(H) imag(H)];');    
    eval('str2 = [freq HM];'); 
    eval('str3 = [freq HM angle(H)];');     
%   
    save(v1,'str1','-ASCII');
    save(v2,'str2','-ASCII');
    save(v3,'str3','-ASCII');    
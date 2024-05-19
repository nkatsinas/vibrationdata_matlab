function[cdof]=beam_3D_keboard_constraints[cdof,nnum]
        disp('   ');
        disp(' Apply Translation Constraints? ');
        disp(' 1=yes  2=no ');
        iac=input(' ');
%
        if(iac==1)
            cflag=1;
        end
%
        i=1;
        while(iac==1)
            disp(' ');
            disp(' Enter node number to apply constraint. ');
            disp(' (Note that a value of 0 will apply constraint to all nodes) ');
            ncon=input(' ');
            disp(' ');
            disp(' Select dofs to constrain ');
            disp(' 1=TX ');  
            disp(' 2=TY '); 
            disp(' 3=TZ ');
            disp(' 4=TX & TY ');  
            disp(' 5=TX & TZ '); 
            disp(' 6=TY & TZ ');      
            disp(' 7=TX,TY,TZ ');             
            tchoice=input(' ');
%
            if(ncon==0)
%           
                for(nc=1:nnum)
                    if(tchoice==1 || tchoice==4 || tchoice==5 || tchoice==7)
                        cdof(i)=nc*6-5;
                        i=i+1;
                    end
                    if(tchoice==2 || tchoice==4 || tchoice==6 || tchoice==7)
                        cdof(i)=nc*6-4;
                        i=i+1;          
                    end
                    if(tchoice==3 || tchoice==5 || tchoice==6 || tchoice==7)
                        cdof(i)=nc*6-3;
                        i=i+1;
                    end         
                end
%            
            else
                if(tchoice==1 || tchoice==4 || tchoice==5 || tchoice==7)
                    cdof(i)=ncon*6-5;
                    i=i+1;
                end
                if(tchoice==2 || tchoice==4 || tchoice==6 || tchoice==7)
                    cdof(i)=ncon*6-4;
                    i=i+1;          
                end
                if(tchoice==3 || tchoice==5 || tchoice==6 || tchoice==7)
                    cdof(i)=ncon*6-3;
                    i=i+1;
                end
            end    
%        
            disp('   ');
            disp(' Apply another translational constraint? ');
            disp(' 1=yes  2=no ');
            iac=input(' ');
%           
        end
%
        disp('   ');
        disp(' Apply Rotational Constraints? ');
        disp(' 1=yes  2=no ');
        iac=input(' ');
        if(iac==1)
            cflag=1;
        end    
%
        while(iac==1)
            disp(' ');
            disp(' Enter node number to apply constraint. ');
            disp(' (Note that a value of 0 will apply constraint to all nodes) ');
            ncon=input(' ');
            if(ncon>nnum)
                disp(' Node number input error ');
            end     
            disp(' ');
            disp(' Select dofs to constrain ');
            disp(' 1=RX ');  
            disp(' 2=RY '); 
            disp(' 3=RZ ');
            disp(' 4=RX & RY ');  
            disp(' 5=RX & RZ '); 
            disp(' 6=RY & RZ ');      
            disp(' 7=RX,RY,RZ ');             
            tchoice=input(' ');
%
            if(ncon==0)
%           
                for(nc=1:nnum)
                    if(tchoice==1 || tchoice==4 || tchoice==5 || tchoice==7)
                        cdof(i)=nc*6-2;
                        i=i+1;
                    end
                    if(tchoice==2 || tchoice==4 || tchoice==6 || tchoice==7)
                        cdof(i)=nc*6-1;
                        i=i+1;          
                    end
                    if(tchoice==3 || tchoice==5 || tchoice==6 || tchoice==7)
                        cdof(i)=nc*6;
                        i=i+1;
                    end         
                end
%            
            else
                if(tchoice==1 || tchoice==4 || tchoice==5 || tchoice==7)
                    cdof(i)=ncon*6-2;
                    i=i+1;
                end
                if(tchoice==2 || tchoice==4 || tchoice==6 || tchoice==7)
                    cdof(i)=ncon*6-1;
                    i=i+1;          
                end
                if(tchoice==3 || tchoice==5 || tchoice==6 || tchoice==7)
                    cdof(i)=ncon*6;
                    i=i+1;
                end
            end    
%        
            disp('   ');
            disp(' Apply another rotational constraint? ');
            disp(' 1=yes  2=no ');
            iac=input(' ');
        end
function[f_sam,apsd_sam]=six_arbitrary(nbreak,slopec,foct)
        
        mm=length(foct); 

        apsd_sam=ones(nbreak,1);
       
             
        while(1)
 
                nnn=sort(round([ rand() rand() rand() rand()]*mm));
                    
                if(length(unique(nnn))==4)
                    if(min(nnn)>=3)
                        if(max(nnn)<=(mm-2))
                            break;
                        end
                    end
                end
        end
        
        f_sam(1)=foct(1);
        f_sam(2)=foct(nnn(1));      
        f_sam(3)=foct(nnn(2));        
        f_sam(4)=foct(nnn(3));       
        f_sam(5)=foct(nnn(4));        
        f_sam(6)=foct(end);
        
        
        n=ceil(8*rand());
               
        
        if(n==1) % two arbit
            slope=slopec*rand();
            if(rand()>0.5)
                slope=-slope;
            end
            for i=2:nbreak
                fratio=f_sam(i)/f_sam(i-1);
                apsd_sam(i)=apsd_sam(i-1)*fratio^(rand()*slopec);
            end            
        end
       if(n==2) % three arbit
            
            while(1)
 
                nnn=round(rand()*nbreak);
               
                if(min(nnn)>=2)
                    if(max(nnn)<=(nbreak-1))
                        break;
                    end
                end
            end
            
            nf1=nnn;
            
            slope1=slopec*rand();
            slope2=slopec*rand();
            if(rand()>0.5)
                slope2=-slope2;
            end    
            
            for i=2:nf1
                fratio=f_sam(i)/f_sam(1);
                apsd_sam(i)=apsd_sam(1)*(fratio)^slope1;
            end
            for i=nf1+1:nbreak
                fratio=f_sam(i)/f_sam(nf1);
                apsd_sam(i)=apsd_sam(nf1)*(fratio)^slope2;
            end
            
       end 
       if(n==3) % four arbit
            
            while(1)
 
                nnn=sort(round([ rand() rand() ]*nbreak));
                    
                if(length(unique(nnn))==2)
                    if(min(nnn)>=2)
                        if(max(nnn)<=(nbreak-1))
                            break;
                        end
                    end
                end
            end
            
            nf1=nnn(1);
            nf2=nnn(2);
            
            slope1=slopec*rand();
            slope2=slopec*rand();
            slope3=slopec*rand();
             
            if(rand()>0.5)
                slope2=-slope2;
            end 
            if(rand()>0.5)
                slope3=-slope3;
            end     
            
            for i=2:nf1
                fratio=f_sam(i)/f_sam(1);
                apsd_sam(i)=apsd_sam(1)*(fratio)^slope1;
            end
            for i=nf1+1:nf2
                fratio=f_sam(i)/f_sam(nf1);
                apsd_sam(i)=apsd_sam(nf1)*(fratio)^slope2;
            end
            for i=nf2+1:nbreak
                fratio=f_sam(i)/f_sam(nf2);
                apsd_sam(i)=apsd_sam(nf2)*(fratio)^slope3;
            end         
        end          
        if(n==4) % five arbit
            
            while(1)
 
                nnn=sort(round([ rand() rand() rand() ]*nbreak));
                    
                if(length(unique(nnn))==3)
                    if(min(nnn)>=2)
                        if(max(nnn)<=(nbreak-1))
                            break;
                        end
                    end
                end
            end
            
            nf1=nnn(1);
            nf2=nnn(2);
            nf3=nnn(3);            
            
            slope1=slopec*rand();
            slope2=slopec*rand();
            slope3=slopec*rand();
            slope4=slopec*rand();
             
            if(rand()>0.5)
                slope2=-slope2;
            end 
            if(rand()>0.5)
                slope3=-slope3;
            end     
            if(rand()>0.5)
                slope4=-slope4;
            end            
            
            for i=2:nf1
                fratio=f_sam(i)/f_sam(1);
                apsd_sam(i)=apsd_sam(1)*(fratio)^slope1;
            end
            for i=nf1+1:nf2
                fratio=f_sam(i)/f_sam(nf1);
                apsd_sam(i)=apsd_sam(nf1)*(fratio)^slope2;
            end
            for i=nf2+1:nf3
                fratio=f_sam(i)/f_sam(nf2);
                apsd_sam(i)=apsd_sam(nf2)*(fratio)^slope3;
            end  
            for i=nf3+1:nbreak
                fratio=f_sam(i)/f_sam(nf3);
                apsd_sam(i)=apsd_sam(nf3)*(fratio)^slope4;
            end            
        end   
        if(n>=5) % six arbit
            
            nf1=2;
            nf2=3;
            nf3=4;            
            nf4=5;
            
            slope1=slopec*rand();
            slope2=slopec*rand();
            slope3=slopec*rand();
            slope4=slopec*rand();
            slope5=slopec*rand();
             
            if(rand()>0.5)
                slope2=-slope2;
            end 
            if(rand()>0.5)
                slope3=-slope3;
            end     
            if(rand()>0.5)
                slope4=-slope4;
            end  
            if(rand()>0.5)
                slope5=-slope5;
            end                  
            
            for i=2:nf1
                fratio=f_sam(i)/f_sam(1);
                apsd_sam(i)=apsd_sam(1)*(fratio)^slope1;
            end
            for i=nf1+1:nf2
                fratio=f_sam(i)/f_sam(nf1);
                apsd_sam(i)=apsd_sam(nf1)*(fratio)^slope2;
            end
            for i=nf2+1:nf3
                fratio=f_sam(i)/f_sam(nf2);
                apsd_sam(i)=apsd_sam(nf2)*(fratio)^slope3;
            end  
            for i=nf3+1:nf4
                fratio=f_sam(i)/f_sam(nf3);
                apsd_sam(i)=apsd_sam(nf3)*(fratio)^slope4;
            end             
            for i=nf4+1:nbreak
                fratio=f_sam(i)/f_sam(nf4);
                apsd_sam(i)=apsd_sam(nf4)*(fratio)^slope5;
            end            
        end      

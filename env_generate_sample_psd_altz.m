%
%   env_generate_sample_psd_altz.m  ver 1.9   by Tom Irvine
%

%
function[f_sam,apsd_sam,max_sss,slopec]=...
    env_generate_sample_psd_altz(n_ref,nbreak,npb,f_ref,ik,slopec,initial,final,f1,f2,plateau,foct)
%

% slopec

while(1)
%
    if(npb<=10)    
        [f_sam]=generate_frequency(nbreak,npb,n_ref,f_ref,f1,f2);
        [apsd_sam]=generate_amplitude(nbreak,initial,final);
        [apsd_sam]=opt_psd_amplitude_adjust(nbreak,npb,apsd_sam);
        [max_sss,min_fff]=freq_slope_check(f_sam,apsd_sam);
        if(f_sam(end)==f2 && max_sss<slopec && min_fff>plateau)
            break;
        end
    end

    if(npb==11)
        [f_sam,apsd_sam]=six_arbitrary(nbreak,slopec,foct);
        [max_sss,min_fff]=freq_slope_check(f_sam,apsd_sam);
        break;
    end    
    if(npb==12)
        [f_sam,apsd_sam]=seven_arbitrary(nbreak,slopec,foct);
        [max_sss,min_fff]=freq_slope_check(f_sam,apsd_sam);
        break;
    end  
    if(npb==13)
        [f_sam,apsd_sam]=eight_arbitrary(nbreak,slopec,foct);
        [max_sss,min_fff]=freq_slope_check(f_sam,apsd_sam);
        break;
    end 
    if(npb==14)
        [f_sam,apsd_sam]=nine_arbitrary(nbreak,slopec,foct);
        [max_sss,min_fff]=freq_slope_check(f_sam,apsd_sam);
        break;
    end 
    if(npb==15)
        [f_sam,apsd_sam]=ten_arbitrary(nbreak,slopec,foct);
        [max_sss,min_fff]=freq_slope_check(f_sam,apsd_sam);
        break;
    end     
    if(npb==16)
               
        [f_sam,apsd_sam]=one_twelfth_arbitrary(nbreak,slopec,foct);        
        [max_sss,min_fff]=freq_slope_check(f_sam,apsd_sam); 
        
        if(f_sam(end)==f2 && max_sss<slopec)
            break;
        else
            disp(' * * ');
            out1=sprintf(' %8.4g %8.4g  %8.4g %8.4g  %8.4g %8.4g',f_sam(end),f2,max_sss,slopec,min_fff,plateau);
            disp(out1);
%%%            uuu=input(' ');
        end
        
    end        
end


%


function[f_sam]=generate_frequency(nbreak,npb,n_ref,f_ref,f1,f2)

f_sam=zeros(nbreak,1);

while(1)    
        g=zeros(nbreak,1);
    
        for i=1:nbreak
%		  
            index = round( n_ref*rand());
            if(index >= n_ref)
                index=n_ref-1;
            end    
            if(index <= 1)
                index=2;
            end
        
            g(i)=index;
            f_sam(i)=f_ref(index);
            
        end    

%
        f_sam(1)=f1;
        f_sam(nbreak)=f2;
        f_sam=sort(f_sam);
        
        if(length(g)==length(unique(g)))
            break;
        end  

end




function[apsd_sam]=generate_amplitude(nbreak,initial,final)
%
    apsd_sam=zeros(nbreak,1);

    for i=1:nbreak
        apsd_sam(i)=rand();
    end
%	   
    amin=1.0e-12;
%
    for i=1:nbreak
%	 
        if(apsd_sam(i) < amin)
            apsd_sam(i)=amin;
        end  
	    if(apsd_sam(i) > (1/amin))
            apsd_sam(i)=(1/amin);
        end    
    end
%%
    if(initial==1 && apsd_sam(1) > apsd_sam(1))
        apsd_sam(1)=apsd_sam(1);
    end
    if(final==1 && apsd_sam(nbreak) > apsd_sam(nbreak-1))
        apsd_sam(nbreak)=apsd_sam(nbreak-1);
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
        
        
       
            
            nf1=2;
            nf2=3;
            nf3=4;            
            nf4=5;
            
            slope1=slopec*rand();
            slope2=slopec*rand();
            slope3=slopec*rand();
            slope4=slopec*rand();
            slope5=slopec*rand();
 
            if(rand()>0.95)
                slope1=-slope1;
            end             
            if(rand()>0.5)
                slope2=-slope2;
            end 
            if(rand()>0.5)
                slope3=-slope3;
            end     
            if(rand()>0.5)
                slope4=-slope4;
            end  
            if(rand()>0.05)
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[f_sam,apsd_sam]=seven_arbitrary(nbreak,slopec,foct)
        
        
        mm=length(foct); 

        apsd_sam=ones(nbreak,1);
       
             
        while(1)
 
                nnn=sort(round([ rand() rand() rand() rand() rand()]*mm));
                    
                if(length(unique(nnn))==5)
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
        f_sam(6)=foct(nnn(5));         
        f_sam(7)=foct(end);
        
        
       
            
            nf1=2;
            nf2=3;
            nf3=4;            
            nf4=5;
            nf5=6;
            
            slope1=slopec*rand();
            slope2=slopec*rand();
            slope3=slopec*rand();
            slope4=slopec*rand();
            slope5=slopec*rand();
            slope6=slopec*rand();             
 
            if(rand()>0.95)
                slope1=-slope1;
            end             
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
            if(rand()>0.05)
                slope6=-slope6;
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
            for i=nf4+1:nf5
                fratio=f_sam(i)/f_sam(nf4);
                apsd_sam(i)=apsd_sam(nf4)*(fratio)^slope5;
            end               
            for i=nf5+1:nbreak
                fratio=f_sam(i)/f_sam(nf5);
                apsd_sam(i)=apsd_sam(nf5)*(fratio)^slope6;
            end      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[f_sam,apsd_sam]=eight_arbitrary(nbreak,slopec,foct)
        
        
        mm=length(foct); 

        apsd_sam=ones(nbreak,1);
       
             
        while(1)
 
                nnn=sort(round([ rand() rand() rand() rand() rand() rand()]*mm));
                    
                if(length(unique(nnn))==6)
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
        f_sam(6)=foct(nnn(5));         
        f_sam(7)=foct(nnn(6));           
        f_sam(8)=foct(end);
        
        
      
            nf1=2;
            nf2=3;
            nf3=4;            
            nf4=5;
            nf5=6;
            nf6=7;
            
            slope1=slopec*rand();
            slope2=slopec*rand();
            slope3=slopec*rand();
            slope4=slopec*rand();
            slope5=slopec*rand();
            slope6=slopec*rand();             
            slope7=slopec*rand();  
            
            if(rand()>0.95)
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
            if(rand()>0.5)
                slope6=-slope6;
            end             
            if(rand()>0.05)
                slope7=-slope7;
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
            for i=nf4+1:nf5
                fratio=f_sam(i)/f_sam(nf4);
                apsd_sam(i)=apsd_sam(nf4)*(fratio)^slope5;
            end 
            for i=nf5+1:nf6
                fratio=f_sam(i)/f_sam(nf5);
                apsd_sam(i)=apsd_sam(nf5)*(fratio)^slope6;
            end                   
            for i=nf6+1:nbreak
                fratio=f_sam(i)/f_sam(nf6);
                apsd_sam(i)=apsd_sam(nf6)*(fratio)^slope7;
            end      
            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function[f_sam,apsd_sam]=nine_arbitrary(nbreak,slopec,foct)
        
        
        mm=length(foct); 

        apsd_sam=ones(nbreak,1);
       
             
        while(1)
 
                nnn=sort(round([ rand() rand() rand() rand() rand() rand() rand()]*mm));
                    
                if(length(unique(nnn))==7)
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
        f_sam(6)=foct(nnn(5));         
        f_sam(7)=foct(nnn(6));    
        f_sam(8)=foct(nnn(7));            
        f_sam(9)=foct(end);
        
        
      
            nf1=2;
            nf2=3;
            nf3=4;            
            nf4=5;
            nf5=6;
            nf6=7;
            nf7=8;
            
            slope1=slopec*rand();
            slope2=slopec*rand();
            slope3=slopec*rand();
            slope4=slopec*rand();
            slope5=slopec*rand();
            slope6=slopec*rand();             
            slope7=slopec*rand();  
            slope8=slopec*rand(); 
             
            if(rand()>0.95)
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
            if(rand()>0.5)
                slope6=-slope6;
            end    
            if(rand()>0.5)
                slope7=-slope7;
            end            
            if(rand()>0.05)
                slope8=-slope8;
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
            for i=nf4+1:nf5
                fratio=f_sam(i)/f_sam(nf4);
                apsd_sam(i)=apsd_sam(nf4)*(fratio)^slope5;
            end 
            for i=nf5+1:nf6
                fratio=f_sam(i)/f_sam(nf5);
                apsd_sam(i)=apsd_sam(nf5)*(fratio)^slope6;
            end  
            for i=nf6+1:nf7
                fratio=f_sam(i)/f_sam(nf6);
                apsd_sam(i)=apsd_sam(nf6)*(fratio)^slope7;
            end                   
            for i=nf7+1:nbreak
                fratio=f_sam(i)/f_sam(nf7);
                apsd_sam(i)=apsd_sam(nf7)*(fratio)^slope8;
            end      
            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[f_sam,apsd_sam]=ten_arbitrary(nbreak,slopec,foct)
        
while(1)        
        mm=length(foct); 

        apsd_sam=ones(nbreak,1);
       
             
        while(1)
 
                nnn=sort(round([ rand() rand() rand() rand() rand() rand() rand() rand()]*mm));
                    
                if(length(unique(nnn))==8)
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
        f_sam(6)=foct(nnn(5));         
        f_sam(7)=foct(nnn(6));    
        f_sam(8)=foct(nnn(7));            
        f_sam(9)=foct(nnn(8));              
        f_sam(10)=foct(end);
        
        
      
            nf1=2;
            nf2=3;
            nf3=4;            
            nf4=5;
            nf5=6;
            nf6=7;
            nf7=8;
            nf8=9;
            
            slope1=slopec*rand();
            slope2=slopec*rand();
            slope3=slopec*rand();
            slope4=slopec*rand();
            slope5=slopec*rand();
            slope6=slopec*rand();             
            slope7=slopec*rand();  
            slope8=slopec*rand(); 
            slope9=slopec*rand();            
             
            if(rand()>0.95)
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
            if(rand()>0.5)
                slope6=-slope6;
            end    
            if(rand()>0.5)
                slope7=-slope7;
            end 
            if(rand()>0.5)
                slope8=-slope8;
            end                   
            if(rand()>0.05)
                slope9=-slope9;
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
            for i=nf4+1:nf5
                fratio=f_sam(i)/f_sam(nf4);
                apsd_sam(i)=apsd_sam(nf4)*(fratio)^slope5;
            end 
            for i=nf5+1:nf6
                fratio=f_sam(i)/f_sam(nf5);
                apsd_sam(i)=apsd_sam(nf5)*(fratio)^slope6;
            end  
            for i=nf6+1:nf7
                fratio=f_sam(i)/f_sam(nf6);
                apsd_sam(i)=apsd_sam(nf6)*(fratio)^slope7;
            end 
            for i=nf7+1:nf8
                fratio=f_sam(i)/f_sam(nf7);
                apsd_sam(i)=apsd_sam(nf7)*(fratio)^slope8;
            end                 
            for i=nf8+1:nbreak
                fratio=f_sam(i)/f_sam(nf8);
                apsd_sam(i)=apsd_sam(nf8)*(fratio)^slope9;
            end
            
    if(min(apsd_sam)>0)
        break;
    end
            
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[f_sam,apsd_sam]=one_twelfth_arbitrary(nbreak,slopec,foct)

        f_sam=foct;
        
        apsd_sam=zeros(nbreak,1);
        apsd_sam(1)=1;
        
        n=ceil(4*rand());
        
        
        if(n==1)
            
            mm=length(foct); 
             
            while(1)
 
                nnn=sort(round(rand()*mm));
                    
                if(length(unique(nnn))==1)
                    if(min(nnn)>=3)
                        if(max(nnn)<=(mm-2))
                            break;
                        end
                    end
                end
            end
            
            nf1=nnn(1);
            
            slope1=slopec*rand();
            slope2=slopec*rand();
             
            if(rand()>0.95)
                slope1=-slope1;
            end 
            if(rand()>0.05)
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
        if(n==2)
            
            mm=length(foct); 
             
            while(1)
 
                nnn=sort(round([rand() rand()]*mm));
                    
                if(length(unique(nnn))==2)
                    if(min(nnn)>=3)
                        if(max(nnn)<=(mm-2))
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
            
            if(rand()>0.95)
                slope1=-slope1;
            end 
            if(rand()>0.5)
                slope2=-slope2;
            end            
            if(rand()>0.05)
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
        if(n==3)
            
            mm=length(foct); 
             
            while(1)
 
                nnn=sort(round([rand() rand() rand()]*mm));
                    
                if(length(unique(nnn))==3)
                    if(min(nnn)>=3)
                        if(max(nnn)<=(mm-2))
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
            
            if(rand()>0.95)
                slope1=-slope1;
            end 
            if(rand()>0.5)
                slope2=-slope2;
            end
            if(rand()>0.5)
                slope3=-slope3;
            end              
            if(rand()>0.05)
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
        if(n==4)
        
            for i=2:nbreak
                fratio=f_sam(i)/f_sam(i-1);
            
                slope=rand()*slopec;
            
                if(rand()>0.5)
                    slope=-slope;
                end

                apsd_sam(i)=apsd_sam(i-1)*(fratio)^slope;
            end
        
        end
  
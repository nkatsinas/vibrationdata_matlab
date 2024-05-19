

% srs_envelope_engine_alt.m  ver 1.8  by Tom Irvine


function[spec]=srs_envelope_engine_alt(ntrials,nf,f,srs_in,ioct,omegan,num,mscale,iform,Q,THFO,CT)

if(min(f)<=0)
    disp('error: srs_envelope_engine')
    return;
end    


amax=max(srs_in);

ccc_record=1.0e+99;

frec=0;
arec=0;

nntt=round(ntrials*0.1);

if(nntt<4)
    nntt=4;
end


for i=1:ntrials
    
    while(1)
   
        while(1)
        
            iflag=1;
    
            if(i<nntt || rand()<0.3)
        
                [fr,r]=gen_one(num,nf,f,srs_in,amax,iform);
                
                if(min(fr)<=0)
                    disp('gen_one');
                    fr
                    % return;
                end         
        
            else
                iflag=2;
                
                [fr,r,kflag]=gen_two(nf,f,fr,frec,arec,num,iform);

                if(min(fr)<=0)
                    disp('gen_two');
                    fr
                    % return;
                end    

                
                if(kflag==1)
                    warndlg(' gen two error');
                    % return;
                end
            end  
    
            noct=zeros(num-1,1);
            
            for ijv=1:num-1
                
                noct(ijv)=log(fr(ijv+1)/fr(ijv))/log(2);
            
            end
            
            if(min(noct)>0.2)
                break;
            end
            
        end
    
%%%%%%%%%%%%%%%%%%    

        if(min(fr)<=0)
            disp('error ref 0');
            fr
            % return;
        end   
        
        [N]=slope_check(num,fr,r);
    
        if(max(N)<6)
            break;
        end
    
    end

     r=fix_size(r);
     fr=fix_size(fr);         
    
    if(min(fr)<=0)
        disp('error ref 1');
        fr
        % return;
    end    

    [f,srs_trial]=SRS_specification_interpolation_nw(fr,r,ioct);  

    if(min(f)<=0)
        disp('error ref 2');
        f
        return;
    end    
    
% scale

     

     nff=min([ length(srs_trial)  length(srs_in) ]);
     nf=nff;

     sc=ones(nf,1);
     
     try
         for j=1:nff
            if(srs_trial(j)<srs_in(j))
                sc(j)= srs_in(j)/srs_trial(j);     
            end    
         end
        
     catch

         out1=sprintf('nf=%d  length(srs_trial)=%d   length(srs_in)=%d  ',nf,length(srs_trial),length(srs_in));
         disp(out1);
         
         warndlg(' sc error');
         return;
     end
     

     max_sc=max(sc);
     
     if(max_sc>1)
     
        srs_trial=srs_trial*max_sc;
                r=r*max_sc;
             
     end           
          
     
% calculate PV

     

     nff=min([length(srs_trial) length(omegan)]);

     PV=zeros(nff,1);

     for j=1:nff
         
         PV(j)=386*srs_trial(j)/omegan(j);
         
     end
     
     PV_max=max(PV);
     
     ccc=r(1)*PV_max*max(r);
     
     error=zeros(nff,1);
     
     for j=1:nff
         error(j)=abs(20*log10( srs_in(j)/(max_sc*srs_trial(j))  ));        
     end
     

 %    error(1)=5*(error(1));
 %    error(2)=4*(error(2));
%     error(3)=3*(error(3));
 %    error(4)=2*(error(4));  
     
%     ccc=sqrt(sum(error))*max(error);
     % ccc=sum(error);  
     
     ccc=sum(error)*max(srs_trial);

         
     fig_num=77;
     md=6;
     x_label='Natural Frequency (Hz)';
     y_label='Peak Accel (G)';
    
     t_string=sprintf('SRS Q=%g  %s',Q,CT);

     f=fix_size(f);
     srs_in=fix_size(srs_in);
     srs_trial=fix_size(srs_trial);

     n=min([length(srs_in) length(f)]);
     
     ppp2=[f(1:n) srs_in(1:n)];
     ppp3=THFO;
     ppp1=[f srs_trial*mscale];
     fmin=f(1);
     fmax=f(end);
     leg3='original';
     leg2='widened';
     leg1='env trial';              
%%% 


     
     if(ccc<ccc_record || i==1)
     
         
     [fig_num,h2]=plot_loglog_function_md_three_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,leg1,leg2,leg3,fmin,fmax,md);
%
         
         ccc_record=ccc;
         

                         
         spec=[fr r*mscale];
         
         out1=sprintf('\n i=%d  PV_max=%8.4g  ccc=%8.4g  iflag=%d',i,PV_max,ccc,iflag);
         disp(out1);
         

         spec  
 
         
         frec=fr;
         arec=r;
         
%%         out1=sprintf('%8.4g %8.4g %8.4g',srs_trial(1),srs_in(1),max_sc);        
%%          disp(out1);
     end

% check for ccc_record
        
end




%%%%%%%%%    

function[fr,r]=gen_one(num,nf,f,srs_in,amax,iform)

    if(min(f)<=0)
        disp('in gen_one')
        min(f)
        return
    end    

    while(1)
            
        fr=zeros(num,1);
         r=zeros(num,1);
      
        for j=1:num
            
            ijk=1+ceil(nf*rand());
            
            if(ijk>nf)
                ijk=nf;
            end
            
            fr(j)=f(ijk);
 %            r(j)=amax*(rand())^3;
            [~,idx]=min(abs(fr(j)-f));
            r(j)=srs_in(idx)*(0.5+1.5*rand());

        end 

        
        
        fr=(sort(fr));
        fr(1)=f(1);
        fr(end)=f(nf); 
        
        if(length(fr)==num)
            
            qr=rand();
            
            for j=1:num
            
                [~,idx]=min(abs(fr(j)-f));
                if(qr<0.9)
                    r(j)=srs_in(idx)*(0.5+1.5*rand());
                else
                    r(j)=srs_in(idx)*(0.9+0.2*rand());                    
                end
            end               
            
            break;
        end
        
    end
    
    for i=1:length(fr)
        if(fr(i)>100)
            fr(i)=round(fr(i));
        end     
    end    
    
    [r]=amplitude_adjust_one(iform,r);

    if(r(1)>r(2))
        r(1)=r(2)/2;
    end 

    if(r(end)>r(end-1) && length(r)>8)
        r(end)=r(end-1);
    end  
    
%%%%%%%%%        
    
function[fr,r,kflag]=gen_two(nf,f,fr,frec,arec,num,iform)
         
    LF=length(fr);
        
    fr=zeros(LF,1);
     r=zeros(LF,1);
     
    try 

        kflag=0;    

        for ij=1:LF
            r(ij)=arec(ij)*(0.995+0.01*rand());        
        end
        for ij=2:LF-1
            fr(ij)=frec(ij)*(0.995+0.01*rand());     
        end       
        fr(1)=frec(1);
        fr(end)=frec(end);
  
    catch
 
        kflag=1;
        warndlg('error:  gen_two  in srs_envelope_engine.m ');
        return;
    end

    fr=sort(fr);
    fr(1)=f(1);
         
    fr(num)=f(nf);

    for i=1:length(fr)
        if(fr(i)>20)
            fr(i)=round(fr(i));
        end     
    end 

    if(min(fr)<=0)
        fr=frec;
    end    
    
    [r]=amplitude_adjust_two(iform,r);
        
    
%%%%%%%%%    
    
function[r]=amplitude_adjust_one(iform,r)
    
    if(iform==1)
        if(r(1)>r(2))
            r(1)=r(2)*rand();
        end
        r(end)=r(end-1);
    end      
    if(iform==2)
        r(end)=r(end-1);
    end     
    if(iform==3)
        r(3)=r(2);
        r(5)=r(4);        
    end 
    if(iform==4)
        r(4)=r(3);
    end       
    if(iform==5)
        r(5)=r(4);
    end          
    if(iform==6)
        r(6)=r(5);
    end  
    if(iform==7)
        r(3)=r(2);
        r(5)=r(4);
    end 
    if(iform==8)
        r(3)=r(2);
        r(5)=r(4);
        r(7)=r(6);
    end
    if(iform==9)
        r(3)=r(2);
        r(5)=r(4);
        r(7)=r(6);
        r(9)=r(8);
    end 
    if(iform==10)
        r(3)=r(2);
        r(5)=r(4);
        r(7)=r(6);
        r(9)=r(8);
        r(11)=r(10);     
    end   
    if(iform==11)
        r(3)=r(2);
        r(5)=r(4);
        r(7)=r(6);
        r(9)=r(8);
        r(11)=r(10);     
        r(13)=r(12);
    end     
    
%%%%%%%%%    
    
function[r]=amplitude_adjust_two(iform,r)
    
    if(iform==1)
        if(r(1)>r(2))
            r(1)=r(2)*rand();
        end
        r(end)=r(end-1);
    end      
    if(iform==2)
        r(end)=r(end-1);
    end     
    if(iform==3)
        r(3)=r(2);
        r(5)=r(4);        
    end 
    if(iform==4)
        r(4)=r(3);
    end       
    if(iform==5)
        r(5)=r(4);
    end          
    if(iform==6)
        r(6)=r(5);
    end  
    if(iform==7)
        r(3)=r(2);
        r(5)=r(4);
    end 
    if(iform==8)
        r(3)=r(2);
        r(5)=r(4);
        r(7)=r(6);
    end        
    if(iform==9)
        r(3)=r(2);
        r(5)=r(4);
        r(7)=r(6);
        r(9)=r(8);
    end  
    if(iform==10)
        r(3)=r(2);
        r(5)=r(4);
        r(7)=r(6);
        r(9)=r(8);
        r(11)=r(10);     
    end   
    if(iform==11)
        r(3)=r(2);
        r(5)=r(4);
        r(7)=r(6);
        r(9)=r(8);
        r(11)=r(10);
        r(13)=r(12);       
    end       
%%%%%    

function[N]=slope_check(num,fr,r)
    
        N=zeros(num-1,1);
        for jk=1:num-1
            N(jk)=log(r(jk+1)/r(jk))/log(fr(jk+1)/fr(jk));
        end
        
        N=abs(N);
    
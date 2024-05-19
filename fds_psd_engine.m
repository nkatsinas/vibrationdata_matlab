
% fds_psd_engine.m  ver 1.2  by Tom Irvine

function[fds_psd]=fds_psd_engine(fds_psd,THM,nf,nQ,Q,nbex,bex,fn,T)

yy=THM;

if(isempty(yy))
    warndlg('fds_engine:  yy empty');    
    return;
end


f=THM(:,1);
a=THM(:,2);

df=diff(f);

ratio=(max(df)-min(df))/max(df);


if(ratio>0.04 || mean(df)>=10)

    [s,~]=calculate_PSD_slopes(f,a);

    df=0.5;
    [fi,ai]=interpolate_PSD(f,a,s,df);
    
    base_psd=[fi ai];
else
    base_psd=[f a];
end

clear df;

progressbar;
    
    for j=1:nf
        
        progressbar(j/nf);
        
        ijk=1;
        
        for k=1:nQ
            
            damp=1/(2*Q(k));
            
% sdof psd response     

            [response_psd]=sdof_response_psd_engine(fn(j),damp,base_psd);
 
            for iv=1:nbex 
                
% Dirlik 
               b=bex(iv); 

               [damage,EP,m0]=Dirlik_response_psd(response_psd,b,T);
                
               fds_psd(j,ijk)=fds_psd(j,ijk)+damage;
               
               ijk=ijk+1;
               
            end
                       
        end
        
    end
    progressbar(1);



clear name;
clear output_name;

%%% names={ 't70313';'t70319';'t70307';'t70325'}

sarray=evalin('base','names');

for i=1:4
    
    ss=char(sarray(i,:));
    ssc=sprintf('%s_corrected',ss);
       
    THM=evalin('base',ss);
    
    [ccc]=correct_avd(THM);
    
    assignin('base',ssc, ccc); 
    
    aout=sprintf('%s.txt',ssc);
    
    save(aout,'ccc','-ASCII')
    
    sz=size(THM);
    ncol=sz(2);   
    
    for j=2:(ncol-4)
        
        sx=sprintf('%s_c%d',ss,(j-1));
        
        assignin('base',sx, [ccc(:,1) ccc(:,j)]); 
    end
    
end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[ccc]=correct_avd(THM)
    
    sz=size(THM);
    
    nrow=sz(1);    
    ncol=sz(2);

    dt=(THM(nrow,1)-THM(1,1))/(nrow-1);
    
    ccc=zeros(nrow,(ncol-4));
    
    ccc(:,1)=THM(:,1);
    
    tt=THM(:,1);
    
    for i=2:(ncol-4)
        
        [q]=avd_engine(dt,tt,THM(:,i));
        
        ccc(:,i)=q;
        
    end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[aa]=avd_engine(dt,tt,y)

    fc=3;
    
    num=length(y);

    y=detrend(y);      
    [y]=Butterworth_filter_highpass_function(y,fc,dt);  
    npe=2;
    [y]=half_cosine_fade_perc(y,npe);
 
    v=zeros(num,1);
    v(1)=y(1)*dt/2;
 
    for i=2:(num-1)
        v(i)=v(i-1)+y(i)*dt;
    end
    v(num)=v(num-1)+y(num)*dt/2;

    v=detrend(v);
    [v]=half_cosine_fade_perc(v,npe);

    d=zeros(num,1);
    d(1)=v(1)*dt/2;
 
    for i=2:(num-1)
        d(i)=d(i-1)+v(i)*dt;
    end
    d(num)=d(num-1)+v(num)*dt/2;
 
    d=fix_size(d);
    [d]=half_cosine_fade_perc(d,npe);
%
    n = 2;
    p = polyfit(tt,d,n);
    d= d - (  p(1)*tt.^2 + p(2)*tt + p(3));
    
    [d]=half_cosine_fade_perc(d,npe);

 %%%%%%%%%%%
    
    [vv]=differentiate_function(d,dt);
    [aa]=differentiate_function(vv,dt); 
    
end
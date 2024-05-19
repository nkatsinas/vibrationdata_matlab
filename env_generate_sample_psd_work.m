%
%   env_generate_sample_psd_work.m  ver 1.6   by Tom Irvine
%
%
%
function[f_sam,apsd_sam]=...
    env_generate_sample_psd_work(n_ref,nbreak,work,f_ref,slopec,initial,final,f1,f2,fn,peak)
%    
iflag=99;

%
f_sam=zeros(nbreak,1);
apsd_sam=zeros(nbreak,1);
%
% generate some random numbers for frequency
%

f1=work(1,1);
f4=work(2,1);
f5=work(3,1);
f6=work(4,1);

a5=work(3,2);
a6=work(4,2);

%
%
    f_sam(1)=f1;
    
    oo=2^(0.25+0.5*rand());
    
    f_sam(2)=fn(1)/oo;
    f_sam(3)=fn(1)*oo;
    f_sam(5)=f5;
    f_sam(6)=f6;
  
    f_sam=round(f_sam);
    
    dff=f4-f_sam(3);
    
    f_sam(4)=f_sam(3)+dff*(rand())^1.6;
    
    if( abs(f_sam(4)-f_sam(3))<10)
        f_sam(4)=f_sam(3)+dff/2;        
    end
    if( abs(f_sam(5)-f_sam(4))<10)
        f_sam(4)=f_sam(3)+dff/2;        
    end    
    
    
    f_sam=sort(f_sam);

    if(f_sam(1)<work(1,1))
        f_sam(1)=10;
    end
    
%%%%%

apsd_sam(end-2)=a5;
apsd_sam(end-1)=a5;
apsd_sam(end)=a6;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

s3=-2+7*rand();

den=(f_sam(4)/f_sam(3))^s3;
apsd_sam(3)=apsd_sam(4)/den;

apsd_sam(2)=apsd_sam(3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

s1=4*rand();

den=(f_sam(2)/f_sam(1))^s1;
apsd_sam(1)=apsd_sam(2)/den;

if(f_sam(2)==f_sam(1))
    f_sam(1)=[];
    apsd_sam(1)=[];
end    


%
%%%%%%%%%
%
%% for i=1:nbreak
%%    out1=sprintf(' %8.2f \t %8.4g ',f_sam(i),apsd_sam(i));
%%    disp(out1);
%% end    

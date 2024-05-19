

% srs_maximum_envelope.m  ver 1.0  by Tom Irvine

function[rec_new_spec,rec_kneef,plateau]=srs_maximum_envelope(fn,a_abs,NT,format)

errormax=1.0e+20;

num_fn=length(fn);

maxa=max(a_abs);

fmin=fn(1);
fmax=fn(num_fn);
df=fmax-fmin;

ioct=3;

if(format<=2)
    nsrs=3;
else
    nsrs=4;
end

fff=zeros(nsrs,1);
new_spec=zeros(nsrs,1);
rec_new_spec=zeros(nsrs,2);


for i=1:NT
    
    fff(1)=fn(1);
    new_spec(1)=a_abs(1)*(1+6*rand());
     
      
    if(i<50 || rand()<0.5)
        if(format<=2)
            fff(2)=fmin+rand()*df;
            fff(3)=fmax;
        else
            fff(1)=fn(1);
            fff(2)=fmin+rand()*df;
            fff(3)=fmin+rand()*df;         
            fff(4)=fmax;            
        end
        
        for jk=2:nsrs
            new_spec(jk)=maxa*(0.3+0.7*rand());  
        end
        
    else
        for jk=1:nsrs
            new_spec(jk)=rec_new_spec(jk)*(0.96+0.08*rand());
        end
        
        fff(2)=rec_fff(2)*(0.96+0.08*rand());
        
        if(format==3)
            fff(3)=rec_fff(3)*(0.96+0.08*rand());           
        end
        
    end
    
    if(format==1)
        new_spec(3)=new_spec(2);               
    end     
    
    for ik=1:nsrs
        if(fff(ik>fmax));
            fff(ik)=fmax;
        end
    end    
    
    fff(nsrs)=fmax;
    
    fff=sort(fff);
    
    [~,speci]=SRS_specification_interpolation_nw(fff,new_spec,ioct);
  
    
    error=0;    
    
    for j=1:num_fn
        
        ccc=20*log10(speci(j)/a_abs(j));
        error=error+abs(ccc);
        
    end

        
    if(new_spec(1)<=1.0e-20)
        warndlg(' new_spec(1) error ');
        return;
    end       
        
     
    if(error<errormax)
        out1=sprintf(' %d %8.4g',i,errormax);
        disp(out1);
        errormax=error;
        rec_new_spec=new_spec;
        rec_fff=fff;
        rec_speci=speci;
    end   

    
end

maxs=0;

for i=1:num_fn
    
   ccc=a_abs(i)/rec_speci(i);
   
   if(ccc>maxs)
       maxs=ccc;
   end
   
end


if(maxs>0)
    rec_new_spec=rec_new_spec*maxs;
end


rec_new_spec=[rec_fff rec_new_spec];
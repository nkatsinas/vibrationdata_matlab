
% simple_srs_engine_function.m  ver 1.0  by Tom Irvine

function[abs_accel_data,xmax,xmin]=...
                    simple_srs_engine_function(yy,fn,dt,res,a1,a2,b1,b2,b3)


num=length(fn);

NL=length(yy);

a_pos=zeros(num,1);
a_neg=zeros(num,1);



for j=1:num
%
    if(res==1)
        
        ML=NL;
        
        try
            ML=NL+round((1/fn(j))/dt);
        catch
        end
        
%        out1=sprintf(' %d  %d  %d  %8.4g  %8.4g ',j,NL,ML,fn(j),dt);
%        disp(out1);
        
        ys=zeros(ML,1);
        
        ys(1:NL)=yy;
    else
        ys=yy;
    end
%
    forward=[ b1(j),  b2(j),  b3(j) ];    
    back   =[     1, -a1(j), -a2(j) ];
%    
    a_resp=filter(forward,back,ys);
%
    a_pos(j)= max(a_resp);
    a_neg(j)= min(a_resp);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

end
%

%
a_neg=abs(a_neg);


a_pos=fix_size(a_pos);
a_neg=fix_size(a_neg);

%
accel_data=[a_pos a_neg];

abs_accel_data=zeros(num,1);

for i=1:num
       abs_accel_data(i)= max([a_pos(i) a_neg(i)]);
end    


xmax=a_pos;
xmin=a_neg;
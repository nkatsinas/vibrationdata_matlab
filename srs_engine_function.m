
% srs_engine_function.m  ver 1.0  by Tom Irvine

function[abs_accel_data,abs_p_vel_data,abs_rel_disp_data,...
                                  accel_data,p_vel_data,rel_disp_data]=...
                                  srs_engine_function(yy,fn,damp,dt,iu,res)

[a1,a2,b1,b2,b3,rd_a1,rd_a2,rd_b1,rd_b2,rd_b3]=...
                                   srs_coefficients(fn,damp,dt);

num=length(fn);

NL=length(yy);

a_pos=zeros(num,1);
a_neg=zeros(num,1);

rd_pos=zeros(num,1);
rd_neg=zeros(num,1);

pv_pos=zeros(num,1);
pv_neg=zeros(num,1);


progressbar;
for j=1:num
%
    progressbar(j/num); 
%
    if(res==1)
        ML=NL+round((1/fn(j))/dt);
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
    rd_forward=[ rd_b1(j),  rd_b2(j),  rd_b3(j) ];    
    rd_back   =[     1, -rd_a1(j), -rd_a2(j) ];      
%    
    rd_resp=filter(rd_forward,rd_back,ys);
%
    if(iu==1)
        rd_resp=rd_resp*386;
    end
    if(iu==2)
        rd_resp=rd_resp*9.81*1000;        
    end
%
    rd_pos(j)= max(rd_resp);
    rd_neg(j)= min(rd_resp);
%
    omegan=2*pi*fn(j);
%
    pv_pos(j)=omegan*rd_pos(j);
    pv_neg(j)=omegan*rd_neg(j);
%
end
%
pause(0.3);
progressbar(1);
%
a_neg=abs(a_neg);
pv_neg=abs(pv_neg);
rd_neg=abs(rd_neg);
%
if(iu==2)
   pv_pos=pv_pos/1000;
   pv_neg=pv_neg/1000;
end

a_pos=fix_size(a_pos);
a_neg=fix_size(a_neg);
pv_pos=fix_size(pv_pos);
pv_neg=fix_size(pv_neg);
rd_pos=fix_size(rd_pos);
rd_neg=fix_size(rd_neg);
%
accel_data=[a_pos a_neg];
p_vel_data=[pv_pos pv_neg];
rel_disp_data=[rd_pos rd_neg];


abs_accel_data=zeros(num,1);
abs_p_vel_data=zeros(num,1);
abs_rel_disp_data=zeros(num,1);


for i=1:num
       abs_accel_data(i)= max([a_pos(i) a_neg(i)]);
       abs_p_vel_data(i)= max([pv_pos(i) pv_neg(i)]);
    abs_rel_disp_data(i)= max([rd_pos(i) rd_neg(i)]);
end    

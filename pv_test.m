
clear d;

acc=evalin('base','response');
vel=evalin('base','integrated_signal');
rd=evalin('base','rd_response');
white=evalin('base','white');

omegan=2*pi*600;

dt=mean(diff(acc(:,1)));

b=4;

% method 1   integrated velocity

x=vel(:,2)*386;
c=rainflow(x);
cycles=c(:,1);
amp=c(:,2)/2;
d(1)=sum( cycles.*amp.^b );


% method 2   accel / omegan

x=386*acc(:,2)/omegan;
c=rainflow(x);
cycles=c(:,1);
amp=c(:,2)/2;
d(2)=sum( cycles.*amp.^b );


% method 3   diff velocity

y=rd(:,2);
[x]=differentiate_function(y,dt);
c=rainflow(x);
cycles=c(:,1);
amp=c(:,2)/2;
d(3)=sum( cycles.*amp.^b );

% method 4  rd*omegan

x=rd(:,2)*omegan;
c=rainflow(x);
cycles=c(:,1);
amp=c(:,2)/2;
d(4)=sum( cycles.*amp.^b );

%
f=600;
damp=0.05;

[a1,a2,b1,b2,b3,rd_b1,rd_b2,rd_b3,rv_b1,rv_b2,rv_b3,ra_b1,ra_b2,ra_b3]=...
                                      srs_coefficients_base(f,damp,dt);

y=white(:,2)*386;

    forward=[ rv_b1,  rv_b2,  rv_b3 ];    
    back   =[  1, -a1, -a2 ];    
    x=filter(forward,back,y);

c=rainflow(x);
cycles=c(:,1);
amp=c(:,2)/2;
d(5)=sum( cycles.*amp.^b );


for i=1:5
    fprintf(' %d  %8.4g  \n',i,d(i));
end





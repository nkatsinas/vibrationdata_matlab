

[fn10,~,ModeShapes10,MST]=Generalized_Eigen(stiffr,mr,2);





[fn6,~,ModeShapes6,MST]=Generalized_Eigen(k_fixed_free,m_fixed_free,2);


sz=size(accel10);

nrows=sz(1);
ncols=sz(2);


delta_accel_2a=zeros(nrows,ncols);

delta_accel_2a(:,1)=accel10(:,1);




for i=1:nrows
    
%       10x4      4 x 1

    term=psi*accel10(i,(ncols-3):ncols)'; 
    
    term=term';
    
    for j=2:ncols
         
        delta_accel_2a(i,j)=accel10(i,j) - term(1,j-1);
        
    end
   
    
end    

figure(10);
plot(delta_accel_2a(:,1),delta_accel_2a(:,2),accel6(:,1),accel6(:,2));
grid on;
xlabel('Time (sec)');

figure(11);
plot(delta_accel_2a(:,1),delta_accel_2a(:,3),accel6(:,1),accel6(:,3));
grid on;
xlabel('Time (sec)');

figure(12);
plot(delta_accel_2a(:,1),delta_accel_2a(:,11),accel10(:,1),accel10(:,11));
grid on;
xlabel('Time (sec)');


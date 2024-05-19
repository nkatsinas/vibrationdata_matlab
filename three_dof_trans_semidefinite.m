
% three_dof_trans_semidefinite.m  ver 1.0  by Tom Irvine

function[a_f_mag,v_f_mag,d_f_mag]=three_dof_trans_semidefinite(QE,fnv,freq,dampv,scale,amp)

    k=1;

    tpi=2*pi;

    num=length(freq);

    H=zeros(num,3);
    HM_accel=zeros(num,3);

    d_f_mag=zeros(num,3);
    v_f_mag=zeros(num,3);
    a_f_mag=zeros(num,3);

    omn=tpi*fnv;
    omn2=omn.^2;

            for i=1:3

                for j=1:num

                    omega=tpi*freq(j);
                    omega2=omega^2;

                    for r=2:3  % natural frequency loop
           
                    %
                        rho=freq(j)/fnv(r);
                        den=1-rho^2+(1i)*2*dampv(r)*rho;
                    %
                        if(abs(den)<1.0e-20)
                            warndlg(' den error ');
                            return;
                        end
                 
                    %
                        term=omega2*(QE(i,r)*QE(k,r)/den)/omn2(r);               
                              
                        H(j,i)=H(j,i)+term;                
                    %
                     
                    end   

                    
                    HM_accel(j,i)=abs(H(j,i)/H(j,1));
                    a_f_mag(j,i)=amp*HM_accel(j,i);
    
                    v_f_mag(j,i)= a_f_mag(j,i)/omega;
                    d_f_mag(j,i)= a_f_mag(j,i)/omega2;

                end
            
            end    

            d_f_mag=d_f_mag*scale;
            v_f_mag=v_f_mag*scale;
%
%    Holzer_torque_core.m  ver 1.0  by Tom Irvine
%
function[Tb,top,kv]=...
         Holzer_torque_core(kv,ibc,idisks,omega,omega_before,T,Tb,FINE,n,j,k,x)
%
top=0;
%
temp2=T;
%
if(n>=2 && kv<=idisks)
%
    if(T*Tb < 0. )
%
        Trecord =9.0e+100;
%
        omrecord = 0.;
%
        delta=omega-omega_before; 
%
		omega=omega_before;
%
		dd=delta/FINE;

		for ij=0:FINE
%
            [T,x]=Holzer_choice2(ibc,idisks,j,k,omega);
%
			if(abs(T)<Trecord)

				Trecord=abs(T);

                omrecord = omega;

			end

			omega=omega+dd;

		end

		omega=omrecord;

        [T,x]=Holzer_choice2(ibc,idisks,j,k,omega);

        [top]=Holzer_printvector(kv,ibc,idisks,omega,x);

		kv=kv+1;

	end

	if(T*Tb == 0. && Tb ~=0.)

		out1=sprintf('z  om=%12.4g  T=%12.4g\n',omega,T);
        disp(out1);
         
        [top]=Holzer_printvector(kv,ibc,idisks,omega,x);

		kv=kv+1;
	end

end

Tb=temp2;

% BeamTransCore_alt.m  ver 1.0 by Tom Irvine

function[HM_accel_left,HM_accel_response,HM_accel_right,HM_rd_left,HM_rd_response,HM_rd_right,adisp]=...
                BeamTransCore_alt(nff,np,num,nem,dm,pMST,num_columns,pomn2,om2,pomegan,...
                omega,TT,pdof,Mwd,pModeShapes,ngw,response_dof)
            
            N=zeros(nff,np);

            adisp=zeros(np,num);
            acc=zeros(np,num);
            rel_disp=zeros(np,num);
 
%            fprintf('\n nem=%d  length(dm)=%d \n\n',nem,length(dm));

            y=ones(nem,1);
            
            A=-pMST*Mwd*y;
                
            nk=min([ length(A) length(dm) num_columns]);
            %
            for i=1:nk  % number of included modes
                for k=1:np
                    N(i,k)=A(i)/(pomn2(i)-om2(k) + (1i)*2*dm(i)*pomegan(i)*omega(k));
                end
            end
            %
            Ud=zeros(nem,np); 
            for i=1:np  % convert acceleration input to displacement
                Ud(:,i)=1/(-om2(i));
            end
            %
            % disp('ModeShapes');
            size(pModeShapes);
                
            Uw=pModeShapes*N;
            %
            Udw=[Ud; Uw];
            %
            U=TT*Udw;
            %
            %   Fix order
            %
            for i=1:num
                for j=1:np
                    adisp(j,ngw(i))=U(i,j);
                    acc(j,ngw(i))=om2(j)*abs(U(i,j));
                    rel_disp(j,ngw(i))=U(i,j)-Ud(1,j);
                end        
            end
            
            HM_accel_left=zeros(np,1);
            HM_accel_response=zeros(np,1);
            HM_accel_right=zeros(np,1);
            
            HM_rd_left=zeros(np,1);
            HM_rd_response=zeros(np,1);
            HM_rd_right=zeros(np,1);

            for j=1:np      
                HM_accel_left(j) =acc(j,1);
                HM_accel_response(j)  =acc(j,response_dof);   
                HM_accel_right(j)=acc(j,(pdof-1));     
                HM_rd_left(j)    =rel_disp(j,1);
                HM_rd_response(j)     =rel_disp(j,response_dof);   
                HM_rd_right(j)   =rel_disp(j,(pdof-1));          
            end
 
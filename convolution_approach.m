  %
            app.acc_trans=zeros(app.np,num_Tz);
            app.pv_trans=zeros(app.np,num_Tz);
            app.rd_trans=zeros(app.np,num_Tz);
            app.stress_trans=zeros(app.np,num_Tz);
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            damp=app.dm;
            
            fprintf('\n\n  app.np=%d  iaa=%d  ibb=%d \n\n',app.np,iaa,ibb);

            progressbar;

            for k=1:app.np  % for each excitation frequency
               
                progressbar((k-1)/app.np);

                for i=iaa:ibb  % mode number

                    N(i)=A(i)/(omn2(i)-om2(k) + (1i)*2*damp(i)*app.omegan(i)*app.omega(k));
                end
                
                Ud=zeros(app.nem,1); 
                for i=1:app.nem  % convert acceleration input to displacement
                    Ud(i)=1/(-om2(k));
                end
            %
                Uw=app.ModeShapes*N;   
            
                Udw=[Ud; Uw];
            %
                U=app.TT*Udw;    
                
                nu=length(U);
                
                if(k==1)
            %        fprintf(' nu=%d num_elem=%d  num_nodes_Tz_free=%d\n',nu,num_elem,num_nodes_Tz_free);
            %        ngw
                end
                
                Ur=zeros(nu,1);
                
                Ur(app.ngw(1:nu)) = U(1:nu);

                num_elem=app.ne;
                
                if(k==1)
                    num_nodes=num_elem+1;
            %       total_dof=num_nodes*2;
                
                    R_tracking_array=zeros(num_nodes,1);
            
            %        rot_dof;  
                    num_Ur=length(Ur);
                
                    app.rot_constraint_matrix=app.constraint_matrix;
                
            %        constraint_matrix;
                
                    length(app.constraint_matrix(:,1))
                
                    for i=length(app.constraint_matrix(:,1)):-1:1
                        if(app.constraint_matrix(i,3)==0)
                            app.rot_constraint_matrix(i,:)=[];
                        end
                    end
                
                    bbb=(1:num_Ur);
                
                    for i=1:num_Tz
                        [Lia,Locb] =ismember(app.TZ_tracking_array,bbb);
                        if(Lia==1)
                            bbb(Locb)=[];
                        end
                    end
                
            %%        fprintf(' num_nodes=%d  num_Ur=%d \n',num_nodes,num_Ur);
                    ccc=app.rot_constraint_matrix(:,1);
                    
                    kv=1;
                    for jj=1:num_nodes    
                        if(ismember(jj,ccc))
            %                fprintf(' jj=%d  included \n',jj);
                        else    
            %                fprintf(' jj=%d  kv=%d \n',jj,kv);
                            R_tracking_array(jj)=bbb(kv);
                            kv=kv+1;
                        end
                    end
                end

                for jk=1:num_Tz
                    node=jk;    
                    ij=app.TZ_tracking_array(node);
                    app.acc_trans(k,jk)=om2(k)*Ur(ij);
                    app.rd_trans(k,jk)=Ur(ij)-Ud(1);
                end
                
                for nk=1:num_nodes-1
                
                    left_node=nk;
                    right_node=nk+1;
            
                    LL=abs(app.xx(left_node)-app.xx(right_node));
                    
                    [B]=beam_stress_B(0,LL);
                    
                    TL=app.TZ_tracking_array(left_node);
                    TR=app.TZ_tracking_array(right_node);
                    
                    URL=0;
                    URR=0;
                    
                    if(R_tracking_array(left_node)~=0)
                        RL=R_tracking_array(left_node);
                        URL=Ur(RL);
                    end
                    if(R_tracking_array(right_node)~=0)
                        RR=R_tracking_array(right_node);
                        URR=Ur(RR);            
                    end
                     
                     d=transpose([Ur(TL) URL Ur(TR) URR]);
            
            %       if(k==1)
            %           fprintf('nk=%d  %d %d %d %d   \n',nk,TL,RL,TR,RR);
            %            fprintf('  %8.4g  %8.4g  %8.4g  %8.4g \n\n',d(1),d(2),d(3),d(4));
            %            B
            %        end
            
                        app.stress_trans(k,nk)=app.cna*app.E*B*d; 
                        
                       QQQ=1; 
                       if(k==jnear  && QQQ==1)
            %                 dzL=Ur(TL);
            %                 ryL=URL; 
            %                 dzR=Ur(TR); 
            %                 ryR=URR; 
                             app.s1=app.stress_trans(k,nk);
            %                 fprintf('\n\n nk=%d \n\n',nk);
            %                 fprintf(' cna=%g  E=%7.3g  s1=%8.4g \n',cna,E,s1*386);
            %                 fprintf('B  %7.3g  %7.3g\n',real(B(1)*dzL),imag(B(1)*dzL));
            %                 fprintf('B  %7.3g  %7.3g\n',real(B(2)*ryL),imag(B(2)*ryL));
            %                 fprintf('B  %7.3g  %7.3g\n',real(B(3)*dzR),imag(B(3)*dzR));
            %                 fprintf('B  %7.3g  %7.3g\n',real(B(4)*ryR),imag(B(4)*ryR));   
            %                 cna*E*B*d
            %                transpose([Ur(TL) URL Ur(TR) URR]);
                        end
                    
                end
                
            % stress at right end  
                app.stress_trans(k,end)=app.stress_trans(k,end-1);
                
            end

            progressbar(1);


            app.pv_trans = app.rd_trans .* (2 * pi * app.freq);

           % disp('Arb')

            if(isempty(app.omegan) || length(app.omegan)<=1)
                warndlg('Calculate Natural Frequencies first');
                return;
            end    

            if(isempty(app.dm))
                warndlg('Save damping first');
                return;
            end            

            app.fig_num=1;

            app.num_nodes_Tz_free=round(app.dof/2);
            
            % app.dm

            num_Tz=length(app.TZ_tracking_array);
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            %%%  need to cleanup
            
            sz=size(app.Mww);
            app.nff=sz(1);
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            app.omegan=2*pi*app.fn;

            %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            tt=app.THM(:,1);
            yy=app.THM(:,2);
            
            app.dt=mean(diff(tt));

            app.sr=1/app.dt;

            T=1/app.fn(1);
            dur=40*T;

            numt=round(dur/app.dt);

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            num_modes_include=str2num(app.NumberofModestoIncludeListBox.Value);
            
            ibb=num_modes_include;
                  
            if(app.nff> num_modes_include)
                app.nff=num_modes_include;
            end 

            Q=app.ModeShapes(:,1:ibb);
            
            %

            app.y=ones(app.nem,1);
            
            try
                A=-app.MST*app.Mwd*app.y;
            catch
                app.nem
                size(app.MST)
                size(app.Mwd)
                warndlg('Error:  ref 1')
                return;
            end

            clear t;

            t=(0:(numt-1))*app.dt;


            t=fix_size(t);

            h=zeros(numt,ibb);

            app.kk=0;

            app.qflag=0;

            for i=1:ibb

                if(app.fn(i)>app.sr/10)
                    app.qflag=1;
                    break;
                end    

                app.kk=app.kk+1;

                domegan=app.dm(i)*app.omegan(i);
                omd=app.omegan(i)*sqrt(1-app.dm(i)^2);

                for j=1:numt
                    h(j,i)=(A(i)/omd)*exp(-domegan*t(j))*sin(omd*t(j));
                end    
            end  

            N=h;

            Uw=Q*N'; 

            Ud=zeros(app.nem,numt); 

            Udw=[Ud; Uw];

            U=app.TT*Udw;    
                
            nu=length(U(:,1));


            Ur=zeros(nu,numt);
                
            Ur(app.ngw(1:nu),:) = U(1:nu,:);

            num_elem=app.ne;

            num_nodes=num_elem+1;
            %       total_dof=num_nodes*2;
                
            R_tracking_array=zeros(num_nodes,1);
            
            %        rot_dof;  
                    num_Ur=length(Ur(:,1));
                
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
       

                impulse_response=zeros(numt,num_nodes);

                for jk=1:num_Tz
                    node=jk;    
                    ij=app.TZ_tracking_array(node);
                    impulse_response(:,jk)=Ur(ij,:)';
                end
                
         
            xr=str2num(app.ResponseLocationfromLeftEndEditField.Value);

            [~,app.node_near]=min(abs(app.xx-xr));

            hd=impulse_response(:,app.node_near);

            hdd=hd/length(hd);

            tic
            cc=conv(yy,hdd);
            toc
            if(app.iu==1)
                cc=cc*386;
            end

            [cc_pv]=differentiate_function(cc,app.dt);
            [cc_a]=differentiate_function(cc_pv,app.dt);

            cc_a=cc_a/app.scale;

            cc=fix_size(cc);
            cc_pv=fix_size(cc_pv);
            cc_a=fix_size(cc_a);

            cc_a(1:length(yy))=cc_a(1:length(yy))+yy;

            tc=(0:length(cc)-1)*app.dt;

            tc=fix_size(tc);

            xq=app.xx(app.node_near);

            num_nodes=app.ne+1;

            if(app.node_near==1)

            end
            if(app.node_near>1 && app.node_near<num_nodes)

            end
            if(app.node_near==num_nodes)

            end

            
            %
            figure(app.fig_num);
            app.fig_num=app.fig_num+1;
            plot(t,hd);
            grid on;
            xlabel('Time(sec)');
            title(sprintf('Impulse Response Function at %7.3g %s',xq,app.LU));
            %
            figure(app.fig_num);
            app.fig_num=app.fig_num+1;
            plot(tc,cc);
            grid on;
            xlabel('Time(sec)');        
            ylabel(sprintf('Rel Disp (%s)',app.LU));
            title(sprintf('Relative Displacement Response at %7.3g %s',xq,app.LU));
            %
            figure(app.fig_num);
            app.fig_num=app.fig_num+1;
            plot(tc,cc_pv);
            grid on;
            xlabel('Time(sec)');        
            ylabel(sprintf('Vel (%s)',app.LV));
            title(sprintf('Pseudo Velocity Response at %7.3g %s',xq,app.LU));
            %
            figure(app.fig_num);
            app.fig_num=app.fig_num+1;
            plot(tc,cc_a);
            grid on;
            xlabel('Time(sec)');        
            ylabel('Accel (G)');
            title(sprintf('Acceleration Response at %7.3g %s',xq,app.LU));
            %

        end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        function pre_trans_sine(app) 

            app.omegan=2*pi*app.fn;
            omn2=app.omegan.^2;

            if(isempty(app.omegan) || length(app.omegan)<=1)
                warndlg('Calculate Natural Frequencies first');
                return;
            end    

            if(isempty(app.dm))
                warndlg('Save damping first');
                return;
            end       

            app.freq=str2num(app.ExcitationFreqHzEditField.Value);
            app.omega=2*pi*app.freq;
            base=str2num(app.BaseAccelerationGEditField.Value);

            app.np=length(app.freq);

            app.num_nodes_Tz_free=round(app.dof/2);
            
            % app.dm

            num_Tz=length(app.TZ_tracking_array);
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            %%%  need to cleanup
            
            sz=size(app.Mww);
            app.nff=sz(1);
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            om2=app.omega.^2;
            
            %
            [~,jnear]=min(abs(app.omegan(1)-app.omega));
            
            N=zeros(app.nff,1);
            %
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            num_modes_include=str2num(app.NumberofModestoIncludeListBox.Value);
            
            iaa=1;
            ibb=num_modes_include;
                  
            if(app.nff> num_modes_include)
                app.nff=num_modes_include;
            end    
            
            %
            app.y=ones(app.nem,1);
            
            try
                A=-app.MST*app.Mwd*app.y;
            catch
                app.nem
                size(app.MST)
                size(app.Mwd)
                size(app.y)
                warndlg('Error:  ref 1')
                return;
            end
            %
            app.acc_trans=zeros(app.np,num_Tz);
            app.pv_trans=zeros(app.np,num_Tz);
            app.rd_trans=zeros(app.np,num_Tz);
            app.stress_trans=zeros(app.np,num_Tz);
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            damp=app.dm;
            
            fprintf('\n\n  app.np=%d  iaa=%d  ibb=%d \n\n',app.np,iaa,ibb);

            for k=1:app.np  % for each excitation frequency
                
                for i=iaa:ibb  % modal frequencies

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
                    app.acc_trans(k,jk)=om2(k)*abs(Ur(ij));
                    app.rd_trans(k,jk)=abs(Ur(ij)-Ud(1));
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
            
                        app.stress_trans(k,nk)=abs(app.cna*app.E*B*d); 
                        
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

            app.pv_trans = app.rd_trans .* (2 * pi * app.freq);

            %%%%%%%%%%%%%%%%

            [~,column_a,max_a]=find_max_2d_array(app.acc_trans);
            app.ppp_a=[app.freq app.acc_trans(:,column_a)];

            app.pv_trans=app.scale*app.pv_trans;
            [~,column_pv,max_pv]=find_max_2d_array(app.pv_trans);
            app.ppp_pv=[app.freq app.pv_trans(:,column_pv)];

            app.rd_trans=app.scale*app.rd_trans;
            [~,column_rd,max_rd]=find_max_2d_array(app.rd_trans);
            app.ppp_rd=[app.freq app.rd_trans(:,column_rd)];

            app.stress_trans=app.scale*app.stress_trans;
            [~,column_st,max_st]=find_max_2d_array(app.stress_trans);
            app.ppp_st=[app.freq app.stress_trans(:,column_st)];

            %%%%%%%%%%%%%%%%%

            fprintf('\n Max Values \n');

            fprintf('          Acceleration Trans = %8.4g G/G \n',max_a);

            if(app.iu==1)
                fprintf('       Pseudo Velocity Trans = %8.4g ips/G \n',max_pv);
                fprintf(' Relative Displacement Trans = %8.4g in/G \n',max_rd);
                fprintf('                Stress Trans = %8.4g psi/G \n',max_st);  
            else
                fprintf('       Pseudo Velocity Trans = %8.4g m/sec/G \n',max_pv);
                fprintf(' Relative Displacement Trans = %8.4g m/G \n',max_rd);
                fprintf('                Stress Trans = %8.4g Pa/G \n',max_st); 
            end


            max_a=base*max_a;
            max_pv=base*max_pv;
            max_rd=base*max_rd;
            max_st=base*max_st;


            if(app.iu==1)
                ss1=sprintf(' Accel = %8.4g G \n',max_a);
                ss2=sprintf(' Pseudo Vel = %8.4g in/sec \n',max_pv);
                ss3=sprintf(' Rel Disp = %8.4g in \n',max_rd);
                ss4=sprintf(' Stress = %8.4g psi \n',max_st);
            else
                ss1=sprintf(' Accel = %8.4g G \n',max_a);
                ss2=sprintf(' Pseudo Vel = %8.4g m/sec \n',max_pv);
                ss3=sprintf(' Rel Disp = %8.4g m \n',max_rd);
                ss4=sprintf(' Stress = %8.4g Pa \n',max_st);
            end    

            ss=sprintf('Maximum Values \n\n %s %s %s %s ',ss1,ss2,ss3,ss4);

            if(app.chplot>=2)

                xr=str2num(app.ResponseLocationfromLeftEndEditField.Value);
                [~,app.node_near]=min(abs(app.xx-xr));

                x_a=app.acc_trans(app.node_near);
                x_pv=app.pv_trans(app.node_near);
                x_rd=app.rd_trans(app.node_near);
                x_st=app.stress_trans(app.node_near);

               

                xq=app.xx(app.node_near);

                if(app.iu==1)
                    ss5=sprintf(' Accel = %8.4g G \n',x_a);
                    ss6=sprintf(' Pseudo Vel = %8.4g in/sec \n',x_pv);
                    ss7=sprintf(' Rel Disp = %8.4g in \n',x_rd);
                    ss8=sprintf(' Stress = %8.4g psi \n',x_st);
                    ss=sprintf('%s \n\n  Values at %7.3g in \n\n %s %s %s %s',ss,xq,ss5,ss6,ss7,ss8);
                else
                    ss5=sprintf(' Accel = %8.4g G \n',x_a);
                    ss6=sprintf(' Pseudo Vel = %8.4g m/sec \n',x_pv);
                    ss7=sprintf(' Rel Disp = %8.4g m \n',x_rd);
                    ss8=sprintf(' Stress = %8.4g Pa \n',x_st);
                    ss=sprintf('%s \n\n  Values at %7.3g in \n\n %s %s %s %s',ss,xq,ss5,ss6,ss7,ss8);
                end    

            end    

           
            app.ResultsTextArea.Value=ss;
            app.ResultsTextArea.Visible='on';
            app.ResultsTextAreaLabel.Visible='on';    

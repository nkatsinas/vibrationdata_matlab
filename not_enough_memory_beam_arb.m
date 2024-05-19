
            clear app.acc;
            clear app.na;

            app.fig_num=1;

            app.THM=single(app.THM);

            NT=length(app.THM(:,1));
            app.nt=NT;

            EA=app.THM;
            
            dur=EA(NT,1)-EA(1,1);
            app.dt=dur/(NT-1);
            
            fprintf(' NT=%d  dur=%8.4g sec  app.dt=%8.4g sec \n',NT,dur,app.dt); 

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
  
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            app.number_modes=str2num(app.NumberofModestoIncludeListBox.Value);
            
 
                  
            if(app.nff> app.number_modes)
                app.nff=app.number_modes;
            end    
            
            %
            

            Q=app.ModeShapes(:,1:app.number_modes);
            QT=Q';

            ff=zeros(app.nem,1);

            progressbar;

            progressbar(0.05);

            QTMwd=QT*app.Mwd;
            
            f=app.THM(:,2);

            [dvelox]=integrate_function(f,app.dt);
            [app.ddisp]=integrate_function(dvelox,app.dt);

            for i=1:length(f)
                ff(1:app.nem,i)=f(i);
            end

            fin=ff;

            FP=-QTMwd*ff;

            app.np=NT;

            %
            app.acc=zeros(app.np,num_Tz);
            app.pv=zeros(app.np,num_Tz);
            app.rd=zeros(app.np,num_Tz);
            app.stress=zeros(app.np,num_Tz);
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            try
                [a1,a2,df1,df2,df3,~,~,~,af1,af2,af3]=...
                          ramp_invariant_filter_coefficients(app.number_modes,app.omegan,app.dm,app.dt);

            catch
                app.number_modes
                app.omegan
                app.dm
                app.dt
                return
            end    

            nx=zeros(app.np,app.number_modes);
            app.na=zeros(app.np,app.number_modes);

            for j=1:app.number_modes  % mode number

                amodal=FP(j,:);
            %
            %  displacement
            %
                d_forward=[   df1(j),  df2(j), df3(j) ];
                d_back   =[     1, -a1(j), -a2(j) ];
                d_resp=filter(d_forward,d_back,amodal);
            %       
            %  acceleration
            %   
                a_forward=[   af1(j),  af2(j), af3(j) ];
                a_back   =[     1, -a1(j), -a2(j) ]; 
                a_resp=filter(a_forward,a_back,amodal);
            %
                nx(:,j)=d_resp;  % displacement
                app.na(:,j)=single(a_resp);  % acceleration  
            %

            end

            size(app.na)

            progressbar(0.25);

            %
            clear amodal;
            clear FP;
            clear d_resp;
            clear a_resp;
            
            disp(' Calculate a');

            fprintf('\n app.number_modes=%d \n',app.number_modes);
            fprintf('app.nt=%d \n',app.nt);
            fprintf('app.nem=%d \n',app.nem);            
            
            szQ=size(Q);

            d=zeros(szQ(1),app.nt);
            a=single(zeros(szQ(1),app.nt));

            try
                d(:,:)=(Q*(nx(:,:))');
            catch
                size(d)
                size(Q)
                size(nx)
                warndlg('d failure')
                return;
            end
            clear nx;

            progressbar(0.3);
            
            disp(' Calculate d');
            a(:,:)=single((Q*(app.na(:,:))')); 
            clear app.na;

            progressbar(0.4);
 
            %%%%  

            d=d';
            a=a';
            
            disp(' Transformation a  ');

            size(fin)
            size(a)
            
            Adw=single([fin' a]);
            
            sz=size(Adw)
            mqq=sz(2)
            
            A=single(zeros(app.nt,mqq));
            D=single(zeros(app.nt,mqq));

            A(:,:)=single((app.TT*Adw(:,:)')');
            clear Adw;

            progressbar(0.5);
            
            disp(' Transformation d '); 

            Ddw=[app.ddisp d];

            size(app.TT)
            size(Ddw)
            
            D(:,:)=(app.TT*Ddw(:,:)')';
            clear Ddw;

            progressbar(0.6);

            app.acc=zeros(app.nt,mqq);
            app.ddd=zeros(app.nt,mqq);
            
            disp(' Sort  A'); 
            app.acc(:,app.ngw(:))=A(:,:);
            clear A;
            
            disp(' Sort  D'); 
            app.ddd(:,app.ngw(:))=D(:,:);
            clear D;

            progressbar(0.7);   

            num_elem=app.ne;
                
            num_nodes=num_elem+1;
            %       total_dof=num_nodes*2;
                
            R_tracking_array=zeros(num_nodes,1);
            
            %        rot_dof;

            Ar=app.acc;
            num_Ar=length(Ar(1,:));
                
            app.rot_constraint_matrix=app.constraint_matrix;
                
            %        constraint_matrix;
                
            length(app.constraint_matrix(:,1))
                
            for i=length(app.constraint_matrix(:,1)):-1:1
                if(app.constraint_matrix(i,3)==0)
                    app.rot_constraint_matrix(i,:)=[];
                end
            end
                
            bbb=(1:num_Ar);
                
            for i=1:num_Tz
                [Lia,Locb] =ismember(app.TZ_tracking_array,bbb);
                if(Lia==1)
                    bbb(Locb)=[];
                end
            end
                
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

            app.np
            num_Tz
            size(app.acc)
            size(Ar)

            for k=1:app.np
                for jk=1:num_Tz
                    node=jk;    
                    ij=app.TZ_tracking_array(node);
                    try
                        app.acc(k,jk)=Ar(k,ij);
                    catch
                        fprintf('\n k=%d  jk=%d  ij=%d \n',k,jk,ij);
                        disp('ref 3')
                        return;
                    end 
                end
            end
        

            if(app.iu==1)
               app.ddd=app.ddd*386;
               app.ddisp=app.ddisp*386;
            else
               app.ddd=app.ddd*9.81;
               app.ddisp=app.ddisp*9.81;
            end    
            
            progressbar(0.75); 
            progressbar(1);
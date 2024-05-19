                
% sine_sweep_trans  ver 1.0  by Tom Irvine

function[f,trans,phase]=sine_sweep_transw(THM,a_resp,ijk,nnum)


                a=THM(:,2);
                b=a_resp;

                dt=mean(diff(THM(:,1)));

                nt=length(a);
                
                %
                %   positive slope zero crossing times for input
                %
                tindex=zeros(nt,1);
                tz=zeros(nt,1);

                t=THM(:,1);
                
                k=1;
                for i=2:nt
                    if( a(i) > a(i-1) && a(i) > 0 && a(i-1) <=0)
                        % tindex(k)=i;

                        dy=a(i)-a(i-1);
                        dx=t(i)-t(i-1);
                        m=dy/dx;
                        bq=a(i-1)-m*t(i-1);
                        xx=-bq/m;

                        tindex(k)=i;
                        
                        tz(k)=xx;
                        
                        k=k+1;


                       % tz(k)=t(i);
                       % k=k+1;
                    end
                end
                tindex=tindex(1:k-1);
                tz=tz(1:k-1);


                nt=floor(nt/3);

                f=zeros(nt,1);
                trans=zeros(nt,1);
                phase=zeros(nt,1);

            

                tpi=2*pi;

                k=1;
                for i=1:nnum:nt

                    if((i+4*nnum)>length(tz))
                        break;
                    end

                    ii=tindex(i);
                    jj=tindex(i+4*nnum);
                    delta=mean(diff(tz(i:i+4*nnum)));
                    f(k)=1/delta;
                    
                    bb=max(b(ii:jj));
                    aa=max(a(ii:jj));

                    bbs=std(b(ii:jj));
                    aas=std(a(ii:jj));

                    trans(k)= 0.7*(bb/aa) + 0.3*(bbs/aas);
                    % fprintf(' %d %d %9.8g %9.8g %9.9g %9.8g \n',ii,jj,t(ii),t(jj),delta,f(k))

                    if(ijk==3)
                        
       %                 y1=a(ii:jj);
       %                 y2=b(ii:jj);
              
      %                  PH=acos(dot(y1,y2)/(norm(y1)*norm(y2)));

      %                  phase(k)=-PH;

                        omega=tpi*f(k);
                    
                        [~,~,~,~,~,x3a,~]=sine_lsf_function(a(ii:jj),t(ii:jj),omega);
                        [~,~,~,~,~,x3b,~]=sine_lsf_function(b(ii:jj),t(ii:jj),omega);
                      
                        phase(k)=x3a-x3b;

                        if(phase(k)<-pi)
                            phase(k)=phase(k)+2*pi;
                        end
                        if(phase(k)>pi)
                            phase(k)=phase(k)-2*pi;
                        end                   
                    end    


                    k=k+1;
                end
                f=f(1:k-1);
                trans=trans(1:k-1);

                phase=phase(1:k-1);

                phase=(180/pi)*phase;

         
function[fig_num]=two_dof_frf_apply_random(m,fn,omegan,omegad,damp,Q,fig_num,iu,...
         power_trans_1,power_trans_2,z_power_trans_1,z_power_trans_2,z_power_trans_21)
%
disp(' ');
disp(' Apply random vibration base input? ');
disp(' 1=yes  2=no ');
irand = input(' ');
%
if(irand==1)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    disp(' ');
    disp(' The input PSD must have two columns:  freq(Hz) & PSD(G^2/Hz)');
    disp(' ');
    disp(' Select file input method for input PSD ');
    disp('   1=external ASCII file ');
    disp('   2=file preloaded into Matlab ');
    file_choice = input('');
%
    if(file_choice==1)
        [filename, pathname] = uigetfile('*.*');
        filename = fullfile(pathname, filename);
        fid = fopen(filename,'r');
        THM = fscanf(fid,'%g %g',[2 inf]);
        THM=THM';
    else
        THM = input(' Enter the matrix name:  ');
    end
%
    PSD_in=double(THM(:,2));
    freq_in=double(THM(:,1));
    nin=length(freq_in);
%
    df=0.2;
    df2=df/2;    
%
    clear Q1;
    clear Q21;
    clear Q22;
%    
    Q1 = real_mult_intlog(freq_in,PSD_in,df);
    f1=Q1(:,1);
    a1=Q1(:,2);
    BRMS=sqrt(sum(a1)*df);      
%
    clear ff;
%  
%   Acceleration
%
    Q21 = real_mult_intlog(power_trans_1(:,1),power_trans_1(:,2),df);
    Q22 = real_mult_intlog(power_trans_2(:,1),power_trans_2(:,2),df);
%
    clear ab;
%
    for(kv=1:2)
%
        if(kv==1)
            f2=Q21(:,1);
            a2=Q21(:,2);
        else
            f2=Q22(:,1);
            a2=Q22(:,2);       
        end
%
        ijk=1;
        for(i=1:length(f1))
            for(j=1:length(f2))
                if(abs(f1(i)-f2(j))<df2)
                    ab(kv,ijk)=a1(i)*a2(j);
                    ff(ijk)=(f1(i)+f2(j))/2.;
                    ijk=ijk+1;
                    break;
                end
            end
        end
        RMS(kv)=sqrt(sum(ab(kv,:))*df);       
%
    end
%
    figure(fig_num)
    fig_num=fig_num+1;  
    plot(f1,a1,ff,ab(1,:),ff,ab(2,:));
    out0=sprintf('Base    %5.2g GRMS',BRMS);
    out1=sprintf('Mass 1  %5.2g GRMS',RMS(1));
    out2=sprintf('Mass 2  %5.2g GRMS',RMS(2));
%
    legend(out0,out1,out2); 
    xlabel(' Frequency(Hz) ');
    ylabel(' Accel(G^2/Hz) ');
    title('Acceleration Power Spectral Density');
    grid on;
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
%
%   Relative Displacement
%
    clear Q21;
    clear Q22;
    clear Q23;
    Q21 = real_mult_intlog(z_power_trans_1(:,1),z_power_trans_1(:,2),df);
    Q22 = real_mult_intlog(z_power_trans_2(:,1),z_power_trans_2(:,2),df);
    Q23 = real_mult_intlog(z_power_trans_21(:,1),z_power_trans_21(:,2),df);    
%
    clear ab;
%
    for(kv=1:3)
%
        if(kv==1)
            f2=Q21(:,1);
            a2=Q21(:,2);
        end
        if(kv==2)       
            f2=Q22(:,1);
            a2=Q22(:,2);       
        end
        if(kv==3)       
            f2=Q23(:,1);
            a2=Q23(:,2);       
        end        
%
        ijk=1;
        for(i=1:length(f1))
            for(j=1:length(f2))
                if(abs(f1(i)-f2(j))<df2)
                    ab(kv,ijk)=a1(i)*a2(j);
                    ff(ijk)=(f1(i)+f2(j))/2.;
                    ijk=ijk+1;
                    break;
                end
            end
        end
        RMS(kv)=sqrt(sum(ab(kv,:))*df);       
%
    end
%
    figure(fig_num);
    fig_num=fig_num+1;  
    plot(ff,ab(1,:),ff,ab(2,:),ff,ab(3,:));
    out0=sprintf('Mass 1  %5.2g in RMS',RMS(1));
    out1=sprintf('Mass 2  %5.2g in RMS',RMS(2));
    out2=sprintf('Mass 2-Mass 1  %5.2g in RMS',RMS(3));
%
    legend(out0,out1,out2); 
    xlabel(' Frequency(Hz) ');
    ylabel(' Rel Disp(in^2/Hz) ');
    title('Relative Displacement Power Spectral Density');
    grid on;
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
end
%
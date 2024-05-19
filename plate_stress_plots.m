
%  plate_stress_plots.m  ver 1.0  by Tom Irvine
  
function[fig_num]=plate_stress_plots(fig_num,x,y,t,rd,rv,acc,sxx,syy,txy,vM,Tr,iu)
    

    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,rd);
%    
    if(iu==1)
        out1=sprintf('Displacement at x=%g in  y=%g in',x,y);
        ylabel('Disp (in) ');
    else
        out1=sprintf(' Displacement at x=%g m  y=%g m',x,y);
        ylabel('Disp (m) ');
    end
    title(out1);
    xlabel('Time (sec)');
    grid on;
%
    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,rv);
%
    if(iu==1)
        out1=sprintf('Velocity at x=%g in  y=%g in',x,y);        
        ylabel('Vel (in/sec) ');
    else
        out1=sprintf(' Velocity at x=%g m  y=%g m',x,y);        
        ylabel('Vel (m/sec) ');
    end
    title(out1);    
    xlabel('Time (sec)');
    grid on    
%
%
    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,acc);
%
    if(iu==1)
        out1=sprintf(' Response Acceleration at x=%g in  y=%g in',x,y);
    else
        out1=sprintf(' Response Acceleration at x=%g m  y=%g m',x,y);       
    end
    title(out1);
    ylabel('Accel (G) ');
    xlabel('Time (sec)'); 
    grid on;
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    xlabel3='Time (sec)';
    
    if(iu==1)
        ylabel1='Stress (psi)';
        ylabel2='Stress (psi)';
        ylabel3='Stress (psi)';
    else
        ylabel1='Stress (Pa)';
        ylabel2='Stress (Pa)';
        ylabel3='Stress (Pa)';     
    end
    
    data1=[t sxx];
    data2=[t syy];
    data3=[t txy];
    
    
    if(iu==1)
        t_string1=sprintf(' Sxx Stress at x=%g in  y=%g in',x,y);        
        t_string2=sprintf(' Syy Stress at x=%g in  y=%g in',x,y);      
        t_string3=sprintf(' Txy Stress at x=%g in  y=%g in',x,y);              
    else
        t_string1=sprintf(' Sxx Stress at x=%g m  y=%g m',x,y);        
        t_string2=sprintf(' Syy Stress at x=%g m  y=%g m',x,y);      
        t_string3=sprintf(' Txy Stress at x=%g m  y=%g m',x,y);        
    end
    
    
    [fig_num]=subplots_three_linlin_three_titles_ss(fig_num,xlabel3,ylabel1,ylabel2,ylabel3,data1,data2,data3,t_string1,t_string2,t_string3);
    
    
    xlabel2='Time (sec)';
    
    if(iu==1)
        ylabel1='Stress (psi)';
        ylabel2='Stress (psi)';
    else
        ylabel1='Stress (Pa)';
        ylabel2='Stress (Pa)';
    end
    
    data1=[t vM];
    data2=[t Tr];


    if(iu==1)
        t_string1=sprintf('von Mises Stress at x=%g in  y=%g in',x,y);        
        t_string2=sprintf('Tresca Stress at x=%g in  y=%g in',x,y);      
    else
        t_string1=sprintf('von Mises Stress at x=%g m  y=%g m',x,y);        
        t_string2=sprintf('Tresca Stress at x=%g m  y=%g m',x,y);           
    end    
    
       
    [fig_num]=subplots_two_linlin_two_titles_xzero(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2);    
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

    [rho]=Pearson_coefficient(sxx,syy);
    
    if(rho>=0 && rho<=1)

        figure(fig_num)
        fig_num=fig_num+1;
        plot(sxx,syy,'b.','MarkerSize',1);
        if(iu==1)
            tstring=sprintf('Bending Stress Scatter Plot, Response at x=%g in  y=%g in \n Pearson Coefficient= %6.3g',x,y,rho);
            ylabel('Syy (psi) ');
            xlabel('Sxx (psi) ');
        else
            tstring=sprintf('Bending Stress Scatter Plot, Response at x=%g m  y=%g m \n Pearson Coefficient= %6.3g',x,y,rho);     
            ylabel('Syy (Pa) ');
            xlabel('Sxx (Pa) ');        
        end
        title(tstring);
        grid on;
    
        [xx]=get(gca,'xlim');
        [yy]=get(gca,'ylim');

        Qmax=max([ abs(xx) abs(yy)  ]);

        [Qmax]=ytick_linear_scale(Qmax);

        xlim([-Qmax,Qmax]);
        ylim([-Qmax,Qmax]);

        axis square;    
    
    end
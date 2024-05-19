%
%   Mohrs_circle_3D.m  ver 1.0  by Tom Irvine
%
function[fig_num]=Mohrs_circle_3D(A,B,C,fig_num)
        
        AB_center=(A+B)/2;
        AC_center=(A+C)/2;
        BC_center=(B+C)/2;
        

        AB_radius=abs(A-B)/2;
        AC_radius=abs(A-C)/2;
        BC_radius=abs(B-C)/2;
        
        ang=0:0.01:2*pi; 
        
        ABxp=AB_radius*cos(ang)+AB_center;
        AByp=AB_radius*sin(ang);
        
        ACxp=AC_radius*cos(ang)+AC_center;
        ACyp=AC_radius*sin(ang);
        
        BCxp=BC_radius*cos(ang)+BC_center;
        BCyp=BC_radius*sin(ang);        
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        figure(fig_num);        
        plot(ABxp,AByp,ACxp,ACyp,BCxp,BCyp);        
        title('Mohr''s Circle for 3D Stress');
        xlabel('sigma');
        ylabel('tau');
        grid on;
        
        xx=get(gca,'xlim');
        yy=get(gca,'ylim');
        
        aa=min([xx(1) yy(1)]);
        bb=max([xx(2) yy(2)]);
        
        xlim([ aa,bb]);
        ylim([ aa,bb]);
        
        axis square; 
        
        fig_num=fig_num+1;
        
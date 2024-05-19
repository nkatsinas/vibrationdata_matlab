%
%   Mohrs_circle_2D.m  ver 1.1  by Tom Irvine
%
function[fig_num,center,radius]=Mohrs_circle_2D(s11,s12,s22,fig_num)
        
        radius=sqrt( 0.25*(s11-s22)^2 + s12^2 );
        center=(s11+s22)/2;
        
        q=(s11-s22)/2;
        two_theta=atan2(s12,q);
        
        ang=0:0.01:2*pi; 
        
        xp=radius*cos(ang)+center;
        yp=radius*sin(ang);
        
        ww=[ center+radius*cos(two_theta)  s12   ;  center-radius*cos(two_theta)  -s12  ];
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        figure(fig_num); 
        plot(xp,yp,'b',ww(:,1),ww(:,2),'r');
        title('Mohr''s Circle for 2D Stress');
        xlabel('sigma');
        ylabel('tau');       
        xx=get(gca,'xlim');
        yy=get(gca,'ylim');
        
%%        aa=min([xx(1) yy(1)]);
%%        bb=max([xx(2) yy(2)]);
  

        cc=max(abs([xx(1) xx(2) yy(1) yy(2)]));

        xlim([ -cc,cc]);
        ylim([ -cc,cc]);
        
        axis square; 
        grid on;     
   
        fig_num=fig_num+1;
        
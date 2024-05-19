%
%  vibrationdata_inplane_rectangular_elements_plot_modes.m 
%
function[fig_num]=...
vibrationdata_inplane_rectangular_elements_plot_modes(element_matrix,...
                    nodex,nodey,fig_num,ModeShapes,fn,k,iu,L,W)
%
sz=size(element_matrix);
ne=sz(1);

num_nodes=length(nodex);

mode_num=k;

dmax=min([L W])/20;

maxa=0.;
maxn=0;

%    
%**********************************************   

emax=max(abs(ModeShapes(:,mode_num)));

ModeShapes(:,mode_num)=ModeShapes(:,mode_num)*dmax/emax;

dnodex=nodex;
dnodey=nodey;

rvector=zeros(num_nodes,1);

for i=1:num_nodes
    
   ux=ModeShapes((2*i-1),mode_num);
   uy=ModeShapes((2*i),mode_num);
   
   rvector(i)=norm([ux uy]);
   
   if(rvector(i) > maxa );
       maxa=rvector(i);
   end
    
   dnodex(i)=dnodex(i)+ux; 
   dnodey(i)=dnodey(i)+uy;  
end

k=1;

for i=1:num_nodes

    if(rvector(i)>=0.998*maxa)
        maxn(k)=i;
        k=k+1;
    end
    
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

node1=element_matrix(:,1);
node2=element_matrix(:,2);
node3=element_matrix(:,3);
node4=element_matrix(:,4);
%
h=figure(fig_num);
fig_num=fig_num+1;
%
hold on;
%
for i=1:ne
    x=[ dnodex(node1(i)) dnodex(node2(i)) dnodex(node3(i)) dnodex(node4(i)) dnodex(node1(i))];
    y=[ dnodey(node1(i)) dnodey(node2(i)) dnodey(node3(i)) dnodey(node4(i)) dnodey(node1(i))];

    if(iu==1)
        plot(x,y,'b');    
    else
        xx=1000*x;
        yy=1000*y;
        plot(xx,yy,'b');        
    end
end
hold off;
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    out1=sprintf(' Mode %d   fn=%8.4g Hz ',mode_num,fn(mode_num));
    title(out1);
    grid on;
    
    if(iu==1)
        xlabel('X (in)');
        ylabel('Y (in)');
    else
        xlabel('X (mm)');
        ylabel('Y (mm)');    
    end

    xLimits = get(gca,'XLim');  %# Get the range of the x axis
    yLimits = get(gca,'YLim');  %# Get the range of the y axis
    
    maxx=max(xLimits);
    maxy=max(yLimits);   
  
    minx=min(xLimits);
    miny=min(yLimits);      
    
    
    pup=max([maxx maxy ]);
    plow=min([minx miny ]);
    
    xlim([plow pup]);
    ylim([plow pup]);    
    
    maxL=length(maxn);
    
    if(maxL==1)
        out1=sprintf('\n Maximum response at:');
    else
        out1=sprintf('\n Maximum responses at:');        
    end
    
    disp(out1);
    
    for i=1:maxL
        out2=sprintf(' node=%d  (x=%7.3g, y=%7.3g)',maxn(i),nodex(maxn(i)),nodey(maxn(i)));
        disp(out2);
    end
    disp(' ');
    
%    
    pname=sprintf('ModeShape_%d.png',mode_num);
    out1=sprintf('plot file:   %s',pname);
    disp(out1);
    set(gca,'Fontsize',12);
    print(h,pname,'-dpng','-r300');
%

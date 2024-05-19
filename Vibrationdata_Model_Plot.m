%
%    Vibrationdata_Model_Plot.m  ver 1.2  by Tom Irvine
%
function[iflag]=Vibrationdata_Model_Plot(np)
%

figure(1);

iflag=0;


try
    ncoor=getappdata(0,'ncoor');
    ncoor;
    iflag=1;
    sz=size(ncoor);
    n_nodes=sz(1);
catch
    n_nodes=0;
    warndlg('No existing nodes'); 
    return;
end    
 

try
    point_mass=getappdata(0,'point_mass');
    sz=size(point_mass);
    n_point_masses=sz(1);
catch
    n_point_masses=0;
end


try
    dof_spring_element=getappdata(0,'dof_spring_element');
    sz=size(dof_spring_element);
    n_dof_spring_element=sz(1);
catch
    n_dof_spring_element=0;
end

try
    rigid_link=getappdata(0,'rigid_link');
    sz=size(rigid_link);
    n_rigid_link=sz(1);
catch
    n_rigid_link=0;
end

disp(' plot ');

out1=sprintf(' %d n_nodes   ',n_nodes);
out2=sprintf(' %d n_point_masses  ',n_point_masses);
out4=sprintf(' %d n_dof_spring_element   ',n_dof_spring_element);
out5=sprintf(' %d n_rigid_link  ',n_rigid_link);

disp(out1);
disp(out2);
disp(out4);
disp(out5);


iflag
    
if(iflag==1 && n_nodes>=1)
 
    if(n_nodes>=1)
 
        noden=ncoor(:,1);
        nodex=ncoor(:,2);
        nodey=ncoor(:,3);
        nodez=ncoor(:,4);
        
        figure(1); 
        
        plot3(nodex,nodey,nodez,'.');
        
        nl=1;

        if(nl==1)
 
            for i=1:n_nodes
                string=num2str(noden(i),'%d\n');
                text(nodex(i),nodey(i),nodez(i),string);
            end
 
        end
         
        xlabel('X');
        ylabel('Y');
        zlabel('Z');
        grid on;
 
        
        az=30;
        el=30;
 
        if(np==2)
            az = 0;
            el = 90;
        end  
        if(np==3)
            az = 0;
            el = 180;
        end   
        if(np==4)
            az = 90;
            el = 0;
        end   
    
        view(az, el);
 
        hold on;
       
        
        if(n_point_masses>=1)        
        
            for i=1:n_point_masses
                n=point_mass(i,1);
                plot3(nodex(n),nodey(n),nodez(n),'ro','MarkerSize',16);
            end
            
        end
        
        if(n_dof_spring_element>=1)        
        
            for i=1:n_dof_spring_element
                n=dof_spring_element(i,2);
                m=dof_spring_element(i,3);
                x1=ncoor(n,2);
                x2=ncoor(m,2);
                y1=ncoor(n,3);
                y2=ncoor(m,3);
                z1=ncoor(n,4);
                z2=ncoor(m,4);
                plot3([x1 x2], [y1 y2], [z1 z2],'b','LineWidth',2);
            end
            
        end        
        
        if(n_rigid_link>=1)        
        
            for i=1:n_rigid_link
                n=rigid_link(i,1);
                m=rigid_link(i,2);
                x1=ncoor(n,2);
                x2=ncoor(m,2);
                y1=ncoor(n,3);
                y2=ncoor(m,3);
                z1=ncoor(n,4);
                z2=ncoor(m,4);
                plot3([x1 x2], [y1 y2], [z1 z2],'k','LineWidth',2);
            end
            
        end           
        
        
        hold off;
    end
 
end


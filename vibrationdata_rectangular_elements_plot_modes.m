%
%  vibrationdata_rectangular_elements_plot_modes.m  ver 1.3   by Tom Irvine
%
function[fig_num]=...
vibrationdata_rectangular_elements_plot_modes(nodex,nodey,fig_num,ModeShapes,fn,number_nodes,k,iu,nx,ny)
%
ips=1;
%
if(ips==1)
    clear aaa;
    clear abc;
    abc=zeros(number_nodes,2);
    abc=[ nodex  nodey ];
end  

if(ips==1)
%    
    clear zzr;
    zzr=zeros(number_nodes,1);
    mode_num=k;
%
    maxr=0;

    maxnode=zeros(1,1);
    
    kk=1;


    for i=1:number_nodes
        ndof=3*i-2;
        zzr(i)=ModeShapes(ndof,mode_num);

%        fprintf('*i=%d ndof=%d \n',i,ndof);        
        
        if(abs(zzr(i))>maxr)
            maxr=abs(zzr(i));
            mnode=i; 
%            fprintf('*i=%d ndof=%d %6.3g %6.3g \n',i,ndof,nodex(i),nodey(i));
        end
    end


    
    kk=kk+1;
    
    maxnode(1)=mnode;
    
    for i=1:number_nodes
        ndof=3*i-2;
        zzr(i)=ModeShapes(ndof,mode_num);
        
        yy=(maxr-abs(zzr(i)))/maxr;
        
        yy=abs(yy);
        
        if(i~=mnode && yy<0.004)
            maxnode(kk)=i;
            kk=kk+1;
        end
    end    
    
    maxnode=sort(maxnode);
    
    fprintf('\n Mode %d   fn=%8.4g Hz \n',mode_num,fn(mode_num));
   
    nn=length(maxnode);
    if(nn==1)
        fprintf(' Maximum response at node %d \n',maxnode(1));
    else
        disp(' Maximum response at nodes: ');
        for i=1:nn
            fprintf('          %d \n',maxnode(i));
        end
    end
    fprintf(' Corresponding eigenvector term = %8.4g \n',maxr); 
    
    seedSize=[nx ny];
    
    xNode = nodex;  
    yNode = nodey; 
    zNode = zzr;

%% Reshaping into meshgrid-style 2D arrays
%    xy = [xNode yNode];
    xMesh = reshape(xNode,seedSize);
    yMesh = reshape(yNode,seedSize);
    zMesh = reshape(zNode,seedSize);

    hF = figure(fig_num);  
%   hA = axes('Parent',hF,'NextPlot','add');
    hSurf = surf(xMesh,yMesh,zMesh);  % Plot interpolated surface
%   hS3 = scatter3(xNode,yNode,zNode);  % Plot nodes in scatter plot

    if(iu==1)
        xlabel('X (in)');
        ylabel('Y (in)');
    else
        xlabel('X (m)');
        ylabel('Y (m)');        
    end
%
    out1=sprintf(' Mode %d   fn=%8.4g Hz ',mode_num,fn(mode_num));
    title(out1);
    grid on;
%    

    zzz=zeros(nx,ny);

    k=1;
    for i=1:ny
        for j=1:nx
            zzz(j,i)=zzr(k);
            k=k+1;
        end
    end

    a=-37.5+90;
    view([a 30])
    fig_num=fig_num+1;
    hF = figure(fig_num);  
    % contour(xMesh,yMesh,zMesh,30);
    % colorbar;
    contour(xMesh,yMesh,zMesh,11,"ShowText",true,"LabelFormat","%3.2g");
    out1=sprintf(' Mode %d   fn=%8.4g Hz ',mode_num,fn(mode_num));
    title(out1); 
    if(iu==1)
        xlabel('X (in)');
        ylabel('Y (in)');
    else
        xlabel('X (m)');
        ylabel('Y (m)');        
    end
    daspect([1 1 1]);

    fig_num=fig_num+1;
    hF = figure(fig_num);  
    % contour(xMesh,yMesh,zMesh,30);
    % colorbar;
    contourf(xMesh,yMesh,zMesh,20);
    out1=sprintf(' Mode %d   fn=%8.4g Hz ',mode_num,fn(mode_num));
    title(out1); 
    if(iu==1)
        xlabel('X (in)');
        ylabel('Y (in)');
    else
        xlabel('X (m)');
        ylabel('Y (m)');        
    end
    daspect([1 1 1]);
    fig_num=fig_num+1;
%
end
for i=1:nmach
    
    x=fpl_mach(i);
    
    if(x<=1.2)
        CCC=0.8;
    else
        if(x>1.2 && x <2.5)
        
            x1=1.2;
            y1=0.8;
            x2=2.5;
            y2=0.6;
            xnew=x;
            
            [CCC]=linear_interpolation_function(x1,y1,x2,y2,xnew);
            
        else
            
            CCC=0.6;
            
        end
        
        
    end
    
    
    CCC=str2num(get(handles.edit_convc,'String'));
    
    Uc(i)=CCC*fs_velox(i);    
end
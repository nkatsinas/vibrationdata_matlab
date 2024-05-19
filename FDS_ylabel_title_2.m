
% FDS_ylabel_title_2.m  ver 1.0  by Tom Irvine


function[y_label,t_string]=FDS_ylabel_title_2(bex,ib,im,iu)

       if(im==1)
            t_string=sprintf('Total Acceleration FDS b=%g',bex(ib));

                    if(iu==1 || iu==2)
                        y_label=sprintf('Relative Damage (G^{%g})',bex(ib));
                    else
                        y_label=sprintf('Relative Damage (m/sec^2)^{%g}',bex(ib));   
                    end
            
        end
        if(im==2)
            t_string=sprintf('Total Pseudo Velocity FDS b=%g',bex(ib));
            
                    if(iu==1)
                        y_label=sprintf('Relative Damage (in/sec)^{%g}',bex(ib));
                    else
                        y_label=sprintf('Relative Damage (m/sec)^{%g}',bex(ib));
                    end
            
        end 
        if(im==3)
            t_string=sprintf('Total Relative Displacement FDS b=%g',bex(ib));
            
                    if(iu==1)
                        y_label=sprintf('Relative Damage (in^{%g})',bex(ib));
                    else
                        y_label=sprintf('Relative Damage (mm^{%g})',bex(ib));    
                    end

        end 
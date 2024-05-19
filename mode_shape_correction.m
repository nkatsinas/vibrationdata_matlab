%
%  mode_shape_correction.m  ver 1.0  September 5, 2012
%
function[ModeShapes]=mode_shape_correction(dof,pp,con,ModeShapes)
%
ijk=1;
%
%    ncc=dof-pp;
%
    sz=size(ModeShapes);
    ncc=sz(2);
%
    newModes=zeros(dof,ncc);
%
    for i=1:dof
%
        iflag=0;
        for ij=1:pp
             k=con(ij);
             if(k==i)
                 iflag=9;
                 break;
             end
        end
%        
       if(iflag==0)
          newModes(i,1:ncc)=ModeShapes(ijk,1:ncc);
          ijk=ijk+1;
       else
          newModes(i,1:ncc)=0;           
       end
%    
    end
%
    clear ModeShapes;
    ModeShapes=newModes;    
end 
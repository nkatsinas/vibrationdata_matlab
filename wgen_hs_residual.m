

% wgen_hs_residual.m  ver 1.0  by Tom Irvine

function[x1r,x2r,x3r,x4r,residual]=wgen_hs_residual(x1r,x2r,x3r,x4r,ffmin,tp,num2,ie,t)

        if(x2r(ie)<ffmin*tp)
            x2r(ie)=ffmin*tp;
            x1r(ie)=1.0e-20;
            x3r(ie)=3;
            x4r(ie)=0;
        end
%
        residual=zeros(num2,1);

        for i=1:num2
%			
            tt=t(i);
%
            t1=x4r(ie) + t(1);
            t2=t1 + tp*x3r(ie)/(2.*x2r(ie));
%
            if( tt>= t1 && tt <= t2)
%				
                arg=x2r(ie)*(tt-t1);  
                y=x1r(ie)*sin(arg/double(x3r(ie)))*sin(arg);
%                rsum(i)=rsum(i)+y;
%
                residual(i)=residual(i)-y;
            end
        end 
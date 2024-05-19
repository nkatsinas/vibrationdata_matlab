%
%   linear_interpolation.m  ver 1.0  September 22, 2012
%
%   This method is more reliable than Matlab's interp1
%
function[xi,yi]=linear_interpolation(tim,amp,dt)
%
        n=length(tim);
        tmx=max(tim);
        tmi=min(tim);
%
%    This method assumes that the sample rate is already uniform ;
%
        js=1;
        nnn=fix((tmx-tmi)/dt);
        x = tim; 
        y = amp;    
        xi=zeros(nnn,1);
        yi=zeros(nnn,1);
        for i=1:nnn
            xi(i)=(i-1)*dt+tmi;
            yi(i)=0.;
            for j=js:(n-1)
                if(xi(i)==x(j))
                    yi(i)=y(j);
                    js=j;
                    break;
                end
                if(xi(i)==x(j+1))
                    yi(i)=y(j+1);
                    js=j;
                    break;
                end         
                if(xi(i)>x(j) && xi(i)<x(j+1))
                    d=xi(i)-x(j);
                    ddt=d/(x(j+1)-x(j));
                    c2=ddt;
                    c1=1.-c2;
                    yi(i)=c1*y(j)+c2*y(j+1);
                    js=j;
                    break;
                end                
%               
            end
        end
%
        disp(' Linear interpolation completed.')     
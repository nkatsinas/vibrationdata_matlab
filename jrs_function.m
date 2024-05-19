for r=1:nmodes
    m=r;
    for s=1:nmodes
        n=s;
        for i=1:num
            for j=1:num
                for k=1:num
                    for p=1:num
                        jrs2(r,s)=jrs2(r,s)+phi(Amn,xx(i),yy(j),m,n,a,b)*phi(Amn,xx(k),yy(p),m,n,a,b);
                    end
                end
            end
        end

    end
end
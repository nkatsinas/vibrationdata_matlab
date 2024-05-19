               
%  octave_test.m  ver 1.0  by Tom Irvine

function[ioct_flag,itype]=octave_test(ggg)

    ioct_flag=0;
    itype=0;

    num=length(ggg(:,1));

    ratio=zeros(num-1,1);

    for j=2:num
        ratio(j)=log2(ggg(j,1)/ggg(j-1,1));
    end    

    rm=mean(ratio);

    if(rm>0.9 && rm<1.1)
        ioct_flag=1;
        itype=1;
    end
    if(rm>0.29 && rm<0.36)
        ioct_flag=1;
        itype=3;
    end

    % fprintf(' octave test: rm=%6.3g  ioct_flag=%d  itype=%d \n',rm,ioct_flag,itype);
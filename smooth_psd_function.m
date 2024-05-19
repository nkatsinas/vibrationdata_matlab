
%   smooth_psd_function.m  ver 1.0  by Tom Irvine

function[fs,as]=smooth_psd_function(f,a)

[s,~] = calculate_PSD_slopes_no(f,a);

fs(1)=f(1);
as(1)=a(1);

df=abs(diff(s));

limit=0.05;

j=2;

for i=1:length(df)

    if( df(i)>limit)
        fs(end+1)=f(j);
        as(end+1)=a(j);
    end    

    j=j+1;

end    

fs(end+1)=f(end);
as(end+1)=a(end);

df=diff(fs);
L=length(df);
j=length(fs);

for i=L:-1:1
    if(df(i)<=2)
        fs(j-1)=-999;
        as(j)=max([as(j) as(j-1)]);
    end    
    j=j-1;
end

for i=length(fs):-1:1
    if(fs(i)<0)
        fs(i)=[];
        as(i)=[];
    end    
end    

fs=fix_size(fs);
as=fix_size(as);
sz=size(sk_array3);
%
disp(' input number ');
n=input(' ');
%
clear a;
clear b;
clear d;
%
j=1;
for i=1:sz(1)
    if( abs(n-sk_array3(i,3))<0.01)
        out1=sprintf('%8.4g  %8.4g  %8.4g  %8.4g',sk_array3(i,1),sk_array3(i,2),log10(sk_array3(i,3)),log10(sk_array3(i,4)));
        disp(out1); 
        a(j)=sk_array3(i,1);
        b(j)=sk_array3(i,2);
        d(j)=log10(sk_array3(i,4));
        j=j+1;
    end
end
%
[p, s] = polyfit(d, a, 2);
p
[p, s] = polyfit(d, b, 2);
p
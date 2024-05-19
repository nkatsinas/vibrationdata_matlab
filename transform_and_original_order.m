%
%  transform_and_original_order.m  ver 1.0  by Tom Irvine
%
function[d,v,acc,d_save,v_save,a_save]=...
        transform_and_original_order(d,v,a,ddisp,dvelox,forig,T1,T2,nt,num,ngw)

%
d_save=d;
v_save=v;
a_save=a;
%
%    Transformation back to xd xf
%
clear dT;
clear vT;
clear accT;
%
a=fix_size(a);
v=fix_size(v);
d=fix_size(d);
%
ddisp=fix_size(ddisp);
dvelox=fix_size(dvelox);
forig=fix_size(forig);
%


dT=T1*ddisp' + T2*d';
vT=T1*dvelox' + T2*v';
accT=T1*forig' + T2*a';
%
%  Put in original order
%
clear ZdT;
clear ZvT;
clear ZaccT;
%
ZdT=[ ddisp  dT' ];
ZvT=[ dvelox  vT' ];
ZaccT=[ forig  accT' ];
%
clear d;   
clear v;
clear a;
clear acc;
d=zeros(nt,num);
v=zeros(nt,num);
acc=zeros(nt,num);
%
for i=1:num
   for j=1:nt
        d(j,ngw(i))=  (ZdT(j,i));        
        v(j,ngw(i))=  (ZvT(j,i));     
      acc(j,ngw(i))=(ZaccT(j,i));
   end
end
 
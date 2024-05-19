
%  stress_tensor_3D.m  ver 1.0  by Tom Irvine

function[pstress]=stress_tensor_3D(sx,sy,sz,txy,txz,tyz)

ss=size(sx);

NT=ss(1);

pstress=zeros(NT,3);
    
for i=1:NT
        
    tensor=[sx(i) txy(i) txz(i); txy(i) sy(i) tyz(i); txz(i) tyz(i) sz(i)];
        
    e = eig(tensor);
    
    pstress(i,:)=e';
        
end  
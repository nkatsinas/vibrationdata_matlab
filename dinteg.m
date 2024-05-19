clear apsd

sz=size(displacement_psd);


apsd=zeros(sz(1),2);

apsd(:,1)=displacement_psd(:,1);

for i=1:sz(1)
    omega=2*pi*displacement_psd(i,1);
    apsd(i,2)=displacement_psd(i,2)*omega^4/386^2
end    
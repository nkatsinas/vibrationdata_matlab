%
%  trans_mult.m  ver 1.0  by Tom Irvine
%
%  This function multiplies a PSD by a transmissibility function
%
% szz =1  for display size on
%     =2  for display size off 

function[ff,ab,rms]=trans_mult(szz,THM1,THM2,nni)


if(THM1(1,1)<=1.0e-12)
    THM1(1,:)=[];
end
if(THM2(1,1)<=1.0e-12)
    THM2(1,:)=[];
end
%

yone=double(THM1(:,2));
xone=double(THM1(:,1));
sz1=size(THM1);
if(szz==1)
    out1=sprintf(' size = %d x %d \n',sz1(1),sz1(2));
    disp(out1);
end

ytwo=double(THM2(:,2));
xtwo=double(THM2(:,1));
sz2=size(THM2);

if(szz==1)
    out1=sprintf(' size = %d x %d \n',sz2(1),sz2(2));
    disp(out1);
end

%
if(sz2(1)~=sz1(1) && szz==1)
    disp(' ');
    disp(' size difference ');
    disp(' ');
end
%
df=0.5;
%
iflag=1;

if(sz1(1)==sz2(1))
  
  if( abs(xone(1)-xtwo(1))<0.01)  
    if( abs(xone(sz1(1))-xtwo(sz2(1)))<0.01)   
        iflag=0;
    end
  end
  
end

if(iflag==0)
  Q1=THM1;
  Q2=THM2;
else
  if(nni==1)
    Q1 = real_mult_intlin(xone,yone,df);
    Q2 = real_mult_intlin(xtwo,ytwo,df);      
  else    
    Q1 = real_mult_intlog(xone,yone,df);
    Q2 = real_mult_intlog(xtwo,ytwo,df);
  end  
end


f1=Q1(:,1);
a1=Q1(:,2);

f2=Q2(:,1);
a2=Q2(:,2);
%
df2=df/2;
%
ijk=1;
for i=1:length(f1)
    for j=1:length(f2)
        if(abs(f1(i)-f2(j))<df2)
            ab(ijk)=a1(i)*a2(j);
            ff(ijk)=(f1(i)+f2(j))/2.;
            ijk=ijk+1;
            break;
        end
    end
end    
%
rms=sqrt(df*sum(ab));

ff=fix_size(ff);
ab=fix_size(ab);

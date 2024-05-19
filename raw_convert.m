
[num,txt,raw]  = xlsread('Book_S.csv')

sz=size(raw);

for i=1:sz(2)
    disp(' ');
        
    if(raw{2,i}~=47)
        aaa=strrep(raw{4,i},'/','-');
        aaa=strrep(aaa,'2002','2');
        a=sprintf('PSD  Fig %d  %s  Zone %s  %s \n%s %s %s ',raw{2,i},raw{3,i},aaa,raw{5,i},raw{6,i},raw{7,i},raw{8,i});
    else
        aaa=7;
        a=sprintf('PSD  Fig %d  %s  Zone %d  %s \n%s %s %s ',raw{2,i},raw{3,i},aaa,raw{5,i},raw{6,i},raw{7,i},raw{8,i}); 
    end
    
%%    disp(a);

    title{i}=a;

end
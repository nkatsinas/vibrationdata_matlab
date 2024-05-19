
%  read_ascii_or_csv.m  ver 1.0   by Tom Irvine

function[THM]=read_ascii_or_csv(filename)

fid = fopen(filename,'r');
 
%%%%%%%%%%%%%%%%
 
sarray = textscan(fid,'%s','Delimiter','\n');
irow=cellfun(@length,sarray);
 
frewind(fid);

THM=zeros(irow,2);

for i=1:irow

     A = fgets(fid);
     A=strrep(A, ',', ' ');
     strs = strsplit(A,' ');       
                 
     a1=str2num(char(strs(1)));
     a2=str2num(char(strs(2))); 
     
     THM(i,:)=[a1 a2];

end

fclose(fid);

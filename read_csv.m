disp(' ');
disp(' * * * * ');
disp(' ');

filename='xxx.csv';

% M = csvread(filename)


fid = fopen(filename,'r');
sarray = textscan(fid,'%s','Delimiter','\n');
fclose(fid);


N = importdata(filename);

sz=size(N);

irow=sz(1);
icol=sz(2);


ss={'a' 'b' 'c' 'd' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z'
    'A' 'B' 'C' 'D' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z' };

nnn=max(size(ss));

amax=0;

for i=1:nnn
%    
    a= strfind(sarray{:}, ss{i});
    a= find(not(cellfun('isempty',a)));
    if(max(a)>amax)
        amax=max(a);
    end
%
end




ihead=amax;

out1=sprintf('\n Number of header lines = %d \n',ihead);
disp(out1);


istart=ihead+1;

t=zeros(irow,1);

for i=istart:irow
   
    t(i)=N(i,1);
    
end


for j=2:icol
    
    k=1;
    
    clear v;

    for i=istart:irow
      
        if(~isnan( N(i,j)))
            v(k,1)=t(i);
            v(k,2)=N(i,j);
            k=k+1;
        end    
        
    end
    
    output_name=sprintf('data_%d',(j-1));
    
    assignin('base', output_name, v);
    
end    

figure(1)
plot(v(:,1),v(:,2))
xlabel('Time (sec)');



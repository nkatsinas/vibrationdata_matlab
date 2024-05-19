

% find_header_lines.m  ver 1.0  by Tom Irvine


function[ihead]=find_header_lines(sarray)

amax=0;

ss={'a' 'b' 'c' 'd' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z'};
nnn=max(size(ss));

for i=1:nnn
%    
    a= strfind(sarray{:}, ss{i});
    a= find(not(cellfun('isempty',a)));
    if(max(a)>amax)
        amax=max(a);
    end
%
end

ss={'A' 'B' 'C' 'D' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z' };
nnn=max(size(ss));

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
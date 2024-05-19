    

%  nastran_export_begin.m  ver 1.0  by Tom Irvine


function[fid]=nastran_export_begin(num,type,fid)

    fprintf(fid,'ID  \n');

    if(type==2)
        
        fprintf(fid,'SOL SEMODES \n');
        fprintf(fid,'CEND \n');
        fprintf(fid,' TITLE = NORMAL MODES \n');
    
    else

        fprintf(fid,'SOL SEMTRAN \n');
        fprintf(fid,'TIME 10000 \n');
        fprintf(fid,'CEND \n');
        fprintf(fid,' TITLE = Transient \n');
               
    end
    
    fprintf(fid,'BEGIN BULK \n');
%    fprintf(fid,'TABLED2        9      0.                                                +    \n');    
    out=sprintf('TABLED2        %d      0.                                                +    \n',num);
    fprintf(fid,out);  
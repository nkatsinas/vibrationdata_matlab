

%  nastran_export_end.m  ver 1.0  by Tom Irvine


function[]=nastran_export_end(fid,iflag)

    if(iflag<2)
        fprintf(fid,'+,ENDT\n');
        fprintf(fid,'ENDDATA');
    end
    if(iflag==2)
        fprintf(fid,',ENDT\n');
        fprintf(fid,'ENDDATA');
    end
    
   fclose(fid);  
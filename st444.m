

sz=size(Sarkani_table);

v=Sarkani_table;

i=1;
out1=sprintf('st=[ %g  %g  %g;',v(i,1),v(i,2),v(i,3));
disp(out1);
    
for i=2:(sz(1)-1);
    
    out1=sprintf(' %g  %g  %g;',v(i,1),v(i,2),v(i,3));
    disp(out1);
end

i=sz(1);
out1=sprintf('%g  %g  %g];',v(i,1),v(i,2),v(i,3));
disp(out1);

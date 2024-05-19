  function range = xlsrange(start_loc, array_size)
     % inputs are [row, column] and [height, width]
     start_col = start_loc(2)-1;
     start_row = start_loc(1);
     end_col = start_col + array_size(2)-1;
     end_row = start_row + array_size(1)-1;
     symbols = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';


     start_col_out = '';
     while ( start_col ~= -1 ) % converting to base-26 with only alpha characters
         remainder = mod(start_col, 26);  
         start_col = floor(start_col / 26)-1;  
         start_col_out(end+1) = symbols(remainder+1);
     end
     start_col_out = fliplr(start_col_out);

     end_col_out = '';
     while ( end_col ~= -1 ) % converting to base-26 with only alpha characters
         remainder = mod(end_col, 26);  
         end_col = floor(end_col / 26)-1;  
         end_col_out(end+1) = symbols(remainder+1);
     end
     end_col_out = fliplr(end_col_out);

     range = sprintf([start_col_out '%d:' end_col_out '%d'],start_row, end_row);
  end
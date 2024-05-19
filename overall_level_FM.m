
function[GRMS]=overall_level_FM(a)

sz=size(a);

num_rows=sz(1);

ms=0;

for i=1:num_rows
  ms=ms+a(i,2)^2;  
end

GRMS=sqrt(ms);
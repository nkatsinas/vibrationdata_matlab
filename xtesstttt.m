
LastName = ["Sanchez";"Johnson";"Zhang";"Diaz";"Brown"];
Age = [38;43;38;40;49];
Smoker = [true;false;true;false;true];

A = table(LastName,Age,Smoker)

filename = 'testdata.xlsx';
writetable(A,filename);
winopen(filename);
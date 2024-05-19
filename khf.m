fn=200;
T=60;
b=4
sigma=11.3



n = b
df = 1;
for i = n : -2 : 1
    df = df * i;
end
str = ['Double Factorial of ' num2str(n) ' is ' num2str(df)];
disp(str)




sqrt(pi/2)*fn*T*df*sigma^b


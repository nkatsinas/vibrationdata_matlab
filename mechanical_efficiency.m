
eta=0.005;

for i=3:3:21
    delta=-(i)/10;
    a=10^delta;
    gamma=eta*a/(1-a);
    fprintf(' %g %3.2g  %6.2e   %6.4g\n',-i,gamma,gamma,sqrt(gamma*550000^2));
end

    
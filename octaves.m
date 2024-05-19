%
%  octaves.m    version 2.3  by Tom Irvine
%
function[fc,imax]=octaves(ioct)
%
clear fc
clear length
%

if(ioct==1)  % full octave
    fc(1)=2.; 
    fc(2)=4.;
    fc(3)=8.;
    fc(4)=16.;
    fc(5)=31.5;
    fc(6)=63.;
    fc(7)=125.;
    fc(8)=250.;
    fc(9)=500.;
    fc(10)=1000.;
    fc(11)=2000.;
    fc(12)=4000.;
    fc(13)=8000.;
    fc(14)=16000.;
end

if(ioct==2)  % 1/3 octave

    fc(1)=2.5;
    fc(2)=3.15;
    fc(3)=4.;
    fc(4)=5.;
    fc(5)=6.3;
    fc(6)=8.;
    fc(7)=10.;
    fc(8)=12.5;
    fc(9)=16.;
    fc(10)=20.;
    fc(11)=25.;
    fc(12)=31.5;
    fc(13)=40.;
    fc(14)=50.;
    fc(15)=63.;
    fc(16)=80.;
    fc(17)=100.;
    fc(18)=125.;
    fc(19)=160.;
    fc(20)=200.;
    fc(21)=250.;
    fc(22)=315.;
    fc(23)=400.;
    fc(24)=500.;
    fc(25)=630.;
    fc(26)=800.;
    fc(27)=1000.;
    fc(28)=1250.;
    fc(29)=1600.;
    fc(30)=2000.;
    fc(31)=2500.;
    fc(32)=3150.;
    fc(33)=4000.;
    fc(34)=5000.;
    fc(35)=6300.;
    fc(36)=8000.;
    fc(37)=10000.;
    fc(38)=12500.;
    fc(39)=16000.;
    fc(40)=20000.;

end

if(ioct==3)  % 1/6 octave

    fc(1)=2.5;
    fc(3)=3.15;
    fc(5)=4.;
    fc(7)=5.;
    fc(9)=6.3;
    fc(11)=8.;
    fc(13)=10.;
    fc(15)=12.5;
    fc(17)=16.;
    fc(19)=20.;
    fc(21)=25.;
    fc(23)=31.5;
    fc(25)=40.;
    fc(27)=50.;
    fc(29)=63.;
    fc(31)=80.;
    fc(33)=100.;
    fc(35)=125.;
    fc(37)=160.;
    fc(39)=200.;
    fc(41)=250.;
    fc(43)=315.;
    fc(45)=400.;
    fc(47)=500.;
    fc(49)=630.;
    fc(51)=800.;
    fc(53)=1000.;
    fc(55)=1250.;
    fc(57)=1600.;
    fc(59)=2000.;
    fc(61)=2500.;
    fc(63)=3150.;
    fc(65)=4000.;
    fc(67)=5000.;
    fc(69)=6300.;
    fc(71)=8000.;
    fc(73)=10000.;
    fc(75)=12500.;
    fc(77)=16000.;
    fc(79)=20000.;

    for i=2:2:78
        fc(i)=sqrt(fc(i-1)*fc(i+1) );
    end

end

if(ioct==4 || ioct==5 || ioct==6)  % 1/12 octave

    fc(1)=1;
    fc(end+1)=1.12;
    fc(end+1)=1.18; 
    fc(end+1)=1.25;
    fc(end+1)=1.33;
    fc(end+1)=1.41;
    fc(end+1)=1.50;
    fc(end+1)=1.59;
    fc(end+1)=1.69;
    fc(end+1)=1.79;
    fc(end+1)=1.89;
    fc(end+1)=2.0;
    fc(end+1)=2.12;
    fc(end+1)=2.24;
    fc(end+1)=2.37;
    fc(end+1)=2.5;
    fc(end+1)=2.65;
    fc(end+1)=2.81;
    fc(end+1)=2.98;
    fc(end+1)=3.15;
    fc(end+1)=3.34;
    fc(end+1)=3.55;
    fc(end+1)=3.77;          
    fc(end+1)=4.0;
    fc(end+1)=4.23;
    fc(end+1)=4.47;
    fc(end+1)=4.73;
    fc(end+1)=5.0;    
    fc(end+1)=5.3; 
    fc(end+1)=5.61;  
    fc(end+1)=5.94;
    fc(end+1)=6.3;
    fc(end+1)=6.69;
    fc(end+1)=7.1;
    fc(end+1)=7.54;
    fc(end+1)=8.0;
    fc(end+1)=8.46;
    fc(end+1)=8.94;
    fc(end+1)=9.46;   
    fc(end+1)=10.;
    fc(end+1)=10.57;
    fc(end+1)=11.2;
    fc(end+1)=11.8;
    fc(end+1)=12.5;
    fc(end+1)=13.3;
    fc(end+1)=14.1;
    fc(end+1)=15.0;
    fc(end+1)=15.9;
    fc(end+1)=16.9;
    fc(end+1)=17.9;
    fc(end+1)=18.9;
    fc(end+1)=20.;
    fc(end+1)=21.2;
    fc(end+1)=22.4;
    fc(end+1)=23.7;
    fc(end+1)=25.;
    fc(end+1)=26.5;
    fc(end+1)=28.1;
    fc(end+1)=29.8;
    fc(end+1)=31.5;
    fc(end+1)=33.4;
    fc(end+1)=35.5;
    fc(end+1)=37.7;
    fc(end+1)=40.;  
    fc(end+1)=42.3;
    fc(end+1)=44.7;
    fc(end+1)=47.3;
    fc(end+1)=50.;
    fc(end+1)=53.;
    fc(end+1)=56.1;
    fc(end+1)=59.4;   
    fc(end+1)=63.; 
    fc(end+1)=66.9;
    fc(end+1)=71.;
    fc(end+1)=75.4;
    fc(end+1)=80.; 
    fc(end+1)=84.6;
    fc(end+1)=89.4;
    fc(end+1)=94.6;
    fc(end+1)=100.;
    fc(end+1)=105.7;
    fc(end+1)=111.8;
    fc(end+1)=118.2;
    fc(end+1)=125.;
    fc(end+1)=132.9;
    fc(end+1)=141.4;
    fc(end+1)=150.4;
    fc(end+1)=160.;
    fc(end+1)=169.2;
    fc(end+1)=178.9; 
    fc(end+1)=189.2;
    fc(end+1)=200.; 
    fc(end+1)=211.5; 
    fc(end+1)=223.6; 
    fc(end+1)=236.4; 
    fc(end+1)=250.; 
    fc(end+1)=264.9;
    fc(end+1)=280.6;
    fc(end+1)=297.3;  
    fc(end+1)=315.;  
    fc(end+1)=334.4;  
    fc(end+1)=355.;  
    fc(end+1)=376.8; 
    fc(end+1)=400.;
    fc(end+1)=422.9;
    fc(end+1)=447.2;   
    fc(end+1)=472.9; 
    fc(end+1)=500.;
    fc(end+1)=529.8;  
    fc(end+1)=561.3;   
    fc(end+1)=594.7;
    fc(end+1)=630.;
    fc(end+1)=668.8;
    fc(end+1)=709.9;
    fc(end+1)=753.6;
    fc(end+1)=800.;
    fc(end+1)=845.9;
    fc(end+1)=894.4;
    fc(end+1)=945.7;
    fc(end+1)=1000.;
    fc(end+1)=1057.4;
    fc(end+1)=1118.;
    fc(end+1)=1182.2;
    fc(end+1)=1250.;
    fc(end+1)=1329.6;
    fc(end+1)=1414.2;
    fc(end+1)=1504.2;
    fc(end+1)=1600.;
    fc(end+1)=1691.8;
    fc(end+1)=1788.9;
    fc(end+1)=1891.5;
    fc(end+1)=2000.;
    fc(end+1)=2120.;
    fc(end+1)=2240.;
    fc(end+1)=2370.;
    fc(end+1)=2500.;
    fc(end+1)=2650.;
    fc(end+1)=2810.;
    fc(end+1)=2980.;
    fc(end+1)=3150.;
    fc(end+1)=3340.;
    fc(end+1)=3550.;
    fc(end+1)=3770.;
    fc(end+1)=4000.;

end   

if(ioct==5 || ioct==6)  % 1/24 octave

    fa=fc;
    clear fc;

    n=length(fa);

    fa(end+1)=fa(end)*2^(1/12);

    fc=zeros(2*n,1);           

    for i=1:n
        fc(2*i-1)=fa(i);
        fc(2*i)=sqrt(fa(i)*fa(i+1));
    end   

end

if(ioct==6)  % 1/48 octave

    fa=fc;
    clear fc;

    n=length(fa);

    fa(end+1)=fa(end)*2^(1/24);

    fc=zeros(2*n,1);

    for i=1:n
        fc(2*i-1)=fa(i);
        fc(2*i)=sqrt(fa(i)*fa(i+1));
    end   

end           

imax=length(fc);
fc=fix_size(fc);



% MW_points.m  ver 1.0  by Tom Irvine

function[MWp,fc,ac]=MW_points()

MWp=[100 135
	111	144
	122	160
	135	179
	144	203
	159	248
	174	300
	191	376
	211	463
	236	576
	271	774
	306	984
	343	1238
	397	1540
	445	1875
	525	2333
	598	2603
	645	2705
	691	2719
	728	2680
	771	2560
	846	2283
	924	1981
	1052	1574
	1137	1325
	1242	1122
	1349	922
	1488	749
	1609	636
	1712	546
	1812	479
	1969	397
	2000	380];


    ff=MWp(:,1);
    aa=MWp(:,2);
    Nff=length(ff);

	fc(1)=100.;
	fc(2)=125.;
	fc(3)=160.;
	fc(4)=200.;
	fc(5)=250.;
	fc(6)=315.;
	fc(7)=400.;
	fc(8)=500.;
	fc(9)=630.;
	fc(10)=800.;
	fc(11)=1000.;
	fc(12)=1250.;
	fc(13)=1600.;
	fc(14)=2000.;
    
    fc=fix_size(fc);

    Nfc=length(fc);
    
    ac=zeros(Nfc,1);
    
    for i=1:Nfc
                
        for j=1:Nff-1
        
            if(fc(i)==ff(j))
               ac(i)=aa(j);
               break;
            end
            if(fc(i)==ff(j+1))
               ac(i)=aa(j+1);
               break;
            end       
            if(fc(i)>ff(j) && fc(i)<ff(j+1))
               n=log(aa(j+1)/aa(j))/log(ff(j+1)/ff(j)); 
               ac(i)=aa(j)*(fc(i)/ff(j))^n;               
               break;            
            end
        end
        
    end